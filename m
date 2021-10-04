Content-Type: multipart/mixed; boundary="===============3132809498860244119=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 05/12] eapol: support extended key IDs
Date: Mon, 04 Oct 2021 09:48:55 -0700
Message-ID: <20211004164902.2274318-5-prestwoj@gmail.com>
In-Reply-To: 20211004164902.2274318-1-prestwoj@gmail.com

--===============3132809498860244119==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

802.11 added Extended Key IDs which aim to solve the issue of PTK
key replacement during rekeys. Since swapping out the existing PTK
may result in data loss because there may be in flight packets still
using the old PTK.

Extended Key IDs use two key IDs for the PTK, which toggle between
0 and 1. During a rekey a new PTK is derived which uses the key ID
not already taken by the existing PTK. This new PTK is added as RX
only, then message 4/4 is sent. This ensure message 4 is encrypted
using the previous PTK. Once sent, the new PTK can be modified to
both RX and TX and the rekey is complete.

To handle this in eapol the extended key ID KDE is parsed which
gives us the new PTK key index. Using the new handshake callbacks
an RX only PTK is installed into the kernel. Once that completes
eapol gets called back and message 4 is sent. Then the existing
handshake_state_install_ptk is used which will handle setting the
new PTK as RX/TX rather than installing the PTK (again).
---
 src/eapol.c | 105 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 91 insertions(+), 14 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index 07120fdb..02920180 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -860,6 +860,8 @@ struct eapol_sm {
 	uint8_t installed_igtk_len;
 	uint8_t installed_igtk[CRYPTO_MAX_IGTK_LEN];
 	unsigned int mic_len;
+	struct eapol_key *step4;
+	bool rekey : 1;
 };
 =

 static void eapol_sm_destroy(void *value)
@@ -873,6 +875,7 @@ static void eapol_sm_destroy(void *value)
 		eap_free(sm->eap);
 =

 	l_free(sm->early_frame);
+	l_free(sm->step4);
 =

 	eapol_frame_watch_remove(sm->watch_id);
 =

@@ -1223,6 +1226,9 @@ static void eapol_handle_ptk_1_of_4(struct eapol_sm *=
sm,
 			return;
 		}
 =

+		if (sm->handshake->ptk_complete)
+			sm->rekey =3D true;
+
 		handshake_state_new_snonce(sm->handshake);
 		handshake_state_set_anonce(sm->handshake, ek->key_nonce);
 =

@@ -1634,6 +1640,44 @@ static int eapol_ie_matches(const void *ies, size_t =
ies_len,
 	return -ENOENT;
 }
 =

