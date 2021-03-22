Content-Type: multipart/mixed; boundary="===============8004998928911826871=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 6/6] station: set handshake offload if required
Date: Mon, 22 Mar 2021 09:01:56 -0700
Message-ID: <20210322160156.392256-6-prestwoj@gmail.com>
In-Reply-To: <20210322160156.392256-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8004998928911826871==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If IWD is connecting to a SAE/WPA3 BSS and Auth/Assoc commands
are not supported the only option is SAE offload. At this point
network_connect should have verified that the extended feature
for SAE offload exists so we can simply enable offload if these
commands are not supported.
---
 src/station.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/station.c b/src/station.c
index 2e577290..385dc7da 100644
--- a/src/station.c
+++ b/src/station.c
@@ -979,6 +979,16 @@ static struct handshake_state *station_handshake_setup=
(struct station *station,
 				goto no_psk;
 =

 			handshake_state_set_passphrase(hs, passphrase);
+
+			/*
+			 * TODO: This check isn't strictly correct since
+			 * some drivers may support EXTERNAL_AUTH but since
+			 * wiphy_can_connect takes this into account IWD should
+			 * have already rejected the connection if this was the
+			 * case.
+			 */
+			if (!wiphy_supports_cmds_auth_assoc(wiphy))
+				hs->offload =3D true;
 		} else {
 			const uint8_t *psk =3D network_get_psk(network);
 =

-- =

2.26.2

--===============8004998928911826871==--

