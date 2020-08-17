Content-Type: multipart/mixed; boundary="===============3280063379736166712=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 04/10] eapol: Basic EAP support in authenticator mode
Date: Mon, 17 Aug 2020 12:06:41 +0200
Message-ID: <20200817100647.338184-4-andrew.zaborowski@intel.com>
In-Reply-To: <20200817100647.338184-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3280063379736166712==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Handle EAPoL-EAP frames using our eap.c methods in authenticator mode
same as we do on the supplicant side.  The user (ap.c) will only need to
set a valid 8021x_settings in the handshake object, same as on the
supplicant side.
---
 src/eapol.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index eee3b04e..686187c6 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -876,7 +876,7 @@ struct eapol_sm *eapol_sm_new(struct handshake_state *h=
s)
 =

 	sm->handshake =3D hs;
 =

-	if (hs->settings_8021x)
+	if (hs->settings_8021x && !hs->authenticator)
 		sm->use_eapol_start =3D true;
 =

 	sm->require_handshake =3D true;
@@ -2074,6 +2074,18 @@ static void eapol_eap_complete_cb(enum eap_result re=
sult, void *user_data)
 	}
 =

 	eap_reset(sm->eap);
+
+	if (sm->handshake->authenticator) {
+		if (L_WARN_ON(!sm->handshake->have_pmk)) {
+			handshake_failed(sm, MMPDU_REASON_CODE_UNSPECIFIED);
+			return;
+		}
+
+		/* sm->mic_len will have been set in eapol_eap_results_cb */
+
+		/* Kick off 4-Way Handshake */
+		eapol_ptk_1_of_4_retry(NULL, sm);
+	}
 }
 =

 /* This respresentes the eapResults message */
@@ -2209,7 +2221,34 @@ static void eapol_rx_auth_packet(uint16_t proto, con=
st uint8_t *from,
 {
 	struct eapol_sm *sm =3D user_data;
 =

+	if (proto !=3D ETH_P_PAE || memcmp(from, sm->handshake->spa, 6))
+		return;
+
 	switch (frame->header.packet_type) {
+	case 0:	/* EAPOL-EAP */
+		if (!sm->eap) {
+			l_error("Authenticator received an unexpected "
+				"EAPOL-EAP frame from %s",
+				util_address_to_string(from));
+			return;
+		}
+
+		eap_rx_packet(sm->eap, frame->data,
+				L_BE16_TO_CPU(frame->header.packet_len));
+		break;
+
+	case 1:	/* EAPOL-Start */
+		/*
+		 * The supplicant might have sent an EAPoL-Start even before
+		 * we queued our EAP Identity Request, so this should happen
+		 * mostly while we wait for the EAP Identity Response or before.
+		 * It's safe to ignore this frame in either case.
+		 *
+		 * TODO: if we're already past the full handshake, send a
+		 * new msg 1/4.
+		 */
+		break;
+
 	case 3: /* EAPOL-Key */
 		eapol_auth_key_handle(sm, frame);
 		break;
@@ -2396,14 +2435,18 @@ bool eapol_start(struct eapol_sm *sm)
 	}
 =

 	if (sm->handshake->authenticator) {
-		if (L_WARN_ON(!sm->handshake->have_pmk))
-			return false;
-
 		if (!sm->protocol_version)
 			sm->protocol_version =3D EAPOL_PROTOCOL_VERSION_2004;
 =

-		/* Kick off handshake */
-		eapol_ptk_1_of_4_retry(NULL, sm);
+		if (sm->handshake->settings_8021x)
+			eap_start(sm->eap);
+		else {
+			if (L_WARN_ON(!sm->handshake->have_pmk))
+				return false;
+
+			/* Kick off handshake */
+			eapol_ptk_1_of_4_retry(NULL, sm);
+		}
 	}
 =

 	return true;
-- =

2.25.1

--===============3280063379736166712==--

