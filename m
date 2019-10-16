Content-Type: multipart/mixed; boundary="===============5107575362602778881=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 03/10] eap-pwd: fix potential memory leak
Date: Wed, 16 Oct 2019 15:29:46 -0700
Message-ID: <20191016222953.513-3-prestwoj@gmail.com>
In-Reply-To: <20191016222953.513-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5107575362602778881==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/eap-pwd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/eap-pwd.c b/src/eap-pwd.c
index e70fc37c..3aa16222 100644
--- a/src/eap-pwd.c
+++ b/src/eap-pwd.c
@@ -115,8 +115,10 @@ static bool kdf(uint8_t *key, size_t key_len, const ch=
ar *label,
 		iov[iov_pos].iov_base =3D &L;
 		iov[iov_pos++].iov_len =3D 2;
 =

-		if (!l_checksum_updatev(hmac, iov, iov_pos))
+		if (!l_checksum_updatev(hmac, iov, iov_pos)) {
+			l_checksum_free(hmac);
 			return false;
+		}
 =

 		l_checksum_get_digest(hmac, out + len, minsize(olen - len, 32));
 		l_checksum_free(hmac);
-- =

2.17.1

--===============5107575362602778881==--

