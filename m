Content-Type: multipart/mixed; boundary="===============4351461916902861659=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] rrm: support scan duration and mandatory flags
Date: Fri, 15 Nov 2019 10:06:07 -0800
Message-ID: <20191115180608.31564-3-prestwoj@gmail.com>
In-Reply-To: <20191115180608.31564-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4351461916902861659==
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
 src/rrm.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/src/rrm.c b/src/rrm.c
index e451448b..219b8bca 100644
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
@@ -395,7 +397,12 @@ static void rrm_handle_beacon_scan(struct rrm_state *r=
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

@@ -403,7 +410,7 @@ static void rrm_handle_beacon_scan(struct rrm_state *rr=
m,
 	scan_freq_set_add(freqs, freq);
 =

 	if (passive)
-		beacon->scan_id =3D scan_passive(rrm->wdev_id, freqs,
+		beacon->scan_id =3D scan_passive_full(rrm->wdev_id, &params,
 						rrm_scan_triggered,
 						rrm_scan_results, rrm,
 						NULL);
@@ -436,11 +443,11 @@ static bool rrm_verify_beacon_request(const uint8_t *=
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

@@ -455,6 +462,7 @@ static void rrm_handle_beacon_request(struct rrm_state =
*rrm,
 					uint8_t dialog_token,
 					const uint8_t *request, size_t len)
 {
+	struct wiphy *wiphy =3D station_get_wiphy(rrm->station);
 	struct rrm_beacon_req_info *beacon;
 	struct ie_tlv_iter iter;
 	/*
@@ -486,6 +494,16 @@ static void rrm_handle_beacon_request(struct rrm_state=
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
@@ -495,6 +513,7 @@ static void rrm_handle_beacon_request(struct rrm_state =
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

--===============4351461916902861659==--

