Content-Type: multipart/mixed; boundary="===============1060516495317989668=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH 01/12] treewide: Parse EnableNetworkConfiguration in one place
Date: Thu, 21 Oct 2021 10:50:30 +0200
Message-ID: <20211021085041.294524-1-andrew.zaborowski@intel.com>

--===============1060516495317989668==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add netconfig_get_enabled() and use that in all places that want to know
whether network configuration is enabled.  Drop the enable_network_config
deprecated setting, which was only being handled in one of these 5 or so
places.
---
 src/ap.c        | 11 +++--------
 src/ip-pool.c   | 11 ++---------
 src/main.c      |  8 ++------
 src/netconfig.c |  9 +++++++++
 src/netconfig.h |  2 ++
 src/resolve.c   | 12 ++----------
 src/station.c   | 10 ++--------
 7 files changed, 22 insertions(+), 41 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 45e647b8..4b26e9ff 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -53,6 +53,7 @@
 #include "src/wscutil.h"
 #include "src/eap-wsc.h"
 #include "src/ip-pool.h"
+#include "src/netconfig.h"
 #include "src/ap.h"
 #include "src/storage.h"
 #include "src/diagnostic.h"
@@ -132,7 +133,6 @@ struct ap_wsc_pbc_probe_record {
 	uint64_t timestamp;
 };
 =

-static bool netconfig_enabled;
 static char **global_addr4_strs;
 static uint32_t netdev_watch;
 static struct l_netlink *rtnl;
@@ -2826,7 +2826,7 @@ static int ap_load_ipv4(struct ap_state *ap, const st=
ruct l_settings *config)
 	unsigned int lease_time =3D 0;
 	struct in_addr ia;
 =

