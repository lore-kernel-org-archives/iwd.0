Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F20453BF
	for <iwd@lists.linux.dev>; Mon, 29 Aug 2022 17:36:10 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id bq11so11088655wrb.12
        for <iwd@lists.linux.dev>; Mon, 29 Aug 2022 10:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=7KJlcaVekh3vqgKf/5jWY+CJnJzM8CoGb0+3BHE5lhI=;
        b=tU/deJbzcOWcb+dyGMSoqQAJMD0ToBSZVrBU7hZ7alZI+F/SrDIjQ44arHALB7U9IU
         oV5Q2yU5YdKdcm6zSH0lkyQyQAYI3sgJstQCc+NuN/4AeIlZ7BuI35v2JaQ7jVvYHh7B
         Qrmanre1IVMNZ2/m4Z2Rc0gOMYAqMJSdArxfmy4XzISYRG0PWpY+D9sjFv0MAiNkh3Vz
         9TlyZJimEDaMVXy6qDuWXNMotzOAIJ64hA/VLBGNwDEvCCQA40TYKxWxyLtXlIvBiPiL
         yNFjt9VRjGxb2jPHHB9CaqT9Ls1PcGrx7LmUyMjnOATYsUuYrMsjxUhr0fOaNzoLjAbM
         e4KA==
X-Gm-Message-State: ACgBeo3j//rN9bebR8RmktOBVGvYyLsxsa9qBwH4spcx+71Hb66temeJ
	97CXQRq4llCUzDvVIdcdCwAtbjfsCxPlcA==
X-Google-Smtp-Source: AA6agR650qcvQ+wpWaPk5qdLxt3IjpkQbVGMCeL3cu1Hwg+cjEHaCRTKGmfnTLnt27OQRIVKs97kvA==
X-Received: by 2002:a05:6000:1b92:b0:220:7d86:2e30 with SMTP id r18-20020a0560001b9200b002207d862e30mr7167456wru.530.1661794568111;
        Mon, 29 Aug 2022 10:36:08 -0700 (PDT)
