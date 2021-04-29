Content-Type: multipart/mixed; boundary="===============1718860703713155336=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 3/7] ft: separate over-air from over-ds initializers
Date: Thu, 29 Apr 2021 16:08:37 -0700
Message-ID: <20210429230841.222368-3-prestwoj@gmail.com>
In-Reply-To: <20210429230841.222368-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1718860703713155336==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ft.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/src/ft.c b/src/ft.c
index d482e539..d5f1db5b 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -917,10 +917,9 @@ static bool ft_start(struct auth_proto *ap)
 	return true;
 }
 =

-static struct auth_proto *ft_sm_new(struct handshake_state *hs,
+struct auth_proto *ft_over_air_sm_new(struct handshake_state *hs,
 				ft_tx_authenticate_func_t tx_auth,
 				ft_tx_associate_func_t tx_assoc,
-				bool over_air,
 				void *user_data)
 {
 	struct ft_sm *ft =3D l_new(struct ft_sm, 1);
@@ -930,7 +929,7 @@ static struct auth_proto *ft_sm_new(struct handshake_st=
ate *hs,
 	ft->hs =3D hs;
 	ft->user_data =3D user_data;
 =

-	ft->ap.rx_authenticate =3D (over_air) ? ft_rx_authenticate : ft_rx_action;
+	ft->ap.rx_authenticate =3D ft_rx_authenticate;
 	ft->ap.rx_associate =3D ft_rx_associate;
 	ft->ap.start =3D ft_start;
 	ft->ap.free =3D ft_sm_free;
@@ -938,18 +937,22 @@ static struct auth_proto *ft_sm_new(struct handshake_=
state *hs,
 	return &ft->ap;
 }
 =

-struct auth_proto *ft_over_air_sm_new(struct handshake_state *hs,
-				ft_tx_authenticate_func_t tx_auth,
-				ft_tx_associate_func_t tx_assoc,
-				void *user_data)
-{
-	return ft_sm_new(hs, tx_auth, tx_assoc, true, user_data);
-}
-
 struct auth_proto *ft_over_ds_sm_new(struct handshake_state *hs,
 				ft_tx_authenticate_func_t tx_auth,
 				ft_tx_associate_func_t tx_assoc,
 				void *user_data)
 {
-	return ft_sm_new(hs, tx_auth, tx_assoc, false, user_data);
+	struct ft_sm *ft =3D l_new(struct ft_sm, 1);
+
+	ft->tx_assoc =3D tx_assoc;
+	ft->tx_auth =3D tx_auth;
+	ft->hs =3D hs;
+	ft->user_data =3D user_data;
+
+	ft->ap.rx_authenticate =3D ft_rx_action;
+	ft->ap.rx_associate =3D ft_rx_associate;
+	ft->ap.start =3D ft_start;
+	ft->ap.free =3D ft_sm_free;
+
+	return &ft->ap;
 }
-- =

2.26.2

--===============1718860703713155336==--

