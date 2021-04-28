Content-Type: multipart/mixed; boundary="===============3592195498178400614=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 2/2] station: remove diagnostic interface on station_free
Date: Wed, 28 Apr 2021 12:40:12 -0700
Message-ID: <20210428194012.149913-2-prestwoj@gmail.com>
In-Reply-To: <20210428194012.149913-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3592195498178400614==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If station gets removed ungracefully (e.g. rfkill/hotplug) it
may not have a chance to disconnect, meaning the diagnostic
interface would remain up.
---
 src/station.c | 4 ++++
 1 file changed, 4 insertions(+)

v5:
 * called remove_interface directly as this is all we needed with
   the state transition anyways.

diff --git a/src/station.c b/src/station.c
index 0cee3525..a3a49fc9 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3487,6 +3487,10 @@ static void station_free(struct station *station)
 	if (station->connected_bss)
 		netdev_disconnect(station->netdev, NULL, NULL);
 =

+	l_dbus_object_remove_interface(dbus_get_bus(),
+					netdev_get_path(station->netdev),
+					IWD_STATION_DIAGNOSTIC_INTERFACE);
+
 	if (station->netconfig) {
 		netconfig_destroy(station->netconfig);
 		station->netconfig =3D NULL;
-- =

2.26.2

--===============3592195498178400614==--

