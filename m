Content-Type: multipart/mixed; boundary="===============0675388281340749324=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 02/10] eapol: Use eapol_start in authenticator mode too
Date: Mon, 17 Aug 2020 12:06:39 +0200
Message-ID: <20200817100647.338184-2-andrew.zaborowski@intel.com>
In-Reply-To: <20200817100647.338184-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0675388281340749324==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On the supplicant side eapol_register would only register the eapol_sm
on a given netdev to start receiving frames and an eapol_start call is
required for the state machine to start executing.  On the authenticator
side we shouldn't have the "early frame" problem but there's no reason
for the semantics of the two methods to be different.  Somehow we were
doing everything in eapol_register and not using eapol_start if
hs->authenticator was true, so bring this in line with the supplicant
side and require eapol_start to be called also from ap.c.
---
 src/ap.c    |  1 +
 src/eapol.c | 37 +++++++++++++++++--------------------
 2 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 0b72cf11..eca49c09 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -469,6 +469,7 @@ static void ap_start_rsna(struct sta_state *sta, const =
uint8_t *gtk_rsc)
 	eapol_sm_set_listen_interval(sta->sm, sta->listen_interval);
 =

 	eapol_register(sta->sm);
+	eapol_start(sta->sm);
 =

 	return;
 =

diff --git a/src/eapol.c b/src/eapol.c
index 9846f540..eee3b04e 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -2338,28 +2338,14 @@ void __eapol_set_rekey_offload_func(eapol_rekey_off=
load_func_t func)
 =

 void eapol_register(struct eapol_sm *sm)
 {
-	l_queue_push_head(state_machines, sm);
-
-	if (sm->handshake->authenticator) {
-		sm->watch_id =3D eapol_frame_watch_add(sm->handshake->ifindex,
-						eapol_rx_auth_packet, sm);
-
-		if (!sm->handshake->proto_version)
-			sm->protocol_version =3D EAPOL_PROTOCOL_VERSION_2004;
-		else
-			sm->protocol_version =3D sm->handshake->proto_version;
+	eapol_frame_watch_func_t rx_handler =3D sm->handshake->authenticator ?
+		eapol_rx_auth_packet : eapol_rx_packet;
 =

-		sm->started =3D true;
-		/* Since AP/AdHoc only support AKM PSK we can hard code this */
-		sm->mic_len =3D 16;
+	l_queue_push_head(state_machines, sm);
 =

-		/* kick off handshake */
-		eapol_ptk_1_of_4_retry(NULL, sm);
-	} else {
-		sm->watch_id =3D eapol_frame_watch_add(sm->handshake->ifindex,
-						eapol_rx_packet, sm);
-		sm->protocol_version =3D sm->handshake->proto_version;
-	}
+	sm->watch_id =3D eapol_frame_watch_add(sm->handshake->ifindex,
+						rx_handler, sm);
+	sm->protocol_version =3D sm->handshake->proto_version;
 }
 =

 bool eapol_start(struct eapol_sm *sm)
@@ -2409,6 +2395,17 @@ bool eapol_start(struct eapol_sm *sm)
 		sm->early_frame =3D NULL;
 	}
 =

+	if (sm->handshake->authenticator) {
+		if (L_WARN_ON(!sm->handshake->have_pmk))
+			return false;
+
+		if (!sm->protocol_version)
+			sm->protocol_version =3D EAPOL_PROTOCOL_VERSION_2004;
+
+		/* Kick off handshake */
+		eapol_ptk_1_of_4_retry(NULL, sm);
+	}
+
 	return true;
 =

 eap_error:
-- =

2.25.1

--===============0675388281340749324==--

