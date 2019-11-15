Content-Type: multipart/mixed; boundary="===============6507031826672289144=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/7] rrm: support scan duration and mandatory flags
Date: Fri, 15 Nov 2019 10:39:22 -0800
Message-ID: <20191115183926.1887-3-prestwoj@gmail.com>
In-Reply-To: <20191115183926.1887-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6507031826672289144==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Beacon requests can specify a scan duration, and set a flag which makes
this duration mandatory. The kernel supports both these values for scan
requests so we no longer need to reject requests which contain these.

Drivers which do not support EXT_FEATURE_SET_SCAN_DWELL will ignore the
duration value, but if duration mandatory is set we must reject the
request.
---
 src/rrm.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

-v2:
 * Include duration in report

diff --git a/src/rrm.c b/src/rrm.c
index e451448b..f96fe279 100644
--- a/src/rrm.c
+++ b/src/rrm.c
@@ -39,6 +39,7 @@
 #include "src/station.h"
 #include "src/scan.h"
 #include "src/nl80211util.h"
+#include "src/wiphy.h"
 =

 #include "linux/nl80211.h"
 =

@@ -104,6 +105,7 @@ struct rrm_beacon_req_info {
 	struct rrm_request_info info;
 	uint8_t oper_class;
 	uint8_t channel;	/* The single channel provided in request */
+	uint16_t duration;
 	uint8_t bssid[6];	/* Request filtered by BSSID */
 	char ssid[33];		/* Request filtered by SSID */
 	bool has_ssid;
@@ -249,9 +251,11 @@ static size_t build_report_for_bss(struct rrm_beacon_r=
eq_info *beacon,
 =

 	*to++ =3D beacon->oper_class;
 	*to++ =3D scan_freq_to_channel(bss->frequency, NULL);
-	/* skip start time/duration */
-	memset(to, 0, 10);
-	to +=3D 10;
+	/* skip start time */
+	memset(to, 0, 8);
+	to +=3D 8;
+	l_put_le16(beacon->duration, to);
+	to +=3D 2;
 	*to++ =3D rrm_phy_type(bss);
 =

 	/* 802.11 Table 9-154 - RCPI values */
@@ -395,7 +399,12 @@ static void rrm_handle_beacon_scan(struct rrm_state *r=
rm,
 					bool passive)
 {
 	struct scan_freq_set *freqs =3D scan_freq_set_new();
-	struct scan_parameters params =3D { .freqs =3D freqs, .flush =3D true };
+	struct scan_parameters params =3D {
+		.freqs =3D freqs,
+		.flush =3D true,
+		.duration =3D beacon->duration,
+		.duration_mandatory =3D util_is_bit_set(beacon->info.mode, 4),
+	};
 	enum scan_band band =3D scan_oper_class_to_band(NULL, beacon->oper_class);
 	uint32_t freq;
 =

@@ -403,7 +412,7 @@ static void rrm_handle_beacon_scan(struct rrm_state *rr=
m,
 	scan_freq_set_add(freqs, freq);
 =

 	if (passive)
-		beacon->scan_id =3D scan_passive(rrm->wdev_id, freqs,
+		beacon->scan_id =3D scan_passive_full(rrm->wdev_id, &params,
 						rrm_scan_triggered,
 						rrm_scan_results, rrm,
 						NULL);
@@ -436,11 +445,11 @@ static bool rrm_verify_beacon_request(const uint8_t *=
request, size_t len)
 			return false;
 =

 		/*
-		 * Not handling interval/duration requests. We can omit this
+		 * Not handling random interval requests. We can omit this
 		 * check for table requests since we just return whatever we
 		 * have cached.
 		 */
-		if (!util_mem_is_zero(request + 2, 4))
+		if (!util_mem_is_zero(request + 2, 2))
 			return false;
 	}
 =

@@ -455,6 +464,7 @@ static void rrm_handle_beacon_request(struct rrm_state =
*rrm,
 					uint8_t dialog_token,
 					const uint8_t *request, size_t len)
 {
+	struct wiphy *wiphy =3D station_get_wiphy(rrm->station);
 	struct rrm_beacon_req_info *beacon;
 	struct ie_tlv_iter iter;
 	/*
@@ -486,6 +496,16 @@ static void rrm_handle_beacon_request(struct rrm_state=
 *rrm,
 	if (util_is_bit_set(beacon->info.mode, 1))
 		goto reject_refused;
 =

+	/*
+	 * Some drivers (non mac80211) do not allow setting a duration/mandatory
+	 * bit in scan requests. The actual duration value can be ignored in
+	 * this case but if the requests includes the duration mandatory bit we
+	 * must reject this request.
+	 */
+	if (!wiphy_has_ext_feature(wiphy, NL80211_EXT_FEATURE_SET_SCAN_DWELL)
+			&& util_is_bit_set(beacon->info.mode, 4))
+		goto reject_incapable;
+
 	/* advance to beacon request */
 	request +=3D 3;
 	len -=3D 3;
@@ -495,6 +515,7 @@ static void rrm_handle_beacon_request(struct rrm_state =
*rrm,
 =

 	beacon->oper_class =3D request[0];
 	beacon->channel =3D request[1];
+	beacon->duration =3D l_get_le16(request + 4);
 	memcpy(beacon->bssid, request + 7, 6);
 =

 	ie_tlv_iter_init(&iter, request + 13, len - 13);
-- =

2.17.1

--===============6507031826672289144==--

