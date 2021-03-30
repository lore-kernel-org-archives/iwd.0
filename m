Content-Type: multipart/mixed; boundary="===============1106203382897016928=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/7] station: set handshake->offload with wiphy_needs_offload
Date: Tue, 30 Mar 2021 09:13:06 -0700
Message-ID: <20210330161307.732965-6-prestwoj@gmail.com>
In-Reply-To: <20210330161307.732965-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1106203382897016928==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will handle both SAE offloading and PSK offloading in one
API call.
---
 src/station.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/src/station.c b/src/station.c
index cf4dd2e7..ef186c8b 100644
--- a/src/station.c
+++ b/src/station.c
@@ -981,16 +981,6 @@ static struct handshake_state *station_handshake_setup=
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

@@ -999,6 +989,17 @@ static struct handshake_state *station_handshake_setup=
(struct station *station,
 =

 			handshake_state_set_pmk(hs, psk, 32);
 		}
+
+		/*
+		 * wiphy_can_connect/select_akm should have already sorted out
+		 * if both the card supports offload AND the user has enabled
+		 * it.
+		 */
+		hs->offload =3D wiphy_needs_offload(wiphy, hs->akm_suite);
+
+		if (hs->offload)
+			l_debug("Offloading connection to firmware");
+
 	} else if (security =3D=3D SECURITY_8021X)
 		handshake_state_set_8021x_config(hs,
 					network_get_settings(network));
-- =

2.26.2

--===============1106203382897016928==--

