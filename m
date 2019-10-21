Content-Type: multipart/mixed; boundary="===============1752529138050165576=="
MIME-Version: 1.0
From: Andrew Zaborowski <balrogg@gmail.com>
Subject: [PATCH 02/11] netdev: Report RSSI to frame watch callbacks
Date: Mon, 21 Oct 2019 15:55:01 +0200
Message-ID: <20191021135510.12657-2-balrogg@gmail.com>
In-Reply-To: <20191021135510.12657-1-balrogg@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1752529138050165576==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Andrew Zaborowski <andrew.zaborowski@intel.com>

The main use case is for user-space implemented scanning / device
discovery logic, like in P2P, to be able to report device rssi like
the kernel- or driver-side scanning does, based on the received beacons,
probe requests, probe responses, GO negotiation requests, PD requests
etc.
---
 src/ap.c     | 13 +++++++------
 src/device.c |  2 +-
 src/netdev.c | 20 ++++++++++++++------
 src/netdev.h |  2 +-
 4 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index cb7288db..db231167 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -966,7 +966,7 @@ bad_frame:
 static void ap_assoc_req_cb(struct netdev *netdev,
 				const struct mmpdu_header *hdr,
 				const void *body, size_t body_len,
-				void *user_data)
+				int rssi, void *user_data)
 {
 	struct ap_state *ap =3D user_data;
 	struct sta_state *sta;
@@ -1000,7 +1000,7 @@ static void ap_assoc_req_cb(struct netdev *netdev,
 static void ap_reassoc_req_cb(struct netdev *netdev,
 				const struct mmpdu_header *hdr,
 				const void *body, size_t body_len,
-				void *user_data)
+				int rssi, void *user_data)
 {
 	struct ap_state *ap =3D user_data;
 	struct sta_state *sta;
@@ -1054,7 +1054,7 @@ static void ap_probe_resp_cb(struct l_genl_msg *msg, =
void *user_data)
 static void ap_probe_req_cb(struct netdev *netdev,
 				const struct mmpdu_header *hdr,
 				const void *body, size_t body_len,
-				void *user_data)
+				int rssi, void *user_data)
 {
 	struct ap_state *ap =3D user_data;
 	const struct mmpdu_probe_request *req =3D body;
@@ -1147,7 +1147,7 @@ static void ap_probe_req_cb(struct netdev *netdev,
 static void ap_disassoc_cb(struct netdev *netdev,
 				const struct mmpdu_header *hdr,
 				const void *body, size_t body_len,
-				void *user_data)
+				int rssi, void *user_data)
 {
 	struct ap_state *ap =3D user_data;
 	struct sta_state *sta;
@@ -1217,7 +1217,8 @@ static void ap_auth_reply(struct ap_state *ap, const =
uint8_t *dest,
  * 802.11-2016 12.3.3.2 (MLME/SME)
  */
 static void ap_auth_cb(struct netdev *netdev, const struct mmpdu_header *h=
dr,
-			const void *body, size_t body_len, void *user_data)
+			const void *body, size_t body_len, int rssi,
+			void *user_data)
 {
 	struct ap_state *ap =3D user_data;
 	const struct mmpdu_authentication *auth =3D body;
@@ -1285,7 +1286,7 @@ done:
 =

 /* 802.11-2016 9.3.3.13 (frame format), 802.11-2016 11.3.4.5 (MLME/SME) */
 static void ap_deauth_cb(struct netdev *netdev, const struct mmpdu_header =
*hdr,
-				const void *body, size_t body_len,
+				const void *body, size_t body_len, int rssi,
 				void *user_data)
 {
 	struct ap_state *ap =3D user_data;
diff --git a/src/device.c b/src/device.c
index 4f9d3933..4fd4edbe 100644
--- a/src/device.c
+++ b/src/device.c
@@ -57,7 +57,7 @@ static uint32_t netdev_watch;
 static void device_ap_roam_frame_event(struct netdev *netdev,
 		const struct mmpdu_header *hdr,
 		const void *body, size_t body_len,
-		void *user_data)
+		int rssi, void *user_data)
 {
 	struct device *device =3D user_data;
 	struct station *station =3D station_find(device->index);
diff --git a/src/netdev.c b/src/netdev.c
index 526480dd..23fd980d 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -36,6 +36,7 @@
 #include <linux/filter.h>
 #include <sys/socket.h>
 #include <errno.h>
+#include <limits.h>
 =

 #include <ell/ell.h>
 =

@@ -2895,7 +2896,7 @@ static void netdev_ft_request_cb(struct l_genl_msg *m=
sg, void *user_data)
 static void netdev_ft_response_frame_event(struct netdev *netdev,
 					const struct mmpdu_header *hdr,
 					const void *body, size_t body_len,
-					void *user_data)
+					int rssi, void *user_data)
 {
 	int ret;
 	uint16_t status_code =3D MMPDU_STATUS_CODE_UNSPECIFIED;
@@ -3171,7 +3172,7 @@ int netdev_neighbor_report_req(struct netdev *netdev,
 static void netdev_neighbor_report_frame_event(struct netdev *netdev,
 					const struct mmpdu_header *hdr,
 					const void *body, size_t body_len,
-					void *user_data)
+					int rssi, void *user_data)
 {
 	if (body_len < 3) {
 		l_debug("Neighbor Report frame too short");
@@ -3206,7 +3207,7 @@ static void netdev_sa_query_resp_cb(struct l_genl_msg=
 *msg,
 static void netdev_sa_query_req_frame_event(struct netdev *netdev,
 		const struct mmpdu_header *hdr,
 		const void *body, size_t body_len,
-		void *user_data)
+		int rssi, void *user_data)
 {
 	uint8_t sa_resp[4];
 	uint16_t transaction;
@@ -3244,7 +3245,7 @@ static void netdev_sa_query_req_frame_event(struct ne=
tdev *netdev,
 static void netdev_sa_query_resp_frame_event(struct netdev *netdev,
 		const struct mmpdu_header *hdr,
 		const void *body, size_t body_len,
-		void *user_data)
+		int rssi, void *user_data)
 {
 	if (body_len < 4) {
 		l_debug("SA Query frame too short");
@@ -3511,6 +3512,7 @@ static void netdev_mgmt_frame_event(struct l_genl_msg=
 *msg,
 	const struct mmpdu_header *mpdu =3D NULL;
 	const uint8_t *body;
 	struct frame_prefix_info info;
+	int rssi =3D INT_MIN;
 =

 	if (!l_genl_attr_init(&attr, msg))
 		return;
@@ -3527,6 +3529,11 @@ static void netdev_mgmt_frame_event(struct l_genl_ms=
g *msg,
 =

 			frame_len =3D len;
 			break;
+		case NL80211_ATTR_RX_SIGNAL_DBM:
+			if (len !=3D 4)
+				break;
+
+			rssi =3D *(const int32_t *) data;
 		}
 	}
 =

@@ -3550,12 +3557,13 @@ static void netdev_mgmt_frame_event(struct l_genl_m=
sg *msg,
 		WATCHLIST_NOTIFY_MATCHES(&netdev->frame_watches,
 					netdev_frame_watch_match_prefix, &info,
 					netdev_frame_watch_func_t,
-					netdev, mpdu, body, info.body_len);
+					netdev, mpdu, body, info.body_len,
+					rssi);
 	else
 		WATCHLIST_NOTIFY_MATCHES(&wdev_frame_watches,
 					netdev_frame_watch_match_prefix, &info,
 					netdev_frame_watch_func_t,
-					NULL, mpdu, body, info.body_len);
+					NULL, mpdu, body, info.body_len, rssi);
 }
 =

 static void netdev_pae_destroy(void *user_data)
diff --git a/src/netdev.h b/src/netdev.h
index 624811b2..77da52de 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -119,7 +119,7 @@ typedef void (*netdev_preauthenticate_cb_t)(struct netd=
ev *netdev,
 typedef void (*netdev_frame_watch_func_t)(struct netdev *netdev,
 					const struct mmpdu_header *frame,
 					const void *body, size_t body_len,
-					void *user_data);
+					int rssi, void *user_data);
 typedef void (*netdev_station_watch_func_t)(struct netdev *netdev,
 					const uint8_t *mac, bool added,
 					void *user_data);
-- =

2.20.1

--===============1752529138050165576==--

