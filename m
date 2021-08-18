Content-Type: multipart/mixed; boundary="===============7788151338162618216=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/8] hwsim: require enabling rule before use
Date: Wed, 18 Aug 2021 15:09:28 -0700
Message-ID: <20210818220934.295721-2-prestwoj@gmail.com>
In-Reply-To: <20210818220934.295721-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7788151338162618216==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The hwsim Rule API was structured as properties so once a rule is
created it automatically starts being applied to frames. This happens
before anything has time to actually define the rule (source, destination
etc). This leads to every single frame being matched to the rule until
these other properties are added, which can result in unexpected behavior.

To fix this an "Enabled" property has been added and the rule will not
be applied until this is true.
---
 tools/hwsim.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/hwsim.c b/tools/hwsim.c
index fcb83248..c7b41750 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -124,6 +124,7 @@ struct hwsim_rule {
 	bool destination_any : 1;
 	bool bidirectional : 1;
 	bool drop : 1;
+	bool enabled : 1;
 	uint32_t frequency;
 	int priority;
 	int signal;
@@ -1177,6 +1178,9 @@ static void process_rules(const struct radio_info_rec=
 *src_radio,
 			rule_entry =3D rule_entry->next) {
 		struct hwsim_rule *rule =3D rule_entry->data;
 =

+		if (!rule->enabled)
+			return;
+
 		if (!rule->source_any &&
 				!radio_match_addr(src_radio, rule->source) &&
 				(!rule->bidirectional ||
@@ -1996,6 +2000,7 @@ static struct l_dbus_message *rule_add(struct l_dbus =
*dbus,
 	rule->source_any =3D true;
 	rule->destination_any =3D true;
 	rule->delay =3D HWSIM_DELAY_MIN_MS;
+	rule->enabled =3D false;
 =

 	if (!rules)
 		rules =3D l_queue_new();
@@ -2369,6 +2374,37 @@ invalid_args:
 	return dbus_error_invalid_args(message);
 }
 =

+static bool rule_property_get_enabled(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct hwsim_rule *rule =3D user_data;
+	bool bval =3D rule->enabled;
+
+	l_dbus_message_builder_append_basic(builder, 'b', &bval);
+
+	return true;
+}
+
+static struct l_dbus_message *rule_property_set_enabled(
+					struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_iter *new_value,
+					l_dbus_property_complete_cb_t complete,
+					void *user_data)
+{
+	struct hwsim_rule *rule =3D user_data;
+	bool bval;
+
+	if (!l_dbus_message_iter_get_variant(new_value, "b", &bval))
+		return dbus_error_invalid_args(message);
+
+	rule->enabled =3D bval;
+
+	return l_dbus_message_new_method_return(message);
+}
+
 static void setup_rule_interface(struct l_dbus_interface *interface)
 {
 	l_dbus_interface_method(interface, "Remove", 0, rule_remove, "", "");
@@ -2409,6 +2445,10 @@ static void setup_rule_interface(struct l_dbus_inter=
face *interface)
 					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "ay",
 					rule_property_get_prefix,
 					rule_property_set_prefix);
+	l_dbus_interface_property(interface, "Enabled",
+					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "b",
+					rule_property_get_enabled,
+					rule_property_set_enabled);
 }
 =

 static void request_name_callback(struct l_dbus *dbus, bool success,
-- =

2.31.1

--===============7788151338162618216==--

