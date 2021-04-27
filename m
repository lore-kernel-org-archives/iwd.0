Content-Type: multipart/mixed; boundary="===============6319402990325019675=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/7] ft: factor out various parsing routines
Date: Tue, 27 Apr 2021 12:49:40 -0700
Message-ID: <20210427194945.49731-2-prestwoj@gmail.com>
In-Reply-To: <20210427194945.49731-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6319402990325019675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Break up the rather large code block which parses out IEs,
verifies, and sets into the handshake. FT-over-DS needs these
steps broken up in order to parse the action frame response
without modifying the handshake.
---
 src/ft.c | 141 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 93 insertions(+), 48 deletions(-)

diff --git a/src/ft.c b/src/ft.c
index 2c58787d..698170cc 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -329,19 +329,14 @@ error:
 	return -EINVAL;
 }
 =

-static int ft_process_ies(struct handshake_state *hs, const uint8_t *ies,
-			size_t ies_len)
+static int ft_parse_ies(const uint8_t *ies, size_t ies_len,
+			const uint8_t **rsne_out, const uint8_t **mde_out,
+			const uint8_t **fte_out)
 {
 	struct ie_tlv_iter iter;
 	const uint8_t *rsne =3D NULL;
 	const uint8_t *mde =3D NULL;
 	const uint8_t *fte =3D NULL;
-	uint32_t kck_len =3D handshake_state_get_kck_len(hs);
-	bool is_rsn;
-
-	/* Check 802.11r IEs */
-	if (!ies)
-		goto ft_error;
 =

 	ie_tlv_iter_init(&iter, ies, ies_len);
 =

@@ -370,8 +365,24 @@ static int ft_process_ies(struct handshake_state *hs, =
const uint8_t *ies,
 		}
 	}
 =

-	is_rsn =3D hs->supplicant_ie !=3D NULL;
+	if (rsne_out)
+		*rsne_out =3D rsne;
+
+	if (mde_out)
+		*mde_out =3D mde;
+
+	if (fte_out)
+		*fte_out =3D fte;
+
+	return 0;
 =

