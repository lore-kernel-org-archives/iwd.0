Content-Type: multipart/mixed; boundary="===============0249669521809169819=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/2] sae: fix inproper return value in sae_verify_accepted
Date: Mon, 21 Oct 2019 11:27:02 -0700
Message-ID: <20191021182702.22061-2-prestwoj@gmail.com>
In-Reply-To: <20191021182702.22061-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0249669521809169819==
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
index a2e7cdd7..42b0a108 100644
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

--===============0249669521809169819==--

