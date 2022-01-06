Content-Type: multipart/mixed; boundary="===============3818176949263814677=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 3/5] json: add NULL check for container on get_container
Date: Thu, 06 Jan 2022 14:52:56 -0800
Message-ID: <20220106225258.570850-3-prestwoj@gmail.com>
In-Reply-To: 20220106225258.570850-1-prestwoj@gmail.com

--===============3818176949263814677==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In case the caller just wants to check an object is iterable,
without actually iterating it.
---
 src/json.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/json.c b/src/json.c
index b89fbaa6..0942dae3 100644
--- a/src/json.c
+++ b/src/json.c
@@ -393,7 +393,8 @@ bool json_iter_get_container(struct json_iter *iter,
 	if (t->type !=3D JSMN_OBJECT && t->type !=3D JSMN_ARRAY)
 		return false;
 =

-	iter_recurse(iter, t, container);
+	if (container)
+		iter_recurse(iter, t, container);
 =

 	return true;
 }
-- =

2.31.1

--===============3818176949263814677==--

