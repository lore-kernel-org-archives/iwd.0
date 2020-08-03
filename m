Content-Type: multipart/mixed; boundary="===============9036908065290607362=="
MIME-Version: 1.0
From: Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] crypto: incorporate C implementation of ARC4
Date: Mon, 03 Aug 2020 12:45:09 +0200
Message-ID: <20200803104509.124604-1-ardb@kernel.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9036908065290607362==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Incorporate the LGPL v2.1 licensed implementation of ARC4, taken from
the Nettle project (https://git.lysator.liu.se/nettle/nettle.git,
commit 3e7a480a1e351884), and tweak it a bit so we don't have to
operate on a skip buffer to fast forward the stream cipher, but can
simply invoke it with NULL dst or src arguments to achieve the same.

This removes the dependency [via libell] on the OS's implementation of
ecb(arc4), which may be going away, and which is not usually accelerated
in the first place.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 src/crypto.c      | 82 ++++++++++++++++++++++++++++++-----------------
 src/main.c        |  8 -----
 unit/test-eapol.c |  3 +-
 3 files changed, 53 insertions(+), 40 deletions(-)

diff --git a/src/crypto.c b/src/crypto.c
index 696b59901284..f5f8e24df1ea 100644
--- a/src/crypto.c
+++ b/src/crypto.c
@@ -18,6 +18,8 @@
  *  License along with this library; if not, write to the Free Software
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
  *
+ *  (contains ARC4 implementation copyright (c) 2001 Niels M=C3=B6ller)
+ *
  */
 =

 #ifdef HAVE_CONFIG_H
@@ -34,6 +36,16 @@
 #include "src/missing.h"
 #include "src/crypto.h"
 =

+#define ARC4_MIN_KEY_SIZE	1
+#define ARC4_MAX_KEY_SIZE	256
+#define ARC4_KEY_SIZE		16
+
+struct arc4_ctx {
+	uint8_t S[256];
+	uint8_t i;
+	uint8_t j;
+};
+
 /* RFC 3526, Section 2 */
 const unsigned char crypto_dh5_prime[] =3D {
 	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xc9, 0x0f, 0xda, 0xa2,
@@ -415,44 +427,54 @@ free_ctr:
 	return false;
 }
 =

-bool arc4_skip(const uint8_t *key, size_t key_len, size_t skip,
-		const uint8_t *in, size_t len, uint8_t *out)
-{
-	char skip_buf[1024];
-	struct l_cipher *cipher;
-	struct iovec in_vec[2];
-	struct iovec out_vec[2];
-	bool r;
-
-	cipher =3D l_cipher_new(L_CIPHER_ARC4, key, key_len);
-	if (!cipher)
-		return false;
+#define SWAP(a,b) do { int _t =3D a; a =3D b; b =3D _t; } while (0)
 =

-	/* This is not strictly necessary, but keeps valgrind happy */
-	memset(skip_buf, 0, sizeof(skip_buf));
+static void arc4_set_key(struct arc4_ctx *ctx, unsigned length,
+			 const uint8_t *key)
+{
+	unsigned int i, j, k;
 =

-	while (skip > sizeof(skip_buf)) {
-		size_t to_skip =3D
-			skip > sizeof(skip_buf) ? sizeof(skip_buf) : skip;
+	/* Initialize context */
+	for (i =3D 0; i < 256; i++)
+		ctx->S[i] =3D i;
 =

-		l_cipher_decrypt(cipher, skip_buf, skip_buf, to_skip);
-		skip -=3D to_skip;
+	for (i =3D j =3D k =3D 0; i < 256; i++) {
+		j +=3D ctx->S[i] + key[k]; j &=3D 0xff;
+		SWAP(ctx->S[i], ctx->S[j]);
+		/* Repeat key as needed */
+		k =3D (k + 1) % length;
 	}
+	ctx->i =3D ctx->j =3D 0;
+}
 =

-	in_vec[0].iov_base =3D skip_buf;
-	in_vec[0].iov_len =3D skip;
-	in_vec[1].iov_base =3D (void *) in;
-	in_vec[1].iov_len =3D len;
+static void arc4_crypt(struct arc4_ctx *ctx, unsigned length, uint8_t *dst,
+		       const uint8_t *src)
+{
+	uint8_t i, j;
+
+	i =3D ctx->i; j =3D ctx->j;
+	while (length--) {
+		i++; i &=3D 0xff;
+		j +=3D ctx->S[i]; j &=3D 0xff;
+		SWAP(ctx->S[i], ctx->S[j]);
+		if (!dst || !src)
+			continue;
+		*dst++ =3D *src++ ^ ctx->S[ (ctx->S[i] + ctx->S[j]) & 0xff ];
+	}
+	ctx->i =3D i; ctx->j =3D j;
+}
 =

-	out_vec[0].iov_base =3D skip_buf;
-	out_vec[0].iov_len =3D skip;
-	out_vec[1].iov_base =3D out;
-	out_vec[1].iov_len =3D len;
+bool arc4_skip(const uint8_t *key, size_t key_len, size_t skip,
+		const uint8_t *in, size_t len, uint8_t *out)
+{
+	struct arc4_ctx cipher;
 =

-	r =3D l_cipher_decryptv(cipher, in_vec, 2, out_vec, 2);
-	l_cipher_free(cipher);
+	arc4_set_key(&cipher, key_len, key);
+	arc4_crypt(&cipher, skip, NULL, NULL);
+	arc4_crypt(&cipher, len, out, in);
+	explicit_bzero(&cipher, sizeof(cipher));
 =

-	return r;
+	return true;
 }
 =

 /* 802.11, Section 11.6.2, Table 11-4 */
diff --git a/src/main.c b/src/main.c
index 7c08746397d3..3216f50834d4 100644
--- a/src/main.c
+++ b/src/main.c
@@ -277,14 +277,6 @@ static int check_crypto()
 		ADD_OPTIONAL("CONFIG_CRYPTO_SHA512_SSSE3");
 	}
 =

-	if (!l_cipher_is_supported(L_CIPHER_ARC4)) {
-		r =3D -ENOTSUP;
-		l_error("RC4 support not found");
-		ADD_MISSING("CONFIG_CRYPTO_USER_API_SKCIPHER");
-		ADD_MISSING("CONFIG_CRYPTO_ARC4");
-		ADD_MISSING("CONFIG_CRYPTO_ECB");
-	}
-
 	if (!l_cipher_is_supported(L_CIPHER_DES) ||
 			!l_cipher_is_supported(L_CIPHER_DES3_EDE_CBC)) {
 		r =3D -ENOTSUP;
diff --git a/unit/test-eapol.c b/unit/test-eapol.c
index ac94522b9fab..f6af6f065199 100644
--- a/unit/test-eapol.c
+++ b/unit/test-eapol.c
@@ -3600,8 +3600,7 @@ int main(int argc, char *argv[])
 	l_test_add("/EAPoL Key/Calculate MIC Test 1",
 			eapol_calculate_mic_test, &eapol_calculate_mic_test_1);
 =

-	if (!l_cipher_is_supported(L_CIPHER_AES) ||
-			!l_cipher_is_supported(L_CIPHER_ARC4))
+	if (!l_cipher_is_supported(L_CIPHER_AES))
 		goto done;
 =

 	l_test_add("EAPoL/WPA2 4-Way Handshake",
-- =

2.20.1

--===============9036908065290607362==--

