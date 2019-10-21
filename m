Content-Type: multipart/mixed; boundary="===============5130812462689854355=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/2] sae: fix potential integer overflow
Date: Mon, 21 Oct 2019 11:27:01 -0700
Message-ID: <20191021182702.22061-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5130812462689854355==
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
 src/sae.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

-v2:
 * Added checks for cases where the length could be zero. This is only
   accepted in one case where the group number is missing from the
   rejection. All other cases should fail if len < 2.

diff --git a/src/sae.c b/src/sae.c
index 8f9425f1..a2e7cdd7 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -689,6 +689,9 @@ static int sae_verify_nothing(struct sae_sm *sm, uint16=
_t transaction,
 	if (status !=3D 0)
 		return -EBADMSG;
 =

+	if (len < 2)
+		return -EBADMSG;
+
 	/* reject with unsupported group */
 	if (l_get_le16(frame) !=3D sm->group) {
 		sae_reject_authentication(sm,
@@ -909,6 +912,9 @@ static int sae_verify_confirmed(struct sae_sm *sm, uint=
16_t trans,
 	if (sm->sync > SAE_SYNC_MAX)
 		return -EBADMSG;
 =

+	if (len < 2)
+		return -EBADMSG;
+
 	/* frame shall be silently discarded */
 	if (l_get_le16(frame) !=3D sm->group)
 		return 0;
@@ -944,6 +950,9 @@ static bool sae_verify_accepted(struct sae_sm *sm, uint=
16_t trans,
 	if (sm->sync > SAE_SYNC_MAX)
 		return false;
 =

+	if (len < 2)
+		return false;
+
 	sc =3D l_get_le16(frame);
 =

 	/*
@@ -1021,25 +1030,13 @@ static int sae_rx_authenticate(struct auth_proto *a=
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

--===============5130812462689854355==--

