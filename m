Content-Type: multipart/mixed; boundary="===============5199320605482955052=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/8] scan: Add scan_bss_new_from_probe_req
Date: Thu, 24 Oct 2019 06:29:56 +0200
Message-ID: <20191024043000.13687-4-andrew.zaborowski@intel.com>
In-Reply-To: <20191024043000.13687-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5199320605482955052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/scan.c | 27 +++++++++++++++++++++++++++
 src/scan.h |  6 ++++++
 2 files changed, 33 insertions(+)

diff --git a/src/scan.c b/src/scan.c
index 2c676890..62f78130 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -46,6 +46,7 @@
 #include "src/nl80211util.h"
 #include "src/util.h"
 #include "src/p2putil.h"
+#include "src/mpdu.h"
 #include "src/scan.h"
 =

 #define SCAN_MAX_INTERVAL 320
@@ -1227,6 +1228,32 @@ static void scan_bss_compute_rank(struct scan_bss *b=
ss)
 		bss->rank =3D irank;
 }
 =

+struct scan_bss *scan_bss_new_from_probe_req(const struct mmpdu_header *mp=
du,
+						const uint8_t *body,
+						size_t body_len,
+						uint32_t frequency, int rssi)
+
+{
+	struct scan_bss *bss;
+
+	bss =3D l_new(struct scan_bss, 1);
+	memcpy(bss->addr, mpdu->address_2, 6);
+	bss->utilization =3D 127;
+	bss->source_frame =3D SCAN_BSS_PROBE_REQ;
+	bss->frequency =3D frequency;
+	bss->signal_strength =3D rssi;
+
+	if (!scan_parse_bss_information_elements(bss, body, body_len))
+		goto fail;
+
+	scan_bss_compute_rank(bss);
+	return bss;
+
+fail:
+	scan_bss_free(bss);
+	return NULL;
+}
+
 void scan_bss_free(struct scan_bss *bss)
 {
 	l_free(bss->ext_supp_rates_ie);
diff --git a/src/scan.h b/src/scan.h
index a3129dea..b602f731 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -43,6 +43,7 @@ struct ie_rsn_info;
 struct p2p_probe_resp;
 struct p2p_probe_req;
 struct p2p_beacon;
+struct mmpdu_header;
 =

 enum scan_bss_frame_type {
 	SCAN_BSS_PROBE_RESP,
@@ -134,6 +135,11 @@ int scan_bss_rank_compare(const void *a, const void *b=
, void *user);
 =

 int scan_bss_get_rsn_info(const struct scan_bss *bss, struct ie_rsn_info *=
info);
 =

+struct scan_bss *scan_bss_new_from_probe_req(const struct mmpdu_header *mp=
du,
+						const uint8_t *body,
+						size_t body_len,
+						uint32_t frequency, int rssi);
+
 uint8_t scan_freq_to_channel(uint32_t freq, enum scan_band *out_band);
 uint32_t scan_channel_to_freq(uint8_t channel, enum scan_band band);
 enum scan_band scan_oper_class_to_band(const uint8_t *country,
-- =

2.20.1

--===============5199320605482955052==--

