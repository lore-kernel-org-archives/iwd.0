Content-Type: multipart/mixed; boundary="===============0078191872244485231=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/4] crypto: use void* args for aes_siv_{encrypt,decrypt}
Date: Mon, 22 Nov 2021 12:44:22 -0800
Message-ID: <20211122204425.3567479-1-prestwoj@gmail.com>

--===============0078191872244485231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This makes these APIs more flexible for other storage types
---
 src/crypto.c | 8 ++++----
 src/crypto.h | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/crypto.c b/src/crypto.c
index 3f516940..c5bf6fe1 100644
--- a/src/crypto.c
+++ b/src/crypto.c
@@ -321,9 +321,9 @@ static bool s2v(struct l_checksum *cmac, struct iovec *=
iov, size_t iov_len,
 /*
  * RFC 5297 Section 2.6 - SIV Encrypt
  */
-bool aes_siv_encrypt(const uint8_t *key, size_t key_len, const uint8_t *in,
+bool aes_siv_encrypt(const void *key, size_t key_len, const void *in,
 			size_t in_len, struct iovec *ad, size_t num_ad,
-			uint8_t *out)
+			void *out)
 {
 	struct l_checksum *cmac;
 	struct l_cipher *ctr;
@@ -374,9 +374,9 @@ free_ctr:
 	return false;
 }
 =

-bool aes_siv_decrypt(const uint8_t *key, size_t key_len, const uint8_t *in,
+bool aes_siv_decrypt(const void *key, size_t key_len, const void *in,
 			size_t in_len, struct iovec *ad, size_t num_ad,
-			uint8_t *out)
+			void *out)
 {
 	struct l_checksum *cmac;
 	struct l_cipher *ctr;
diff --git a/src/crypto.h b/src/crypto.h
index d359da61..eb48fe5b 100644
--- a/src/crypto.h
+++ b/src/crypto.h
@@ -83,12 +83,12 @@ bool aes_wrap(const uint8_t *kek, const uint8_t *in, si=
ze_t len, uint8_t *out);
 bool arc4_skip(const uint8_t *key, size_t key_len, size_t skip,
 		const uint8_t *in, size_t len, uint8_t *out);
 =

-bool aes_siv_encrypt(const uint8_t *key, size_t key_len, const uint8_t *in,
+bool aes_siv_encrypt(const void *key, size_t key_len, const void *in,
 			size_t in_len, struct iovec *ad, size_t num_ad,
-			uint8_t *out);
-bool aes_siv_decrypt(const uint8_t *key, size_t key_len, const uint8_t *in,
+			void *out);
+bool aes_siv_decrypt(const void *key, size_t key_len, const void *in,
 			size_t in_len, struct iovec *ad, size_t num_ad,
-			uint8_t *out);
+			void *out);
 =

 int crypto_cipher_key_len(enum crypto_cipher cipher);
 int crypto_cipher_tk_bits(enum crypto_cipher cipher);
-- =

2.31.1

--===============0078191872244485231==--

