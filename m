Content-Type: multipart/mixed; boundary="===============0317322309351167825=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/8] json: add support for primitive types
Date: Wed, 05 Jan 2022 10:46:20 -0800
Message-ID: <20220105184627.329505-1-prestwoj@gmail.com>

--===============0317322309351167825==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds support for boolean, (unsigned) integers, and
null types. JSON_PRIMITIVE should be used as the type when
parsing and the value should be struct json_iter.

Once parsed the actual value can be obtained using one of
the primitive getters. If the type does not match they will
return false.

If using JSON_OPTIONAL with JSON_PRIMITIVE the resulting
iterator can be checked with json_iter_is_valid. If false
the key/value was not found or the type was not matching.
---
 src/json.c | 138 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 src/json.h |  13 ++++-
 2 files changed, 143 insertions(+), 8 deletions(-)

diff --git a/src/json.c b/src/json.c
index 39570e7e..a83ba464 100644
--- a/src/json.c
+++ b/src/json.c
@@ -85,14 +85,26 @@ static int find_object_tokens(struct json_iter *iter, j=
smntok_t *object)
 	return next - object - 1;
 }
 =

-static void iter_recurse(struct json_iter *iter, jsmntok_t *object,
+static void iter_recurse(struct json_iter *iter, jsmntok_t *token,
 				struct json_iter *child)
 {
 	struct json_contents *c =3D iter->contents;
 =

 	child->contents =3D c;
-	child->start =3D object - c->tokens;
-	child->count =3D find_object_tokens(iter, object);
+	child->start =3D token - c->tokens;
+
+	/*
+	* For objects iterating all tokens with the object as the parent
+	* parent should give the total number of tokens for this object.
+	*
+	* For strings/primitives the value is always going to one token which
+	* will not be iteratable. Because of this the count is set to zero to
+	* disallow any iteration on this child iterator.
+	*/
+	if (token->type =3D=3D JSMN_OBJECT)
+		child->count =3D find_object_tokens(iter, token);
+	else
+		child->count =3D 0;
 }
 =

 struct json_contents *json_contents_new(const char *json, size_t json_len)
@@ -153,7 +165,7 @@ static void assign_arg(void *data, void *user_data)
 	struct json_arg *arg =3D data;
 	struct json_contents *c =3D iter->contents;
 	char **sval;
-	struct json_iter *oval;
+	struct json_iter *iter_val;
 =

 	switch (arg->type) {
 	case JSON_STRING:
@@ -163,12 +175,13 @@ static void assign_arg(void *data, void *user_data)
 =

 		break;
 	case JSON_OBJECT:
-		oval =3D arg->value;
+	case JSON_PRIMITIVE:
+		iter_val =3D arg->value;
 =

 		if (!arg->v)
-			oval->start =3D -1;
+			iter_val->start =3D -1;
 		else
-			iter_recurse(iter, arg->v, oval);
+			iter_recurse(iter, arg->v, iter_val);
 =

 		break;
 	default:
@@ -209,6 +222,7 @@ bool json_iter_parse(struct json_iter *iter, enum json_=
type type, ...)
 			goto done;
 		case JSON_STRING:
 		case JSON_OBJECT:
+		case JSON_PRIMITIVE:
 			break;
 		default:
 			goto error;
@@ -268,3 +282,113 @@ error:
 	l_queue_destroy(args, l_free);
 	return false;
 }
+
+static bool iter_get_primitive_data(struct json_iter *iter, void **ptr,
+					size_t *len)
+{
+	struct json_contents *c =3D iter->contents;
+	jsmntok_t *t =3D c->tokens + iter->start;
+
+	if (t->type !=3D JSMN_PRIMITIVE)
+		return false;
+
+	*ptr =3D TOK_PTR(c->json, t);
+	*len =3D TOK_LEN(t);
+
+	return true;
+}
+
+bool json_iter_get_int(struct json_iter *iter, int *i)
+{
+	void *ptr;
+	size_t len;
+	long int r;
+	int t;
+	char *endp;
+
+	if (json_iter_get_null(iter) || json_iter_get_boolean(iter, NULL))
+		return false;
+
+	if (!iter_get_primitive_data(iter, &ptr, &len))
+		return false;
+
+	errno =3D 0;
+
+	t =3D r =3D strtol(ptr, &endp, 0);
+	if (endp =3D=3D ptr)
+		return false;
+
+	if (errno =3D=3D ERANGE || r !=3D t)
+		return false;
+
+	if (i)
+		*i =3D r;
+
+	return true;
+}
+
+bool json_iter_get_uint(struct json_iter *iter, unsigned int *i)
+{
+	void *ptr;
+	size_t len;
+	unsigned long int r;
+	unsigned int t;
+	char *endp;
+
+	if (json_iter_get_null(iter) || json_iter_get_boolean(iter, NULL))
+		return false;
+
+	if (!iter_get_primitive_data(iter, &ptr, &len))
+		return false;
+
+	errno =3D 0;
+
+	t =3D r =3D strtoul(ptr, &endp, 0);
+	if (endp =3D=3D ptr)
+		return false;
+
+	if (errno =3D=3D ERANGE || r !=3D t)
+		return false;
+
+	if (i)
+		*i =3D r;
+
+	return true;
+}
+
+bool json_iter_get_boolean(struct json_iter *iter, bool *b)
+{
+	void *ptr;
+	size_t len;
+
+	if (!iter_get_primitive_data(iter, &ptr, &len))
+		return false;
+
+	if (len =3D=3D 4 && !memcmp(ptr, "true", 4)) {
+		if (b)
+			*b =3D true;
+
+		return true;
+	} else if (len =3D=3D 5 && !memcmp(ptr, "false", 5)) {
+		if (b)
+			*b =3D false;
+
+		return true;
+	}
+
+	return false;
+}
+
+bool json_iter_get_null(struct json_iter *iter)
+{
+	void *ptr;
+	size_t len;
+
+	if (!iter_get_primitive_data(iter, &ptr, &len))
+		return false;
+
+	if (len =3D=3D 4 && !memcmp(ptr, "null", 4))
+		return true;
+
+	return false;
+}
diff --git a/src/json.h b/src/json.h
index 915b675b..9f00a9d5 100644
--- a/src/json.h
+++ b/src/json.h
@@ -73,11 +73,22 @@ void json_iter_init(struct json_iter *iter, struct json=
_contents *c);
  *
  * String values should be of type char ** and must be freed
  * Object values should be of type struct json_iter *
+ * Primitive types (numbers, booleans, null) should be of type
+ * 		struct json_iter *. This is to allow the caller to distinguish
+ * 		between the actual value type after parsing using a getter for
+ * 		the expected type (get_uint/get_int/get_boolean etc.). In
+ * 		addition this lets the caller use JSON_OPTIONAL and check post
+ * 		json_iter_parse if the iterator is valid (json_iter_is_valid).
  *
  * No other types are supported at this time, and json_iter_parse will fai=
l if
  * other types are encountered.
  *
  * JSON_OPTIONAL string values will point to NULL if not found
- * JSON_OPTIONAL objects can be checked with json_object_not_found.
+ * JSON_OPTIONAL objects/primitives can be checked with json_object_is_val=
id.
  */
 bool json_iter_parse(struct json_iter *iter, enum json_type type, ...);
+
+bool json_iter_get_int(struct json_iter *iter, int *i);
+bool json_iter_get_uint(struct json_iter *iter, unsigned int *i);
+bool json_iter_get_boolean(struct json_iter *iter, bool *b);
+bool json_iter_get_null(struct json_iter *iter);
-- =

2.31.1

--===============0317322309351167825==--

