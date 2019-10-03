Content-Type: multipart/mixed; boundary="===============0545767335193135727=="
MIME-Version: 1.0
From: Will Dietz <w@wdtz.org>
Subject: [PATCH] crypto: fix copy size causing overruns/crashing
Date: Thu, 03 Oct 2019 12:18:51 -0500
Message-ID: <20191003171851.31807-1-w@wdtz.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0545767335193135727==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

num_ad is already accounted for in `sizeof(iov)`
as iov has size `sizeof(struct iovec) * (num_ad+1)`.
---
 src/crypto.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/crypto.c b/src/crypto.c
index 632117d..62edd44 100644
--- a/src/crypto.c
+++ b/src/crypto.c
@@ -311,7 +311,7 @@ bool aes_siv_encrypt(const uint8_t *key, size_t key_len=
, const uint8_t *in,
 	struct iovec iov[num_ad + 1];
 	uint8_t v[16];
 =

-	memcpy(iov, ad, sizeof(iov) * num_ad);
+	memcpy(iov, ad, sizeof(struct iovec) * num_ad);
 	iov[num_ad].iov_base =3D (void *)in;
 	iov[num_ad].iov_len =3D in_len;
 	num_ad++;
@@ -368,7 +368,7 @@ bool aes_siv_decrypt(const uint8_t *key, size_t key_len=
, const uint8_t *in,
 	if (in_len < 16)
 		return false;
 =

-	memcpy(iov, ad, sizeof(iov) * num_ad);
+	memcpy(iov, ad, sizeof(struct iovec) * num_ad);
 	iov[num_ad].iov_base =3D (void *)out;
 	iov[num_ad].iov_len =3D in_len - 16;
 	num_ad++;
-- =

2.23.0

--===============0545767335193135727==--

