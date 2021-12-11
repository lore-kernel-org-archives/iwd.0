Content-Type: multipart/mixed; boundary="===============5526961130260169000=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] json: fix pointer arithmetic error
Date: Fri, 10 Dec 2021 16:13:07 -0800
Message-ID: <20211211001307.2102791-1-prestwoj@gmail.com>

--===============5526961130260169000==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Subtracting the pointers is sufficient for counting the tokens,
they do not need to be modulus the size of jsmntok_t
---
 src/json.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/json.c b/src/json.c
index 20adcec7..39570e7e 100644
--- a/src/json.c
+++ b/src/json.c
@@ -82,7 +82,7 @@ static int find_object_tokens(struct json_iter *iter, jsm=
ntok_t *object)
 	if (!next)
 		next =3D ITER_END(iter);
 =

-	return ((next - object) % sizeof(jsmntok_t)) - 1;
+	return next - object - 1;
 }
 =

 static void iter_recurse(struct json_iter *iter, jsmntok_t *object,
@@ -91,7 +91,7 @@ static void iter_recurse(struct json_iter *iter, jsmntok_=
t *object,
 	struct json_contents *c =3D iter->contents;
 =

 	child->contents =3D c;
-	child->start =3D (object - c->tokens) % sizeof(jsmntok_t);
+	child->start =3D object - c->tokens;
 	child->count =3D find_object_tokens(iter, object);
 }
 =

-- =

2.31.1

--===============5526961130260169000==--

