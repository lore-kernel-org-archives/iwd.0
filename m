Content-Type: multipart/mixed; boundary="===============8460954434624474128=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] util: add bounds check to util_get_{domain,username}
Date: Wed, 16 Oct 2019 16:43:01 -0700
Message-ID: <20191016234304.14716-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8460954434624474128==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/util.c b/src/util.c
index f787ce6b..f1860a33 100644
--- a/src/util.c
+++ b/src/util.c
@@ -176,7 +176,7 @@ const char *util_get_domain(const char *identity)
 			strncpy(domain, identity, c - identity);
 			return domain;
 		case '@':
-			strcpy(domain, c + 1);
+			strncpy(domain, c + 1, sizeof(domain));
 			return domain;
 		default:
 			continue;
@@ -197,7 +197,7 @@ const char *util_get_username(const char *identity)
 	for (c =3D identity; *c; c++) {
 		switch (*c) {
 		case '\\':
-			strcpy(username, c + 1);
+			strncpy(username, c + 1, sizeof(username));
 			return username;
 		case '@':
 			strncpy(username, identity, c - identity);
-- =

2.17.1

--===============8460954434624474128==--

