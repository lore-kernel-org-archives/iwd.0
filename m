Content-Type: multipart/mixed; boundary="===============0106011424072926962=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 8/9] ft: make Authenticate OCVC settable by caller
Date: Tue, 28 Sep 2021 08:46:57 -0700
Message-ID: <20210928154658.2382597-8-prestwoj@gmail.com>
In-Reply-To: 20210928154658.2382597-1-prestwoj@gmail.com

--===============0106011424072926962==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The FT-over-DS action stage builds an FT-Request which contains an
RSNE. Since FT-over-DS will not support OCV add a boolean to
ft_build_authenticate_ies so the OCVC bit can be disabled rather
than relying on the handshake setting.
---
 src/ft.c     | 6 ++++--
 src/ft.h     | 2 +-
 src/netdev.c | 4 +++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/src/ft.c b/src/ft.c
index 40e29341..9c5bc8b0 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -805,7 +805,7 @@ static bool ft_over_ds_start(struct auth_proto *ap)
 	return ft_tx_reassociate(ft) =3D=3D 0;
 }
 =

-bool ft_build_authenticate_ies(struct handshake_state *hs,
+bool ft_build_authenticate_ies(struct handshake_state *hs, bool ocvc,
 				const uint8_t *new_snonce, uint8_t *buf,
 				size_t *len)
 {
@@ -834,6 +834,7 @@ bool ft_build_authenticate_ies(struct handshake_state *=
hs,
 =

 		rsn_info.num_pmkids =3D 1;
 		rsn_info.pmkids =3D hs->pmk_r0_name;
+		rsn_info.ocvc =3D ocvc;
 =

 		ie_build_rsne(&rsn_info, ptr);
 		ptr +=3D ptr[1] + 2;
@@ -884,7 +885,8 @@ static bool ft_start(struct auth_proto *ap)
 	uint8_t buf[512];
 	size_t len;
 =

-	if (!ft_build_authenticate_ies(hs, hs->snonce, buf, &len))
+	if (!ft_build_authenticate_ies(hs, hs->supplicant_ocvc, hs->snonce,
+					buf, &len))
 		return false;
 =

 	iov.iov_base =3D buf;
diff --git a/src/ft.h b/src/ft.h
index cc25463f..a2fa8946 100644
--- a/src/ft.h
+++ b/src/ft.h
@@ -44,7 +44,7 @@ struct ft_ds_info {
 =

 void ft_ds_info_free(struct ft_ds_info *info);
 =

-bool ft_build_authenticate_ies(struct handshake_state *hs,
+bool ft_build_authenticate_ies(struct handshake_state *hs, bool ocvc,
 				const uint8_t *new_snonce, uint8_t *buf,
 				size_t *len);
 =

diff --git a/src/netdev.c b/src/netdev.c
index a0669173..53a0a184 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4402,7 +4402,9 @@ int netdev_fast_transition_over_ds_action(struct netd=
ev *netdev,
 	iovs[0].iov_base =3D ft_req;
 	iovs[0].iov_len =3D sizeof(ft_req);
 =

-	if (!ft_build_authenticate_ies(hs, info->super.snonce, buf, &len))
+
+	if (!ft_build_authenticate_ies(hs, false, info->super.snonce,
+						buf, &len))
 		goto failed;
 =

 	iovs[1].iov_base =3D buf;
-- =

2.31.1

--===============0106011424072926962==--

