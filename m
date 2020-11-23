Content-Type: multipart/mixed; boundary="===============4912178461156923249=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] netconfig: fix freeing invalid pointer
Date: Mon, 23 Nov 2020 15:05:54 -0800
Message-ID: <20201123230554.4119658-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4912178461156923249==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If l_rtnl_ifaddr4_extract does not set the values they would
get freed. Instead initialize to NULL so the cleanup free is
a no op.
---
 src/netconfig.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index dcb88749..610635cd 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -441,9 +441,9 @@ static void netconfig_ifaddr_added(struct netconfig *ne=
tconfig,
 					const struct ifaddrmsg *ifa,
 					uint32_t len)
 {
-	L_AUTO_FREE_VAR(char *, label);
-	L_AUTO_FREE_VAR(char *, ip);
-	L_AUTO_FREE_VAR(char *, broadcast);
+	L_AUTO_FREE_VAR(char *, label) =3D NULL;
+	L_AUTO_FREE_VAR(char *, ip) =3D NULL;
+	L_AUTO_FREE_VAR(char *, broadcast) =3D NULL;
 =

 	l_rtnl_ifaddr4_extract(ifa, len, &label, &ip, &broadcast);
 	l_debug("%s: ifaddr %s/%u broadcast %s", label,
-- =

2.26.2

--===============4912178461156923249==--

