Content-Type: multipart/mixed; boundary="===============7948546297766362609=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/5] eapol: Remove assumption of single cipher in
 authenticator IE
Date: Sat, 30 Jan 2021 00:27:38 +0100
Message-ID: <20210129232740.27393-3-andrew.zaborowski@intel.com>
In-Reply-To: <20210129232740.27393-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7948546297766362609==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Allow the user of the eapol_sm & handshake_state APIs to have multiple
pairwise ciphers listed in the authenticator IE.  This comes at the cost
of requiring the user to call handshake_state_override_pairwise_cipher
to select the cipher when setting up the handshake state.
---
 src/adhoc.c     |  1 +
 src/ap.c        |  2 ++
 src/eapol.c     | 20 +++++++++++++++-----
 src/handshake.c | 25 +++++++++++++++----------
 src/handshake.h |  2 ++
 5 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/src/adhoc.c b/src/adhoc.c
index 7f9ce765..d83ed94e 100644
--- a/src/adhoc.c
+++ b/src/adhoc.c
@@ -257,6 +257,7 @@ static struct eapol_sm *adhoc_new_sm(struct sta_state *=
sta, bool authenticator,
 	handshake_state_set_authenticator_ie(hs, bss_rsne);
 	handshake_state_set_supplicant_ie(hs, bss_rsne);
 	handshake_state_set_pmk(hs, adhoc->pmk, 32);
+	handshake_state_override_pairwise_cipher(hs, adhoc->ciphers);
 =

 	if (authenticator) {
 		handshake_state_set_authenticator_address(hs, own_addr);
diff --git a/src/ap.c b/src/ap.c
index 1e028122..1359dcac 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -724,6 +724,8 @@ static void ap_start_handshake(struct sta_state *sta, b=
ool use_eapol_start,
 	ie_build_rsne(&rsn, bss_rsne);
 	handshake_state_set_authenticator_ie(sta->hs, bss_rsne);
 =

+	handshake_state_override_pairwise_cipher(sta->hs, ap->ciphers);
+
 	if (gtk_rsc)
 		handshake_state_set_gtk(sta->hs, sta->ap->gtk,
 					sta->ap->gtk_index, gtk_rsc);
diff --git a/src/eapol.c b/src/eapol.c
index c42f1a05..49abb105 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1275,7 +1275,7 @@ static void eapol_send_ptk_3_of_4(struct eapol_sm *sm)
 {
 	uint8_t frame_buf[512];
 	unsigned int rsne_len =3D sm->handshake->authenticator_ie[1] + 2;
-	uint8_t key_data_buf[128 + rsne_len];
+	uint8_t key_data_buf[128 + rsne_len * 2];
 	int key_data_len =3D rsne_len;
 	struct eapol_key *ek =3D (struct eapol_key *) frame_buf;
 	enum crypto_cipher cipher =3D ie_rsn_cipher_suite_to_cipher(
@@ -1284,6 +1284,8 @@ static void eapol_send_ptk_3_of_4(struct eapol_sm *sm)
 				sm->handshake->group_cipher);
 	const uint8_t *kck;
 	const uint8_t *kek;
+	uint16_t mask =3D sm->handshake->supplicant_ciphers &
+		sm->handshake->authenticator_ciphers;
 =

 	sm->replay_counter++;
 =

@@ -1306,12 +1308,20 @@ static void eapol_send_ptk_3_of_4(struct eapol_sm *=
sm)
 	ek->key_rsc[6] =3D 0;
 	ek->key_rsc[7] =3D 0;
 =

-	/*
-	 * Just one RSNE in Key Data as we only set one cipher in ap->ciphers
-	 * currently.
-	 */
 	memcpy(key_data_buf, sm->handshake->authenticator_ie, rsne_len);
 =

+	/* See if we need to add the second RSNE */
+	if (sm->handshake->pairwise_cipher !=3D mask) {
+		struct ie_rsn_info rsn_info;
+
+		rsn_info.pairwise_ciphers =3D sm->handshake->pairwise_cipher;
+
+		if (!ie_build_rsne(&rsn_info, key_data_buf + rsne_len))
+			return;
+
+		key_data_len +=3D key_data_buf[rsne_len + 1] + 2;
+	}
+
 	if (group_cipher) {
 		uint8_t *gtk_kde =3D key_data_buf + key_data_len;
 =

diff --git a/src/handshake.c b/src/handshake.c
index e76cf8fb..884b8f96 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -133,14 +133,10 @@ void handshake_state_set_8021x_config(struct handshak=
e_state *s,
 static bool handshake_state_setup_own_ciphers(struct handshake_state *s,
 						const struct ie_rsn_info *info)
 {
-	if (__builtin_popcount(info->pairwise_ciphers) !=3D 1)
-		return false;
-
 	if (__builtin_popcount(info->akm_suites) !=3D 1)
 		return false;
 =

 	s->akm_suite =3D info->akm_suites;
-	s->pairwise_cipher =3D info->pairwise_ciphers;
 	s->group_cipher =3D info->group_cipher;
 	s->group_management_cipher =3D info->group_management_cipher;
 =

@@ -164,9 +160,6 @@ bool handshake_state_set_authenticator_ie(struct handsh=
ake_state *s,
 	s->wpa_ie =3D is_ie_wpa_ie(ie + 2, ie[1]);
 	s->osen_ie =3D is_ie_wfa_ie(ie + 2, ie[1], IE_WFA_OI_OSEN);
 =

-	if (!s->authenticator)
-		return true;
-
 	if (s->wpa_ie) {
 		if (ie_parse_wpa_from_data(ie, ie[1] + 2, &info) < 0)
 			return false;
@@ -178,6 +171,11 @@ bool handshake_state_set_authenticator_ie(struct hands=
hake_state *s,
 			return false;
 	}
 =

+	s->authenticator_ciphers =3D info.pairwise_ciphers;
+
+	if (!s->authenticator)
+		return true;
+
 	return handshake_state_setup_own_ciphers(s, &info);
 }
 =

@@ -191,9 +189,6 @@ bool handshake_state_set_supplicant_ie(struct handshake=
_state *s,
 	s->wpa_ie =3D is_ie_wpa_ie(ie + 2, ie[1]);
 	s->osen_ie =3D is_ie_wfa_ie(ie + 2, ie[1], IE_WFA_OI_OSEN);
 =

-	if (s->authenticator)
-		return true;
-
 	if (s->wpa_ie) {
 		if (ie_parse_wpa_from_data(ie, ie[1] + 2, &info) < 0)
 			return false;
@@ -205,6 +200,16 @@ bool handshake_state_set_supplicant_ie(struct handshak=
e_state *s,
 			return false;
 	}
 =

+	s->supplicant_ciphers =3D info.pairwise_ciphers;
+
+	if (s->authenticator)
+		return true;
+
+	if (__builtin_popcount(info.pairwise_ciphers) !=3D 1)
+		return false;
+
+	s->pairwise_cipher =3D info.pairwise_ciphers;
+
 	return handshake_state_setup_own_ciphers(s, &info);
 }
 =

diff --git a/src/handshake.h b/src/handshake.h
index b738efd9..12aee921 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -88,6 +88,8 @@ struct handshake_state {
 	uint8_t *mde;
 	uint8_t *fte;
 	enum ie_rsn_cipher_suite pairwise_cipher;
+	enum ie_rsn_cipher_suite authenticator_ciphers;
+	enum ie_rsn_cipher_suite supplicant_ciphers;
 	enum ie_rsn_cipher_suite group_cipher;
 	enum ie_rsn_cipher_suite group_management_cipher;
 	enum ie_rsn_akm_suite akm_suite;
-- =

2.20.1

--===============7948546297766362609==--

