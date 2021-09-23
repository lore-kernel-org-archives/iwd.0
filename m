Content-Type: multipart/mixed; boundary="===============6110821626877773747=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 4/5] station: check if connected before allowing Roam()
Date: Thu, 23 Sep 2021 15:57:27 -0700
Message-ID: <20210923225728.556306-4-prestwoj@gmail.com>
In-Reply-To: 20210923225728.556306-1-prestwoj@gmail.com

--===============6110821626877773747==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/station.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/station.c b/src/station.c
index 98fc3cf2..3f860398 100644
--- a/src/station.c
+++ b/src/station.c
@@ -4082,6 +4082,9 @@ static struct l_dbus_message *station_force_roam(stru=
ct l_dbus *dbus,
 	if (mac_len !=3D 6)
 		return dbus_error_invalid_args(message);
 =

+	if (!station->connected_network)
+		return dbus_error_not_connected(message);
+
 	target =3D network_bss_find_by_addr(station->connected_network, mac);
 	if (!target || target =3D=3D station->connected_bss)
 		return dbus_error_invalid_args(message);
-- =

2.31.1

--===============6110821626877773747==--

