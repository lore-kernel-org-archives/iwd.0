Content-Type: multipart/mixed; boundary="===============7592533247165509051=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/3] dpp: check return of aes_siv_encrypt
Date: Fri, 18 Feb 2022 11:55:06 -0800
Message-ID: <20220218195506.2145602-3-prestwoj@gmail.com>
In-Reply-To: 20220218195506.2145602-1-prestwoj@gmail.com

--===============7592533247165509051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This was caught by static analysis. As is common this should never
happen in the real world since the only way this can fail (apart from
extreme circumstances like OOM) is if the key size is incorrect, which
it will never be.
---
 src/dpp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index f664e490..54662e8f 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -1070,8 +1070,11 @@ static void send_authenticate_response(struct dpp_sm=
 *dpp)
 	 * do not use AAD; in other words, the number of AAD components is set
 	 * to zero.""
 	 */
-	aes_siv_encrypt(dpp->ke, dpp->key_len, wrapped2_plaintext,
-					dpp->key_len + 4, NULL, 0, wrapped2);
+	if (!aes_siv_encrypt(dpp->ke, dpp->key_len, wrapped2_plaintext,
+					dpp->key_len + 4, NULL, 0, wrapped2)) {
+		l_error("Failed to encrypt wrapped data");
+		return;
+	}
 =

 	wrapped2_len +=3D 16;
 =

-- =

2.34.1

--===============7592533247165509051==--

