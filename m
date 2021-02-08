Content-Type: multipart/mixed; boundary="===============1693228943282221294=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] diagnostics: check dbus variant parsing
Date: Mon, 08 Feb 2021 11:52:29 -0800
Message-ID: <20210208195229.603430-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1693228943282221294==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the diagnostics dictionary is invalid print an
error and do not continue parsing.
---
 client/diagnostic.c | 43 ++++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/client/diagnostic.c b/client/diagnostic.c
index c94178d6..153598ed 100644
--- a/client/diagnostic.c
+++ b/client/diagnostic.c
@@ -31,7 +31,7 @@
 #include "client/diagnostic.h"
 #include "client/display.h"
 =

-typedef void (*display_dict_custom_func_t)(struct l_dbus_message_iter *var=
iant,
+typedef bool (*display_dict_custom_func_t)(struct l_dbus_message_iter *var=
iant,
 				const char *key, const char *margin,
 				int name_column_width, int value_column_width);
 =

@@ -64,16 +64,19 @@ static const struct diagnostic_dict_mapping *find_mappi=
ng(const char *key,
 	return NULL;
 }
 =

-static void display_bitrate_100kbps(struct l_dbus_message_iter *variant,
+static bool display_bitrate_100kbps(struct l_dbus_message_iter *variant,
 				const char *key, const char *margin,
 				int name_column_width, int value_column_width)
 {
 	uint32_t rate;
 =

-	l_dbus_message_iter_get_variant(variant, "u", &rate);
+	if (!l_dbus_message_iter_get_variant(variant, "u", &rate))
+		return false;
 =

 	display("%s%-*s%-*u Kbit/s\n", margin, name_column_width, key,
 			value_column_width, rate * 100);
+
+	return true;
 }
 =

 static const struct diagnostic_dict_mapping diagnostic_mapping[] =3D {
@@ -115,39 +118,48 @@ void diagnostic_display(struct l_dbus_message_iter *d=
ict,
 			if (!map->custom)
 				continue;
 =

-			map->custom(&variant, key, margin, name_column_width,
-					value_column_width);
+			if (!map->custom(&variant, key, margin, name_column_width,
+					value_column_width))
+				goto parse_error;
 =

 			/* custom should handle any units, so continue */
 			continue;
 =

 		case 's':
-			l_dbus_message_iter_get_variant(&variant, "s",
-							&s_value);
+			if (!l_dbus_message_iter_get_variant(&variant, "s",
+							&s_value))
+				goto parse_error;
+
 			sprintf(display_text, "%s%-*s%-*s", margin,
 					name_column_width, key,
 					value_column_width, s_value);
 			break;
 =

 		case 'u':
-			l_dbus_message_iter_get_variant(&variant, "u",
-							&u_value);
+			if (!l_dbus_message_iter_get_variant(&variant, "u",
+							&u_value))
+				goto parse_error;
+
 			sprintf(display_text, "%s%-*s%-*u", margin,
 						name_column_width, key,
 						value_column_width, u_value);
 			break;
 =

 		case 'n':
-			l_dbus_message_iter_get_variant(&variant, "n",
-							&n_value);
+			if (!l_dbus_message_iter_get_variant(&variant, "n",
+							&n_value))
+				goto parse_error;
+
 			sprintf(display_text, "%s%-*s%-*i", margin,
 						name_column_width, key,
 						value_column_width, n_value);
 			break;
 =

 		case 'y':
-			l_dbus_message_iter_get_variant(&variant, "y",
-							&y_value);
+			if (!l_dbus_message_iter_get_variant(&variant, "y",
+							&y_value))
+				goto parse_error;
+
 			sprintf(display_text, "%s%-*s%-*u", margin,
 						name_column_width, key,
 						value_column_width, y_value);
@@ -164,4 +176,9 @@ void diagnostic_display(struct l_dbus_message_iter *dic=
t,
 		else
 			display("%s\n", display_text);
 	}
+
+	return;
+
+parse_error:
+	display_error("Error parsing dignostics");
 }
-- =

2.26.2

--===============1693228943282221294==--

