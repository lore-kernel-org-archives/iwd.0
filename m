Content-Type: multipart/mixed; boundary="===============4660043093467765127=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 7/9] station: set OCVC for handshakes
Date: Mon, 27 Sep 2021 10:04:02 -0700
Message-ID: <20210927170404.1292107-7-prestwoj@gmail.com>
In-Reply-To: 20210927170404.1292107-1-prestwoj@gmail.com

--===============4660043093467765127==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Setting OCVC true for all connections except FT-over-DS. Since
Authentication is skipped there is no way to obtain OCI information
from the kernel prior to (Re)association.
---
 src/station.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/src/station.c b/src/station.c
index 672c4860..96794998 100644
--- a/src/station.c
+++ b/src/station.c
@@ -998,11 +998,11 @@ static int station_build_handshake_rsn(struct handsha=
ke_state *hs,
 	enum security security =3D network_get_security(network);
 	bool add_mde =3D false;
 	struct erp_cache_entry *erp_cache =3D NULL;
-
 	struct ie_rsn_info bss_info;
 	uint8_t rsne_buf[256];
 	struct ie_rsn_info info;
 	uint8_t *ap_ie;
+	bool ocvc =3D true;
 =

 	memset(&info, 0, sizeof(info));
 =

@@ -1080,6 +1080,16 @@ static int station_build_handshake_rsn(struct handsh=
ake_state *hs,
 		goto not_supported;
 =

 build_ie:
+	if (IE_AKM_IS_FT(info.akm_suites)) {
+		/* Don't set OCVC if FT-over-DS is enabled */
+		if (bss->mde[2] & 1)
+			ocvc =3D false;
+
+		add_mde =3D true;
+	}
+
+	info.ocvc =3D ocvc;
+
 	/* RSN takes priority */
 	if (bss->rsne) {
 		ap_ie =3D bss->rsne;
@@ -1099,9 +1109,6 @@ build_ie:
 	if (!handshake_state_set_supplicant_ie(hs, rsne_buf))
 		goto not_supported;
 =

-	if (IE_AKM_IS_FT(info.akm_suites))
-		add_mde =3D true;
-
 	/*
 	 * If FILS was chosen, the ERP cache has been verified to exist. Take
 	 * a reference now so it remains valid (in case of expiration) until
-- =

2.31.1

--===============4660043093467765127==--

