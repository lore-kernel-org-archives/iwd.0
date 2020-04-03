Content-Type: multipart/mixed; boundary="===============3221205483776490758=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 05/17] p2p: Add main device settings
Date: Fri, 03 Apr 2020 18:14:18 +0200
Message-ID: <20200403161430.14168-5-andrew.zaborowski@intel.com>
In-Reply-To: <20200403161430.14168-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3221205483776490758==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Read the country code (for channel operating classes), WSC configuration
methods and the Primary Device Type from the config file and expose
device name as a property.
---
 src/p2p.c | 189 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 189 insertions(+)

diff --git a/src/p2p.c b/src/p2p.c
index 49111a98..ab21239d 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -60,7 +60,10 @@ struct p2p_device {
 	uint8_t addr[6];
 	struct wiphy *wiphy;
 	unsigned int connections_left;
+	struct p2p_capability_attr capability;
+	struct p2p_device_info_attr device_info;
 =

+	uint8_t country[3];
 	struct l_queue *peer_list;
 };
 =

@@ -276,6 +279,9 @@ struct p2p_device *p2p_device_update_from_genl(struct l=
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
@@ -345,8 +351,148 @@ struct p2p_device *p2p_device_update_from_genl(struct=
 l_genl_msg *msg,
 	dev->wdev_id =3D *wdev_id;
 	memcpy(dev->addr, ifaddr, ETH_ALEN);
 	dev->wiphy =3D wiphy;
+	gethostname(hostname, sizeof(hostname));
 	dev->connections_left =3D 1;
 =

+	dev->country[0] =3D 'X';
+	dev->country[1] =3D 'X';
+	dev->country[2] =3D 4;	/* Table E-4 */
+
+	str =3D l_settings_get_string(iwd_get_config(), "General", "CountryCode");
+	if (str) {
+		if (strlen(str) !=3D 2)
+			l_error("[General].CountryCode must be a 2-character "
+				"string");
+		else {
+			dev->country[0] =3D str[0];
+			dev->country[1] =3D str[1];
+		}
+
+		l_free(str);
+	}
+
+	/* TODO: allow masking capability bits through a setting? */
+	dev->capability.device_caps =3D P2P_DEVICE_CAP_CONCURRENT_OP;
+	dev->capability.group_caps =3D 0;
+
+	memcpy(dev->device_info.device_addr, dev->addr, 6);
+
+	dev->device_info.wsc_config_methods =3D
+		WSC_CONFIGURATION_METHOD_LABEL |
+		WSC_CONFIGURATION_METHOD_KEYPAD |
+		WSC_CONFIGURATION_METHOD_VIRTUAL_PUSH_BUTTON |
+		WSC_CONFIGURATION_METHOD_PHYSICAL_PUSH_BUTTON |
+		WSC_CONFIGURATION_METHOD_P2P |
+		WSC_CONFIGURATION_METHOD_VIRTUAL_DISPLAY_PIN |
+		WSC_CONFIGURATION_METHOD_PHYSICAL_DISPLAY_PIN;
+	dev->device_info.primary_device_type.category =3D 1;	/* Computer */
+	memcpy(dev->device_info.primary_device_type.oui, microsoft_oui, 3);
+	dev->device_info.primary_device_type.oui_type =3D 0x04;
+	dev->device_info.primary_device_type.subcategory =3D 1;	/* PC */
+	l_strlcpy(dev->device_info.device_name, hostname,
+			sizeof(dev->device_info.device_name));
+
+	/* TODO: possibly interpret a list of strings of config method names */
+	if (l_settings_get_uint(iwd_get_config(), "P2P",
+				"ConfigurationMethodMask", &uint_val)) {
+		if (!(dev->device_info.wsc_config_methods & uint_val))
+			l_error("[P2P].ConfigurationMethodMask must contain "
+				"at least one supported method");
+		else if (uint_val & ~0xffff)
+			l_error("[P2P].ConfigurationMethodMask should be a "
+				"16-bit integer");
+		else
+			dev->device_info.wsc_config_methods &=3D uint_val;
+	}
+
+	str =3D l_settings_get_string(iwd_get_config(), "P2P", "DeviceCategory");
+	if (str) {
+		unsigned int i;
+		char *endp;
+
+		i =3D strtoul(str, &endp, 0);
+
+		if (*endp =3D=3D '\0') {
+			if (i < 1 || i > 255) {
+				l_error("[P2P].DeviceCategory must be in the "
+					"range 1-255");
+				i =3D 0;
+			}
+		} else if (!strcmp(str, "Other"))
+			i =3D 255;
+		else {
+			for (i =3D 0; i < L_ARRAY_SIZE(device_type_categories);
+					i++) {
+				struct device_type_category_info *cat_info =3D
+					&device_type_categories[i];
+
+				if (!cat_info->category_str)
+					continue;
+
+				if (strcasecmp(str, cat_info->category_str))
+					continue;
+
+				break;
+			}
+
+			if (i =3D=3D L_ARRAY_SIZE(device_type_categories)) {
+				l_error("Unkown [P2P].DeviceCategory %s", str);
+				i =3D 0;
+			}
+		}
+
+		if (i)
+			dev->device_info.primary_device_type.category =3D i;
+	}
+
+	str =3D l_settings_get_string(iwd_get_config(), "P2P",
+					"DeviceSubcategory");
+	if (str) {
+		unsigned int i;
+		char *endp;
+		unsigned int category =3D
+			dev->device_info.primary_device_type.category;
+		struct device_type_category_info *cat_info =3D
+			&device_type_categories[category];
+
+		i =3D strtoul(str, &endp, 0);
+
+		if (*endp =3D=3D '\0') {
+			if (i < 1 || i > 255) {
+				l_error("[P2P].DeviceSubcategory must be in "
+					"the range 1-255");
+				i =3D 0;
+			}
+		} else if (!strcmp(str, "Other"))
+			i =3D 255;
+		else if (category < L_ARRAY_SIZE(device_type_categories) &&
+				cat_info->subcategory_max) {
+			for (i =3D 0; i <=3D cat_info->subcategory_max; i++) {
+				if (!cat_info->subcategory_str[i])
+					continue;
+
+				if (strcasecmp(str,
+						cat_info->subcategory_str[i]))
+					continue;
+
+				break;
+			}
+
+			if (i > cat_info->subcategory_max) {
+				l_error("Unkown [P2P].DeviceSubcategory %s",
+					str);
+				i =3D 0;
+			}
+		} else {
+			l_error("Only numeric [P2P].DeviceSubcategory values "
+				"allowed for this category");
+			i =3D 0;
+		}
+
+		if (i)
+			dev->device_info.primary_device_type.subcategory =3D i;
+	}
+
 	l_queue_push_tail(p2p_device_list, dev);
 =

 	l_debug("Created P2P device %" PRIx64, dev->wdev_id);
@@ -378,6 +524,46 @@ bool p2p_device_destroy(struct p2p_device *dev)
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
+	l_strlcpy(dev->device_info.device_name, new_name,
+			sizeof(dev->device_info.device_name));
+	l_dbus_property_changed(dbus, p2p_device_get_path(dev),
+				IWD_P2P_INTERFACE, "Name");
+
+done:
+	complete(dbus, message, NULL);
+	return NULL;
+}
+
 static bool p2p_device_get_avail_conns(struct l_dbus *dbus,
 					struct l_dbus_message *message,
 					struct l_dbus_message_builder *builder,
@@ -430,6 +616,9 @@ static struct l_dbus_message *p2p_device_get_peers(stru=
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

--===============3221205483776490758==--

