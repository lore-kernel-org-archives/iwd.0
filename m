Content-Type: multipart/mixed; boundary="===============4070496237346598705=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/9] hwsim: add MatchTimes property
Date: Tue, 07 Sep 2021 14:14:42 -0700
Message-ID: <20210907211450.27270-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4070496237346598705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This integer property can be set to only match a rule a number of
times rather than all packets. This is useful for testing behavior
of a single dropped frame or ack. Once the rule has been matched
'MatchTimes' the rules will no longer be applied (unless set again
to some integer greater than zero).
---
 tools/hwsim.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/hwsim.c b/tools/hwsim.c
index cd4a99b7..18ba111a 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -131,6 +131,7 @@ struct hwsim_rule {
 	int delay;
 	uint8_t *prefix;
 	size_t prefix_len;
+	int match_times; /* negative value indicates unused */
 };
 =

 struct hwsim_support {
@@ -1217,6 +1218,8 @@ static void process_rules(const struct radio_info_rec=
 *src_radio,
 		}
 =

 		/* Rule deemed to match frame, apply any changes */
+		if (rule->match_times =3D=3D 0)
+			continue;
 =

 		if (rule->signal)
 			frame->signal =3D rule->signal / 100;
@@ -1225,6 +1228,9 @@ static void process_rules(const struct radio_info_rec=
 *src_radio,
 =

 		if (delay)
 			*delay =3D rule->delay;
+
+		if (rule->match_times > 0)
+			rule->match_times--;
 	}
 }
 =

@@ -2008,6 +2014,7 @@ static struct l_dbus_message *rule_add(struct l_dbus =
*dbus,
 	rule->destination_any =3D true;
 	rule->delay =3D 0;
 	rule->enabled =3D false;
+	rule->match_times =3D -1;
 =

 	if (!rules)
 		rules =3D l_queue_new();
@@ -2412,6 +2419,37 @@ static struct l_dbus_message *rule_property_set_enab=
led(
 	return l_dbus_message_new_method_return(message);
 }
 =

+static bool rule_property_get_match_times(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct hwsim_rule *rule =3D user_data;
+	uint16_t val =3D rule->match_times;
+
+	l_dbus_message_builder_append_basic(builder, 'q', &val);
+
+	return true;
+}
+
+static struct l_dbus_message *rule_property_set_match_times(
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
+	rule->match_times =3D val;
+
+	return l_dbus_message_new_method_return(message);
+}
+
 static void setup_rule_interface(struct l_dbus_interface *interface)
 {
 	l_dbus_interface_method(interface, "Remove", 0, rule_remove, "", "");
@@ -2456,6 +2494,10 @@ static void setup_rule_interface(struct l_dbus_inter=
face *interface)
 					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "b",
 					rule_property_get_enabled,
 					rule_property_set_enabled);
+	l_dbus_interface_property(interface, "MatchTimes",
+					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "q",
+					rule_property_get_match_times,
+					rule_property_set_match_times);
 }
 =

 static void request_name_callback(struct l_dbus *dbus, bool success,
-- =

2.31.1

--===============4070496237346598705==--

