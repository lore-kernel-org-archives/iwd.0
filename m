Content-Type: multipart/mixed; boundary="===============0419665303311184595=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 04/17] p2p: Add peer WSC device type properties
Date: Fri, 03 Apr 2020 18:14:17 +0200
Message-ID: <20200403161430.14168-4-andrew.zaborowski@intel.com>
In-Reply-To: <20200403161430.14168-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0419665303311184595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/p2p.c | 208 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 208 insertions(+)

diff --git a/src/p2p.c b/src/p2p.c
index 957482eb..49111a98 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -68,10 +68,156 @@ struct p2p_peer {
 	struct scan_bss *bss;
 	struct p2p_device *dev;
 	char *name;
+	struct wsc_primary_device_type primary_device_type;
 };
 =

 static struct l_queue *p2p_device_list;
 =

+struct device_type_category_info {
+	char *category_str;
+	unsigned int subcategory_max;
+	char **subcategory_str;
+};
+
+/* Wi-Fi Simple Configuration Technical Specification v2.0.5 Table 41 */
+struct device_type_category_info device_type_categories[] =3D {
+	[1] =3D {
+		"Computer",
+		10,
+		(char *[]) {
+			[1] =3D "PC",
+			[2] =3D "Server",
+			[3] =3D "Media Center",
+			[4] =3D "Ultra-mobile PC",
+			[5] =3D "Notebook",
+			[6] =3D "Desktop",
+			[7] =3D "Mobile Internet Device",
+			[8] =3D "Netbook",
+			[9] =3D "Tablet",
+			[10] =3D "Ultrabook",
+		},
+	},
+	[2] =3D {
+		"Input Device",
+		9,
+		(char *[]) {
+			[1] =3D "Keyboard",
+			[2] =3D "Mouse",
+			[3] =3D "Joystick",
+			[4] =3D "Trackball",
+			[5] =3D "Gaming controller",
+			[6] =3D "Remote",
+			[7] =3D "Touchscreen",
+			[8] =3D "Biometric reader",
+			[9] =3D "Barcode reader",
+		},
+	},
+	[3] =3D {
+		"Printer or Scanner",
+		5,
+		(char *[]) {
+			[1] =3D "Printer/Print Server",
+			[2] =3D "Scanner",
+			[3] =3D "Fax",
+			[4] =3D "Copier",
+			[5] =3D "All-in-one printer, scanner, fax, copier",
+		},
+	},
+	[4] =3D {
+		"Camera",
+		4,
+		(char *[]) {
+			[1] =3D "Digital Still Camera",
+			[2] =3D "Video Camera",
+			[3] =3D "Web Camera",
+			[4] =3D "Security Camera",
+		},
+	},
+	[5] =3D {
+		"Storage",
+		1,
+		(char *[]) {
+			[1] =3D "NAS",
+		},
+	},
+	[6] =3D {
+		"Network Infrastructure",
+		5,
+		(char *[]) {
+			[1] =3D "AP",
+			[2] =3D "Router",
+			[3] =3D "Switch",
+			[4] =3D "Gateway",
+			[5] =3D "Bridge",
+		},
+	},
+	[7] =3D {
+		"Display",
+		4,
+		(char *[]) {
+			[1] =3D "Television",
+			[2] =3D "Electronic Picture Frame",
+			[3] =3D "Projector",
+			[4] =3D "Monitor",
+		},
+	},
+	[8] =3D {
+		"Multimedia Device",
+		6,
+		(char *[]) {
+			[1] =3D "DAR",
+			[2] =3D "PVR",
+			[3] =3D "MCX",
+			[4] =3D "Set-top box",
+			[5] =3D "Media Server/Adapter/Extender",
+			[6] =3D "Portable Video Player",
+		},
+	},
+	[9] =3D {
+		"Gaming device",
+		5,
+		(char *[]) {
+			[1] =3D "Xbox",
+			[2] =3D "Xbox360",
+			[3] =3D "Playstation",
+			[4] =3D "Game Console/Console Adapter",
+			[5] =3D "Portable Gaming Device",
+		},
+	},
+	[10] =3D {
+		"Telephone",
+		5,
+		(char *[]) {
+			[1] =3D "Windows Mobile",
+			[2] =3D "Single mode phone",
+			[3] =3D "Dual mode phone",
+			[4] =3D "Single mode smartphone",
+			[5] =3D "Dual mode smartphone",
+		},
+	},
+	[11] =3D {
+		"Audio Device",
+		7,
+		(char *[]) {
+			[1] =3D "Audio tuner/receiver",
+			[2] =3D "Speakers",
+			[3] =3D "Portable Music Player",
+			[4] =3D "Headset",
+			[5] =3D "Headphones",
+			[6] =3D "Microphone",
+			[7] =3D "Home Theater System",
+		},
+	},
+	[12] =3D {
+		"Docking Device",
+		2,
+		(char *[]) {
+			[1] =3D "Computer docking station",
+			[2] =3D "Media kiosk",
+		},
+	},
+};
+
 static bool p2p_device_match(const void *a, const void *b)
 {
 	const struct p2p_device *dev =3D a;
@@ -301,6 +447,64 @@ static bool p2p_peer_get_name(struct l_dbus *dbus,
 	return true;
 }
 =

+static bool p2p_peer_get_category(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct p2p_peer *peer =3D user_data;
+	uint16_t category_id =3D peer->primary_device_type.category;
+	const char *category =3D NULL;
+
+	if (category_id =3D=3D 255)
+		category =3D "Other";
+	else if (category_id < L_ARRAY_SIZE(device_type_categories))
+		category =3D device_type_categories[category_id].category_str;
+
+	if (!category)
+		category =3D "Unknown";
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
+	uint16_t category_id =3D peer->primary_device_type.category;
+	uint16_t subcategory_id =3D peer->primary_device_type.subcategory;
+	const char *subcategory;
+
+	/*
+	 * Should we generate subcategory strings with the numerical
+	 * values for the subcategories we don't know, such as
+	 * "Vendor-specific 00:11:22:33 44" ?
+	 */
+
+	if (memcmp(peer->primary_device_type.oui, microsoft_oui, 3) ||
+			peer->primary_device_type.oui_type !=3D 4)
+		return false;
+
+	if (category_id >=3D L_ARRAY_SIZE(device_type_categories))
+		return false;
+
+	if (!device_type_categories[category_id].subcategory_str ||
+			subcategory_id >
+			device_type_categories[category_id].subcategory_max)
+		return false;
+
+	subcategory =3D device_type_categories[category_id].
+		subcategory_str[subcategory_id];
+	if (!subcategory)
+		return false;
+
+	l_dbus_message_builder_append_basic(builder, 's', subcategory);
+	return true;
+}
+
 static bool p2p_peer_get_connected(struct l_dbus *dbus,
 					struct l_dbus_message *message,
 					struct l_dbus_message_builder *builder,
@@ -316,6 +520,10 @@ static void p2p_peer_interface_setup(struct l_dbus_int=
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

--===============0419665303311184595==--

