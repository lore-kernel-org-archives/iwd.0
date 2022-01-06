Content-Type: multipart/mixed; boundary="===============7234639709380030774=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 7/9] json: add json_iter_get_container
Date: Thu, 06 Jan 2022 11:50:05 -0800
Message-ID: <20220106195007.528618-7-prestwoj@gmail.com>
In-Reply-To: 20220106195007.528618-1-prestwoj@gmail.com

--===============7234639709380030774==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows getting an iterator for a container nested inside
an array.
---
 src/json.c | 14 ++++++++++++++
 src/json.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/src/json.c b/src/json.c
index aec5fe5c..6e40629d 100644
--- a/src/json.c
+++ b/src/json.c
@@ -383,6 +383,20 @@ bool json_iter_get_null(struct json_iter *iter)
 	return false;
 }
 =

+bool json_iter_get_container(struct json_iter *iter,
+				struct json_iter *container)
+{
+	struct json_contents *c =3D iter->contents;
+	jsmntok_t *t =3D c->tokens + iter->current;
+
+	if (t->type !=3D JSMN_OBJECT && t->type !=3D JSMN_ARRAY)
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
diff --git a/src/json.h b/src/json.h
index 458deb93..518d778c 100644
--- a/src/json.h
+++ b/src/json.h
@@ -93,6 +93,8 @@ bool json_iter_get_int(struct json_iter *iter, int *i);
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

--===============7234639709380030774==--

