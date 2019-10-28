Content-Type: multipart/mixed; boundary="===============8085531115045897026=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 03/16] scan: Parse P2P IEs according to frame type
Date: Mon, 28 Oct 2019 15:04:55 +0100
Message-ID: <20191028140508.13518-3-andrew.zaborowski@intel.com>
In-Reply-To: <20191028140508.13518-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8085531115045897026==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Save the source frame type in struct scan_bss as it may affect how some
of the data in the struct should be parsed.  Also replace the P2P IE
payload data in that struct with a union containing pre-parsed p2p
attributes corresponding to the frame type.

This means users don't have to call the parsers in p2putil.c on that
data, which wouldn't have worked anyway because we those parsers were
assuming the raw concatenated P2P IEs as a parameter instead of the
payload extracted with ie_tlv_extract_p2p_payload.
---
 src/scan.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++-------
 src/scan.h | 17 ++++++++++--
 2 files changed, 84 insertions(+), 12 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index 0ec7831c..0956c6f6 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -45,6 +45,7 @@
 #include "src/nl80211cmd.h"
 #include "src/nl80211util.h"
 #include "src/util.h"
+#include "src/p2putil.h"
 #include "src/scan.h"
 =

 #define SCAN_MAX_INTERVAL 320
@@ -987,6 +988,38 @@ static bool scan_parse_bss_information_elements(struct=
 scan_bss *bss,
 		}
 	}
 =

+	bss->wsc =3D ie_tlv_extract_wsc_payload(data, len, &bss->wsc_size);
+
+	switch (bss->source_frame) {
+	case SCAN_BSS_PROBE_RESP:
+	{
+		struct p2p_probe_resp info;
+
+		if (p2p_parse_probe_resp(data, len, &info) =3D=3D 0)
+			bss->p2p_probe_resp_info =3D l_memdup(&info, sizeof(info));
+
+		break;
+	}
+	case SCAN_BSS_PROBE_REQ:
+	{
+		struct p2p_probe_req info;
+
+		if (p2p_parse_probe_req(data, len, &info) =3D=3D 0)
+			bss->p2p_probe_req_info =3D l_memdup(&info, sizeof(info));
+
+		break;
+	}
+	case SCAN_BSS_BEACON:
+	{
+		struct p2p_beacon info;
+
+		if (p2p_parse_beacon(data, len, &info) =3D=3D 0)
+			bss->p2p_beacon_info =3D l_memdup(&info, sizeof(info));
+
+		break;
+	}
+	}
+
 	return have_ssid;
 }
 =

@@ -995,9 +1028,12 @@ static struct scan_bss *scan_parse_attr_bss(struct l_=
genl_attr *attr)
 	uint16_t type, len;
 	const void *data;
 	struct scan_bss *bss;
+	const uint8_t *ies =3D NULL;
+	size_t ies_len;
 =

 	bss =3D l_new(struct scan_bss, 1);
 	bss->utilization =3D 127;
+	bss->source_frame =3D SCAN_BSS_BEACON;
 =

 	while (l_genl_attr_next(attr, &type, &len, &data)) {
 		switch (type) {
@@ -1025,20 +1061,19 @@ static struct scan_bss *scan_parse_attr_bss(struct =
l_genl_attr *attr)
 =

 			bss->signal_strength =3D *((int32_t *) data);
 			break;
+		case NL80211_BSS_PRESP_DATA:
+			bss->source_frame =3D SCAN_BSS_PROBE_RESP;
+			break;
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
 		}
 	}
 =

+	if (ies && !scan_parse_bss_information_elements(bss, ies, ies_len))
+		goto fail;
+
 	return bss;
 =

 fail:
@@ -1198,9 +1233,33 @@ void scan_bss_free(struct scan_bss *bss)
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
+		p2p_free_probe_resp(bss->p2p_probe_resp_info);
+		l_free(bss->p2p_probe_resp_info);
+		break;
+	case SCAN_BSS_PROBE_REQ:
+		if (!bss->p2p_probe_req_info)
+			break;
+
+		p2p_free_probe_req(bss->p2p_probe_req_info);
+		l_free(bss->p2p_probe_req_info);
+		break;
+	case SCAN_BSS_BEACON:
+		if (!bss->p2p_beacon_info)
+			break;
+
+		p2p_free_beacon(bss->p2p_beacon_info);
+		l_free(bss->p2p_beacon_info);
+		break;
+	}
+
 	l_free(bss);
 }
 =

diff --git a/src/scan.h b/src/scan.h
index 626de80b..afed831e 100644
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

--===============8085531115045897026==--

