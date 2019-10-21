Content-Type: multipart/mixed; boundary="===============1466025778878632715=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] sae: fix potential integer overflow
Date: Mon, 21 Oct 2019 11:09:31 -0700
Message-ID: <20191021180931.20182-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1466025778878632715==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If an authentication frame of length <=3D 5 is sent sae will overflow an
integer. The original cause of this was due to incorrectly using the
sizeof(struct mmpdu_header). The header can be either 24 or 28 bytes
depending on fc.order. sizeof does not account for this so 28 is always
the calculated length.

This, in addition to hostapd not including a group number when rejecting,
cause this erroneous length calculation to be worked around as seen in
the removed comment. The comment is still valid (and described again
in another location) but the actual check for len =3D=3D 4 is not correct.

To fix this we now rely on mpdu_validate to check that the authentication
frame is valid, and then take the difference from 'hdr' and 'auth' to
find the true header length (either 24 or 28 bytes). Doing this lets us
simply check if len < 6 and reject since this would not be a valid auth
frame.
---
 src/sae.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/src/sae.c b/src/sae.c
index 8f9425f1..0fb5f662 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -1021,25 +1021,13 @@ static int sae_rx_authenticate(struct auth_proto *a=
p,
 		goto reject;
 	}
 =

-	len -=3D sizeof(struct mmpdu_header);
+	len -=3D ((const void *)auth - (const void *)hdr);
 =

-	if (len < 4) {
-		l_error("bad packet length");
+	if (len < 6) {
+		l_error("bad packet length %zu", len);
 		goto reject;
 	}
 =

-	/*
-	 * TODO: Hostapd seems to not include the group number when rejecting
-	 * with an unsupported group, which violates the spec. This means our
-	 * len =3D=3D 4, but we can still recover this connection by renegotiating
-	 * a new group. Because of this we need to special case this status
-	 * code, as well as add the check in the verify function to allow for
-	 * this missing group number.
-	 */
-	if (len =3D=3D 4 && L_LE16_TO_CPU(auth->status) !=3D
-				MMPDU_STATUS_CODE_UNSUPP_FINITE_CYCLIC_GROUP)
-		goto reject;
-
 	ret =3D sae_verify_packet(sm, L_LE16_TO_CPU(auth->transaction_sequence),
 					L_LE16_TO_CPU(auth->status),
 					auth->ies, len - 6);
-- =

2.17.1

--===============1466025778878632715==--

