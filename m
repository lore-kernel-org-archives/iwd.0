Content-Type: multipart/mixed; boundary="===============9123146479205428434=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/2] station: move scan cancelation to
 __station_connect_network
Date: Thu, 04 Feb 2021 16:06:02 -0800
Message-ID: <20210205000603.241826-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9123146479205428434==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

An earlier patch fixed a problem where a queued quick scan would
be triggered and fail once already connected, resulting in a state
transition from connected --> autoconnect_full. This fixed the
Connect() path but this could also happen via autoconnect. Starting
from a connected state, the sequence goes:

 - DBus scan is triggered
 - AP disconnects IWD
 - State transition from disconnected --> autoconnect_quick
 - Queue quick scan
 - DBus scan results come in and used to autoconnect
 - A connect work item is inserted ahead of all others, transition
   from autoconnect_quick --> connecting.
 - Connect completes, transition from connecting --> connected
 - Quick scan can finally get triggered, which the kernel fails to
   do since IWD is connected, transition from connected -->
   autoconnect_full.

This can be fixed by checking for a pending quick scan in the
autoconnect path.
---
 src/station.c | 7 +++++++
 1 file changed, 7 insertions(+)

v3:
 * Moved check into the autoconnect path rather than
   __station_connect_network

diff --git a/src/station.c b/src/station.c
index 8288916f..2a7025ef 100644
--- a/src/station.c
+++ b/src/station.c
@@ -196,6 +196,13 @@ static void station_autoconnect_next(struct station *s=
tation)
 =

 		if (!r) {
 			station_enter_state(station, STATION_STATE_CONNECTING);
+
+			if (station->quick_scan_id) {
+				scan_cancel(netdev_get_wdev_id(station->netdev),
+						station->quick_scan_id);
+				station->quick_scan_id =3D 0;
+			}
+
 			return;
 		}
 	}
-- =

2.26.2

--===============9123146479205428434==--

