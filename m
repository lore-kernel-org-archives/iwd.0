Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA945C84
	for <iwd@lists.linux.dev>; Mon, 29 Aug 2022 17:36:13 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id b5so11100735wrr.5
        for <iwd@lists.linux.dev>; Mon, 29 Aug 2022 10:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=U19CAqqM7R30yGEpKDIghGBBzBPOgXZRUqCAnTUWybY=;
        b=2v9n37zdvpkB18OE1E1xuF+Nf5x3PILSxKFk9//Pfpvl2OsvN7Sdwf4d/Rva2k73i7
         tx/Ae9h+PfL6xOnPQBN18nq6+gNWzHL++7pHlu8OF2vlCkhUQ0fxFyTIB4Af8hH72RpV
         Cx9rUOmNeojyOAWMMri2IPzQLzisFaVTOLmZCGhaRTujoEHfVuuCNHFY9WoCPeRyxDs7
         sm94M0kePpJobuyok0vM15/33bS+JQ2cfwh+BTOFmULFxFd+UVapfCGaTBp6QlkYScjn
         13OkJvXXY6ODhakXqmPYaF7SvyvtDAaDmQBt3mEg+DqRULAiFk+Xwd5+fHJxG7A5IP3I
         3x2w==
X-Gm-Message-State: ACgBeo385NvVE3J1hWQtNntJz66qfFae69QbvHoXVZYVcGKO8dX3Qxs9
	5CZeaa6wGG9+ypf/8u9qDEZT2FtHJRhRIg==
X-Google-Smtp-Source: AA6agR6KVmUEvgxyr/GSmo38hYVIyibFuNGtVTWQBV47w4CMSabLBVsrGCZerI2P2gmwXzs9jXsC4A==
X-Received: by 2002:adf:e0c3:0:b0:226:d598:85ee with SMTP id m3-20020adfe0c3000000b00226d59885eemr4662820wri.589.1661794571148;
        Mon, 29 Aug 2022 10:36:11 -0700 (PDT)
Received: from iss.ger.corp.intel.com ([82.213.228.103])
        by smtp.gmail.com with ESMTPSA id q3-20020a1ce903000000b003a61306d79dsm9830551wmc.41.2022.08.29.10.36.10
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 10:36:10 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 06/10] netconfig: Add netconfig-commit API
Date: Mon, 29 Aug 2022 19:35:57 +0200
Message-Id: <20220829173601.1963953-6-andrew.zaborowski@intel.com>
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

Add netconfig-commit.c whose main method, netconfig_commit actually sets
the configuration obtained by l_netconfig to the system netdev,
specifically it sets local addresses on the interface, adds routes to the
routing table, sets DNS related data and may add entries to the neighbor
cache.  netconfig-commit.c uses a backend-ops type structure to allow
for switching backends.  In this commit there's only a default backend
that uses l_netconfig_rtnl_apply() and a struct resolve object to write
the configuration.

netconfig_gateway_to_arp is moved from netconfig.c to netconfig-commit.c
(and renamed.)  The struct netconfig definition is moved to netconfig.h
so that both files can access the settings stored in the struct.
---
 Makefile.am            |   3 +-
 src/netconfig-commit.c | 203 +++++++++++++++++++++++++++++++++++++++++
 src/netconfig.c        |  77 +---------------
 src/netconfig.h        |  33 +++++++
 4 files changed, 243 insertions(+), 73 deletions(-)
 create mode 100644 src/netconfig-commit.c

diff --git a/Makefile.am b/Makefile.am
index 31b7e24b..bc26d052 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -237,7 +237,8 @@ src_iwd_SOURCES = src/main.c linux/nl80211.h src/iwd.h src/missing.h \
 					src/anqp.h src/anqp.c \
 					src/anqputil.h src/anqputil.c \
 					src/netconfig.h src/netconfig.c\
-					src/resolve.h src/resolve.c\
+					src/netconfig-commit.c \
+					src/resolve.h src/resolve.c \
 					src/hotspot.c \
 					src/p2p.h src/p2p.c \
 					src/p2putil.h src/p2putil.c \
