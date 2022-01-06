Content-Type: multipart/mixed; boundary="===============3910448049343759971=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 4/5] json: restrict json_iter_{parse,next} to objects/arrays
Date: Thu, 06 Jan 2022 14:42:15 -0800
Message-ID: <20220106224216.569171-4-prestwoj@gmail.com>
In-Reply-To: 20220106224216.569171-1-prestwoj@gmail.com

--===============3910448049343759971==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

json_iter_parse is only meant to work on objects while
json_iter_next is only meant to work on arrays.

This adds checks in both APIs to ensure they aren't being
used incorrectly.
---
 src/json.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/json.c b/src/json.c
index 0942dae3..869a3f43 100644
--- a/src/json.c
+++ b/src/json.c
@@ -200,6 +200,9 @@ bool json_iter_parse(struct json_iter *iter, enum json_=
type type, ...)
 	if (iter->start =3D=3D -1)
 		return false;
 =

+	if (c->tokens[iter->start].type !=3D JSMN_OBJECT)
+		return false;
+
 	args =3D l_queue_new();
 =

 	va_start(va, type);
@@ -427,6 +430,9 @@ bool json_iter_next(struct json_iter *iter)
 	jsmntok_t *t =3D c->tokens + iter->current;
 	int inc =3D 1;
 =

+	if (iter->current =3D=3D iter->start && t->type !=3D JSMN_ARRAY)
+		return false;
+
 	/*
 	 * If this is the initial iteration skip this and just increment
 	 * current by 1 since this iterator points to a container which needs to
-- =

2.31.1

--===============3910448049343759971==--

