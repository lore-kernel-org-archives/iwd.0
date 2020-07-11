Content-Type: multipart/mixed; boundary="===============3446735017713063122=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 05/18] p2p: Implement the Peer.Device property
Date: Sat, 11 Jul 2020 03:00:40 +0200
Message-ID: <20200711010053.224223-5-andrew.zaborowski@intel.com>
In-Reply-To: <20200711010053.224223-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3446735017713063122==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add the net.connman.iwd.p2p.Peer.Device property as listed in doc/p2p-peer-=
api.txt
---
 src/p2p.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/src/p2p.c b/src/p2p.c
index 0d580ce3..1e38c45b 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -3454,6 +3454,18 @@ static bool p2p_peer_get_name(struct l_dbus *dbus,
 	return true;
 }
 =

+static bool p2p_peer_get_device(struct l_dbus *dbus,
+				struct l_dbus_message *message,
+				struct l_dbus_message_builder *builder,
+				void *user_data)
+{
+	struct p2p_peer *peer =3D user_data;
+
+	l_dbus_message_builder_append_basic(builder, 'o',
+						p2p_device_get_path(peer->dev));
+	return true;
+}
+
 static bool p2p_peer_get_category(struct l_dbus *dbus,
 					struct l_dbus_message *message,
 					struct l_dbus_message_builder *builder,
@@ -3530,6 +3542,8 @@ static void p2p_peer_interface_setup(struct l_dbus_in=
terface *interface)
 {
 	l_dbus_interface_property(interface, "Name", 0, "s",
 					p2p_peer_get_name, NULL);
+	l_dbus_interface_property(interface, "Device", 0, "o",
+					p2p_peer_get_device, NULL);
 	l_dbus_interface_property(interface, "DeviceCategory", 0, "s",
 					p2p_peer_get_category, NULL);
 	l_dbus_interface_property(interface, "DeviceSubcategory", 0, "s",
-- =

2.25.1

--===============3446735017713063122==--

