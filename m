Content-Type: multipart/mixed; boundary="===============6314874027730456858=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/4] ap: tie diagnostic interface to AP Start/Stop
Date: Mon, 01 Feb 2021 15:52:17 -0800
Message-ID: <20210201235217.46602-4-prestwoj@gmail.com>
In-Reply-To: <20210201235217.46602-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6314874027730456858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The diagnostic interface serves no purpose until the AP has
been started. Any calls on it will return an error so instead
it makes more sense to bring it up when the AP is started, and
down when the AP is stopped.
---
 src/ap.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index f33d73e1..8ea26a0d 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -2966,6 +2966,11 @@ static void ap_if_event_func(enum ap_event_type type=
, const void *event_data,
 		if (L_WARN_ON(!ap_if->pending))
 			break;
 =

+		l_dbus_object_add_interface(dbus_get_bus(),
+						netdev_get_path(ap_if->netdev),
+						IWD_AP_DIAGNOSTIC_INTERFACE,
+						ap_if);
+
 		reply =3D l_dbus_message_new_method_return(ap_if->pending);
 		dbus_pending_reply(&ap_if->pending, reply);
 		l_dbus_property_changed(dbus_get_bus(),
@@ -2977,6 +2982,10 @@ static void ap_if_event_func(enum ap_event_type type=
, const void *event_data,
 		break;
 =

 	case AP_EVENT_STOPPING:
+		l_dbus_object_remove_interface(dbus_get_bus(),
+						netdev_get_path(ap_if->netdev),
+						IWD_AP_DIAGNOSTIC_INTERFACE);
+
 		l_dbus_property_changed(dbus_get_bus(),
 					netdev_get_path(ap_if->netdev),
 					IWD_AP_INTERFACE, "Started");
@@ -3265,16 +3274,12 @@ static void ap_add_interface(struct netdev *netdev)
 	/* setup ap dbus interface */
 	l_dbus_object_add_interface(dbus_get_bus(),
 			netdev_get_path(netdev), IWD_AP_INTERFACE, ap_if);
-	l_dbus_object_add_interface(dbus_get_bus(), netdev_get_path(netdev),
-			IWD_AP_DIAGNOSTIC_INTERFACE, ap_if);
 }
 =

 static void ap_remove_interface(struct netdev *netdev)
 {
 	l_dbus_object_remove_interface(dbus_get_bus(),
 			netdev_get_path(netdev), IWD_AP_INTERFACE);
-	l_dbus_object_remove_interface(dbus_get_bus(), netdev_get_path(netdev),
-			IWD_AP_DIAGNOSTIC_INTERFACE);
 }
 =

 static void ap_netdev_watch(struct netdev *netdev,
-- =

2.26.2

--===============6314874027730456858==--

