Content-Type: multipart/mixed; boundary="===============4801849077757836276=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/4] scan: Parse P2P IEs according to frame type
Date: Thu, 21 Nov 2019 21:15:56 +0100
Message-ID: <20191121201557.16506-3-andrew.zaborowski@intel.com>
In-Reply-To: <20191121201557.16506-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4801849077757836276==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Save the source frame type in struct scan_bss as it may affect how some
of the data in the struct will be parsed.  Also replace the P2P IE
payload data in that struct with a union containing pre-parsed p2p
attributes corresponding to the frame type.

This means users don't have to call the parsers in p2putil.c on that
data, which wouldn't have worked anyway because those parsers assume
input is the raw IE sequence rather than just the "payload".
---
 src/scan.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 src/scan.h |  17 +++++++-
 2 files changed, 128 insertions(+), 12 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index c5dbbb1c..ed4b1717 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -46,6 +46,7 @@
 #include "src/nl80211cmd.h"
 #include "src/nl80211util.h"
 #include "src/util.h"
+#include "src/p2putil.h"
 #include "src/scan.h"
 =

 #define SCAN_MAX_INTERVAL 320
@@ -1054,6 +1055,65 @@ static bool scan_parse_bss_information_elements(stru=
ct scan_bss *bss,
 		}
 	}
 =

+	bss->wsc =3D ie_tlv_extract_wsc_payload(data, len, &bss->wsc_size);
+
+	switch (bss->source_frame) {
+	case SCAN_BSS_PROBE_RESP:
+		bss->p2p_probe_resp_info =3D l_new(struct p2p_probe_resp, 1);
+
+		if (p2p_parse_probe_resp(data, len, bss->p2p_probe_resp_info) =3D=3D
+				0)
+			break;
+
+		l_free(bss->p2p_probe_resp_info);
+		bss->p2p_probe_resp_info =3D NULL;
+		break;
+	case SCAN_BSS_PROBE_REQ:
+		bss->p2p_probe_req_info =3D l_new(struct p2p_probe_req, 1);
+
+		if (p2p_parse_probe_req(data, len, bss->p2p_probe_req_info) =3D=3D
+				0)
+			break;
+
+		l_free(bss->p2p_probe_req_info);
+		bss->p2p_probe_req_info =3D NULL;
+		break;
+	case SCAN_BSS_BEACON:
+	{
+		/*
+		 * Beacon and Probe Response P2P IE subelement formats are
+		 * mutually incompatible and can help us distinguish one frame
+		 * subtype from the other if the driver is not exposing enough
+		 * information.  As a result of trusting the frame contents on
+		 * this, no critical code should depend on the
+		 * bss->source_frame information being right.
+		 */
+		struct p2p_beacon info;
+		int r;
+
+		r =3D p2p_parse_beacon(data, len, &info);
+		if (r =3D=3D 0) {
+			bss->p2p_beacon_info =3D l_memdup(&info, sizeof(info));
+			break;
+		}
+
+		if (r =3D=3D -ENOENT)
+			break;
+
+		bss->p2p_probe_resp_info =3D l_new(struct p2p_probe_resp, 1);
+
+		if (p2p_parse_probe_resp(data, len, bss->p2p_probe_resp_info) =3D=3D
+				0) {
+			bss->source_frame =3D SCAN_BSS_PROBE_RESP;
+			break;
+		}
+
+		l_free(bss->p2p_probe_resp_info);
+		bss->p2p_probe_resp_info =3D NULL;
+		break;
+	}
+	}
+
 	return have_ssid;
 }
 =

@@ -1062,9 +1122,14 @@ static struct scan_bss *scan_parse_attr_bss(struct l=
_genl_attr *attr)
 	uint16_t type, len;
 	const void *data;
 	struct scan_bss *bss;
+	const uint8_t *ies =3D NULL;
+	size_t ies_len;
+	const uint8_t *beacon_ies =3D NULL;
+	size_t beacon_ies_len;
 =

 	bss =3D l_new(struct scan_bss, 1);
 	bss->utilization =3D 127;
