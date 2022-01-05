Content-Type: multipart/mixed; boundary="===============3650293108914316662=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 6/8] json: support arrays of objects
Date: Wed, 05 Jan 2022 10:46:25 -0800
Message-ID: <20220105184627.329505-6-prestwoj@gmail.com>
In-Reply-To: 20220105184627.329505-1-prestwoj@gmail.com

--===============3650293108914316662==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/json.c | 39 +++++++++++++++++++++++++++++++++++++--
 src/json.h |  2 ++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/src/json.c b/src/json.c
index 4e4c004e..d38d884e 100644
--- a/src/json.c
+++ b/src/json.c
@@ -401,6 +401,21 @@ bool json_iter_get_null(struct json_iter *iter)
 	return false;
 }
 =

+bool json_iter_get_container(struct json_iter *iter,
+				struct json_iter *container)
+{
+	struct json_contents *c =3D iter->contents;
+	jsmntok_t *t =3D c->tokens + iter->current;
+
+	/* TODO: Add nested array support */
+	if (t->type !=3D JSMN_OBJECT)
+		return false;
+
+	iter_recurse(iter, t, container);
+
+	return true;
+}
+
 enum json_type json_iter_get_type(struct json_iter *iter)
 {
 	struct json_contents *c =3D iter->contents;
@@ -412,15 +427,35 @@ enum json_type json_iter_get_type(struct json_iter *i=
ter)
 bool json_iter_next(struct json_iter *iter)
 {
 	struct json_contents *c =3D iter->contents;
+	jsmntok_t *t =3D c->tokens + iter->current;
+	int inc =3D 1;
 =

 	/* For now only allow json_iter_next() on arrays */
 	if (!iter->array)
 		return false;
 =

-	if (c->tokens + iter->current + 1 > ITER_END(iter))
+	/*
+	 * If this is the initial iteration skip this and just increment
+	 * current by 1 since this iterator points to an array which needs to
+	 * be advanced to the first token in the array.
+	 *
+	 * In addition primitive types and empty object will have a size of 1,
+	 * so no special handling is needed there.
+	 *
+	 * For objects (and arrays in the future), 'current' needs to be
+	 * advanced by all objects child tokens plus the object token itself.
+	 * This check ensures:
+	 *    1. It is not the initial iteration
+	 *    2. This is an object
+	 *    3. The object is not empty
+	 */
+	if (iter->current !=3D iter->start && t->type =3D=3D JSMN_OBJECT && t->si=
ze)
+		inc =3D find_parent_tokens(iter, t) + 1;
+
+	if (c->tokens + iter->current + inc > ITER_END(iter))
 		return false;
 =

-	iter->current++;
+	iter->current +=3D inc;
 =

 	/* TODO: Add support for nested array iteration */
 	if ((c->tokens + iter->current)->type =3D=3D JSMN_ARRAY)
diff --git a/src/json.h b/src/json.h
index 75ac9853..c7993a5a 100644
--- a/src/json.h
+++ b/src/json.h
@@ -94,6 +94,8 @@ bool json_iter_get_int(struct json_iter *iter, int *i);
 bool json_iter_get_uint(struct json_iter *iter, unsigned int *i);
 bool json_iter_get_boolean(struct json_iter *iter, bool *b);
 bool json_iter_get_null(struct json_iter *iter);
+bool json_iter_get_container(struct json_iter *iter,
+				struct json_iter *container);
 =

 enum json_type json_iter_get_type(struct json_iter *iter);
 bool json_iter_next(struct json_iter *iter);
-- =

2.31.1

--===============3650293108914316662==--

