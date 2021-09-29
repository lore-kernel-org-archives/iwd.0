Content-Type: multipart/mixed; boundary="===============9026830194968492065=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH] station: Move netconfig_reset() to common path
Date: Wed, 29 Sep 2021 18:42:54 +0200
Message-ID: <20210929164254.118503-1-andrew.zaborowski@intel.com>

--===============9026830194968492065==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Move the netconfig_reset calls to inside
station_reset_connection_state() instead of having each caller do
netconfig_reset() followed by station_reset_connection_state().  One of
the callers was missing the netconfig_reset() and this was resulting in
the "netconfig: Failed to start DHCPv4 client for interface %u" warning.
---
 src/station.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/src/station.c b/src/station.c
index 934815f2..61649c74 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1501,6 +1501,9 @@ static void station_reset_connection_state(struct sta=
tion *station)
 	if (!network)
 		return;
 =

+	if (station->netconfig)
+		netconfig_reset(station->netconfig);
+
 	if (station->state =3D=3D STATION_STATE_CONNECTED ||
 			station->state =3D=3D STATION_STATE_CONNECTING ||
 			station->state =3D=3D STATION_STATE_CONNECTING_AUTO ||
@@ -1530,9 +1533,6 @@ static void station_disassociated(struct station *sta=
tion)
 {
 	l_debug("%u", netdev_get_ifindex(station->netdev));
 =

-	if (station->netconfig)
-		netconfig_reset(station->netconfig);
-
 	station_reset_connection_state(station);
 =

 	station_enter_state(station, STATION_STATE_DISCONNECTED);
@@ -2930,9 +2930,6 @@ static void station_disconnect_onconnect(struct stati=
on *station,
 		return;
 	}
 =

-	if (station->netconfig)
-		netconfig_reset(station->netconfig);
-
 	station_reset_connection_state(station);
 =

 	station_enter_state(station, STATION_STATE_DISCONNECTING);
@@ -3234,9 +3231,6 @@ int station_disconnect(struct station *station)
 	if (!station->connected_bss)
 		return -ENOTCONN;
 =

-	if (station->netconfig)
-		netconfig_reset(station->netconfig);
-
 	/*
 	 * If the disconnect somehow fails we won't know if we're still
 	 * connected so we may as well indicate now that we're no longer
-- =

2.30.2

--===============9026830194968492065==--