+ft_error:
+	return -EINVAL;
+}
+
+static bool ft_verify_rsne(const uint8_t *rsne, const uint8_t *pmk_r0_name,
+				const uint8_t *authenticator_ie)
+{
 	/*
 	 * In an RSN, check for an RSNE containing the PMK-R0-Name and
 	 * the remaining fields same as in the advertised RSNE.
@@ -385,36 +396,31 @@ static int ft_process_ies(struct handshake_state *hs,=
 const uint8_t *ies,
 	 * =E2=80=94 All other fields shall be identical to the contents of the
 	 *   RSNE advertised by the AP in Beacon and Probe Response frames."
 	 */
-	if (is_rsn) {
-		struct ie_rsn_info msg2_rsne;
 =

-		if (!rsne)
-			goto ft_error;
+	struct ie_rsn_info msg2_rsne;
 =

-		if (ie_parse_rsne_from_data(rsne, rsne[1] + 2,
+	if (!rsne)
+		return false;
+
+	if (ie_parse_rsne_from_data(rsne, rsne[1] + 2,
 						&msg2_rsne) < 0)
-			goto ft_error;
+		return false;
 =

-		if (msg2_rsne.num_pmkids !=3D 1 ||
-				memcmp(msg2_rsne.pmkids, hs->pmk_r0_name, 16))
-			goto ft_error;
+	if (msg2_rsne.num_pmkids !=3D 1 ||
+				memcmp(msg2_rsne.pmkids, pmk_r0_name, 16))
+		return false;
 =

-		if (!handshake_util_ap_ie_matches(rsne, hs->authenticator_ie,
-							false))
-			goto ft_error;
-	} else if (rsne)
-		goto ft_error;
+	if (!handshake_util_ap_ie_matches(rsne, authenticator_ie, false))
+		return false;
 =

-	/*
-	 * Check for an MD IE identical to the one we sent in message 1
-	 *
-	 * 12.8.3: "The MDE shall contain the MDID and FT Capability and
-	 * Policy fields. This element shall be the same as the MDE
-	 * advertised by the target AP in Beacon and Probe Response frames."
-	 */
-	if (!mde || memcmp(hs->mde, mde, hs->mde[1] + 2))
-		goto ft_error;
+	return true;
+}
 =

+static bool ft_parse_fte(struct handshake_state *hs,
+				const uint8_t *snonce,
+				const uint8_t *fte,
+				struct ie_ft_info *ft_info)
+{
 	/*
 	 * In an RSN, check for an FT IE with the same R0KH-ID and the same
 	 * SNonce that we sent, and check that the R1KH-ID and the ANonce
@@ -433,28 +439,67 @@ static int ft_process_ies(struct handshake_state *hs,=
 const uint8_t *ies,
 	 *   of this sequence.
 	 * =E2=80=94 All other fields shall be set to 0."
 	 */
-	if (is_rsn) {
-		struct ie_ft_info ft_info;
-		uint8_t zeros[24] =3D {};
+	uint8_t zeros[24] =3D {};
+	uint32_t kck_len =3D handshake_state_get_kck_len(hs);
 =

-		if (!fte)
-			goto ft_error;
+	if (!fte)
+		return false;
 =

-		if (ie_parse_fast_bss_transition_from_data(fte, fte[1] + 2,
-						kck_len, &ft_info) < 0)
-			goto ft_error;
+	if (ie_parse_fast_bss_transition_from_data(fte, fte[1] + 2,
+					kck_len, ft_info) < 0)
+		return false;
+	if (ft_info->mic_element_count !=3D 0 ||
+			memcmp(ft_info->mic, zeros, kck_len))
+		return false;
+	if (hs->r0khid_len !=3D ft_info->r0khid_len ||
+			memcmp(hs->r0khid, ft_info->r0khid,
+				hs->r0khid_len) ||
+			!ft_info->r1khid_present)
+		return false;
+	if (memcmp(ft_info->snonce, snonce, 32))
+		return false;
 =

-		if (ft_info.mic_element_count !=3D 0 ||
-				memcmp(ft_info.mic, zeros, kck_len))
-			goto ft_error;
+	return true;
+}
 =

-		if (hs->r0khid_len !=3D ft_info.r0khid_len ||
-				memcmp(hs->r0khid, ft_info.r0khid,
-					hs->r0khid_len) ||
-				!ft_info.r1khid_present)
+static int ft_process_ies(struct handshake_state *hs, const uint8_t *ies,
+			size_t ies_len)
+{
+	const uint8_t *rsne =3D NULL;
+	const uint8_t *mde =3D NULL;
+	const uint8_t *fte =3D NULL;
+	bool is_rsn;
+
+	/* Check 802.11r IEs */
+	if (!ies)
+		goto ft_error;
+
+	if (ft_parse_ies(ies, ies_len, &rsne, &mde, &fte) < 0)
+		goto ft_error;
+
+	is_rsn =3D hs->supplicant_ie !=3D NULL;
+
+	if (is_rsn) {
+		if (!ft_verify_rsne(rsne, hs->pmk_r0_name,
+					hs->authenticator_ie))
 			goto ft_error;
+	} else if (rsne)
+		goto ft_error;
 =

-		if (memcmp(ft_info.snonce, hs->snonce, 32))
+	/*
+	 * Check for an MD IE identical to the one we sent in message 1
+	 *
+	 * 12.8.3: "The MDE shall contain the MDID and FT Capability and
+	 * Policy fields. This element shall be the same as the MDE
+	 * advertised by the target AP in Beacon and Probe Response frames."
+	 */
+	if (!mde || memcmp(hs->mde, mde, hs->mde[1] + 2))
+		goto ft_error;
+
+	if (is_rsn) {
+		struct ie_ft_info ft_info;
+
+		if (!ft_parse_fte(hs, hs->snonce, fte, &ft_info))
 			goto ft_error;
 =

 		handshake_state_set_fte(hs, fte);
-- =

2.26.2

--===============6319402990325019675==--

