Content-Type: multipart/mixed; boundary="===============8285531633825484468=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] sae: remove unneeded NULL pointer check
Date: Mon, 21 Oct 2019 15:02:50 -0700
Message-ID: <20191021220250.12908-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8285531633825484468==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The frame was already validated, and mmpdu_body will never return
a NULL pointer.
---
 src/sae.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/src/sae.c b/src/sae.c
index a17c2883..391ed4f8 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -1021,11 +1021,6 @@ static int sae_rx_authenticate(struct auth_proto *ap,
 =

 	auth =3D mmpdu_body(hdr);
 =

-	if (!auth) {
-		l_debug("Auth frame body did not validate");
-		goto reject;
-	}
-
 	len -=3D mmpdu_header_len(hdr);
 =

 	ret =3D sae_verify_packet(sm, L_LE16_TO_CPU(auth->transaction_sequence),
-- =

2.17.1

--===============8285531633825484468==--

