Content-Type: multipart/mixed; boundary="===============8712179318923051741=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/4] netdev: Switch to new frame watch API
Date: Thu, 16 Jan 2020 03:40:59 +0100
Message-ID: <20200116024100.18371-3-andrew.zaborowski@intel.com>
In-Reply-To: <20200116024100.18371-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8712179318923051741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netdev.c | 68 +++++++++++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 84ba4c7f..ff56b78f 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -61,6 +61,7 @@
 #include "src/fils.h"
 #include "src/auth-proto.h"
 #include "src/rtnlutil.h"
+#include "src/frame-xchg.h"
 =

 #ifndef ENOTSUPP
 #define ENOTSUPP 524
@@ -2814,13 +2815,13 @@ static void netdev_ft_request_cb(struct l_genl_msg =
*msg, void *user_data)
 	}
 }
 =

-static void netdev_ft_response_frame_event(struct netdev *netdev,
-					const struct mmpdu_header *hdr,
+static void netdev_ft_response_frame_event(const struct mmpdu_header *hdr,
 					const void *body, size_t body_len,
-					void *user_data)
+					int rssi, void *user_data)
 {
 	int ret;
 	uint16_t status_code =3D MMPDU_STATUS_CODE_UNSPECIFIED;
+	struct netdev *netdev =3D user_data;
 =

 	if (!netdev->ap || !netdev->in_ft)
 		return;
@@ -2841,11 +2842,12 @@ ft_error:
 	return;
 }
 =

-static void netdev_qos_map_frame_event(struct netdev *netdev,
-					const struct mmpdu_header *hdr,
+static void netdev_qos_map_frame_event(const struct mmpdu_header *hdr,
 					const void *body, size_t body_len,
-					void *user_data)
+					int rssi, void *user_data)
 {
+	struct netdev *netdev =3D user_data;
+
 	/* No point telling the kernel */
 	if (!netdev->connected)
 		return;
@@ -3090,11 +3092,12 @@ int netdev_neighbor_report_req(struct netdev *netde=
v,
 	return 0;
 }
 =

-static void netdev_neighbor_report_frame_event(struct netdev *netdev,
-					const struct mmpdu_header *hdr,
+static void netdev_neighbor_report_frame_event(const struct mmpdu_header *=
hdr,
 					const void *body, size_t body_len,
-					void *user_data)
+					int rssi, void *user_data)
 {
+	struct netdev *netdev =3D user_data;
+
 	if (body_len < 3) {
 		l_debug("Neighbor Report frame too short");
 		return;
@@ -3125,13 +3128,13 @@ static void netdev_sa_query_resp_cb(struct l_genl_m=
sg *msg,
 		l_debug("error sending SA Query request");
 }
 =

-static void netdev_sa_query_req_frame_event(struct netdev *netdev,
-		const struct mmpdu_header *hdr,
-		const void *body, size_t body_len,
-		void *user_data)
+static void netdev_sa_query_req_frame_event(const struct mmpdu_header *hdr,
+					const void *body, size_t body_len,
+					int rssi, void *user_data)
 {
 	uint8_t sa_resp[4];
 	uint16_t transaction;
+	struct netdev *netdev =3D user_data;
 =

 	if (body_len < 4) {
 		l_debug("SA Query request too short");
@@ -3163,11 +3166,12 @@ static void netdev_sa_query_req_frame_event(struct =
netdev *netdev,
 	}
 }
 =

-static void netdev_sa_query_resp_frame_event(struct netdev *netdev,
-		const struct mmpdu_header *hdr,
-		const void *body, size_t body_len,
-		void *user_data)
+static void netdev_sa_query_resp_frame_event(const struct mmpdu_header *hd=
r,
+					const void *body, size_t body_len,
+					int rssi, void *user_data)
 {
+	struct netdev *netdev =3D user_data;
+
 	if (body_len < 4) {
 		l_debug("SA Query frame too short");
 		return;
@@ -4524,26 +4528,26 @@ struct netdev *netdev_create_from_genl(struct l_gen=
l_msg *msg,
 	l_free(rtmmsg);
 =

 	/* Subscribe to Management -> Action -> RM -> Neighbor Report frames */
-	netdev_frame_watch_add(netdev, 0x00d0, action_neighbor_report_prefix,
-				sizeof(action_neighbor_report_prefix),
-				netdev_neighbor_report_frame_event, NULL);
+	frame_watch_add(wdev, 0, 0x00d0, action_neighbor_report_prefix,
+			sizeof(action_neighbor_report_prefix),
+			netdev_neighbor_report_frame_event, netdev, NULL);
 =

-	netdev_frame_watch_add(netdev, 0x00d0, action_sa_query_resp_prefix,
-				sizeof(action_sa_query_resp_prefix),
-				netdev_sa_query_resp_frame_event, NULL);
+	frame_watch_add(wdev, 0, 0x00d0, action_sa_query_resp_prefix,
+			sizeof(action_sa_query_resp_prefix),
+			netdev_sa_query_resp_frame_event, netdev, NULL);
 =

-	netdev_frame_watch_add(netdev, 0x00d0, action_sa_query_req_prefix,
-				sizeof(action_sa_query_req_prefix),
-				netdev_sa_query_req_frame_event, NULL);
+	frame_watch_add(wdev, 0, 0x00d0, action_sa_query_req_prefix,
+			sizeof(action_sa_query_req_prefix),
+			netdev_sa_query_req_frame_event, netdev, NULL);
 =

-	netdev_frame_watch_add(netdev, 0x00d0, action_ft_response_prefix,
-				sizeof(action_ft_response_prefix),
-				netdev_ft_response_frame_event, NULL);
+	frame_watch_add(wdev, 0, 0x00d0, action_ft_response_prefix,
+			sizeof(action_ft_response_prefix),
+			netdev_ft_response_frame_event, netdev, NULL);
 =

 	if (wiphy_supports_qos_set_map(netdev->wiphy))
-		netdev_frame_watch_add(netdev, 0x00d0, action_qos_map_prefix,
-					sizeof(action_qos_map_prefix),
-					netdev_qos_map_frame_event, NULL);
+		frame_watch_add(wdev, 0, 0x00d0, action_qos_map_prefix,
+				sizeof(action_qos_map_prefix),
+				netdev_qos_map_frame_event, netdev, NULL);
 =

 	/* Set RSSI threshold for CQM notifications */
 	if (netdev->type =3D=3D NL80211_IFTYPE_STATION)
-- =

2.20.1

--===============8712179318923051741==--

