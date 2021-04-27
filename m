Content-Type: multipart/mixed; boundary="===============5093517054615961941=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] ap: set link/operstate on AP start/stop
Date: Tue, 27 Apr 2021 16:08:52 -0700
Message-ID: <20210427230852.94957-2-prestwoj@gmail.com>
In-Reply-To: <20210427230852.94957-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5093517054615961941==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prior to this netdev_connect_ok set setting this which really
only applies to station mode. In addition this happens for each
new station that connects to the AP. Instead set the operstate /
link mode when AP starts and stops.
---
 src/ap.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/ap.c b/src/ap.c
index 46821c04..89a05b8c 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -28,6 +28,7 @@
 #include <linux/if_ether.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
+#include <linux/if.h>
 =

 #include <ell/ell.h>
 =

@@ -3090,6 +3091,11 @@ static void ap_if_event_func(enum ap_event_type type=
, const void *event_data,
 		l_dbus_property_changed(dbus_get_bus(),
 					netdev_get_path(ap_if->netdev),
 					IWD_AP_INTERFACE, "Name");
+
+		l_rtnl_set_linkmode_and_operstate(rtnl,
+					netdev_get_ifindex(ap_if->netdev),
+					IF_LINK_MODE_DEFAULT, IF_OPER_UP,
+					NULL, NULL, NULL);
 		break;
 =

 	case AP_EVENT_STOPPING:
@@ -3104,6 +3110,11 @@ static void ap_if_event_func(enum ap_event_type type=
, const void *event_data,
 					netdev_get_path(ap_if->netdev),
 					IWD_AP_INTERFACE, "Name");
 =

+		l_rtnl_set_linkmode_and_operstate(rtnl,
+					netdev_get_ifindex(ap_if->netdev),
+					IF_LINK_MODE_DORMANT, IF_OPER_DOWN,
+					NULL, NULL, NULL);
+
 		if (!ap_if->pending)
 			ap_if->ap =3D NULL;
 =

-- =

2.26.2

--===============5093517054615961941==--

