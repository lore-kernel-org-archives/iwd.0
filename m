Content-Type: multipart/mixed; boundary="===============3528306729720701017=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] station: print which BSS is being connected to
Date: Mon, 14 Sep 2020 14:02:30 -0700
Message-ID: <20200914210233.428835-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3528306729720701017==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For multi-bss networks its nice to know which BSS is being connected
to. The ranking can hint at it, but blacklisting or network capabilities
could effect which network is actually chosen. An explicit debug print
makes debugging much easier.
---
 src/station.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/station.c b/src/station.c
index a8d8ad08..7fb4ae77 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2423,6 +2423,8 @@ int __station_connect_network(struct station *station=
, struct network *network,
 		return r;
 	}
 =

+	l_debug("connecting to BSS "MAC, MAC_STR(bss->addr));
+
 	station->connected_bss =3D bss;
 	station->connected_network =3D network;
 =

-- =

2.26.2

--===============3528306729720701017==--

