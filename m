Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6645C85
	for <iwd@lists.linux.dev>; Mon, 29 Aug 2022 17:36:14 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id n17so11112523wrm.4
        for <iwd@lists.linux.dev>; Mon, 29 Aug 2022 10:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=MEFEdZFCnyPpgnda0MwMbvW4bJWLsUrQyP4TlzDzLv4=;
        b=XEuQbIb730AwpjV9DoYeCZJ3gPGF3/qqxiENEXaoMpzawTCZR/mbBDw8gJmZMY68kK
         QR6I3VRFJcMaB52ZCPhBRfr+fdRuD9P7sL8mV6t3O3iVhpXpJ5TYaoSQkRoV1B4PSMzn
         yWQtur5bPtc3VNBJW7VvZh01ZZQRn7HcRbxWdmlNGvxF6W/SjTdXYsh+06WVAm0tJWpv
         KcljTrdRwS7aDgi06aqlhC8FR2AtLY3BCOH5bIllFTp+01ABaZjSDa3MOQuUl5gDvttq
         mdkrIThJkgkaOJS6TwbJFn/qBI64Xb8jHQy22VH6zr240WYHOjip5/HPAHpIlkTMf34V
         doAg==
X-Gm-Message-State: ACgBeo2vgoK1htCK4+tws0o1S5wNkENpPqUe/3nSYk6VII0kam/X8oza
	mOL+Aszj4ljWzN23F7UaU2xmMJJ9ym9X+w==
X-Google-Smtp-Source: AA6agR5wRuTvAZaACWvjauvtv6OgC3qMCpGaYPHIo4rrPLRABMHTus61zyx47h+L1AtlRfhVZIZPng==
X-Received: by 2002:a5d:508c:0:b0:226:e033:c042 with SMTP id a12-20020a5d508c000000b00226e033c042mr950743wrt.389.1661794572765;
        Mon, 29 Aug 2022 10:36:12 -0700 (PDT)
Received: from iss.ger.corp.intel.com ([82.213.228.103])
        by smtp.gmail.com with ESMTPSA id q3-20020a1ce903000000b003a61306d79dsm9830551wmc.41.2022.08.29.10.36.12
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 10:36:12 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 08/10] netconfig: Re-add FILS handling
Date: Mon, 29 Aug 2022 19:35:59 +0200
Message-Id: <20220829173601.1963953-8-andrew.zaborowski@intel.com>
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

Load the settings from FILS IE data into our l_netconfig instance when
appropriate.
---
 src/netconfig-commit.c |  51 ++++++++++++++++++
 src/netconfig.c        | 115 ++++++++++++++++++++++++++++++++++++++++-
 src/netconfig.h        |   1 +
 3 files changed, 166 insertions(+), 1 deletion(-)

diff --git a/src/netconfig-commit.c b/src/netconfig-commit.c
index 95b2a9d9..d675d396 100644
--- a/src/netconfig-commit.c
+++ b/src/netconfig-commit.c
@@ -103,6 +103,10 @@ void netconfig_commit(struct netconfig *netconfig, uint8_t family,
 		if (family == AF_INET &&
 				!netconfig->static_config[INDEX_FOR_AF(family)])
 			netconfig_dhcp_gateway_to_arp(netconfig);
+
+		if (!netconfig->connected[INDEX_FOR_AF(family)] &&
+				netconfig_use_fils_addr(netconfig, family))
+			netconfig_commit_fils_macs(netconfig, family);
 	}
 }
 
@@ -187,6 +191,53 @@ void netconfig_dhcp_gateway_to_arp(struct netconfig *netconfig)
 		l_debug("l_rtnl_neighbor_set_hwaddr failed");
 }
 
