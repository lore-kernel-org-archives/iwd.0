Content-Type: multipart/mixed; boundary="===============4710731117173339106=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/3] json: introduce JSON module
Date: Tue, 07 Dec 2021 12:55:46 -0800
Message-ID: <20211207205547.1520508-2-prestwoj@gmail.com>
In-Reply-To: 20211207205547.1520508-1-prestwoj@gmail.com

--===============4710731117173339106==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a minimal wrapper around jsmn.h to make things a bit easier
for iterating through a JSON object.

An iterator can be created/destroyed with json_iter_{new,free} and
the caller may call json_iter_foreach on this iterator.

The callback function will contain the key and a void* value. The
value type depends on what 'type' is set to. Currently only JSON_STRING
and JSON_OBJECT types are supported.

If the value is of type JSON_OBJECT json_iter_foreach may be used
again to iterate it. This json_iter should not be freed and is only
valid in the scope of the callback function.

Both keys JSON_STRING values are raw pointers to the original JSON
string and not NULL terminated. String/UTF-8 verification is left up
to the caller.
---
 Makefile.am |   1 +
 src/json.c  | 204 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/json.h  |  59 +++++++++++++++
 3 files changed, 264 insertions(+)
 create mode 100644 src/json.c
 create mode 100644 src/json.h

diff --git a/Makefile.am b/Makefile.am
index 7fe4b5c3..1ae7e3c0 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -249,6 +249,7 @@ src_iwd_SOURCES =3D src/main.c linux/nl80211.h src/iwd.=
h src/missing.h \
 					src/sysfs.h src/sysfs.c \
 					src/offchannel.h src/offchannel.c \
 					src/dpp-util.h src/dpp-util.c \
+					src/json.h src/json.c \
 					$(eap_sources) \
 					$(builtin_sources)
 =

diff --git a/src/json.c b/src/json.c
new file mode 100644
index 00000000..a54d0b9c
--- /dev/null
+++ b/src/json.c
@@ -0,0 +1,204 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2013-2019  Intel Corporation. All rights reserved.
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
+#include <errno.h>
+
+#include <ell/ell.h>
+
+#include "src/json.h"
+#include "ell/useful.h"
+
+#include "shared/jsmn.h"
+
+/* Max number of tokens supported. Increase if larger objects are expected=
 */
