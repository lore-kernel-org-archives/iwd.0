Content-Type: multipart/mixed; boundary="===============8623477244462375106=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH] netconfig: Switch to l_netconfig
Date: Thu, 02 Jun 2022 00:59:26 +0200
Message-ID: <20220601225926.459442-1-andrew.zaborowski@intel.com>

--===============8623477244462375106==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch depends on ell patches that are mostly on the ell list but
are blocked by a release or other factors, posting this for early
review.  This leaves IWD's netconfig.h mostly unchanged but the
implementation is switched over to use l_netconfig.

The struct netconfig declaration is nearly empty now but contains the
resolver client, the data received from FILS and some state that mirrors
l_netconfig state and could be replaced by using l_netconfig getters for
the settings which have only setters at this time.

A minor behaviour change is that a netconfig failure, such as DHCP error
or timeout, would now cause station to signal an DBus error and continue
with autoconnect instead of being stuck in netconfig.
---
 Makefile.am     |    6 +-
 src/netconfig.c | 1642 +++++++++++------------------------------------
 src/netconfig.h |    1 +
 src/station.c   |   88 +--
 4 files changed, 413 insertions(+), 1324 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 80377613..bcb313d7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -62,7 +62,8 @@ ell_headers =3D ell/util.h \
 			ell/icmp6.h \
 			ell/dhcp6.h \
 			ell/acd.h \
-			ell/cleanup.h
+			ell/cleanup.h \
+			ell/netconfig.h
 =

 ell_sources =3D ell/private.h \
 			ell/missing.h \
@@ -141,7 +142,8 @@ ell_sources =3D ell/private.h \
 			ell/icmp6-private.h \
 			ell/dhcp6-lease.c \
 			ell/dhcp6-transport.c \
-			ell/acd.c
+			ell/acd.c \
+			ell/netconfig.c
 =

 ell_shared =3D ell/useful.h ell/asn1-private.h
 =

