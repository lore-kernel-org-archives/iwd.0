Content-Type: multipart/mixed; boundary="===============2097877344336128680=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] station: Fix autoconnect loops
Date: Mon, 10 May 2021 11:00:12 +0200
Message-ID: <20210510090012.174294-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2097877344336128680==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make sure we process the result of a connect attempt both in a D-Bus
triggered connection and during autoconnect.  Until now we'd only call
station_connect_cb() on NETDEV_EVENT_DISCONNECT_BY_{AP,SME} if
station->connect_pending was non-NULL, i.e. only in the D-Bus method.
As a result we were never blacklisting BSSes and never calling
network_connect_failed() (to set ask_passphrase) during autoconnect.
---
 src/station.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index 479f81f5..aba16c83 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1370,7 +1370,8 @@ static void station_disconnect_event(struct station *=
station, void *event_data)
 {
 	l_debug("%u", netdev_get_ifindex(station->netdev));
 =

-	if (station->connect_pending)
+	if (station->connect_pending ||
+			station->state =3D=3D STATION_STATE_CONNECTING)
 		station_connect_cb(station->netdev,
 					NETDEV_RESULT_HANDSHAKE_FAILED,
 					event_data, station);
-- =

2.27.0

--===============2097877344336128680==--

