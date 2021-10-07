Content-Type: multipart/mixed; boundary="===============1795954475370094856=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 04/13] eapol: support extended key IDs
Date: Thu, 07 Oct 2021 13:49:48 -0700
Message-ID: <20211007204957.3745985-4-prestwoj@gmail.com>
In-Reply-To: 20211007204957.3745985-1-prestwoj@gmail.com

--===============1795954475370094856==
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
gives us the new PTK key index. Using the new handshake callback
(handshake_state_set_ext_tk) the new TK is installed. The 4th
message is also included as an argument which is taken care of by
netdev (in case waiting for NEW_KEY is required due to PAE socekts).
---
 src/eapol.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 63 insertions(+), 9 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index 07120fdb..cd481317 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -860,6 +860,7 @@ struct eapol_sm {
 	uint8_t installed_igtk_len;
 	uint8_t installed_igtk[CRYPTO_MAX_IGTK_LEN];
 	unsigned int mic_len;
+	bool rekey : 1;
 };
 =

 static void eapol_sm_destroy(void *value)
@@ -1223,6 +1224,9 @@ static void eapol_handle_ptk_1_of_4(struct eapol_sm *=
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

@@ -1643,12 +1647,14 @@ static void eapol_handle_ptk_3_of_4(struct eapol_sm=
 *sm,
 	struct handshake_state *hs =3D sm->handshake;
 	const uint8_t *kck;
 	const uint8_t *kek;
-	struct eapol_key *step4;
+	_auto_(l_free) struct eapol_key *step4 =3D NULL;
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
@@ -1856,6 +1862,44 @@ static void eapol_handle_ptk_3_of_4(struct eapol_sm =
*sm,
 	} else
 		igtk =3D NULL;
 =

+	key_id =3D handshake_util_find_kde(HANDSHAKE_KDE_KEY_ID,
+					decrypted_key_data,
+					decrypted_key_data_size, &key_id_len);
+	if (hs->ext_key_id_capable) {
+		uint8_t idx;
+
+		if (!key_id) {
+			l_debug("No extended key KDE in frame 3/4");
+			handshake_failed(sm, MMPDU_REASON_CODE_INVALID_IE);
+			return;
+		}
+
+		if (key_id_len !=3D 2) {
+			l_error("invalid Key ID KDE format");
+			handshake_failed(sm, MMPDU_REASON_CODE_INVALID_IE);
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
+		if ((idx !=3D 0 && idx !=3D 1) || (sm->rekey &&
+						idx =3D=3D hs->active_tk_index)) {
+			l_error("invalid Key ID KDE value (%u)", idx);
+			handshake_failed(sm, MMPDU_REASON_CODE_INVALID_IE);
+			return;
+		}
+
+		hs->active_tk_index =3D idx;
+
+		l_debug("using Extended key ID %u", hs->active_tk_index);
+	}
+
 	if (hs->support_ip_allocation) {
 		size_t len;
 		const uint8_t *ip_alloc_kde =3D
@@ -1917,7 +1961,6 @@ retransmit:
 		if (!eapol_calculate_mic(hs->akm_suite, kck,
 						step4, mic, sm->mic_len)) {
 			l_debug("MIC Calculation failed");
-			l_free(step4);
 			handshake_failed(sm, MMPDU_REASON_CODE_UNSPECIFIED);
 			return;
 		}
@@ -1928,18 +1971,11 @@ retransmit:
 						handshake_state_get_kek_len(hs),
 						step4, NULL, 0)) {
 			l_debug("AES-SIV encryption failed");
-			l_free(step4);
 			handshake_failed(sm, MMPDU_REASON_CODE_UNSPECIFIED);
 			return;
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
@@ -1954,6 +1990,24 @@ retransmit:
 	if (igtk)
 		eapol_install_igtk(sm, igtk_key_index, igtk, igtk_len);
 =

+	/*
+	 * Only install if this is the first 3/4 message (not retransmitting)
+	 * and a rekey. Initial associations don't need the special RX -> TX
+	 * procedure and can install the TK normally
+	 */
+	if (key_id && hs->ext_key_id_capable && sm->rekey) {
+		handshake_state_install_ext_ptk(hs, hs->active_tk_index,
+						(struct eapol_frame *) step4,
+						ETH_P_PAE, unencrypted);
+
+		return;
+	}
+
+	eapol_sm_write(sm, (struct eapol_frame *) step4, unencrypted);
+
+	if (hs->ptk_complete)
+		return;
+
 	handshake_state_install_ptk(hs);
 =

 	if (rekey_offload)
-- =

2.31.1

--===============1795954475370094856==--

