Content-Type: multipart/mixed; boundary="===============8844277429557605502=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/2] crypto: allow NULL 'ad' to aes_siv_decrypt
Date: Wed, 15 Dec 2021 09:41:45 -0800
Message-ID: <20211215174146.2465846-1-prestwoj@gmail.com>

--===============8844277429557605502==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/crypto.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/crypto.c b/src/crypto.c
index 7d5e42fe..475ebf36 100644
--- a/src/crypto.c
+++ b/src/crypto.c
@@ -330,7 +330,9 @@ bool aes_siv_encrypt(const void *key, size_t key_len, c=
onst void *in,
 	struct iovec iov[num_ad + 1];
 	uint8_t v[16];
 =

-	memcpy(iov, ad, sizeof(struct iovec) * num_ad);
+	if (ad)
+		memcpy(iov, ad, sizeof(struct iovec) * num_ad);
+
 	iov[num_ad].iov_base =3D (void *)in;
 	iov[num_ad].iov_len =3D in_len;
 	num_ad++;
-- =

2.31.1

--===============8844277429557605502==--

