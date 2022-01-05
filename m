Content-Type: multipart/mixed; boundary="===============7762192793316963517=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/8] json: add support for array iteration
Date: Wed, 05 Jan 2022 10:46:22 -0800
Message-ID: <20220105184627.329505-3-prestwoj@gmail.com>
In-Reply-To: 20220105184627.329505-1-prestwoj@gmail.com

--===============7762192793316963517==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Arrays can now be parsed using the JSON_ARRAY type (stored in
a struct json_iter) then iterated using json_iter_next. When
iterating the type can be checked with json_iter_get_type. For
each iteration the value can be obtained using any of the type
getters (int/uint/boolean/null).

For now only primitive type arrays are supported.

Several internal APIs were renamed/altered to make them more
general purpose for both arrays and objects.
---
 src/json.c | 64 ++++++++++++++++++++++++++++++++++++++++++------------
 src/json.h |  5 +++++
 2 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/src/json.c b/src/json.c
index a83ba464..879d43be 100644
--- a/src/json.c
+++ b/src/json.c
@@ -56,7 +56,8 @@ struct json_contents {
 	jsmn_parser *p;
 };
 =

-static jsmntok_t *next_key_in_parent(struct json_iter *iter, jsmntok_t *cu=
rrent)
+static jsmntok_t *next_token_in_parent(struct json_iter *iter,
+					jsmntok_t *current)
 {
 	int parent =3D current->parent;
 =

@@ -69,20 +70,14 @@ static jsmntok_t *next_key_in_parent(struct json_iter *=
iter, jsmntok_t *current)
 	return NULL;
 }
 =

-/*
- * 'object' is expected to be a value, so object - 1 is its key. Find
- * the next key who's parent matches the parent of object - 1. The
- * token preceeding this next key will mark the end of 'object'.
- */
-static int find_object_tokens(struct json_iter *iter, jsmntok_t *object)
+static int find_parent_tokens(struct json_iter *iter, jsmntok_t *token)
 {
-	jsmntok_t *next =3D next_key_in_parent(iter, object - 1);
+	jsmntok_t *next =3D next_token_in_parent(iter, token);
 =

-	/* End of token list */
 	if (!next)
 		next =3D ITER_END(iter);
 =

-	return next - object - 1;
+	return next - token;
 }
 =

 static void iter_recurse(struct json_iter *iter, jsmntok_t *token,
@@ -92,18 +87,29 @@ static void iter_recurse(struct json_iter *iter, jsmnto=
k_t *token,
 =

 	child->contents =3D c;
 	child->start =3D token - c->tokens;
+	child->current =3D child->start;
 =

 	/*
 	* For objects iterating all tokens with the object as the parent
 	* parent should give the total number of tokens for this object.
 	*
+	* For arrays we want to count the tokens inside the array itself. We
+	* cannot simply count until we reach a different parent than the array
+	* due to the possibility of nested objects. Instead we find the next
+	* token with the same parent as the array (the next key in the object).
+	* This offset will include both the arrays key, and the array itself,
+	* hence subtracting 2.
+	*
 	* For strings/primitives the value is always going to one token which
 	* will not be iteratable. Because of this the count is set to zero to
 	* disallow any iteration on this child iterator.
 	*/
 	if (token->type =3D=3D JSMN_OBJECT)
-		child->count =3D find_object_tokens(iter, token);
-	else
+		child->count =3D find_parent_tokens(iter, token);
+	else if (token->type =3D=3D JSMN_ARRAY) {
+		child->count =3D find_parent_tokens(iter, token - 1) - 2;
+		child->array =3D true;
+	} else
 		child->count =3D 0;
 }
 =

@@ -176,6 +182,7 @@ static void assign_arg(void *data, void *user_data)
 		break;
 	case JSON_OBJECT:
 	case JSON_PRIMITIVE:
+	case JSON_ARRAY:
 		iter_val =3D arg->value;
 =

 		if (!arg->v)
@@ -223,6 +230,7 @@ bool json_iter_parse(struct json_iter *iter, enum json_=
type type, ...)
 		case JSON_STRING:
 		case JSON_OBJECT:
 		case JSON_PRIMITIVE:
+		case JSON_ARRAY:
 			break;
 		default:
 			goto error;
@@ -252,7 +260,7 @@ bool json_iter_parse(struct json_iter *iter, enum json_=
type type, ...)
 				break;
 			}
 =

-			next =3D next_key_in_parent(iter, next);
+			next =3D next_token_in_parent(iter, next);
 			if (!next)
 				break;
 		}
@@ -287,7 +295,7 @@ static bool iter_get_primitive_data(struct json_iter *i=
ter, void **ptr,
 					size_t *len)
 {
 	struct json_contents *c =3D iter->contents;
-	jsmntok_t *t =3D c->tokens + iter->start;
+	jsmntok_t *t =3D c->tokens + iter->current;
 =

 	if (t->type !=3D JSMN_PRIMITIVE)
 		return false;
@@ -392,3 +400,31 @@ bool json_iter_get_null(struct json_iter *iter)
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
+
+	/* For now only allow json_iter_next() on arrays */
+	if (!iter->array)
+		return false;
+
+	if (c->tokens + iter->current + 1 > ITER_END(iter))
+		return false;
+
+	iter->current++;
+
+	/* TODO: Add support for nested array iteration */
+	if ((c->tokens + iter->current)->type =3D=3D JSMN_ARRAY)
+		return false;
+
+	return true;
+}
diff --git a/src/json.h b/src/json.h
index 9f00a9d5..75ac9853 100644
--- a/src/json.h
+++ b/src/json.h
@@ -42,6 +42,8 @@ struct json_iter {
 	struct json_contents *contents;
 	int start;
 	int count;
+	int current;
+	bool array : 1;
 };
 =

 #define JSON_MANDATORY(key, type, out) \
@@ -92,3 +94,6 @@ bool json_iter_get_int(struct json_iter *iter, int *i);
 bool json_iter_get_uint(struct json_iter *iter, unsigned int *i);
 bool json_iter_get_boolean(struct json_iter *iter, bool *b);
 bool json_iter_get_null(struct json_iter *iter);
+
+enum json_type json_iter_get_type(struct json_iter *iter);
+bool json_iter_next(struct json_iter *iter);
-- =

2.31.1

--===============7762192793316963517==--

