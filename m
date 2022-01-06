Content-Type: multipart/mixed; boundary="===============0279693814090169316=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 1/9] json: fix find_object_tokens
Date: Thu, 06 Jan 2022 11:49:59 -0800
Message-ID: <20220106195007.528618-1-prestwoj@gmail.com>

--===============0279693814090169316==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

First, this was renamed to 'count_tokens_in_container' to be
more general purpose (i.e. include future array counting).

The way the tokens are counted also changed to be more intuitive.
While the previous way was correct, it was somewhat convoluted in
how it worked (finding the next parent of the objects parent).

Instead we can use the container token itself as the parent and
begin counting tokens. When we find a token with a parent index
less than the target we have reached the end of this container.
This also works for nested containers, including arrays since we
no longer rely on a key (which an array element would not have).

For example::

{
	"first":{"foo":"bar"},
	"second":{"foo2":"bar2"}
}

index 0		<overall object>
index 1		"first"		with parent 0
index 2         {"foo":"bar"}   with parent 1

Counting tokens inside "first"'s object we have:

index 3		"foo"		with parent 2
index 4		"bar"		with parent 3

If we continue counting we reach:

index 5		"second"	with parent 0

This terminates the counting loop since the parent index is
less than '2' (the index of {"foo":"bar"} object).
---
 src/json.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/src/json.c b/src/json.c
index 39570e7e..a917fb89 100644
--- a/src/json.c
+++ b/src/json.c
@@ -69,20 +69,16 @@ static jsmntok_t *next_key_in_parent(struct json_iter *=
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
+static int count_tokens_in_container(struct json_iter *iter, jsmntok_t *co=
ntainer)
 {
-	jsmntok_t *next =3D next_key_in_parent(iter, object - 1);
+	int idx =3D container - iter->contents->tokens;
+	jsmntok_t *contents;
 =

-	/* End of token list */
-	if (!next)
-		next =3D ITER_END(iter);
+	for (contents =3D ++container; contents < ITER_END(iter); contents++)
+		if (contents->parent < idx)
+			break;
 =

-	return next - object - 1;
+	return contents - container;
 }
 =

 static void iter_recurse(struct json_iter *iter, jsmntok_t *object,
@@ -92,7 +88,7 @@ static void iter_recurse(struct json_iter *iter, jsmntok_=
t *object,
 =

 	child->contents =3D c;
 	child->start =3D object - c->tokens;
-	child->count =3D find_object_tokens(iter, object);
+	child->count =3D count_tokens_in_container(iter, object);
 }
 =

 struct json_contents *json_contents_new(const char *json, size_t json_len)
-- =

2.31.1

--===============0279693814090169316==--

