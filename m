Content-Type: multipart/mixed; boundary="===============5807843454199421711=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/7] ft: expose ft_build_authenticate_ies
Date: Tue, 27 Apr 2021 12:49:41 -0700
Message-ID: <20210427194945.49731-3-prestwoj@gmail.com>
In-Reply-To: <20210427194945.49731-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5807843454199421711==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The building of the FT IEs for Action/Authenticate
frames will need to be shared between ft and netdev
once FT-over-DS is refactored.

The building was refactored to work off the callers
buffer rather than internal stack buffers. An argument
'new_snonce' was included as FT-over-DS will generate
a new snonce for the initial action frame, hence the
handshakes snonce cannot be used.
---
 src/ft.c | 62 +++++++++++++++++++++++++++++++-------------------------
 src/ft.h |  4 ++++
 2 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/src/ft.c b/src/ft.c
index 698170cc..80782a58 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -724,19 +724,16 @@ static void ft_sm_free(struct auth_proto *ap)
 	l_free(ft);
 }
 =

-static bool ft_start(struct auth_proto *ap)
+bool ft_build_authenticate_ies(struct handshake_state *hs,
+				const uint8_t *new_snonce, uint8_t *buf,
+				size_t *len)
 {
-	struct ft_sm *ft =3D l_container_of(ap, struct ft_sm, ap);
-	struct handshake_state *hs =3D ft->hs;
 	uint32_t kck_len =3D handshake_state_get_kck_len(hs);
 	bool is_rsn =3D hs->supplicant_ie !=3D NULL;
-	uint8_t mde[5];
-	struct iovec iov[3];
-	size_t iov_elems =3D 0;
+	uint8_t *ptr =3D buf;
 =

 	if (is_rsn) {
 		struct ie_rsn_info rsn_info;
-		uint8_t *rsne;
 =

 		/*
 		 * Rebuild the RSNE to include the PMKR0Name and append
@@ -757,26 +754,18 @@ static bool ft_start(struct auth_proto *ap)
 		rsn_info.num_pmkids =3D 1;
 		rsn_info.pmkids =3D hs->pmk_r0_name;
 =

-		rsne =3D alloca(256);
-		ie_build_rsne(&rsn_info, rsne);
-
-		iov[iov_elems].iov_base =3D rsne;
-		iov[iov_elems].iov_len =3D rsne[1] + 2;
-		iov_elems +=3D 1;
+		ie_build_rsne(&rsn_info, ptr);
+		ptr +=3D ptr[1] + 2;
 	}
 =

 	/* The MDE advertised by the BSS must be passed verbatim */
-	mde[0] =3D IE_TYPE_MOBILITY_DOMAIN;
-	mde[1] =3D 3;
-	memcpy(mde + 2, hs->mde + 2, 3);
-
-	iov[iov_elems].iov_base =3D mde;
-	iov[iov_elems].iov_len =3D 5;
-	iov_elems +=3D 1;
+	ptr[0] =3D IE_TYPE_MOBILITY_DOMAIN;
+	ptr[1] =3D 3;
+	memcpy(ptr + 2, hs->mde + 2, 3);
+	ptr +=3D 5;
 =

 	if (is_rsn) {
 		struct ie_ft_info ft_info;
-		uint8_t *fte;
 =

 		/*
 		 * 12.8.2: "If present, the FTE shall be set as follows:
@@ -793,17 +782,34 @@ static bool ft_start(struct auth_proto *ap)
 		memcpy(ft_info.r0khid, hs->r0khid, hs->r0khid_len);
 		ft_info.r0khid_len =3D hs->r0khid_len;
 =

-		memcpy(ft_info.snonce, hs->snonce, 32);
+		memcpy(ft_info.snonce, new_snonce, 32);
 =

-		fte =3D alloca(256);
-		ie_build_fast_bss_transition(&ft_info, kck_len, fte);
+		ie_build_fast_bss_transition(&ft_info, kck_len, ptr);
 =

-		iov[iov_elems].iov_base =3D fte;
-		iov[iov_elems].iov_len =3D fte[1] + 2;
-		iov_elems +=3D 1;
+		ptr +=3D ptr[1] + 2;
 	}
 =

-	ft->tx_auth(iov, iov_elems, ft->user_data);
+	if (len)
+		*len =3D ptr - buf;
+
+	return true;
+}
+
+static bool ft_start(struct auth_proto *ap)
+{
+	struct ft_sm *ft =3D l_container_of(ap, struct ft_sm, ap);
+	struct handshake_state *hs =3D ft->hs;
+	struct iovec iov;
+	uint8_t buf[512];
+	size_t len;
+
+	if (!ft_build_authenticate_ies(hs, hs->snonce, buf, &len))
+		return false;
+
+	iov.iov_base =3D buf;
+	iov.iov_len =3D len;
+
+	ft->tx_auth(&iov, 1, ft->user_data);
 =

 	return true;
 }
diff --git a/src/ft.h b/src/ft.h
index 6f6a7fd5..f24b3b5e 100644
--- a/src/ft.h
+++ b/src/ft.h
@@ -25,6 +25,10 @@ typedef void (*ft_tx_authenticate_func_t)(struct iovec *=
iov, size_t iov_len,
 typedef void (*ft_tx_associate_func_t)(struct iovec *ie_iov, size_t iov_le=
n,
 					void *user_data);
 =

+bool ft_build_authenticate_ies(struct handshake_state *hs,
+				const uint8_t *new_snonce, uint8_t *buf,
+				size_t *len);
+
 struct auth_proto *ft_over_air_sm_new(struct handshake_state *hs,
 				ft_tx_authenticate_func_t tx_auth,
 				ft_tx_associate_func_t tx_assoc,
-- =

2.26.2

--===============5807843454199421711==--

