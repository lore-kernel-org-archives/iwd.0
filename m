Content-Type: multipart/mixed; boundary="===============6983145188008411644=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/5] sae: remove authenticate timeout handler
Date: Mon, 05 Apr 2021 15:40:23 -0700
Message-ID: <20210405224027.1052197-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6983145188008411644==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This fixes an infinite loop issue when authenticate frames time
out. If the AP is not responding IWD ends up retrying indefinitely
due to how SAE was handling this timeout. Inside sae_auth_timeout
it was actually sending another authenticate frame to reject
the SAE handshake. This, again, resulted in a timeout which called
the SAE timeout handler and repeated indefinitely.

The kernel resend behavior was not taken into account when writing
the SAE timeout behavior and in practice there is actually no need
for SAE to do much of anything in response to a timeout. The
kernel automatically resends Authenticate frames 3 times which mirrors
IWDs SAE behavior anyways. Because of this the authenticate timeout
handler can be completely removed, which will cause the connection
to fail in the case of an autentication timeout.
---
 src/sae.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/src/sae.c b/src/sae.c
index b6cc0b15..98050483 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -672,35 +672,6 @@ static bool sae_send_commit(struct sae_sm *sm, bool re=
try)
 	return true;
 }
 =

-static bool sae_auth_timeout(struct auth_proto *ap)
-{
-	struct sae_sm *sm =3D l_container_of(ap, struct sae_sm, ap);
-
-	/* regardless of state, reject if sync exceeds max */
-	if (sm->sync > SAE_SYNC_MAX) {
-		sae_reject_authentication(sm, MMPDU_REASON_CODE_UNSPECIFIED);
-		return false;
-	}
-
-	sm->sync++;
-
-	switch (sm->state) {
-	case SAE_STATE_COMMITTED:
-		sae_send_commit(sm, true);
-		break;
-	case SAE_STATE_CONFIRMED:
-		sm->sc++;
-		sae_send_confirm(sm);
-		break;
-	default:
-		/* should never happen */
-		l_error("SAE timeout in bad state %u", sm->state);
-		return false;
-	}
-
-	return true;
-}
-
 static bool sae_assoc_timeout(struct auth_proto *ap)
 {
 	struct sae_sm *sm =3D l_container_of(ap, struct sae_sm, ap);
@@ -1194,7 +1165,6 @@ struct auth_proto *sae_sm_new(struct handshake_state =
*hs,
 	sm->ap.free =3D sae_free;
 	sm->ap.rx_authenticate =3D sae_rx_authenticate;
 	sm->ap.rx_associate =3D sae_rx_associate;
-	sm->ap.auth_timeout =3D sae_auth_timeout;
 	sm->ap.assoc_timeout =3D sae_assoc_timeout;
 =

 	return &sm->ap;
-- =

2.26.2

--===============6983145188008411644==--

