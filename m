Content-Type: multipart/mixed; boundary="===============8280357307375909777=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 5/5] client: update station to use display_dictionary
Date: Thu, 21 Jan 2021 10:11:13 -0800
Message-ID: <20210121181113.572092-5-prestwoj@gmail.com>
In-Reply-To: <20210121181113.572092-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8280357307375909777==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 client/station.c | 75 +++++++++++++++++-------------------------------
 1 file changed, 27 insertions(+), 48 deletions(-)

diff --git a/client/station.c b/client/station.c
index 93b1a4da..1085e18d 100644
--- a/client/station.c
+++ b/client/station.c
@@ -593,12 +593,36 @@ static enum cmd_status cmd_scan(const char *device_na=
me,
 	return CMD_STATUS_TRIGGERED;
 }
 =

+static void display_bitrate_100kbps(struct l_dbus_message_iter *variant,
+				const char *key, const char *margin,
+				int name_column_width,
+				int value_column_width)
+{
+	uint32_t rate;
+
+	l_dbus_message_iter_get_variant(variant, "u", &rate);
+
+	display("%s%-*s%-*u Kbit/s\n", margin, name_column_width, key,
+			value_column_width, rate * 100);
+}
+
+static const struct display_dict_mapping diagnostic_mapping[] =3D {
+	{ "ConnectedBss", 's', NULL },
+	{ "RxMode", 's', NULL },
+	{ "TxMode", 's', NULL },
+	{ "RxBitrate", 0, display_bitrate_100kbps },
+	{ "TxBitrate", 0, display_bitrate_100kbps },
+	{ "ExpectedThroughput", 'u', "Kbit/s" },
+	{ "RSSI", 'n', "dBm" },
+	{ "RxMCS", 'y', NULL },
+	{ "TxMCS", 'y', NULL},
+	{ NULL }
+};
+
 static void get_diagnostics_callback(struct l_dbus_message *message,
 					void *user_data)
 {
 	struct l_dbus_message_iter iter;
-	struct l_dbus_message_iter variant;
-	const char *key;
 =

 	if (dbus_message_has_error(message))
 		return;
@@ -608,52 +632,7 @@ static void get_diagnostics_callback(struct l_dbus_mes=
sage *message,
 		goto done;
 	}
 =

-	while (l_dbus_message_iter_next_entry(&iter, &key, &variant)) {
-		const char *s_value;
-		uint32_t u_value;
-		int16_t i_value;
-		uint8_t y_value;
-
-		if (!strcmp(key, "ConnectedBss") || !strcmp(key, "RxMode") ||
-				!strcmp(key, "TxMode")) {
-			/* String variants with no special handling */
-
-			l_dbus_message_iter_get_variant(&variant, "s",
-							&s_value);
-
-			display("%s%*s  %-*s%-*s\n", MARGIN, 8, "", 20,
-				key, 47, s_value);
-		} else if (!strcmp(key, "RxBitrate") ||
-				!strcmp(key, "TxBitrate")) {
-			/* Bitrates expressed in 100Kbit/s */
-
-			l_dbus_message_iter_get_variant(&variant, "u",
-							&u_value);
-			display("%s%*s  %-*s%u Kbit/s\n", MARGIN, 8, "", 20,
-				key, u_value * 100);
-		} else if (!strcmp(key, "ExpectedThroughput")) {
-			/* ExpectedThroughput expressed in Kbit/s */
-
-			l_dbus_message_iter_get_variant(&variant, "u",
-							&u_value);
-			display("%s%*s  %-*s%u Kbit/s\n", MARGIN, 8, "", 20,
-				key, u_value);
-		} else if (!strcmp(key, "RSSI")) {
-			/* RSSI expressed in dBm */
-
-			l_dbus_message_iter_get_variant(&variant, "n",
-							&i_value);
-			display("%s%*s  %-*s%i dBm\n", MARGIN, 8, "", 20,
-				key, i_value);
-		} else if (!strcmp(key, "RxMCS") || !strcmp(key, "TxMCS")) {
-			/* MCS index's are single byte integers */
-
-			l_dbus_message_iter_get_variant(&variant, "y",
-							&y_value);
-			display("%s%*s  %-*s%u\n", MARGIN, 8, "", 20,
-				key, y_value);
-		}
-	}
+	display_dictionary(&iter, diagnostic_mapping, "            ", 20, 20);
 =

 done:
 	/* Finish the table started by cmd_show */
-- =

2.26.2

--===============8280357307375909777==--

