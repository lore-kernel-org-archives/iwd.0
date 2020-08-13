Content-Type: multipart/mixed; boundary="===============2960670741356848356=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 03/16] eapol: Don't re-build the AP RSNE in authenticator mode
Date: Thu, 13 Aug 2020 02:50:13 +0200
Message-ID: <20200813005026.294950-3-andrew.zaborowski@intel.com>
In-Reply-To: <20200813005026.294950-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2960670741356848356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

sm->handshake already contains our RSN/WPA IE so there's no need to
rebuild it for msg 3/4, especially since we hardcode the fact that we
only support one pairwise cipher.  If we start declaring more supported
ciphers and need to include a second RSNE we can first parse
sm->hs->authenticator_ie into a struct ir_rsn_info, overwrite the cipher
and rebuild it from that struct.

This way we duplicate less code and we hardcode fewer facts about the AP
in eapol.c which also helps in adding EAP-WSC.
---
 src/eapol.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index b982e6b6..ae37f6c2 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1267,17 +1267,16 @@ static void eapol_send_ptk_3_of_4(struct eapol_sm *=
sm)
 {
 	uint32_t ifindex =3D sm->handshake->ifindex;
 	uint8_t frame_buf[512];
-	uint8_t key_data_buf[128];
+	unsigned int rsne_len =3D sm->handshake->authenticator_ie[1] + 2;
+	uint8_t key_data_buf[128 + rsne_len];
+	int key_data_len =3D rsne_len;
 	struct eapol_key *ek =3D (struct eapol_key *) frame_buf;
-	int key_data_len;
 	enum crypto_cipher cipher =3D ie_rsn_cipher_suite_to_cipher(
 				sm->handshake->pairwise_cipher);
 	enum crypto_cipher group_cipher =3D ie_rsn_cipher_suite_to_cipher(
 				sm->handshake->group_cipher);
 	const uint8_t *kck;
 	const uint8_t *kek;
-	struct ie_rsn_info rsn;
-	uint8_t *rsne;
 =

 	sm->replay_counter++;
 =

@@ -1304,17 +1303,7 @@ static void eapol_send_ptk_3_of_4(struct eapol_sm *s=
m)
 	 * Just one RSNE in Key Data as we only set one cipher in ap->ciphers
 	 * currently.
 	 */
-
-	memset(&rsn, 0, sizeof(rsn));
-	rsn.akm_suites =3D IE_RSN_AKM_SUITE_PSK;
-	rsn.pairwise_ciphers =3D sm->handshake->pairwise_cipher;
-	rsn.group_cipher =3D sm->handshake->group_cipher;
-
-	rsne =3D key_data_buf;
-	if (!ie_build_rsne(&rsn, rsne))
-		return;
-
-	key_data_len =3D rsne[1] + 2;
+	memcpy(key_data_buf, sm->handshake->authenticator_ie, rsne_len);
 =

 	if (group_cipher) {
 		uint8_t *gtk_kde =3D key_data_buf + key_data_len;
-- =

2.25.1

--===============2960670741356848356==--

