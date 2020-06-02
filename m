Content-Type: multipart/mixed; boundary="===============4503131660887463486=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 07/10] hwsim: add new 'Delay' property to Rules
Date: Tue, 02 Jun 2020 10:30:18 -0700
Message-ID: <20200602173021.20085-8-prestwoj@gmail.com>
In-Reply-To: <20200602173021.20085-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4503131660887463486==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows a matching frame to be delayed by some number of
milliseconds.
---
 tools/hwsim.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 5 deletions(-)

diff --git a/tools/hwsim.c b/tools/hwsim.c
index d066f814..3ccc936e 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -113,6 +113,7 @@ enum hwsim_tx_control_flags {
 };
 =

 #define IEEE80211_TX_RATE_TABLE_SIZE	4
+#define HWSIM_DELAY_MIN_MS		1
 =

 struct hwsim_rule {
 	unsigned int id;
@@ -125,6 +126,7 @@ struct hwsim_rule {
 	uint32_t frequency;
 	int priority;
 	int signal;
+	int delay;
 };
 =

 struct hwsim_support {
@@ -1106,7 +1108,8 @@ static bool radio_match_addr(const struct radio_info_=
rec *radio,
 =

 static void process_rules(const struct radio_info_rec *src_radio,
 				const struct radio_info_rec *dst_radio,
-				struct hwsim_frame *frame, bool *drop)
+				struct hwsim_frame *frame, bool *drop,
+				uint32_t *delay)
 {
 	const struct l_queue_entry *rule_entry;
 =

@@ -1149,6 +1152,9 @@ static void process_rules(const struct radio_info_rec=
 *src_radio,
 			frame->signal =3D rule->signal / 100;
 =

 		*drop =3D rule->drop;
+
+		if (delay)
+			*delay =3D rule->delay;
 	}
 }
 =

@@ -1232,7 +1238,7 @@ static void hwsim_frame_unref(struct hwsim_frame *fra=
me)
 			bool drop =3D false;
 =

 			process_rules(frame->ack_radio, frame->src_radio,
-					frame, &drop);
+					frame, &drop, NULL);
 =

 			if (!drop)
 				frame->flags |=3D HWSIM_TX_STAT_ACK;
@@ -1374,13 +1380,14 @@ static void process_frame(struct hwsim_frame *frame)
 	bool drop_mcast =3D false;
 =

 	if (util_is_broadcast_address(frame->dst_ether_addr))
-		process_rules(frame->src_radio, NULL, frame, &drop_mcast);
+		process_rules(frame->src_radio, NULL, frame, &drop_mcast, NULL);
 =

 	for (entry =3D l_queue_get_entries(radio_info); entry;
 			entry =3D entry->next) {
 		struct radio_info_rec *radio =3D entry->data;
 		struct send_frame_info *send_info;
 		bool drop =3D drop_mcast;
+		uint32_t delay =3D HWSIM_DELAY_MIN_MS;
 =

 		if (radio =3D=3D frame->src_radio)
 			continue;
@@ -1413,7 +1420,7 @@ static void process_frame(struct hwsim_frame *frame)
 				continue;
 		}
 =

-		process_rules(frame->src_radio, radio, frame, &drop);
+		process_rules(frame->src_radio, radio, frame, &drop, &delay);
 =

 		if (drop)
 			continue;
@@ -1422,7 +1429,7 @@ static void process_frame(struct hwsim_frame *frame)
 		send_info->radio =3D radio;
 		send_info->frame =3D hwsim_frame_ref(frame);
 =

-		if (!l_timeout_create_ms(1, frame_delay_callback,
+		if (!l_timeout_create_ms(delay, frame_delay_callback,
 						send_info, NULL)) {
 			l_error("Error delaying frame, frame will be dropped");
 			send_frame_destroy(send_info);
@@ -1875,6 +1882,7 @@ static struct l_dbus_message *rule_add(struct l_dbus =
*dbus,
 	rule->id =3D next_rule_id++;
 	rule->source_any =3D true;
 	rule->destination_any =3D true;
+	rule->delay =3D HWSIM_DELAY_MIN_MS;
 =

 	if (!rules)
 		rules =3D l_queue_new();
@@ -2160,6 +2168,37 @@ static struct l_dbus_message *rule_property_set_drop(
 	return l_dbus_message_new_method_return(message);
 }
 =

+static bool rule_property_get_delay(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct hwsim_rule *rule =3D user_data;
+
+	l_dbus_message_builder_append_basic(builder, 'u', &rule->delay);
+
+	return true;
+}
+
+static struct l_dbus_message *rule_property_set_delay(
+					struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_iter *new_value,
+					l_dbus_property_complete_cb_t complete,
+					void *user_data)
+{
+	struct hwsim_rule *rule =3D user_data;
+	uint32_t val;
+
+	if (!l_dbus_message_iter_get_variant(new_value, "u", &val) ||
+				val < HWSIM_DELAY_MIN_MS)
+		return dbus_error_invalid_args(message);
+
+	rule->delay =3D val;
+
+	return l_dbus_message_new_method_return(message);
+}
+
 static void setup_rule_interface(struct l_dbus_interface *interface)
 {
 	l_dbus_interface_method(interface, "Remove", 0, rule_remove, "", "");
@@ -2192,6 +2231,10 @@ static void setup_rule_interface(struct l_dbus_inter=
face *interface)
 					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "b",
 					rule_property_get_drop,
 					rule_property_set_drop);
+	l_dbus_interface_property(interface, "Delay",
+					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "u",
+					rule_property_get_delay,
+					rule_property_set_delay);
 }
 =

 static void request_name_callback(struct l_dbus *dbus, bool success,
-- =

2.21.1

--===============4503131660887463486==--

