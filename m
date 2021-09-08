Content-Type: multipart/mixed; boundary="===============6298783772762174239=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/7] sae: fix a spec violation with duplicate commits
Date: Wed, 08 Sep 2021 11:18:58 -0700
Message-ID: <20210908181904.84594-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6298783772762174239==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If a commit is received while in an accepted state the spec states
the scalar should be checked against the previous commit and if
equal the message should be silently dropped.
---
 src/sae.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

v2:
 * Changed to check the scalar rather than always ignore.

diff --git a/src/sae.c b/src/sae.c
index 62fd6c88..c14b646f 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -1182,10 +1182,32 @@ static int sae_verify_accepted(struct sae_sm *sm, u=
int16_t trans,
 {
 	uint16_t sc;
 =

-	/* spec does not specify what to do here, so print and discard */
-	if (trans !=3D SAE_STATE_CONFIRMED) {
+	/*
+	 * 12.4.8.6.1 Parent process behavior
+	 *
+	 * "Upon receipt of an SAE Commit message... and it is in Accepted
+	 * state, the scalar in the received frame is checked against the
+	 * peer-scalar used in authentication of the existing protocol instance
+	 * (in Accepted state). If it is identical, the frame shall be dropped"
+	 */
+	if (trans =3D=3D SAE_STATE_COMMITTED) {
+		bool drop;
+		unsigned int nbytes =3D l_ecc_curve_get_scalar_bytes(sm->curve);
+		struct l_ecc_scalar *p_scalar;
+
+		if (len < nbytes + 2)
+			return -EMSGSIZE;
+
+		p_scalar =3D l_ecc_scalar_new(sm->curve, frame + 2, nbytes);
+
+		drop =3D l_ecc_scalars_are_equal(sm->p_scalar, p_scalar);
+		l_ecc_scalar_free(p_scalar);
+
+		if (drop)
+			return -EBADMSG;
+
 		l_error("received transaction %u in accepted state", trans);
-		return -EBADMSG;
+		return -EPROTO;
 	}
 =

 	if (sm->sync > SAE_SYNC_MAX)
-- =

2.31.1

--===============6298783772762174239==--

