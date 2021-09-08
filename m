Content-Type: multipart/mixed; boundary="===============3289249638927126539=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/5] hwsim: add PrefixOffset rule property
Date: Wed, 08 Sep 2021 15:47:40 -0700
Message-ID: <20210908224744.102156-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3289249638927126539==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If set, a rule will start matching a prefix some number of bytes
into the frame. This is useful since header information, addresses,
and sequence numbers may be unpredictable between test runs.
---
 tools/hwsim.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/tools/hwsim.c b/tools/hwsim.c
index 8fb9b0a4..9a7a90a9 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -132,6 +132,7 @@ struct hwsim_rule {
 	int delay;
 	uint8_t *prefix;
 	size_t prefix_len;
+	uint16_t prefix_offset;
 	int match_times; /* negative value indicates unused */
 };
 =

@@ -1212,8 +1213,13 @@ static void process_rules(const struct radio_info_re=
c *src_radio,
 		if (rule->frequency && rule->frequency !=3D frame->frequency)
 			continue;
 =

-		if (rule->prefix && frame->payload_len >=3D rule->prefix_len) {
-			if (memcmp(rule->prefix, frame->payload,
+		if (rule->prefix) {
+			if (frame->payload_len <
+					rule->prefix_len + rule->prefix_offset)
+				continue;
+
+			if (memcmp(rule->prefix,
+					frame->payload + rule->prefix_offset,
 					rule->prefix_len) !=3D 0)
 				continue;
 		}
@@ -2394,6 +2400,37 @@ invalid_args:
 	return dbus_error_invalid_args(message);
 }
 =

+static bool rule_property_get_prefix_offset(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct hwsim_rule *rule =3D user_data;
+	uint16_t val =3D rule->prefix_offset;
+
+	l_dbus_message_builder_append_basic(builder, 'q', &val);
+
+	return true;
+}
+
+static struct l_dbus_message *rule_property_set_prefix_offset(
+					struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_iter *new_value,
+					l_dbus_property_complete_cb_t complete,
+					void *user_data)
+{
+	struct hwsim_rule *rule =3D user_data;
+	uint16_t val;
+
+	if (!l_dbus_message_iter_get_variant(new_value, "q", &val))
+		return dbus_error_invalid_args(message);
+
+	rule->prefix_offset =3D val;
+
+	return l_dbus_message_new_method_return(message);
+}
+
 static bool rule_property_get_enabled(struct l_dbus *dbus,
 					struct l_dbus_message *message,
 					struct l_dbus_message_builder *builder,
@@ -2527,6 +2564,10 @@ static void setup_rule_interface(struct l_dbus_inter=
face *interface)
 					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "ay",
 					rule_property_get_prefix,
 					rule_property_set_prefix);
+	l_dbus_interface_property(interface, "PrefixOffset",
+					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "q",
+					rule_property_get_prefix_offset,
+					rule_property_set_prefix_offset);
 	l_dbus_interface_property(interface, "Enabled",
 					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "b",
 					rule_property_get_enabled,
-- =

2.31.1

--===============3289249638927126539==--

