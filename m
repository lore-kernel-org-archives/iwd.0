Content-Type: multipart/mixed; boundary="===============6134830089624393792=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/6] hwsim: add MatchBytes/MatchBytesOffset rule properties
Date: Thu, 09 Sep 2021 15:08:43 -0700
Message-ID: <20210909220848.19376-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6134830089624393792==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If set, a rule will start matching 'MatchBytes' some number of bytes
into the frame (MatchBytesOffset). This is useful since header
information, addresses, and sequence numbers may be unpredictable
between test runs.

To avoid unintended matches the Prefix property is left unchanged
and will match starting at the beginning of the frame.
---
 tools/hwsim.c | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/tools/hwsim.c b/tools/hwsim.c
index 8fb9b0a4..2352dcce 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -132,6 +132,9 @@ struct hwsim_rule {
 	int delay;
 	uint8_t *prefix;
 	size_t prefix_len;
+	uint8_t *match;
+	size_t match_len;
+	uint16_t match_offset;
 	int match_times; /* negative value indicates unused */
 };
 =

@@ -1218,6 +1221,14 @@ static void process_rules(const struct radio_info_re=
c *src_radio,
 				continue;
 		}
 =

+		if (rule->match && frame->payload_len >=3D
+					rule->match_len + rule->match_offset) {
+			if (memcmp(rule->match,
+					frame->payload + rule->match_offset,
+					rule->match_len))
+				continue;
+		}
+
 		/* Rule deemed to match frame, apply any changes */
 		if (rule->match_times =3D=3D 0)
 			continue;
@@ -2063,6 +2074,9 @@ static struct l_dbus_message *rule_remove(struct l_db=
us *dbus,
 	if (rule->prefix)
 		l_free(rule->prefix);
 =

+	if (rule->match)
+		l_free(rule->match);
+
 	l_free(rule);
 	l_dbus_unregister_object(dbus, path);
 =

@@ -2394,6 +2408,90 @@ invalid_args:
 	return dbus_error_invalid_args(message);
 }
 =

+static bool rule_property_get_match(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct hwsim_rule *rule =3D user_data;
+	size_t i;
+
+	l_dbus_message_builder_enter_array(builder, "y");
+
+	for (i =3D 0; i < rule->match_len; i++)
+		l_dbus_message_builder_append_basic(builder, 'y',
+							rule->match + i);
+
+	l_dbus_message_builder_leave_array(builder);
+
+	return true;
+}
+
+static struct l_dbus_message *rule_property_set_match(
+					struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_iter *new_value,
+					l_dbus_property_complete_cb_t complete,
+					void *user_data)
+{
+	struct hwsim_rule *rule =3D user_data;
+	struct l_dbus_message_iter iter;
+	const uint8_t *match;
+	uint32_t len;
+
+	if (!l_dbus_message_iter_get_variant(new_value, "ay", &iter))
+		goto invalid_args;
+
+	if (!l_dbus_message_iter_get_fixed_array(&iter,
+						(const void **)&match, &len))
+		goto invalid_args;
+
+	if (len > HWSIM_MAX_PREFIX_LEN)
+		goto invalid_args;
+
+	if (rule->match)
+		l_free(rule->match);
+
+	rule->match =3D l_memdup(match, len);
+	rule->match_len =3D len;
+
+	return l_dbus_message_new_method_return(message);
+
+invalid_args:
+	return dbus_error_invalid_args(message);
+}
+
+static bool rule_property_get_match_offset(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct hwsim_rule *rule =3D user_data;
+	uint16_t val =3D rule->match_offset;
+
+	l_dbus_message_builder_append_basic(builder, 'q', &val);
+
+	return true;
+}
+
+static struct l_dbus_message *rule_property_set_match_offset(
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
+	rule->match_offset =3D val;
+
+	return l_dbus_message_new_method_return(message);
+}
+
 static bool rule_property_get_enabled(struct l_dbus *dbus,
 					struct l_dbus_message *message,
 					struct l_dbus_message_builder *builder,
@@ -2527,6 +2625,14 @@ static void setup_rule_interface(struct l_dbus_inter=
face *interface)
 					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "ay",
 					rule_property_get_prefix,
 					rule_property_set_prefix);
+	l_dbus_interface_property(interface, "MatchBytes",
+					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "ay",
+					rule_property_get_match,
+					rule_property_set_match);
+	l_dbus_interface_property(interface, "MatchBytesOffset",
+					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "q",
+					rule_property_get_match_offset,
+					rule_property_set_match_offset);
 	l_dbus_interface_property(interface, "Enabled",
 					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "b",
 					rule_property_get_enabled,
-- =

2.31.1

--===============6134830089624393792==--