diff --git a/src/netconfig.c b/src/netconfig.c
index 2ab03b90..3c233fa6 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -53,23 +53,16 @@
 #include "src/sysfs.h"
 =

 struct netconfig {
-	uint32_t ifindex;
-	struct l_dhcp_client *dhcp_client;
-	struct l_dhcp6_client *dhcp6_client;
-	uint8_t rtm_protocol;
-	uint8_t rtm_v6_protocol;
-	struct l_rtnl_address *v4_address;
-	struct l_rtnl_address *v6_address;
-	char **dns4_overrides;
-	char **dns6_overrides;
-	char **dns4_list;
-	char **dns6_list;
+	struct l_netconfig *nc;
+	struct netdev *netdev;
+
 	char *mdns;
 	struct ie_fils_ip_addr_response_info *fils_override;
-	char *v4_gateway_str;
-	char *v6_gateway_str;
-	char *v4_domain;
-	char **v6_domains;
+	bool enabled[2];
+	bool static_config[2];
+	bool gateway_overridden[2];
+	bool dns_overridden[2];
+	bool connected[2];
 =

 	const struct l_settings *active_settings;
 =

@@ -77,17 +70,12 @@ struct netconfig {
 	void *user_data;
 =

 	struct resolve *resolve;
-
-	struct l_acd *acd;
-
-	uint32_t addr4_add_cmd_id;
-	uint32_t addr6_add_cmd_id;
-	uint32_t route4_add_gateway_cmd_id;
-	uint32_t route6_add_cmd_id;
 };
 =

+/* 0 for AF_INET, 1 for AF_INET6 */
+#define INDEX_FOR_AF(af)	((af) !=3D AF_INET)
+
 static struct l_netlink *rtnl;
-static struct l_queue *netconfig_list;
 =

 /*
  * Routing priority offset, configurable in main.conf. The route with lower
@@ -105,172 +93,66 @@ static void do_debug(const char *str, void *user_data)
 =

 static void netconfig_free_settings(struct netconfig *netconfig)
 {
-	l_rtnl_address_free(netconfig->v4_address);
-	netconfig->v4_address =3D NULL;
-	l_rtnl_address_free(netconfig->v6_address);
-	netconfig->v6_address =3D NULL;
-
-	l_strfreev(netconfig->dns4_overrides);
-	netconfig->dns4_overrides =3D NULL;
-	l_strfreev(netconfig->dns6_overrides);
-	netconfig->dns6_overrides =3D NULL;
+	netconfig->enabled[0] =3D false;
+	netconfig->enabled[1] =3D false;
+	netconfig->static_config[0] =3D false;
+	netconfig->static_config[1] =3D false;
+	netconfig->gateway_overridden[0] =3D false;
+	netconfig->gateway_overridden[1] =3D false;
+	netconfig->dns_overridden[0] =3D false;
+	netconfig->dns_overridden[1] =3D false;
 =

 	l_free(netconfig->mdns);
 	netconfig->mdns =3D NULL;
+
+	l_netconfig_reset_config(netconfig->nc);
+
+	l_free(l_steal_ptr(netconfig->fils_override));
 }
 =

 static void netconfig_free(void *data)
 {
 	struct netconfig *netconfig =3D data;
 =

-	l_dhcp_client_destroy(netconfig->dhcp_client);
-	l_dhcp6_client_destroy(netconfig->dhcp6_client);
-
+	l_netconfig_destroy(netconfig->nc);
 	l_free(netconfig);
 }
 =

-static struct netconfig *netconfig_find(uint32_t ifindex)
-{
-	const struct l_queue_entry *entry;
-
-	for (entry =3D l_queue_get_entries(netconfig_list); entry;
-							entry =3D entry->next) {
-		struct netconfig *netconfig =3D entry->data;
-
-		if (netconfig->ifindex !=3D ifindex)
-			continue;
-
-		return netconfig;
-	}
-
-	return NULL;
-}
-
-static inline char *netconfig_ipv4_to_string(uint32_t addr)
+static bool netconfig_addr_to_str(uint8_t af, const void *v4_addr,
+					const void *v6_addr, char *out_str,
+					bool *out_is_zero)
 {
-	struct in_addr in_addr =3D { .s_addr =3D addr };
-	char *addr_str =3D l_malloc(INET_ADDRSTRLEN);
+	const void *addr =3D (af =3D=3D AF_INET ? v4_addr : v6_addr);
+	uint8_t bytes =3D (af =3D=3D AF_INET ? 4 : 16);
 =

-	if (L_WARN_ON(unlikely(!inet_ntop(AF_INET, &in_addr, addr_str,
-						INET_ADDRSTRLEN)))) {
-		l_free(addr_str);
-		return NULL;
+	if (l_memeqzero(addr, bytes)) {
+		*out_is_zero =3D true;
+		return true;
 	}
 =

-	return addr_str;
-}
-
-static inline char *netconfig_ipv6_to_string(const uint8_t *addr)
-{
-	struct in6_addr in6_addr;
-	char *addr_str =3D l_malloc(INET6_ADDRSTRLEN);
-
-	memcpy(in6_addr.s6_addr, addr, 16);
+	*out_is_zero =3D false;
 =

-	if (L_WARN_ON(unlikely(!inet_ntop(AF_INET6, &in6_addr, addr_str,
-						INET6_ADDRSTRLEN)))) {
-		l_free(addr_str);
-		return NULL;
-	}
+	if (L_WARN_ON(!inet_ntop(af, addr, out_str, INET6_ADDRSTRLEN)))
+		return false;
 =

-	return addr_str;
+	return true;
 }
 =

 static bool netconfig_use_fils_addr(struct netconfig *netconfig, int af)
 {
-	if ((af =3D=3D AF_INET ? netconfig->rtm_protocol :
-				netconfig->rtm_v6_protocol) !=3D RTPROT_DHCP)
+	if (!netconfig->enabled[INDEX_FOR_AF(af)])
 		return false;
 =

-	if (!netconfig->fils_override)
-		return false;
-
-	if (af =3D=3D AF_INET)
-		return !!netconfig->fils_override->ipv4_addr;
-
-	return !l_memeqzero(netconfig->fils_override->ipv6_addr, 16);
-}
-
-static bool netconfig_use_fils_gateway(struct netconfig *netconfig, int af)
-{
-	if ((af =3D=3D AF_INET ? netconfig->rtm_protocol :
-				netconfig->rtm_v6_protocol) !=3D RTPROT_DHCP)
+	if (netconfig->static_config[INDEX_FOR_AF(af)])
 		return false;
 =

 	if (!netconfig->fils_override)
 		return false;
 =

 	if (af =3D=3D AF_INET)
-		return !!netconfig->fils_override->ipv4_gateway;
-
-	return !l_memeqzero(netconfig->fils_override->ipv6_gateway, 16);
-}
-
-static char **netconfig_get_dns_list(struct netconfig *netconfig, int af,
-					const uint8_t **out_dns_mac)
-{
-	const struct ie_fils_ip_addr_response_info *fils =3D
-		netconfig->fils_override;
-
-	if (af =3D=3D AF_INET) {
-		const struct l_dhcp_lease *lease;
-
-		if (netconfig->dns4_overrides)
-			return l_strv_copy(netconfig->dns4_overrides);
-
-		if (netconfig->rtm_protocol !=3D RTPROT_DHCP)
-			return NULL;
-
-		if (fils && fils->ipv4_dns) {
-			char **dns_list =3D l_new(char *, 2);
-
-			if (!l_memeqzero(fils->ipv4_dns_mac, 6) &&
-					out_dns_mac &&
-					util_ip_subnet_match(
-							fils->ipv4_prefix_len,
-							&fils->ipv4_addr,
-							&fils->ipv4_dns))
-				*out_dns_mac =3D fils->ipv4_dns_mac;
-
-			dns_list[0] =3D netconfig_ipv4_to_string(fils->ipv4_dns);
-			return dns_list;
-		}
-
-		lease =3D l_dhcp_client_get_lease(netconfig->dhcp_client);
-		if (!lease)
-			return NULL;
-
-		return l_dhcp_lease_get_dns(lease);
-	} else {
-		const struct l_dhcp6_lease *lease;
-
-		if (netconfig->dns6_overrides)
-			return l_strv_copy(netconfig->dns6_overrides);
-
-		if (netconfig->rtm_v6_protocol !=3D RTPROT_DHCP)
-			return NULL;
-
-		if (fils && !l_memeqzero(fils->ipv6_dns, 16)) {
-			char **dns_list =3D l_new(char *, 2);
-
-			if (!l_memeqzero(fils->ipv6_dns_mac, 6) &&
-					out_dns_mac &&
-					util_ip_subnet_match(
-							fils->ipv6_prefix_len,
-							fils->ipv6_addr,
-							fils->ipv6_dns))
-				*out_dns_mac =3D fils->ipv6_dns_mac;
-
-			dns_list[0] =3D netconfig_ipv6_to_string(fils->ipv6_dns);
-			return dns_list;
-		}
-
-		lease =3D l_dhcp6_client_get_lease(netconfig->dhcp6_client);
-		if (!lease)
-			return NULL;
+		return !!netconfig->fils_override->ipv4_addr;
 =

-		return l_dhcp6_lease_get_dns(lease);
-	}
+	return !l_memeqzero(netconfig->fils_override->ipv6_addr, 16);
 }
 =

 static void netconfig_set_neighbor_entry_cb(int error,
@@ -282,144 +164,22 @@ static void netconfig_set_neighbor_entry_cb(int erro=
r,
 			strerror(-error), error);
 }
 =

-static void netconfig_set_dns(struct netconfig *netconfig)
+static void netconfig_dns_list_update(struct netconfig *netconfig)
 {
-	if (!netconfig->dns4_list && !netconfig->dns6_list)
-		return;
+	_auto_(l_strv_free) char **dns_list =3D
+		l_netconfig_get_dns_list(netconfig->nc);
 =

-	if (netconfig->dns4_list && netconfig->dns6_list) {
-		unsigned int n_entries4 =3D l_strv_length(netconfig->dns4_list);
-		unsigned int n_entries6 =3D l_strv_length(netconfig->dns6_list);
-		char **dns_list =3D l_malloc(sizeof(char *) *
-					(n_entries4 + n_entries6 + 1));
-
-		memcpy(dns_list, netconfig->dns4_list,
-			sizeof(char *) * n_entries4);
-		memcpy(dns_list + n_entries4, netconfig->dns6_list,
-			sizeof(char *) * (n_entries6 + 1));
+	if (netconfig->resolve && dns_list)
 		resolve_set_dns(netconfig->resolve, dns_list);
-		l_free(dns_list);
-		return;
-	}
-
-	resolve_set_dns(netconfig->resolve,
-			netconfig->dns4_list ?: netconfig->dns6_list);
-}
-
-static bool netconfig_dns_list_update(struct netconfig *netconfig, uint8_t=
 af)
-{
-	const uint8_t *fils_dns_mac =3D NULL;
-	char ***dns_list_ptr =3D af =3D=3D AF_INET ?
-		&netconfig->dns4_list : &netconfig->dns6_list;
-	char **new_dns_list =3D netconfig_get_dns_list(netconfig, af,
-							&fils_dns_mac);
-
-	if (l_strv_eq(*dns_list_ptr, new_dns_list)) {
-		l_strv_free(new_dns_list);
-		return false;
-	}
-
-	l_strv_free(*dns_list_ptr);
-	*dns_list_ptr =3D new_dns_list;
-
-	if (fils_dns_mac) {
-		const struct ie_fils_ip_addr_response_info *fils =3D
-			netconfig->fils_override;
-		const void *dns_ip =3D af =3D=3D AF_INET ?
-			(const void *) &fils->ipv4_dns :
-			(const void *) &fils->ipv6_dns;
-
-		if (!l_rtnl_neighbor_set_hwaddr(rtnl, netconfig->ifindex, af,
-						dns_ip, fils_dns_mac, 6,
-						netconfig_set_neighbor_entry_cb,
-						NULL, NULL))
-			l_debug("l_rtnl_neighbor_set_hwaddr failed");
-	}
-
-	return true;
-}
-
-static void append_domain(char **domains, unsigned int *n_domains,
-				size_t max, char *domain)
-{
-	unsigned int i;
-
-	if (*n_domains =3D=3D max)
-		return;
-
-	for (i =3D 0; i < *n_domains; i++)
-		if (!strcmp(domains[i], domain))
-			return;
-
-	domains[*n_domains] =3D domain;
-	*n_domains +=3D 1;
-}
-
-static void netconfig_set_domains(struct netconfig *netconfig)
-{
-	char *domains[31];
-	unsigned int n_domains =3D 0;
-	char **p;
-
-	memset(domains, 0, sizeof(domains));
-
-	append_domain(domains, &n_domains,
-			L_ARRAY_SIZE(domains) - 1, netconfig->v4_domain);
-
-	for (p =3D netconfig->v6_domains; p && *p; p++)
-		append_domain(domains, &n_domains,
-				L_ARRAY_SIZE(domains) - 1, *p);
-
-	resolve_set_domains(netconfig->resolve, domains);
 }
 =

-static bool netconfig_domains_update(struct netconfig *netconfig, uint8_t =
af)
+static void netconfig_domains_update(struct netconfig *netconfig)
 {
-	bool changed =3D false;
-
-	if (af =3D=3D AF_INET) {
-		/* Allow to override the DHCP domain name with setting entry. */
-		char *v4_domain =3D l_settings_get_string(
-						netconfig->active_settings,
-						"IPv4", "DomainName");
-
-		if (!v4_domain && netconfig->rtm_protocol =3D=3D RTPROT_DHCP) {
-			const struct l_dhcp_lease *lease =3D
-				l_dhcp_client_get_lease(netconfig->dhcp_client);
-
-			if (lease)
-				v4_domain =3D l_dhcp_lease_get_domain_name(lease);
-		}
-
-		if (l_streq0(v4_domain, netconfig->v4_domain))
-			l_free(v4_domain);
-		else {
-			l_free(netconfig->v4_domain);
-			netconfig->v4_domain =3D v4_domain;
-			changed =3D true;
-		}
-	} else {
-		char **v6_domains =3D NULL;
-
-		if (netconfig->rtm_v6_protocol =3D=3D RTPROT_DHCP) {
-			const struct l_dhcp6_lease *lease =3D
-				l_dhcp6_client_get_lease(
-						netconfig->dhcp6_client);
-
-			if (lease)
-				v6_domains =3D l_dhcp6_lease_get_domains(lease);
-		}
+	_auto_(l_strv_free) char **domains =3D
+		l_netconfig_get_domain_names(netconfig->nc);
 =

-		if (l_strv_eq(netconfig->v6_domains, v6_domains))
-			l_strv_free(v6_domains);
-		else {
-			l_strv_free(netconfig->v6_domains);
-			netconfig->v6_domains =3D v6_domains;
-			changed =3D true;
-		}
-	}
-
-	return changed;
+	if (netconfig->resolve && domains)
+		resolve_set_domains(netconfig->resolve, domains);
 }
 =

 static struct l_rtnl_address *netconfig_get_static4_address(
@@ -433,13 +193,22 @@ static struct l_rtnl_address *netconfig_get_static4_a=
ddress(
 	uint32_t prefix_len;
 =

 	ip =3D l_settings_get_string(active_settings, "IPv4", "Address");
-	if (!ip)
+	if (unlikely(!ip)) {
+		l_error("netconfig: Can't load IPv4.Address");
 		return NULL;
+	}
+
+	if (l_settings_has_key(active_settings, "IPv4", "Netmask") &&
+			!(netmask =3D l_settings_get_string(active_settings,
+								"IPv4",
+								"Netmask"))) {
+		l_error("netconfig: Can't load IPv4.Netmask");
+		return NULL;
+	}
 =

-	netmask =3D l_settings_get_string(active_settings, "IPv4", "Netmask");
 	if (netmask) {
 		if (inet_pton(AF_INET, netmask, &in_addr) !=3D 1) {
-			l_error("netconfig: Can't parse IPv4 Netmask");
+			l_error("netconfig: Can't parse IPv4.Netmask");
 			return NULL;
 		}
 =

@@ -447,7 +216,7 @@ static struct l_rtnl_address *netconfig_get_static4_add=
ress(
 =

 		if (ntohl(in_addr.s_addr) !=3D
 				util_netmask_from_prefix(prefix_len)) {
-			l_error("netconfig: Invalid IPv4 Netmask");
+			l_error("netconfig: Invalid IPv4.Netmask");
 			return NULL;
 		}
 	} else
@@ -466,50 +235,9 @@ static struct l_rtnl_address *netconfig_get_static4_ad=
dress(
 		return NULL;
 	}
 =

-	l_rtnl_address_set_noprefixroute(ifaddr, true);
 	return ifaddr;
 }
 =

-static char *netconfig_ipv4_get_gateway(struct netconfig *netconfig,
-					const uint8_t **out_mac)
-{
-	const struct l_dhcp_lease *lease;
-	char *gateway;
-	const struct ie_fils_ip_addr_response_info *fils =3D
-		netconfig->fils_override;
-
-	switch (netconfig->rtm_protocol) {
-	case RTPROT_STATIC:
-		gateway =3D l_settings_get_string(netconfig->active_settings,
-							"IPv4", "Gateway");
-		if (!gateway)
-			gateway =3D l_settings_get_string(
-						netconfig->active_settings,
-						"IPv4", "gateway");
-
-		return gateway;
-
-	case RTPROT_DHCP:
-		if (netconfig_use_fils_gateway(netconfig, AF_INET)) {
-			gateway =3D netconfig_ipv4_to_string(fils->ipv4_gateway);
-
-			if (gateway && out_mac &&
-					!l_memeqzero(fils->ipv4_gateway_mac, 6))
-				*out_mac =3D fils->ipv4_gateway_mac;
-
-			return gateway;
-		}
-
-		lease =3D l_dhcp_client_get_lease(netconfig->dhcp_client);
-		if (!lease)
-			return NULL;
-
-		return l_dhcp_lease_get_gateway(lease);
-	}
-
-	return NULL;
-}
-
 static struct l_rtnl_address *netconfig_get_static6_address(
 				const struct l_settings *active_settings)
 {
@@ -519,8 +247,10 @@ static struct l_rtnl_address *netconfig_get_static6_ad=
dress(
 	uint32_t prefix_len =3D 128;
 =

 	ip =3D l_settings_get_string(active_settings, "IPv6", "Address");
-	if (!ip)
+	if (unlikely(!ip)) {
+		l_error("netconfig: Can't load IPv6.Address");
 		return NULL;
+	}
 =

 	p =3D strrchr(ip, '/');
 	if (!p)
@@ -547,86 +277,22 @@ no_prefix_len:
 	return ret;
 }
 =

-static struct l_rtnl_route *netconfig_get_static6_gateway(
-						struct netconfig *netconfig,
-						char **out_str,
-						const uint8_t **out_mac)
-{
-	L_AUTO_FREE_VAR(char *, gateway);
-	struct l_rtnl_route *ret;
-	const uint8_t *mac =3D NULL;
-
-	gateway =3D l_settings_get_string(netconfig->active_settings,
-						"IPv6", "Gateway");
-	if (!gateway && netconfig_use_fils_gateway(netconfig, AF_INET6)) {
-		gateway =3D netconfig_ipv6_to_string(
-					netconfig->fils_override->ipv6_gateway);
-
-		if (!l_memeqzero(netconfig->fils_override->ipv6_gateway_mac, 6))
-			mac =3D netconfig->fils_override->ipv6_gateway_mac;
-	} else if (!gateway)
-		return NULL;
-
-	ret =3D l_rtnl_route_new_gateway(gateway);
-	if (!ret) {
-		l_error("netconfig: Invalid IPv6 gateway address %s is "
-			"provided in network configuration file.",
-			gateway);
-		return ret;
-	}
-
-	l_rtnl_route_set_priority(ret, ROUTE_PRIORITY_OFFSET);
-	l_rtnl_route_set_protocol(ret, RTPROT_STATIC);
-	*out_str =3D l_steal_ptr(gateway);
-	*out_mac =3D mac;
-
-	return ret;
-}
-
-static struct l_rtnl_address *netconfig_get_dhcp4_address(
-						struct netconfig *netconfig)
-{
-	const struct l_dhcp_lease *lease =3D
-			l_dhcp_client_get_lease(netconfig->dhcp_client);
-	L_AUTO_FREE_VAR(char *, ip) =3D NULL;
-	L_AUTO_FREE_VAR(char *, broadcast) =3D NULL;
-	uint32_t prefix_len;
-	struct l_rtnl_address *ret;
-
-	if (L_WARN_ON(!lease))
-		return NULL;
-
-	ip =3D l_dhcp_lease_get_address(lease);
-	broadcast =3D l_dhcp_lease_get_broadcast(lease);
-
-	prefix_len =3D l_dhcp_lease_get_prefix_length(lease);
-	if (!prefix_len)
-		prefix_len =3D 24;
-
-	ret =3D l_rtnl_address_new(ip, prefix_len);
-	if (!ret)
-		return ret;
-
-	if (broadcast)
-		l_rtnl_address_set_broadcast(ret, broadcast);
-
-	l_rtnl_address_set_noprefixroute(ret, true);
-	return ret;
-}
-
-static void netconfig_gateway_to_arp(struct netconfig *netconfig)
+static void netconfig_dhcp_gateway_to_arp(struct netconfig *netconfig)
 {
+	struct l_dhcp_client *dhcp =3D l_netconfig_get_dhcp_client(netconfig->nc);
 	const struct l_dhcp_lease *lease;
 	_auto_(l_free) char *server_id =3D NULL;
 	_auto_(l_free) char *gw =3D NULL;
 	const uint8_t *server_mac;
 	struct in_addr in_gw;
+	uint32_t ifindex =3D netdev_get_ifindex(netconfig->netdev);
 =

 	/* Can only do this for DHCP in certain network setups */
-	if (netconfig->rtm_protocol !=3D RTPROT_DHCP)
+	if (netconfig->static_config[INDEX_FOR_AF(AF_INET)] ||
+			netconfig->fils_override)
 		return;
 =

-	lease =3D l_dhcp_client_get_lease(netconfig->dhcp_client);
+	lease =3D l_dhcp_client_get_lease(dhcp);
 	if (!lease)
 		return;
 =

@@ -640,844 +306,348 @@ static void netconfig_gateway_to_arp(struct netconf=
ig *netconfig)
 	l_debug("Gateway MAC is known, setting into ARP cache");
 	in_gw.s_addr =3D l_dhcp_lease_get_gateway_u32(lease);
 =

-	if (!l_rtnl_neighbor_set_hwaddr(rtnl, netconfig->ifindex, AF_INET,
+	if (!l_rtnl_neighbor_set_hwaddr(rtnl, ifindex, AF_INET,
 					&in_gw, server_mac, ETH_ALEN,
 					netconfig_set_neighbor_entry_cb, NULL,
 					NULL))
 		l_debug("l_rtnl_neighbor_set_hwaddr failed");
 }
 =

-static void netconfig_ifaddr_added(struct netconfig *netconfig,
-					const struct ifaddrmsg *ifa,
-					uint32_t len)
-{
-	L_AUTO_FREE_VAR(char *, label) =3D NULL;
-	L_AUTO_FREE_VAR(char *, ip) =3D NULL;
-	L_AUTO_FREE_VAR(char *, broadcast) =3D NULL;
-
-	l_rtnl_ifaddr4_extract(ifa, len, &label, &ip, &broadcast);
-	l_debug("%s: ifaddr %s/%u broadcast %s", label,
-					ip, ifa->ifa_prefixlen, broadcast);
-}
-
-static void netconfig_ifaddr_deleted(struct netconfig *netconfig,
-					const struct ifaddrmsg *ifa,
-					uint32_t len)
-{
-	L_AUTO_FREE_VAR(char *, ip);
-
-	l_rtnl_ifaddr4_extract(ifa, len, NULL, &ip, NULL);
-	l_debug("ifaddr %s/%u", ip, ifa->ifa_prefixlen);
-}
-
-static void netconfig_ifaddr_notify(uint16_t type, const void *data,
-						uint32_t len, void *user_data)
+static void netconfig_commit_fils_macs(struct netconfig *netconfig, uint8_=
t af)
 {
-	const struct ifaddrmsg *ifa =3D data;
-	struct netconfig *netconfig;
-	uint32_t bytes;
+	const struct ie_fils_ip_addr_response_info *fils =3D
+		netconfig->fils_override;
+	const void *addr;
+	const void *hwaddr;
+	size_t addr_len =3D (af =3D=3D AF_INET ? 4 : 16);
+	uint32_t ifindex =3D netdev_get_ifindex(netconfig->netdev);
 =

-	netconfig =3D netconfig_find(ifa->ifa_index);
-	if (!netconfig)
-		/* Ignore the interfaces which aren't managed by iwd. */
+	if (!fils)
 		return;
 =

-	bytes =3D len - NLMSG_ALIGN(sizeof(struct ifaddrmsg));
+	/*
+	 * Attempt to use the gateway/DNS MAC addressed received from the AP
+	 * by writing the mapping directly into the netdev's ARP table so as
+	 * to save one data frame roundtrip before first IP connections are
+	 * established.  This is very low-priority but print error messages
+	 * just because they may indicate bigger problems.
+	 */
 =

-	switch (type) {
-	case RTM_NEWADDR:
-		netconfig_ifaddr_added(netconfig, ifa, bytes);
-		break;
-	case RTM_DELADDR:
-		netconfig_ifaddr_deleted(netconfig, ifa, bytes);
-		break;
-	}
-}
+	addr =3D (af =3D=3D AF_INET ? (void *) &fils->ipv4_gateway :
+			(void *) &fils->ipv6_gateway);
+	hwaddr =3D (af =3D=3D AF_INET ?
+			&fils->ipv4_gateway_mac : &fils->ipv6_gateway_mac);
 =

-static void netconfig_ifaddr_cmd_cb(int error, uint16_t type,
-						const void *data, uint32_t len,
-						void *user_data)
-{
-	if (error) {
-		l_error("netconfig: ifaddr command failure. "
-				"Error %d: %s", error, strerror(-error));
-		return;
-	}
+	if (!l_memeqzero(addr, addr_len) && !l_memeqzero(hwaddr, ETH_ALEN) &&
+			unlikely(!l_rtnl_neighbor_set_hwaddr(rtnl, ifindex, af,
+						addr, hwaddr, ETH_ALEN,
+						netconfig_set_neighbor_entry_cb,
+						NULL, NULL)))
+		l_debug("l_rtnl_neighbor_set_hwaddr(%s, gateway) failed",
+			af =3D=3D AF_INET ? "AF_INET" : "AF_INET6");
 =

-	if (type !=3D RTM_NEWADDR)
-		return;
+	addr =3D (af =3D=3D AF_INET ? (void *) &fils->ipv4_dns :
+			(void *) &fils->ipv6_dns);
+	hwaddr =3D (af =3D=3D AF_INET ? &fils->ipv4_dns_mac : &fils->ipv6_dns_mac=
);
 =

-	netconfig_ifaddr_notify(type, data, len, user_data);
+	if (!l_memeqzero(addr, addr_len) && !l_memeqzero(hwaddr, ETH_ALEN) &&
+			unlikely(!l_rtnl_neighbor_set_hwaddr(rtnl, ifindex, af,
+						addr, hwaddr, ETH_ALEN,
+						netconfig_set_neighbor_entry_cb,
+						NULL, NULL)))
+		l_debug("l_rtnl_neighbor_set_hwaddr(%s, DNS) failed",
+			af =3D=3D AF_INET ? "AF_INET" : "AF_INET6");
 }
 =

-static void netconfig_ifaddr_ipv6_added(struct netconfig *netconfig,
-					const struct ifaddrmsg *ifa,
-					uint32_t len)
+static void netconfig_event_handler(struct l_netconfig *nc, uint8_t family,
+					enum l_netconfig_event event,
+					void *user_data)
 {
-	struct in6_addr in6;
-	L_AUTO_FREE_VAR(char *, ip) =3D NULL;
-
-	if (ifa->ifa_flags & IFA_F_TENTATIVE)
-		return;
-
-	l_rtnl_ifaddr6_extract(ifa, len, &ip);
-
-	l_debug("ifindex %u: ifaddr %s/%u", netconfig->ifindex,
-			ip, ifa->ifa_prefixlen);
-
-	if (netconfig->rtm_v6_protocol !=3D RTPROT_DHCP ||
-			netconfig_use_fils_addr(netconfig, AF_INET6))
-		return;
-
-	inet_pton(AF_INET6, ip, &in6);
-	if (!IN6_IS_ADDR_LINKLOCAL(&in6))
-		return;
+	struct netconfig *netconfig =3D user_data;
 =

-	l_dhcp6_client_set_link_local_address(netconfig->dhcp6_client, ip);
+	l_debug("l_netconfig event %d", event);
 =

-	if (l_dhcp6_client_start(netconfig->dhcp6_client))
-		return;
+	l_netconfig_apply_rtnl(nc);
 =

-	l_error("netconfig: Failed to start DHCPv6 client for "
-			"interface %u", netconfig->ifindex);
-}
+	switch (event) {
+	case L_NETCONFIG_EVENT_CONFIGURE:
+		netconfig_dns_list_update(netconfig);
+		netconfig_domains_update(netconfig);
 =

-static void netconfig_ifaddr_ipv6_deleted(struct netconfig *netconfig,
-						const struct ifaddrmsg *ifa,
-						uint32_t len)
-{
-	L_AUTO_FREE_VAR(char *, ip);
+		if (family =3D=3D AF_INET &&
+				!netconfig->static_config[INDEX_FOR_AF(family)])
+			netconfig_dhcp_gateway_to_arp(netconfig);
 =

-	l_rtnl_ifaddr6_extract(ifa, len, &ip);
-	l_debug("ifindex %u: ifaddr %s/%u", netconfig->ifindex,
-			ip, ifa->ifa_prefixlen);
-}
+		if (!netconfig->connected[INDEX_FOR_AF(family)] &&
+				netconfig_use_fils_addr(netconfig, family))
+			netconfig_commit_fils_macs(netconfig, family);
 =

-static void netconfig_ifaddr_ipv6_notify(uint16_t type, const void *data,
-						uint32_t len, void *user_data)
-{
-	const struct ifaddrmsg *ifa =3D data;
-	struct netconfig *netconfig;
-	uint32_t bytes;
-
-	netconfig =3D netconfig_find(ifa->ifa_index);
-	if (!netconfig)
-		/* Ignore the interfaces which aren't managed by iwd. */
-		return;
-
-	bytes =3D len - NLMSG_ALIGN(sizeof(struct ifaddrmsg));
+		if (family =3D=3D AF_INET &&
+				!netconfig->connected[INDEX_FOR_AF(family)] &&
+				netconfig->notify)
+			netconfig->notify(NETCONFIG_EVENT_CONNECTED,
+						netconfig->user_data);
 =

-	switch (type) {
-	case RTM_NEWADDR:
-		netconfig_ifaddr_ipv6_added(netconfig, ifa, bytes);
+		netconfig->connected[INDEX_FOR_AF(family)] =3D true;
 		break;
-	case RTM_DELADDR:
-		netconfig_ifaddr_ipv6_deleted(netconfig, ifa, bytes);
-		break;
-	}
-}
-
-static void netconfig_ifaddr_ipv6_cmd_cb(int error, uint16_t type,
-						const void *data, uint32_t len,
-						void *user_data)
-{
-	if (error) {
-		l_error("netconfig: ifaddr IPv6 command failure. "
-				"Error %d: %s", error, strerror(-error));
-		return;
-	}
-
-	if (type !=3D RTM_NEWADDR)
-		return;
 =

-	netconfig_ifaddr_ipv6_notify(type, data, len, user_data);
-}
-
-static void netconfig_route_generic_cb(int error, uint16_t type,
-					const void *data, uint32_t len,
-					void *user_data)
-{
-	if (error) {
-		l_error("netconfig: Failed to add route. Error %d: %s",
-						error, strerror(-error));
-		return;
-	}
-}
-
-static void netconfig_route_add_cmd_cb(int error, uint16_t type,
-						const void *data, uint32_t len,
-						void *user_data)
-{
-	struct netconfig *netconfig =3D user_data;
-
-	netconfig->route4_add_gateway_cmd_id =3D 0;
-
-	if (error) {
-		l_error("netconfig: Failed to add route. Error %d: %s",
-						error, strerror(-error));
-		return;
-	}
-
-	if (!netconfig->notify)
-		return;
-
-	netconfig->notify(NETCONFIG_EVENT_CONNECTED, netconfig->user_data);
-	netconfig->notify =3D NULL;
-}
+	case L_NETCONFIG_EVENT_UPDATE:
+	case L_NETCONFIG_EVENT_UNCONFIGURE:
+		break;
 =

-static void netconfig_route6_add_cb(int error, uint16_t type,
-					const void *data, uint32_t len,
-					void *user_data)
-{
-	struct netconfig *netconfig =3D user_data;
+	case L_NETCONFIG_EVENT_FAILED:
+		/*
+		 * l_netconfig might have emitted an UNCONFIGURE before this
+		 * but now it tells us it's given up on (re)establishing the
+		 * IP setup.
+		 */
+		if (family =3D=3D AF_INET && netconfig->notify)
+			netconfig->notify(NETCONFIG_EVENT_FAILED,
+						netconfig->user_data);
 =

-	netconfig->route6_add_cmd_id =3D 0;
+		break;
 =

-	if (error) {
-		l_error("netconfig: Failed to add route. Error %d: %s",
-						error, strerror(-error));
-		return;
+	default:
+		l_error("netconfig: Received unsupported l_netconfig event: %d",
+									event);
 	}
 }
 =

-static bool netconfig_ipv4_subnet_route_install(struct netconfig *netconfi=
g)
+static bool netconfig_load_dns(struct netconfig *netconfig,
+				const struct l_settings *active_settings,
+				const char *group_name, uint8_t family)
 {
-	struct in_addr in_addr;
-	char ip[INET_ADDRSTRLEN];
-	char network[INET_ADDRSTRLEN];
-	unsigned int prefix_len =3D
-		l_rtnl_address_get_prefix_length(netconfig->v4_address);
-
-	if (!l_rtnl_address_get_address(netconfig->v4_address, ip) ||
-			inet_pton(AF_INET, ip, &in_addr) < 1)
-		return false;
+	_auto_(l_strv_free) char **dns_str_list =3D NULL;
 =

-	in_addr.s_addr =3D in_addr.s_addr &
-				htonl(0xFFFFFFFFLU << (32 - prefix_len));
+	if (!l_settings_has_key(active_settings, group_name, "DNS"))
+		return true;
 =

-	if (!inet_ntop(AF_INET, &in_addr, network, INET_ADDRSTRLEN))
+	dns_str_list =3D l_settings_get_string_list(active_settings,
+							group_name, "DNS", ' ');
+	if (unlikely(!dns_str_list)) {
+		l_error("netconfig: Can't load [%s].DNS", group_name);
 		return false;
+	}
 =

-	if (!l_rtnl_route4_add_connected(rtnl, netconfig->ifindex,
-						prefix_len, network, ip,
-						netconfig->rtm_protocol,
-						netconfig_route_generic_cb,
-						netconfig, NULL)) {
-		l_error("netconfig: Failed to add subnet route.");
+	if (unlikely(!l_netconfig_set_dns_override(netconfig->nc, family,
+							dns_str_list))) {
+		l_error("netconfig: l_netconfig_set_dns_override(%s) failed",
+			family =3D=3D AF_INET ? "AF_INET" : "AF_INET6");
 		return false;
 	}
 =

+	netconfig->dns_overridden[INDEX_FOR_AF(family)] =3D true;
 	return true;
 }
 =

-static bool netconfig_ipv4_gateway_route_install(struct netconfig *netconf=
ig)
+static bool netconfig_load_gateway(struct netconfig *netconfig,
+				const struct l_settings *active_settings,
+				const char *group_name, uint8_t family)
 {
-	L_AUTO_FREE_VAR(char *, gateway) =3D NULL;
-	const uint8_t *gateway_mac =3D NULL;
-	struct in_addr in_addr;
-	char ip[INET_ADDRSTRLEN];
-
-	gateway =3D netconfig_ipv4_get_gateway(netconfig, &gateway_mac);
-	if (!gateway) {
-		l_debug("No gateway obtained from %s.",
-				netconfig->rtm_protocol =3D=3D RTPROT_STATIC ?
-				"setting file" : "DHCPv4 lease");
-
-		if (netconfig->notify) {
-			netconfig->notify(NETCONFIG_EVENT_CONNECTED,
-						netconfig->user_data);
-			netconfig->notify =3D NULL;
-		}
+	_auto_(l_free) char *gateway_str =3D NULL;
 =

+	if (!l_settings_has_key(active_settings, group_name, "Gateway"))
 		return true;
-	}
 =

-	if (!l_rtnl_address_get_address(netconfig->v4_address, ip) ||
-			inet_pton(AF_INET, ip, &in_addr) < 1)
+	gateway_str =3D l_settings_get_string(active_settings, group_name,
+						"Gateway");
+	if (unlikely(!gateway_str)) {
+		l_error("netconfig: Can't load [%s].Gateway", group_name);
 		return false;
+	}
 =

-	netconfig->route4_add_gateway_cmd_id =3D
-		l_rtnl_route4_add_gateway(rtnl, netconfig->ifindex, gateway, ip,
-						ROUTE_PRIORITY_OFFSET,
-						netconfig->rtm_protocol,
-						netconfig_route_add_cmd_cb,
-						netconfig, NULL);
-	if (!netconfig->route4_add_gateway_cmd_id) {
-		l_error("netconfig: Failed to add route for: %s gateway.",
-								gateway);
-
+	if (unlikely(!l_netconfig_set_gateway_override(netconfig->nc, family,
+							gateway_str))) {
+		l_error("netconfig: l_netconfig_set_gateway_override(%s) "
+			"failed", family =3D=3D AF_INET ? "AF_INET" : "AF_INET6");
 		return false;
 	}
 =

-	/*
-	 * Attempt to use the gateway MAC address received from the AP by
-	 * writing the mapping directly into the netdev's ARP table so as
-	 * to save one data frame roundtrip before first IP connections
-	 * are established.  This is very low-priority but print error
-	 * messages just because they may indicate bigger problems.
-	 */
-	if (gateway_mac && !l_rtnl_neighbor_set_hwaddr(rtnl, netconfig->ifindex,
-					AF_INET,
-					&netconfig->fils_override->ipv4_gateway,
-					gateway_mac, 6,
-					netconfig_set_neighbor_entry_cb, NULL,
-					NULL))
-		l_debug("l_rtnl_neighbor_set_hwaddr failed");
-
+	netconfig->gateway_overridden[INDEX_FOR_AF(family)] =3D true;
 	return true;
 }
 =

-static void netconfig_ipv4_ifaddr_add_cmd_cb(int error, uint16_t type,
-						const void *data, uint32_t len,
-						void *user_data)
-{
-	struct netconfig *netconfig =3D user_data;
-
-	netconfig->addr4_add_cmd_id =3D 0;
-
-	if (error && error !=3D -EEXIST) {
-		l_error("netconfig: Failed to add IP address. "
-				"Error %d: %s", error, strerror(-error));
-		return;
-	}
-
-	netconfig_gateway_to_arp(netconfig);
-
-	if (!netconfig_ipv4_subnet_route_install(netconfig) ||
-			!netconfig_ipv4_gateway_route_install(netconfig))
-		return;
-
-	netconfig_set_dns(netconfig);
-	netconfig_set_domains(netconfig);
-}
-
-static void netconfig_ipv6_ifaddr_add_cmd_cb(int error, uint16_t type,
-						const void *data, uint32_t len,
-						void *user_data)
-{
-	struct netconfig *netconfig =3D user_data;
-	struct l_rtnl_route *gateway;
-	const uint8_t *gateway_mac;
-
-	netconfig->addr6_add_cmd_id =3D 0;
-
-	if (error && error !=3D -EEXIST) {
-		l_error("netconfig: Failed to add IPv6 address. "
-				"Error %d: %s", error, strerror(-error));
-		return;
-	}
-
-	gateway =3D netconfig_get_static6_gateway(netconfig,
-						&netconfig->v6_gateway_str,
-						&gateway_mac);
-	if (gateway) {
-		netconfig->route6_add_cmd_id =3D l_rtnl_route_add(rtnl,
-							netconfig->ifindex,
-							gateway,
-							netconfig_route6_add_cb,
-							netconfig, NULL);
-		L_WARN_ON(unlikely(!netconfig->route6_add_cmd_id));
-		l_rtnl_route_free(gateway);
-
-		if (gateway_mac && !l_rtnl_neighbor_set_hwaddr(rtnl,
-					netconfig->ifindex, AF_INET6,
-					netconfig->fils_override->ipv6_gateway,
-					gateway_mac, 6,
-					netconfig_set_neighbor_entry_cb, NULL,
-					NULL))
-			l_debug("l_rtnl_neighbor_set_hwaddr failed");
-	}
-
-	netconfig_set_dns(netconfig);
-	netconfig_set_domains(netconfig);
-}
-
-static void netconfig_ifaddr_del_cmd_cb(int error, uint16_t type,
-						const void *data, uint32_t len,
-						void *user_data)
-{
-	if (error =3D=3D -ENODEV)
-		/* The device is unplugged, we are done. */
-		return;
-
-	if (!error)
-		/*
-		 * The kernel removes all of the routes associated with the
-		 * deleted IP on its own. There is no need to explicitly remove
-		 * them.
-		 */
-		return;
-
-	l_error("netconfig: Failed to delete IP address. "
-				"Error %d: %s", error, strerror(-error));
-}
-
-static void netconfig_ipv4_dhcp_event_handler(struct l_dhcp_client *client,
-						enum l_dhcp_client_event event,
-						void *userdata)
+bool netconfig_load_settings(struct netconfig *netconfig,
+				const struct l_settings *active_settings)
 {
-	struct netconfig *netconfig =3D userdata;
+	bool send_hostname =3D false;
+	char hostname[HOST_NAME_MAX + 1];
+	_auto_(l_free) char *mdns =3D NULL;
 =

-	l_debug("DHCPv4 event %d", event);
+	l_netconfig_reset_config(netconfig->nc);
 =

-	switch (event) {
-	case L_DHCP_CLIENT_EVENT_IP_CHANGED:
-		L_WARN_ON(!l_rtnl_ifaddr_delete(rtnl, netconfig->ifindex,
-					netconfig->v4_address,
-					netconfig_ifaddr_del_cmd_cb,
-					netconfig, NULL));
-		/* Fall through. */
-	case L_DHCP_CLIENT_EVENT_LEASE_OBTAINED:
-	{
-		char *gateway_str;
-		struct l_rtnl_address *address;
-
-		gateway_str =3D netconfig_ipv4_get_gateway(netconfig, NULL);
-		if (l_streq0(netconfig->v4_gateway_str, gateway_str))
-			l_free(gateway_str);
-		else {
-			l_free(netconfig->v4_gateway_str);
-			netconfig->v4_gateway_str =3D gateway_str;
-		}
+	if (l_settings_has_key(active_settings, "IPv4", "Address")) {
+		_auto_(l_rtnl_address_free) struct l_rtnl_address *addr =3D
+			netconfig_get_static4_address(active_settings);
 =

-		address =3D netconfig_get_dhcp4_address(netconfig);
-		l_rtnl_address_free(netconfig->v4_address);
-		netconfig->v4_address =3D address;
+		if (unlikely(!addr))
+			goto error;
 =

-		if (!netconfig->v4_address) {
-			l_error("netconfig: Failed to obtain IP addresses from "
-							"DHCPv4 lease.");
-			return;
+		if (!l_netconfig_set_static_addr(netconfig->nc, AF_INET,
+							addr)) {
+			l_error("netconfig: l_netconfig_set_static_addr("
+				"AF_INET) failed");
+			goto error;
 		}
 =

-		netconfig_dns_list_update(netconfig, AF_INET);
-		netconfig_domains_update(netconfig, AF_INET);
-
-		L_WARN_ON(!(netconfig->addr4_add_cmd_id =3D
-				l_rtnl_ifaddr_add(rtnl, netconfig->ifindex,
-					netconfig->v4_address,
-					netconfig_ipv4_ifaddr_add_cmd_cb,
-					netconfig, NULL)));
-		break;
+		netconfig->static_config[INDEX_FOR_AF(AF_INET)] =3D true;
 	}
-	case L_DHCP_CLIENT_EVENT_LEASE_RENEWED:
-		break;
-	case L_DHCP_CLIENT_EVENT_LEASE_EXPIRED:
-		L_WARN_ON(!l_rtnl_ifaddr_delete(rtnl, netconfig->ifindex,
-					netconfig->v4_address,
-					netconfig_ifaddr_del_cmd_cb,
-					netconfig, NULL));
-		l_rtnl_address_free(netconfig->v4_address);
-		netconfig->v4_address =3D NULL;
-		l_free(l_steal_ptr(netconfig->v4_gateway_str));
-
-		/* Fall through. */
-	case L_DHCP_CLIENT_EVENT_NO_LEASE:
-		/*
-		 * The requested address is no longer available, try to restart
-		 * the client.
-		 */
-		if (!l_dhcp_client_start(client))
-			l_error("netconfig: Failed to re-start DHCPv4 client "
-					"for interface %u", netconfig->ifindex);
 =

-		break;
-	default:
-		l_error("netconfig: Received unsupported DHCPv4 event: %d",
-									event);
-	}
-}
+	if (l_settings_has_key(active_settings, "IPv6", "Address")) {
+		_auto_(l_rtnl_address_free) struct l_rtnl_address *addr =3D
+			netconfig_get_static6_address(active_settings);
 =

-static void netconfig_dhcp6_event_handler(struct l_dhcp6_client *client,
-						enum l_dhcp6_client_event event,
-						void *userdata)
-{
-	struct netconfig *netconfig =3D userdata;
+		if (unlikely(!addr))
+			goto error;
 =

-	switch (event) {
-	case L_DHCP6_CLIENT_EVENT_IP_CHANGED:
-	case L_DHCP6_CLIENT_EVENT_LEASE_OBTAINED:
-	case L_DHCP6_CLIENT_EVENT_LEASE_RENEWED:
-	{
-		const struct l_dhcp6_lease *lease =3D
-			l_dhcp6_client_get_lease(netconfig->dhcp6_client);
-		_auto_(l_free) char *addr_str =3D
-			l_dhcp6_lease_get_address(lease);
-		struct l_rtnl_address *address;
-		struct l_icmp6_client *icmp6 =3D
-			l_dhcp6_client_get_icmp6(netconfig->dhcp6_client);
-		const struct l_icmp6_router *router =3D
-			l_icmp6_client_get_router(icmp6);
-		char *gateway_str =3D l_icmp6_router_get_address(router);
-
-		if (l_streq0(netconfig->v6_gateway_str, gateway_str))
-			l_free(gateway_str);
-		else {
-			l_free(netconfig->v6_gateway_str);
-			netconfig->v6_gateway_str =3D gateway_str;
+		if (!l_netconfig_set_static_addr(netconfig->nc, AF_INET6,
+							addr)) {
+			l_error("netconfig: l_netconfig_set_static_addr("
+				"AF_INET6) failed");
+			goto error;
 		}
 =

-		address =3D l_rtnl_address_new(addr_str,
-					l_dhcp6_lease_get_prefix_length(lease));
-		l_rtnl_address_free(netconfig->v6_address);
-		netconfig->v6_address =3D address;
-
-		netconfig_dns_list_update(netconfig, AF_INET6);
-		netconfig_domains_update(netconfig, AF_INET6);
-		netconfig_set_dns(netconfig);
-		netconfig_set_domains(netconfig);
-		break;
-	}
-	case L_DHCP6_CLIENT_EVENT_LEASE_EXPIRED:
-		l_debug("Lease for interface %u expired", netconfig->ifindex);
-		netconfig_dns_list_update(netconfig, AF_INET6);
-		netconfig_domains_update(netconfig, AF_INET6);
-		netconfig_set_dns(netconfig);
-		netconfig_set_domains(netconfig);
-		l_rtnl_address_free(netconfig->v6_address);
-		netconfig->v6_address =3D NULL;
-		l_free(l_steal_ptr(netconfig->v6_gateway_str));
-
-		/* Fall through */
-	case L_DHCP6_CLIENT_EVENT_NO_LEASE:
-		if (!l_dhcp6_client_start(netconfig->dhcp6_client))
-			l_error("netconfig: Failed to re-start DHCPv6 client "
-					"for interface %u", netconfig->ifindex);
-		break;
+		netconfig->static_config[INDEX_FOR_AF(AF_INET6)] =3D true;
 	}
-}
 =

-static void netconfig_remove_v4_address(struct netconfig *netconfig)
-{
-	if (!netconfig->v4_address)
-		return;
-
-	L_WARN_ON(!l_rtnl_ifaddr_delete(rtnl, netconfig->ifindex,
-					netconfig->v4_address,
-					netconfig_ifaddr_del_cmd_cb,
-					netconfig, NULL));
-	l_rtnl_address_free(netconfig->v4_address);
-	netconfig->v4_address =3D NULL;
-}
-
-static void netconfig_reset_v4(struct netconfig *netconfig)
-{
-	if (netconfig->rtm_protocol) {
-		netconfig_remove_v4_address(netconfig);
-
-		l_strv_free(l_steal_ptr(netconfig->dns4_overrides));
-		l_strv_free(l_steal_ptr(netconfig->dns4_list));
-
-		l_dhcp_client_stop(netconfig->dhcp_client);
-		netconfig->rtm_protocol =3D 0;
+	if (!netconfig_load_gateway(netconfig, active_settings,
+					"IPv4", AF_INET) ||
+			!netconfig_load_gateway(netconfig, active_settings,
+						"IPv6", AF_INET6))
+		goto error;
 =

-		l_acd_destroy(netconfig->acd);
-		netconfig->acd =3D NULL;
+	if (!netconfig_load_dns(netconfig, active_settings, "IPv4", AF_INET) ||
+			!netconfig_load_dns(netconfig, active_settings, "IPv6",
+						AF_INET6))
+		goto error;
 =

-		l_free(l_steal_ptr(netconfig->v4_gateway_str));
+	netconfig->enabled[INDEX_FOR_AF(AF_INET)] =3D true;
+	netconfig->enabled[INDEX_FOR_AF(AF_INET6)] =3D ipv6_enabled;
 =

-		l_free(l_steal_ptr(netconfig->v4_domain));
+	if (l_settings_has_key(active_settings, "IPv6", "Enabled") &&
+			!l_settings_get_bool(active_settings, "IPv6", "Enabled",
+				&netconfig->enabled[INDEX_FOR_AF(AF_INET6)])) {
+		l_error("netconfig: Can't load Network.MulticastDNS");
+		goto error;
 	}
-}
 =

-static void netconfig_ipv4_acd_event(enum l_acd_event event, void *user_da=
ta)
-{
-	struct netconfig *netconfig =3D user_data;
-
-	switch (event) {
-	case L_ACD_EVENT_AVAILABLE:
-		L_WARN_ON(!(netconfig->addr4_add_cmd_id =3D
-				l_rtnl_ifaddr_add(rtnl, netconfig->ifindex,
-					netconfig->v4_address,
-					netconfig_ipv4_ifaddr_add_cmd_cb,
-					netconfig, NULL)));
-		return;
-	case L_ACD_EVENT_CONFLICT:
-		/*
-		 * Conflict found, no IP was actually set so just free/unset
-		 * anything we set prior to starting ACD.
-		 */
-		l_error("netconfig: statically configured address conflict!");
-		l_rtnl_address_free(netconfig->v4_address);
-		netconfig->v4_address =3D NULL;
-		netconfig->rtm_protocol =3D 0;
-		break;
-	case L_ACD_EVENT_LOST:
-		/*
-		 * Set IP but lost it some time after. Full (IPv4) reset in this
-		 * case.
-		 */
-		l_error("netconfig: statically configured address was lost");
-		netconfig_remove_v4_address(netconfig);
-		break;
+	if (!l_netconfig_set_family_enabled(netconfig->nc, AF_INET,
+				netconfig->enabled[INDEX_FOR_AF(AF_INET)]) ||
+			!l_netconfig_set_family_enabled(netconfig->nc, AF_INET6,
+				netconfig->enabled[INDEX_FOR_AF(AF_INET6)])) {
+		l_error("netconfig: l_netconfig_set_family_enabled() failed");
+		goto error;
 	}
-}
-
-static bool netconfig_ipv4_select_and_install(struct netconfig *netconfig)
-{
-	struct netdev *netdev =3D netdev_find(netconfig->ifindex);
-	bool set_address =3D (netconfig->rtm_protocol =3D=3D RTPROT_STATIC);
-
-	if (netconfig_use_fils_addr(netconfig, AF_INET)) {
-		L_AUTO_FREE_VAR(char *, addr_str) =3D netconfig_ipv4_to_string(
-					netconfig->fils_override->ipv4_addr);
-		uint8_t prefix_len =3D netconfig->fils_override->ipv4_prefix_len;
-
-		if (unlikely(!addr_str))
-			return false;
-
-		netconfig->v4_address =3D l_rtnl_address_new(addr_str,
-								prefix_len);
-		if (L_WARN_ON(!netconfig->v4_address))
-			return false;
-
-		l_rtnl_address_set_noprefixroute(netconfig->v4_address, true);
-		set_address =3D true;
 =

-		/*
-		 * TODO: If netconfig->fils_override->ipv4_lifetime is set,
-		 * start a timeout to renew the address using FILS IP Address
-		 * Assignment or perhaps just start the DHCP client at that
-		 * time.
-		 */
+	if (l_settings_has_key(active_settings, "IPv4", "SendHostname") &&
+			!l_settings_get_bool(active_settings, "IPv4",
+						"SendHostname",
+						&send_hostname)) {
+		l_error("netconfig: Can't load [IPv4].SendHostname");
+		goto error;
 	}
 =

-	if (set_address) {
-		char ip[INET6_ADDRSTRLEN];
-
-		if (L_WARN_ON(!netconfig->v4_address ||
-					!l_rtnl_address_get_address(
-							netconfig->v4_address,
-							ip)))
-			return false;
-
-		netconfig_dns_list_update(netconfig, AF_INET);
-		netconfig_domains_update(netconfig, AF_INET);
-
-		netconfig->acd =3D l_acd_new(netconfig->ifindex);
-		l_acd_set_event_handler(netconfig->acd,
-					netconfig_ipv4_acd_event, netconfig,
-					NULL);
-		if (getenv("IWD_ACD_DEBUG"))
-			l_acd_set_debug(netconfig->acd, do_debug,
-					"[ACD] ", NULL);
-
-		if (!l_acd_start(netconfig->acd, ip)) {
-			l_error("failed to start ACD, continuing anyways");
-			l_acd_destroy(netconfig->acd);
-			netconfig->acd =3D NULL;
-
-			L_WARN_ON(!(netconfig->addr4_add_cmd_id =3D
-				l_rtnl_ifaddr_add(rtnl, netconfig->ifindex,
-					netconfig->v4_address,
-					netconfig_ipv4_ifaddr_add_cmd_cb,
-					netconfig, NULL)));
-		}
-
-		return true;
+	if (send_hostname && gethostname(hostname, sizeof(hostname)) !=3D 0) {
+		l_warn("netconfig: Unable to get hostname. "
+			"Error %d: %s", errno, strerror(errno));
+		send_hostname =3D false;
 	}
 =

-	l_dhcp_client_set_address(netconfig->dhcp_client, ARPHRD_ETHER,
-					netdev_get_address(netdev), ETH_ALEN);
-
-	if (l_dhcp_client_start(netconfig->dhcp_client))
-		return true;
-
-	l_error("netconfig: Failed to start DHCPv4 client for interface %u",
-							netconfig->ifindex);
-	return false;
-}
-
-static bool netconfig_ipv6_select_and_install(struct netconfig *netconfig)
-{
-	struct netdev *netdev =3D netdev_find(netconfig->ifindex);
-
-	if (netconfig->rtm_v6_protocol =3D=3D RTPROT_UNSPEC) {
-		l_debug("IPV6 configuration disabled");
-		return true;
+	if (send_hostname &&
+			!l_netconfig_set_hostname(netconfig->nc, hostname)) {
+		l_error("netconfig: l_netconfig_set_hostname() failed");
+		goto error;
 	}
 =

-	sysfs_write_ipv6_setting(netdev_get_name(netdev), "disable_ipv6", "0");
-
-	if (netconfig_use_fils_addr(netconfig, AF_INET6)) {
-		uint8_t prefix_len =3D netconfig->fils_override->ipv6_prefix_len;
-		L_AUTO_FREE_VAR(char *, addr_str) =3D netconfig_ipv6_to_string(
-					netconfig->fils_override->ipv6_addr);
-
-		if (unlikely(!addr_str))
-			return false;
-
-		netconfig->v6_address =3D l_rtnl_address_new(addr_str,
-								prefix_len);
-		if (L_WARN_ON(unlikely(!netconfig->v6_address)))
-			return false;
-
-		l_rtnl_address_set_noprefixroute(netconfig->v6_address, true);
-
-		/*
-		 * TODO: If netconfig->fils_override->ipv6_lifetime is set,
-		 * start a timeout to renew the address using FILS IP Address
-		 * Assignment or perhaps just start the DHCP client at that
-		 * time.
-		 */
+	if (l_settings_has_key(active_settings, "Network", "MulticastDNS") &&
+			!(mdns =3D l_settings_get_string(active_settings,
+							"Network",
+							"MulticastDNS"))) {
+		l_error("netconfig: Can't load Network.MulticastDNS");
+		goto error;
 	}
 =

-	if (netconfig->v6_address) {
-		netconfig_dns_list_update(netconfig, AF_INET6);
-
-		L_WARN_ON(!(netconfig->addr6_add_cmd_id =3D
-			l_rtnl_ifaddr_add(rtnl, netconfig->ifindex,
-					netconfig->v6_address,
-					netconfig_ipv6_ifaddr_add_cmd_cb,
-					netconfig, NULL)));
-		return true;
-	}
+	if (!l_netconfig_check_config(netconfig->nc))
+		goto error;
 =

-	/* DHCPv6 or RA, update MAC */
-	l_dhcp6_client_set_address(netconfig->dhcp6_client, ARPHRD_ETHER,
-					netdev_get_address(netdev), ETH_ALEN);
+	netconfig_free_settings(netconfig);
 =

+	netconfig->active_settings =3D active_settings;
+	netconfig->mdns =3D l_steal_ptr(mdns);
 	return true;
+error:
+	l_netconfig_reset_config(netconfig->nc);
+	return false;
 }
 =

-static int validate_dns_list(int family, char **dns_list)
+static bool netconfig_load_fils_settings(struct netconfig *netconfig,
+						uint8_t af)
 {
-	unsigned int n_valid =3D 0;
-	struct in_addr in_addr;
-	struct in6_addr in6_addr;
-	char **p;
-
-	for (p =3D dns_list; *p; p++) {
-		int r;
-
-		if (family =3D=3D AF_INET)
-			r =3D inet_pton(AF_INET, *p, &in_addr);
-		else if (family =3D=3D AF_INET6)
-			r =3D inet_pton(AF_INET6, *p, &in6_addr);
-		else
-			r =3D -EAFNOSUPPORT;
-
-		if (r > 0) {
-			n_valid +=3D 1;
-			continue;
-		}
+	struct ie_fils_ip_addr_response_info *fils =3D netconfig->fils_override;
+	char addr_str[INET6_ADDRSTRLEN];
+	char gw_addr_str[INET6_ADDRSTRLEN];
+	char dns_addr_str[INET6_ADDRSTRLEN];
+	_auto_(l_rtnl_address_free) struct l_rtnl_address *rtnl_addr =3D NULL;
+	bool is_zero =3D false;
+	uint8_t prefix_len;
 =

-		l_error("netconfig: Invalid DNS address '%s'.", *p);
-		return -EINVAL;
-	}
+	if (!netconfig_addr_to_str(af, &fils->ipv4_addr, &fils->ipv6_addr,
+					addr_str, &is_zero) || is_zero)
+		return is_zero;
 =

-	return n_valid;
-}
+	prefix_len =3D (af =3D=3D AF_INET ? fils->ipv4_prefix_len :
+			fils->ipv6_prefix_len);
 =

-bool netconfig_load_settings(struct netconfig *netconfig,
-				const struct l_settings *active_settings)
-{
-	_auto_(l_free) char *mdns =3D NULL;
-	bool send_hostname;
-	bool v6_enabled;
-	char hostname[HOST_NAME_MAX + 1];
-	_auto_(l_strv_free) char **dns4_overrides =3D NULL;
-	_auto_(l_strv_free) char **dns6_overrides =3D NULL;
-	_auto_(l_rtnl_address_free) struct l_rtnl_address *v4_address =3D NULL;
-	_auto_(l_rtnl_address_free) struct l_rtnl_address *v6_address =3D NULL;
-
-	dns4_overrides =3D l_settings_get_string_list(active_settings,
-							"IPv4", "DNS", ' ');
-	if (dns4_overrides) {
-		int r =3D validate_dns_list(AF_INET, dns4_overrides);
-
-		if (unlikely(r <=3D 0)) {
-			l_strfreev(dns4_overrides);
-			dns4_overrides =3D NULL;
-
-			if (r < 0)
-				return false;
-		}
-
-		if (r =3D=3D 0)
-			l_error("netconfig: Empty IPv4.DNS entry, skipping...");
-	}
-
-	dns6_overrides =3D l_settings_get_string_list(active_settings,
-							"IPv6", "DNS", ' ');
-
-	if (dns6_overrides) {
-		int r =3D validate_dns_list(AF_INET6, dns6_overrides);
-
-		if (unlikely(r <=3D 0)) {
-			l_strfreev(dns6_overrides);
-			dns6_overrides =3D NULL;
-
-			if (r < 0)
-				return false;
-		}
-
-		if (r =3D=3D 0)
-			l_error("netconfig: Empty IPv6.DNS entry, skipping...");
-	}
-
-	if (!l_settings_get_bool(active_settings,
-					"IPv4", "SendHostname", &send_hostname))
-		send_hostname =3D false;
+	if (L_WARN_ON(!(rtnl_addr =3D l_rtnl_address_new(addr_str, prefix_len))))
+		return false;
 =

-	if (send_hostname) {
-		if (gethostname(hostname, sizeof(hostname)) !=3D 0) {
-			l_warn("netconfig: Unable to get hostname. "
-					"Error %d: %s", errno, strerror(errno));
-			send_hostname =3D false;
-		}
-	}
+	if (L_WARN_ON(!l_netconfig_set_static_addr(netconfig->nc, af,
+							rtnl_addr)))
+		return false;
 =

-	mdns =3D l_settings_get_string(active_settings,
-					"Network", "MulticastDNS");
+	/*
+	 * Done with local address, move on to gateway and DNS.
+	 *
+	 * Since load_settings is called early, generally before the actual
+	 * connection setup starts, and load_fils_settings is called after
+	 * 802.11 Authentication & Association, we need to check if either
+	 * the gateway or DNS settings were overridden in load_settings so
+	 * as not to overwrite the user-provided values.  Values received
+	 * with FILS are expected to have the same weight as those from
+	 * DHCP/SLAAC.
+	 *
+	 * TODO: If netconfig->fils_override->ipv{4,6}_lifetime is set,
+	 * start a timeout to renew the address using FILS IP Address
+	 * Assignment or perhaps just start the DHCP client after that
+	 * time.
+	 *
+	 * TODO: validate gateway and/or DNS on local subnet, link-local,
+	 * etc.?
+	 */
 =

-	if (l_settings_has_key(active_settings, "IPv4", "Address")) {
-		v4_address =3D netconfig_get_static4_address(active_settings);
+	if (!netconfig_addr_to_str(af, &fils->ipv4_gateway, &fils->ipv6_gateway,
+					gw_addr_str, &is_zero))
+		return false;
 =

-		if (unlikely(!v4_address)) {
-			l_error("netconfig: Can't parse IPv4 address");
-			return false;
-		}
-	}
+	if (!netconfig->gateway_overridden[INDEX_FOR_AF(af)] && !is_zero &&
+			L_WARN_ON(!l_netconfig_set_gateway_override(
+								netconfig->nc,
+								af,
+								gw_addr_str)))
+		return false;
 =

-	if (!l_settings_get_bool(active_settings, "IPv6",
-					"Enabled", &v6_enabled))
-		v6_enabled =3D ipv6_enabled;
+	if (!netconfig_addr_to_str(af, &fils->ipv4_dns, &fils->ipv6_dns,
+					dns_addr_str, &is_zero))
+		return is_zero;
 =

-	if (l_settings_has_key(active_settings, "IPv6", "Address")) {
-		v6_address =3D netconfig_get_static6_address(active_settings);
+	if (!netconfig->dns_overridden[INDEX_FOR_AF(af)] && !is_zero) {
+		char *dns_list[2] =3D { dns_addr_str, NULL };
 =

-		if (unlikely(!v6_address)) {
-			l_error("netconfig: Can't parse IPv6 address");
+		if (L_WARN_ON(!l_netconfig_set_dns_override(netconfig->nc,
+								af, dns_list)))
 			return false;
-		}
 	}
 =

-	/* No more validation steps for now, commit new values */
-	netconfig->rtm_protocol =3D v4_address ? RTPROT_STATIC : RTPROT_DHCP;
-
-	if (!v6_enabled)
-		netconfig->rtm_v6_protocol =3D RTPROT_UNSPEC;
-	else if (v6_address)
-		netconfig->rtm_v6_protocol =3D RTPROT_STATIC;
-	else
-		netconfig->rtm_v6_protocol =3D RTPROT_DHCP;
-
-	if (send_hostname)
-		l_dhcp_client_set_hostname(netconfig->dhcp_client, hostname);
-
-	netconfig_free_settings(netconfig);
-
-	if (netconfig->rtm_protocol =3D=3D RTPROT_STATIC)
-		netconfig->v4_address =3D l_steal_ptr(v4_address);
-
-	if (netconfig->rtm_v6_protocol =3D=3D RTPROT_STATIC)
-		netconfig->v6_address =3D l_steal_ptr(v6_address);
-
-	netconfig->active_settings =3D active_settings;
-	netconfig->dns4_overrides =3D l_steal_ptr(dns4_overrides);
-	netconfig->dns6_overrides =3D l_steal_ptr(dns6_overrides);
-	netconfig->mdns =3D l_steal_ptr(mdns);
 	return true;
 }
 =

@@ -1487,10 +657,15 @@ bool netconfig_configure(struct netconfig *netconfig,
 	netconfig->notify =3D notify;
 	netconfig->user_data =3D user_data;
 =

-	if (unlikely(!netconfig_ipv4_select_and_install(netconfig)))
+	if (netconfig_use_fils_addr(netconfig, AF_INET) &&
+			!netconfig_load_fils_settings(netconfig, AF_INET))
+		return false;
+
+	if (netconfig_use_fils_addr(netconfig, AF_INET6) &&
+			!netconfig_load_fils_settings(netconfig, AF_INET6))
 		return false;
 =

-	if (unlikely(!netconfig_ipv6_select_and_install(netconfig)))
+	if (unlikely(!l_netconfig_start(netconfig->nc)))
 		return false;
 =

 	resolve_set_mdns(netconfig->resolve, netconfig->mdns);
@@ -1507,14 +682,23 @@ bool netconfig_reconfigure(struct netconfig *netconf=
ig, bool set_arp_gw)
 	 * lost or delayed.  Try to force the gateway into the ARP cache
 	 * to alleviate this
 	 */
-	if (set_arp_gw)
-		netconfig_gateway_to_arp(netconfig);
+	if (set_arp_gw) {
+		netconfig_dhcp_gateway_to_arp(netconfig);
+
+		if (netconfig->connected[INDEX_FOR_AF(AF_INET)] &&
+				netconfig_use_fils_addr(netconfig, AF_INET))
+			netconfig_commit_fils_macs(netconfig, AF_INET);
 =

-	if (netconfig->rtm_protocol =3D=3D RTPROT_DHCP) {
+		if (netconfig->connected[INDEX_FOR_AF(AF_INET6)] &&
+				netconfig_use_fils_addr(netconfig, AF_INET6))
+			netconfig_commit_fils_macs(netconfig, AF_INET6);
+	}
+
+	if (!netconfig->static_config[INDEX_FOR_AF(AF_INET)]) {
 		/* TODO l_dhcp_client sending a DHCP inform request */
 	}
 =

-	if (netconfig->rtm_v6_protocol =3D=3D RTPROT_DHCP) {
+	if (!netconfig->static_config[INDEX_FOR_AF(AF_INET6)]) {
 		/* TODO l_dhcp_v6_client sending a DHCP inform request */
 	}
 =

@@ -1523,64 +707,27 @@ bool netconfig_reconfigure(struct netconfig *netconf=
ig, bool set_arp_gw)
 =

 bool netconfig_reset(struct netconfig *netconfig)
 {
-	struct netdev *netdev =3D netdev_find(netconfig->ifindex);
-
-	if (netconfig->route4_add_gateway_cmd_id) {
-		l_netlink_cancel(rtnl, netconfig->route4_add_gateway_cmd_id);
-		netconfig->route4_add_gateway_cmd_id =3D 0;
-	}
+	l_netconfig_stop(netconfig->nc);
 =

-	if (netconfig->route6_add_cmd_id) {
-		l_netlink_cancel(rtnl, netconfig->route6_add_cmd_id);
-		netconfig->route6_add_cmd_id =3D 0;
-	}
-
-	if (netconfig->addr4_add_cmd_id) {
-		l_netlink_cancel(rtnl, netconfig->addr4_add_cmd_id);
-		netconfig->addr4_add_cmd_id =3D 0;
-	}
+	resolve_revert(netconfig->resolve);
 =

-	if (netconfig->addr6_add_cmd_id) {
-		l_netlink_cancel(rtnl, netconfig->addr6_add_cmd_id);
-		netconfig->addr6_add_cmd_id =3D 0;
-	}
-
-	if (netconfig->rtm_protocol || netconfig->rtm_v6_protocol)
-		resolve_revert(netconfig->resolve);
-
-	netconfig_reset_v4(netconfig);
-
-	if (netconfig->rtm_v6_protocol) {
-		l_rtnl_address_free(netconfig->v6_address);
-		netconfig->v6_address =3D NULL;
-
-		l_strv_free(l_steal_ptr(netconfig->dns6_overrides));
-		l_strv_free(l_steal_ptr(netconfig->dns6_list));
-
-		l_dhcp6_client_stop(netconfig->dhcp6_client);
-		netconfig->rtm_v6_protocol =3D 0;
-
-		sysfs_write_ipv6_setting(netdev_get_name(netdev),
-						"disable_ipv6", "1");
-
-		l_free(l_steal_ptr(netconfig->v6_gateway_str));
-
-		l_strv_free(l_steal_ptr(netconfig->v6_domains));
-	}
-
-	l_free(l_steal_ptr(netconfig->fils_override));
+	netconfig->connected[0] =3D false;
+	netconfig->connected[1] =3D false;
 =

+	netconfig_free_settings(netconfig);
 	return true;
 }
 =

 char *netconfig_get_dhcp_server_ipv4(struct netconfig *netconfig)
 {
+	struct l_dhcp_client *client =3D
+		l_netconfig_get_dhcp_client(netconfig->nc);
 	const struct l_dhcp_lease *lease;
 =

-	if (!netconfig->dhcp_client)
+	if (!client)
 		return NULL;
 =

-	lease =3D l_dhcp_client_get_lease(netconfig->dhcp_client);
+	lease =3D l_dhcp_client_get_lease(client);
 	if (!lease)
 		return NULL;
 =

@@ -1596,15 +743,16 @@ bool netconfig_get_fils_ip_req(struct netconfig *net=
config,
 	 * configuration (usually DHCP).  If we're configured with static
 	 * values return false to mean the IE should not be sent.
 	 */
-	if (netconfig->rtm_protocol !=3D RTPROT_DHCP &&
-			netconfig->rtm_v6_protocol !=3D RTPROT_DHCP)
+	if (netconfig->static_config[0] && netconfig->static_config[1])
 		return false;
 =

 	memset(info, 0, sizeof(*info));
-	info->ipv4 =3D (netconfig->rtm_protocol =3D=3D RTPROT_DHCP);
-	info->ipv6 =3D (netconfig->rtm_v6_protocol =3D=3D RTPROT_DHCP);
-	info->dns =3D (info->ipv4 && !netconfig->dns4_overrides) ||
-		(info->ipv6 && !netconfig->dns6_overrides);
+	info->ipv4 =3D !netconfig->static_config[INDEX_FOR_AF(AF_INET)];
+	info->ipv6 =3D !netconfig->static_config[INDEX_FOR_AF(AF_INET6)];
+	info->dns =3D (info->ipv4 &&
+			!netconfig->dns_overridden[INDEX_FOR_AF(AF_INET)]) ||
+		(info->ipv6 &&
+			!netconfig->dns_overridden[INDEX_FOR_AF(AF_INET)]);
 =

 	return true;
 }
@@ -1620,28 +768,17 @@ struct netconfig *netconfig_new(uint32_t ifindex)
 {
 	struct netdev *netdev =3D netdev_find(ifindex);
 	struct netconfig *netconfig;
-	struct l_icmp6_client *icmp6;
 	const char *debug_level =3D NULL;
 	int dhcp_priority =3D L_LOG_INFO;
+	struct l_dhcp6_client *dhcp6;
 =

-	if (!netconfig_list)
-		return NULL;
-
-	l_debug("Starting netconfig for interface: %d", ifindex);
-
-	netconfig =3D netconfig_find(ifindex);
-	if (netconfig)
-		return netconfig;
+	l_debug("Creating netconfig for interface: %d", ifindex);
 =

 	netconfig =3D l_new(struct netconfig, 1);
-	netconfig->ifindex =3D ifindex;
+	netconfig->nc =3D l_netconfig_new(ifindex);
+	netconfig->netdev =3D netdev;
 	netconfig->resolve =3D resolve_new(ifindex);
 =

-	netconfig->dhcp_client =3D l_dhcp_client_new(ifindex);
-	l_dhcp_client_set_event_handler(netconfig->dhcp_client,
-					netconfig_ipv4_dhcp_event_handler,
-					netconfig, NULL);
-
 	debug_level =3D getenv("IWD_DHCP_DEBUG");
 	if (debug_level !=3D NULL) {
 		if (!strcmp("debug", debug_level))
@@ -1656,42 +793,28 @@ struct netconfig *netconfig_new(uint32_t ifindex)
 			dhcp_priority =3D L_LOG_DEBUG;
 	}
 =

-	l_dhcp_client_set_debug(netconfig->dhcp_client, do_debug,
-					"[DHCPv4] ", NULL, dhcp_priority);
-
-	netconfig->dhcp6_client =3D l_dhcp6_client_new(ifindex);
-	l_dhcp6_client_set_event_handler(netconfig->dhcp6_client,
-						netconfig_dhcp6_event_handler,
-						netconfig, NULL);
-	l_dhcp6_client_set_lla_randomized(netconfig->dhcp6_client, true);
-	l_dhcp6_client_set_nodelay(netconfig->dhcp6_client, true);
-	l_dhcp6_client_set_rtnl(netconfig->dhcp6_client, rtnl);
+	l_netconfig_set_event_handler(netconfig->nc, netconfig_event_handler,
+					netconfig, NULL);
 =

-	if (getenv("IWD_DHCP_DEBUG"))
-		l_dhcp6_client_set_debug(netconfig->dhcp6_client, do_debug,
-							"[DHCPv6] ", NULL);
+	l_dhcp_client_set_debug(l_netconfig_get_dhcp_client(netconfig->nc),
+				do_debug, "[DHCPv4] ", NULL, dhcp_priority);
 =

-	icmp6 =3D l_dhcp6_client_get_icmp6(netconfig->dhcp6_client);
-	l_icmp6_client_set_rtnl(icmp6, rtnl);
-	l_icmp6_client_set_route_priority(icmp6, ROUTE_PRIORITY_OFFSET);
+	dhcp6 =3D l_netconfig_get_dhcp6_client(netconfig->nc);
+	l_dhcp6_client_set_lla_randomized(dhcp6, true);
+	l_dhcp6_client_set_nodelay(dhcp6, true);
 =

-	l_queue_push_tail(netconfig_list, netconfig);
+	if (getenv("IWD_DHCP_DEBUG"))
+		l_dhcp6_client_set_debug(dhcp6, do_debug, "[DHCPv6] ", NULL);
 =

-	sysfs_write_ipv6_setting(netdev_get_name(netdev), "accept_ra", "0");
-	sysfs_write_ipv6_setting(netdev_get_name(netdev), "disable_ipv6", "1");
+	l_netconfig_set_route_priority(netconfig->nc, ROUTE_PRIORITY_OFFSET);
 =

 	return netconfig;
 }
 =

 void netconfig_destroy(struct netconfig *netconfig)
 {
-	if (!netconfig_list)
-		return;
-
 	l_debug("");
 =

-	l_queue_remove(netconfig_list, netconfig);
-
 	netconfig_reset(netconfig);
 	resolve_free(netconfig->resolve);
 	netconfig_free(netconfig);
@@ -1708,43 +831,8 @@ bool netconfig_enabled(void)
 =

 static int netconfig_init(void)
 {
-	uint32_t r;
-
-	if (netconfig_list)
-		return -EALREADY;
-
 	rtnl =3D iwd_get_rtnl();
 =

-	r =3D l_netlink_register(rtnl, RTNLGRP_IPV4_IFADDR,
-					netconfig_ifaddr_notify, NULL, NULL);
-	if (!r) {
-		l_error("netconfig: Failed to register for RTNL link address"
-							" notifications.");
-		goto error;
-	}
-
-	r =3D l_rtnl_ifaddr4_dump(rtnl, netconfig_ifaddr_cmd_cb, NULL, NULL);
-	if (!r) {
-		l_error("netconfig: Failed to get addresses from RTNL link.");
-		goto error;
-	}
-
-	r =3D l_netlink_register(rtnl, RTNLGRP_IPV6_IFADDR,
-				netconfig_ifaddr_ipv6_notify, NULL, NULL);
-	if (!r) {
-		l_error("netconfig: Failed to register for RTNL link IPv6 "
-					"address notifications.");
-		goto error;
-	}
-
-	r =3D l_rtnl_ifaddr6_dump(rtnl, netconfig_ifaddr_ipv6_cmd_cb, NULL,
-									NULL);
-	if (!r) {
-		l_error("netconfig: Failed to get IPv6 addresses from RTNL"
-								" link.");
-		goto error;
-	}
-
 	if (!l_settings_get_uint(iwd_get_config(), "Network",
 							"RoutePriorityOffset",
 							&ROUTE_PRIORITY_OFFSET))
@@ -1755,24 +843,12 @@ static int netconfig_init(void)
 					&ipv6_enabled))
 		ipv6_enabled =3D false;
 =

-	netconfig_list =3D l_queue_new();
-
 	return 0;
-
-error:
-	rtnl =3D NULL;
-
-	return r;
 }
 =

 static void netconfig_exit(void)
 {
-	if (!netconfig_list)
-		return;
-
 	rtnl =3D NULL;
-
-	l_queue_destroy(netconfig_list, netconfig_free);
 }
 =

 IWD_MODULE(netconfig, netconfig_init, netconfig_exit)
diff --git a/src/netconfig.h b/src/netconfig.h
index c9ac6f8f..b42e9cc8 100644
--- a/src/netconfig.h
+++ b/src/netconfig.h
@@ -26,6 +26,7 @@ struct ie_fils_ip_addr_response_info;
 =

 enum netconfig_event {
 	NETCONFIG_EVENT_CONNECTED,
+	NETCONFIG_EVENT_FAILED,
 };
 =

 typedef void (*netconfig_notify_func_t)(enum netconfig_event event,
diff --git a/src/station.c b/src/station.c
index 7c88f266..a2762b7c 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2011,6 +2011,48 @@ delayed_retry:
 	station_roam_retry(station);
 }
 =

+static void station_connect_failed(struct station *station, int error,
+					bool during_eapol)
+{
+	bool continue_autoconnect;
+
+	if (station->connect_pending) {
+		struct l_dbus_message *reply;
+
+		if (error =3D=3D -ECANCELED)
+			reply =3D dbus_error_aborted(station->connect_pending);
+		else
+			reply =3D dbus_error_failed(station->connect_pending);
+
+		dbus_pending_reply(&station->connect_pending, reply);
+	}
+
+	if (error =3D=3D -ECANCELED)
+		return;
+
+	continue_autoconnect =3D station->state =3D=3D STATION_STATE_CONNECTING_A=
UTO;
+
+	if (station->state =3D=3D STATION_STATE_CONNECTING)
+		network_connect_failed(station->connected_network,
+								during_eapol);
+
+	station_reset_connection_state(station);
+	station_enter_state(station, STATION_STATE_DISCONNECTED);
+
+	if (continue_autoconnect) {
+		if (station_autoconnect_next(station) < 0) {
+			l_debug("Nothing left on autoconnect list");
+			station_enter_state(station,
+					STATION_STATE_AUTOCONNECT_FULL);
+		}
+
+		return;
+	}
+
+	if (station->autoconnect)
+		station_enter_state(station, STATION_STATE_AUTOCONNECT_QUICK);
+}
+
 static void station_netconfig_event_handler(enum netconfig_event event,
 							void *user_data)
 {
@@ -2019,7 +2061,9 @@ static void station_netconfig_event_handler(enum netc=
onfig_event event,
 	switch (event) {
 	case NETCONFIG_EVENT_CONNECTED:
 		station_enter_state(station, STATION_STATE_CONNECTED);
-
+		break;
+	case NETCONFIG_EVENT_FAILED:
+		station_connect_failed(station, -EIO, false);
 		break;
 	default:
 		l_error("station: Unsupported netconfig event: %d.", event);
@@ -2899,7 +2943,6 @@ static void station_connect_cb(struct netdev *netdev,=
 enum netdev_result result,
 					void *event_data, void *user_data)
 {
 	struct station *station =3D user_data;
-	bool continue_autoconnect;
 =

 	l_debug("%u, result: %d", netdev_get_ifindex(station->netdev), result);
 =

@@ -2925,43 +2968,10 @@ static void station_connect_cb(struct netdev *netde=
v, enum netdev_result result,
 		break;
 	}
 =

-	if (station->connect_pending) {
-		struct l_dbus_message *reply;
-
-		if (result =3D=3D NETDEV_RESULT_ABORTED)
-			reply =3D dbus_error_aborted(station->connect_pending);
-		else
-			reply =3D dbus_error_failed(station->connect_pending);
-
-		dbus_pending_reply(&station->connect_pending, reply);
-	}
-
-	if (result =3D=3D NETDEV_RESULT_ABORTED)
-		return;
-
-	continue_autoconnect =3D station->state =3D=3D STATION_STATE_CONNECTING_A=
UTO;
-
-	if (station->state =3D=3D STATION_STATE_CONNECTING) {
-		bool during_eapol =3D result =3D=3D NETDEV_RESULT_HANDSHAKE_FAILED;
-		network_connect_failed(station->connected_network,
-								during_eapol);
-	}
-
-	station_reset_connection_state(station);
-	station_enter_state(station, STATION_STATE_DISCONNECTED);
-
-	if (continue_autoconnect) {
-		if (station_autoconnect_next(station) < 0) {
-			l_debug("Nothing left on autoconnect list");
-			station_enter_state(station,
-					STATION_STATE_AUTOCONNECT_FULL);
-		}
-
-		return;
-	}
-
-	if (station->autoconnect)
-		station_enter_state(station, STATION_STATE_AUTOCONNECT_QUICK);
+	station_connect_failed(station,
+				result =3D=3D NETDEV_RESULT_ABORTED ?
+					-ECANCELED : -EIO,
+				result =3D=3D NETDEV_RESULT_HANDSHAKE_FAILED);
 }
 =

 static void station_disconnect_event(struct station *station, void *event_=
data)
-- =

2.34.1

--===============8623477244462375106==--

