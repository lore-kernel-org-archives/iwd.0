Content-Type: multipart/mixed; boundary="===============5629549025836564308=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 4/9] json: add support for array iteration
Date: Thu, 06 Jan 2022 11:50:02 -0800
Message-ID: <20220106195007.528618-4-prestwoj@gmail.com>
In-Reply-To: 20220106195007.528618-1-prestwoj@gmail.com

--===============5629549025836564308==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Arrays can now be parsed using the JSON_ARRAY type (stored in
a struct json_iter) then iterated using json_iter_next. When
iterating the type can be checked with json_iter_get_type. For
each iteration the value can be obtained using any of the type
getters (int/uint/boolean/null).
---
 src/json.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/json.h |  4 ++++
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/src/json.c b/src/json.c
index 6c88ed3a..cf233e56 100644
--- a/src/json.c
+++ b/src/json.c
@@ -88,7 +88,17 @@ static void iter_recurse(struct json_iter *iter, jsmntok=
_t *token,
 =

 	child->contents =3D c;
 	child->start =3D token - c->tokens;
+	child->current =3D child->start;
 	child->count =3D count_tokens_in_container(iter, token);
+
+	/*
+	 * Add one to include the object/array token itself. This is required
+	 * since 'current' points to the container initially. Only after a call
+	 * to json_iter_next() will 'current' point to the first token in the
+	 * container.
+	 */
+	if (token->type =3D=3D JSMN_OBJECT || token->type =3D=3D JSMN_ARRAY)
+		child->count++;
 }
 =

 struct json_contents *json_contents_new(const char *json, size_t json_len)
@@ -160,6 +170,7 @@ static void assign_arg(void *data, void *user_data)
 		break;
 	case JSON_OBJECT:
 	case JSON_PRIMITIVE:
+	case JSON_ARRAY:
 		iter_val =3D arg->value;
 =

 		if (!arg->v)
@@ -207,6 +218,7 @@ bool json_iter_parse(struct json_iter *iter, enum json_=
type type, ...)
 		case JSON_STRING:
 		case JSON_OBJECT:
 		case JSON_PRIMITIVE:
+		case JSON_ARRAY:
 			break;
 		default:
 			goto error;
@@ -271,7 +283,7 @@ static bool iter_get_primitive_data(struct json_iter *i=
ter, void **ptr,
 					size_t *len)
 {
 	struct json_contents *c =3D iter->contents;
-	jsmntok_t *t =3D c->tokens + iter->start;
+	jsmntok_t *t =3D c->tokens + iter->current;
 =

 	if (t->type !=3D JSMN_PRIMITIVE)
 		return false;
@@ -370,3 +382,45 @@ bool json_iter_get_null(struct json_iter *iter)
 =

 	return false;
 }
+
+enum json_type json_iter_get_type(struct json_iter *iter)
+{
+	struct json_contents *c =3D iter->contents;
+	jsmntok_t *t =3D c->tokens + iter->current;
+
+	return (enum json_type) t->type;
+}
+
+bool json_iter_next(struct json_iter *iter)
+{
+	struct json_contents *c =3D iter->contents;
+	jsmntok_t *t =3D c->tokens + iter->current;
+	int inc =3D 1;
+
+	/*
+	 * If this is the initial iteration skip this and just increment
+	 * current by 1 since this iterator points to a container which needs to
+	 * be advanced to the first token..
+	 *
+	 * In addition primitive types and empty containers will have a size
+	 * of 1, so no special handling is needed there.
+	 *
+	 * For non-empty containers 'current' needs to be advanced by all the
+	 * containers child tokens, plus the container itself.
+	 *
+	 * This check ensures:
+	 *    1. It is not the initial iteration
+	 *    2. This is a container
+	 *    3. The container is not empty
+	 */
+	if (iter->current !=3D iter->start && ((t->type =3D=3D JSMN_OBJECT ||
+					t->type =3D=3D JSMN_ARRAY) && t->size))
+		inc =3D count_tokens_in_container(iter, t) + 1;
+
+	if (c->tokens + iter->current + inc >=3D ITER_END(iter))
+		return false;
+
+	iter->current +=3D inc;
+
+	return true;
+}
diff --git a/src/json.h b/src/json.h
index 9f00a9d5..458deb93 100644
--- a/src/json.h
+++ b/src/json.h
@@ -42,6 +42,7 @@ struct json_iter {
 	struct json_contents *contents;
 	int start;
 	int count;
+	int current;
 };
 =

 #define JSON_MANDATORY(key, type, out) \
@@ -92,3 +93,6 @@ bool json_iter_get_int(struct json_iter *iter, int *i);
 bool json_iter_get_uint(struct json_iter *iter, unsigned int *i);
 bool json_iter_get_boolean(struct json_iter *iter, bool *b);
 bool json_iter_get_null(struct json_iter *iter);
+
+enum json_type json_iter_get_type(struct json_iter *iter);
+bool json_iter_next(struct json_iter *iter);
-- =

2.31.1

--===============5629549025836564308==--

