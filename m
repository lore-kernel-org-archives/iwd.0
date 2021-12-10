Content-Type: multipart/mixed; boundary="===============1960888317651533849=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 2/3] json: introduce JSON module
Date: Fri, 10 Dec 2021 13:41:38 -0800
Message-ID: <20211210214139.2045488-2-prestwoj@gmail.com>
In-Reply-To: 20211210214139.2045488-1-prestwoj@gmail.com

--===============1960888317651533849==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a minimal wrapper around jsmn.h to make things a bit easier
for iterating through a JSON object.

To use, first parse the JSON and create a contents object using
json_contents_new(). This object can then be used to initialize a
json_iter object using json_iter_init().

The json_iter object can then be parsed with json_iter_parse by
passing in JSON_MANDATORY/JSON_OPTIONAL arguments. Currently only
JSON_STRING and JSON_OBJECT types are supported. Any JSON_MANDATORY
values that are not found will result in an error.

If a JSON_OPTIONAL string is not found, the pointer will be NULL.
If a JSON_OPTIONAL object is not found, this iterator will be
initialized but 'start' will be -1. This can be checked with a
convenience macro json_object_not_found();
---
 Makefile.am |   4 +-
 src/json.c  | 271 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/json.h  |  83 ++++++++++++++++
 3 files changed, 357 insertions(+), 1 deletion(-)
 create mode 100644 src/json.c
 create mode 100644 src/json.h

v3:
 * Return allocated strings
 * Initialize iterators using contents object which
   allows them to be stored on the stack. This also removes
   the need for child objects to be tracked.
 * Enabled JSMN_PARENT_LINKS to make iterating keys much
   more straight forward
 * Enabled JSMN_STRICT for strict JSON parsing
 * Removed side-effecting with supplied arguments. Instead
   push arguments into a queue during parsing. Then, once
   all arguments are verified, set the out args from the caller.

diff --git a/Makefile.am b/Makefile.am
index 7fe4b5c3..fef2c2c4 100644
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

@@ -566,7 +567,8 @@ EXTRA_DIST =3D src/genbuiltin src/iwd.service.in src/ne=
t.connman.iwd.service \
 =

 AM_CFLAGS =3D $(ell_cflags) -fvisibility=3Dhidden \
 				-DUNITDIR=3D\""$(top_srcdir)/unit/"\" \
-				-DCERTDIR=3D\""$(top_builddir)/unit/"\"
+				-DCERTDIR=3D\""$(top_builddir)/unit/"\" \
+				-DJSMN_PARENT_LINKS -DJSMN_STRICT
 =

 if MAINTAINER_MODE
 AM_CFLAGS +=3D -DHAVE_PKCS8_SUPPORT
