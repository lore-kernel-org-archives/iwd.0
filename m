Content-Type: multipart/mixed; boundary="===============0340251438977568900=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 4/5] station: Subscribe to netconfig event notifier
Date: Tue, 08 Oct 2019 14:48:23 -0700
Message-ID: <20191008214824.19466-4-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191008214824.19466-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0340251438977568900==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/station.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index 9997352e..46f2a02e 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1309,6 +1309,22 @@ static void station_roam_failed(struct station *stat=
ion)
 		station_roam_timeout_rearm(station, 60);
 }
 =

+static void station_netconfig_event_handler(enum netconfig_event event,
+							void *user_data)
+{
+	struct station *station =3D user_data;
+
+	switch (event) {
+	case NETCONFIG_EVENT_CONNECTED:
+		station_enter_state(station, STATION_STATE_CONNECTED);
+
+		break;
+	default:
+		l_error("station: Unsupported netconfig event: %d.", event);
+		break;
+	}
+}
+
 static void station_connected(struct station *station)
 {
 	periodic_scan_stop(station);
@@ -1328,7 +1344,9 @@ static void station_connected(struct station *station)
 	netconfig_configure(station->netconfig,
 				network_get_settings(
 						station->connected_network),
-				netdev_get_address(station->netdev));
+				netdev_get_address(station->netdev),
+				station_netconfig_event_handler,
+				station);
 }
 =

 static void station_reassociate_cb(struct netdev *netdev,
-- =

2.13.6

--===============0340251438977568900==--

