Content-Type: multipart/mixed; boundary="===============1963289225204279225=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/4] netconfig: Move EnableNetworkConfiguration check to
 station
Date: Thu, 30 Apr 2020 15:48:42 +0200
Message-ID: <20200430134847.62234-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1963289225204279225==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Allow p2p to use netconfig even if not enabled for Infrastructure mode
connections.
---
 src/netconfig.c | 17 -----------------
 src/station.c   | 19 ++++++++++++++++++-
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 1e6af3d2..6a618e8f 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -1193,28 +1193,11 @@ void netconfig_destroy(struct netconfig *netconfig)
 =

 static int netconfig_init(void)
 {
-	bool enabled;
 	uint32_t r;
 =

 	if (netconfig_list)
 		return -EALREADY;
 =

-	if (!l_settings_get_bool(iwd_get_config(), "General",
-					"EnableNetworkConfiguration",
-					&enabled)) {
-		if (l_settings_get_bool(iwd_get_config(), "General",
-					"enable_network_config", &enabled))
-			l_warn("[General].enable_network_config is deprecated,"
-				" use [General].EnableNetworkConfiguration");
-		else
-			enabled =3D false;
-	}
-
-	if (!enabled) {
-		l_info("netconfig: Network configuration is disabled.");
-		return 0;
-	}
-
 	rtnl =3D iwd_get_rtnl();
 =

 	r =3D l_netlink_register(rtnl, RTNLGRP_IPV4_IFADDR,
diff --git a/src/station.c b/src/station.c
index 3b3bb30a..c532319a 100644
--- a/src/station.c
+++ b/src/station.c
@@ -58,6 +58,7 @@ static struct l_queue *station_list;
 static uint32_t netdev_watch;
 static uint32_t mfp_setting;
 static bool anqp_disabled;
+static bool netconfig_enabled;
 =

 struct station {
 	enum station_state state;
@@ -3098,7 +3099,8 @@ static struct station *station_create(struct netdev *=
netdev)
 	l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
 					IWD_STATION_INTERFACE, station);
 =

-	station->netconfig =3D netconfig_new(netdev_get_ifindex(netdev));
+	if (netconfig_enabled)
+		station->netconfig =3D netconfig_new(netdev_get_ifindex(netdev));
 =

 	station->anqp_pending =3D l_queue_new();
 =

@@ -3250,6 +3252,21 @@ static int station_init(void)
 				&anqp_disabled))
 		anqp_disabled =3D true;
 =

+	if (!l_settings_get_bool(iwd_get_config(), "General",
+					"EnableNetworkConfiguration",
+					&netconfig_enabled)) {
+		if (l_settings_get_bool(iwd_get_config(), "General",
+					"enable_network_config",
+					&netconfig_enabled))
+			l_warn("[General].enable_network_config is deprecated,"
+				" use [General].EnableNetworkConfiguration");
+		else
+			netconfig_enabled =3D false;
+	}
+
+	if (!netconfig_enabled)
+		l_info("station: Network configuration is disabled.");
+
 	return 0;
 }
 =

-- =

2.25.1

--===============1963289225204279225==--

