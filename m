Content-Type: multipart/mixed; boundary="===============0530908709778161684=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 06/16] eapol: Basic EAP support in authenticator mode
Date: Thu, 13 Aug 2020 02:50:16 +0200
Message-ID: <20200813005026.294950-6-andrew.zaborowski@intel.com>
In-Reply-To: <20200813005026.294950-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0530908709778161684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Handle EAPoL-EAP frames using our eap.c methods in authenticator mode
same as we do on the supplicant side.  The user (ap.c) will only need to
set a valid 8021x_settings in the handshake object, same as on the
supplicant side.
---
 src/eapol.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 72 insertions(+), 4 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index 299de13f..06b8a2f6 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -2067,6 +2067,17 @@ static void eapol_eap_complete_cb(enum eap_result re=
sult, void *user_data)
 	}
 =

 	eap_reset(sm->eap);
+
+	if (sm->handshake->authenticator) {
+		if (L_WARN_ON(!sm->handshake->have_pmk))
+			return;
+
+		sm->mic_len =3D eapol_get_mic_length(sm->handshake->akm_suite,
+						sm->handshake->pmk_len);
+
+		/* Kick off 4-Way Handshake */
+		eapol_ptk_1_of_4_retry(NULL, sm);
+	}
 }
 =

 /* This respresentes the eapResults message */
@@ -2200,7 +2211,34 @@ static void eapol_rx_auth_packet(uint16_t proto, con=
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
@@ -2341,16 +2379,46 @@ void eapol_register(struct eapol_sm *sm)
 			sm->protocol_version =3D sm->handshake->proto_version;
 =

 		sm->started =3D true;
-		/* Since AP/AdHoc only support AKM PSK we can hard code this */
-		sm->mic_len =3D 16;
 =

-		/* kick off handshake */
-		eapol_ptk_1_of_4_retry(NULL, sm);
+		if (sm->handshake->settings_8021x) {
+			sm->eap =3D eap_new(eapol_eap_msg_cb,
+						eapol_eap_complete_cb, sm);
+			if (!sm->eap)
+				goto eap_error;
+
+			eap_set_key_material_func(sm->eap,
+							eapol_eap_results_cb);
+			eap_set_event_func(sm->eap, eapol_eap_event_cb);
+
+			if (!eap_load_settings(sm->eap,
+						sm->handshake->settings_8021x,
+						"EAP-")) {
+				eap_free(sm->eap);
+				sm->eap =3D NULL;
+				goto eap_error;
+			}
+		} else {
+			if (L_WARN_ON(!sm->handshake->have_pmk))
+				return;
+
+			sm->mic_len =3D eapol_get_mic_length(
+						sm->handshake->akm_suite,
+						sm->handshake->pmk_len);
+
+			/* kick off handshake */
+			eapol_ptk_1_of_4_retry(NULL, sm);
+		}
 	} else {
 		sm->watch_id =3D eapol_frame_watch_add(sm->handshake->ifindex,
 						eapol_rx_packet, sm);
 		sm->protocol_version =3D sm->handshake->proto_version;
 	}
+
+	return;
+
+eap_error:
+	l_error("Error initializing EAP for ifindex %i",
+			(int) sm->handshake->ifindex);
 }
 =

 bool eapol_start(struct eapol_sm *sm)
-- =

2.25.1

--===============0530908709778161684==--

