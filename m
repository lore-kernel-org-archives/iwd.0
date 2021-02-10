Content-Type: multipart/mixed; boundary="===============6036604184985061872=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] crypto: Check for l_cipher_decrypt error
Date: Wed, 10 Feb 2021 15:24:23 +0100
Message-ID: <20210210142423.234599-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6036604184985061872==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/crypto.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/crypto.c b/src/crypto.c
index 563f17ce..6c70eb9a 100644
--- a/src/crypto.c
+++ b/src/crypto.c
@@ -167,12 +167,18 @@ bool aes_unwrap(const uint8_t *kek, size_t kek_len, c=
onst uint8_t *in, size_t le
 		for (i =3D n; i >=3D 1; i--, t--) {
 			b[0] ^=3D L_CPU_TO_BE64(t);
 			b[1] =3D L_GET_UNALIGNED(r);
-			l_cipher_decrypt(cipher, b, b, 16);
+
+			if (!l_cipher_decrypt(cipher, b, b, 16)) {
+				b[0] =3D 0;
+				goto done;
+			}
+
 			L_PUT_UNALIGNED(b[1], r);
 			r -=3D 1;
 		}
 	}
 =

+done:
 	l_cipher_free(cipher);
 	explicit_bzero(&b[1], 8);
 =

-- =

2.27.0

--===============6036604184985061872==--

