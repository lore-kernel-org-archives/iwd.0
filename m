Content-Type: multipart/mixed; boundary="===============7371349712257947322=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3] ft: set OCVC false for FT-over-DS
Date: Tue, 28 Sep 2021 09:45:53 -0700
Message-ID: <20210928164553.2856733-1-prestwoj@gmail.com>

--===============7371349712257947322==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

FT-over-DS cannot use OCV due to how the kernel works. This means
we could connect initially with OCVC set, but a FT-over-DS attempt
needs to unset OCVC. Set OCVC false when rebuilding the RSNE for
reassociation.
---
 src/ft.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/ft.c b/src/ft.c
index 9c5bc8b0..52506301 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -43,6 +43,8 @@ struct ft_sm {
 	ft_get_oci get_oci;
 =

 	void *user_data;
+
+	bool over_ds:1;
 };
 =

 /*
@@ -236,6 +238,10 @@ static int ft_tx_reassociate(struct ft_sm *ft)
 		rsn_info.num_pmkids =3D 1;
 		rsn_info.pmkids =3D hs->pmk_r1_name;
 =

+		/* Always set OCVC false for FT-over-DS */
+		if (ft->over_ds)
+			rsn_info.ocvc =3D false;
+
 		rsne =3D alloca(256);
 		ie_build_rsne(&rsn_info, rsne);
 =

@@ -929,6 +935,7 @@ struct auth_proto *ft_over_ds_sm_new(struct handshake_s=
tate *hs,
 	ft->tx_assoc =3D tx_assoc;
 	ft->hs =3D hs;
 	ft->user_data =3D user_data;
+	ft->over_ds =3D true;
 =

 	ft->ap.rx_associate =3D ft_rx_associate;
 	ft->ap.start =3D ft_over_ds_start;
-- =

2.31.1

--===============7371349712257947322==--

