Content-Type: multipart/mixed; boundary="===============5451899103033436500=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 3/3] sae: fix inproper return value in sae_verify_accepted
Date: Mon, 21 Oct 2019 14:01:59 -0700
Message-ID: <20191021210159.8132-3-prestwoj@gmail.com>
In-Reply-To: <20191021210159.8132-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5451899103033436500==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This function was returning a boolean and the expected return was
a signed integer. Since this function actually returned false in
all cases the check for a success (0) return always worked.

The comment about the 'standard code path' was removed as this is
no longer valid.
---
 src/sae.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/src/sae.c b/src/sae.c
index a6b2c582..327277eb 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -935,7 +935,7 @@ static int sae_verify_confirmed(struct sae_sm *sm, uint=
16_t trans,
 /*
  * 802.11-2016 - 12.4.8.6.6 Protocol instance behavior - Accepted state
  */
-static bool sae_verify_accepted(struct sae_sm *sm, uint16_t trans,
+static int sae_verify_accepted(struct sae_sm *sm, uint16_t trans,
 					uint16_t status, const uint8_t *frame,
 					size_t len)
 {
@@ -944,14 +944,14 @@ static bool sae_verify_accepted(struct sae_sm *sm, ui=
nt16_t trans,
 	/* spec does not specify what to do here, so print and discard */
 	if (trans !=3D SAE_STATE_CONFIRMED) {
 		l_error("received transaction %u in accepted state", trans);
-		return false;
+		return -EBADMSG;
 	}
 =

 	if (sm->sync > SAE_SYNC_MAX)
-		return false;
+		return -EBADMSG;
 =

 	if (len < 2)
-		return false;
+		return -EBADMSG;
 =

 	sc =3D l_get_le16(frame);
 =

@@ -961,14 +961,14 @@ static bool sae_verify_accepted(struct sae_sm *sm, ui=
nt16_t trans,
 	 * silently discarded.
 	 */
 	if (sc <=3D sm->rc || sc =3D=3D 0xffff)
-		return false;
+		return -EBADMSG;
 =

 	/*
 	 * If the verification fails, the received frame shall be silently
 	 * discarded.
 	 */
 	if (!sae_verify_confirm(sm, frame))
-		return false;
+		return -EBADMSG;
 =

 	/*
 	 * If the verification succeeds, the Rc variable shall be set to the
@@ -981,11 +981,7 @@ static bool sae_verify_accepted(struct sae_sm *sm, uin=
t16_t trans,
 =

 	sae_send_confirm(sm);
 =

-	/*
-	 * Since the confirmed needed special processing because of accepted
-	 * state we don't want the standard code path to execute.
-	 */
-	return false;
+	return 0;
 }
 =

 static int sae_verify_packet(struct sae_sm *sm, uint16_t trans,
-- =

2.17.1

--===============5451899103033436500==--

