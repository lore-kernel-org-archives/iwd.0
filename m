Content-Type: multipart/mixed; boundary="===============8934008322547734122=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] dpp: use %zu for printing size_t
Date: Wed, 05 Jan 2022 11:50:16 -0800
Message-ID: <20220105195016.334937-1-prestwoj@gmail.com>

--===============8934008322547734122==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/dpp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/dpp.c b/src/dpp.c
index 9eb1d642..dedbd3b2 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -1272,7 +1272,7 @@ static void authenticate_request(struct dpp_sm *dpp, =
const uint8_t *from,
 	}
 =

 	if (i_nonce_len !=3D dpp->nonce_len) {
-		l_debug("I-Nonce has unexpected length %lu", i_nonce_len);
+		l_debug("I-Nonce has unexpected length %zu", i_nonce_len);
 		goto auth_request_failed;
 	}
 =

-- =

2.31.1

--===============8934008322547734122==--

