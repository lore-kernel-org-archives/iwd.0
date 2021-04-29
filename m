Content-Type: multipart/mixed; boundary="===============2977445177621717213=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/6] ft: separate over-air from over-ds initializers
Date: Thu, 29 Apr 2021 12:40:59 -0700
Message-ID: <20210429194103.207447-2-prestwoj@gmail.com>
In-Reply-To: <20210429194103.207447-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2977445177621717213==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ft.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/src/ft.c b/src/ft.c
index 82c790de..ea6eba69 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -923,10 +923,9 @@ static bool ft_start(struct auth_proto *ap)
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
@@ -936,7 +935,7 @@ static struct auth_proto *ft_sm_new(struct handshake_st=
ate *hs,
 	ft->hs =3D hs;
 	ft->user_data =3D user_data;
 =

-	ft->ap.rx_authenticate =3D (over_air) ? ft_rx_authenticate : ft_rx_action;
+	ft->ap.rx_authenticate =3D ft_rx_authenticate;
 	ft->ap.rx_associate =3D ft_rx_associate;
 	ft->ap.start =3D ft_start;
 	ft->ap.free =3D ft_sm_free;
@@ -944,18 +943,22 @@ static struct auth_proto *ft_sm_new(struct handshake_=
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

--===============2977445177621717213==--

