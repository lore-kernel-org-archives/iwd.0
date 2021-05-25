Content-Type: multipart/mixed; boundary="===============5000525607955947606=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/7] ap: Refactor DHCP settings loading
Date: Tue, 25 May 2021 14:55:04 +0200
Message-ID: <20210525125508.2695708-3-andrew.zaborowski@intel.com>
In-Reply-To: <20210525125508.2695708-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5000525607955947606==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Extend the [IPv4].Address setting's syntax to allow a new format: a list
of <IP>/<prefix_len> -form strings that define the address space from
which a subnet is selected.  Rewrite the DHCP settings loading with
other notable changes:

 * validate some of the settings more thoroughly,
 * name all netconfig-related ap_state members with the netconfig_
   prefix,
 * make sure we always call l_dhcp_server_set_netmask(),
 * allow netmasks other than 24-bit and change the default to 28 bits,
 * as requested avoid using the l_net_ ioctl-based functions although
   l_dhcp still uses them internally,
 * as requested avoid touching the ap_state members until the end of
   some functions so that on error they're basically a no-op (for
   readabaility).
---
 src/ap.c | 423 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 262 insertions(+), 161 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index fff7c664..aad460dc 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -52,6 +52,7 @@
 #include "src/frame-xchg.h"
 #include "src/wscutil.h"
 #include "src/eap-wsc.h"
+#include "src/ip-pool.h"
 #include "src/ap.h"
 #include "src/storage.h"
 #include "src/diagnostic.h"
@@ -88,15 +89,15 @@ struct ap_state {
 	uint16_t last_aid;
 	struct l_queue *sta_states;
 =

-	struct l_dhcp_server *server;
+	struct l_dhcp_server *netconfig_dhcp;
+	char *netconfig_addr4_str;
+	uint8_t netconfig_prefix_len4;
 	uint32_t rtnl_add_cmd;
-	char *own_ip;
-	unsigned int ip_prefix;
 =

 	bool started : 1;
 	bool gtk_set : 1;
-	bool cleanup_ip : 1;
-	bool use_ip_pool : 1;
+	bool netconfig_set_addr4 : 1;
+	bool netconfig_use_ip_pool : 1;
 };
 =

 struct sta_state {
@@ -173,15 +174,14 @@ static bool ip_pool_create(const char *ip_prefix)
 	return true;
 }
 =

-static char *ip_pool_get()
+static uint32_t ip_pool_get()
 {
 	uint32_t ip;
-	struct in_addr ia;
 	uint8_t next_subnet =3D (uint8_t)l_uintset_find_unused_min(pool.used);
 =

 	/* This shouldn't happen */
 	if (next_subnet < pool.sub_start || next_subnet > pool.sub_end)
-		return NULL;
+		return 0;
 =

 	l_uintset_put(pool.used, next_subnet);
 =

@@ -189,8 +189,7 @@ static char *ip_pool_get()
 	ip &=3D 0xffff00ff;
 	ip |=3D (next_subnet << 8);
 =

-	ia.s_addr =3D htonl(ip);
-	return l_strdup(inet_ntoa(ia));
+	return ip;
 }
 =

 static bool ip_pool_put(const char *address)
@@ -321,23 +320,27 @@ static void ap_reset(struct ap_state *ap)
 	ap->started =3D false;
 =

 	/* Delete IP if one was set by IWD */
-	if (ap->cleanup_ip)
+	if (ap->netconfig_set_addr4) {
 		l_rtnl_ifaddr4_delete(rtnl, netdev_get_ifindex(netdev),
-					ap->ip_prefix, ap->own_ip,
-					broadcast_from_ip(ap->own_ip),
-					NULL, NULL, NULL);
+				ap->netconfig_prefix_len4,
+				ap->netconfig_addr4_str,
+				broadcast_from_ip(ap->netconfig_addr4_str),
+				NULL, NULL, NULL);
+		ap->netconfig_set_addr4 =3D false;
+	}
 =

