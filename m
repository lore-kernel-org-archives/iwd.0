Content-Type: multipart/mixed; boundary="===============8900455097066642288=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/7] ft: rework ft_parse_ies
Date: Thu, 29 Apr 2021 14:43:05 -0700
Message-ID: <20210429214311.216293-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8900455097066642288==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds the RSNE verification to ft_parse_ies which will
be common between over-Air and over-DS.
---
 src/ft.c | 102 +++++++++++++++++++++++++++----------------------------
 1 file changed, 50 insertions(+), 52 deletions(-)

diff --git a/src/ft.c b/src/ft.c
index 85d2d369..cb374a08 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -329,14 +329,52 @@ error:
 	return -EINVAL;
 }
 =

-static int ft_parse_ies(const uint8_t *ies, size_t ies_len,
-			const uint8_t **rsne_out, const uint8_t **mde_out,
+static bool ft_verify_rsne(const uint8_t *rsne, const uint8_t *pmk_r0_name,
+				const uint8_t *authenticator_ie)
+{
+	/*
+	 * In an RSN, check for an RSNE containing the PMK-R0-Name and
+	 * the remaining fields same as in the advertised RSNE.
+	 *
+	 * 12.8.3: "The RSNE shall be present only if dot11RSNAActivated
+	 * is true. If present, the RSNE shall be set as follows:
+	 * - Version field shall be set to 1.
+	 * - PMKID Count field shall be set to 1.
+	 * - PMKID List field shall be set to the value contained in the
+	 *   first message of this sequence.
+	 * - All other fields shall be identical to the contents of the
+	 *   RSNE advertised by the AP in Beacon and Probe Response frames."
+	 */
+
+	struct ie_rsn_info msg2_rsne;
+
+	if (!rsne)
+		return false;
+
+	if (ie_parse_rsne_from_data(rsne, rsne[1] + 2,
+						&msg2_rsne) < 0)
+		return false;
+
+	if (msg2_rsne.num_pmkids !=3D 1 ||
+				memcmp(msg2_rsne.pmkids, pmk_r0_name, 16))
+		return false;
+
+	if (!handshake_util_ap_ie_matches(rsne, authenticator_ie, false))
+		return false;
+
+	return true;
+}
+
+static int ft_parse_ies(struct handshake_state *hs,
+			const uint8_t *ies, size_t ies_len,
+			const uint8_t **mde_out,
 			const uint8_t **fte_out)
 {
 	struct ie_tlv_iter iter;
 	const uint8_t *rsne =3D NULL;
 	const uint8_t *mde =3D NULL;
 	const uint8_t *fte =3D NULL;
+	bool is_rsn;
 =

 	ie_tlv_iter_init(&iter, ies, ies_len);
 =

@@ -365,8 +403,14 @@ static int ft_parse_ies(const uint8_t *ies, size_t ies=
_len,
 		}
 	}
 =

-	if (rsne_out)
-		*rsne_out =3D rsne;
+	is_rsn =3D hs->supplicant_ie !=3D NULL;
+
+	if (is_rsn) {
+		if (!ft_verify_rsne(rsne, hs->pmk_r0_name,
+					hs->authenticator_ie))
+			goto ft_error;
+	} else if (rsne)
+		goto ft_error;
 =

 	if (mde_out)
 		*mde_out =3D mde;
@@ -380,42 +424,6 @@ ft_error:
 	return -EINVAL;
 }
 =

-static bool ft_verify_rsne(const uint8_t *rsne, const uint8_t *pmk_r0_name,
-				const uint8_t *authenticator_ie)
-{
-	/*
-	 * In an RSN, check for an RSNE containing the PMK-R0-Name and
-	 * the remaining fields same as in the advertised RSNE.
-	 *
-	 * 12.8.3: "The RSNE shall be present only if dot11RSNAActivated
-	 * is true. If present, the RSNE shall be set as follows:
-	 * - Version field shall be set to 1.
-	 * - PMKID Count field shall be set to 1.
-	 * - PMKID List field shall be set to the value contained in the
-	 *   first message of this sequence.
-	 * - All other fields shall be identical to the contents of the
-	 *   RSNE advertised by the AP in Beacon and Probe Response frames."
-	 */
-
-	struct ie_rsn_info msg2_rsne;
-
-	if (!rsne)
-		return false;
-
-	if (ie_parse_rsne_from_data(rsne, rsne[1] + 2,
-						&msg2_rsne) < 0)
-		return false;
-
-	if (msg2_rsne.num_pmkids !=3D 1 ||
-				memcmp(msg2_rsne.pmkids, pmk_r0_name, 16))
-		return false;
-
-	if (!handshake_util_ap_ie_matches(rsne, authenticator_ie, false))
-		return false;
-
-	return true;
-}
-
 static bool ft_parse_fte(struct handshake_state *hs,
 				const uint8_t *snonce,
 				const uint8_t *fte,
@@ -468,25 +476,15 @@ static bool ft_parse_fte(struct handshake_state *hs,
 static int ft_process_ies(struct handshake_state *hs, const uint8_t *ies,
 			size_t ies_len)
 {
-	const uint8_t *rsne =3D NULL;
 	const uint8_t *mde =3D NULL;
 	const uint8_t *fte =3D NULL;
-	bool is_rsn;
+	bool is_rsn =3D hs->supplicant_ie !=3D NULL;
 =

 	/* Check 802.11r IEs */
 	if (!ies)
 		goto ft_error;
 =

-	if (ft_parse_ies(ies, ies_len, &rsne, &mde, &fte) < 0)
-		goto ft_error;
-
-	is_rsn =3D hs->supplicant_ie !=3D NULL;
-
-	if (is_rsn) {
-		if (!ft_verify_rsne(rsne, hs->pmk_r0_name,
-					hs->authenticator_ie))
-			goto ft_error;
-	} else if (rsne)
+	if (ft_parse_ies(hs, ies, ies_len, &mde, &fte) < 0)
 		goto ft_error;
 =

 	/*
-- =

2.26.2

--===============8900455097066642288==--

