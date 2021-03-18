Content-Type: multipart/mixed; boundary="===============4509126394623233180=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/6] station: set handshake offload if required
Date: Thu, 18 Mar 2021 10:20:39 -0700
Message-ID: <20210318172039.278896-6-prestwoj@gmail.com>
In-Reply-To: <20210318172039.278896-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4509126394623233180==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If IWD is connecting to a SAE/WPA3 BSS and Auth/Assoc commands
are not supported the only option is SAE offload. At this point
network_connect should have verified that the extended feature
for SAE offload exists so we can simply enable offload if these
commands are not supported.
---
 src/station.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/station.c b/src/station.c
index 2e577290..5d118a3c 100644
--- a/src/station.c
+++ b/src/station.c
@@ -979,6 +979,10 @@ static struct handshake_state *station_handshake_setup=
(struct station *station,
 				goto no_psk;
 =

 			handshake_state_set_passphrase(hs, passphrase);
+
+			/* SAE offload required */
+			if (!wiphy_supports_cmds_auth_assoc(wiphy))
+				hs->offload =3D true;
 		} else {
 			const uint8_t *psk =3D network_get_psk(network);
 =

-- =

2.26.2

--===============4509126394623233180==--