-	if (ap->own_ip) {
+	if (ap->netconfig_use_ip_pool) {
 		/* Release IP from pool if used */
-		if (ap->use_ip_pool)
-			ip_pool_put(ap->own_ip);
-
-		l_free(ap->own_ip);
+		ip_pool_put(ap->netconfig_addr4_str);
+		ap->netconfig_use_ip_pool =3D false;
 	}
 =

-	if (ap->server) {
-		l_dhcp_server_destroy(ap->server);
-		ap->server =3D NULL;
+	l_free(ap->netconfig_addr4_str);
+	ap->netconfig_addr4_str =3D NULL;
+
+	if (ap->netconfig_dhcp) {
+		l_dhcp_server_destroy(ap->netconfig_dhcp);
+		ap->netconfig_dhcp =3D NULL;
 	}
 }
 =

@@ -2165,7 +2168,7 @@ static void ap_start_cb(struct l_genl_msg *msg, void =
*user_data)
 		goto failed;
 	}
 =

-	if (ap->server && !l_dhcp_server_start(ap->server)) {
+	if (ap->netconfig_dhcp && !l_dhcp_server_start(ap->netconfig_dhcp)) {
 		l_error("DHCP server failed to start");
 		goto failed;
 	}
@@ -2492,182 +2495,268 @@ static void ap_mlme_notify(struct l_genl_msg *msg=
, void *user_data)
 	}
 }
 =

