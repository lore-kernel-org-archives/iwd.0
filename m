Content-Type: multipart/mixed; boundary="===============2066510499130835860=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/7] ap: Refactor global address pool loading
Date: Tue, 25 May 2021 14:55:05 +0200
Message-ID: <20210525125508.2695708-4-andrew.zaborowski@intel.com>
In-Reply-To: <20210525125508.2695708-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2066510499130835860==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Deprecate the global [General].APRanges setting in favour of
[IPv4].APAddressPool with an extended (but backwards-compatible) syntax.
Drop the existing address pool creation code.

The new APAddressPool setting has the same syntax as the profile-local
[IPv4].Address setting and the subnet selection code will fall back
to the global setting if it's missing, this way we use common code to
handle both settings.
---
 src/ap.c | 180 +++++++++++++------------------------------------------
 1 file changed, 42 insertions(+), 138 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index aad460dc..52587d9d 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -97,7 +97,6 @@ struct ap_state {
 	bool started : 1;
 	bool gtk_set : 1;
 	bool netconfig_set_addr4 : 1;
-	bool netconfig_use_ip_pool : 1;
 };
 =

 struct sta_state {
@@ -128,97 +127,11 @@ struct ap_wsc_pbc_probe_record {
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
+static char **global_addr4_strs;
 static uint32_t netdev_watch;
 static struct l_netlink *rtnl;
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
-static uint32_t ip_pool_get()
-{
-	uint32_t ip;
-	uint8_t next_subnet =3D (uint8_t)l_uintset_find_unused_min(pool.used);
-
-	/* This shouldn't happen */
-	if (next_subnet < pool.sub_start || next_subnet > pool.sub_end)
-		return 0;
-
-	l_uintset_put(pool.used, next_subnet);
-
-	ip =3D pool.start;
-	ip &=3D 0xffff00ff;
-	ip |=3D (next_subnet << 8);
-
-	return ip;
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
@@ -329,12 +242,6 @@ static void ap_reset(struct ap_state *ap)
 		ap->netconfig_set_addr4 =3D false;
 	}
 =

-	if (ap->netconfig_use_ip_pool) {
-		/* Release IP from pool if used */
-		ip_pool_put(ap->netconfig_addr4_str);
-		ap->netconfig_use_ip_pool =3D false;
-	}
-
 	l_free(ap->netconfig_addr4_str);
 	ap->netconfig_addr4_str =3D NULL;
 =

@@ -2510,7 +2417,6 @@ static int ap_setup_netconfig4(struct ap_state *ap, c=
onst char **addr_str_list,
 	int ret;
 	struct in_addr ia;
 	struct l_dhcp_server *dhcp;
-	bool use_ip_pool =3D false;
 	bool r;
 =

 	dhcp =3D l_dhcp_server_new(ifindex);
@@ -2543,24 +2449,11 @@ static int ap_setup_netconfig4(struct ap_state *ap,=
 const char **addr_str_list,
 =

 		ret =3D 0;
 	} else {
-		if (prefix_len) {
-			l_error("[IPv4].Netmask can't be used without an "
-				"address");
-			ret =3D -EINVAL;
-			goto error;
-		}
+		if (!prefix_len)
+			prefix_len =3D AP_DEFAULT_IPV4_PREFIX_LEN;
 =

-		/* No config, no address set. Use IP pool */
-		addr =3D ip_pool_get();
-		if (addr) {
-			use_ip_pool =3D true;
-			prefix_len =3D pool.prefix;
-			ret =3D 0;
-		} else {
-			l_error("No more IP's in pool, cannot start AP on %u",
-					ifindex);
-			ret =3D -EEXIST;
-		}
+		ret =3D ip_pool_select_addr4((const char **) global_addr4_strs,
+						prefix_len, ap->netdev, &addr);
 	}
 =

 	if (ret)
@@ -2618,7 +2511,6 @@ static int ap_setup_netconfig4(struct ap_state *ap, c=
onst char **addr_str_list,
 	ap->netconfig_prefix_len4 =3D prefix_len;
 	ap->netconfig_set_addr4 =3D !addr_rec || addr_rec->addr !=3D addr ||
 		addr_rec->prefix_len > prefix_len;
-	ap->netconfig_use_ip_pool =3D use_ip_pool;
 	ap->netconfig_dhcp =3D dhcp;
 	return 0;
 =

@@ -2639,7 +2531,7 @@ static int ap_load_ipv4(struct ap_state *ap, const st=
ruct l_settings *config)
 	unsigned int lease_time =3D 0;
 	struct in_addr ia;
 =

-	if (!l_settings_has_group(config, "IPv4") || !pool.used)
+	if (!l_settings_has_group(config, "IPv4") || !netconfig_enabled)
 		return 0;
 =

 	if (l_settings_has_key(config, "IPv4", "Address")) {
@@ -3628,7 +3520,6 @@ static void ap_netdev_watch(struct netdev *netdev,
 static int ap_init(void)
 {
 	const struct l_settings *settings =3D iwd_get_config();
-	bool dhcp_enable;
 =

 	netdev_watch =3D netdev_watch_add(ap_netdev_watch, NULL, NULL);
 =

@@ -3639,31 +3530,44 @@ static int ap_init(void)
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
-
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
+					"EnableNetworkConfiguration",
+					&netconfig_enabled))
+		netconfig_enabled =3D false;
+
+	if (netconfig_enabled) {
+		if (l_settings_get_value(settings, "IPv4", "APAddressPool")) {
+			global_addr4_strs =3D l_settings_get_string_list(settings,
+								"IPv4",
+								"APAddressPool",
+								',');
+			if (!global_addr4_strs || !*global_addr4_strs) {
+				l_error("Can't parse the [IPv4].APAddressPool "
+					"setting as a string list");
+				l_strv_free(global_addr4_strs);
+				global_addr4_strs =3D NULL;
+			}
+		} else if (l_settings_get_value(settings,
+						"General", "APRanges")) {
+			global_addr4_strs =3D l_settings_get_string_list(settings,
+								"General",
+								"APRanges",
+								',');
+			if (!global_addr4_strs || !*global_addr4_strs) {
+				l_error("Can't parse the [General].APRanges "
+					"setting as a string list");
+				l_strv_free(global_addr4_strs);
+				global_addr4_strs =3D NULL;
+			}
 		}
 =

-		if (!ip_pool_create(ip_prefix))
-			return -EINVAL;
+		/* Fall back to 192.168.0.0/16 */
+		if (!global_addr4_strs)
+			global_addr4_strs =3D
+				l_strv_append(NULL, "192.168.0.0/16");
 	}
 =

 	rtnl =3D iwd_get_rtnl();
@@ -3676,7 +3580,7 @@ static void ap_exit(void)
 	netdev_watch_remove(netdev_watch);
 	l_dbus_unregister_interface(dbus_get_bus(), IWD_AP_INTERFACE);
 =

-	ip_pool_destroy();
+	l_strv_free(global_addr4_strs);
 }
 =

 IWD_MODULE(ap, ap_init, ap_exit)
-- =

2.27.0

--===============2066510499130835860==--