+	bss->source_frame =3D SCAN_BSS_BEACON;
 =

 	while (l_genl_attr_next(attr, &type, &len, &data)) {
 		switch (type) {
@@ -1093,15 +1158,8 @@ static struct scan_bss *scan_parse_attr_bss(struct l=
_genl_attr *attr)
 			bss->signal_strength =3D *((int32_t *) data);
 			break;
 		case NL80211_BSS_INFORMATION_ELEMENTS:
-			if (!scan_parse_bss_information_elements(bss,
-								data, len))
-				goto fail;
-
-			bss->wsc =3D ie_tlv_extract_wsc_payload(data, len,
-								&bss->wsc_size);
-			bss->p2p =3D ie_tlv_extract_p2p_payload(data, len,
-								&bss->p2p_size);
-
+			ies =3D data;
+			ies_len =3D len;
 			break;
 		case NL80211_BSS_PARENT_TSF:
 			if (len !=3D sizeof(uint64_t))
@@ -1109,9 +1167,30 @@ static struct scan_bss *scan_parse_attr_bss(struct l=
_genl_attr *attr)
 =

 			bss->parent_tsf =3D l_get_u64(data);
 			break;
+		case NL80211_BSS_PRESP_DATA:
+			bss->source_frame =3D SCAN_BSS_PROBE_RESP;
+			break;
+		case NL80211_BSS_BEACON_IES:
+			beacon_ies =3D data;
+			beacon_ies_len =3D len;
+			break;
 		}
 	}
 =

+	/*
+	 * Try our best at deciding whether the IEs come from a Probe
+	 * Response based on the hints explained in nl80211.h
+	 * (enum nl80211_bss).
+	 */
+	if (bss->source_frame =3D=3D SCAN_BSS_BEACON && ies && (
+				!beacon_ies ||
+				ies_len !=3D beacon_ies_len ||
+				memcmp(ies, beacon_ies, ies_len)))
+		bss->source_frame =3D SCAN_BSS_PROBE_RESP;
+
+	if (ies && !scan_parse_bss_information_elements(bss, ies, ies_len))
+		goto fail;
+
 	return bss;
 =

 fail:
@@ -1271,9 +1350,33 @@ void scan_bss_free(struct scan_bss *bss)
 	l_free(bss->rsne);
 	l_free(bss->wpa);
 	l_free(bss->wsc);
-	l_free(bss->p2p);
 	l_free(bss->osen);
 	l_free(bss->rc_ie);
+
+	switch (bss->source_frame) {
+	case SCAN_BSS_PROBE_RESP:
+		if (!bss->p2p_probe_resp_info)
+			break;
+
+		p2p_clear_probe_resp(bss->p2p_probe_resp_info);
+		l_free(bss->p2p_probe_resp_info);
+		break;
+	case SCAN_BSS_PROBE_REQ:
+		if (!bss->p2p_probe_req_info)
+			break;
+
+		p2p_clear_probe_req(bss->p2p_probe_req_info);
+		l_free(bss->p2p_probe_req_info);
+		break;
+	case SCAN_BSS_BEACON:
+		if (!bss->p2p_beacon_info)
+			break;
+
+		p2p_clear_beacon(bss->p2p_beacon_info);
+		l_free(bss->p2p_beacon_info);
+		break;
+	}
+
 	l_free(bss);
 }
 =

diff --git a/src/scan.h b/src/scan.h
index 8fc2aa56..aa282084 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -40,6 +40,15 @@ typedef void (*scan_freq_set_func_t)(uint32_t freq, void=
 *userdata);
 =

 struct scan_freq_set;
 struct ie_rsn_info;
+struct p2p_probe_resp;
+struct p2p_probe_req;
+struct p2p_beacon;
+
+enum scan_bss_frame_type {
+	SCAN_BSS_PROBE_RESP,
+	SCAN_BSS_PROBE_REQ,
+	SCAN_BSS_BEACON,
+};
 =

 struct scan_bss {
 	uint8_t addr[6];
@@ -51,8 +60,12 @@ struct scan_bss {
 	uint8_t *osen;
 	uint8_t *wsc;		/* Concatenated WSC IEs */
 	ssize_t wsc_size;	/* Size of Concatenated WSC IEs */
-	uint8_t *p2p;		/* Concatenated P2P IEs */
-	ssize_t p2p_size;	/* Size of Concatenated P2P IEs */
+	enum scan_bss_frame_type source_frame;
+	union {
+		struct p2p_probe_resp *p2p_probe_resp_info;
+		struct p2p_probe_req *p2p_probe_req_info;
+		struct p2p_beacon *p2p_beacon_info;
+	};
 	uint8_t mde[3];
 	uint8_t ssid[32];
 	uint8_t ssid_len;
-- =

2.20.1

--===============4801849077757836276==--

