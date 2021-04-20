Content-Type: multipart/mixed; boundary="===============4130197556132299858=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 6/8] rrm: Always create RRM state
Date: Tue, 20 Apr 2021 11:35:17 -0500
Message-ID: <20210420163519.12375-6-denkenz@gmail.com>
In-Reply-To: <20210420163519.12375-1-denkenz@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4130197556132299858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Right now, RRM is created when a new netdev is detected and its iftype
is of type station.  That means that any devices that start their life
as any other iftype cannot be changed to a station and have RRM function
properly.  Fix that by always creating the RRM state regardless of the
initial iftype.
---
 src/rrm.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/src/rrm.c b/src/rrm.c
index 860691a6f258..71442abb105f 100644
--- a/src/rrm.c
+++ b/src/rrm.c
@@ -770,14 +770,20 @@ static void rrm_state_destroy(void *data)
 	l_free(rrm);
 }
 =

-static void rrm_new_state(struct netdev *netdev)
+static void rrm_add_frame_watches(struct rrm_state *rrm)
 {
-	struct rrm_state *rrm;
-	uint16_t frame_type =3D 0x00d0;
-	uint8_t prefix[] =3D { 0x05, 0x00 };
+	static const uint16_t frame_type =3D 0x00d0;
+	static const uint8_t prefix[] =3D { 0x05, 0x00 };
 =

-	if (netdev_get_iftype(netdev) !=3D NETDEV_IFTYPE_STATION)
-		return;
+	l_debug("");
+
+	frame_watch_add(rrm->wdev_id, 0, frame_type, prefix, sizeof(prefix),
+					rrm_frame_watch_cb, rrm, NULL);
+}
+
+static struct rrm_state *rrm_new_state(struct netdev *netdev)
+{
+	struct rrm_state *rrm;
 =

 	rrm =3D l_new(struct rrm_state, 1);
 =

@@ -785,10 +791,9 @@ static void rrm_new_state(struct netdev *netdev)
 	rrm->ifindex =3D netdev_get_ifindex(netdev);
 	rrm->wdev_id =3D netdev_get_wdev_id(netdev);
 =

-	frame_watch_add(rrm->wdev_id, 0, frame_type, prefix, sizeof(prefix),
-					rrm_frame_watch_cb, rrm, NULL);
-
 	l_queue_push_head(states, rrm);
+
+	return rrm;
 }
 =

 static bool match_ifindex(const void *a, const void *b)
@@ -807,8 +812,12 @@ static void rrm_netdev_watch(struct netdev *netdev,
 =

 	switch (event) {
 	case NETDEV_WATCH_EVENT_NEW:
-		rrm_new_state(netdev);
-		return;
+		rrm =3D rrm_new_state(netdev);
+
+		if (netdev_get_iftype(netdev) =3D=3D NETDEV_IFTYPE_STATION)
+			rrm_add_frame_watches(rrm);
+
+		break;
 	case NETDEV_WATCH_EVENT_DEL:
 		/*
 		 * This event is triggered by the netdev being removed, which
-- =

2.26.3

--===============4130197556132299858==--

