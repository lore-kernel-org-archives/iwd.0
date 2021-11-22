Content-Type: multipart/mixed; boundary="===============0883360407909244940=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/4] crypto: use void* for hkdf_expand
Date: Mon, 22 Nov 2021 12:44:23 -0800
Message-ID: <20211122204425.3567479-2-prestwoj@gmail.com>
In-Reply-To: 20211122204425.3567479-1-prestwoj@gmail.com

--===============0883360407909244940==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This makes it more flexible for other storage types
---
 src/crypto.c | 2 +-
 src/crypto.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/crypto.c b/src/crypto.c
index c5bf6fe1..7d5e42fe 100644
--- a/src/crypto.c
+++ b/src/crypto.c
@@ -860,7 +860,7 @@ bool hkdf_extract(enum l_checksum_type type, const void=
 *key,
 	return (ret =3D=3D (int) dlen);
 }
 =

-bool hkdf_expand(enum l_checksum_type type, const uint8_t *key, size_t key=
_len,
+bool hkdf_expand(enum l_checksum_type type, const void *key, size_t key_le=
n,
 			const char *info, void *out, size_t out_len)
 {
 	return prf_plus(type, key, key_len, info, out, out_len, 0);
diff --git a/src/crypto.h b/src/crypto.h
index eb48fe5b..b6fa2ec3 100644
--- a/src/crypto.h
+++ b/src/crypto.h
@@ -122,7 +122,7 @@ bool prf_plus(enum l_checksum_type type, const void *ke=
y, size_t key_len,
 bool hkdf_extract(enum l_checksum_type type, const void *key, size_t key_l=
en,
 				uint8_t num_args, void *out, ...);
 =

-bool hkdf_expand(enum l_checksum_type type, const uint8_t *key, size_t key=
_len,
+bool hkdf_expand(enum l_checksum_type type, const void *key, size_t key_le=
n,
 				const char *info, void *out, size_t out_len);
 =

 bool crypto_derive_pairwise_ptk(const uint8_t *pmk, size_t pmk_len,
-- =

2.31.1

--===============0883360407909244940==--

