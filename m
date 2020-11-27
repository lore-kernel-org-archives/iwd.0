Content-Type: multipart/mixed; boundary="===============1513099143767466338=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: [PATCH] network: clear info of removed known network before disconnect
Date: Fri, 27 Nov 2020 16:04:58 +0000
Message-ID: <20201127160444.681629-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1513099143767466338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make sure to erase the network_info of a known network that has been
removed before disconnecting any stations connected to it. This fixes
the following warning observed when forgetting a connected network:

  WARNING: ../git/src/network.c:network_rank_update() condition n < 0 failed

This also fixes a bug where such a forgotten network would incorrectly
appear as the first element in the response to GetOrderedNetworks().  By
clearing the network_info, network_rank_update() properly negates the
rank of the now-unknown network.
---
 src/network.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/src/network.c b/src/network.c
index 388bc17a..0d2506e7 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1444,22 +1444,26 @@ static void network_unset_hotspot(struct network *n=
etwork, void *user_data)
 	network_set_info(network, NULL);
 }
 =

-static void emit_known_network_changed(struct station *station, void *user=
_data)
+static void emit_known_network_removed(struct station *station, void *user=
_data)
 {
 	struct network_info *info =3D user_data;
+	struct network *connected_network;
 	struct network *network;
 =

-	if (!info->is_hotspot) {
+	/* Clear network info, as this network is no longer known */
+	if (info->is_hotspot)
+		station_network_foreach(station, network_unset_hotspot, info);
+	else {
 		network =3D station_network_find(station, info->ssid, info->type);
 		if (!network)
 			return;
 =

 		network_set_info(network, NULL);
-		return;
 	}
 =

-	/* This is a removed hotspot */
-	station_network_foreach(station, network_unset_hotspot, info);
+	connected_network =3D station_get_connected_network(station);
+	if (connected_network && connected_network->info =3D=3D NULL)
+		station_disconnect(station);
 }
 =

 static void network_update_hotspot(struct network *network, void *user_dat=
a)
@@ -1487,17 +1491,6 @@ static void match_known_network(struct station *stat=
ion, void *user_data)
 	station_network_foreach(station, network_update_hotspot, info);
 }
 =

-static void disconnect_no_longer_known(struct station *station, void *user=
_data)
-{
-	struct network_info *info =3D user_data;
-	struct network *network;
-
-	network =3D station_get_connected_network(station);
-
-	if (network && network->info =3D=3D info)
-		station_disconnect(station);
-}
-
 static void known_networks_changed(enum known_networks_event event,
 					const struct network_info *info,
 					void *user_data)
@@ -1510,8 +1503,7 @@ static void known_networks_changed(enum known_network=
s_event event,
 		known_network_frequency_sync((struct network_info *)info);
 		break;
 	case KNOWN_NETWORKS_EVENT_REMOVED:
-		station_foreach(disconnect_no_longer_known, (void *) info);
-		station_foreach(emit_known_network_changed, (void *) info);
+		station_foreach(emit_known_network_removed, (void *) info);
 		break;
 	}
 }
-- =

2.29.0
--===============1513099143767466338==--

