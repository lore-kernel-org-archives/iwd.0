Content-Type: multipart/mixed; boundary="===============7123481824199418814=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/2] ap: Switch to new frame watch API
Date: Mon, 06 Jan 2020 13:39:39 +0100
Message-ID: <20200106123939.6960-2-andrew.zaborowski@intel.com>
In-Reply-To: <20200106123939.6960-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7123481824199418814==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ap.c | 92 ++++++++++++++++++++------------------------------------
 1 file changed, 33 insertions(+), 59 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index f8698e9a..569f8572 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -44,6 +44,7 @@
 #include "src/handshake.h"
 #include "src/dbus.h"
 #include "src/nl80211util.h"
+#include "src/frame-xchg.h"
 =

 struct ap_state {
 	struct netdev *netdev;
@@ -55,7 +56,6 @@ struct ap_state {
 	uint32_t beacon_interval;
 	struct l_uintset *rates;
 	uint8_t pmk[32];
-	struct l_queue *frame_watch_ids;
 	uint32_t start_stop_cmd_id;
 	uint8_t gtk[CRYPTO_MAX_GTK_LEN];
 	uint8_t gtk_index;
@@ -109,14 +109,6 @@ static void ap_sta_free(void *data)
 	l_free(sta);
 }
 =

-static void ap_frame_watch_remove(void *data, void *user_data)
-{
-	struct netdev *netdev =3D user_data;
-
-	if (L_PTR_TO_UINT(data))
-		netdev_frame_watch_remove(netdev, L_PTR_TO_UINT(data));
-}
-
 static void ap_reset(struct ap_state *ap)
 {
 	struct netdev *netdev =3D ap->netdev;
@@ -132,8 +124,7 @@ static void ap_reset(struct ap_state *ap)
 =

 	memset(ap->pmk, 0, sizeof(ap->pmk));
 =

-	l_queue_foreach(ap->frame_watch_ids, ap_frame_watch_remove, netdev);
-	l_queue_destroy(ap->frame_watch_ids, NULL);
+	frame_watch_wdev_remove(netdev_get_wdev_id(netdev));
 =

 	if (ap->start_stop_cmd_id)
 		l_genl_family_cancel(ap->nl80211, ap->start_stop_cmd_id);
@@ -968,10 +959,8 @@ bad_frame:
 }
 =

 /* 802.11-2016 9.3.3.6 */
-static void ap_assoc_req_cb(struct netdev *netdev,
-				const struct mmpdu_header *hdr,
-				const void *body, size_t body_len,
-				void *user_data)
+static void ap_assoc_req_cb(const struct mmpdu_header *hdr, const void *bo=
dy,
+				size_t body_len, int rssi, void *user_data)
 {
 	struct ap_state *ap =3D user_data;
 	struct sta_state *sta;
@@ -1002,10 +991,8 @@ static void ap_assoc_req_cb(struct netdev *netdev,
 }
 =

 /* 802.11-2016 9.3.3.8 */
-static void ap_reassoc_req_cb(struct netdev *netdev,
-				const struct mmpdu_header *hdr,
-				const void *body, size_t body_len,
-				void *user_data)
+static void ap_reassoc_req_cb(const struct mmpdu_header *hdr, const void *=
body,
+				size_t body_len, int rssi, void *user_data)
 {
 	struct ap_state *ap =3D user_data;
 	struct sta_state *sta;
@@ -1056,10 +1043,8 @@ static void ap_probe_resp_cb(struct l_genl_msg *msg,=
 void *user_data)
  * Parse Probe Request according to 802.11-2016 9.3.3.10 and act according
  * to 802.11-2016 11.1.4.3
  */
-static void ap_probe_req_cb(struct netdev *netdev,
-				const struct mmpdu_header *hdr,
-				const void *body, size_t body_len,
-				void *user_data)
+static void ap_probe_req_cb(const struct mmpdu_header *hdr, const void *bo=
dy,
+				size_t body_len, int rssi, void *user_data)
 {
 	struct ap_state *ap =3D user_data;
 	const struct mmpdu_probe_request *req =3D body;
@@ -1149,10 +1134,8 @@ static void ap_probe_req_cb(struct netdev *netdev,
 }
 =

 /* 802.11-2016 9.3.3.5 (frame format), 802.11-2016 11.3.5.9 (MLME/SME) */
-static void ap_disassoc_cb(struct netdev *netdev,
-				const struct mmpdu_header *hdr,
-				const void *body, size_t body_len,
-				void *user_data)
+static void ap_disassoc_cb(const struct mmpdu_header *hdr, const void *bod=
y,
+				size_t body_len, int rssi, void *user_data)
 {
 	struct ap_state *ap =3D user_data;
 	struct sta_state *sta;
@@ -1221,8 +1204,8 @@ static void ap_auth_reply(struct ap_state *ap, const =
uint8_t *dest,
  * 802.11-2016 9.3.3.12 (frame format), 802.11-2016 11.3.4.3 and
  * 802.11-2016 12.3.3.2 (MLME/SME)
  */
-static void ap_auth_cb(struct netdev *netdev, const struct mmpdu_header *h=
dr,
-			const void *body, size_t body_len, void *user_data)
+static void ap_auth_cb(const struct mmpdu_header *hdr, const void *body,
+			size_t body_len, int rssi, void *user_data)
 {
 	struct ap_state *ap =3D user_data;
 	const struct mmpdu_authentication *auth =3D body;
@@ -1289,9 +1272,8 @@ done:
 }
 =

 /* 802.11-2016 9.3.3.13 (frame format), 802.11-2016 11.3.4.5 (MLME/SME) */
-static void ap_deauth_cb(struct netdev *netdev, const struct mmpdu_header =
*hdr,
-				const void *body, size_t body_len,
-				void *user_data)
+static void ap_deauth_cb(const struct mmpdu_header *hdr, const void *body,
+				size_t body_len, int rssi, void *user_data)
 {
 	struct ap_state *ap =3D user_data;
 	struct sta_state *sta;
@@ -1417,8 +1399,7 @@ static int ap_start(struct ap_state *ap, const char *=
ssid, const char *psk,
 	struct netdev *netdev =3D ap->netdev;
 	struct wiphy *wiphy =3D netdev_get_wiphy(netdev);
 	struct l_genl_msg *cmd;
-	const struct l_queue_entry *entry;
-	uint32_t id;
+	uint64_t wdev_id =3D netdev_get_wdev_id(netdev);
 =

 	ap->ssid =3D l_strdup(ssid);
 	/* TODO: Start a Get Survey to decide the channel */
@@ -1437,42 +1418,35 @@ static int ap_start(struct ap_state *ap, const char=
 *ssid, const char *psk,
 					ap->pmk) < 0)
 		goto error;
 =

-	ap->frame_watch_ids =3D l_queue_new();
-
-	id =3D netdev_frame_watch_add(netdev, 0x0000 |
+	if (!frame_watch_add(wdev_id, 0, 0x0000 |
 			(MPDU_MANAGEMENT_SUBTYPE_ASSOCIATION_REQUEST << 4),
-			NULL, 0, ap_assoc_req_cb, ap);
-	l_queue_push_tail(ap->frame_watch_ids, L_UINT_TO_PTR(id));
+			NULL, 0, ap_assoc_req_cb, ap, NULL))
+		goto error;
 =

-	id =3D netdev_frame_watch_add(netdev, 0x0000 |
+	if (!frame_watch_add(wdev_id, 0, 0x0000 |
 			(MPDU_MANAGEMENT_SUBTYPE_REASSOCIATION_REQUEST << 4),
-			NULL, 0, ap_reassoc_req_cb, ap);
-	l_queue_push_tail(ap->frame_watch_ids, L_UINT_TO_PTR(id));
+			NULL, 0, ap_reassoc_req_cb, ap, NULL))
+		goto error;
 =

-	id =3D netdev_frame_watch_add(netdev, 0x0000 |
+	if (!frame_watch_add(wdev_id, 0, 0x0000 |
 				(MPDU_MANAGEMENT_SUBTYPE_PROBE_REQUEST << 4),
-				NULL, 0, ap_probe_req_cb, ap);
-	l_queue_push_tail(ap->frame_watch_ids, L_UINT_TO_PTR(id));
+				NULL, 0, ap_probe_req_cb, ap, NULL))
+		goto error;
 =

-	id =3D netdev_frame_watch_add(netdev, 0x0000 |
+	if (!frame_watch_add(wdev_id, 0, 0x0000 |
 				(MPDU_MANAGEMENT_SUBTYPE_DISASSOCIATION << 4),
-				NULL, 0, ap_disassoc_cb, ap);
-	l_queue_push_tail(ap->frame_watch_ids, L_UINT_TO_PTR(id));
+				NULL, 0, ap_disassoc_cb, ap, NULL))
+		goto error;
 =

-	id =3D netdev_frame_watch_add(netdev, 0x0000 |
+	if (!frame_watch_add(wdev_id, 0, 0x0000 |
 				(MPDU_MANAGEMENT_SUBTYPE_AUTHENTICATION << 4),
-				NULL, 0, ap_auth_cb, ap);
-	l_queue_push_tail(ap->frame_watch_ids, L_UINT_TO_PTR(id));
+				NULL, 0, ap_auth_cb, ap, NULL))
+		goto error;
 =

-	id =3D netdev_frame_watch_add(netdev, 0x0000 |
+	if (!frame_watch_add(wdev_id, 0, 0x0000 |
 				(MPDU_MANAGEMENT_SUBTYPE_DEAUTHENTICATION << 4),
-				NULL, 0, ap_deauth_cb, ap);
-	l_queue_push_tail(ap->frame_watch_ids, L_UINT_TO_PTR(id));
-
-	for (entry =3D l_queue_get_entries(ap->frame_watch_ids); entry;
-			entry =3D entry->next)
-		if (!L_PTR_TO_UINT(entry->data))
-			goto error;
+				NULL, 0, ap_deauth_cb, ap, NULL))
+		goto error;
 =

 	cmd =3D ap_build_cmd_start_ap(ap);
 	if (!cmd)
-- =

2.20.1

--===============7123481824199418814==--