diff --git a/src/netconfig-commit.c b/src/netconfig-commit.c
new file mode 100644
index 00000000..48ebe847
--- /dev/null
+++ b/src/netconfig-commit.c
@@ -0,0 +1,203 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2022  Intel Corporation. All rights reserved.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <arpa/inet.h>
+#include <netinet/if_ether.h>
+#include <linux/icmpv6.h>
+
+#include <ell/ell.h>
+
+#include "ell/useful.h"
+#include "src/iwd.h"
+#include "src/common.h"
+#include "src/util.h"
+#include "src/netdev.h"
+#include "src/ie.h"
+#include "src/resolve.h"
+#include "src/netconfig.h"
+
+struct netconfig_commit_ops {
+	bool (*init_data)(struct netconfig *netconfig);
+	void (*free_data)(struct netconfig *netconfig, const char *reasonstr);
+	void (*commit)(struct netconfig *netconfig, uint8_t family,
+			enum l_netconfig_event event);
+};
+
+static struct l_netlink *rtnl;
+
+static void netconfig_rtnl_commit(struct netconfig *netconfig, uint8_t family,
+					enum l_netconfig_event event);
+
+/* Default backend */
+static struct netconfig_commit_ops netconfig_rtnl_ops = {
+	.commit = netconfig_rtnl_commit,
+};
+
+/* Same backend for all netconfig objects */
+static const struct netconfig_commit_ops *commit_ops = &netconfig_rtnl_ops;
+
+static struct l_queue *netconfig_list;
+
+void netconfig_commit_init(struct netconfig *netconfig)
+{
+	if (!rtnl)
+		rtnl = l_rtnl_get();
+
+	if (!netconfig_list)
+		netconfig_list = l_queue_new();
+
+	l_queue_push_tail(netconfig_list, netconfig);
+
+	L_WARN_ON(netconfig->commit_data);
+
+	if (commit_ops->init_data)
+		commit_ops->init_data(netconfig);
+}
+
+void netconfig_commit_free(struct netconfig *netconfig, const char *reasonstr)
+{
+	if (commit_ops->free_data)
+		commit_ops->free_data(netconfig, reasonstr);
+
+	L_WARN_ON(!l_queue_remove(netconfig_list, netconfig));
+
+	if (l_queue_isempty(netconfig_list))
+		l_queue_destroy(l_steal_ptr(netconfig_list), NULL);
+}
+
+void netconfig_commit(struct netconfig *netconfig, uint8_t family,
+			enum l_netconfig_event event)
+{
+	commit_ops->commit(netconfig, family, event);
+
+	if (event == L_NETCONFIG_EVENT_CONFIGURE) {
+		/*
+		 * Done here instead of in ops->commit because the MACs are
+		 * not considered part of the network configuration
+		 * (particularly Network Manager's "level 3 config" or l3cfg)
+		 * so we can handle this ourselves independent of the backend.
+		 */
+		if (family == AF_INET &&
+				!netconfig->static_config[INDEX_FOR_AF(family)])
+			netconfig_dhcp_gateway_to_arp(netconfig);
+	}
+}
+
+/*
+ * Called by all backends when netconfig_commit finishes, synchronously or
+ * asynchronously.
+ */
+static void netconfig_commit_done(struct netconfig *netconfig, uint8_t family,
+					enum l_netconfig_event event,
+					bool success)
+{
+}
+
+static void netconfig_set_neighbor_entry_cb(int error,
+						uint16_t type, const void *data,
+						uint32_t len, void *user_data)
+{
+	if (error)
+		l_error("l_rtnl_neighbor_set_hwaddr failed: %s (%i)",
+			strerror(-error), error);
+}
+
+void netconfig_dhcp_gateway_to_arp(struct netconfig *netconfig)
+{
+	struct l_dhcp_client *dhcp = l_netconfig_get_dhcp_client(netconfig->nc);
+	const struct l_dhcp_lease *lease;
+	_auto_(l_free) char *server_id = NULL;
+	_auto_(l_free) char *gw = NULL;
+	const uint8_t *server_mac;
+	struct in_addr in_gw;
+	uint32_t ifindex = netdev_get_ifindex(netconfig->netdev);
+
+	/* Can only do this for DHCP in certain network setups */
+	if (netconfig->static_config[INDEX_FOR_AF(AF_INET)] ||
+			netconfig->fils_override)
+		return;
+
+	lease = l_dhcp_client_get_lease(dhcp);
+	if (!lease)
+		return;
+
+	server_id = l_dhcp_lease_get_server_id(lease);
+	gw = l_dhcp_lease_get_gateway(lease);
+	server_mac = l_dhcp_lease_get_server_mac(lease);
+
+	if (!gw || strcmp(server_id, gw) || !server_mac)
+		return;
+
+	l_debug("Gateway MAC is known, setting into ARP cache");
+	in_gw.s_addr = l_dhcp_lease_get_gateway_u32(lease);
+
+	if (!l_rtnl_neighbor_set_hwaddr(rtnl, ifindex, AF_INET,
+					&in_gw, server_mac, ETH_ALEN,
+					netconfig_set_neighbor_entry_cb, NULL,
+					NULL))
+		l_debug("l_rtnl_neighbor_set_hwaddr failed");
+}
+
+static void netconfig_dns_list_update(struct netconfig *netconfig)
+{
+	_auto_(l_strv_free) char **dns_list =
+		l_netconfig_get_dns_list(netconfig->nc);
+
+	if (netconfig->resolve && dns_list)
+		resolve_set_dns(netconfig->resolve, dns_list);
+}
+
+static void netconfig_domains_update(struct netconfig *netconfig)
+{
+	_auto_(l_strv_free) char **domains =
+		l_netconfig_get_domain_names(netconfig->nc);
+
+	if (netconfig->resolve && domains)
+		resolve_set_domains(netconfig->resolve, domains);
+}
+
+static void netconfig_rtnl_commit(struct netconfig *netconfig, uint8_t family,
+					enum l_netconfig_event event)
+{
+	l_netconfig_apply_rtnl(netconfig->nc);
+
+	/* TODO: cache values and skip updates if unchanged */
+	netconfig_dns_list_update(netconfig);
+	netconfig_domains_update(netconfig);
+
+	if (event == L_NETCONFIG_EVENT_CONFIGURE && family == AF_INET)
+		/*
+		 * netconfig->mdns is currently only loaded in
+		 * netconfig_load_settings() so we can set it once on
+		 * the CONFIGURE event.
+		 */
+		resolve_set_mdns(netconfig->resolve, netconfig->mdns);
+
+	if (event == L_NETCONFIG_EVENT_UNCONFIGURE && family == AF_INET)
+		resolve_revert(netconfig->resolve);
+
+	netconfig_commit_done(netconfig, family, event, true);
+}
diff --git a/src/netconfig.c b/src/netconfig.c
index 74eaca16..5b7a21ee 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -27,9 +27,7 @@
 #include <errno.h>
 #include <arpa/inet.h>
 #include <net/if_arp.h>
