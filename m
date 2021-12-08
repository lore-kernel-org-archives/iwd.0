Content-Type: multipart/mixed; boundary="===============7796084646096562997=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 2/3] json: introduce JSON module
Date: Wed, 08 Dec 2021 13:36:35 -0800
Message-ID: <20211208213636.1697316-2-prestwoj@gmail.com>
In-Reply-To: 20211208213636.1697316-1-prestwoj@gmail.com

--===============7796084646096562997==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a minimal wrapper around jsmn.h to make things a bit easier
for iterating through a JSON object.

An iterator can be created/destroyed with json_iter_{new,free} and
values can be parsed from this iterator using json_iter_parse.

Arguments to json_iter_parse should use JSON_MANDATORY/JSON_OPTIONAL
macros, and terminate the argument list with JSON_FLAG_INVALID.

The value pointer in the MANDATORY/OPTIONAL macros can be NULL, in
which case the presence of the key/value is checked but no data is
returned out.

Currently only JSON_STRING and JSON_OBJECT types are supported. String
values should be of type struct iovec *, and objects should be of
type struct json_iter **. These nested objects can be parsed again
using json_iter_parse and should not be freed (the original iterator
keeps track of nested object iterators).
---
 Makefile.am |   1 +
 src/json.c  | 222 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/json.h  |  84 ++++++++++++++++++++
 3 files changed, 307 insertions(+)
 create mode 100644 src/json.c
 create mode 100644 src/json.h

v2:
 * Re-wrote to remove callback style parsing. Instead the expected values
   are provided to the parser directly.

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
index 00000000..9f6c744f
--- /dev/null
+++ b/src/json.c
@@ -0,0 +1,222 @@
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
+
+#include "shared/jsmn.h"
+
+/* Max number of tokens supported. Increase if larger objects are expected=
 */
