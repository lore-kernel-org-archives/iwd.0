Content-Type: multipart/mixed; boundary="===============5484125341927373484=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/7] ap: Refactor IP address selection
Date: Fri, 26 Feb 2021 17:17:26 +0100
Message-ID: <20210226161728.677701-5-andrew.zaborowski@intel.com>
In-Reply-To: <20210226161728.677701-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5484125341927373484==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Refactor how the subnet IP address is selected and change related
settings syntax in the following way:

* [IPv4].Address in an AP profile can now be given as just an IP address
  or a list of prefix notation address spaces.  In the latter case one
  subnet address of the size implied by [IPv4].Netmask is selected
  randomly from that space, defaults to a 28-bit netmask.  In the former
  case [IPv4].Address is now also checked for conflicts with addresses
  already in use.

* main.conf's [IPv4].APAddressPool is now the fallback setting that uses
  the same syntax as profile-local [IPv4].Address and has a default
  value of 192.168.0.0/16.

* main.conf's [General].APRanges is deprecated in favour of
  [IPv4].APAddressPool but this change should be backwards compatible.

ap_setup_dhcp now always prints error messages, it seems it was assumed
that the caller would do this before but it didn't.  It also now always
reads [IPv4].Netmask or the value already set on the interface (when
existing IP is used) and uses that value.  Previously the configured
netmask was only being announced through DHCP but not used locally.
---
 src/ap.c | 563 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 350 insertions(+), 213 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 2042cde6..98c89f7f 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -28,6 +28,7 @@
 #include <linux/if_ether.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
+#include <ifaddrs.h>
 =

 #include <ell/ell.h>
 =

@@ -81,12 +82,11 @@ struct ap_state {
 	struct l_dhcp_server *server;
 	uint32_t rtnl_add_cmd;
 	char *own_ip;
-	unsigned int ip_prefix;
+	uint8_t ip_prefix;
 =

 	bool started : 1;
 	bool gtk_set : 1;
 	bool cleanup_ip : 1;
-	bool use_ip_pool : 1;
 };
 =

 struct sta_state {
@@ -115,99 +115,10 @@ struct ap_wsc_pbc_probe_record {
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
+struct l_uintset *used_ips;
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
@@ -326,13 +237,8 @@ static void ap_reset(struct ap_state *ap)
 					broadcast_from_ip(ap->own_ip),
 					NULL, NULL, NULL);
 =

-	if (ap->own_ip) {
-		/* Release IP from pool if used */
-		if (ap->use_ip_pool)
-			ip_pool_put(ap->own_ip);
-
+	if (ap->own_ip)
 		l_free(ap->own_ip);
-	}
 =

 	if (ap->server)
 		l_dhcp_server_stop(ap->server);
@@ -2394,13 +2300,12 @@ static void ap_mlme_notify(struct l_genl_msg *msg, =
void *user_data)
 	}
 }
 =

