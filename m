Content-Type: multipart/mixed; boundary="===============8793297455112389620=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] station: set handshake offload if supported
Date: Wed, 03 Mar 2021 09:47:29 -0800
Message-ID: <20210303174730.6738-3-prestwoj@gmail.com>
In-Reply-To: <20210303174730.6738-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8793297455112389620==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When setting up the handshake check if wiphy supports handshake
offload for PSK networks (not including SAE, for now).
---
 src/station.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/station.c b/src/station.c
index 6496be10..93701e7f 100644
--- a/src/station.c
+++ b/src/station.c
@@ -986,6 +986,8 @@ static struct handshake_state *station_handshake_setup(=
struct station *station,
 				goto no_psk;
 =

 			handshake_state_set_pmk(hs, psk, 32);
+
+			hs->offload_psk =3D wiphy_can_offload(wiphy, bss);
 		}
 	} else if (security =3D=3D SECURITY_8021X)
 		handshake_state_set_8021x_config(hs,
-- =

2.26.2

--===============8793297455112389620==--

