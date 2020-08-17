Content-Type: multipart/mixed; boundary="===============1397576841724700563=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 01/10] station: Don't call network_rank_update with NULL
 network
Date: Mon, 17 Aug 2020 12:06:38 +0200
Message-ID: <20200817100647.338184-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1397576841724700563==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Move the update of station->networks_sorted order to before we set
station->connected_network NULL to avoid a crash when we attempt to
use the NULL pointer.
---
 src/station.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/station.c b/src/station.c
index e44dc145..e53952a7 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1298,15 +1298,15 @@ static void station_reset_connection_state(struct s=
tation *station)
 =

 	station_roam_state_clear(station);
 =

-	station->connected_bss =3D NULL;
-	station->connected_network =3D NULL;
-
 	/* Refresh the ordered network list */
 	network_rank_update(station->connected_network, false);
 	l_queue_remove(station->networks_sorted, station->connected_network);
 	l_queue_insert(station->networks_sorted, station->connected_network,
 				network_rank_compare, NULL);
 =

+	station->connected_bss =3D NULL;
+	station->connected_network =3D NULL;
+
 	l_dbus_property_changed(dbus, netdev_get_path(station->netdev),
 				IWD_STATION_INTERFACE, "ConnectedNetwork");
 	l_dbus_property_changed(dbus, network_get_path(network),
-- =

2.25.1

--===============1397576841724700563==--

