Content-Type: multipart/mixed; boundary="===============3076317536482640777=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 4/8] rrm: Track that station is removed
Date: Tue, 20 Apr 2021 11:35:15 -0500
Message-ID: <20210420163519.12375-4-denkenz@gmail.com>
In-Reply-To: <20210420163519.12375-1-denkenz@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3076317536482640777==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In the case that a netdev is powered down, or an interface type change
occurs, the station object will be removed and any watches will be
freed.

Since rrm is created when the netdev is created and persists across
iftype and power up/down changes, it should provide a destroy callback
to station_add_state_watch so that it can be notified when the watch is
removed.
---
 src/rrm.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/src/rrm.c b/src/rrm.c
index f41bc907703b..860691a6f258 100644
--- a/src/rrm.c
+++ b/src/rrm.c
@@ -117,6 +117,7 @@ struct rrm_beacon_req_info {
 /* Per-netdev state */
 struct rrm_state {
 	struct station *station;
+	uint32_t watch_id;
 	uint32_t ifindex;
 	uint64_t wdev_id;
 	struct rrm_request_info *pending;
@@ -662,6 +663,17 @@ static void rrm_station_watch_cb(enum station_state st=
ate, void *userdata)
 	}
 }
 =

+static void rrm_station_watch_destroy(void *user_data)
+{
+	struct rrm_state *rrm =3D user_data;
+
+	l_debug("");
+
+	rrm_cancel_pending(rrm);
+	rrm->watch_id =3D 0;
+	rrm->station =3D NULL;
+}
+
 static void rrm_frame_watch_cb(const struct mmpdu_header *mpdu,
 				const void *body, size_t body_len,
 				int rssi, void *user_data)
@@ -684,8 +696,9 @@ static void rrm_frame_watch_cb(const struct mmpdu_heade=
r *mpdu,
 			return;
 		}
 =

-		station_add_state_watch(rrm->station, rrm_station_watch_cb,
-						rrm, NULL);
+		rrm->watch_id =3D station_add_state_watch(rrm->station,
+						rrm_station_watch_cb, rrm,
+						rrm_station_watch_destroy);
 	}
 =

 	/*
@@ -806,7 +819,10 @@ static void rrm_netdev_watch(struct netdev *netdev,
 		rrm =3D l_queue_remove_if(states, match_ifindex,
 						L_UINT_TO_PTR(ifindex));
 		if (rrm) {
-			rrm_cancel_pending(rrm);
+			if (rrm->station && rrm->watch_id)
+				station_remove_state_watch(rrm->station,
+								rrm->watch_id);
+
 			l_free(rrm);
 		}
 =

-- =

2.26.3

--===============3076317536482640777==--

