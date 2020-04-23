Content-Type: multipart/mixed; boundary="===============1683749225570818391=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 04/19] p2p: Add main device settings
Date: Thu, 23 Apr 2020 18:24:32 +0200
Message-ID: <20200423162447.15750-4-andrew.zaborowski@intel.com>
In-Reply-To: <20200423162447.15750-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1683749225570818391==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Read WSC configuration methods and the Primary Device Type from the
config file and expose device name as a property.
---
 src/p2p.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/src/p2p.c b/src/p2p.c
index 52ad2808..030224e1 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -60,6 +60,8 @@ struct p2p_device {
 	uint8_t addr[6];
 	struct wiphy *wiphy;
 	unsigned int connections_left;
+	struct p2p_capability_attr capability;
+	struct p2p_device_info_attr device_info;
 =

 	struct l_queue *peer_list;
 };
@@ -121,6 +123,15 @@ static void p2p_peer_put(void *user_data)
 	p2p_peer_free(peer);
 }
 =

+#define P2P_SUPPORTED_METHODS	(			\
+	WSC_CONFIGURATION_METHOD_LABEL |		\
+	WSC_CONFIGURATION_METHOD_KEYPAD |		\
+	WSC_CONFIGURATION_METHOD_VIRTUAL_PUSH_BUTTON |	\
+	WSC_CONFIGURATION_METHOD_PHYSICAL_PUSH_BUTTON |	\
+	WSC_CONFIGURATION_METHOD_P2P |			\
+	WSC_CONFIGURATION_METHOD_VIRTUAL_DISPLAY_PIN |	\
+	WSC_CONFIGURATION_METHOD_PHYSICAL_DISPLAY_PIN)
+
 struct p2p_device *p2p_device_update_from_genl(struct l_genl_msg *msg,
 						bool create)
 {
@@ -131,6 +142,9 @@ struct p2p_device *p2p_device_update_from_genl(struct l=
_genl_msg *msg,
 	const uint64_t *wdev_id =3D NULL;
 	struct wiphy *wiphy =3D NULL;
 	struct p2p_device *dev;
+	char hostname[HOST_NAME_MAX + 1];
+	char *str;
+	unsigned int uint_val;
 =

 	if (!l_genl_attr_init(&attr, msg))
 		return NULL;
@@ -200,8 +214,78 @@ struct p2p_device *p2p_device_update_from_genl(struct =
l_genl_msg *msg,
 	dev->wdev_id =3D *wdev_id;
 	memcpy(dev->addr, ifaddr, ETH_ALEN);
 	dev->wiphy =3D wiphy;
+	gethostname(hostname, sizeof(hostname));
 	dev->connections_left =3D 1;
 =

+	/* TODO: allow masking capability bits through a setting? */
+	dev->capability.device_caps =3D P2P_DEVICE_CAP_CONCURRENT_OP;
+	dev->capability.group_caps =3D 0;
+
+	memcpy(dev->device_info.device_addr, dev->addr, 6);
+
+	dev->device_info.wsc_config_methods =3D
+		WSC_CONFIGURATION_METHOD_P2P |
+		WSC_CONFIGURATION_METHOD_PUSH_BUTTON;
+	dev->device_info.primary_device_type.category =3D 1;	/* Computer */
+	memcpy(dev->device_info.primary_device_type.oui, microsoft_oui, 3);
+	dev->device_info.primary_device_type.oui_type =3D 0x04;
+	dev->device_info.primary_device_type.subcategory =3D 1;	/* PC */
+	l_strlcpy(dev->device_info.device_name, hostname,
+			sizeof(dev->device_info.device_name));
+
+	if (l_settings_get_uint(iwd_get_config(), "P2P",
+				"ConfigurationMethods", &uint_val)) {
+		if (!(uint_val & P2P_SUPPORTED_METHODS))
+			l_error("[P2P].ConfigurationMethods must contain "
+				"at least one supported method");
+		else if (uint_val & ~0xffff)
+			l_error("[P2P].ConfigurationMethods should be a "
+				"16-bit integer");
+		else
+			dev->device_info.wsc_config_methods =3D
+				uint_val & P2P_SUPPORTED_METHODS;
+	}
+
+	str =3D l_settings_get_string(iwd_get_config(), "P2P", "DeviceType");
+
+	/*
+	 * Standard WSC subcategories are unique and more specific than
+	 * categories so there's no point for the user to specify the
+	 * category if they choose to use the string format.
+	 *
+	 * As an example our default value (Computer - PC) can be
+	 * encoded as either of:
+	 *
+	 * DeviceType=3Dpc
+	 * DeviceType=3D0x00010050f2040001
+	 */
+	if (str && !wsc_device_type_from_subcategory_str(
+					&dev->device_info.primary_device_type,
+					str)) {
+		unsigned long long u;
+		char *endp;
+
+		u =3D strtoull(str, &endp, 0);
+
+		/*
+		 * Accept any custom category, OUI and subcategory values but
+		 * require non-zero category as a sanity check.
+		 */
+		if (*endp !=3D '\0' || (u & 0xffff000000000000ll) =3D=3D 0)
+			l_error("[P2P].DeviceType must be a subcategory string "
+				"or a 64-bit integer encoding the full Primary"
+				" Device Type attribute: "
+				"<Category>|<OUI>|<OUI Type>|<Subcategory>");
+		else {
+			dev->device_info.primary_device_type.category =3D u >> 48;
+			dev->device_info.primary_device_type.oui[0] =3D u >> 40;
+			dev->device_info.primary_device_type.oui[1] =3D u >> 32;
+			dev->device_info.primary_device_type.oui[2] =3D u >> 24;
+			dev->device_info.primary_device_type.oui_type =3D u >> 16;
+			dev->device_info.primary_device_type.subcategory =3D u;
+		}
+	}
+
 	l_queue_push_tail(p2p_device_list, dev);
 =

 	l_debug("Created P2P device %" PRIx64, dev->wdev_id);
@@ -233,6 +317,51 @@ bool p2p_device_destroy(struct p2p_device *dev)
 	return true;
 }
 =

+static bool p2p_device_get_name(struct l_dbus *dbus,
+				struct l_dbus_message *message,
+				struct l_dbus_message_builder *builder,
+				void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+
+	l_dbus_message_builder_append_basic(builder, 's',
+						dev->device_info.device_name);
+	return true;
+}
+
+static struct l_dbus_message *p2p_device_set_name(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_iter *new_value,
+					l_dbus_property_complete_cb_t complete,
+					void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+	const char *new_name;
+	bool changed =3D false;
+
+	if (!l_dbus_message_iter_get_variant(new_value, "s", &new_name))
+		return dbus_error_invalid_args(message);
+
+	if (!strcmp(new_name, dev->device_info.device_name))
+		goto done;
+
+	if (strlen(new_name) > sizeof(dev->device_info.device_name) - 1)
+		return dbus_error_invalid_args(message);
+
+	changed =3D true;
+	l_strlcpy(dev->device_info.device_name, new_name,
+			sizeof(dev->device_info.device_name));
+
+done:
+	complete(dbus, message, NULL);
+
+	if (changed)
+		l_dbus_property_changed(dbus, p2p_device_get_path(dev),
+					IWD_P2P_INTERFACE, "Name");
+
+	return NULL;
+}
+
 static bool p2p_device_get_avail_conns(struct l_dbus *dbus,
 					struct l_dbus_message *message,
 					struct l_dbus_message_builder *builder,
@@ -285,6 +414,9 @@ static struct l_dbus_message *p2p_device_get_peers(stru=
ct l_dbus *dbus,
 =

 static void p2p_interface_setup(struct l_dbus_interface *interface)
 {
+	l_dbus_interface_property(interface, "Name", 0, "s",
+					p2p_device_get_name,
+					p2p_device_set_name);
 	l_dbus_interface_property(interface, "AvailableConnections", 0, "q",
 					p2p_device_get_avail_conns, NULL);
 	l_dbus_interface_method(interface, "GetPeers", 0,
-- =

2.20.1

--===============1683749225570818391==--

