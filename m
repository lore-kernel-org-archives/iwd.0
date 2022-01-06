Content-Type: multipart/mixed; boundary="===============7358646471813652353=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/5] json: add json_iter_get_string
Date: Thu, 06 Jan 2022 14:42:12 -0800
Message-ID: <20220106224216.569171-1-prestwoj@gmail.com>

--===============7358646471813652353==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/json.c | 14 ++++++++++++++
 src/json.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/src/json.c b/src/json.c
index b48dba4a..b89fbaa6 100644
--- a/src/json.c
+++ b/src/json.c
@@ -398,6 +398,20 @@ bool json_iter_get_container(struct json_iter *iter,
 	return true;
 }
 =

+bool json_iter_get_string(struct json_iter *iter, char **s)
+{
+	struct json_contents *c =3D iter->contents;
+	jsmntok_t *t =3D c->tokens + iter->current;
+
+	if (t->type !=3D JSMN_STRING)
+		return false;
+
+	if (s)
+		*s =3D TOK_TO_STR(c->json, t);
+
+	return true;
+}
+
 enum json_type json_iter_get_type(struct json_iter *iter)
 {
 	struct json_contents *c =3D iter->contents;
diff --git a/src/json.h b/src/json.h
index 518d778c..1db3428d 100644
--- a/src/json.h
+++ b/src/json.h
@@ -95,6 +95,7 @@ bool json_iter_get_boolean(struct json_iter *iter, bool *=
b);
 bool json_iter_get_null(struct json_iter *iter);
 bool json_iter_get_container(struct json_iter *iter,
 				struct json_iter *container);
+bool json_iter_get_string(struct json_iter *iter, char **s);
 =

 enum json_type json_iter_get_type(struct json_iter *iter);
 bool json_iter_next(struct json_iter *iter);
-- =

2.31.1

--===============7358646471813652353==--

