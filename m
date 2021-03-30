Content-Type: multipart/mixed; boundary="===============0692399857671925597=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 5/7] station: set handshake->offload if required
Date: Tue, 30 Mar 2021 11:48:06 -0700
Message-ID: <20210330184808.744574-5-prestwoj@gmail.com>
In-Reply-To: <20210330184808.744574-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0692399857671925597==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the selected AKM requires offloading set the flag in the
handshake as such. This also removes the need for
wiphy_support_cmds_auth_assoc.
---
 src/station.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/src/station.c b/src/station.c
index 0329d990..e161421b 100644
--- a/src/station.c
+++ b/src/station.c
@@ -802,6 +802,7 @@ static int station_build_handshake_rsn(struct handshake=
_state *hs,
 	enum security security =3D network_get_security(network);
 	bool add_mde =3D false;
 	bool fils_hint =3D false;
+	bool offload =3D false;
 =

 	struct ie_rsn_info bss_info;
 	uint8_t rsne_buf[256];
@@ -824,7 +825,12 @@ static int station_build_handshake_rsn(struct handshak=
e_state *hs,
 	if (security =3D=3D SECURITY_8021X && hs->support_fils)
 		fils_hint =3D station_has_erp_identity(network);
 =

-	info.akm_suites =3D wiphy_select_akm(wiphy, bss, fils_hint, NULL);
+	info.akm_suites =3D wiphy_select_akm(wiphy, bss, fils_hint, &offload);
+
+	hs->offload =3D offload;
+
+	if (hs->offload)
+		l_debug("Connection will offload 4-way handshake to firmware");
 =

 	/*
 	 * Special case for OWE. With OWE we still need to build up the
@@ -981,16 +987,6 @@ static struct handshake_state *station_handshake_setup=
(struct station *station,
 				goto no_psk;
 =

 			handshake_state_set_passphrase(hs, passphrase);
-
-			/*
-			 * TODO: This check isn't strictly correct since
-			 * some drivers may support EXTERNAL_AUTH but since
-			 * wiphy_can_connect takes this into account IWD should
-			 * have already rejected the connection if this was the
-			 * case.
-			 */
-			if (!wiphy_supports_cmds_auth_assoc(wiphy))
-				hs->offload =3D true;
 		} else {
 			const uint8_t *psk =3D network_get_psk(network);
 =

-- =

2.26.2

--===============0692399857671925597==--

