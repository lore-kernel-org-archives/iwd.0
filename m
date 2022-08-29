Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085F85C80
	for <iwd@lists.linux.dev>; Mon, 29 Aug 2022 17:36:10 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id m16so11074736wru.9
        for <iwd@lists.linux.dev>; Mon, 29 Aug 2022 10:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=JIsWuqr8TnvEqnvOmTJ4X2yqWH2vbn6bRtUT8qm0CVk=;
        b=xbDemWM40wHOnwm32iOmkcjfHxkOXnp2jd2Ed4z5T34/dYhEOKoEMqRCnFrDP9q9Ab
         tuCFgRADCHsAzPsDk87BdzL1Slk/aCzjLuSSkda15xssoTuO1qCua4QsubRqNjYZ00+5
         4yPMfHSElUJ9kY7ej9wO7xq4N6eiumvexlyS8ncesI3M0TqHA82ixaJJviP6bMIG+/+U
         fIe4ijpBc8OMP7fkAAPPp9f+o9e2vT8Dg1j63UsomeTGRrlc38vzf61Bm0mcari+9S9O
         mpVVZMIt66SZ/8i9S7rXde6He1kEoB9NzRIUMrV/kQyrjzpSjrORTAXvaMU0b4PFZ2XN
         18SQ==
X-Gm-Message-State: ACgBeo2iKRs9Wb1dLbQI4DrhNKAHTXG2WrFDOevwKj9yAKcgBmbYLWvO
	w0y5BQegUXoMa29CAnGMw2sZIvzWCcCvaQ==
X-Google-Smtp-Source: AA6agR5Y2PZgIEfUg263s1wkLD9q89RNHLqtVFCyutEz1DA2X7iHtcghvE1y8oG9ALFZ6gCeh7JkYQ==
X-Received: by 2002:a5d:6d46:0:b0:21f:8b7:4c1d with SMTP id k6-20020a5d6d46000000b0021f08b74c1dmr7047802wri.455.1661794568818;
        Mon, 29 Aug 2022 10:36:08 -0700 (PDT)
Received: from iss.ger.corp.intel.com ([82.213.228.103])
        by smtp.gmail.com with ESMTPSA id q3-20020a1ce903000000b003a61306d79dsm9830551wmc.41.2022.08.29.10.36.08
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 10:36:08 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 03/10] netconfig: Keep configuration directly in struct l_netconfig
Date: Mon, 29 Aug 2022 19:35:54 +0200
Message-Id: <20220829173601.1963953-3-andrew.zaborowski@intel.com>
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

Drop all the struct netconfig members where we were keeping the parsed
netconfig settings and add a struct l_netconfig object.  In
netconfig_load_settings load all of the settings once parsed directly
into the l_netconfig object.  Only preserve the mdns configuration and
save some boolean values needed to properly handle static configuration
and FILS.  Update functions to use the new set of struct netconfig
members.

These booleans mirroring the l_netconfig state could be replaced by
adding l_netconfig getters for settings which currently only have
setters.
---
 Makefile.am     |   6 +-
 src/netconfig.c | 387 ++++++++++++++++++++++++++----------------------
 2 files changed, 216 insertions(+), 177 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index ed93d000..31b7e24b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -62,7 +62,8 @@ ell_headers = ell/util.h \
 			ell/icmp6.h \
 			ell/dhcp6.h \
 			ell/acd.h \
-			ell/cleanup.h
+			ell/cleanup.h \
+			ell/netconfig.h
 
 ell_sources = ell/private.h \
 			ell/missing.h \
@@ -141,7 +142,8 @@ ell_sources = ell/private.h \
 			ell/icmp6-private.h \
 			ell/dhcp6-lease.c \
 			ell/dhcp6-transport.c \
-			ell/acd.c
+			ell/acd.c \
+			ell/netconfig.c
 
 ell_shared = ell/useful.h ell/asn1-private.h
 