-static bool dhcp_load_settings(struct ap_state *ap, struct l_settings *set=
tings)
+static bool dhcp_load_settings(struct ap_state *ap,
+				const struct l_settings *settings,
+				uint32_t own_ip, uint8_t prefix)
 {
 	struct l_dhcp_server *server =3D ap->server;
-	struct in_addr ia;
 =

-	L_AUTO_FREE_VAR(char *, netmask) =3D l_settings_get_string(settings,
-							"IPv4", "Netmask");
 	L_AUTO_FREE_VAR(char *, gateway) =3D l_settings_get_string(settings,
 							"IPv4", "Gateway");
 	char **dns =3D l_settings_get_string_list(settings, "IPv4",
@@ -2423,17 +2328,34 @@ static bool dhcp_load_settings(struct ap_state *ap,=
 struct l_settings *settings)
 		goto error;
 	}
 =

-	if (netmask && !l_dhcp_server_set_netmask(server, netmask)) {
-		l_error("[IPv4].Netmask value error");
-		goto error;
-	}
-
 	if (ip_range) {
+		int i;
+
 		if (l_strv_length(ip_range) !=3D 2) {
 			l_error("Two addresses expected in [IPv4].IPRange");
 			goto error;
 		}
 =

+		for (i =3D 0; i < 2; i++) {
+			struct in_addr range_addr;
+
+			if (inet_aton(ip_range[i], &range_addr) !=3D 1) {
+				l_error("Can't parse address in "
+					"[IPv4].IPRange[%i]", i + 1);
+				goto error;
+			}
+
+			if ((own_ip ^ ntohl(range_addr.s_addr)) &
+					util_netmask_from_prefix(prefix)) {
+				struct in_addr addr =3D { htonl(own_ip) };
+
+				l_error("[IPv4].IPRange[%i] is not in the "
+					"%s/%i subnet", i + 1,
+					inet_ntoa(addr), prefix);
+				goto error;
+			}
+		}
+
 		if (!l_dhcp_server_set_ip_range(server, ip_range[0],
 							ip_range[1])) {
 			l_error("Error setting IP range from [IPv4].IPRange");
@@ -2446,11 +2368,6 @@ static bool dhcp_load_settings(struct ap_state *ap, =
struct l_settings *settings)
 		goto error;
 	}
 =

-	if (netmask && inet_pton(AF_INET, netmask, &ia) > 0)
-		ap->ip_prefix =3D __builtin_popcountl(ia.s_addr);
-	else
-		ap->ip_prefix =3D 24;
-
 	ret =3D true;
 =

 error:
@@ -2459,31 +2376,234 @@ error:
 	return ret;
 }
 =

+struct ap_ip_range {
+	uint32_t start;
+	uint32_t end;
+};
+
 /*
- * This will determine the IP being used for DHCP. The IP will be automati=
cally
- * set to ap->own_ip.
+ * Append any address ranges within an input start/end range, which contain
+ * at least one full subnet and don't intersect with any subnets already in
+ * use.  This may result in the input range being split into multiple rang=
es
+ * of different sizes or being skipped altogether.
+ * All inputs must be rounded to the subnet boundary and the @used queue
+ * sorted by the subnet start address.
+ */
+static void ap_append_range(struct l_queue *to, const struct ap_ip_range *=
range,
+				const struct l_queue *used)
+{
+	const struct l_queue_entry *entry =3D
+		l_queue_get_entries((struct l_queue *) used);
+	const struct ap_ip_range *used_range =3D entry ? entry->data : NULL;
+	uint32_t start =3D range->start;
+
+	while (range->end > start) {
+		while (used_range && used_range->end <=3D start) {
+			entry =3D entry->next;
+			used_range =3D entry ? entry->data : NULL;
+		}
+
+		/* No more used ranges that intersect with @start/@range->end */
+		if (!used_range || range->end <=3D used_range->start) {
+			struct ap_ip_range *sub =3D l_new(struct ap_ip_range, 1);
+
+			sub->start =3D start;
+			sub->end =3D range->end;
+			l_queue_push_tail(to, sub);
+			return;
+		}
+
+		/* Now we know @used_range is non-NULL and intersects */
+		if (start < used_range->start) {
+			struct ap_ip_range *sub =3D l_new(struct ap_ip_range, 1);
+
+			sub->start =3D start;
+			sub->end =3D used_range->start;
+			l_queue_push_tail(to, sub);
+		}
+
+		/* Skip to the start of the next subnet */
+		start =3D used_range->end;
+	}
+}
+
+static int ap_ip_range_compare(const void *a, const void *b, void *user_da=
ta)
+{
+	const struct ap_ip_range *range_a =3D a;
+	const struct ap_ip_range *range_b =3D b;
+
+	return range_a->start > range_b->start;
+}
+
+/* Select a subnet and a host address from a defined space */
+static int ap_select_addr(const char **addr_str_list, uint8_t prefix,
+				const char *ifname, uint32_t *out_addr)
+{
+	uint32_t total =3D 0;
+	uint32_t selected;
+	unsigned int i;
+	uint32_t addr;
+	struct ifaddrs *ifaddr;
+	const struct ifaddrs *ifa;
+	uint32_t subnet_size =3D 1 << (32 - prefix);
+	uint32_t host_mask =3D subnet_size - 1;
+	uint32_t subnet_mask =3D ~host_mask;
+	uint32_t host_addr =3D 0;
+	struct l_queue *ranges =3D l_queue_new();
+	struct l_queue *used =3D l_queue_new();
+	struct in_addr ia;
+	const struct l_queue_entry *entry;
+	int err =3D -EINVAL;
+
+	/* Build a sorted list of used/unavailable subnets */
+	if (getifaddrs(&ifaddr) !=3D 0)
+		ifaddr =3D NULL;
+
+	for (ifa =3D ifaddr; ifa; ifa =3D ifa->ifa_next) {
+		const struct sockaddr_in *addr_sa;
+		const struct sockaddr_in *netmask_sa;
+		uint32_t used_addr;
+		uint32_t used_prefix;
+		struct ap_ip_range *range;
+
+		if (ifa->ifa_addr->sa_family !=3D AF_INET)
+			continue;
+
+		/*
+		 * Ignore the subnet set on the target interface, we'll be
+		 * overwriting it if everything goes well.
+		 */
+		if (!strcmp(ifa->ifa_name, ifname))
+			continue;
+
+		addr_sa =3D (struct sockaddr_in *) ifa->ifa_addr;
+		netmask_sa =3D (struct sockaddr_in *) ifa->ifa_netmask;
+		if (!addr_sa || !netmask_sa)
+			continue;
+
+		used_addr =3D ntohl(addr_sa->sin_addr.s_addr);
+		used_prefix =3D __builtin_popcountl(netmask_sa->sin_addr.s_addr);
+
+		range =3D l_new(struct ap_ip_range, 1);
+		range->start =3D used_addr & subnet_mask;
+		range->end =3D (range->start + (1 << (32 - used_prefix)) +
+				subnet_size - 1) & subnet_mask;
+		l_queue_insert(used, range, ap_ip_range_compare, NULL);
+	}
+
+	freeifaddrs(ifaddr);
+
+	/* Build the list of available subnets */
+
+	/* Check for the static IP syntax: Address=3D<IP> */
+	if (l_strv_length((char **) addr_str_list) =3D=3D 1 &&
+			inet_pton(AF_INET, *addr_str_list, &ia) =3D=3D 1) {
+		struct ap_ip_range range;
+
+		host_addr =3D ntohl(ia.s_addr);
+		range.start =3D host_addr & subnet_mask;
+		range.end =3D range.start + subnet_size;
+		ap_append_range(ranges, &range, used);
+		goto select_addr;
+	}
+
+	for (i =3D 0; addr_str_list[i]; i++) {
+		struct ap_ip_range range;
+		uint8_t addr_prefix;
+
+		if (!util_ip_prefix_tohl(addr_str_list[i], &addr_prefix, &addr,
+						NULL, NULL)) {
+			l_error("Can't parse %s as a subnet address",
+				addr_str_list[i]);
+			goto done;
+		}
+
+		if (addr_prefix > prefix)
+			continue;
+
+		range.start =3D addr & subnet_mask;
+		range.end =3D range.start + (1 << (32 - addr_prefix));
+		ap_append_range(ranges, &range, used);
+	}
+
+select_addr:
+	if (l_queue_isempty(ranges)) {
+		l_error("No IP subnets available for new Access Point after "
+			"eliminating those already in use on the system");
+		err =3D -EEXIST;
+		goto done;
+	}
+
+	/* Count available @prefix-sized subnets */
+	for (entry =3D l_queue_get_entries(ranges); entry; entry =3D entry->next)=
 {
+		struct ap_ip_range *range =3D entry->data;
+
+		total +=3D (range->end - range->start) >> (32 - prefix);
+	}
+
+	selected =3D l_getrandom_uint32() % total;
+
+	/* Find the @selected'th @prefix-sized subnet */
+	for (entry =3D l_queue_get_entries(ranges);; entry =3D entry->next) {
+		struct ap_ip_range *range =3D entry->data;
+		uint32_t count =3D (range->end - range->start) >> (32 - prefix);
+
+		if (selected < count) {
+			addr =3D range->start + (selected << (32 - prefix));
+			break;
+		}
+
+		selected -=3D count;
+	}
+
+	if (!host_addr)
+		host_addr =3D addr + 1;
+
+	err =3D 0;
+	*out_addr =3D host_addr;
+
+done:
+	l_queue_destroy(ranges, l_free);
+	l_queue_destroy(used, l_free);
+	return err;
+}
+
+#define AP_DEFAULT_IPV4_PREFIX_LEN 28
+
+/*
+ * This will determine the IP to be used for DHCP.  ap->server,
+ * ap->own_ip and ap->ip_prefix will be set.
  *
  * The address to set (or keep) is determined in this order:
- * 1. Address defined in provisioning file
- * 2. Address already set on interface
- * 3. Address in IP pool.
+ * 1. Select from address pool defined in the provisioning file
+ * 2. Keep address already set on the interface
+ * 3. Select from the global address pool
+ * 4. Select from 192.168.0.0/16
  *
  * Returns:  0 if an IP was successfully selected and needs to be set
  *          -EALREADY if an IP was already set on the interface
- *          -EEXIST if the IP pool ran out of IP's
+ *          -EEXIST if all available subnet addresses are in use
  *          -EINVAL if there was an error.
  */
-static int ap_setup_dhcp(struct ap_state *ap, struct l_settings *settings)
+static int ap_setup_dhcp(struct ap_state *ap,
+				const struct l_settings *profile,
+				const struct l_settings *global)
 {
 	uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
-	struct in_addr ia;
+	struct in_addr if_addr;
+	struct in_addr if_netmask;
 	uint32_t address =3D 0;
+	uint8_t prefix;
+	bool update =3D false;
 	int ret =3D -EINVAL;
+	char **addr_str_list;
+	L_AUTO_FREE_VAR(char *, netmask_str) =3D
+		l_settings_get_string(profile, "IPv4", "Netmask");
 =

 	ap->server =3D l_dhcp_server_new(ifindex);
 	if (!ap->server) {
 		l_error("Failed to create DHCP server on %u", ifindex);
-		return -EINVAL;;
+		return -EINVAL;
 	}
 =

 	if (getenv("IWD_DHCP_DEBUG"))
@@ -2491,87 +2611,137 @@ static int ap_setup_dhcp(struct ap_state *ap, stru=
ct l_settings *settings)
 							"[DHCPv4 SERV] ", NULL);
 =

 	/* get the current address if there is one */
-	if (l_net_get_address(ifindex, &ia) && ia.s_addr !=3D 0)
-		address =3D ia.s_addr;
+	if (l_net_get_address(ifindex, &if_addr) && if_addr.s_addr !=3D 0 &&
+			l_net_get_netmask(ifindex, &if_netmask)) {
+		address =3D ntohl(if_addr.s_addr);
+		prefix =3D __builtin_popcountl(if_netmask.s_addr);
+	}
+
+	if (profile && l_settings_get_value(profile, "IPv4", "Address")) {
+		addr_str_list =3D l_settings_get_string_list(profile, "IPv4",
+								"Address", ',');
+		if (!addr_str_list || !*addr_str_list) {
+			l_error("Can't parse the profile [IPv4].Address "
+				"setting as a string list");
+			goto done;
+		}
+	} else if (address) {
+		addr_str_list =3D NULL;
+	} else if (l_settings_get_value(global, "IPv4", "APAddressPool")) {
+		addr_str_list =3D l_settings_get_string_list(global, "IPv4",
+							"APAddressPool", ',');
+		if (!addr_str_list || !*addr_str_list) {
+			l_error("Can't parse the global [IPv4].APAddressPool "
+				"setting as a string list");
+			goto done;
+		}
+	} else if (l_settings_get_value(global, "General", "APRanges")) {
+		addr_str_list =3D l_settings_get_string_list(global, "General",
+							"APRanges", ',');
+		if (!addr_str_list || !*addr_str_list) {
+			l_error("Can't parse the global [General].APRanges "
+				"setting as a string list");
+			goto done;
+		}
+	} else
+		addr_str_list =3D l_strv_append(NULL, "192.168.0.0/16");
 =

-	if (ap->config->profile) {
-		char *addr;
-
-		addr =3D l_settings_get_string(settings, "IPv4", "Address");
-		if (addr) {
-			if (inet_pton(AF_INET, addr, &ia) < 0)
-				goto free_addr;
-
-			/* Is a matching address already set on interface? */
-			if (ia.s_addr =3D=3D address)
-				ret =3D -EALREADY;
-			else
-				ret =3D 0;
-		} else if (address) {
-			/* No address in config, but interface has one set */
-			addr =3D l_strdup(inet_ntoa(ia));
-			ret =3D -EALREADY;
-		} else
-			goto free_addr;
+	if (addr_str_list) {
+		uint32_t new_addr;
+		int r;
 =

-		/* Set the remaining DHCP options in config file */
-		if (!dhcp_load_settings(ap, settings)) {
-			ret =3D -EINVAL;
-			goto free_addr;
-		}
+		if (netmask_str) {
+			uint32_t netmask;
 =

-		if (!l_dhcp_server_set_ip_address(ap->server, addr)) {
-			ret =3D -EINVAL;
-			goto free_addr;
-		}
+			if (inet_pton(AF_INET, netmask_str, &if_netmask) < 0) {
+				l_error("Can't parse the profile "
+					"[IPv4].Netmask setting");
+				goto done;
+			}
 =

-		ap->own_ip =3D l_strdup(addr);
+			netmask =3D if_netmask.s_addr;
+			prefix =3D __builtin_popcountl(netmask);
+			if ((ntohl(netmask) !=3D
+					util_netmask_from_prefix(prefix))) {
+				l_error("Invalid netmask %s", netmask_str);
+				goto done;
+			}
 =

-free_addr:
-		l_free(addr);
+			if (prefix > 30 || prefix < 8) {
+				l_error("Netmasks between 8 and 30 bits "
+					"are allowed");
+				goto done;
+			}
+		} else
+			prefix =3D AP_DEFAULT_IPV4_PREFIX_LEN;
 =

-		return ret;
-	} else if (address) {
-		/* No config file and address is already set */
-		ap->own_ip =3D l_strdup(inet_ntoa(ia));
-
-		return -EALREADY;
-	} else if (pool.used) {
-		/* No config file, no address set. Use IP pool */
-		ap->own_ip =3D ip_pool_get();
-		if (!ap->own_ip) {
-			l_error("No more IP's in pool, cannot start AP on %u",
-					ifindex);
-			return -EEXIST;
+		r =3D ap_select_addr((const char **) addr_str_list, prefix,
+					netdev_get_name(ap->netdev), &new_addr);
+		if (r < 0) {
+			ret =3D r;
+			goto done;
 		}
 =

-		ap->use_ip_pool =3D true;
-		ap->ip_prefix =3D pool.prefix;
+		if (new_addr !=3D address) {
+			address =3D new_addr;
+			update =3D true;
+		}
+	}
 =

-		return 0;
+	if_addr.s_addr =3D htonl(address);
+	if (!l_dhcp_server_set_ip_address(ap->server, inet_ntoa(if_addr))) {
+		l_error("l_dhcp_server_set_ip_address failed");
+		goto done;
 	}
 =

-	return -EINVAL;
+	if_netmask.s_addr =3D htonl(util_netmask_from_prefix(prefix));
+	if (!l_dhcp_server_set_netmask(ap->server, inet_ntoa(if_netmask))) {
+		l_error("l_dhcp_server_set_netmask failed");
+		goto done;
+	}
+
+	/* Set the remaining DHCP options in config file */
+	if (profile && !dhcp_load_settings(ap, profile, address, prefix))
+		goto done;
+
+	ap->own_ip =3D l_strdup(inet_ntoa(if_addr));
+	ap->ip_prefix =3D prefix;
+	ret =3D update ? 0 : -EALREADY;
+
+done:
+	l_strv_free(addr_str_list);
+	return ret;
 }
 =

 static int ap_load_profile_and_dhcp(struct ap_state *ap, bool *wait_dhcp)
 {
 	uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
 	char *passphrase;
-	struct l_settings *settings =3D NULL;
+	struct l_settings *profile =3D NULL;
 	int err =3D -EINVAL;
+	const struct l_settings *settings =3D iwd_get_config();
+	bool dhcp_enable;
 =

-	/* No profile or DHCP settings */
-	if (!ap->config->profile && !pool.used)
+	/*
+	 * Enable DHCP server only if [General].EnableNetworkConfiguration is
+	 * true.  With StartProfile, individual profiles can additionally
+	 * disable DHCP by not having the [IPv4] group.
+	 */
+	if (!l_settings_get_bool(settings, "General",
+					"EnableNetworkConfiguration",
+					&dhcp_enable) ||
+			!dhcp_enable) {
+		*wait_dhcp =3D false;
 		return 0;
+	}
 =

 	if (ap->config->profile) {
-		settings =3D l_settings_new();
+		profile =3D l_settings_new();
 =

-		if (!l_settings_load_from_file(settings, ap->config->profile))
+		if (!l_settings_load_from_file(profile, ap->config->profile))
 			goto cleanup;
 =

-		passphrase =3D l_settings_get_string(settings, "Security",
+		passphrase =3D l_settings_get_string(profile, "Security",
 							"Passphrase");
 		if (passphrase) {
 			if (strlen(passphrase) > 63) {
@@ -2585,14 +2755,14 @@ static int ap_load_profile_and_dhcp(struct ap_state=
 *ap, bool *wait_dhcp)
 			l_free(passphrase);
 		}
 =

-		if (!l_settings_has_group(settings, "IPv4")) {
+		if (!l_settings_has_group(profile, "IPv4")) {
 			*wait_dhcp =3D false;
 			err =3D 0;
 			goto cleanup;
 		}
 	}
 =

-	err =3D ap_setup_dhcp(ap, settings);
+	err =3D ap_setup_dhcp(ap, profile, settings);
 	if (err =3D=3D 0) {
 		/* Address change required */
 		ap->rtnl_add_cmd =3D l_rtnl_ifaddr4_add(rtnl, ifindex,
@@ -2617,7 +2787,7 @@ static int ap_load_profile_and_dhcp(struct ap_state *=
ap, bool *wait_dhcp)
 	}
 =

 cleanup:
-	l_settings_free(settings);
+	l_settings_free(profile);
 	return err;
 }
 =

@@ -3315,9 +3485,6 @@ static void ap_netdev_watch(struct netdev *netdev,
 =

 static int ap_init(void)
 {
-	const struct l_settings *settings =3D iwd_get_config();
-	bool dhcp_enable;
-
 	netdev_watch =3D netdev_watch_add(ap_netdev_watch, NULL, NULL);
 =

 	l_dbus_register_interface(dbus_get_bus(), IWD_AP_INTERFACE,
@@ -3326,34 +3493,6 @@ static int ap_init(void)
 			ap_setup_diagnostic_interface,
 			ap_diagnostic_interface_destroy, false);
 =

-	/*
-	 * Reusing [General].EnableNetworkConfiguration as a switch to enable
-	 * DHCP server. If no value is found or it is false do not create a
-	 * DHCP server.
-	 */
-	if (!l_settings_get_bool(settings, "General",
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
-		}
-
-		if (!ip_pool_create(ip_prefix))
-			return -EINVAL;
-	}
-
 	rtnl =3D iwd_get_rtnl();
 =

 	return 0;
@@ -3363,8 +3502,6 @@ static void ap_exit(void)
 {
 	netdev_watch_remove(netdev_watch);
 	l_dbus_unregister_interface(dbus_get_bus(), IWD_AP_INTERFACE);
-
-	ip_pool_destroy();
 }
 =

 IWD_MODULE(ap, ap_init, ap_exit)
-- =

2.27.0

--===============5484125341927373484==--

