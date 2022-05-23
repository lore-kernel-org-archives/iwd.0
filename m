Content-Type: multipart/mixed; boundary="===============2713179222791928195=="
MIME-Version: 1.0
From: Jesse Lentz <jesse at twosheds.org>
To: iwd at lists.01.org
Subject: [PATCH 1/2] station: Simplify usage of station_signal_agent_notify()
Date: Mon, 23 May 2022 02:20:52 -0400
Message-ID: <20220523062053.16206-1-jesse@twosheds.org>

--===============2713179222791928195==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

station_signal_agent_notify() has been refactored so that its usage is
simpler. station_rssi_level_changed() has been replaced by an inlined
call to station_signal_agent_notify().
---
 src/station.c | 38 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/src/station.c b/src/station.c
index a356339e..6aad40cb 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1438,6 +1438,8 @@ static void station_set_drop_unicast_l2_multicast(str=
uct station *station,
 				"drop_unicast_in_l2_multicast", v);
 }
 =

+static void station_signal_agent_notify(struct station *station);
+
 static void station_enter_state(struct station *station,
 						enum station_state state)
 {
@@ -2754,9 +2756,6 @@ static void station_event_channel_switched(struct sta=
tion *station,
 	network_bss_update(network, station->connected_bss);
 }
 =

-static void station_rssi_level_changed(struct station *station,
-					uint8_t level_idx);
-
 static bool station_try_next_bss(struct station *station)
 {
 	struct scan_bss *next;
@@ -3011,7 +3010,8 @@ static void station_netdev_event(struct netdev *netde=
v, enum netdev_event event,
 		station_ok_rssi(station);
 		break;
 	case NETDEV_EVENT_RSSI_LEVEL_NOTIFY:
-		station_rssi_level_changed(station, l_get_u8(event_data));
+		if (station->signal_agent)
+			station_signal_agent_notify(station);
 		break;
 	case NETDEV_EVENT_ROAMING:
 		station_enter_state(station, STATION_STATE_ROAMING);
@@ -3645,9 +3645,13 @@ struct signal_agent {
 	unsigned int disconnect_watch;
 };
 =

-static void station_signal_agent_notify(struct signal_agent *agent,
-					const char *device_path, uint8_t level)
+static void station_signal_agent_notify(struct station *station)
 {
+	struct signal_agent *agent =3D station->signal_agent;
+	struct netdev *netdev =3D station->netdev;
+	const char *device_path =3D netdev_get_path(netdev);
+	uint8_t level =3D netdev_get_rssi_level_idx(netdev);
+
 	struct l_dbus_message *msg;
 =

 	msg =3D l_dbus_message_new_method_call(dbus_get_bus(),
@@ -3660,18 +3664,6 @@ static void station_signal_agent_notify(struct signa=
l_agent *agent,
 	l_dbus_send(dbus_get_bus(), msg);
 }
 =

-static void station_rssi_level_changed(struct station *station,
-					uint8_t level_idx)
-{
-	struct netdev *netdev =3D station->netdev;
-
-	if (!station->signal_agent)
-		return;
-
-	station_signal_agent_notify(station->signal_agent,
-					netdev_get_path(netdev), level_idx);
-}
-
 static void station_signal_agent_release(struct signal_agent *agent,
 						const char *device_path)
 {
@@ -3762,14 +3754,8 @@ static struct l_dbus_message *station_dbus_signal_ag=
ent_register(
 	reply =3D l_dbus_message_new_method_return(message);
 	l_dbus_send(dbus, reply);
 =

-	if (station->connected_network) {
-		struct netdev *netdev =3D station->netdev;
-		uint8_t level =3D netdev_get_rssi_level_idx(netdev);
-
-		station_signal_agent_notify(station->signal_agent,
-						netdev_get_path(netdev),
-						level);
-	}
+	if (station->connected_network)
+		station_signal_agent_notify(station);
 =

 	return NULL;
 }
-- =

2.36.0

--===============2713179222791928195==--