diff --git a/src/netconfig.c b/src/netconfig.c
index ea9846f6..98764346 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -53,21 +53,15 @@
 #include "src/sysfs.h"
 
 struct netconfig {
+	struct l_netconfig *nc;
 	uint32_t ifindex;
-	uint8_t rtm_protocol;
-	uint8_t rtm_v6_protocol;
-	struct l_rtnl_address *v4_address;
-	struct l_rtnl_address *v6_address;
-	char **dns4_overrides;
-	char **dns6_overrides;
-	char **dns4_list;
-	char **dns6_list;
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
 
 	const struct l_settings *active_settings;
 
@@ -77,6 +71,9 @@ struct netconfig {
 	struct resolve *resolve;
 };
 
+/* 0 for AF_INET, 1 for AF_INET6 */
+#define INDEX_FOR_AF(af)	((af) != AF_INET)
+
 static struct l_netlink *rtnl;
 
 /*
@@ -95,31 +92,36 @@ static void do_debug(const char *str, void *user_data)
 
 static void netconfig_free_settings(struct netconfig *netconfig)
 {
-	l_rtnl_address_free(netconfig->v4_address);
-	netconfig->v4_address = NULL;
-	l_rtnl_address_free(netconfig->v6_address);
-	netconfig->v6_address = NULL;
-
-	l_strfreev(netconfig->dns4_overrides);
-	netconfig->dns4_overrides = NULL;
-	l_strfreev(netconfig->dns6_overrides);
-	netconfig->dns6_overrides = NULL;
+	netconfig->enabled[0] = true;
+	netconfig->enabled[1] = false;
+	netconfig->static_config[0] = false;
+	netconfig->static_config[1] = false;
+	netconfig->gateway_overridden[0] = false;
+	netconfig->gateway_overridden[1] = false;
+	netconfig->dns_overridden[0] = false;
+	netconfig->dns_overridden[1] = false;
+	l_netconfig_reset_config(netconfig->nc);
 
 	l_free(netconfig->mdns);
 	netconfig->mdns = NULL;
+
+	l_free(l_steal_ptr(netconfig->fils_override));
 }
 
 static void netconfig_free(void *data)
 {
 	struct netconfig *netconfig = data;
 
+	l_netconfig_destroy(netconfig->nc);
 	l_free(netconfig);
 }
 
 static bool netconfig_use_fils_addr(struct netconfig *netconfig, int af)
 {
-	if ((af == AF_INET ? netconfig->rtm_protocol :
-				netconfig->rtm_v6_protocol) != RTPROT_DHCP)
+	if (!netconfig->enabled[INDEX_FOR_AF(af)])
+		return false;
+
+	if (netconfig->static_config[INDEX_FOR_AF(af)])
 		return false;
 
 	if (!netconfig->fils_override)
@@ -229,7 +231,7 @@ no_prefix_len:
 
 static void netconfig_gateway_to_arp(struct netconfig *netconfig)
 {
-	struct l_dhcp_client *dhcp = NULL; /* TODO */
+	struct l_dhcp_client *dhcp = l_netconfig_get_dhcp_client(netconfig->nc);
 	const struct l_dhcp_lease *lease;
 	_auto_(l_free) char *server_id = NULL;
 	_auto_(l_free) char *gw = NULL;
@@ -237,7 +239,8 @@ static void netconfig_gateway_to_arp(struct netconfig *netconfig)
 	struct in_addr in_gw;
 
 	/* Can only do this for DHCP in certain network setups */
-	if (netconfig->rtm_protocol != RTPROT_DHCP)
+	if (netconfig->static_config[INDEX_FOR_AF(AF_INET)] ||
+			netconfig->fils_override)
 		return;
 
 	lease = l_dhcp_client_get_lease(dhcp);
@@ -261,167 +264,207 @@ static void netconfig_gateway_to_arp(struct netconfig *netconfig)
 		l_debug("l_rtnl_neighbor_set_hwaddr failed");
 }
 
-static void netconfig_remove_v4_address(struct netconfig *netconfig)
+static bool netconfig_load_dns(struct netconfig *netconfig,
+				const struct l_settings *active_settings,
+				const char *group_name, uint8_t family)
 {
-	if (!netconfig->v4_address)
-		return;
+	_auto_(l_strv_free) char **dns_str_list = NULL;
 
-	l_rtnl_address_free(netconfig->v4_address);
-	netconfig->v4_address = NULL;
-}
+	if (!l_settings_has_key(active_settings, group_name, "DNS"))
+		return true;
 
