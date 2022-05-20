Content-Type: multipart/mixed; boundary="===============3145129561969555330=="
MIME-Version: 1.0
From: Jesse Lentz <jesse at twosheds.org>
To: iwd at lists.01.org
Subject: [PATCH 1/2] Initial signal level notification
Date: Fri, 20 May 2022 17:53:23 -0400
Message-ID: <20220520215324.15537-1-jesse@twosheds.org>

--===============3145129561969555330==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After registration of a SignalLevelAgent, make iwd inform the client of
the initial signal level via a "Changed" method call.
---
 src/netdev.c  |  5 +++++
 src/netdev.h  |  1 +
 src/station.c | 19 ++++++++++++++-----
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index e483edf8..8b2143fd 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -450,6 +450,11 @@ const char *netdev_get_path(struct netdev *netdev)
 	return path;
 }
 =

+uint8_t netdev_get_rssi_level_idx(struct netdev *netdev)
+{
+	return netdev->cur_rssi_level_idx;
+}
+
 static void netdev_set_powered_result(int error, uint16_t type,
 					const void *data,
 					uint32_t len, void *user_data)
diff --git a/src/netdev.h b/src/netdev.h
index 0094d5f9..f093c499 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -145,6 +145,7 @@ bool netdev_get_4addr(struct netdev *netdev);
 const char *netdev_get_name(struct netdev *netdev);
 bool netdev_get_is_up(struct netdev *netdev);
 const char *netdev_get_path(struct netdev *netdev);
+uint8_t netdev_get_rssi_level_idx(struct netdev *netdev);
 =

 struct handshake_state *netdev_handshake_state_new(struct netdev *netdev);
 struct handshake_state *netdev_get_handshake(struct netdev *netdev);
diff --git a/src/station.c b/src/station.c
index 2d85054c..61dd690b 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3716,6 +3716,7 @@ static struct l_dbus_message *station_dbus_signal_age=
nt_register(
 {
 	struct station *station =3D user_data;
 	const char *path, *sender;
+	struct l_dbus_message *reply;
 	struct l_dbus_message_iter level_iter;
 	int8_t levels[16];
 	int err;
@@ -3758,12 +3759,20 @@ static struct l_dbus_message *station_dbus_signal_a=
gent_register(
 =

 	l_debug("agent %s path %s", sender, path);
 =

-	/*
-	 * TODO: send an initial notification in a oneshot idle callback,
-	 * if state is connected.
-	 */
+	reply =3D l_dbus_message_new_method_return(message);
+	l_dbus_send(dbus, reply);
 =

-	return l_dbus_message_new_method_return(message);
+	if (station->connected_network)
+	{
+		struct netdev *netdev =3D station->netdev;
+		uint8_t level =3D netdev_get_rssi_level_idx(netdev);
+
+		station_signal_agent_notify(station->signal_agent,
+						netdev_get_path(netdev),
+						level);
+	}
+
+	return NULL;
 }
 =

 static struct l_dbus_message *station_dbus_signal_agent_unregister(
-- =

2.36.0

--===============3145129561969555330==--