+#define JSON_DEFAULT_TOKENS 30
+
+#define TOK_LEN(token) (token)->end - (token)->start
+#define TOK_PTR(json, token) (const uint8_t *)((json) + (token)->start)
+
+struct json_iter {
+	char *json;
+	size_t json_len;
+	jsmntok_t *tokens;
+	int tokens_len;
+	jsmn_parser *p;
+};
+
+static struct json_iter *iter_recurse(struct json_iter *parent,
+					jsmntok_t *object)
+{
+	struct json_iter *iter =3D l_new(struct json_iter, 1);
+
+	iter->json =3D parent->json;
+	iter->json_len =3D parent->json_len;
+	iter->p =3D parent->p;
+	iter->tokens =3D object;
+
+	/*
+	 * Since object->size only indicates the number of keys in an object
+	 * we cannot easily calculate the number of tokens remaining (for this
+	 * object) since each object may have nested objects. Set tokens_len to
+	 * the number of tokens remaining in the overall list after 'object'
+	 */
+	iter->tokens_len =3D parent->tokens_len -
+				((object - parent->tokens) % sizeof(jsmntok_t));
+
+	return iter;
+}
+
+struct json_iter *json_iter_new(const char *json, size_t json_len)
+{
+	struct json_iter *iter =3D l_new(struct json_iter, 1);
+
+	iter->json =3D l_memdup(json, json_len);
+	iter->json_len =3D json_len;
+	iter->p =3D l_new(jsmn_parser, 1);
+	iter->tokens =3D l_new(jsmntok_t, JSON_DEFAULT_TOKENS);
+
+	jsmn_init(iter->p);
+	iter->tokens_len =3D jsmn_parse(iter->p, iter->json, iter->json_len,
+					iter->tokens, JSON_DEFAULT_TOKENS);
+	if (iter->tokens_len < 0) {
+		json_iter_free(iter);
+		return NULL;
+	}
+
+	return iter;
+}
+
+void json_iter_free(struct json_iter *iter)
+{
+	l_free(iter->json);
+	l_free(iter->p);
+	l_free(iter->tokens);
+	l_free(iter);
+}
+
+static int json_iterate(struct json_iter *iter, jsmntok_t *current, int ma=
x,
+				json_iter_func_t func, void *user_data);
+static int json_handle_value(struct json_iter *iter, jsmntok_t *key,
+				jsmntok_t *value, json_iter_func_t func,
+				void *user_data)
+{
+	_auto_(l_free) struct json_iter *ovalue =3D NULL;
+
+	switch (value->type) {
+	case JSMN_OBJECT:
+		/*
+		 * Create this temporary iterator if the caller needs to
+		 * iterate this object.
+		 */
+		ovalue =3D iter_recurse(iter, value);
+
+		if (func)
+			if (!func(iter, TOK_PTR(iter->json, key), TOK_LEN(key),
+					(enum json_type)value->type, ovalue, 0,
+					user_data))
+				return -ECANCELED;
+
+		/*
+		 * Object which will be iterable in the above callback if
+		 * needed. Move past this object with no callback.
+		 *
+		 * TODO: It may be possible to calculate the next token offset
+		 * rather than iterate each token but this gets tricky since
+		 * there are quotes, commas, braces or brackets in between
+		 * tokens.
+		 */
+		return json_iterate(iter, value + 1, value->size,
+					NULL, NULL) + 2;
+	case JSMN_STRING:
+		if (func)
+			if (!func(iter, TOK_PTR(iter->json, key), TOK_LEN(key),
+					(enum json_type)value->type,
+					TOK_PTR(iter->json, value),
+					TOK_LEN(value), user_data))
+				return -ECANCELED;
+
+		return 2;
+	default:
+		return -ENOTSUP;
+	}
+}
+
+/*
+ * Iterate tokens starting at 'current' up to 'max' key value pairs calling
+ * 'func' for each pair.
+ */
+static int json_iterate(struct json_iter *iter, jsmntok_t *current, int ma=
x,
+				json_iter_func_t func, void *user_data)
+{
+	jsmntok_t *c =3D current;
+	int keys =3D 0;
+	int ret;
+
+	while (keys < max) {
+		switch (c->type) {
+		case JSMN_STRING:
+			if (c + 1 > iter->tokens + iter->tokens_len)
+				return -1;
+
+			ret =3D json_handle_value(iter, c, c + 1, func,
+						user_data);
+			if (ret < 0)
+				return ret;
+
+			if (c + ret > iter->tokens + iter->tokens_len)
+				return -EMSGSIZE;
+
+			c +=3D ret;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		keys++;
+	}
+
+	/* Return number of tokens consumed */
+	return (c - current) % sizeof(jsmntok_t);
+}
+
+/*
+ * Iterate over a JSON object. This calls 'func' for each top level key/va=
lue.
+ * Returns true if successful, false otherwise. A False return indicates t=
he
+ * JSON contained currently unsupported types.
+ */
+bool json_iter_foreach(struct json_iter *iter, json_iter_func_t func,
+			void *user_data)
+{
+	int ret;
+
+	/* Empty object {} */
+	if (iter->tokens_len =3D=3D 0)
+		return true;
+
+	/* tokens + 1 should point to the first key in the overall object */
+	ret =3D json_iterate(iter, iter->tokens + 1, iter->tokens->size,
+				func, user_data);
+
+	return ret >=3D 0;
+}
diff --git a/src/json.h b/src/json.h
new file mode 100644
index 00000000..91037153
--- /dev/null
+++ b/src/json.h
@@ -0,0 +1,59 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2021  Intel Corporation. All rights reserved.
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
+struct json_iter;
+
+/*
+ * Identical to JSMN types
+ */
+enum json_type {
+	JSON_UNDEFINED =3D 0,
+	JSON_OBJECT =3D 1 << 0,
+	JSON_ARRAY =3D 1 << 1,
+	JSON_STRING =3D 1 << 2,
+	JSON_PRIMITIVE =3D 1 << 3
+};
+
+/*
+ * Called for each top level key/value in a JSON object. Currently only su=
pports
+ * objects and string types. 'type' will be either JSON_STRING or JSON_OBJ=
ECT.
+ * For both keys (and string values) UTF verification is left up to the ca=
ller.
+ *
+ * 'key' will point directly to the keys memory location in the original J=
SON
+ * string and 'key_len' will be set to its length.
+ *
+ * If 'type' is JSON_STRING, 'value' will be const uint8_t* type and point=
 to
+ * the direct memory location of the value in the original JSON string and
+ * value_len will be set.
+ *
+ * If 'type' is JSON_OBJECT, 'value' will be of struct json_iter* type. Th=
is can
+ * be iterated again by calling json_iter_foreach.
+ */
+typedef bool (*json_iter_func_t)(struct json_iter *iter,
+				const uint8_t *key, size_t key_len,
+				enum json_type type, const void *value,
+				size_t value_len, void *user_data);
+
+struct json_iter *json_iter_new(const char *json, size_t json_len);
+void json_iter_free(struct json_iter *iter);
+bool json_iter_foreach(struct json_iter *iter, json_iter_func_t func,
+			void *user_data);
-- =

2.31.1

--===============4710731117173339106==--

