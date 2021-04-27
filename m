Content-Type: multipart/mixed; boundary="===============3794603952419310018=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] station: transition to disconnected on DOWN/DEL events
Date: Tue, 27 Apr 2021 13:58:08 -0700
Message-ID: <20210427205808.65927-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3794603952419310018==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows station to gracefully clean up things like the diagnostic
interface which is directly tied to stations CONNECTED/DISCONNECTED
states.
---
 src/station.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/station.c b/src/station.c
index 9c2b4e64..f2a6a56e 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3695,6 +3695,8 @@ static void add_frame_watches(struct netdev *netdev)
 static void station_netdev_watch(struct netdev *netdev,
 				enum netdev_watch_event event, void *userdata)
 {
+	struct station *station =3D station_find(netdev_get_ifindex(netdev));
+
 	switch (event) {
 	case NETDEV_WATCH_EVENT_NEW:
 		if (netdev_get_iftype(netdev) =3D=3D NETDEV_IFTYPE_STATION) {
@@ -3711,6 +3713,10 @@ static void station_netdev_watch(struct netdev *netd=
ev,
 		break;
 	case NETDEV_WATCH_EVENT_DOWN:
 	case NETDEV_WATCH_EVENT_DEL:
+		if (netdev_get_iftype(netdev) =3D=3D NETDEV_IFTYPE_STATION)
+			station_enter_state(station,
+						STATION_STATE_DISCONNECTED);
+
 		l_dbus_object_remove_interface(dbus_get_bus(),
 						netdev_get_path(netdev),
 						IWD_STATION_INTERFACE);
-- =

2.26.2

--===============3794603952419310018==--