+void netconfig_commit_fils_macs(struct netconfig *netconfig, uint8_t family)
+{
+	const struct ie_fils_ip_addr_response_info *fils =
+		netconfig->fils_override;
+	const void *addr;
+	const void *hwaddr;
+	size_t addr_len = (family == AF_INET ? 4 : 16);
+	uint32_t ifindex = netdev_get_ifindex(netconfig->netdev);
+
+	if (!fils)
+		return;
+
+	/*
+	 * Attempt to use the gateway/DNS MAC addressed received from the AP
+	 * by writing the mapping directly into the netdev's ARP table so as
+	 * to save one data frame roundtrip before first IP connections are
+	 * established.  This is very low-priority but print error messages
+	 * just because they may indicate bigger problems.
+	 */
+
+	addr = (family == AF_INET ? (void *) &fils->ipv4_gateway :
+			(void *) &fils->ipv6_gateway);
+	hwaddr = (family == AF_INET ?
+			&fils->ipv4_gateway_mac : &fils->ipv6_gateway_mac);
+
+	if (!l_memeqzero(addr, addr_len) && !l_memeqzero(hwaddr, ETH_ALEN) &&
+			unlikely(!l_rtnl_neighbor_set_hwaddr(rtnl, ifindex,
+						family, addr, hwaddr, ETH_ALEN,
+						netconfig_set_neighbor_entry_cb,
+						NULL, NULL)))
+		l_debug("l_rtnl_neighbor_set_hwaddr(%s, gateway) failed",
+			family == AF_INET ? "AF_INET" : "AF_INET6");
+
+	addr = (family == AF_INET ? (void *) &fils->ipv4_dns :
+			(void *) &fils->ipv6_dns);
+	hwaddr = (family == AF_INET ?
+			&fils->ipv4_dns_mac : &fils->ipv6_dns_mac);
+
+	if (!l_memeqzero(addr, addr_len) && !l_memeqzero(hwaddr, ETH_ALEN) &&
+			unlikely(!l_rtnl_neighbor_set_hwaddr(rtnl, ifindex,
+						family, addr, hwaddr, ETH_ALEN,
+						netconfig_set_neighbor_entry_cb,
+						NULL, NULL)))
+		l_debug("l_rtnl_neighbor_set_hwaddr(%s, DNS) failed",
+			family == AF_INET ? "AF_INET" : "AF_INET6");
+}
+
 static void netconfig_dns_list_update(struct netconfig *netconfig)
 {
 	_auto_(l_strv_free) char **dns_list =
diff --git a/src/netconfig.c b/src/netconfig.c
index 91830416..feb7f87a 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -90,6 +90,26 @@ static void netconfig_free(void *data)
 	l_free(netconfig);
 }
 
+static bool netconfig_addr_to_str(uint8_t af, const void *v4_addr,
+					const void *v6_addr, char *out_str,
+					bool *out_is_zero)
+{
+	const void *addr = (af == AF_INET ? v4_addr : v6_addr);
+	uint8_t bytes = (af == AF_INET ? 4 : 16);
+
+	if (l_memeqzero(addr, bytes)) {
+		*out_is_zero = true;
+		return true;
+	}
+
+	*out_is_zero = false;
+
+	if (L_WARN_ON(!inet_ntop(af, addr, out_str, INET6_ADDRSTRLEN)))
+		return false;
+
+	return true;
+}
+
 bool netconfig_use_fils_addr(struct netconfig *netconfig, int af)
 {
 	if (!netconfig->enabled[INDEX_FOR_AF(af)])
@@ -408,12 +428,96 @@ mdns:
 	return false;
 }
 
