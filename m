Content-Type: multipart/mixed; boundary="===============5495064246519348208=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/2] station: Fix autoconnect loops
Date: Mon, 10 May 2021 12:12:03 +0200
Message-ID: <20210510101204.175551-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5495064246519348208==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make sure we process the result of a connect attempt both in a D-Bus
triggered connection and during autoconnect.  Until now we'd only call
station_connect_cb() on NETDEV_EVENT_DISCONNECT_BY_{AP,SME} if
station->connect_pending was non-NULL, i.e. only in the D-Bus method.
As a result we were never blacklisting BSSes and never calling
network_connect_failed() (to set ask_passphrase) during autoconnect.

Use station->netdev_connected to keep track of whether the event
actually happens in the handshake (as opposed to netconfig for example)
to avoid calling network_connect_failed() with the "in_handshake"
parameter set to true.  Arguably we might want to call
netdev_connect_failed() or at least temporarily blacklist/downrank
the bss if the connection breaks during netconfig but I kept the
current logic in this commit.

We might also want to call station_reassociate_cb() if we're in a
reassociation but this wouldn't currently make much difference (and we
don't seem to have any flag to know that we're in a reassociation right
now.)
---
 src/station.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index 479f81f5..e503f636 100644
--- a/src/station.c
+++ b/src/station.c
@@ -113,6 +113,7 @@ struct station {
 	bool ap_directed_roaming : 1;
 	bool scanning : 1;
 	bool autoconnect : 1;
+	bool netdev_connected : 1;
 };
 =

 struct anqp_entry {
@@ -1339,6 +1340,7 @@ static void station_reset_connection_state(struct sta=
tion *station)
 	l_queue_insert(station->networks_sorted, station->connected_network,
 				network_rank_compare, NULL);
 =

+	station->netdev_connected =3D false;
 	station->connected_bss =3D NULL;
 	station->connected_network =3D NULL;
 =

@@ -1370,7 +1372,9 @@ static void station_disconnect_event(struct station *=
station, void *event_data)
 {
 	l_debug("%u", netdev_get_ifindex(station->netdev));
 =

-	if (station->connect_pending)
+	if (station->connect_pending ||
+			(station->state =3D=3D STATION_STATE_CONNECTING &&
+			 !station->netdev_connected))
 		station_connect_cb(station->netdev,
 					NETDEV_RESULT_HANDSHAKE_FAILED,
 					event_data, station);
@@ -2554,6 +2558,7 @@ static void station_connect_cb(struct netdev *netdev,=
 enum netdev_result result,
 			l_warn("Could not request neighbor report");
 	}
 =

+	station->netdev_connected =3D true;
 	network_connected(station->connected_network);
 =

 	if (station->netconfig)
-- =

2.27.0

--===============5495064246519348208==--

