Content-Type: multipart/mixed; boundary="===============3763849297306348642=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 6/9] station: set OCVC for handshakes
Date: Tue, 28 Sep 2021 08:46:55 -0700
Message-ID: <20210928154658.2382597-6-prestwoj@gmail.com>
In-Reply-To: 20210928154658.2382597-1-prestwoj@gmail.com

--===============3763849297306348642==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Setting OCVC true for all connections unless disabled
---
 src/station.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index 21416d57..2e7fd0f9 100644
--- a/src/station.c
+++ b/src/station.c
@@ -995,14 +995,15 @@ static int station_build_handshake_rsn(struct handsha=
ke_state *hs,
 					struct network *network,
 					struct scan_bss *bss)
 {
+	const struct l_settings *settings =3D iwd_get_config();
 	enum security security =3D network_get_security(network);
 	bool add_mde =3D false;
 	struct erp_cache_entry *erp_cache =3D NULL;
-
 	struct ie_rsn_info bss_info;
 	uint8_t rsne_buf[256];
 	struct ie_rsn_info info;
 	uint8_t *ap_ie;
+	bool disable_ocv;
 =

 	memset(&info, 0, sizeof(info));
 =

@@ -1080,6 +1081,12 @@ static int station_build_handshake_rsn(struct handsh=
ake_state *hs,
 		goto not_supported;
 =

 build_ie:
+	if (!l_settings_get_bool(settings, "General", "DisableOCV",
+					&disable_ocv))
+		disable_ocv =3D false;
+
+	info.ocvc =3D !disable_ocv;
+
 	/* RSN takes priority */
 	if (bss->rsne) {
 		ap_ie =3D bss->rsne;
-- =

2.31.1

--===============3763849297306348642==--

