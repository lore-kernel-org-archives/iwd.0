Content-Type: multipart/mixed; boundary="===============6332061678966201766=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/9] hwsim: add DropAck rule property
Date: Tue, 07 Sep 2021 14:14:44 -0700
Message-ID: <20210907211450.27270-3-prestwoj@gmail.com>
In-Reply-To: <20210907211450.27270-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6332061678966201766==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The hwsim rules did not treat frames and ACKs any differently which
can mislead the developer especially when setting a rule prefix.
If a prefix was used the frame ACK was actually being matched against
the original frame payload which seems wrong because the ACK is not
the original frame.

Though strange, matching the frame prefix on an ACK has its place if
the developer wants to block just the ACK rather than the frame so
to make this case more clear 'DropAck' was added as a rule property.
And only if this is true will an ACK be checked and potentially
dropped.

To maintain the current hwsim behavior DropAck will default to true.
---
 tools/hwsim.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/tools/hwsim.c b/tools/hwsim.c
index 18ba111a..8fb9b0a4 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -124,6 +124,7 @@ struct hwsim_rule {
 	bool destination_any : 1;
 	bool bidirectional : 1;
 	bool drop : 1;
+	bool drop_ack : 1;
 	bool enabled : 1;
 	uint32_t frequency;
 	int priority;
@@ -1170,7 +1171,7 @@ static bool radio_match_addr(const struct radio_info_=
rec *radio,
 =

 static void process_rules(const struct radio_info_rec *src_radio,
 				const struct radio_info_rec *dst_radio,
-				struct hwsim_frame *frame, bool *drop,
+				struct hwsim_frame *frame, bool ack, bool *drop,
 				uint32_t *delay)
 {
 	const struct l_queue_entry *rule_entry;
@@ -1224,7 +1225,9 @@ static void process_rules(const struct radio_info_rec=
 *src_radio,
 		if (rule->signal)
 			frame->signal =3D rule->signal / 100;
 =

-		*drop =3D rule->drop;
+		/* Don't drop if this is an ACK, unless drop_ack is set */
+		if (!ack || (ack && rule->drop_ack))
+			*drop =3D rule->drop;
 =

 		if (delay)
 			*delay =3D rule->delay;
@@ -1314,7 +1317,7 @@ static void hwsim_frame_unref(struct hwsim_frame *fra=
me)
 			bool drop =3D false;
 =

 			process_rules(frame->ack_radio, frame->src_radio,
-					frame, &drop, NULL);
+					frame, true, &drop, NULL);
 =

 			if (!drop)
 				frame->flags |=3D HWSIM_TX_STAT_ACK;
@@ -1458,7 +1461,8 @@ static void process_frame(struct hwsim_frame *frame)
 	bool drop_mcast =3D false;
 =

 	if (util_is_broadcast_address(frame->dst_ether_addr))
-		process_rules(frame->src_radio, NULL, frame, &drop_mcast, NULL);
+		process_rules(frame->src_radio, NULL, frame, false,
+				&drop_mcast, NULL);
 =

 	for (entry =3D l_queue_get_entries(radio_info); entry;
 			entry =3D entry->next) {
@@ -1498,7 +1502,8 @@ static void process_frame(struct hwsim_frame *frame)
 				continue;
 		}
 =

-		process_rules(frame->src_radio, radio, frame, &drop, &delay);
+		process_rules(frame->src_radio, radio, frame, false,
+				&drop, &delay);
 =

 		if (drop)
 			continue;
@@ -2015,6 +2020,7 @@ static struct l_dbus_message *rule_add(struct l_dbus =
*dbus,
 	rule->delay =3D 0;
 	rule->enabled =3D false;
 	rule->match_times =3D -1;
+	rule->drop_ack =3D true;
 =

 	if (!rules)
 		rules =3D l_queue_new();
@@ -2450,6 +2456,37 @@ static struct l_dbus_message *rule_property_set_matc=
h_times(
 	return l_dbus_message_new_method_return(message);
 }
 =

+static bool rule_property_get_drop_ack(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct hwsim_rule *rule =3D user_data;
+	bool bval =3D rule->drop_ack;
+
+	l_dbus_message_builder_append_basic(builder, 'b', &bval);
+
+	return true;
+}
+
+static struct l_dbus_message *rule_property_set_drop_ack(
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
+	rule->drop_ack =3D bval;
+
+	return l_dbus_message_new_method_return(message);
+}
+
 static void setup_rule_interface(struct l_dbus_interface *interface)
 {
 	l_dbus_interface_method(interface, "Remove", 0, rule_remove, "", "");
@@ -2498,6 +2535,10 @@ static void setup_rule_interface(struct l_dbus_inter=
face *interface)
 					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "q",
 					rule_property_get_match_times,
 					rule_property_set_match_times);
+	l_dbus_interface_property(interface, "DropAck",
+					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "b",
+					rule_property_get_drop_ack,
+					rule_property_set_drop_ack);
 }
 =

 static void request_name_callback(struct l_dbus *dbus, bool success,
-- =

2.31.1

--===============6332061678966201766==--

