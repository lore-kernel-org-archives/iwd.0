Content-Type: multipart/mixed; boundary="===============5273787609813725292=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/5] hwsim: add Prefix match rule support
Date: Mon, 05 Apr 2021 15:40:24 -0700
Message-ID: <20210405224027.1052197-2-prestwoj@gmail.com>
In-Reply-To: <20210405224027.1052197-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5273787609813725292==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hwsim rules now have a 'Prefix' property which will allow
matching frames based on their payload data.
---
 tools/hwsim.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/hwsim.c b/tools/hwsim.c
index 08198b56..fcb83248 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -114,6 +114,7 @@ enum hwsim_tx_control_flags {
 =

 #define IEEE80211_TX_RATE_TABLE_SIZE	4
 #define HWSIM_DELAY_MIN_MS		1
+#define HWSIM_MAX_PREFIX_LEN		128
 =

 struct hwsim_rule {
 	unsigned int id;
@@ -127,6 +128,8 @@ struct hwsim_rule {
 	int priority;
 	int signal;
 	int delay;
+	uint8_t *prefix;
+	size_t prefix_len;
 };
 =

 struct hwsim_support {
@@ -1203,6 +1206,12 @@ static void process_rules(const struct radio_info_re=
c *src_radio,
 		if (rule->frequency && rule->frequency !=3D frame->frequency)
 			continue;
 =

+		if (rule->prefix && frame->payload_len >=3D rule->prefix_len) {
+			if (memcmp(rule->prefix, frame->payload,
+					rule->prefix_len) !=3D 0)
+				continue;
+		}
+
 		/* Rule deemed to match frame, apply any changes */
 =

 		if (rule->signal)
@@ -2025,6 +2034,10 @@ static struct l_dbus_message *rule_remove(struct l_d=
bus *dbus,
 =

 	path =3D rule_get_path(rule);
 	l_queue_remove(rules, rule);
+
+	if (rule->prefix)
+		l_free(rule->prefix);
+
 	l_free(rule);
 	l_dbus_unregister_object(dbus, path);
 =

@@ -2303,6 +2316,59 @@ static struct l_dbus_message *rule_property_set_dela=
y(
 	return l_dbus_message_new_method_return(message);
 }
 =

+static bool rule_property_get_prefix(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct hwsim_rule *rule =3D user_data;
+	size_t i;
+
+	l_dbus_message_builder_enter_array(builder, "y");
+
+	for (i =3D 0; i < rule->prefix_len; i++)
+		l_dbus_message_builder_append_basic(builder, 'y',
+							rule->prefix + i);
+
+	l_dbus_message_builder_leave_array(builder);
+
+	return true;
+}
+
+static struct l_dbus_message *rule_property_set_prefix(
+					struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_iter *new_value,
+					l_dbus_property_complete_cb_t complete,
+					void *user_data)
+{
+	struct hwsim_rule *rule =3D user_data;
+	struct l_dbus_message_iter iter;
+	const uint8_t *prefix;
+	uint32_t len;
+
+	if (!l_dbus_message_iter_get_variant(new_value, "ay", &iter))
+		goto invalid_args;
+
+	if (!l_dbus_message_iter_get_fixed_array(&iter,
+						(const void **)&prefix, &len))
+		goto invalid_args;
+
+	if (len > HWSIM_MAX_PREFIX_LEN)
+		goto invalid_args;
+
+	if (rule->prefix)
+		l_free(rule->prefix);
+
+	rule->prefix =3D l_memdup(prefix, len);
+	rule->prefix_len =3D len;
+
+	return l_dbus_message_new_method_return(message);
+
+invalid_args:
+	return dbus_error_invalid_args(message);
+}
+
 static void setup_rule_interface(struct l_dbus_interface *interface)
 {
 	l_dbus_interface_method(interface, "Remove", 0, rule_remove, "", "");
@@ -2339,6 +2405,10 @@ static void setup_rule_interface(struct l_dbus_inter=
face *interface)
 					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "u",
 					rule_property_get_delay,
 					rule_property_set_delay);
+	l_dbus_interface_property(interface, "Prefix",
+					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "ay",
+					rule_property_get_prefix,
+					rule_property_set_prefix);
 }
 =

 static void request_name_callback(struct l_dbus *dbus, bool success,
-- =

2.26.2

--===============5273787609813725292==--

