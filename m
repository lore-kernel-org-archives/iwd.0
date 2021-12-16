Content-Type: multipart/mixed; boundary="===============7877577838844484290=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/2] crypto: allow NULL 'ad' to aes_siv_decrypt
Date: Thu, 16 Dec 2021 10:00:02 -0800
Message-ID: <20211216180003.38883-1-prestwoj@gmail.com>

--===============7877577838844484290==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/crypto.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/crypto.c b/src/crypto.c
index 475ebf36..cd50d6f7 100644
--- a/src/crypto.c
+++ b/src/crypto.c
@@ -389,7 +389,9 @@ bool aes_siv_decrypt(const void *key, size_t key_len, c=
onst void *in,
 	if (in_len < 16)
 		return false;
 =

-	memcpy(iov, ad, sizeof(struct iovec) * num_ad);
+	if (ad)
+		memcpy(iov, ad, sizeof(struct iovec) * num_ad);
+
 	iov[num_ad].iov_base =3D (void *)out;
 	iov[num_ad].iov_len =3D in_len - 16;
 	num_ad++;
-- =

2.31.1

--===============7877577838844484290==--

