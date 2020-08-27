Content-Type: multipart/mixed; boundary="===============1988060541397880785=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 02/11] eap: Re-send Identity Request on EAPoL-Start
Date: Thu, 27 Aug 2020 20:14:44 +0200
Message-ID: <20200827181453.61823-2-andrew.zaborowski@intel.com>
In-Reply-To: <20200827181453.61823-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1988060541397880785==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It looks like clients sometimes miss our unsolicited Identity Request
and need a resend.
---
 src/eap.c   | 12 ++++++++++--
 src/eapol.c | 12 ++++++++----
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/src/eap.c b/src/eap.c
index fcc18c77..dea0c3cf 100644
--- a/src/eap.c
+++ b/src/eap.c
@@ -245,10 +245,18 @@ void eap_start(struct eap_state *eap)
 {
 	uint8_t buf[5];
 =

-	L_WARN_ON(!eap->method || !eap->authenticator || eap->identity);
+	L_WARN_ON(!eap->method || !eap->authenticator);
 =

+	/*
+	 * Until we've received the Identity response we can resend the
+	 * Identity request with a constant ID on EAPoL-Start.
+	 */
+	if (eap->identity)
+		return;
+
+	eap->last_id =3D 1;
 	buf[4] =3D EAP_TYPE_IDENTITY;
-	eap_send_packet(eap, EAP_CODE_REQUEST, ++eap->last_id, buf, 5);
+	eap_send_packet(eap, EAP_CODE_REQUEST, eap->last_id, buf, 5);
 }
 =

 void __eap_handle_request(struct eap_state *eap, uint16_t id,
diff --git a/src/eapol.c b/src/eapol.c
index 686187c6..2d339163 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -2239,14 +2239,18 @@ static void eapol_rx_auth_packet(uint16_t proto, co=
nst uint8_t *from,
 =

 	case 1:	/* EAPOL-Start */
 		/*
-		 * The supplicant might have sent an EAPoL-Start even before
-		 * we queued our EAP Identity Request, so this should happen
-		 * mostly while we wait for the EAP Identity Response or before.
-		 * It's safe to ignore this frame in either case.
+		 * The supplicant may have sent an EAPoL-Start even before
+		 * we queued our EAP Identity Request or it may have missed our
+		 * early Identity Request and may need a retransmission.  Tell
+		 * sm->eap so it can decide whether to send a new Identity
+		 * Request or ignore this.
 		 *
 		 * TODO: if we're already past the full handshake, send a
 		 * new msg 1/4.
 		 */
+		if (sm->eap)
+			eap_start(sm->eap);
+
 		break;
 =

 	case 3: /* EAPOL-Key */
-- =

2.25.1

--===============1988060541397880785==--

