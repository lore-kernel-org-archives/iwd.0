Content-Type: multipart/mixed; boundary="===============2768859076821254318=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 1/5] ft: check authenticator_ie from ft_ds_info,
 not handshake
Date: Tue, 28 Sep 2021 15:05:03 -0700
Message-ID: <20210928220507.944851-1-prestwoj@gmail.com>

--===============2768859076821254318==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The handshake contains the current BSS's RSNE/WPA which may differ
from the FT-over-DS target. When verifying the target BSS's RSNE/WPA
IE needs to be checked, not the current BSS.
---
 src/ft.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/ft.c b/src/ft.c
index fecb4c0e..7a4b16f3 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -354,6 +354,7 @@ static bool ft_verify_rsne(const uint8_t *rsne, const u=
int8_t *pmk_r0_name,
 }
 =

 static int ft_parse_ies(struct handshake_state *hs,
+			const uint8_t *authenticator_ie,
 			const uint8_t *ies, size_t ies_len,
 			const uint8_t **mde_out,
 			const uint8_t **fte_out)
@@ -394,8 +395,7 @@ static int ft_parse_ies(struct handshake_state *hs,
 	is_rsn =3D hs->supplicant_ie !=3D NULL;
 =

 	if (is_rsn) {
-		if (!ft_verify_rsne(rsne, hs->pmk_r0_name,
-					hs->authenticator_ie))
+		if (!ft_verify_rsne(rsne, hs->pmk_r0_name, authenticator_ie))
 			goto ft_error;
 	} else if (rsne)
 		goto ft_error;
@@ -485,7 +485,8 @@ bool ft_over_ds_parse_action_ies(struct ft_ds_info *inf=
o,
 	const uint8_t *fte =3D NULL;
 	bool is_rsn =3D hs->supplicant_ie !=3D NULL;
 =

-	if (ft_parse_ies(hs, ies, ies_len, &mde, &fte) < 0)
+	if (ft_parse_ies(hs, info->authenticator_ie, ies, ies_len,
+				&mde, &fte) < 0)
 		return false;
 =

 	if (!mde_equal(info->mde, mde))
@@ -516,7 +517,8 @@ static int ft_process_ies(struct handshake_state *hs, c=
onst uint8_t *ies,
 	if (!ies)
 		goto ft_error;
 =

-	if (ft_parse_ies(hs, ies, ies_len, &mde, &fte) < 0)
+	if (ft_parse_ies(hs, hs->authenticator_ie, ies, ies_len,
+				&mde, &fte) < 0)
 		goto ft_error;
 =

 	if (!mde_equal(hs->mde, mde))
-- =

2.31.1

--===============2768859076821254318==--

