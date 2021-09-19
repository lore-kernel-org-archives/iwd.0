Content-Type: multipart/mixed; boundary="===============5608781867201384408=="
MIME-Version: 1.0
From: Fabrice Fontaine <fontaine.fabrice at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] src/sae.c: Use realloc(3) instead of reallocarray(3)
Date: Sun, 19 Sep 2021 10:57:10 +0200
Message-ID: <20210919085710.1805075-1-fontaine.fabrice@gmail.com>

--===============5608781867201384408==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

reallocarray(3) has been added to glibc relatively recently (version
2.26, from 2017) and apparently not all users run new enough glibc.
Moreover, reallocarray is not available with uclibc-ng. Just use
realloc(3) for now since in this case there's no real risk of overflow.
This will avoid the following build failure since commit
891b78e9e892a3bcd800eb3a298e6380e9a15dd1:

/home/giuliobenetti/autobuild/run/instance-3/output-1/host/lib/gcc/xtensa-b=
uildroot-linux-uclibc/10.3.0/../../../../xtensa-buildroot-linux-uclibc/bin/=
ld: src/sae.o: in function `sae_rx_authenticate':
sae.c:(.text+0xd74): undefined reference to `reallocarray'

Fixes:
 - http://autobuild.buildroot.org/results/c6d3f86282c44645b4f1c61882dc63ccf=
c8eb35a

Signed-off-by: Fabrice Fontaine <fontaine.fabrice(a)gmail.com>
---
 src/sae.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/sae.c b/src/sae.c
index 7e6377f5..d04891e7 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -104,7 +104,7 @@ static void sae_rejected_groups_append(struct sae_sm *s=
m, uint16_t group)
 	uint16_t i;
 =

 	if (!sm->rejected_groups) {
-		sm->rejected_groups =3D reallocarray(NULL, 2, sizeof(uint16_t));
+		sm->rejected_groups =3D realloc(NULL, 2 * sizeof(uint16_t));
 		sm->rejected_groups[0] =3D 1;
 		sm->rejected_groups[1] =3D group;
 		return;
@@ -114,8 +114,8 @@ static void sae_rejected_groups_append(struct sae_sm *s=
m, uint16_t group)
 		if (sm->rejected_groups[i] =3D=3D group)
 			return;
 =

-	sm->rejected_groups =3D reallocarray(sm->rejected_groups,
-						i + 1, sizeof(uint16_t));
+	sm->rejected_groups =3D realloc(sm->rejected_groups,
+					(i + 1) * sizeof(uint16_t));
 	sm->rejected_groups[0] +=3D 1;
 	sm->rejected_groups[i] =3D group;
 }
-- =

2.33.0

--===============5608781867201384408==--