-#include <netinet/if_ether.h>
 #include <netinet/in.h>
-#include <linux/rtnetlink.h>
 #include <limits.h>
 #include <string.h>
 #include <fcntl.h>
@@ -52,30 +50,6 @@
 #include "src/netconfig.h"
 #include "src/sysfs.h"
 
-struct netconfig {
-	struct l_netconfig *nc;
-	struct netdev *netdev;
-
-	char *mdns;
-	struct ie_fils_ip_addr_response_info *fils_override;
-	bool enabled[2];
-	bool static_config[2];
-	bool gateway_overridden[2];
-	bool dns_overridden[2];
-
-	const struct l_settings *active_settings;
-
-	netconfig_notify_func_t notify;
-	void *user_data;
-
-	struct resolve *resolve;
-};
-
-/* 0 for AF_INET, 1 for AF_INET6 */
-#define INDEX_FOR_AF(af)	((af) != AF_INET)
-
-static struct l_netlink *rtnl;
-
 /*
  * Routing priority offset, configurable in main.conf. The route with lower
  * priority offset is preferred.
@@ -116,7 +90,7 @@ static void netconfig_free(void *data)
 	l_free(netconfig);
 }
 
-static bool netconfig_use_fils_addr(struct netconfig *netconfig, int af)
+bool netconfig_use_fils_addr(struct netconfig *netconfig, int af)
 {
 	if (!netconfig->enabled[INDEX_FOR_AF(af)])
 		return false;
@@ -133,15 +107,6 @@ static bool netconfig_use_fils_addr(struct netconfig *netconfig, int af)
 	return !l_memeqzero(netconfig->fils_override->ipv6_addr, 16);
 }
 
-static void netconfig_set_neighbor_entry_cb(int error,
-						uint16_t type, const void *data,
-						uint32_t len, void *user_data)
-{
-	if (error)
-		l_error("l_rtnl_neighbor_set_hwaddr failed: %s (%i)",
-			strerror(-error), error);
-}
-
 static struct l_rtnl_address *netconfig_get_static4_address(
 				const struct l_settings *active_settings)
 {
@@ -240,41 +205,6 @@ no_prefix_len:
 	return l_steal_ptr(ret);
 }
 
-static void netconfig_gateway_to_arp(struct netconfig *netconfig)
-{
-	struct l_dhcp_client *dhcp = l_netconfig_get_dhcp_client(netconfig->nc);
-	const struct l_dhcp_lease *lease;
-	_auto_(l_free) char *server_id = NULL;
-	_auto_(l_free) char *gw = NULL;
-	const uint8_t *server_mac;
-	struct in_addr in_gw;
-
-	/* Can only do this for DHCP in certain network setups */
-	if (netconfig->static_config[INDEX_FOR_AF(AF_INET)] ||
-			netconfig->fils_override)
-		return;
-
-	lease = l_dhcp_client_get_lease(dhcp);
-	if (!lease)
-		return;
-
-	server_id = l_dhcp_lease_get_server_id(lease);
-	gw = l_dhcp_lease_get_gateway(lease);
-	server_mac = l_dhcp_lease_get_server_mac(lease);
-
-	if (!gw || strcmp(server_id, gw) || !server_mac)
-		return;
-
-	l_debug("Gateway MAC is known, setting into ARP cache");
-	in_gw.s_addr = l_dhcp_lease_get_gateway_u32(lease);
-
-	if (!l_rtnl_neighbor_set_hwaddr(rtnl, netconfig->ifindex, AF_INET,
-					&in_gw, server_mac, ETH_ALEN,
-					netconfig_set_neighbor_entry_cb, NULL,
-					NULL))
-		l_debug("l_rtnl_neighbor_set_hwaddr failed");
-}
-
 static bool netconfig_load_dns(struct netconfig *netconfig,
 				const struct l_settings *active_settings,
 				const char *group_name, uint8_t family)
