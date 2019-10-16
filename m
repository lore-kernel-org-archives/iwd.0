Content-Type: multipart/mixed; boundary="===============8176182959203424957=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 04/10] crypto: fix potential memory leak
Date: Wed, 16 Oct 2019 15:29:47 -0700
Message-ID: <20191016222953.513-4-prestwoj@gmail.com>
In-Reply-To: <20191016222953.513-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8176182959203424957==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/crypto.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/crypto.c b/src/crypto.c
index 62edd447..638098a9 100644
--- a/src/crypto.c
+++ b/src/crypto.c
@@ -706,6 +706,7 @@ bool hkdf_extract(enum l_checksum_type type, const uint=
8_t *key,
 	}
 =

 	if (!l_checksum_updatev(hmac, iov, num_args)) {
+		l_checksum_free(hmac);
 		va_end(va);
 		return false;
 	}
-- =

2.17.1

--===============8176182959203424957==--

