Content-Type: multipart/mixed; boundary="===============3554087336901707662=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/4] station: set evict_nocarrier sysfs option during roaming
Date: Wed, 03 Nov 2021 15:15:01 -0700
Message-ID: <20211103221502.470442-3-prestwoj@gmail.com>
In-Reply-To: 20211103221502.470442-1-prestwoj@gmail.com

--===============3554087336901707662==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the kernel supports evict_nocarrier set this during the roam
to prevent packet delays post roam.
---
 src/station.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/src/station.c b/src/station.c
index 84f9d0c2..4bb8e60f 100644
--- a/src/station.c
+++ b/src/station.c
@@ -57,12 +57,15 @@
 #include "src/anqputil.h"
 #include "src/diagnostic.h"
 #include "src/frame-xchg.h"
+#include "src/sysfs.h"
 =

 static struct l_queue *station_list;
 static uint32_t netdev_watch;
 static uint32_t mfp_setting;
 static uint32_t roam_retry_interval;
 static bool anqp_disabled;
+static bool supports_arp_evict_nocarrier;
+static bool supports_ndisc_evict_nocarrier;
 static struct watchlist event_watches;
 =

 struct station {
@@ -1384,6 +1387,19 @@ static const char *station_state_to_string(enum stat=
ion_state state)
 	return "invalid";
 }
 =

+static void station_set_evict_nocarrier(struct station *station, bool valu=
e)
+{
+	char *v =3D value ? "1" : "0";
+
+	if (supports_arp_evict_nocarrier)
+		sysfs_write_ipv4_setting(netdev_get_name(station->netdev),
+					"arp_evict_nocarrier", v);
+
+	if (supports_ndisc_evict_nocarrier)
+		sysfs_write_ipv6_setting(netdev_get_name(station->netdev),
+					"ndisc_evict_nocarrier", v);
+}
+
 static void station_enter_state(struct station *station,
 						enum station_state state)
 {
@@ -1429,9 +1445,6 @@ static void station_enter_state(struct station *stati=
on,
 				network_get_path(station->connected_network),
 				IWD_NETWORK_INTERFACE, "Connected");
 =

-		periodic_scan_stop(station);
-		break;
-	case STATION_STATE_DISCONNECTED:
 		periodic_scan_stop(station);
 		break;
 	case STATION_STATE_CONNECTED:
@@ -1439,11 +1452,16 @@ static void station_enter_state(struct station *sta=
tion,
 					netdev_get_path(station->netdev),
 					IWD_STATION_DIAGNOSTIC_INTERFACE,
 					station);
+		/* Fall through */
+	case STATION_STATE_DISCONNECTED:
 		periodic_scan_stop(station);
+
+		station_set_evict_nocarrier(station, true);
 		break;
 	case STATION_STATE_DISCONNECTING:
 		break;
 	case STATION_STATE_ROAMING:
+		station_set_evict_nocarrier(station, false);
 		break;
 	}
 =

@@ -4457,6 +4475,11 @@ static int station_init(void)
 	if (!netconfig_enabled())
 		l_info("station: Network configuration is disabled.");
 =

+	supports_arp_evict_nocarrier =3D sysfs_supports_ipv4_setting("all",
+						"arp_evict_nocarrier");
+	supports_ndisc_evict_nocarrier =3D sysfs_supports_ipv6_setting("all",
+						"ndisc_evict_nocarrier");
+
 	watchlist_init(&event_watches, NULL);
 =

 	return 0;
-- =

2.31.1

--===============3554087336901707662==--

