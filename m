Content-Type: multipart/mixed; boundary="===============6628434678343928443=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/3] eapol: add PMK installer support
Date: Fri, 09 Apr 2021 09:14:44 -0700
Message-ID: <20210409161446.1303013-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6628434678343928443==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

802.1x offloading needs a way to call SET_PMK after EAP finishes.
In the same manor as set_tk/gtk/igtk a new 'install_pmk' function
was added which eapol can call into after EAP completes.
---
 src/eapol.c | 10 ++++++++++
 src/eapol.h |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/src/eapol.c b/src/eapol.c
index 23aaf530..3823f854 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -52,6 +52,7 @@ static uint32_t eapol_4way_handshake_time =3D 2;
 static eapol_rekey_offload_func_t rekey_offload =3D NULL;
 =

 static eapol_tx_packet_func_t tx_packet =3D NULL;
+static eapol_install_pmk_func_t install_pmk =3D NULL;
 static void *tx_user_data;
 =

 #define VERIFY_IS_ZERO(field)						\
@@ -2162,6 +2163,10 @@ static void eapol_eap_complete_cb(enum eap_result re=
sult, void *user_data)
 		sm->eap =3D NULL;
 		handshake_failed(sm, MMPDU_REASON_CODE_IEEE8021X_FAILED);
 		return;
+	} else {
+		if (install_pmk)
+			install_pmk(sm->handshake, sm->handshake->pmk,
+					sm->handshake->pmk_len);
 	}
 =

 	eap_reset(sm->eap);
@@ -2470,6 +2475,11 @@ void __eapol_set_rekey_offload_func(eapol_rekey_offl=
oad_func_t func)
 	rekey_offload =3D func;
 }
 =

+void __eapol_set_install_pmk_func(eapol_install_pmk_func_t func)
+{
+	install_pmk =3D func;
+}
+
 void eapol_register(struct eapol_sm *sm)
 {
 	eapol_frame_watch_func_t rx_handler =3D sm->handshake->authenticator ?
diff --git a/src/eapol.h b/src/eapol.h
index 0f9a6917..a948c018 100644
--- a/src/eapol.h
+++ b/src/eapol.h
@@ -51,6 +51,9 @@ typedef void (*eapol_frame_watch_func_t)(uint16_t proto, =
const uint8_t *from,
 						const struct eapol_frame *frame,
 						bool noencrypt,
 						void *user_data);
+typedef void (*eapol_install_pmk_func_t)(struct handshake_state *hs,
+						const uint8_t *pmk,
+						size_t pmk_len);
 =

 bool eapol_calculate_mic(enum ie_rsn_akm_suite akm, const uint8_t *kck,
 				const struct eapol_key *frame, uint8_t *mic,
@@ -102,6 +105,8 @@ void __eapol_tx_packet(uint32_t ifindex, const uint8_t =
*dst, uint16_t proto,
 void __eapol_set_tx_packet_func(eapol_tx_packet_func_t func);
 void __eapol_set_tx_user_data(void *user_data);
 =

+void __eapol_set_install_pmk_func(eapol_install_pmk_func_t func);
+
 void __eapol_set_rekey_offload_func(eapol_rekey_offload_func_t func);
 void __eapol_update_replay_counter(uint32_t ifindex, const uint8_t *spa,
 				const uint8_t *aa, uint64_t replay_counter);
-- =

2.26.2

--===============6628434678343928443==--