-	if (!l_settings_has_group(config, "IPv4") || !netconfig_enabled)
+	if (!l_settings_has_group(config, "IPv4") || !netconfig_get_enabled())
 		return 0;
 =

 	if (l_settings_has_key(config, "IPv4", "Address")) {
@@ -3829,12 +3829,7 @@ static int ap_init(void)
 	 * Enable network configuration and DHCP only if
 	 * [General].EnableNetworkConfiguration is true.
 	 */
-	if (!l_settings_get_bool(settings, "General",
-					"EnableNetworkConfiguration",
-					&netconfig_enabled))
-		netconfig_enabled =3D false;
-
-	if (netconfig_enabled) {
+	if (netconfig_get_enabled()) {
 		if (l_settings_get_value(settings, "IPv4", "APAddressPool")) {
 			global_addr4_strs =3D l_settings_get_string_list(settings,
 								"IPv4",
diff --git a/src/ip-pool.c b/src/ip-pool.c
index 82f5216e..0c84394c 100644
--- a/src/ip-pool.c
+++ b/src/ip-pool.c
@@ -34,6 +34,7 @@
 #include "src/iwd.h"
 #include "src/module.h"
 #include "src/netdev.h"
+#include "src/netconfig.h"
 #include "src/ip-pool.h"
 =

 struct ip_pool_addr4_record {
@@ -357,15 +358,7 @@ static void ip_pool_addr4_dump_cb(int error,
 =

 static int ip_pool_init(void)
 {
-	const struct l_settings *settings =3D iwd_get_config();
-	bool netconfig_enabled;
-
-	if (!l_settings_get_bool(settings, "General",
-				"EnableNetworkConfiguration",
-				&netconfig_enabled))
-		netconfig_enabled =3D false;
-
-	if (!netconfig_enabled)
+	if (!netconfig_get_enabled())
 		return 0;
 =

 	rtnl =3D iwd_get_rtnl();
diff --git a/src/main.c b/src/main.c
index b67c74d9..f5095ecc 100644
--- a/src/main.c
+++ b/src/main.c
@@ -42,6 +42,7 @@
 #include "src/rfkill.h"
 #include "src/storage.h"
 #include "src/anqp.h"
+#include "src/netconfig.h"
 =

 #include "src/backtrace.h"
 =

@@ -217,12 +218,7 @@ static struct l_dbus_message *iwd_dbus_get_info(struct=
 l_dbus *dbus,
 	struct l_dbus_message *reply;
 	struct l_dbus_message_builder *builder;
 	L_AUTO_FREE_VAR(char *, storage_dir) =3D storage_get_path(NULL);
-	bool netconfig_enabled;
-
-	if (!l_settings_get_bool(iwd_config, "General",
-					"EnableNetworkConfiguration",
-					&netconfig_enabled))
-		netconfig_enabled =3D false;
+	bool netconfig_enabled =3D netconfig_get_enabled();
 =

 	reply =3D l_dbus_message_new_method_return(message);
 	builder =3D l_dbus_message_builder_new(reply);
diff --git a/src/netconfig.c b/src/netconfig.c
index 2ffc5ab1..833fd3ab 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -1581,6 +1581,15 @@ void netconfig_destroy(struct netconfig *netconfig)
 	netconfig_free(netconfig);
 }
 =

+bool netconfig_get_enabled(void)
+{
+	bool enabled;
+
+	return l_settings_get_bool(iwd_get_config(), "General",
+					"EnableNetworkConfiguration",
+					&enabled) && enabled;
+}
+
 static int netconfig_init(void)
 {
 	uint32_t r;
diff --git a/src/netconfig.h b/src/netconfig.h
index 3c4e7641..9d5887e9 100644
--- a/src/netconfig.h
+++ b/src/netconfig.h
@@ -46,3 +46,5 @@ void netconfig_handle_fils_ip_resp(struct netconfig *netc=
onfig,
 =

 struct netconfig *netconfig_new(uint32_t ifindex);
 void netconfig_destroy(struct netconfig *netconfig);
+
+bool netconfig_get_enabled(void);
diff --git a/src/resolve.c b/src/resolve.c
index 9b724392..59b29ec2 100644
--- a/src/resolve.c
+++ b/src/resolve.c
@@ -35,6 +35,7 @@
 #include "src/iwd.h"
 #include "src/module.h"
 #include "src/dbus.h"
+#include "src/netconfig.h"
 #include "src/resolve.h"
 =

 struct resolve_ops {
@@ -579,18 +580,9 @@ static const struct {
 static int resolve_init(void)
 {
 	const char *method_name;
-	bool enabled;
 	uint8_t i;
 =

-	if (!l_settings_get_bool(iwd_get_config(), "General",
-					"EnableNetworkConfiguration",
-					&enabled)) {
-		if (!l_settings_get_bool(iwd_get_config(), "General",
-					"enable_network_config", &enabled))
-			enabled =3D false;
-	}
-
-	if (!enabled)
+	if (!netconfig_get_enabled())
 		return 0;
 =

 	method_name =3D l_settings_get_value(iwd_get_config(), "Network",
diff --git a/src/station.c b/src/station.c
index c73db634..d3767203 100644
--- a/src/station.c
+++ b/src/station.c
@@ -63,7 +63,6 @@ static uint32_t netdev_watch;
 static uint32_t mfp_setting;
 static uint32_t roam_retry_interval;
 static bool anqp_disabled;
-static bool netconfig_enabled;
 static struct watchlist event_watches;
 =

 struct station {
@@ -3859,7 +3858,7 @@ static struct station *station_create(struct netdev *=
netdev)
 	l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
 					IWD_STATION_INTERFACE, station);
 =

-	if (netconfig_enabled)
+	if (netconfig_get_enabled())
 		station->netconfig =3D netconfig_new(netdev_get_ifindex(netdev));
 =

 	station->anqp_pending =3D l_queue_new();
@@ -4442,12 +4441,7 @@ static int station_init(void)
 				&anqp_disabled))
 		anqp_disabled =3D true;
 =

-	if (!l_settings_get_bool(iwd_get_config(), "General",
-					"EnableNetworkConfiguration",
-					&netconfig_enabled))
-			netconfig_enabled =3D false;
-
-	if (!netconfig_enabled)
+	if (!netconfig_get_enabled())
 		l_info("station: Network configuration is disabled.");
 =

 	watchlist_init(&event_watches, NULL);
-- =

2.32.0

--===============1060516495317989668==--