Received: from iss.ger.corp.intel.com ([82.213.228.103])
        by smtp.gmail.com with ESMTPSA id q3-20020a1ce903000000b003a61306d79dsm9830551wmc.41.2022.08.29.10.36.07
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 10:36:07 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 02/10] netconfig: Drop dhcp, dhcp6 and acd client instances
Date: Mon, 29 Aug 2022 19:35:53 +0200
Message-Id: <20220829173601.1963953-2-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220829173601.1963953-1-andrew.zaborowski@intel.com>
References: <20220829173601.1963953-1-andrew.zaborowski@intel.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In anticipation of switching to use the l_netconfig API, which
internally handles DHCPv4, DHCPv6, ACD, etc., drop pointers to
instances of l_dhcp_client, l_dhcp6_client and l_acd from struct
netconfig.  Also drop all code used for handling events from these
APIs, including code to commit the received configurations to the
system.  Committing the final settings to the system netdevs is going to
be handled by a new set of utilities in a new file.
---
Note this temporarily leaves IWD network configuration non-functional.
---
 src/netconfig.c | 1199 +----------------------------------------------
 1 file changed, 12 insertions(+), 1187 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 4a70b0ca..ea9846f6 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -54,8 +54,6 @@
 
 struct netconfig {
 	uint32_t ifindex;
-	struct l_dhcp_client *dhcp_client;
-	struct l_dhcp6_client *dhcp6_client;
 	uint8_t rtm_protocol;
 	uint8_t rtm_v6_protocol;
 	struct l_rtnl_address *v4_address;
@@ -77,17 +75,9 @@ struct netconfig {
 	void *user_data;
 
 	struct resolve *resolve;
-
-	struct l_acd *acd;
-
-	uint32_t addr4_add_cmd_id;
-	uint32_t addr6_add_cmd_id;
-	uint32_t route4_add_gateway_cmd_id;
-	uint32_t route6_add_cmd_id;
 };
 
 static struct l_netlink *rtnl;
-static struct l_queue *netconfig_list;
 
 /*
  * Routing priority offset, configurable in main.conf. The route with lower
@@ -123,59 +113,9 @@ static void netconfig_free(void *data)
 {
 	struct netconfig *netconfig = data;
 
-	l_dhcp_client_destroy(netconfig->dhcp_client);
-	l_dhcp6_client_destroy(netconfig->dhcp6_client);
-
 	l_free(netconfig);
 }
 
-static struct netconfig *netconfig_find(uint32_t ifindex)
-{
-	const struct l_queue_entry *entry;
-
-	for (entry = l_queue_get_entries(netconfig_list); entry;
-							entry = entry->next) {
-		struct netconfig *netconfig = entry->data;
-
-		if (netconfig->ifindex != ifindex)
-			continue;
-
-		return netconfig;
-	}
-
-	return NULL;
-}
-
-static inline char *netconfig_ipv4_to_string(uint32_t addr)
-{
-	struct in_addr in_addr = { .s_addr = addr };
-	char *addr_str = l_malloc(INET_ADDRSTRLEN);
-
-	if (L_WARN_ON(unlikely(!inet_ntop(AF_INET, &in_addr, addr_str,
-						INET_ADDRSTRLEN)))) {
-		l_free(addr_str);
-		return NULL;
-	}
-
-	return addr_str;
-}
-
-static inline char *netconfig_ipv6_to_string(const uint8_t *addr)
-{
-	struct in6_addr in6_addr;
-	char *addr_str = l_malloc(INET6_ADDRSTRLEN);
-
-	memcpy(in6_addr.s6_addr, addr, 16);
-
-	if (L_WARN_ON(unlikely(!inet_ntop(AF_INET6, &in6_addr, addr_str,
-						INET6_ADDRSTRLEN)))) {
-		l_free(addr_str);
-		return NULL;
-	}
-
-	return addr_str;
-}
-
 static bool netconfig_use_fils_addr(struct netconfig *netconfig, int af)
 {
 	if ((af == AF_INET ? netconfig->rtm_protocol :
@@ -191,88 +131,6 @@ static bool netconfig_use_fils_addr(struct netconfig *netconfig, int af)
 	return !l_memeqzero(netconfig->fils_override->ipv6_addr, 16);
 }
 
-static bool netconfig_use_fils_gateway(struct netconfig *netconfig, int af)
-{
-	if ((af == AF_INET ? netconfig->rtm_protocol :
-				netconfig->rtm_v6_protocol) != RTPROT_DHCP)
-		return false;
-
-	if (!netconfig->fils_override)
-		return false;
-
-	if (af == AF_INET)
-		return !!netconfig->fils_override->ipv4_gateway;
-
-	return !l_memeqzero(netconfig->fils_override->ipv6_gateway, 16);
-}
-
-static char **netconfig_get_dns_list(struct netconfig *netconfig, int af,
-					const uint8_t **out_dns_mac)
-{
-	const struct ie_fils_ip_addr_response_info *fils =
-		netconfig->fils_override;
-
-	if (af == AF_INET) {
-		const struct l_dhcp_lease *lease;
-
-		if (netconfig->dns4_overrides)
-			return l_strv_copy(netconfig->dns4_overrides);
-
-		if (netconfig->rtm_protocol != RTPROT_DHCP)
-			return NULL;
-
-		if (fils && fils->ipv4_dns) {
-			char **dns_list = l_new(char *, 2);
-
-			if (!l_memeqzero(fils->ipv4_dns_mac, 6) &&
-					out_dns_mac &&
-					util_ip_subnet_match(
-							fils->ipv4_prefix_len,
-							&fils->ipv4_addr,
-							&fils->ipv4_dns))
-				*out_dns_mac = fils->ipv4_dns_mac;
-
-			dns_list[0] = netconfig_ipv4_to_string(fils->ipv4_dns);
-			return dns_list;
-		}
-
-		lease = l_dhcp_client_get_lease(netconfig->dhcp_client);
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
-		if (netconfig->rtm_v6_protocol != RTPROT_DHCP)
-			return NULL;
-
-		if (fils && !l_memeqzero(fils->ipv6_dns, 16)) {
-			char **dns_list = l_new(char *, 2);
-
-			if (!l_memeqzero(fils->ipv6_dns_mac, 6) &&
-					out_dns_mac &&
-					util_ip_subnet_match(
-							fils->ipv6_prefix_len,
-							fils->ipv6_addr,
-							fils->ipv6_dns))
-				*out_dns_mac = fils->ipv6_dns_mac;
-
-			dns_list[0] = netconfig_ipv6_to_string(fils->ipv6_dns);
-			return dns_list;
-		}
-
-		lease = l_dhcp6_client_get_lease(netconfig->dhcp6_client);
-		if (!lease)
-			return NULL;
-
-		return l_dhcp6_lease_get_dns(lease);
-	}
-}
-
 static void netconfig_set_neighbor_entry_cb(int error,
 						uint16_t type, const void *data,
 						uint32_t len, void *user_data)
@@ -282,146 +140,6 @@ static void netconfig_set_neighbor_entry_cb(int error,
 			strerror(-error), error);
 }
 
-static void netconfig_set_dns(struct netconfig *netconfig)
-{
-	if (!netconfig->dns4_list && !netconfig->dns6_list)
-		return;
-
-	if (netconfig->dns4_list && netconfig->dns6_list) {
-		unsigned int n_entries4 = l_strv_length(netconfig->dns4_list);
-		unsigned int n_entries6 = l_strv_length(netconfig->dns6_list);
-		char **dns_list = l_malloc(sizeof(char *) *
-					(n_entries4 + n_entries6 + 1));
-
-		memcpy(dns_list, netconfig->dns4_list,
-			sizeof(char *) * n_entries4);
-		memcpy(dns_list + n_entries4, netconfig->dns6_list,
-			sizeof(char *) * (n_entries6 + 1));
-		resolve_set_dns(netconfig->resolve, dns_list);
-		l_free(dns_list);
-		return;
-	}
-
-	resolve_set_dns(netconfig->resolve,
-			netconfig->dns4_list ?: netconfig->dns6_list);
-}
-
-static bool netconfig_dns_list_update(struct netconfig *netconfig, uint8_t af)
-{
-	const uint8_t *fils_dns_mac = NULL;
-	char ***dns_list_ptr = af == AF_INET ?
-		&netconfig->dns4_list : &netconfig->dns6_list;
-	char **new_dns_list = netconfig_get_dns_list(netconfig, af,
-							&fils_dns_mac);
-
-	if (l_strv_eq(*dns_list_ptr, new_dns_list)) {
-		l_strv_free(new_dns_list);
-		return false;
-	}
-
-	l_strv_free(*dns_list_ptr);
-	*dns_list_ptr = new_dns_list;
-
-	if (fils_dns_mac) {
-		const struct ie_fils_ip_addr_response_info *fils =
-			netconfig->fils_override;
-		const void *dns_ip = af == AF_INET ?
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
-	if (*n_domains == max)
-		return;
-
-	for (i = 0; i < *n_domains; i++)
-		if (!strcmp(domains[i], domain))
-			return;
-
-	domains[*n_domains] = domain;
-	*n_domains += 1;
-}
-
-static void netconfig_set_domains(struct netconfig *netconfig)
-{
-	char *domains[31];
-	unsigned int n_domains = 0;
-	char **p;
-
-	memset(domains, 0, sizeof(domains));
-
-	append_domain(domains, &n_domains,
-			L_ARRAY_SIZE(domains) - 1, netconfig->v4_domain);
-
-	for (p = netconfig->v6_domains; p && *p; p++)
-		append_domain(domains, &n_domains,
-				L_ARRAY_SIZE(domains) - 1, *p);
-
-	resolve_set_domains(netconfig->resolve, domains);
-}
-
-static bool netconfig_domains_update(struct netconfig *netconfig, uint8_t af)
-{
-	bool changed = false;
-
-	if (af == AF_INET) {
-		/* Allow to override the DHCP domain name with setting entry. */
-		char *v4_domain = l_settings_get_string(
-						netconfig->active_settings,
-						"IPv4", "DomainName");
-
-		if (!v4_domain && netconfig->rtm_protocol == RTPROT_DHCP) {
-			const struct l_dhcp_lease *lease =
-				l_dhcp_client_get_lease(netconfig->dhcp_client);
-
-			if (lease)
-				v4_domain = l_dhcp_lease_get_domain_name(lease);
-		}
-
-		if (l_streq0(v4_domain, netconfig->v4_domain))
-			l_free(v4_domain);
-		else {
-			l_free(netconfig->v4_domain);
-			netconfig->v4_domain = v4_domain;
-			changed = true;
-		}
-	} else {
-		char **v6_domains = NULL;
-
-		if (netconfig->rtm_v6_protocol == RTPROT_DHCP) {
-			const struct l_dhcp6_lease *lease =
-				l_dhcp6_client_get_lease(
-						netconfig->dhcp6_client);
-
-			if (lease)
-				v6_domains = l_dhcp6_lease_get_domains(lease);
-		}
-
-		if (l_strv_eq(netconfig->v6_domains, v6_domains))
-			l_strv_free(v6_domains);
-		else {
-			l_strv_free(netconfig->v6_domains);
-			netconfig->v6_domains = v6_domains;
-			changed = true;
-		}
-	}
-
-	return changed;
-}
-
 static struct l_rtnl_address *netconfig_get_static4_address(
 				const struct l_settings *active_settings)
 {
@@ -470,46 +188,6 @@ static struct l_rtnl_address *netconfig_get_static4_address(
 	return ifaddr;
 }
 
-static char *netconfig_ipv4_get_gateway(struct netconfig *netconfig,
-					const uint8_t **out_mac)
-{
-	const struct l_dhcp_lease *lease;
-	char *gateway;
-	const struct ie_fils_ip_addr_response_info *fils =
-		netconfig->fils_override;
-
-	switch (netconfig->rtm_protocol) {
-	case RTPROT_STATIC:
-		gateway = l_settings_get_string(netconfig->active_settings,
-							"IPv4", "Gateway");
-		if (!gateway)
-			gateway = l_settings_get_string(
-						netconfig->active_settings,
-						"IPv4", "gateway");
-
-		return gateway;
-
-	case RTPROT_DHCP:
-		if (netconfig_use_fils_gateway(netconfig, AF_INET)) {
-			gateway = netconfig_ipv4_to_string(fils->ipv4_gateway);
-
-			if (gateway && out_mac &&
-					!l_memeqzero(fils->ipv4_gateway_mac, 6))
-				*out_mac = fils->ipv4_gateway_mac;
-
-			return gateway;
-		}
-
-		lease = l_dhcp_client_get_lease(netconfig->dhcp_client);
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
@@ -549,75 +227,9 @@ no_prefix_len:
 	return ret;
 }
 
-static struct l_rtnl_route *netconfig_get_static6_gateway(
-						struct netconfig *netconfig,
-						char **out_str,
-						const uint8_t **out_mac)
-{
-	L_AUTO_FREE_VAR(char *, gateway);
-	struct l_rtnl_route *ret;
-	const uint8_t *mac = NULL;
-
-	gateway = l_settings_get_string(netconfig->active_settings,
-						"IPv6", "Gateway");
-	if (!gateway && netconfig_use_fils_gateway(netconfig, AF_INET6)) {
-		gateway = netconfig_ipv6_to_string(
-					netconfig->fils_override->ipv6_gateway);
-
-		if (!l_memeqzero(netconfig->fils_override->ipv6_gateway_mac, 6))
-			mac = netconfig->fils_override->ipv6_gateway_mac;
-	} else if (!gateway)
-		return NULL;
-
-	ret = l_rtnl_route_new_gateway(gateway);
-	if (!ret) {
-		l_error("netconfig: Invalid IPv6 gateway address %s is "
-			"provided in network configuration file.",
-			gateway);
-		return ret;
-	}
-
-	l_rtnl_route_set_priority(ret, ROUTE_PRIORITY_OFFSET);
-	l_rtnl_route_set_protocol(ret, RTPROT_STATIC);
-	*out_str = l_steal_ptr(gateway);
-	*out_mac = mac;
-
-	return ret;
-}
-
-static struct l_rtnl_address *netconfig_get_dhcp4_address(
-						struct netconfig *netconfig)
-{
-	const struct l_dhcp_lease *lease =
-			l_dhcp_client_get_lease(netconfig->dhcp_client);
-	L_AUTO_FREE_VAR(char *, ip) = NULL;
-	L_AUTO_FREE_VAR(char *, broadcast) = NULL;
-	uint32_t prefix_len;
-	struct l_rtnl_address *ret;
-
-	if (L_WARN_ON(!lease))
-		return NULL;
-
-	ip = l_dhcp_lease_get_address(lease);
-	broadcast = l_dhcp_lease_get_broadcast(lease);
-
-	prefix_len = l_dhcp_lease_get_prefix_length(lease);
-	if (!prefix_len)
-		prefix_len = 24;
-
-	ret = l_rtnl_address_new(ip, prefix_len);
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
 static void netconfig_gateway_to_arp(struct netconfig *netconfig)
 {
+	struct l_dhcp_client *dhcp = NULL; /* TODO */
 	const struct l_dhcp_lease *lease;
 	_auto_(l_free) char *server_id = NULL;
 	_auto_(l_free) char *gw = NULL;
@@ -628,7 +240,7 @@ static void netconfig_gateway_to_arp(struct netconfig *netconfig)
 	if (netconfig->rtm_protocol != RTPROT_DHCP)
 		return;
 
-	lease = l_dhcp_client_get_lease(netconfig->dhcp_client);
+	lease = l_dhcp_client_get_lease(dhcp);
 	if (!lease)
 		return;
 
@@ -649,515 +261,11 @@ static void netconfig_gateway_to_arp(struct netconfig *netconfig)
 		l_debug("l_rtnl_neighbor_set_hwaddr failed");
 }
 
-static void netconfig_ifaddr_added(struct netconfig *netconfig,
-					const struct ifaddrmsg *ifa,
-					uint32_t len)
-{
-	L_AUTO_FREE_VAR(char *, label) = NULL;
-	L_AUTO_FREE_VAR(char *, ip) = NULL;
-	L_AUTO_FREE_VAR(char *, broadcast) = NULL;
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
-{
-	const struct ifaddrmsg *ifa = data;
-	struct netconfig *netconfig;
-	uint32_t bytes;
-
-	netconfig = netconfig_find(ifa->ifa_index);
-	if (!netconfig)
-		/* Ignore the interfaces which aren't managed by iwd. */
-		return;
-
-	bytes = len - NLMSG_ALIGN(sizeof(struct ifaddrmsg));
-
-	switch (type) {
-	case RTM_NEWADDR:
-		netconfig_ifaddr_added(netconfig, ifa, bytes);
-		break;
-	case RTM_DELADDR:
-		netconfig_ifaddr_deleted(netconfig, ifa, bytes);
-		break;
-	}
-}
-
-static void netconfig_ifaddr_cmd_cb(int error, uint16_t type,
-						const void *data, uint32_t len,
-						void *user_data)
-{
-	if (error) {
-		l_error("netconfig: ifaddr command failure. "
-				"Error %d: %s", error, strerror(-error));
-		return;
-	}
-
-	if (type != RTM_NEWADDR)
-		return;
-
-	netconfig_ifaddr_notify(type, data, len, user_data);
-}
-
-static void netconfig_ifaddr_ipv6_added(struct netconfig *netconfig,
-					const struct ifaddrmsg *ifa,
-					uint32_t len)
-{
-	struct in6_addr in6;
-	L_AUTO_FREE_VAR(char *, ip) = NULL;
-
-	if (ifa->ifa_flags & IFA_F_TENTATIVE)
-		return;
-
-	l_rtnl_ifaddr6_extract(ifa, len, &ip);
-
-	l_debug("ifindex %u: ifaddr %s/%u", netconfig->ifindex,
-			ip, ifa->ifa_prefixlen);
-
-	if (netconfig->rtm_v6_protocol != RTPROT_DHCP ||
-			netconfig_use_fils_addr(netconfig, AF_INET6))
-		return;
-
-	inet_pton(AF_INET6, ip, &in6);
-	if (!IN6_IS_ADDR_LINKLOCAL(&in6))
-		return;
-
-	l_dhcp6_client_set_link_local_address(netconfig->dhcp6_client, ip);
-
-	if (l_dhcp6_client_start(netconfig->dhcp6_client))
-		return;
-
-	l_error("netconfig: Failed to start DHCPv6 client for "
-			"interface %u", netconfig->ifindex);
-}
-
-static void netconfig_ifaddr_ipv6_deleted(struct netconfig *netconfig,
-						const struct ifaddrmsg *ifa,
-						uint32_t len)
-{
-	L_AUTO_FREE_VAR(char *, ip);
-
-	l_rtnl_ifaddr6_extract(ifa, len, &ip);
-	l_debug("ifindex %u: ifaddr %s/%u", netconfig->ifindex,
-			ip, ifa->ifa_prefixlen);
-}
-
-static void netconfig_ifaddr_ipv6_notify(uint16_t type, const void *data,
-						uint32_t len, void *user_data)
-{
-	const struct ifaddrmsg *ifa = data;
-	struct netconfig *netconfig;
-	uint32_t bytes;
-
-	netconfig = netconfig_find(ifa->ifa_index);
-	if (!netconfig)
-		/* Ignore the interfaces which aren't managed by iwd. */
-		return;
-
-	bytes = len - NLMSG_ALIGN(sizeof(struct ifaddrmsg));
-
-	switch (type) {
-	case RTM_NEWADDR:
-		netconfig_ifaddr_ipv6_added(netconfig, ifa, bytes);
-		break;
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
-	if (type != RTM_NEWADDR)
-		return;
-
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
-	struct netconfig *netconfig = user_data;
-
-	netconfig->route4_add_gateway_cmd_id = 0;
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
-	netconfig->notify = NULL;
-}
-
-static void netconfig_route6_add_cb(int error, uint16_t type,
-					const void *data, uint32_t len,
-					void *user_data)
-{
-	struct netconfig *netconfig = user_data;
-
-	netconfig->route6_add_cmd_id = 0;
-
-	if (error) {
-		l_error("netconfig: Failed to add route. Error %d: %s",
-						error, strerror(-error));
-		return;
-	}
-}
-
-static bool netconfig_ipv4_subnet_route_install(struct netconfig *netconfig)
-{
-	struct in_addr in_addr;
-	char ip[INET_ADDRSTRLEN];
-	char network[INET_ADDRSTRLEN];
-	unsigned int prefix_len =
-		l_rtnl_address_get_prefix_length(netconfig->v4_address);
-
-	if (!l_rtnl_address_get_address(netconfig->v4_address, ip) ||
-			inet_pton(AF_INET, ip, &in_addr) < 1)
-		return false;
-
-	in_addr.s_addr = in_addr.s_addr &
-				htonl(0xFFFFFFFFLU << (32 - prefix_len));
-
-	if (!inet_ntop(AF_INET, &in_addr, network, INET_ADDRSTRLEN))
-		return false;
-
-	if (!l_rtnl_route4_add_connected(rtnl, netconfig->ifindex,
-						prefix_len, network, ip,
-						netconfig->rtm_protocol,
-						netconfig_route_generic_cb,
-						netconfig, NULL)) {
-		l_error("netconfig: Failed to add subnet route.");
-		return false;
-	}
-
-	return true;
-}
-
-static bool netconfig_ipv4_gateway_route_install(struct netconfig *netconfig)
-{
-	L_AUTO_FREE_VAR(char *, gateway) = NULL;
-	const uint8_t *gateway_mac = NULL;
-	struct in_addr in_addr;
-	char ip[INET_ADDRSTRLEN];
-
-	gateway = netconfig_ipv4_get_gateway(netconfig, &gateway_mac);
-	if (!gateway) {
-		l_debug("No gateway obtained from %s.",
-				netconfig->rtm_protocol == RTPROT_STATIC ?
-				"setting file" : "DHCPv4 lease");
-
-		if (netconfig->notify) {
-			netconfig->notify(NETCONFIG_EVENT_CONNECTED,
-						netconfig->user_data);
-			netconfig->notify = NULL;
-		}
-
-		return true;
-	}
-
-	if (!l_rtnl_address_get_address(netconfig->v4_address, ip) ||
-			inet_pton(AF_INET, ip, &in_addr) < 1)
-		return false;
-
-	netconfig->route4_add_gateway_cmd_id =
-		l_rtnl_route4_add_gateway(rtnl, netconfig->ifindex, gateway, ip,
-						ROUTE_PRIORITY_OFFSET,
-						netconfig->rtm_protocol,
-						netconfig_route_add_cmd_cb,
-						netconfig, NULL);
-	if (!netconfig->route4_add_gateway_cmd_id) {
-		l_error("netconfig: Failed to add route for: %s gateway.",
-								gateway);
-
-		return false;
-	}
-
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
-	return true;
-}
-
-static void netconfig_ipv4_ifaddr_add_cmd_cb(int error, uint16_t type,
-						const void *data, uint32_t len,
-						void *user_data)
-{
-	struct netconfig *netconfig = user_data;
-
-	netconfig->addr4_add_cmd_id = 0;
-
-	if (error && error != -EEXIST) {
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
-	struct netconfig *netconfig = user_data;
-	struct l_rtnl_route *gateway;
-	const uint8_t *gateway_mac;
-
-	netconfig->addr6_add_cmd_id = 0;
-
-	if (error && error != -EEXIST) {
-		l_error("netconfig: Failed to add IPv6 address. "
-				"Error %d: %s", error, strerror(-error));
-		return;
-	}
-
-	gateway = netconfig_get_static6_gateway(netconfig,
-						&netconfig->v6_gateway_str,
-						&gateway_mac);
-	if (gateway) {
-		netconfig->route6_add_cmd_id = l_rtnl_route_add(rtnl,
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
-	if (error == -ENODEV)
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
-{
-	struct netconfig *netconfig = userdata;
-
-	l_debug("DHCPv4 event %d", event);
-
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
-		gateway_str = netconfig_ipv4_get_gateway(netconfig, NULL);
-		if (l_streq0(netconfig->v4_gateway_str, gateway_str))
-			l_free(gateway_str);
-		else {
-			l_free(netconfig->v4_gateway_str);
-			netconfig->v4_gateway_str = gateway_str;
-		}
-
-		address = netconfig_get_dhcp4_address(netconfig);
-		l_rtnl_address_free(netconfig->v4_address);
-		netconfig->v4_address = address;
-
-		if (!netconfig->v4_address) {
-			l_error("netconfig: Failed to obtain IP addresses from "
-							"DHCPv4 lease.");
-			return;
-		}
-
-		netconfig_dns_list_update(netconfig, AF_INET);
-		netconfig_domains_update(netconfig, AF_INET);
-
-		L_WARN_ON(!(netconfig->addr4_add_cmd_id =
-				l_rtnl_ifaddr_add(rtnl, netconfig->ifindex,
-					netconfig->v4_address,
-					netconfig_ipv4_ifaddr_add_cmd_cb,
-					netconfig, NULL)));
-		break;
-	}
-	case L_DHCP_CLIENT_EVENT_LEASE_RENEWED:
-		break;
-	case L_DHCP_CLIENT_EVENT_LEASE_EXPIRED:
-		L_WARN_ON(!l_rtnl_ifaddr_delete(rtnl, netconfig->ifindex,
-					netconfig->v4_address,
-					netconfig_ifaddr_del_cmd_cb,
-					netconfig, NULL));
-		l_rtnl_address_free(netconfig->v4_address);
-		netconfig->v4_address = NULL;
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
-
-		break;
-	default:
-		l_error("netconfig: Received unsupported DHCPv4 event: %d",
-									event);
-	}
-}
-
-static void netconfig_dhcp6_event_handler(struct l_dhcp6_client *client,
-						enum l_dhcp6_client_event event,
-						void *userdata)
-{
-	struct netconfig *netconfig = userdata;
-
-	switch (event) {
-	case L_DHCP6_CLIENT_EVENT_IP_CHANGED:
-	case L_DHCP6_CLIENT_EVENT_LEASE_OBTAINED:
-	case L_DHCP6_CLIENT_EVENT_LEASE_RENEWED:
-	{
-		const struct l_dhcp6_lease *lease =
-			l_dhcp6_client_get_lease(netconfig->dhcp6_client);
-		_auto_(l_free) char *addr_str =
-			l_dhcp6_lease_get_address(lease);
-		struct l_rtnl_address *address;
-		struct l_icmp6_client *icmp6 =
-			l_dhcp6_client_get_icmp6(netconfig->dhcp6_client);
-		const struct l_icmp6_router *router =
-			l_icmp6_client_get_router(icmp6);
-		char *gateway_str = l_icmp6_router_get_address(router);
-
-		if (l_streq0(netconfig->v6_gateway_str, gateway_str))
-			l_free(gateway_str);
-		else {
-			l_free(netconfig->v6_gateway_str);
-			netconfig->v6_gateway_str = gateway_str;
-		}
-
-		address = l_rtnl_address_new(addr_str,
-					l_dhcp6_lease_get_prefix_length(lease));
-		l_rtnl_address_free(netconfig->v6_address);
-		netconfig->v6_address = address;
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
-		netconfig->v6_address = NULL;
-		l_free(l_steal_ptr(netconfig->v6_gateway_str));
-
-		/* Fall through */
-	case L_DHCP6_CLIENT_EVENT_NO_LEASE:
-		if (!l_dhcp6_client_start(netconfig->dhcp6_client))
-			l_error("netconfig: Failed to re-start DHCPv6 client "
-					"for interface %u", netconfig->ifindex);
-		break;
-	}
-}
-
 static void netconfig_remove_v4_address(struct netconfig *netconfig)
 {
 	if (!netconfig->v4_address)
 		return;
 
-	L_WARN_ON(!l_rtnl_ifaddr_delete(rtnl, netconfig->ifindex,
-					netconfig->v4_address,
-					netconfig_ifaddr_del_cmd_cb,
-					netconfig, NULL));
 	l_rtnl_address_free(netconfig->v4_address);
 	netconfig->v4_address = NULL;
 }
@@ -1170,178 +278,14 @@ static void netconfig_reset_v4(struct netconfig *netconfig)
 		l_strv_free(l_steal_ptr(netconfig->dns4_overrides));
 		l_strv_free(l_steal_ptr(netconfig->dns4_list));
 
-		l_dhcp_client_stop(netconfig->dhcp_client);
 		netconfig->rtm_protocol = 0;
 
-		l_acd_destroy(netconfig->acd);
-		netconfig->acd = NULL;
-
 		l_free(l_steal_ptr(netconfig->v4_gateway_str));
 
 		l_free(l_steal_ptr(netconfig->v4_domain));
 	}
 }
 
-static void netconfig_ipv4_acd_event(enum l_acd_event event, void *user_data)
-{
-	struct netconfig *netconfig = user_data;
-
-	switch (event) {
-	case L_ACD_EVENT_AVAILABLE:
-		L_WARN_ON(!(netconfig->addr4_add_cmd_id =
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
-		netconfig->v4_address = NULL;
-		netconfig->rtm_protocol = 0;
-		break;
-	case L_ACD_EVENT_LOST:
-		/*
-		 * Set IP but lost it some time after. Full (IPv4) reset in this
-		 * case.
-		 */
-		l_error("netconfig: statically configured address was lost");
-		netconfig_remove_v4_address(netconfig);
-		break;
-	}
-}
-
-static bool netconfig_ipv4_select_and_install(struct netconfig *netconfig)
-{
-	struct netdev *netdev = netdev_find(netconfig->ifindex);
-	bool set_address = (netconfig->rtm_protocol == RTPROT_STATIC);
-
-	if (netconfig_use_fils_addr(netconfig, AF_INET)) {
-		L_AUTO_FREE_VAR(char *, addr_str) = netconfig_ipv4_to_string(
-					netconfig->fils_override->ipv4_addr);
-		uint8_t prefix_len = netconfig->fils_override->ipv4_prefix_len;
-
-		if (unlikely(!addr_str))
-			return false;
-
-		netconfig->v4_address = l_rtnl_address_new(addr_str,
-								prefix_len);
-		if (L_WARN_ON(!netconfig->v4_address))
-			return false;
-
-		l_rtnl_address_set_noprefixroute(netconfig->v4_address, true);
-		set_address = true;
-
-		/*
-		 * TODO: If netconfig->fils_override->ipv4_lifetime is set,
-		 * start a timeout to renew the address using FILS IP Address
-		 * Assignment or perhaps just start the DHCP client at that
-		 * time.
-		 */
-	}
-
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
-		netconfig->acd = l_acd_new(netconfig->ifindex);
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
-			netconfig->acd = NULL;
-
-			L_WARN_ON(!(netconfig->addr4_add_cmd_id =
-				l_rtnl_ifaddr_add(rtnl, netconfig->ifindex,
-					netconfig->v4_address,
-					netconfig_ipv4_ifaddr_add_cmd_cb,
-					netconfig, NULL)));
-		}
-
-		return true;
-	}
-
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
-	struct netdev *netdev = netdev_find(netconfig->ifindex);
-
-	if (netconfig->rtm_v6_protocol == RTPROT_UNSPEC) {
-		l_debug("IPV6 configuration disabled");
-		return true;
-	}
-
-	sysfs_write_ipv6_setting(netdev_get_name(netdev), "disable_ipv6", "0");
-
-	if (netconfig_use_fils_addr(netconfig, AF_INET6)) {
-		uint8_t prefix_len = netconfig->fils_override->ipv6_prefix_len;
-		L_AUTO_FREE_VAR(char *, addr_str) = netconfig_ipv6_to_string(
-					netconfig->fils_override->ipv6_addr);
-
-		if (unlikely(!addr_str))
-			return false;
-
-		netconfig->v6_address = l_rtnl_address_new(addr_str,
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
-	}
-
-	if (netconfig->v6_address) {
-		netconfig_dns_list_update(netconfig, AF_INET6);
-
-		L_WARN_ON(!(netconfig->addr6_add_cmd_id =
-			l_rtnl_ifaddr_add(rtnl, netconfig->ifindex,
-					netconfig->v6_address,
-					netconfig_ipv6_ifaddr_add_cmd_cb,
-					netconfig, NULL)));
-		return true;
-	}
-
-	/* DHCPv6 or RA, update MAC */
-	l_dhcp6_client_set_address(netconfig->dhcp6_client, ARPHRD_ETHER,
-					netdev_get_address(netdev), ETH_ALEN);
-
-	return true;
-}
-
 static int validate_dns_list(int family, char **dns_list)
 {
 	unsigned int n_valid = 0;
@@ -1465,9 +409,6 @@ bool netconfig_load_settings(struct netconfig *netconfig,
 	else
 		netconfig->rtm_v6_protocol = RTPROT_DHCP;
 
-	if (send_hostname)
-		l_dhcp_client_set_hostname(netconfig->dhcp_client, hostname);
-
 	netconfig_free_settings(netconfig);
 
 	if (netconfig->rtm_protocol == RTPROT_STATIC)
@@ -1489,11 +430,7 @@ bool netconfig_configure(struct netconfig *netconfig,
 	netconfig->notify = notify;
 	netconfig->user_data = user_data;
 
-	if (unlikely(!netconfig_ipv4_select_and_install(netconfig)))
-		return false;
-
-	if (unlikely(!netconfig_ipv6_select_and_install(netconfig)))
-		return false;
+	/* TODO */
 
 	resolve_set_mdns(netconfig->resolve, netconfig->mdns);
 
@@ -1525,31 +462,6 @@ bool netconfig_reconfigure(struct netconfig *netconfig, bool set_arp_gw)
 
 bool netconfig_reset(struct netconfig *netconfig)
 {
-	struct netdev *netdev = netdev_find(netconfig->ifindex);
-
-	if (netconfig->route4_add_gateway_cmd_id) {
-		l_netlink_cancel(rtnl, netconfig->route4_add_gateway_cmd_id);
-		netconfig->route4_add_gateway_cmd_id = 0;
-	}
-
-	if (netconfig->route6_add_cmd_id) {
-		l_netlink_cancel(rtnl, netconfig->route6_add_cmd_id);
-		netconfig->route6_add_cmd_id = 0;
-	}
-
-	if (netconfig->addr4_add_cmd_id) {
-		l_netlink_cancel(rtnl, netconfig->addr4_add_cmd_id);
-		netconfig->addr4_add_cmd_id = 0;
-	}
-
-	if (netconfig->addr6_add_cmd_id) {
-		l_netlink_cancel(rtnl, netconfig->addr6_add_cmd_id);
-		netconfig->addr6_add_cmd_id = 0;
-	}
-
-	if (netconfig->rtm_protocol || netconfig->rtm_v6_protocol)
-		resolve_revert(netconfig->resolve);
-
 	netconfig_reset_v4(netconfig);
 
 	if (netconfig->rtm_v6_protocol) {
@@ -1559,12 +471,8 @@ bool netconfig_reset(struct netconfig *netconfig)
 		l_strv_free(l_steal_ptr(netconfig->dns6_overrides));
 		l_strv_free(l_steal_ptr(netconfig->dns6_list));
 
-		l_dhcp6_client_stop(netconfig->dhcp6_client);
 		netconfig->rtm_v6_protocol = 0;
 
-		sysfs_write_ipv6_setting(netdev_get_name(netdev),
-						"disable_ipv6", "1");
-
 		l_free(l_steal_ptr(netconfig->v6_gateway_str));
 
 		l_strv_free(l_steal_ptr(netconfig->v6_domains));
@@ -1577,12 +485,10 @@ bool netconfig_reset(struct netconfig *netconfig)
 
 char *netconfig_get_dhcp_server_ipv4(struct netconfig *netconfig)
 {
+	struct l_dhcp_client *client = NULL; /* TODO */
 	const struct l_dhcp_lease *lease;
 
-	if (!netconfig->dhcp_client)
-		return NULL;
-
-	lease = l_dhcp_client_get_lease(netconfig->dhcp_client);
+	lease = l_dhcp_client_get_lease(client);
 	if (!lease)
 		return NULL;
 
@@ -1622,28 +528,17 @@ struct netconfig *netconfig_new(uint32_t ifindex)
 {
 	struct netdev *netdev = netdev_find(ifindex);
 	struct netconfig *netconfig;
-	struct l_icmp6_client *icmp6;
 	const char *debug_level = NULL;
 	int dhcp_priority = L_LOG_INFO;
-
-	if (!netconfig_list)
-		return NULL;
+	struct l_dhcp_client *dhcp = NULL; /* TODO */
+	struct l_dhcp6_client *dhcp6 = NULL; /* TODO */
 
 	l_debug("Starting netconfig for interface: %d", ifindex);
 
-	netconfig = netconfig_find(ifindex);
-	if (netconfig)
-		return netconfig;
-
 	netconfig = l_new(struct netconfig, 1);
 	netconfig->ifindex = ifindex;
 	netconfig->resolve = resolve_new(ifindex);
 
-	netconfig->dhcp_client = l_dhcp_client_new(ifindex);
-	l_dhcp_client_set_event_handler(netconfig->dhcp_client,
-					netconfig_ipv4_dhcp_event_handler,
-					netconfig, NULL);
-
 	debug_level = getenv("IWD_DHCP_DEBUG");
 	if (debug_level != NULL) {
 		if (!strcmp("debug", debug_level))
@@ -1658,42 +553,22 @@ struct netconfig *netconfig_new(uint32_t ifindex)
 			dhcp_priority = L_LOG_DEBUG;
 	}
 
-	l_dhcp_client_set_debug(netconfig->dhcp_client, do_debug,
-					"[DHCPv4] ", NULL, dhcp_priority);
+	l_dhcp_client_set_debug(dhcp, do_debug, "[DHCPv4] ", NULL,
+				dhcp_priority);
 
-	netconfig->dhcp6_client = l_dhcp6_client_new(ifindex);
-	l_dhcp6_client_set_event_handler(netconfig->dhcp6_client,
-						netconfig_dhcp6_event_handler,
-						netconfig, NULL);
-	l_dhcp6_client_set_lla_randomized(netconfig->dhcp6_client, true);
-	l_dhcp6_client_set_nodelay(netconfig->dhcp6_client, true);
-	l_dhcp6_client_set_rtnl(netconfig->dhcp6_client, rtnl);
+	l_dhcp6_client_set_lla_randomized(dhcp6, true);
+	l_dhcp6_client_set_nodelay(dhcp6, true);
 
 	if (getenv("IWD_DHCP_DEBUG"))
-		l_dhcp6_client_set_debug(netconfig->dhcp6_client, do_debug,
-							"[DHCPv6] ", NULL);
-
-	icmp6 = l_dhcp6_client_get_icmp6(netconfig->dhcp6_client);
-	l_icmp6_client_set_rtnl(icmp6, rtnl);
-	l_icmp6_client_set_route_priority(icmp6, ROUTE_PRIORITY_OFFSET);
-
-	l_queue_push_tail(netconfig_list, netconfig);
-
-	sysfs_write_ipv6_setting(netdev_get_name(netdev), "accept_ra", "0");
-	sysfs_write_ipv6_setting(netdev_get_name(netdev), "disable_ipv6", "1");
+		l_dhcp6_client_set_debug(dhcp6, do_debug, "[DHCPv6] ", NULL);
 
 	return netconfig;
 }
 
 void netconfig_destroy(struct netconfig *netconfig)
 {
-	if (!netconfig_list)
-		return;
-
 	l_debug("");
 
-	l_queue_remove(netconfig_list, netconfig);
-
 	netconfig_reset(netconfig);
 	resolve_free(netconfig->resolve);
 	netconfig_free(netconfig);
@@ -1710,43 +585,6 @@ bool netconfig_enabled(void)
 
 static int netconfig_init(void)
 {
-	uint32_t r;
-
-	if (netconfig_list)
-		return -EALREADY;
-
-	rtnl = iwd_get_rtnl();
-
-	r = l_netlink_register(rtnl, RTNLGRP_IPV4_IFADDR,
-					netconfig_ifaddr_notify, NULL, NULL);
-	if (!r) {
-		l_error("netconfig: Failed to register for RTNL link address"
-							" notifications.");
-		goto error;
-	}
-
-	r = l_rtnl_ifaddr4_dump(rtnl, netconfig_ifaddr_cmd_cb, NULL, NULL);
-	if (!r) {
-		l_error("netconfig: Failed to get addresses from RTNL link.");
-		goto error;
-	}
-
-	r = l_netlink_register(rtnl, RTNLGRP_IPV6_IFADDR,
-				netconfig_ifaddr_ipv6_notify, NULL, NULL);
-	if (!r) {
-		l_error("netconfig: Failed to register for RTNL link IPv6 "
-					"address notifications.");
-		goto error;
-	}
-
-	r = l_rtnl_ifaddr6_dump(rtnl, netconfig_ifaddr_ipv6_cmd_cb, NULL,
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
@@ -1757,24 +595,11 @@ static int netconfig_init(void)
 					&ipv6_enabled))
 		ipv6_enabled = false;
 
-	netconfig_list = l_queue_new();
-
 	return 0;
-
-error:
-	rtnl = NULL;
-
-	return r;
 }
 
 static void netconfig_exit(void)
 {
-	if (!netconfig_list)
-		return;
-
-	rtnl = NULL;
-
-	l_queue_destroy(netconfig_list, netconfig_free);
 }
 
 IWD_MODULE(netconfig, netconfig_init, netconfig_exit)
-- 
2.34.1