-static bool dhcp_load_settings(struct ap_state *ap,
-				const struct l_settings *settings)
+#define AP_DEFAULT_IPV4_PREFIX_LEN 28
+
+static int ap_setup_netconfig4(struct ap_state *ap, const char **addr_str_=
list,
+				uint8_t prefix_len, const char *gateway_str,
+				const char **ip_range,
+				const char **dns_str_list,
+				unsigned int lease_time)
 {
-	struct l_dhcp_server *server =3D ap->server;
+	uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
+	const struct ip_pool_addr4_record *addr_rec =3D
+		ip_pool_get_addr4(ap->netdev);
+	uint32_t addr;
+	int ret;
 	struct in_addr ia;
+	struct l_dhcp_server *dhcp;
+	bool use_ip_pool =3D false;
+	bool r;
 =

-	L_AUTO_FREE_VAR(char *, netmask) =3D l_settings_get_string(settings,
-							"IPv4", "Netmask");
-	L_AUTO_FREE_VAR(char *, gateway) =3D l_settings_get_string(settings,
-							"IPv4", "Gateway");
-	char **dns =3D l_settings_get_string_list(settings, "IPv4",
-							"DNSList", ',');
-	char **ip_range =3D l_settings_get_string_list(settings, "IPv4",
-							"IPRange", ',');
-	unsigned int lease_time;
-	bool ret =3D false;
+	dhcp =3D l_dhcp_server_new(ifindex);
+	if (!dhcp) {
+		l_error("Failed to create DHCP server on ifindex %u", ifindex);
+		return -EIO;
+	}
+
+	if (getenv("IWD_DHCP_DEBUG"))
+		l_dhcp_server_set_debug(dhcp, do_debug,
+					"[DHCPv4 SERV] ", NULL);
+
+	/*
+	 * The address pool specified for this AP (if any) has the priority,
+	 * next is the address currently set on the interface (if any) and
+	 * last is the global AP address pool (APRanges setting).
+	 */
+	if (addr_str_list) {
+		if (!prefix_len)
+			prefix_len =3D AP_DEFAULT_IPV4_PREFIX_LEN;
+
+		ret =3D ip_pool_select_addr4(addr_str_list, prefix_len,
+						ap->netdev, &addr);
+	} else if (addr_rec && addr_rec->addr &&
+			addr_rec->prefix_len > 0 && addr_rec->prefix_len < 31) {
+		addr =3D addr_rec->addr;
+
+		if (!prefix_len)
+			prefix_len =3D addr_rec->prefix_len;
+
+		ret =3D 0;
+	} else {
+		if (prefix_len) {
+			l_error("[IPv4].Netmask can't be used without an "
+				"address");
+			ret =3D -EINVAL;
+			goto error;
+		}
+
+		/* No config, no address set. Use IP pool */
+		addr =3D ip_pool_get();
+		if (addr) {
+			use_ip_pool =3D true;
+			prefix_len =3D pool.prefix;
+			ret =3D 0;
+		} else {
+			l_error("No more IP's in pool, cannot start AP on %u",
+					ifindex);
+			ret =3D -EEXIST;
+		}
+	}
 =

-	if (!l_settings_get_uint(settings, "IPv4", "LeaseTime", &lease_time))
-		lease_time =3D 0;
+	if (ret)
+		goto error;
 =

-	if (gateway && !l_dhcp_server_set_gateway(server, gateway)) {
-		l_error("[IPv4].Gateway value error");
+	ret =3D -EIO;
+
+	/*
+	 * l_dhcp_server_start() would retrieve the current IPv4 from
+	 * the interface but set it anyway in case there are multiple
+	 * addresses, saves one ioctl too.
+	 */
+	ia.s_addr =3D htonl(addr);
+
+	if (!l_dhcp_server_set_ip_address(dhcp, inet_ntoa(ia))) {
+		l_error("l_dhcp_server_set_ip_address failed");
 		goto error;
 	}
 =

-	if (dns && !l_dhcp_server_set_dns(server, dns)) {
-		l_error("[IPv4].DNSList value error");
+	ia.s_addr =3D htonl(util_netmask_from_prefix(prefix_len));
+
+	if (!l_dhcp_server_set_netmask(dhcp, inet_ntoa(ia))) {
+		l_error("l_dhcp_server_set_netmask failed");
 		goto error;
 	}
 =

-	if (netmask && !l_dhcp_server_set_netmask(server, netmask)) {
-		l_error("[IPv4].Netmask value error");
+	if (gateway_str && !l_dhcp_server_set_gateway(dhcp, gateway_str)) {
+		l_error("l_dhcp_server_set_gateway failed");
 		goto error;
 	}
 =

 	if (ip_range) {
-		if (l_strv_length(ip_range) !=3D 2) {
-			l_error("Two addresses expected in [IPv4].IPRange");
+		r =3D l_dhcp_server_set_ip_range(dhcp, ip_range[0], ip_range[1]);
+		if (!r) {
+			l_error("l_dhcp_server_set_ip_range failed");
 			goto error;
 		}
+	}
 =

-		if (!l_dhcp_server_set_ip_range(server, ip_range[0],
-							ip_range[1])) {
-			l_error("Error setting IP range from [IPv4].IPRange");
+	if (dns_str_list) {
+		r =3D l_dhcp_server_set_dns(dhcp, (char **) dns_str_list);
+		if (!r) {
+			l_error("l_dhcp_server_set_dns failed");
 			goto error;
 		}
 	}
 =

-	if (lease_time && !l_dhcp_server_set_lease_time(server, lease_time)) {
-		l_error("[IPv4].LeaseTime value error");
+	if (lease_time && !l_dhcp_server_set_lease_time(dhcp, lease_time)) {
+		l_error("l_dhcp_server_set_lease_time failed");
 		goto error;
 	}
 =

-	if (netmask && inet_pton(AF_INET, netmask, &ia) > 0)
-		ap->ip_prefix =3D __builtin_popcountl(ia.s_addr);
-	else
-		ap->ip_prefix =3D 24;
-
-	ret =3D true;
+	ia.s_addr =3D htonl(addr);
+	ap->netconfig_addr4_str =3D l_strdup(inet_ntoa(ia));
+	ap->netconfig_prefix_len4 =3D prefix_len;
+	ap->netconfig_set_addr4 =3D !addr_rec || addr_rec->addr !=3D addr ||
+		addr_rec->prefix_len > prefix_len;
+	ap->netconfig_use_ip_pool =3D use_ip_pool;
+	ap->netconfig_dhcp =3D dhcp;
+	return 0;
 =

 error:
-	l_strv_free(dns);
-	l_strv_free(ip_range);
+	l_dhcp_server_destroy(dhcp);
 	return ret;
 }
 =

-/*
- * This will determine the IP being used for DHCP. The IP will be automati=
cally
- * set to ap->own_ip.
- *
- * The address to set (or keep) is determined in this order:
- * 1. Address defined in provisioning file
- * 2. Address already set on interface
- * 3. Address in IP pool.
- *
- * Returns:  0 if an IP was successfully selected and needs to be set
- *          -EALREADY if an IP was already set on the interface or
- *            IP configuration was not enabled,
- *          -EEXIST if the IP pool ran out of IP's
- *          -EINVAL if there was an error.
- */
-static int ap_setup_dhcp(struct ap_state *ap, const struct l_settings *set=
tings)
+static int ap_load_ipv4(struct ap_state *ap, const struct l_settings *conf=
ig)
 {
-	uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
-	struct in_addr ia;
-	uint32_t address =3D 0;
-	L_AUTO_FREE_VAR(char *, addr) =3D NULL;
 	int ret =3D -EINVAL;
+	char **addr_str_list =3D NULL;
+	uint32_t static_addr =3D 0;
+	uint8_t prefix_len =3D 0;
+	char *gateway_str =3D NULL;
+	char **ip_range =3D NULL;
+	char **dns_str_list =3D NULL;
+	unsigned int lease_time =3D 0;
+	struct in_addr ia;
+
+	if (!l_settings_has_group(config, "IPv4") || !pool.used)
+		return 0;
 =

-	/* get the current address if there is one */
-	if (l_net_get_address(ifindex, &ia) && ia.s_addr !=3D 0)
-		address =3D ia.s_addr;
+	if (l_settings_has_key(config, "IPv4", "Address")) {
+		addr_str_list =3D l_settings_get_string_list(config, "IPv4",
+								"Address", ',');
+		if (!addr_str_list || !*addr_str_list) {
+			l_error("Can't parse the profile [IPv4].Address "
+				"setting as a string list");
+			goto done;
+		}
 =

-	addr =3D l_settings_get_string(settings, "IPv4", "Address");
-	if (addr) {
-		if (inet_pton(AF_INET, addr, &ia) < 0)
-			return -EINVAL;
+		/* Check for the static IP syntax: Address=3D<IP> */
+		if (l_strv_length(addr_str_list) =3D=3D 1 &&
+				inet_pton(AF_INET, *addr_str_list, &ia) =3D=3D 1)
+			static_addr =3D ntohl(ia.s_addr);
+	}
 =

-		/* Is a matching address already set on interface? */
-		if (ia.s_addr =3D=3D address)
-			ret =3D -EALREADY;
-		else
-			ret =3D 0;
-	} else if (address) {
-		/* No address in config, but interface has one set */
-		addr =3D l_strdup(inet_ntoa(ia));
-		ret =3D -EALREADY;
-	} else if (pool.used) {
-		/* No config file, no address set. Use IP pool */
-		addr =3D ip_pool_get();
-		if (!addr) {
-			l_error("No more IP's in pool, cannot start AP on %u",
-					ifindex);
-			return -EEXIST;
+	if (l_settings_has_key(config, "IPv4", "Netmask")) {
+		L_AUTO_FREE_VAR(char *, netmask_str) =3D
+			l_settings_get_string(config, "IPv4", "Netmask");
+
+		if (inet_pton(AF_INET, netmask_str, &ia) !=3D 1) {
+			l_error("Can't parse the profile [IPv4].Netmask "
+				"setting");
+			goto done;
 		}
 =

-		ap->use_ip_pool =3D true;
-		ap->ip_prefix =3D pool.prefix;
-		ret =3D 0;
-	} else
-		return -EALREADY;
+		prefix_len =3D __builtin_popcount(ia.s_addr);
 =

-	ap->server =3D l_dhcp_server_new(ifindex);
-	if (!ap->server) {
-		l_error("Failed to create DHCP server on %u", ifindex);
-		return -EINVAL;
+		if (ntohl(ia.s_addr) !=3D util_netmask_from_prefix(prefix_len)) {
+			l_error("Invalid profile [IPv4].Netmask value");
+			goto done;
+		}
 	}
 =

-	if (getenv("IWD_DHCP_DEBUG"))
-		l_dhcp_server_set_debug(ap->server, do_debug,
-							"[DHCPv4 SERV] ", NULL);
+	if (l_settings_has_key(config, "IPv4", "Gateway")) {
+		gateway_str =3D l_settings_get_string(config, "IPv4", "Gateway");
+		if (!gateway_str) {
+			l_error("Invalid profile [IPv4].Gateway value");
+			goto done;
+		}
+	}
 =

-	/* Set the remaining DHCP options in config file */
-	if (!dhcp_load_settings(ap, settings))
-		return -EINVAL;
+	if (l_settings_get_value(config, "IPv4", "IPRange")) {
+		int i;
+		uint32_t netmask;
+		uint8_t tmp_len =3D prefix_len ?: AP_DEFAULT_IPV4_PREFIX_LEN;
 =

-	if (!l_dhcp_server_set_ip_address(ap->server, addr))
-		return -EINVAL;
+		ip_range =3D l_settings_get_string_list(config, "IPv4",
+							"IPRange", ',');
 =

-	ap->own_ip =3D l_steal_ptr(addr);
-	return ret;
-}
+		if (!static_addr) {
+			l_error("[IPv4].IPRange only makes sense in an AP "
+				"profile if a static local address has also "
+				"been specified");
+			goto done;
+		}
 =

-static int ap_load_dhcp(struct ap_state *ap, const struct l_settings *conf=
ig,
-			bool *wait_dhcp)
-{
-	uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
-	int err =3D -EINVAL;
+		if (!ip_range || l_strv_length(ip_range) !=3D 2) {
+			l_error("Can't parse the profile [IPv4].IPRange "
+				"setting as two address strings");
+			goto done;
+		}
 =

-	if (!l_settings_has_group(config, "IPv4"))
-		return 0;
+		netmask =3D util_netmask_from_prefix(tmp_len);
 =

-	err =3D ap_setup_dhcp(ap, config);
-	if (err =3D=3D 0) {
-		/* Address change required */
-		ap->rtnl_add_cmd =3D l_rtnl_ifaddr4_add(rtnl, ifindex,
-					ap->ip_prefix, ap->own_ip,
-					broadcast_from_ip(ap->own_ip),
-					ap_ifaddr4_added_cb, ap, NULL);
+		for (i =3D 0; i < 2; i++) {
+			struct in_addr range_addr;
 =

-		if (!ap->rtnl_add_cmd) {
-			l_error("Failed to add IPv4 address");
-			return -EIO;
+			if (inet_aton(ip_range[i], &range_addr) !=3D 1) {
+				l_error("Can't parse address in "
+					"[IPv4].IPRange[%i]", i + 1);
+				goto done;
+			}
+
+			if ((static_addr ^ ntohl(range_addr.s_addr)) &
+					netmask) {
+				ia.s_addr =3D htonl(static_addr);
+				l_error("[IPv4].IPRange[%i] is not in the "
+					"%s/%i subnet", i + 1, inet_ntoa(ia),
+					tmp_len);
+				goto done;
+			}
 		}
+	}
 =

-		ap->cleanup_ip =3D true;
+	if (l_settings_has_key(config, "IPv4", "DNSList")) {
+		dns_str_list =3D l_settings_get_string_list(config, "IPv4",
+								"DNSList", ',');
+		if (!dns_str_list || !*dns_str_list) {
+			l_error("Can't parse the profile [IPv4].DNSList "
+				"setting as a string list");
+			goto done;
+		}
+	}
 =

-		*wait_dhcp =3D true;
-		err =3D 0;
-	/* Selected address already set, continue normally */
-	} else if (err =3D=3D -EALREADY) {
-		*wait_dhcp =3D false;
-		err =3D 0;
+	if (l_settings_has_key(config, "IPv4", "LeaseTime")) {
+		if (!l_settings_get_uint(config, "IPv4", "LeaseTime",
+						&lease_time) ||
+				lease_time < 1) {
+			l_error("Error parsing [IPv4].LeaseTime as a positive "
+				"integer");
+			goto done;
+		}
 	}
 =

-	return err;
+	ret =3D ap_setup_netconfig4(ap, (const char **) addr_str_list, prefix_len,
+					gateway_str, (const char **) ip_range,
+					(const char **) dns_str_list,
+					lease_time);
+
+done:
+	l_strv_free(addr_str_list);
+	l_free(gateway_str);
+	l_strv_free(ip_range);
+	l_strv_free(dns_str_list);
+	return ret;
 }
 =

 static bool ap_load_psk(struct ap_state *ap, const struct l_settings *conf=
ig)
@@ -2722,7 +2811,7 @@ static bool ap_load_psk(struct ap_state *ap, const st=
ruct l_settings *config)
 }
 =

 static int ap_load_config(struct ap_state *ap, const struct l_settings *co=
nfig,
-				bool *out_wait_dhcp, bool *out_cck_rates)
+				bool *out_cck_rates)
 {
 	size_t len;
 	L_AUTO_FREE_VAR(char *, strval) =3D NULL;
@@ -2748,11 +2837,12 @@ static int ap_load_config(struct ap_state *ap, cons=
t struct l_settings *config,
 		return -EINVAL;
 =

 	/*
-	 * This loads DHCP settings either from the l_settings object or uses
-	 * the defaults. wait_on_address will be set true if an address change
-	 * is required.
+	 * This looks@the network configuration settings in @config and
+	 * relevant global settings and if it determines that netconfig is to
+	 * be enabled for the AP, it both creates the DHCP server object and
+	 * processes IP settings, applying the defaults where needed.
 	 */
-	err =3D ap_load_dhcp(ap, config, out_wait_dhcp);
+	err =3D ap_load_ipv4(ap, config);
 	if (err)
 		return err;
 =

@@ -2868,15 +2958,15 @@ struct ap_state *ap_start(struct netdev *netdev, st=
ruct l_settings *config,
 	struct ap_state *ap;
 	struct wiphy *wiphy =3D netdev_get_wiphy(netdev);
 	uint64_t wdev_id =3D netdev_get_wdev_id(netdev);
-	int err =3D -EINVAL;
-	bool wait_on_address =3D false;
+	int err;
 	bool cck_rates =3D true;
 =

-	if (err_out)
-		*err_out =3D err;
+	if (L_WARN_ON(!config)) {
+		if (err_out)
+			*err_out =3D -EINVAL;
 =

-	if (L_WARN_ON(!config))
 		return NULL;
+	}
 =

 	ap =3D l_new(struct ap_state, 1);
 	ap->nl80211 =3D l_genl_family_new(iwd_get_genl(), NL80211_GENL_NAME);
@@ -2884,7 +2974,7 @@ struct ap_state *ap_start(struct netdev *netdev, stru=
ct l_settings *config,
 	ap->ops =3D ops;
 	ap->user_data =3D user_data;
 =

-	err =3D ap_load_config(ap, config, &wait_on_address, &cck_rates);
+	err =3D ap_load_config(ap, config, &cck_rates);
 	if (err)
 		goto error;
 =

@@ -2950,9 +3040,20 @@ struct ap_state *ap_start(struct netdev *netdev, str=
uct l_settings *config,
 	if (!ap->mlme_watch)
 		l_error("Registering for MLME notification failed");
 =

-	if (wait_on_address) {
-		if (err_out)
-			*err_out =3D 0;
+	if (ap->netconfig_set_addr4) {
+		const char *broadcast_str =3D
+			broadcast_from_ip(ap->netconfig_addr4_str);
+
+		ap->rtnl_add_cmd =3D l_rtnl_ifaddr4_add(rtnl,
+						netdev_get_ifindex(netdev),
+						ap->netconfig_prefix_len4,
+						ap->netconfig_addr4_str,
+						broadcast_str,
+						ap_ifaddr4_added_cb, ap, NULL);
+		if (!ap->rtnl_add_cmd) {
+			l_error("Failed to add the IPv4 address");
+			goto error;
+		}
 =

 		return ap;
 	}
-- =

2.27.0

--===============5000525607955947606==--