+#define JSON_DEFAULT_TOKENS 30
+
+#define TOK_LEN(token) (token)->end - (token)->start
+#define TOK_PTR(json, token) (void *)((json) + (token)->start)
+
+struct json_iter {
+	const char *json;
+	size_t json_len;
+	jsmntok_t *tokens;
+	int tokens_len;
+	jsmn_parser *p;
+	struct l_queue *children;
+	bool root : 1;
+};
+
+static struct json_iter *iter_recurse(struct json_iter *parent,
+					jsmntok_t *object)
+{
+	struct json_iter *iter =3D l_new(struct json_iter, 1);
+
+	iter->json =3D parent->json;
+	iter->json_len =3D parent->json_len;
+	iter->tokens =3D object;
+	iter->children =3D l_queue_new();
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
+	l_queue_push_head(parent->children, iter);
+
+	return iter;
+}
+
+struct json_iter *json_iter_new(const char *json, size_t json_len)
+{
+	struct json_iter *iter =3D l_new(struct json_iter, 1);
+
+	iter->json =3D json;
+	iter->json_len =3D json_len;
+	iter->p =3D l_new(jsmn_parser, 1);
+	iter->tokens =3D l_new(jsmntok_t, JSON_DEFAULT_TOKENS);
+	iter->root =3D true;
+
+	jsmn_init(iter->p);
+	iter->tokens_len =3D jsmn_parse(iter->p, iter->json, iter->json_len,
+					iter->tokens, JSON_DEFAULT_TOKENS);
+	if (iter->tokens_len < 0) {
+		json_iter_free(iter);
+		return NULL;
+	}
+
+	iter->children =3D l_queue_new();
+
+	return iter;
+}
+
+static void json_iter_destroy(void *data)
+{
+	struct json_iter *iter =3D data;
+
+	json_iter_free(iter);
+}
+
+void json_iter_free(struct json_iter *iter)
+{
+	if (iter->root) {
+		l_free(iter->p);
+		l_free(iter->tokens);
+	}
+
+	l_queue_destroy(iter->children, json_iter_destroy);
+	l_free(iter);
+}
+
+static jsmntok_t *next_key(struct json_iter *iter, jsmntok_t *current)
+{
+	jsmntok_t *value;
+	int i;
+
+	/*
+	 * In theory JSMN should prevent any of these bounds checks from failing
+	 */
+	if (current + 1 > iter->tokens + iter->tokens_len)
+		return NULL;
+
+	value =3D current + 1;
+
+	if (value->size =3D=3D 0)
+		return value + 1;
+
+	for (i =3D 0; i < value->size; i++)
+		value =3D next_key(iter, value);
+
+	return value;
+}
+
+/*
+ * Checks that the keys value (t + 1) is in bounds, the value type matches,
+ * key length matches, and key string match
+ */
+#define TOKEN_MATCHES(iter, t, key, type) \
+	(t) + 1 < iter->tokens + iter->tokens_len && \
+	(jsmntype_t)(type) =3D=3D ((t) + 1)->type && \
+	TOK_LEN((t)) =3D=3D (int)strlen((key)) && \
+	!memcmp(TOK_PTR((iter)->json, (t)), (key), TOK_LEN((t)))
+
+bool json_iter_parse(struct json_iter *iter, ...)
+{
+	va_list va;
+	int i;
+	int num =3D iter->tokens->size;
+	jsmntok_t *next;
+	struct iovec *sval;
+	struct json_iter **oval;
+
+	/* Empty object {} */
+	if (iter->tokens_len < 1)
+		return false;
+
+	va_start(va, iter);
+
+	while (true) {
+		enum json_flag flag;
+		char *key;
+		enum json_type type;
+		void *value;
+		jsmntok_t *v =3D NULL;
+
+		flag =3D va_arg(va, enum json_flag);
+
+		if (flag =3D=3D JSON_FLAG_INVALID)
+			break;
+
+		key =3D va_arg(va, char *);
+		type =3D va_arg(va, enum json_type);
+		value =3D va_arg(va, void *);
+
+		next =3D iter->tokens + 1;
+
+		/* Iterate over this objects keys */
+		for (i =3D 0; i < num; i++) {
+			if (TOKEN_MATCHES(iter, next, key, type)) {
+				v =3D next + 1;
+				break;
+			}
+
+			next =3D next_key(iter, next);
+			if (!next)
+				return false;
+		}
+
+		if (flag =3D=3D JSON_FLAG_MANDATORY && !v)
+			return false;
+
+		switch (type) {
+		case JSON_STRING:
+			if (!value)
+				continue;
+
+			sval =3D value;
+			sval->iov_base =3D v ? TOK_PTR(iter->json, v) : NULL;
+			sval->iov_len =3D v ? TOK_LEN(v) : 0;
+
+			break;
+		case JSON_OBJECT:
+			if (!value)
+				continue;
+
+			oval =3D value;
+			*oval =3D v ? iter_recurse(iter, v) : NULL;
+
+			break;
+		default:
+			return false;
+		}
+	}
+
+	va_end(va);
+
+	return true;
+}
diff --git a/src/json.h b/src/json.h
new file mode 100644
index 00000000..202445ee
--- /dev/null
+++ b/src/json.h
@@ -0,0 +1,84 @@
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
+enum json_flag {
+	JSON_FLAG_INVALID =3D 0,
+	JSON_FLAG_MANDATORY =3D 1,
+	JSON_FLAG_OPTIONAL =3D 2,
+};
+
+#define JSON_MANDATORY(key, type, out) \
+	JSON_FLAG_MANDATORY, (key), (type), (out)
+
+#define JSON_OPTIONAL(key, type, out) \
+	JSON_FLAG_OPTIONAL, (key), (type), (out)
+
+#define JSON_STR_EQ(iov, s) \
+	((iov)->iov_len =3D=3D strlen((s)) && \
+	!memcmp((iov)->iov_base, (s), (iov)->iov_len))
+
+#define JSON_TO_STR(iov) \
+({ \
+	char *_tmp =3D l_malloc((iov)->iov_len + 1); \
+	memcpy(_tmp, (iov)->iov_base, (iov)->iov_len); \
+	_tmp[(iov)->iov_len] =3D '\0'; \
+	_tmp; \
+})
+
+struct json_iter *json_iter_new(const char *json, size_t json_len);
+void json_iter_free(struct json_iter *iter);
+
+/*
+ * Parse an arbitrary number of key/value pairs from a JSON iterator. Init=
ially
+ * a new JSON iterator should be created with json_iter_new() and, when do=
ne,
+ * freed with json_iter_free. Nested objects are also parsed with this fun=
ction
+ * but these iterators should not be freed and are tracked by the original
+ * iterator.
+ *
+ * Arguments should be specified using JSON_MANDATORY or JSON_OPTIONAL:
+ *
+ * r =3D json_iter_parse(iter, JSON_MANDATORY("mykey", JSON_STRING, &strva=
lue),
+ * 			JSON_OPTIONAL("optkey", JSON_STRING, &optvalue));
+ *
+ * String values should be of type struct iovec *
+ * Object values should be of type struct json_iter **
+ *
+ * No other types are supported at this time, and json_iter_parse will fai=
l if
+ * other types are encountered.
+ *
+ * JSON_OPTIONAL string values will have a NULL/0 iov_base/iov_len if they=
 were
+ * not found. JSON_OPTIONAL object value iterators will be NULL if not fou=
nd.
+ */
+bool json_iter_parse(struct json_iter *iter, ...);
-- =

2.31.1

--===============7796084646096562997==--