-static void netconfig_reset_v4(struct netconfig *netconfig)
-{
-	if (netconfig->rtm_protocol) {
-		netconfig_remove_v4_address(netconfig);
-
-		l_strv_free(l_steal_ptr(netconfig->dns4_overrides));
-		l_strv_free(l_steal_ptr(netconfig->dns4_list));
-
-		netconfig->rtm_protocol = 0;
-
-		l_free(l_steal_ptr(netconfig->v4_gateway_str));
+	dns_str_list = l_settings_get_string_list(active_settings,
+							group_name, "DNS", ' ');
+	if (unlikely(!dns_str_list)) {
+		l_error("netconfig: Can't load [%s].DNS", group_name);
+		return false;
+	}
 
-		l_free(l_steal_ptr(netconfig->v4_domain));
+	if (unlikely(!l_netconfig_set_dns_override(netconfig->nc, family,
+							dns_str_list))) {
+		l_error("netconfig: l_netconfig_set_dns_override(%s) failed",
+			family == AF_INET ? "AF_INET" : "AF_INET6");
+		return false;
 	}
+
+	netconfig->dns_overridden[INDEX_FOR_AF(family)] = true;
+	return true;
 }
 
-static int validate_dns_list(int family, char **dns_list)
+static bool netconfig_load_gateway(struct netconfig *netconfig,
+				const struct l_settings *active_settings,
+				const char *group_name, uint8_t family)
 {
-	unsigned int n_valid = 0;
-	struct in_addr in_addr;
-	struct in6_addr in6_addr;
-	char **p;
-
-	for (p = dns_list; *p; p++) {
-		int r;
-
-		if (family == AF_INET)
-			r = inet_pton(AF_INET, *p, &in_addr);
-		else if (family == AF_INET6)
-			r = inet_pton(AF_INET6, *p, &in6_addr);
-		else
-			r = -EAFNOSUPPORT;
-
-		if (r > 0) {
-			n_valid += 1;
-			continue;
-		}
+	_auto_(l_free) char *gateway_str = NULL;
+
+	if (!l_settings_has_key(active_settings, group_name, "Gateway"))
+		return true;
 
-		l_error("netconfig: Invalid DNS address '%s'.", *p);
-		return -EINVAL;
+	gateway_str = l_settings_get_string(active_settings, group_name,
+						"Gateway");
+	if (unlikely(!gateway_str)) {
+		l_error("netconfig: Can't load [%s].Gateway", group_name);
+		return false;
+	}
+
+	if (unlikely(!l_netconfig_set_gateway_override(netconfig->nc, family,
+							gateway_str))) {
+		l_error("netconfig: l_netconfig_set_gateway_override(%s) "
+			"failed", family == AF_INET ? "AF_INET" : "AF_INET6");
+		return false;
 	}
 
-	return n_valid;
+	netconfig->gateway_overridden[INDEX_FOR_AF(family)] = true;
+	return true;
 }
 
 bool netconfig_load_settings(struct netconfig *netconfig,
 				const struct l_settings *active_settings)
 {
-	_auto_(l_free) char *mdns = NULL;
-	bool send_hostname;
-	bool v6_enabled;
+	bool send_hostname = false;
 	char hostname[HOST_NAME_MAX + 1];
-	_auto_(l_strv_free) char **dns4_overrides = NULL;
-	_auto_(l_strv_free) char **dns6_overrides = NULL;
-	_auto_(l_rtnl_address_free) struct l_rtnl_address *v4_address = NULL;
-	_auto_(l_rtnl_address_free) struct l_rtnl_address *v6_address = NULL;
-
-	dns4_overrides = l_settings_get_string_list(active_settings,
-							"IPv4", "DNS", ' ');
-	if (dns4_overrides) {
-		int r = validate_dns_list(AF_INET, dns4_overrides);
-
-		if (unlikely(r <= 0)) {
-			l_strfreev(dns4_overrides);
-			dns4_overrides = NULL;
-
-			if (r < 0)
-				return false;
-		}
+	_auto_(l_free) char *mdns = NULL;
+	bool success = true;
+	bool static_ipv4 = false;
+	bool static_ipv6 = false;
+	bool enable_ipv4 = true;
+	bool enable_ipv6 = ipv6_enabled;
 
-		if (r == 0)
-			l_error("netconfig: Empty IPv4.DNS entry, skipping...");
-	}
+	netconfig_free_settings(netconfig);
 
-	dns6_overrides = l_settings_get_string_list(active_settings,
-							"IPv6", "DNS", ' ');
+	/*
+	 * Note we try to print errors and continue validating the
+	 * configuration until we've gone through all the settings so
+	 * as to make fixing the settings more efficient for the user.
+	 */
 
-	if (dns6_overrides) {
-		int r = validate_dns_list(AF_INET6, dns6_overrides);
+	if (l_settings_has_key(active_settings, "IPv4", "Address")) {
+		_auto_(l_rtnl_address_free) struct l_rtnl_address *addr =
+			netconfig_get_static4_address(active_settings);
 
-		if (unlikely(r <= 0)) {
-			l_strfreev(dns6_overrides);
-			dns6_overrides = NULL;
+		if (unlikely(!addr)) {
+			success = false;
+			goto ipv6_addr;
+		}
 
-			if (r < 0)
-				return false;
+		if (!l_netconfig_set_static_addr(netconfig->nc, AF_INET,
+							addr)) {
+			l_error("netconfig: l_netconfig_set_static_addr("
+				"AF_INET) failed");
+			success = false;
+			goto ipv6_addr;
 		}
 
-		if (r == 0)
-			l_error("netconfig: Empty IPv6.DNS entry, skipping...");
+		static_ipv4 = true;
 	}
 
-	if (!l_settings_get_bool(active_settings,
-					"IPv4", "SendHostname", &send_hostname))
-		send_hostname = false;
+ipv6_addr:
+	if (l_settings_has_key(active_settings, "IPv6", "Address")) {
+		_auto_(l_rtnl_address_free) struct l_rtnl_address *addr =
+			netconfig_get_static6_address(active_settings);
+
+		if (unlikely(!addr)) {
+			success = false;
+			goto gateway;
+		}
 
-	if (send_hostname) {
-		if (gethostname(hostname, sizeof(hostname)) != 0) {
-			l_warn("netconfig: Unable to get hostname. "
-					"Error %d: %s", errno, strerror(errno));
-			send_hostname = false;
+		if (!l_netconfig_set_static_addr(netconfig->nc, AF_INET6,
+							addr)) {
+			l_error("netconfig: l_netconfig_set_static_addr("
+				"AF_INET6) failed");
+			success = false;
+			goto gateway;
 		}
+
+		static_ipv6 = true;
 	}
 
-	mdns = l_settings_get_string(active_settings,
-					"Network", "MulticastDNS");
+gateway:
+	if (!netconfig_load_gateway(netconfig, active_settings,
+					"IPv4", AF_INET))
+		success = false;
 
-	if (l_settings_has_key(active_settings, "IPv4", "Address")) {
-		v4_address = netconfig_get_static4_address(active_settings);
+	if (!netconfig_load_gateway(netconfig, active_settings,
+					"IPv6", AF_INET6))
+		success = false;
 
-		if (unlikely(!v4_address)) {
-			l_error("netconfig: Can't parse IPv4 address");
-			return false;
-		}
+	if (!netconfig_load_dns(netconfig, active_settings, "IPv4", AF_INET))
+		success = false;
+
+	if (!netconfig_load_dns(netconfig, active_settings, "IPv6", AF_INET6))
+		success = false;
+
+	if (l_settings_has_key(active_settings, "IPv6", "Enabled") &&
+			!l_settings_get_bool(active_settings, "IPv6", "Enabled",
+						&enable_ipv6)) {
+		l_error("netconfig: Can't load IPv6.Enabled");
+		success = false;
+		goto send_hostname;
 	}
 
-	if (!l_settings_get_bool(active_settings, "IPv6",
-					"Enabled", &v6_enabled))
-		v6_enabled = ipv6_enabled;
+	if (!l_netconfig_set_family_enabled(netconfig->nc, AF_INET,
+						enable_ipv4) ||
+			!l_netconfig_set_family_enabled(netconfig->nc, AF_INET6,
+							enable_ipv6)) {
+		l_error("netconfig: l_netconfig_set_family_enabled() failed");
+		success = false;
+	}
 
-	if (l_settings_has_key(active_settings, "IPv6", "Address")) {
-		v6_address = netconfig_get_static6_address(active_settings);
+send_hostname:
+	if (l_settings_has_key(active_settings, "IPv4", "SendHostname") &&
+			!l_settings_get_bool(active_settings, "IPv4",
+						"SendHostname",
+						&send_hostname)) {
+		l_error("netconfig: Can't load [IPv4].SendHostname");
+		success = false;
+		goto mdns;
+	}
 
-		if (unlikely(!v6_address)) {
-			l_error("netconfig: Can't parse IPv6 address");
-			return false;
-		}
+	if (send_hostname && gethostname(hostname, sizeof(hostname)) != 0) {
+		/* Warning only */
+		l_warn("netconfig: Unable to get hostname. "
+			"Error %d: %s", errno, strerror(errno));
+		goto mdns;
 	}
 
-	/* No more validation steps for now, commit new values */
-	netconfig->rtm_protocol = v4_address ? RTPROT_STATIC : RTPROT_DHCP;
+	if (send_hostname &&
+			!l_netconfig_set_hostname(netconfig->nc, hostname)) {
+		l_error("netconfig: l_netconfig_set_hostname() failed");
+		success = false;
+		goto mdns;
+	}
 
-	if (!v6_enabled)
-		netconfig->rtm_v6_protocol = RTPROT_UNSPEC;
-	else if (v6_address)
-		netconfig->rtm_v6_protocol = RTPROT_STATIC;
-	else
-		netconfig->rtm_v6_protocol = RTPROT_DHCP;
+mdns:
+	if (l_settings_has_key(active_settings, "Network", "MulticastDNS") &&
+			!(mdns = l_settings_get_string(active_settings,
+							"Network",
+							"MulticastDNS"))) {
+		l_error("netconfig: Can't load Network.MulticastDNS");
+		success = false;
+	}
 
-	netconfig_free_settings(netconfig);
+	if (mdns && !L_IN_STRSET(mdns, "true", "false", "resolve")) {
+		l_error("netconfig: Bad Network.MulticastDNS value '%s'", mdns);
+		success = false;
+	}
 
-	if (netconfig->rtm_protocol == RTPROT_STATIC)
-		netconfig->v4_address = l_steal_ptr(v4_address);
+	if (!l_netconfig_check_config(netconfig->nc)) {
+		l_error("netconfig: Invalid configuration");
+		success = false;
+	}
 
-	if (netconfig->rtm_v6_protocol == RTPROT_STATIC)
-		netconfig->v6_address = l_steal_ptr(v6_address);
+	if (success) {
+		netconfig->active_settings = active_settings;
+		netconfig->static_config[INDEX_FOR_AF(AF_INET)] = static_ipv4;
+		netconfig->static_config[INDEX_FOR_AF(AF_INET6)] = static_ipv6;
+		netconfig->enabled[INDEX_FOR_AF(AF_INET)] = enable_ipv4;
+		netconfig->enabled[INDEX_FOR_AF(AF_INET6)] = enable_ipv6;
+		netconfig->mdns = l_steal_ptr(mdns);
+		return true;
+	}
 
-	netconfig->active_settings = active_settings;
-	netconfig->dns4_overrides = l_steal_ptr(dns4_overrides);
-	netconfig->dns6_overrides = l_steal_ptr(dns6_overrides);
-	netconfig->mdns = l_steal_ptr(mdns);
-	return true;
+	l_netconfig_reset_config(netconfig->nc);
+	return false;
 }
 
 bool netconfig_configure(struct netconfig *netconfig,
@@ -449,11 +492,11 @@ bool netconfig_reconfigure(struct netconfig *netconfig, bool set_arp_gw)
 	if (set_arp_gw)
 		netconfig_gateway_to_arp(netconfig);
 
-	if (netconfig->rtm_protocol == RTPROT_DHCP) {
+	if (!netconfig->static_config[INDEX_FOR_AF(AF_INET)]) {
 		/* TODO l_dhcp_client sending a DHCP inform request */
 	}
 
-	if (netconfig->rtm_v6_protocol == RTPROT_DHCP) {
+	if (!netconfig->static_config[INDEX_FOR_AF(AF_INET6)]) {
 		/* TODO l_dhcp_v6_client sending a DHCP inform request */
 	}
 
@@ -462,32 +505,22 @@ bool netconfig_reconfigure(struct netconfig *netconfig, bool set_arp_gw)
 
 bool netconfig_reset(struct netconfig *netconfig)
 {
-	netconfig_reset_v4(netconfig);
-
-	if (netconfig->rtm_v6_protocol) {
-		l_rtnl_address_free(netconfig->v6_address);
-		netconfig->v6_address = NULL;
-
-		l_strv_free(l_steal_ptr(netconfig->dns6_overrides));
-		l_strv_free(l_steal_ptr(netconfig->dns6_list));
-
-		netconfig->rtm_v6_protocol = 0;
-
-		l_free(l_steal_ptr(netconfig->v6_gateway_str));
-
-		l_strv_free(l_steal_ptr(netconfig->v6_domains));
-	}
-
-	l_free(l_steal_ptr(netconfig->fils_override));
+	l_netconfig_unconfigure(netconfig->nc);
+	l_netconfig_stop(netconfig->nc);
 
+	netconfig_free_settings(netconfig);
 	return true;
 }
 
 char *netconfig_get_dhcp_server_ipv4(struct netconfig *netconfig)
 {
-	struct l_dhcp_client *client = NULL; /* TODO */
+	struct l_dhcp_client *client =
+		l_netconfig_get_dhcp_client(netconfig->nc);
 	const struct l_dhcp_lease *lease;
 
+	if (!client)
+		return NULL;
+
 	lease = l_dhcp_client_get_lease(client);
 	if (!lease)
 		return NULL;
@@ -504,15 +537,16 @@ bool netconfig_get_fils_ip_req(struct netconfig *netconfig,
 	 * configuration (usually DHCP).  If we're configured with static
 	 * values return false to mean the IE should not be sent.
 	 */
-	if (netconfig->rtm_protocol != RTPROT_DHCP &&
-			netconfig->rtm_v6_protocol != RTPROT_DHCP)
+	if (netconfig->static_config[0] && netconfig->static_config[1])
 		return false;
 
 	memset(info, 0, sizeof(*info));
-	info->ipv4 = (netconfig->rtm_protocol == RTPROT_DHCP);
-	info->ipv6 = (netconfig->rtm_v6_protocol == RTPROT_DHCP);
-	info->dns = (info->ipv4 && !netconfig->dns4_overrides) ||
-		(info->ipv6 && !netconfig->dns6_overrides);
+	info->ipv4 = !netconfig->static_config[INDEX_FOR_AF(AF_INET)];
+	info->ipv6 = !netconfig->static_config[INDEX_FOR_AF(AF_INET6)];
+	info->dns = (info->ipv4 &&
+			!netconfig->dns_overridden[INDEX_FOR_AF(AF_INET)]) ||
+		(info->ipv6 &&
+			!netconfig->dns_overridden[INDEX_FOR_AF(AF_INET)]);
 
 	return true;
 }
@@ -530,12 +564,12 @@ struct netconfig *netconfig_new(uint32_t ifindex)
 	struct netconfig *netconfig;
 	const char *debug_level = NULL;
 	int dhcp_priority = L_LOG_INFO;
-	struct l_dhcp_client *dhcp = NULL; /* TODO */
-	struct l_dhcp6_client *dhcp6 = NULL; /* TODO */
+	struct l_dhcp6_client *dhcp6;
 
-	l_debug("Starting netconfig for interface: %d", ifindex);
+	l_debug("Creating netconfig for interface: %d", ifindex);
 
 	netconfig = l_new(struct netconfig, 1);
+	netconfig->nc = l_netconfig_new(ifindex);
 	netconfig->ifindex = ifindex;
 	netconfig->resolve = resolve_new(ifindex);
 
@@ -553,15 +587,18 @@ struct netconfig *netconfig_new(uint32_t ifindex)
 			dhcp_priority = L_LOG_DEBUG;
 	}
 
-	l_dhcp_client_set_debug(dhcp, do_debug, "[DHCPv4] ", NULL,
-				dhcp_priority);
+	l_dhcp_client_set_debug(l_netconfig_get_dhcp_client(netconfig->nc),
+				do_debug, "[DHCPv4] ", NULL, dhcp_priority);
 
+	dhcp6 = l_netconfig_get_dhcp6_client(netconfig->nc);
 	l_dhcp6_client_set_lla_randomized(dhcp6, true);
 	l_dhcp6_client_set_nodelay(dhcp6, true);
 
-	if (getenv("IWD_DHCP_DEBUG"))
+	if (debug_level)
 		l_dhcp6_client_set_debug(dhcp6, do_debug, "[DHCPv6] ", NULL);
 
+	l_netconfig_set_route_priority(netconfig->nc, ROUTE_PRIORITY_OFFSET);
+
 	return netconfig;
 }
 
-- 
2.34.1

