Content-Type: multipart/mixed; boundary="===============8284158939676369055=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v2 3/3] station: Subscribe to netconfig event notifier
Date: Wed, 09 Oct 2019 14:53:33 -0700
Message-ID: <20191009215333.14547-3-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191009215333.14547-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8284158939676369055==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/station.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index af209ebb..9b31cd20 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1314,6 +1314,22 @@ static void station_roam_failed(struct station *stat=
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
 static void station_reassociate_cb(struct netdev *netdev,
 					enum netdev_result result,
 					void *event_data,
@@ -2271,7 +2287,9 @@ static void station_connect_cb(struct netdev *netdev,=
 enum netdev_result result,
 		netconfig_configure(station->netconfig,
 					network_get_settings(
 						station->connected_network),
-					netdev_get_address(station->netdev));
+					netdev_get_address(station->netdev),
+					station_netconfig_event_handler,
+					station);
 	else
 		station_enter_state(station, STATION_STATE_CONNECTED);
 }
-- =

2.13.6

--===============8284158939676369055==--

