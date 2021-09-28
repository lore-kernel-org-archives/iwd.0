Content-Type: multipart/mixed; boundary="===============6992892786519634597=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 6/9] eapol: include OCI in GTK 2/2
Date: Tue, 28 Sep 2021 14:27:41 -0700
Message-ID: <20210928212744.717276-6-prestwoj@gmail.com>
In-Reply-To: 20210928212744.717276-1-prestwoj@gmail.com

--===============6992892786519634597==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/eapol.c | 32 +++++++++++++++++++++++++++-----
 src/eapol.h |  2 ++
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index 3127e066..85718ed1 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -762,6 +762,8 @@ struct eapol_key *eapol_create_gtk_2_of_2(
 				enum eapol_protocol_version protocol,
 				enum eapol_key_descriptor_version version,
 				uint64_t key_replay_counter,
+				size_t extra_len,
+				const uint8_t *extra_data,
 				bool is_wpa, uint8_t wpa_key_id, size_t mic_len)
 {
 	uint8_t snonce[32];
@@ -770,7 +772,8 @@ struct eapol_key *eapol_create_gtk_2_of_2(
 	memset(snonce, 0, sizeof(snonce));
 	step2 =3D eapol_create_common(protocol, version, true,
 					key_replay_counter, snonce,
-					0, NULL, 0, is_wpa, mic_len);
+					extra_len, extra_data, 0, is_wpa,
+					mic_len);
 =

 	if (!step2)
 		return step2;
@@ -1246,10 +1249,13 @@ static void eapol_handle_ptk_1_of_4(struct eapol_sm=
 *sm,
 	}
 =

 	/*
-	 * IEEE 802.11-2020 Section 12.7.6.3
-	 * "Additionally, contains an OCI KDE when
-	 *  dot11RSNAOperatingChannelValidationActivated is true on the
-	 *  Supplicant."
+	 * IEEE 802.11-2020 Section 12.7.7.3
+	 * "If dot11RSNAOperatingChannelValidationActivated is true and
+	 * Supplicant RSNE indicates OCVC capability, the Authenticator silently
+	 * discards message 2 if any of the following are true:
+	 *     - OCI KDE is missing in the message
+	 *     - Channel information in the OCI KDE does not match current
+	 *       operating channel parameters (see 12.2.9)"
 	 */
 	if (sm->handshake->supplicant_ocvc && sm->handshake->chandef) {
 		ies[ies_len++] =3D IE_TYPE_VENDOR_SPECIFIC;
@@ -2010,6 +2016,8 @@ static void eapol_handle_gtk_1_of_2(struct eapol_sm *=
sm,
 	uint16_t igtk_key_index;
 	const uint8_t *oci =3D NULL;
 	size_t oci_len;
+	uint8_t oci_out[9];
+
 =

 	l_debug("ifindex=3D%u", hs->ifindex);
 =

@@ -2068,6 +2076,19 @@ static void eapol_handle_gtk_1_of_2(struct eapol_sm =
*sm,
 	} else
 		igtk =3D NULL;
 =

+	/*
+	 * IEEE 802.11-2020 Section 12.7.6.3
+	 * "Additionally, contains an OCI KDE when
+	 *  dot11RSNAOperatingChannelValidationActivated is true on the
+	 *  Supplicant."
+	 */
+	if (sm->handshake->supplicant_ocvc && sm->handshake->chandef) {
+		oci_out[0] =3D IE_TYPE_VENDOR_SPECIFIC;
+		oci_out[1] =3D 4 + 3;
+		l_put_be32(HANDSHAKE_KDE_OCI, oci_out + 2);
+		oci_from_chandef(sm->handshake->chandef, oci_out + 6);
+	}
+
 	/*
 	 * 802.11-2016, Section 12.7.7.2:
 	 * "
@@ -2089,6 +2110,7 @@ static void eapol_handle_gtk_1_of_2(struct eapol_sm *=
sm,
 	step2 =3D eapol_create_gtk_2_of_2(sm->protocol_version,
 					ek->key_descriptor_version,
 					sm->replay_counter,
+					oci_out[1] + 2, oci_out,
 					hs->wpa_ie, ek->wpa_key_id,
 					sm->mic_len);
 =

diff --git a/src/eapol.h b/src/eapol.h
index a948c018..53ae6e8f 100644
--- a/src/eapol.h
+++ b/src/eapol.h
@@ -95,6 +95,8 @@ struct eapol_key *eapol_create_gtk_2_of_2(
 				enum eapol_protocol_version protocol,
 				enum eapol_key_descriptor_version version,
 				uint64_t key_replay_counter,
+				size_t extra_len,
+				const uint8_t *extra_data,
 				bool is_wpa, uint8_t wpa_key_id,
 				size_t mic_len);
 =

-- =

2.31.1

--===============6992892786519634597==--