+static bool netconfig_load_fils_settings(struct netconfig *netconfig,
+						uint8_t af)
+{
+	struct ie_fils_ip_addr_response_info *fils = netconfig->fils_override;
+	char addr_str[INET6_ADDRSTRLEN];
+	char gw_addr_str[INET6_ADDRSTRLEN];
+	char dns_addr_str[INET6_ADDRSTRLEN];
+	_auto_(l_rtnl_address_free) struct l_rtnl_address *rtnl_addr = NULL;
+	bool is_zero = false;
+	uint8_t prefix_len;
+
+	if (!netconfig_addr_to_str(af, &fils->ipv4_addr, &fils->ipv6_addr,
+					addr_str, &is_zero) || is_zero)
+		return is_zero;
+
+	prefix_len = (af == AF_INET ? fils->ipv4_prefix_len :
+			fils->ipv6_prefix_len);
+
+	if (L_WARN_ON(!(rtnl_addr = l_rtnl_address_new(addr_str, prefix_len))))
+		return false;
+
+	if (L_WARN_ON(!l_netconfig_set_static_addr(netconfig->nc, af,
+							rtnl_addr)))
+		return false;
+
+	if (af == AF_INET &&
+			L_WARN_ON(!l_netconfig_set_acd_enabled(netconfig->nc,
+								false)))
+		return false;
+
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
+
+	if (!netconfig_addr_to_str(af, &fils->ipv4_gateway, &fils->ipv6_gateway,
+					gw_addr_str, &is_zero))
+		return false;
+
+	if (!netconfig->gateway_overridden[INDEX_FOR_AF(af)] && !is_zero &&
+			L_WARN_ON(!l_netconfig_set_gateway_override(
+								netconfig->nc,
+								af,
+								gw_addr_str)))
+		return false;
+
+	if (!netconfig_addr_to_str(af, &fils->ipv4_dns, &fils->ipv6_dns,
+					dns_addr_str, &is_zero))
+		return is_zero;
+
+	if (!netconfig->dns_overridden[INDEX_FOR_AF(af)] && !is_zero) {
+		char *dns_list[2] = { dns_addr_str, NULL };
+
+		if (L_WARN_ON(!l_netconfig_set_dns_override(netconfig->nc,
+								af, dns_list)))
+			return false;
+	}
+
+	return true;
+}
+
 bool netconfig_configure(struct netconfig *netconfig,
 				netconfig_notify_func_t notify, void *user_data)
 {
 	netconfig->notify = notify;
 	netconfig->user_data = user_data;
 
+	if (netconfig_use_fils_addr(netconfig, AF_INET) &&
+			!netconfig_load_fils_settings(netconfig, AF_INET))
+		return false;
+
+	if (netconfig_use_fils_addr(netconfig, AF_INET6) &&
+			!netconfig_load_fils_settings(netconfig, AF_INET6))
+		return false;
+
 	if (unlikely(!l_netconfig_start(netconfig->nc)))
 		return false;
 
@@ -429,9 +533,18 @@ bool netconfig_reconfigure(struct netconfig *netconfig, bool set_arp_gw)
 	 * lost or delayed.  Try to force the gateway into the ARP cache
 	 * to alleviate this
 	 */
-	if (set_arp_gw)
+	if (set_arp_gw) {
 		netconfig_dhcp_gateway_to_arp(netconfig);
 
+		if (netconfig->connected[INDEX_FOR_AF(AF_INET)] &&
+				netconfig_use_fils_addr(netconfig, AF_INET))
+			netconfig_commit_fils_macs(netconfig, AF_INET);
+
+		if (netconfig->connected[INDEX_FOR_AF(AF_INET6)] &&
+				netconfig_use_fils_addr(netconfig, AF_INET6))
+			netconfig_commit_fils_macs(netconfig, AF_INET6);
+	}
+
 	if (!netconfig->static_config[INDEX_FOR_AF(AF_INET)]) {
 		/* TODO l_dhcp_client sending a DHCP inform request */
 	}
diff --git a/src/netconfig.h b/src/netconfig.h
index 50085aa7..0ecd2583 100644
--- a/src/netconfig.h
+++ b/src/netconfig.h
@@ -83,3 +83,4 @@ void netconfig_commit(struct netconfig *netconfig, uint8_t family,
 			enum l_netconfig_event event);
 
 void netconfig_dhcp_gateway_to_arp(struct netconfig *netconfig);
+void netconfig_commit_fils_macs(struct netconfig *netconfig, uint8_t family);
-- 
2.34.1

