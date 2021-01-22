Content-Type: multipart/mixed; boundary="===============4799178016006324820=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 8/8] client: remove display_dictionary
Date: Fri, 22 Jan 2021 12:38:49 -0800
Message-ID: <20210122203849.679952-8-prestwoj@gmail.com>
In-Reply-To: <20210122203849.679952-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4799178016006324820==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This has been replaced by diagnostic_display
---
 client/display.c | 94 ------------------------------------------------
 client/display.h | 22 ------------
 2 files changed, 116 deletions(-)

diff --git a/client/display.c b/client/display.c
index d7baaac2..88bc913f 100644
--- a/client/display.c
+++ b/client/display.c
@@ -393,100 +393,6 @@ void display_command_line(const char *command_family,
 	l_free(cmd_line);
 }
 =

-static const struct display_dict_mapping *find_mapping(const char *key,
-				const struct display_dict_mapping *mapping)
-{
-	int idx =3D 0;
-
-	while (mapping[idx].key) {
-		if (!strcmp(mapping[idx].key, key))
-			return &mapping[idx];
-
-		idx++;
-	}
-
-	return NULL;
-}
-
-void display_dictionary(struct l_dbus_message_iter *dict,
-			const struct display_dict_mapping *mapping,
-			const char *margin, int name_column_width,
-			int value_column_width)
-{
-	struct l_dbus_message_iter variant;
-	const char *key;
-	const struct display_dict_mapping *map;
-	display_dict_custom_func_t custom;
-	char display_text[160];
-
-	while (l_dbus_message_iter_next_entry(dict, &key, &variant)) {
-		const char *s_value;
-		uint32_t u_value;
-		int16_t n_value;
-		uint8_t y_value;
-
-		map =3D find_mapping(key, mapping);
-		if (!map)
-			continue;
-
-		switch (map->type) {
-		case 0:
-			if (!map->units)
-				continue;
-
-			custom =3D (display_dict_custom_func_t)map->units;
-
-			custom(&variant, key, margin, name_column_width,
-					value_column_width);
-
-			/* custom should handle any units, so continue */
-			continue;
-
-		case 's':
-			l_dbus_message_iter_get_variant(&variant, "s",
-							&s_value);
-			sprintf(display_text, "%s%-*s%-*s", margin,
-					name_column_width, key,
-					value_column_width, s_value);
-			break;
-
-		case 'u':
-			l_dbus_message_iter_get_variant(&variant, "u",
-							&u_value);
-			sprintf(display_text, "%s%-*s%-*u", margin,
-						name_column_width, key,
-						value_column_width, u_value);
-			break;
-
-		case 'n':
-			l_dbus_message_iter_get_variant(&variant, "n",
-							&n_value);
-			sprintf(display_text, "%s%-*s%-*i", margin,
-						name_column_width, key,
-						value_column_width, n_value);
-			break;
-
-		case 'y':
-			l_dbus_message_iter_get_variant(&variant, "y",
-							&y_value);
-			sprintf(display_text, "%s%-*s%-*u", margin,
-						name_column_width, key,
-						value_column_width, y_value);
-			break;
-
-		default:
-			display("type %c not handled", map->type);
-			continue;
-		}
-
-		if (map->units)
-			display("%s %s\n", display_text,
-					(const char *)map->units);
-		else
-			display("%s\n", display_text);
-	}
-}
-
 static void display_completion_matches(char **matches, int num_matches,
 								int max_length)
 {
diff --git a/client/display.h b/client/display.h
index 78b486f5..b5df944a 100644
--- a/client/display.h
+++ b/client/display.h
@@ -22,24 +22,6 @@
 =

 struct command;
 struct command_family;
-struct l_dbus_message_iter;
-
-typedef void (*display_dict_custom_func_t)(struct l_dbus_message_iter *var=
iant,
-				const char *key, const char *margin,
-				int name_column_width, int value_column_width);
-
-/*
- * Maps dictionary keys to types/units. 'type' should be a valid DBus type=
, or
- * zero for displaying in a custom fashion. When the display needs to be
- * customized 'units' should point to a custom display function of the form
- * display_dict_custom_func_t which should display the entire value as well
- * as any units required.
- */
-struct display_dict_mapping {
-	const char *key;
-	char type;
-	void *units;
-};
 =

 #define COLOR_BOLDGRAY	"\x1B[1;30m"
 #define COLOR_GRAY	"\x1b[37m"
@@ -59,10 +41,6 @@ void display_table_footer(void);
 void display_error(const char *error);
 void display_command_line(const char *command_family,
 						const struct command *cmd);
-void display_dictionary(struct l_dbus_message_iter *dict,
-			const struct display_dict_mapping *mapping,
-			const char *margin,
-			int name_column_width, int value_column_width);
 =

 void display_refresh_timeout_set(void);
 void display_refresh_reset(void);
-- =

2.26.2

--===============4799178016006324820==--

