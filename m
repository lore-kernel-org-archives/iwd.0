Content-Type: multipart/mixed; boundary="===============1546674708981145410=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] eapol: check return of ie_parse_rsne_from_data
Date: Wed, 16 Oct 2019 16:43:03 -0700
Message-ID: <20191016234304.14716-3-prestwoj@gmail.com>
In-Reply-To: <20191016234304.14716-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1546674708981145410==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/eapol.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index cbaf0f4f..6f04dbc5 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1106,7 +1106,8 @@ static void eapol_handle_ptk_1_of_4(struct eapol_sm *=
sm,
 	pmkid =3D handshake_util_find_pmkid_kde(EAPOL_KEY_DATA(ek, sm->mic_len),
 					EAPOL_KEY_DATA_LEN(ek, sm->mic_len));
 =

-	ie_parse_rsne_from_data(own_ie, own_ie[1] + 2, &rsn_info);
+	if (ie_parse_rsne_from_data(own_ie, own_ie[1] + 2, &rsn_info) < 0)
+		goto error_unspecified;
 =

 	/*
 	 * Require the PMKID KDE whenever we've sent a list of PMKIDs in
@@ -1557,7 +1558,8 @@ static void eapol_handle_ptk_3_of_4(struct eapol_sm *=
sm,
 		const uint8_t *mde =3D sm->handshake->mde;
 		const uint8_t *fte =3D sm->handshake->fte;
 =

-		ie_parse_rsne_from_data(rsne, rsne[1] + 2, &ie_info);
+		if (ie_parse_rsne_from_data(rsne, rsne[1] + 2, &ie_info) < 0)
+			goto error_ie_different;
 =

 		if (ie_info.num_pmkids !=3D 1 || memcmp(ie_info.pmkids,
 						sm->handshake->pmk_r1_name, 16))
-- =

2.17.1

--===============1546674708981145410==--

