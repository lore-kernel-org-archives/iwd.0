Content-Type: multipart/mixed; boundary="===============1526579961820062096=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: [PATCH 2/3] station: add RoamRetryInterval setting
Date: Fri, 22 Jan 2021 13:37:01 +0000
Message-ID: <20210122133659.577139-2-alsi@bang-olufsen.dk>
In-Reply-To: <20210122133659.577139-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1526579961820062096==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/station.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index 2e886a73..558ecf9a 100644
--- a/src/station.c
+++ b/src/station.c
@@ -29,6 +29,7 @@
 #include <errno.h>
 #include <time.h>
 #include <sys/time.h>
+#include <limits.h>
 #include <linux/if_ether.h>
 =

 #include <ell/ell.h>
@@ -57,6 +58,7 @@
 static struct l_queue *station_list;
 static uint32_t netdev_watch;
 static uint32_t mfp_setting;
+static uint32_t roam_retry_interval;
 static bool anqp_disabled;
 static bool netconfig_enabled;
 static struct watchlist anqp_watches;
@@ -1369,7 +1371,7 @@ static void station_roamed(struct station *station)
 	 * remain low. A subsequent high signal notification will cancel it.
 	 */
 	if (station->signal_low)
-		station_roam_timeout_rearm(station, 60);
+		station_roam_timeout_rearm(station, roam_retry_interval);
 =

 	if (station->netconfig)
 		netconfig_reconfigure(station->netconfig);
@@ -1416,7 +1418,7 @@ delayed_retry:
 	station->ap_directed_roaming =3D false;
 =

 	if (station->signal_low)
-		station_roam_timeout_rearm(station, 60);
+		station_roam_timeout_rearm(station, roam_retry_interval);
 }
 =

 static void station_netconfig_event_handler(enum netconfig_event event,
@@ -3646,6 +3648,14 @@ static int station_init(void)
 		mfp_setting =3D 1;
 	}
 =

+	if (!l_settings_get_uint(iwd_get_config(), "General",
+				"RoamRetryInterval",
+				&roam_retry_interval))
+		roam_retry_interval =3D 60;
+
+	if (roam_retry_interval > INT_MAX)
+		roam_retry_interval =3D INT_MAX;
+
 	if (!l_settings_get_bool(iwd_get_config(), "General", "DisableANQP",
 				&anqp_disabled))
 		anqp_disabled =3D true;
-- =

2.29.2
--===============1526579961820062096==--