@@ -501,7 +431,7 @@ bool netconfig_reconfigure(struct netconfig *netconfig, bool set_arp_gw)
 	 * to alleviate this
 	 */
 	if (set_arp_gw)
-		netconfig_gateway_to_arp(netconfig);
+		netconfig_dhcp_gateway_to_arp(netconfig);
 
 	if (!netconfig->static_config[INDEX_FOR_AF(AF_INET)]) {
 		/* TODO l_dhcp_client sending a DHCP inform request */
@@ -584,6 +514,8 @@ struct netconfig *netconfig_new(uint32_t ifindex)
 	netconfig->netdev = netdev;
 	netconfig->resolve = resolve_new(ifindex);
 
+	netconfig_commit_init(netconfig);
+
 	debug_level = getenv("IWD_DHCP_DEBUG");
 	if (debug_level != NULL) {
 		if (!strcmp("debug", debug_level))
@@ -618,6 +550,7 @@ void netconfig_destroy(struct netconfig *netconfig)
 	l_debug("");
 
 	netconfig_reset(netconfig);
+	netconfig_commit_free(netconfig, "aborted");
 	resolve_free(netconfig->resolve);
 	netconfig_free(netconfig);
 }
diff --git a/src/netconfig.h b/src/netconfig.h
index c9ac6f8f..9f4f3b77 100644
--- a/src/netconfig.h
+++ b/src/netconfig.h
@@ -20,6 +20,7 @@
  *
  */
 
+struct netdev;
 struct netconfig;
 struct ie_fils_ip_addr_request_info;
 struct ie_fils_ip_addr_response_info;
@@ -31,6 +32,30 @@ enum netconfig_event {
 typedef void (*netconfig_notify_func_t)(enum netconfig_event event,
 							void *user_data);
 
+struct netconfig {
+	struct l_netconfig *nc;
+	struct netdev *netdev;
+
+	char *mdns;
+	struct ie_fils_ip_addr_response_info *fils_override;
+	bool enabled[2];
+	bool static_config[2];
+	bool gateway_overridden[2];
+	bool dns_overridden[2];
+
+	const struct l_settings *active_settings;
+
+	netconfig_notify_func_t notify;
+	void *user_data;
+
+	struct resolve *resolve;
+
+	void *commit_data;
+};
+
+/* 0 for AF_INET, 1 for AF_INET6 */
+#define INDEX_FOR_AF(af)	((af) != AF_INET)
+
 bool netconfig_load_settings(struct netconfig *netconfig,
 				const struct l_settings *active_settings);
 bool netconfig_configure(struct netconfig *netconfig,
@@ -43,8 +68,16 @@ bool netconfig_get_fils_ip_req(struct netconfig *netconfig,
 				struct ie_fils_ip_addr_request_info *info);
 void netconfig_handle_fils_ip_resp(struct netconfig *netconfig,
 			const struct ie_fils_ip_addr_response_info *info);
+bool netconfig_use_fils_addr(struct netconfig *netconfig, int af);
 
 struct netconfig *netconfig_new(uint32_t ifindex);
 void netconfig_destroy(struct netconfig *netconfig);
 
 bool netconfig_enabled(void);
+
+void netconfig_commit_init(struct netconfig *netconfig);
+void netconfig_commit_free(struct netconfig *netconfig, const char *reasonstr);
+void netconfig_commit(struct netconfig *netconfig, uint8_t family,
+			enum l_netconfig_event event);
+
+void netconfig_dhcp_gateway_to_arp(struct netconfig *netconfig);
-- 
2.34.1

