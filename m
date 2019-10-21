Content-Type: multipart/mixed; boundary="===============4742715562087143707=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/3] sae: fix potential integer overflow
Date: Mon, 21 Oct 2019 14:01:58 -0700
Message-ID: <20191021210159.8132-2-prestwoj@gmail.com>
In-Reply-To: <20191021210159.8132-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4742715562087143707==
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
frame is valid, and then subtract the actual header length using
mmpdu_header_len rather than sizeof. Doing this lets us also remove the
length check since it was validated previously.
---
 src/sae.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

-v3:
 * Removed length check as mpdu_validate does this for us
 * Use mmpdu_header_len instead of auth - hdr calculation

diff --git a/src/sae.c b/src/sae.c
index 8f9425f1..a6b2c582 100644
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
@@ -1021,24 +1030,7 @@ static int sae_rx_authenticate(struct auth_proto *ap,
 		goto reject;
 	}
 =

-	len -=3D sizeof(struct mmpdu_header);
-
-	if (len < 4) {
-		l_error("bad packet length");
-		goto reject;
-	}
-
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
+	len -=3D mmpdu_header_len(hdr);
 =

 	ret =3D sae_verify_packet(sm, L_LE16_TO_CPU(auth->transaction_sequence),
 					L_LE16_TO_CPU(auth->status),
-- =

2.17.1

--===============4742715562087143707==--

