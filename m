Content-Type: multipart/mixed; boundary="===============7085215391749652326=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] station/wsc: remove beacon loss handling
Date: Tue, 03 Nov 2020 12:51:27 -0800
Message-ID: <20201103205129.2744888-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7085215391749652326==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Modern kernels ~5.4+ have changed the way lost beacons are
reported and effectively make the lost beacon event useless
because it is immediately followed by a disconnect event. This
does now allow IWD enough time to do much of anything before
the disconnect comes in and we are forced to fully re-connect
to a different AP.
---
 src/station.c | 26 --------------------------
 src/wsc.c     |  3 ---
 2 files changed, 29 deletions(-)

diff --git a/src/station.c b/src/station.c
index eb254bf6..db36b748 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2085,29 +2085,6 @@ static bool station_cannot_roam(struct station *stat=
ion)
 					station->state =3D=3D STATION_STATE_ROAMING;
 }
 =

-static void station_lost_beacon(struct station *station)
-{
-	l_debug("%u", netdev_get_ifindex(station->netdev));
-
-	if (station->state !=3D STATION_STATE_ROAMING &&
-			station->state !=3D STATION_STATE_CONNECTED)
-		return;
-
-	/*
-	 * Tell the roam mechanism to not bother requesting Neighbor Reports,
-	 * preauthenticating or performing other over-the-DS type of
-	 * authentication to target AP, even while station->connected_bss is
-	 * still non-NULL.  The current connection is in a serious condition
-	 * and we might wasting our time with those mechanisms.
-	 */
-	station->roam_no_orig_ap =3D true;
-
-	if (station_cannot_roam(station))
-		return;
-
-	station_roam_trigger_cb(NULL, station);
-}
-
 #define WNM_REQUEST_MODE_PREFERRED_CANDIDATE_LIST	(1 << 0)
 #define WNM_REQUEST_MODE_TERMINATION_IMMINENT		(1 << 3)
 #define WNM_REQUEST_MODE_ESS_DISASSOCIATION_IMMINENT	(1 << 4)
@@ -2235,9 +2212,6 @@ static void station_netdev_event(struct netdev *netde=
v, enum netdev_event event,
 	case NETDEV_EVENT_ASSOCIATING:
 		l_debug("Associating");
 		break;
-	case NETDEV_EVENT_LOST_BEACON:
-		station_lost_beacon(station);
-		break;
 	case NETDEV_EVENT_DISCONNECT_BY_AP:
 	case NETDEV_EVENT_DISCONNECT_BY_SME:
 		station_disconnect_event(station, event_data);
diff --git a/src/wsc.c b/src/wsc.c
index 66ddb8bf..aec9900c 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -247,9 +247,6 @@ static void wsc_enrollee_netdev_event(struct netdev *ne=
tdev,
 	case NETDEV_EVENT_AUTHENTICATING:
 	case NETDEV_EVENT_ASSOCIATING:
 		break;
-	case NETDEV_EVENT_LOST_BEACON:
-		l_debug("Lost beacon");
-		break;
 	case NETDEV_EVENT_DISCONNECT_BY_AP:
 		l_debug("Disconnect by AP");
 		wsc_enrollee_connect_cb(wsce->netdev,
-- =

2.26.2

--===============7085215391749652326==--

