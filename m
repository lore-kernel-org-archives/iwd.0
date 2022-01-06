Content-Type: multipart/mixed; boundary="===============0499506219211862881=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 5/9] json: increase default token size to 60
Date: Thu, 06 Jan 2022 11:50:03 -0800
Message-ID: <20220106195007.528618-5-prestwoj@gmail.com>
In-Reply-To: 20220106195007.528618-1-prestwoj@gmail.com

--===============0499506219211862881==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/json.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/json.c b/src/json.c
index cf233e56..aec5fe5c 100644
--- a/src/json.c
+++ b/src/json.c
@@ -33,7 +33,7 @@
 #include "shared/jsmn.h"
 =

 /* Max number of tokens supported. Increase if larger objects are expected=
 */
-#define JSON_DEFAULT_TOKENS 30
+#define JSON_DEFAULT_TOKENS 60
 =

 #define TOK_LEN(token) (token)->end - (token)->start
 #define TOK_PTR(json, token) (void *)((json) + (token)->start)
-- =

2.31.1

--===============0499506219211862881==--

