Content-Type: multipart/mixed; boundary="===============0677759096023468439=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH 1/2] p2p: Add p2p.Peer.Address D-bus property
Date: Wed, 06 Oct 2021 22:52:13 +0200
Message-ID: <20211006205214.227476-1-andrew.zaborowski@intel.com>

--===============0677759096023468439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Expose the Device Address property for each peer.  The spec doesn't say
much about how permanent the address or the name are, although the
device address by definition lives longer than the interface addresses.
However the device address is defined to be unique and the name is not
so the address can be used to differentiate devices with identical name.
Being unique also may imply that it's assigned globally and thus
permanent.

Network Manager uses the P2P device address when saving connection
profiles (and will need it from the backend) and in this case it seems
better justified than using the name.

The address is already in the object path but the object path also
includes the local phy index which may change for no reason even when
the peer's address hasn't changed so the path is not useful for
remembering which device we've connected to before.  Looking at only
parts of the path is considered wrong.
---
 src/p2p.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/src/p2p.c b/src/p2p.c
index 90779f95..3ae28edd 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -4708,6 +4708,18 @@ static bool p2p_peer_get_name(struct l_dbus *dbus,
 	return true;
 }
 =

+static bool p2p_peer_get_addr(struct l_dbus *dbus,
+				struct l_dbus_message *message,
+				struct l_dbus_message_builder *builder,
+				void *user_data)
+{
+	struct p2p_peer *peer =3D user_data;
+	const char *addr =3D util_address_to_string(peer->device_addr);
+
+	l_dbus_message_builder_append_basic(builder, 's', addr);
+	return true;
+}
+
 static bool p2p_peer_get_device(struct l_dbus *dbus,
 				struct l_dbus_message *message,
 				struct l_dbus_message_builder *builder,
@@ -4825,6 +4837,8 @@ static void p2p_peer_interface_setup(struct l_dbus_in=
terface *interface)
 {
 	l_dbus_interface_property(interface, "Name", 0, "s",
 					p2p_peer_get_name, NULL);
+	l_dbus_interface_property(interface, "Address", 0, "s",
+					p2p_peer_get_addr, NULL);
 	l_dbus_interface_property(interface, "Device", 0, "o",
 					p2p_peer_get_device, NULL);
 	l_dbus_interface_property(interface, "DeviceCategory", 0, "s",
-- =

2.30.2

--===============0677759096023468439==--

