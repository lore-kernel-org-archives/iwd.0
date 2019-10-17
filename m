Content-Type: multipart/mixed; boundary="===============5467635166588062268=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2] util: add bounds check to util_get_{domain,username}
Date: Thu, 17 Oct 2019 08:49:21 -0700
Message-ID: <20191017154921.15516-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5467635166588062268==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Two cases were using strcpy, and the other two were using strncpy.
Instead all cases can use l_strlcpy which guarentees NULL termination.
---
 src/util.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/util.c b/src/util.c
index f787ce6b..1291d9c9 100644
--- a/src/util.c
+++ b/src/util.c
@@ -173,10 +173,10 @@ const char *util_get_domain(const char *identity)
 	for (c =3D identity; *c; c++) {
 		switch (*c) {
 		case '\\':
-			strncpy(domain, identity, c - identity);
+			l_strlcpy(domain, identity, c - identity);
 			return domain;
 		case '@':
-			strcpy(domain, c + 1);
+			l_strlcpy(domain, c + 1, sizeof(domain));
 			return domain;
 		default:
 			continue;
@@ -197,10 +197,10 @@ const char *util_get_username(const char *identity)
 	for (c =3D identity; *c; c++) {
 		switch (*c) {
 		case '\\':
-			strcpy(username, c + 1);
+			l_strlcpy(username, c + 1, sizeof(username));
 			return username;
 		case '@':
-			strncpy(username, identity, c - identity);
+			l_strlcpy(username, identity, c - identity);
 			return username;
 		default:
 			continue;
-- =

2.17.1

--===============5467635166588062268==--