+static void eapol_finish_ptk_3_of_4(struct eapol_sm *sm,
+					struct eapol_key *step4,
+					bool unencrypted)
+{
+	struct handshake_state *hs =3D sm->handshake;
+	const uint8_t *kck =3D handshake_state_get_kck(hs);
+	const uint8_t *kek =3D handshake_state_get_kek(hs);
+
+	eapol_sm_write(sm, (struct eapol_frame *) step4, unencrypted);
+
+	if (hs->ptk_complete)
+		return;
+
+	handshake_state_install_ptk(hs);
+
+	if (rekey_offload)
+		rekey_offload(hs->ifindex, kek, kck,
+				sm->replay_counter, sm->user_data);
+
+	l_timeout_remove(sm->timeout);
+	sm->timeout =3D NULL;
+}
+
+static void eapol_rx_ptk_cb(bool success, void *user_data)
+{
+	struct eapol_sm *sm =3D user_data;
+
+	/* Netdev will take care of notifying of key setting failure */
+	if (!success)
+		goto done;
+
+	eapol_finish_ptk_3_of_4(sm, sm->step4, false);
+
+done:
+	l_free(sm->step4);
+	sm->step4 =3D NULL;
+}
+
 static void eapol_handle_ptk_3_of_4(struct eapol_sm *sm,
 					const struct eapol_key *ek,
 					const uint8_t *decrypted_key_data,
@@ -1642,13 +1686,14 @@ static void eapol_handle_ptk_3_of_4(struct eapol_sm=
 *sm,
 {
 	struct handshake_state *hs =3D sm->handshake;
 	const uint8_t *kck;
-	const uint8_t *kek;
 	struct eapol_key *step4;
 	uint8_t mic[MIC_MAXLEN];
 	const uint8_t *gtk =3D NULL;
 	size_t gtk_len;
 	const uint8_t *igtk =3D NULL;
 	size_t igtk_len;
+	const uint8_t *key_id =3D NULL;
+	size_t key_id_len;
 	const uint8_t *rsne;
 	struct ie_rsn_info rsn_info;
 	const uint8_t *optional_rsne =3D NULL;
@@ -1856,6 +1901,41 @@ static void eapol_handle_ptk_3_of_4(struct eapol_sm =
*sm,
 	} else
 		igtk =3D NULL;
 =

+	key_id =3D handshake_util_find_kde(HANDSHAKE_KDE_KEY_ID,
+					decrypted_key_data,
+					decrypted_key_data_size, &key_id_len);
+	if (key_id && hs->ext_key_id_capable) {
+		uint8_t idx;
+
+		if (key_id_len !=3D 2) {
+			l_error("invalid Key ID KDE format");
+			handshake_failed(sm, MMPDU_REASON_CODE_UNSPECIFIED);
+			return;
+		}
+
+		idx =3D bit_field(key_id[0], 0, 2);
+
+		/*
+		 * IEEE 802.11-2020 - 12.7.6.4 4-way handshake message 3
+		 * "... the Authenticator assigns a new Key ID for the PTKSA in
+		 * the range of 0 to 1 that is different from the Key ID
+		 * assigned in the previous handshake"
+		 */
+		if (idx !=3D 0 && idx !=3D 1 && idx !=3D hs->ptk_index) {
+			l_error("invalid Key ID KDE value (%u)", idx);
+			handshake_failed(sm, MMPDU_REASON_CODE_UNSPECIFIED);
+			return;
+		}
+
+		hs->ptk_index =3D idx;
+
+		/* initial connection's don't do the RX only key dance */
+		if (sm->rekey)
+			hs->use_ext_key_id =3D true;
+
+		l_debug("using Extended key ID %u", hs->ptk_index);
+	}
+
 	if (hs->support_ip_allocation) {
 		size_t len;
 		const uint8_t *ip_alloc_kde =3D
@@ -1911,7 +1991,6 @@ retransmit:
 					hs->wpa_ie, sm->mic_len);
 =

 	kck =3D handshake_state_get_kck(hs);
-	kek =3D handshake_state_get_kek(hs);
 =

 	if (sm->mic_len) {
 		if (!eapol_calculate_mic(hs->akm_suite, kck,
@@ -1934,12 +2013,6 @@ retransmit:
 		}
 	}
 =

-	eapol_sm_write(sm, (struct eapol_frame *) step4, unencrypted);
-	l_free(step4);
-
-	if (hs->ptk_complete)
-		return;
-
 	/*
 	 * For WPA1 the group handshake should be happening after we set the
 	 * ptk, this flag tells netdev to wait for the gtk/igtk before
@@ -1954,14 +2027,18 @@ retransmit:
 	if (igtk)
 		eapol_install_igtk(sm, igtk_key_index, igtk, igtk_len);
 =

-	handshake_state_install_ptk(hs);
+	if (hs->use_ext_key_id && sm->rekey) {
+		sm->rekey =3D false;
+		sm->step4 =3D step4;
 =

-	if (rekey_offload)
-		rekey_offload(hs->ifindex, kek, kck,
-				sm->replay_counter, sm->user_data);
+		handshake_state_install_rx_ptk(hs, hs->ptk_index,
+						eapol_rx_ptk_cb, sm);
 =

-	l_timeout_remove(sm->timeout);
-	sm->timeout =3D NULL;
+		return;
+	}
+
+	eapol_finish_ptk_3_of_4(sm, step4, unencrypted);
+	l_free(step4);
 =

 	return;
 =

-- =

2.31.1

--===============3132809498860244119==--

