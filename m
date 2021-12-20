Content-Type: multipart/mixed; boundary="===============1417803046725530551=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/9] dpp-util: pass actual ad_size, not hard coded '2'.
Date: Mon, 20 Dec 2021 13:49:08 -0800
Message-ID: <20211220214915.34093-2-prestwoj@gmail.com>
In-Reply-To: 20211220214915.34093-1-prestwoj@gmail.com

--===============1417803046725530551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/dpp-util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/dpp-util.c b/src/dpp-util.c
index 5e8ab2a7..1db38cfb 100644
--- a/src/dpp-util.c
+++ b/src/dpp-util.c
@@ -280,7 +280,7 @@ uint8_t *dpp_unwrap_attr(const void *ad0, size_t ad0_le=
n, const void *ad1,
 =

 	unwrapped =3D l_malloc(wrapped_len - 16);
 =

-	if (!aes_siv_decrypt(key, key_len, wrapped, wrapped_len, ad, 2,
+	if (!aes_siv_decrypt(key, key_len, wrapped, wrapped_len, ad, ad_size,
 				unwrapped)) {
 		l_free(unwrapped);
 		return NULL;
-- =

2.31.1

--===============1417803046725530551==--

