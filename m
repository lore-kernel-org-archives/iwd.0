Content-Type: multipart/mixed; boundary="===============4180867220778737983=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 03/10] ap: Refactor address pool logic
Date: Fri, 05 Mar 2021 16:09:29 +0100
Message-ID: <20210305150936.868546-3-andrew.zaborowski@intel.com>
In-Reply-To: <20210305150936.868546-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4180867220778737983==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Deprecate the global [General].APRanges setting in favour of
[IPv4].APAddressPool with an extended syntax, but keep backwards
compatibility.  Drop the existing address pool creation code.  The
new APAddressPool setting has the same syntax as the profile-local
[IPv4].Address.  [IPv4].Address is loaded as ap->config->addr4_str_list
and, when missing, ap_start will fall back to the global setting so
there'll be common code to handle both settings.
---
 src/ap.c | 153 +++++++++++++++----------------------------------------
 1 file changed, 40 insertions(+), 113 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 589f6059..fdb4b454 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -86,7 +86,6 @@ struct ap_state {
 	bool started : 1;
 	bool gtk_set : 1;
 	bool cleanup_ip : 1;
-	bool use_ip_pool : 1;
 };
 =

 struct sta_state {
@@ -115,99 +114,11 @@ struct ap_wsc_pbc_probe_record {
 	uint64_t timestamp;
 };
 =

-struct ap_ip_pool {
-	uint32_t start;
-	uint32_t end;
-	uint8_t prefix;
-
-	/* Fist/last valid subnet */
-	uint8_t sub_start;
-	uint8_t sub_end;
-
-	struct l_uintset *used;
-};
-
-struct ap_ip_pool pool;
+static bool netconfig_enabled;
+static char **global_addr_strs;
 static uint32_t netdev_watch;
 struct l_netlink *rtnl;
 =

-/*
- * Creates pool of IPs which AP intefaces can use. Each call to ip_pool_get
- * will advance the subnet +1 so there are no IP conflicts between AP
- * interfaces
- */
-static bool ip_pool_create(const char *ip_prefix)
-{
-	if (!util_ip_prefix_tohl(ip_prefix, &pool.prefix, &pool.start,
-					&pool.end, NULL))
-		return false;
-
-	if (pool.prefix > 24) {
-		l_error("APRanges prefix must 24 or less (%u used)",
-				pool.prefix);
-		memset(&pool, 0, sizeof(pool));
-		return false;
-	}
-
-	/*
-	 * Find the number of subnets we can use, this will dictate the number
-	 * of AP interfaces that can be created (when using DHCP)
-	 */
-	pool.sub_start =3D (pool.start & 0x0000ff00) >> 8;
-	pool.sub_end =3D (pool.end & 0x0000ff00) >> 8;
-
-	pool.used =3D l_uintset_new_from_range(pool.sub_start, pool.sub_end);
-
-	return true;
-}
-
-static char *ip_pool_get()
-{
-	uint32_t ip;
-	struct in_addr ia;
-	uint8_t next_subnet =3D (uint8_t)l_uintset_find_unused_min(pool.used);
-
-	/* This shouldn't happen */
-	if (next_subnet < pool.sub_start || next_subnet > pool.sub_end)
-		return NULL;
-
-	l_uintset_put(pool.used, next_subnet);
-
-	ip =3D pool.start;
-	ip &=3D 0xffff00ff;
-	ip |=3D (next_subnet << 8);
-
-	ia.s_addr =3D htonl(ip);
-	return l_strdup(inet_ntoa(ia));
-}
-
-static bool ip_pool_put(const char *address)
-{
-	struct in_addr ia;
-	uint32_t ip;
-	uint8_t subnet;
-
-	if (inet_aton(address, &ia) < 0)
-		return false;
-
-	ip =3D ntohl(ia.s_addr);
-
-	subnet =3D (ip & 0x0000ff00) >> 8;
-
-	if (subnet < pool.sub_start || subnet > pool.sub_end)
-		return false;
-
-	return l_uintset_take(pool.used, subnet);
-}
-
-static void ip_pool_destroy()
-{
-	if (pool.used)
-		l_uintset_free(pool.used);
-
-	memset(&pool, 0, sizeof(pool));
-}
-
 static const char *broadcast_from_ip(const char *ip)
 {
 	struct in_addr ia;
@@ -2677,6 +2588,10 @@ struct ap_state *ap_start(struct netdev *netdev, str=
uct ap_config *config,
 	if (!ap->mlme_watch)
 		l_error("Registering for MLME notification failed");
 =

+	if (netconfig_enabled && !ap->config->disable_netconfig4) {
+		/* TODO: Start netconfig */
+	}
+
 	cmd =3D ap_build_cmd_start_ap(ap);
 	if (!cmd)
 		goto error;
@@ -3235,7 +3150,6 @@ static void ap_netdev_watch(struct netdev *netdev,
 static int ap_init(void)
 {
 	const struct l_settings *settings =3D iwd_get_config();
-	bool dhcp_enable;
 =

 	netdev_watch =3D netdev_watch_add(ap_netdev_watch, NULL, NULL);
 =

@@ -3246,31 +3160,44 @@ static int ap_init(void)
 			ap_diagnostic_interface_destroy, false);
 =

 	/*
-	 * Reusing [General].EnableNetworkConfiguration as a switch to enable
-	 * DHCP server. If no value is found or it is false do not create a
-	 * DHCP server.
+	 * Enable network configuration and DHCP only if
+	 * [General].EnableNetworkConfiguration is true.
 	 */
 	if (!l_settings_get_bool(settings, "General",
-				"EnableNetworkConfiguration", &dhcp_enable))
-		dhcp_enable =3D false;
+					"EnableNetworkConfiguration",
+					&netconfig_enabled))
+		netconfig_enabled =3D false;
 =

-	if (dhcp_enable) {
-		L_AUTO_FREE_VAR(char *, ip_prefix);
-
-		ip_prefix =3D l_settings_get_string(settings, "General",
-							"APRanges");
-		/*
-		 * In this case its assumed the user only cares about station
-		 * netconfig so we let ap_init pass but DHCP will not be
-		 * enabled.
-		 */
-		if (!ip_prefix) {
-			l_warn("[General].APRanges must be set for DHCP");
-			return 0;
+	if (netconfig_enabled) {
+		if (l_settings_get_value(settings, "IPv4", "APAddressPool")) {
+			global_addr_strs =3D l_settings_get_string_list(settings,
+								"IPv4",
+								"APAddressPool",
+								',');
+			if (!global_addr_strs || !*global_addr_strs) {
+				l_error("Can't parse the [IPv4].APAddressPool "
+					"setting as a string list");
+				l_strv_free(global_addr_strs);
+				global_addr_strs =3D NULL;
+			}
+		} else if (l_settings_get_value(settings,
+						"General", "APRanges")) {
+			global_addr_strs =3D l_settings_get_string_list(settings,
+								"General",
+								"APRanges",
+								',');
+			if (!global_addr_strs || !*global_addr_strs) {
+				l_error("Can't parse the [General].APRanges "
+					"setting as a string list");
+				l_strv_free(global_addr_strs);
+				global_addr_strs =3D NULL;
+			}
 		}
 =

-		if (!ip_pool_create(ip_prefix))
-			return -EINVAL;
+		/* Fall back to 192.168.0.0/16 */
+		if (!global_addr_strs)
+			global_addr_strs =3D
+				l_strv_append(NULL, "192.168.0.0/16");
 	}
 =

 	rtnl =3D iwd_get_rtnl();
@@ -3283,7 +3210,7 @@ static void ap_exit(void)
 	netdev_watch_remove(netdev_watch);
 	l_dbus_unregister_interface(dbus_get_bus(), IWD_AP_INTERFACE);
 =

-	ip_pool_destroy();
+	l_strv_free(global_addr_strs);
 }
 =

 IWD_MODULE(ap, ap_init, ap_exit)
-- =

2.27.0

--===============4180867220778737983==--

