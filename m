Content-Type: multipart/mixed; boundary="===============9216046446469142032=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 5/7] client: implement diagnostic module
Date: Fri, 22 Jan 2021 10:14:32 -0800
Message-ID: <20210122181434.644707-5-prestwoj@gmail.com>
In-Reply-To: <20210122181434.644707-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9216046446469142032==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For now this module serves as a helper for printing diagnostic
dictionary values. The new API (diagnostic_display) takes a
Dbus iterator which has been entered into a dictionary and
prints out each key and value. A mapping struct was defined
which maps keys to types and units. For simple cases the mapping
will consist of a dbus type character and a units string,
e.g. dBm, Kbit/s etc. For more complex printing which requires
processing the value the 'units' void* cant be set to a
function which can be custom written to handle the value.
---
 Makefile.am         |   3 +-
 client/diagnostic.c | 166 ++++++++++++++++++++++++++++++++++++++++++++
 client/diagnostic.h |  26 +++++++
 3 files changed, 194 insertions(+), 1 deletion(-)
 create mode 100644 client/diagnostic.c
 create mode 100644 client/diagnostic.h

v3:
 * Moved this into its own file/module

diff --git a/Makefile.am b/Makefile.am
index a0701c97..0cbadb09 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -286,7 +286,8 @@ client_iwctl_SOURCES =3D client/main.c \
 			client/known-networks.c \
 			client/network.h client/network.c \
 			client/properties.h client/properties.c \
-			client/wsc.c client/station.c
+			client/wsc.c client/station.c \
+			client/diagnostic.c client/diagnostic.h
 client_iwctl_LDADD =3D $(ell_ldadd) $(READLINE_LIBS)
 =

 if MANUAL_PAGES
diff --git a/client/diagnostic.c b/client/diagnostic.c
new file mode 100644
index 00000000..73f71563
--- /dev/null
+++ b/client/diagnostic.c
@@ -0,0 +1,166 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2020  Intel Corporation. All rights reserved.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+
+#include <ell/ell.h>
+
+#include "client/diagnostic.h"
+#include "client/display.h"
+
+typedef void (*display_dict_custom_func_t)(struct l_dbus_message_iter *var=
iant,
+				const char *key, const char *margin,
+				int name_column_width, int value_column_width);
+
+/*
+ * Maps dictionary keys to types/units. 'type' should be a valid DBus type=
, or
+ * zero for displaying in a custom fashion. When the display needs to be
+ * customized 'units' should point to a custom display function of the form
+ * display_dict_custom_func_t which should display the entire value as well
+ * as any units required.
+ */
+struct display_dict_mapping {
+	const char *key;
+	char type;
+	const char *units;
+	display_dict_custom_func_t custom;
+};
+
+static const struct display_dict_mapping *find_mapping(const char *key,
+				const struct display_dict_mapping *mapping)
+{
+	int idx =3D 0;
+
+	while (mapping[idx].key) {
+		if (!strcmp(mapping[idx].key, key))
+			return &mapping[idx];
+
+		idx++;
+	}
+
+	return NULL;
+}
+
+static void display_bitrate_100kbps(struct l_dbus_message_iter *variant,
+				const char *key, const char *margin,
+				int name_column_width, int value_column_width)
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
+	{ "Address", 's' },
+	{ "ConnectedBss", 's' },
+	{ "RxMode", 's' },
+	{ "TxMode", 's' },
+	{ "RxBitrate", 0, NULL, display_bitrate_100kbps },
+	{ "TxBitrate", 0, NULL, display_bitrate_100kbps },
+	{ "ExpectedThroughput", 'u', "Kbit/s" },
+	{ "RSSI", 'n', "dBm" },
+	{ "RxMCS", 'y' },
+	{ "TxMCS", 'y' },
+	{ NULL }
+};
+
+void diagnostic_display(struct l_dbus_message_iter *dict,
+			const char *margin, int name_column_width,
+			int value_column_width)
+{
+	struct l_dbus_message_iter variant;
+	const char *key;
+	const struct display_dict_mapping *map;
+	char display_text[160];
+
+	while (l_dbus_message_iter_next_entry(dict, &key, &variant)) {
+		const char *s_value;
+		uint32_t u_value;
+		int16_t n_value;
+		uint8_t y_value;
+
+		map =3D find_mapping(key, diagnostic_mapping);
+		if (!map)
+			continue;
+
+		switch (map->type) {
+		case 0:
+			if (!map->custom)
+				continue;
+
+			map->custom(&variant, key, margin, name_column_width,
+					value_column_width);
+
+			/* custom should handle any units, so continue */
+			continue;
+
+		case 's':
+			l_dbus_message_iter_get_variant(&variant, "s",
+							&s_value);
+			sprintf(display_text, "%s%-*s%-*s", margin,
+					name_column_width, key,
+					value_column_width, s_value);
+			break;
+
+		case 'u':
+			l_dbus_message_iter_get_variant(&variant, "u",
+							&u_value);
+			sprintf(display_text, "%s%-*s%-*u", margin,
+						name_column_width, key,
+						value_column_width, u_value);
+			break;
+
+		case 'n':
+			l_dbus_message_iter_get_variant(&variant, "n",
+							&n_value);
+			sprintf(display_text, "%s%-*s%-*i", margin,
+						name_column_width, key,
+						value_column_width, n_value);
+			break;
+
+		case 'y':
+			l_dbus_message_iter_get_variant(&variant, "y",
+							&y_value);
+			sprintf(display_text, "%s%-*s%-*u", margin,
+						name_column_width, key,
+						value_column_width, y_value);
+			break;
+
+		default:
+			display("type %c not handled", map->type);
+			continue;
+		}
+
+		if (map->units)
+			display("%s %s\n", display_text,
+					(const char *)map->units);
+		else
+			display("%s\n", display_text);
+	}
+}
diff --git a/client/diagnostic.h b/client/diagnostic.h
new file mode 100644
index 00000000..004bbe85
--- /dev/null
+++ b/client/diagnostic.h
@@ -0,0 +1,26 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2020  Intel Corporation. All rights reserved.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+struct l_dbus_message_iter;
+
+void diagnostic_display(struct l_dbus_message_iter *dict, const char *marg=
in,
+			int name_column_width, int value_column_width);
-- =

2.26.2

--===============9216046446469142032==--

