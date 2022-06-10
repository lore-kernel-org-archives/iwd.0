Content-Type: multipart/mixed; boundary="===============8962657122122249863=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/3] storage: remove unused variables
Date: Fri, 10 Jun 2022 12:52:40 -0700
Message-ID: <20220610195242.455453-1-prestwoj@gmail.com>

--===============8962657122122249863==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The auto macros apparently made it difficult for gcc to
detect, but clang was able to find them.
---
 src/storage.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index aa8066b1..2100d08d 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -456,11 +456,9 @@ char *__storage_encrypt(const struct l_settings *setti=
ngs, const char *name,
 int __storage_decrypt(struct l_settings *settings, const char *ssid,
 				bool *encrypt)
 {
-	_auto_(l_settings_free) struct l_settings *security =3D NULL;
 	_auto_(l_free) uint8_t *encrypted =3D NULL;
 	_auto_(l_free) uint8_t *decrypted =3D NULL;
 	_auto_(l_free) uint8_t *salt =3D NULL;
-	_auto_(l_strv_free) char **embedded =3D NULL;
 	_auto_(l_strv_free) char **groups =3D NULL;
 	char **i;
 	size_t elen, slen;
-- =

2.34.1

--===============8962657122122249863==--