diff --git a/src/json.c b/src/json.c
new file mode 100644
index 00000000..eb041934
--- /dev/null
+++ b/src/json.c
@@ -0,0 +1,271 @@
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
+#define TOK_TO_STR(json, token) \
+({ \
+	char *_tmp =3D l_malloc(TOK_LEN((token)) + 1); \
+	memcpy(_tmp, TOK_PTR((json), (token)), TOK_LEN((token))); \
+	_tmp[TOK_LEN((token))] =3D '\0'; \
+	_tmp; \
+})
+
+#define ITER_END(iter) \
+	(((iter)->contents->tokens + (iter)->start) + (iter)->count)
+
+struct json_contents {
+	const char *json;
+	size_t json_len;
+	jsmntok_t *tokens;
+	int tokens_len;
+	jsmn_parser *p;
+};
+
+static jsmntok_t *next_key_in_parent(struct json_iter *iter, jsmntok_t *cu=
rrent)
+{
+	int parent =3D current->parent;
+
+	/* iterate the list and stop on the first token with the same parent */
+	while (++current < ITER_END(iter)) {
+		if (current->parent =3D=3D parent)
+			return current;
+	}
+
+	return NULL;
+}
+
+/*
+ * 'object' is expected to be a value, so object - 1 is its key. Find
+ * the next key who's parent matches the parent of object - 1. The
+ * token preceeding this next key will mark the end of 'object'.
+ */
+static int find_object_tokens(struct json_iter *iter, jsmntok_t *object)
+{
+	jsmntok_t *next =3D next_key_in_parent(iter, object - 1);
+
+	/* End of token list */
+	if (!next)
+		next =3D ITER_END(iter);
+
+	return ((next - object) % sizeof(jsmntok_t)) - 1;
+}
+
+static void iter_recurse(struct json_iter *iter, jsmntok_t *object,
+				struct json_iter *child)
+{
+	struct json_contents *c =3D iter->contents;
+
+	child->contents =3D c;
+	child->start =3D (object - c->tokens) % sizeof(jsmntok_t);
+	child->count =3D find_object_tokens(iter, object);
+}
+
+struct json_contents *json_contents_new(const char *json, size_t json_len)
+{
+	struct json_contents *c =3D l_new(struct json_contents, 1);
+
+	c->json =3D json;
+	c->json_len =3D json_len;
+	c->p =3D l_new(jsmn_parser, 1);
+	c->tokens =3D l_new(jsmntok_t, JSON_DEFAULT_TOKENS);
+
+	jsmn_init(c->p);
+	c->tokens_len =3D jsmn_parse(c->p, c->json, c->json_len,
+					c->tokens, JSON_DEFAULT_TOKENS);
+	if (c->tokens_len < 0) {
+		json_contents_free(c);
+		return NULL;
+	}
+
+	return c;
+}
+
+void json_iter_init(struct json_iter *iter, struct json_contents *c)
+{
+	iter->contents =3D c;
+	iter->start =3D 0;
+	iter->count =3D c->tokens_len;
+}
+
+void json_contents_free(struct json_contents *c)
+{
+	l_free(c->p);
+	l_free(c->tokens);
+	l_free(c);
+}
+
+struct json_arg {
+	enum json_type type;
+	void *value;
+	jsmntok_t *v;
+};
+
+static void push_arg(struct l_queue *q, enum json_type type,
+			void *value, jsmntok_t *v)
+{
+	struct json_arg *arg =3D l_new(struct json_arg, 1);
+
+	arg->type =3D type;
+	arg->value =3D value;
+	arg->v =3D v;
+
+	l_queue_push_head(q, arg);
+}
+
+static void assign_arg(void *data, void *user_data)
+{
+	struct json_iter *iter =3D user_data;
+	struct json_arg *arg =3D data;
+	struct json_contents *c =3D iter->contents;
+	char **sval;
+	struct json_iter *oval;
+
+	switch (arg->type) {
+	case JSON_STRING:
+		sval =3D arg->value;
+
+		*sval =3D arg->v ? TOK_TO_STR(c->json, arg->v) : NULL;
+
+		break;
+	case JSON_OBJECT:
+		oval =3D arg->value;
+
+		if (!arg->v)
+			oval->start =3D -1;
+		else
+			iter_recurse(iter, arg->v, oval);
+
+		break;
+	default:
+		/* Types are verified earlier, this should never happen */
+		return;
+	}
+
+	l_free(arg);
+}
+
+bool json_iter_parse(struct json_iter *iter, enum json_type type, ...)
+{
+	struct json_contents *c =3D iter->contents;
+	va_list va;
+	int i;
+	int num =3D c->tokens->size;
+	jsmntok_t *next;
+	struct l_queue *args;
+
+	if (iter->start =3D=3D -1)
+		return false;
+
+	args =3D l_queue_new();
+
+	va_start(va, type);
+
+	while (true) {
+		enum json_flag flag;
+		char *key;
+		void *value;
+		jsmntok_t *v =3D NULL;
+		void *ptr;
+		size_t len;
+
+		if (type =3D=3D JSON_UNDEFINED)
+			break;
+
+		key =3D va_arg(va, char *);
+		value =3D va_arg(va, void *);
+		flag =3D va_arg(va, enum json_flag);
+
+		/* First key */
+		next =3D c->tokens + iter->start + 1;
+
+		/* Iterate over this objects keys */
+		for (i =3D 0; i < num; i++) {
+			ptr =3D TOK_PTR(c->json, next);
+			len =3D TOK_LEN(next);
+
+			if (next + 1 > ITER_END(iter))
+				goto error;
+
+			if (strlen(key) =3D=3D len && !memcmp(ptr, key, len)) {
+				/* Key found but the wrong value type */
+				if ((next + 1)->type !=3D (jsmntype_t)type)
+					goto error;
+
+				v =3D next + 1;
+				break;
+			}
+
+			next =3D next_key_in_parent(iter, next);
+			if (!next)
+				goto next;
+		}
+
+		if (flag =3D=3D JSON_FLAG_MANDATORY && !v)
+			goto error;
+
+		/* Check supported types prior to pushing/assigning */
+		switch (type) {
+		case JSON_STRING:
+		case JSON_OBJECT:
+			break;
+		default:
+			goto error;
+		}
+
+next:
+		/*
+		 * Still push even if an optional value doesn't exist (!v) so
+		 * the caller can check if it was found or not.
+		 */
+		if (value)
+			push_arg(args, type, value, v);
+
+		type =3D va_arg(va, enum json_type);
+	}
+
+	va_end(va);
+
+	l_queue_foreach(args, assign_arg, iter);
+	l_queue_destroy(args, NULL);
+
+	return true;
+
+error:
+	l_queue_destroy(args, l_free);
+	return false;
+}
diff --git a/src/json.h b/src/json.h
new file mode 100644
index 00000000..cff8e289
--- /dev/null
+++ b/src/json.h
@@ -0,0 +1,83 @@
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
+	JSON_OBJECT =3D 1,
+	JSON_ARRAY =3D 2,
+	JSON_STRING =3D 3,
+	JSON_PRIMITIVE =3D 4
+};
+
+enum json_flag {
+	JSON_FLAG_MANDATORY =3D 1,
+	JSON_FLAG_OPTIONAL =3D 2,
+};
+
+struct json_iter {
+	struct json_contents *contents;
+	int start;
+	int count;
+};
+
+#define JSON_MANDATORY(key, type, out) \
+	(type), (key), (out), JSON_FLAG_MANDATORY
+
+#define JSON_OPTIONAL(key, type, out) \
+	(type), (key), (out), JSON_FLAG_OPTIONAL
+
+#define json_object_not_found(iter) ((iter)->start =3D=3D -1)
+
+struct json_contents *json_contents_new(const char *json, size_t json_len);
+void json_contents_free(struct json_contents *c);
+
+void json_iter_init(struct json_iter *iter, struct json_contents *c);
+
+/*
+ * Parse an arbitrary number of key/value pairs from a JSON iterator. Init=
ially
+ * a new JSON contents object should be created with json_contents_new() a=
nd,
+ * when done, freed with json_contents_free.
+ *
+ * Iterators can be initialized with the json_contents object. Nested obje=
ct
+ * iterators are also parsed with this function.
+ *
+ * Arguments should be specified using JSON_MANDATORY or JSON_OPTIONAL:
+ *
+ * r =3D json_iter_parse(iter, JSON_MANDATORY("mykey", JSON_STRING, &strva=
lue),
+ * 			JSON_OPTIONAL("optkey", JSON_STRING, &optvalue),
+ * 			JSON_UNDEFINED);
+ *
+ * String values should be of type char ** and must be freed
+ * Object values should be of type struct json_iter *
+ *
+ * No other types are supported at this time, and json_iter_parse will fai=
l if
+ * other types are encountered.
+ *
+ * JSON_OPTIONAL string values will point to NULL if not found
+ * JSON_OPTIONAL objects can be checked with json_object_not_found.
+ */
+bool json_iter_parse(struct json_iter *iter, enum json_type type, ...);
-- =

2.31.1

--===============1960888317651533849==--

