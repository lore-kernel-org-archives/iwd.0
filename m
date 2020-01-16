Content-Type: multipart/mixed; boundary="===============3882046271678260536=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/4] rrm: Switch to new frame watch API
Date: Thu, 16 Jan 2020 03:40:58 +0100
Message-ID: <20200116024100.18371-2-andrew.zaborowski@intel.com>
In-Reply-To: <20200116024100.18371-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3882046271678260536==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/rrm.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/src/rrm.c b/src/rrm.c
index a117dce3..64d4afd3 100644
--- a/src/rrm.c
+++ b/src/rrm.c
@@ -39,6 +39,7 @@
 #include "src/scan.h"
 #include "src/nl80211util.h"
 #include "src/wiphy.h"
+#include "src/frame-xchg.h"
 =

 #include "linux/nl80211.h"
 =

@@ -658,10 +659,9 @@ static void rrm_station_watch_cb(enum station_state st=
ate, void *userdata)
 	}
 }
 =

-static void rrm_frame_watch_cb(struct netdev *netdev,
-				const struct mmpdu_header *mpdu,
+static void rrm_frame_watch_cb(const struct mmpdu_header *mpdu,
 				const void *body, size_t body_len,
-				void *user_data)
+				int rssi, void *user_data)
 {
 	struct rrm_state *rrm =3D user_data;
 	const uint8_t *request =3D body;
@@ -769,8 +769,8 @@ static void rrm_new_state(struct netdev *netdev)
 	rrm->ifindex =3D netdev_get_ifindex(netdev);
 	rrm->wdev_id =3D netdev_get_wdev_id(netdev);
 =

-	netdev_frame_watch_add(netdev, frame_type, prefix, sizeof(prefix),
-					rrm_frame_watch_cb, rrm);
+	frame_watch_add(rrm->wdev_id, 0, frame_type, prefix, sizeof(prefix),
+					rrm_frame_watch_cb, rrm, NULL);
 =

 	l_queue_push_head(states, rrm);
 }
@@ -794,6 +794,12 @@ static void rrm_netdev_watch(struct netdev *netdev,
 		rrm_new_state(netdev);
 		return;
 	case NETDEV_WATCH_EVENT_DEL:
+		/*
+		 * We're triggered on L80211_CMD_DEL_INTERFACE and RTM_DELLINK which
+		 * also cause all frame watches to be unregistered so we don't have
+		 * to do this here.
+		 */
+
 		rrm =3D l_queue_remove_if(states, match_ifindex,
 						L_UINT_TO_PTR(ifindex));
 		if (rrm) {
-- =

2.20.1

--===============3882046271678260536==--

