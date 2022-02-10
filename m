Content-Type: multipart/mixed; boundary="===============0716405367424049084=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] station: fix >80 character lines
Date: Thu, 10 Feb 2022 13:06:50 -0800
Message-ID: <20220210210650.866456-1-prestwoj@gmail.com>

--===============0716405367424049084==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/station.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index 6dc0074c..cd119ff1 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1472,8 +1472,10 @@ static void station_enter_state(struct station *stat=
ion,
 	case STATION_STATE_CONNECTING_AUTO:
 		/* Refresh the ordered network list */
 		network_rank_update(station->connected_network, true);
-		l_queue_remove(station->networks_sorted, station->connected_network);
-		l_queue_insert(station->networks_sorted, station->connected_network,
+		l_queue_remove(station->networks_sorted,
+					station->connected_network);
+		l_queue_insert(station->networks_sorted,
+					station->connected_network,
 					network_rank_compare, NULL);
 =

 		l_dbus_property_changed(dbus, netdev_get_path(station->netdev),
-- =

2.34.1

--===============0716405367424049084==--

