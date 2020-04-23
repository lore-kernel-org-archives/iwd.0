Content-Type: multipart/mixed; boundary="===============4523674090990469112=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 02/19] p2p: Add peer WSC device type properties
Date: Thu, 23 Apr 2020 18:24:30 +0200
Message-ID: <20200423162447.15750-2-andrew.zaborowski@intel.com>
In-Reply-To: <20200423162447.15750-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4523674090990469112==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/p2p.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/src/p2p.c b/src/p2p.c
index f2cdd011..52ad2808 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -68,6 +68,7 @@ struct p2p_peer {
 	struct scan_bss *bss;
 	struct p2p_device *dev;
 	char *name;
+	struct wsc_primary_device_type primary_device_type;
 };
 =

 static struct l_queue *p2p_device_list;
@@ -301,6 +302,46 @@ static bool p2p_peer_get_name(struct l_dbus *dbus,
 	return true;
 }
 =

+static bool p2p_peer_get_category(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct p2p_peer *peer =3D user_data;
+	const char *category;
+
+	if (!wsc_device_type_to_dbus_str(&peer->primary_device_type,
+						&category, NULL) ||
+			!category)
+		category =3D "unknown-device";
+
+	l_dbus_message_builder_append_basic(builder, 's', category);
+	return true;
+}
+
+static bool p2p_peer_get_subcategory(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct p2p_peer *peer =3D user_data;
+	const char *subcategory;
+
+	/*
+	 * Should we generate subcategory strings with the numerical
+	 * values for the subcategories we don't know, such as
+	 * "Vendor-specific 00:11:22:33 44" ?
+	 */
+
+	if (!wsc_device_type_to_dbus_str(&peer->primary_device_type,
+						NULL, &subcategory) ||
+			!subcategory)
+		return false;
+
+	l_dbus_message_builder_append_basic(builder, 's', subcategory);
+	return true;
+}
+
 static bool p2p_peer_get_connected(struct l_dbus *dbus,
 					struct l_dbus_message *message,
 					struct l_dbus_message_builder *builder,
@@ -316,6 +357,10 @@ static void p2p_peer_interface_setup(struct l_dbus_int=
erface *interface)
 {
 	l_dbus_interface_property(interface, "Name", 0, "s",
 					p2p_peer_get_name, NULL);
+	l_dbus_interface_property(interface, "DeviceCategory", 0, "s",
+					p2p_peer_get_category, NULL);
+	l_dbus_interface_property(interface, "DeviceSubcategory", 0, "s",
+					p2p_peer_get_subcategory, NULL);
 	l_dbus_interface_property(interface, "Connected", 0, "b",
 					p2p_peer_get_connected, NULL);
 }
-- =

2.20.1

--===============4523674090990469112==--

