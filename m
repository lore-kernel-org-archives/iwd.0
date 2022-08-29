Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F405C80
	for <iwd@lists.linux.dev>; Mon, 29 Aug 2022 17:36:15 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so4802980wmb.4
        for <iwd@lists.linux.dev>; Mon, 29 Aug 2022 10:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=lOK0Puls0Yvt1XrnUvQytMvRvxv1YFhpHm7B3/DyZbQ=;
        b=se13hk5RIMMxYl37l4V5vRZ61FcYGGNEQbNWxOFvv1GYiU48gXM2Lbo9Pk1p+o/a2M
         +/dWJ95ZS67X65d5CHrc669el5BnmcKNTJEaMDxTkw1fuqIZQ1Ekc8Chb+bX6dqxVswI
         A2U+fRVF8Rv57RNEoW04H2UimWz5NcUkPdzTpSXXF3QZ/Yj1V0c7N7UOiHRaewhsj7no
         Tx/0JGOdNDedj6b/LCSUFc7vU8LAiUr3TqBVyCVB22r5cp5mQ8P9eQrWDDax4lVvltod
         Sk3PG5/OBcDYhspU0kwN3shqyEBLasPcwh0909/zF4hG5skKrjznaGneDROUrnDP8Nzn
         DEjw==
X-Gm-Message-State: ACgBeo3Yqxip90zlSxiAlGVvym0z+/Rv72fxm8L2/0hBmYuGPcLpfh+6
	BLyGHQ3L4GZDjYB81JYS8wBmxDqWdlEYlg==
X-Google-Smtp-Source: AA6agR7RlMFvpIlplvXgT0gn661LgeW+8TDOYagEGdE3QuwLHkC2Fr8U3/p+EX6PLFDOntTR06G0mA==
X-Received: by 2002:a05:600c:a02:b0:39c:97cc:82e3 with SMTP id z2-20020a05600c0a0200b0039c97cc82e3mr7477054wmp.97.1661794573682;
        Mon, 29 Aug 2022 10:36:13 -0700 (PDT)
Received: from iss.ger.corp.intel.com ([82.213.228.103])
        by smtp.gmail.com with ESMTPSA id q3-20020a1ce903000000b003a61306d79dsm9830551wmc.41.2022.08.29.10.36.12
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 10:36:13 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 09/10] netconfig: Add NetworkConfigurationAgent DBus API
Date: Mon, 29 Aug 2022 19:36:00 +0200
Message-Id: <20220829173601.1963953-9-andrew.zaborowski@intel.com>
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

Add a second netconfig-commit backend which, if enabled, doesn't
directly send any of the network configuration to the kernel or system
files but delegates the operation to an interested client's D-Bus
method as described in doc/agent-api.txt.  This backend is switched to
when a client registers a netconfig agent object and is swiched away
from when the client disconnects or unregisters the agent.  Only one
netconfig agent can be registered any given time.
---
 src/agent.c            |  62 +++++++
 src/dbus.h             |   2 +
 src/netconfig-commit.c | 380 +++++++++++++++++++++++++++++++++++++++++
 src/netconfig.h        |   2 +
 4 files changed, 446 insertions(+)

diff --git a/src/agent.c b/src/agent.c
index 63361a5d..0f718b87 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -28,6 +28,7 @@
 
 #include <ell/ell.h>
 #include "src/dbus.h"
+#include "src/netconfig.h"
 #include "src/agent.h"
 #include "src/iwd.h"
 #include "src/module.h"
@@ -584,6 +585,60 @@ static struct l_dbus_message *agent_unregister(struct l_dbus *dbus,
 	return reply;
 }
 
+static struct l_dbus_message *netconfig_agent_register(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct l_dbus_message *reply;
+	const char *path;
+	int r;
+
+	l_debug("");
+
+	if (!l_dbus_message_get_arguments(message, "o", &path))
+		return dbus_error_invalid_args(message);
+
+	if (!netconfig_enabled())
+		return dbus_error_not_supported(message);
+
+	r = netconfig_register_agent(l_dbus_message_get_sender(message), path);
+	if (r)
+		return dbus_error_from_errno(r, message);
+
+	l_debug("agent %s path %s",
+		l_dbus_message_get_sender(message), path);
+
+	reply = l_dbus_message_new_method_return(message);
+	l_dbus_message_set_arguments(reply, "");
+	return reply;
+}
+
+static struct l_dbus_message *netconfig_agent_unregister(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+					void *user_data)
+{
+	struct l_dbus_message *reply;
+	const char *path;
+	int r;
+
+	l_debug("");
+
+	if (!l_dbus_message_get_arguments(message, "o", &path))
+		return dbus_error_invalid_args(message);
+
+	if (!netconfig_enabled())
+		return dbus_error_not_supported(message);
+
+	r = netconfig_unregister_agent(l_dbus_message_get_sender(message),
+					path);
+	if (r)
+		return dbus_error_from_errno(r, message);
+
+	reply = l_dbus_message_new_method_return(message);
+	l_dbus_message_set_arguments(reply, "");
+	return reply;
+}
+
 static void setup_agent_interface(struct l_dbus_interface *interface)
 {
 	l_dbus_interface_method(interface, "RegisterAgent", 0,
@@ -592,6 +647,13 @@ static void setup_agent_interface(struct l_dbus_interface *interface)
 	l_dbus_interface_method(interface, "UnregisterAgent", 0,
 				agent_unregister,
 				"", "o", "path");
+
+	l_dbus_interface_method(interface,
+				"RegisterNetworkConfigurationAgent", 0,
+				netconfig_agent_register, "", "o", "path");
+	l_dbus_interface_method(interface,
+				"UnregisterNetworkConfigurationAgent", 0,
+				netconfig_agent_unregister, "", "o", "path");
 }
 
 static bool release_agent(void *data, void *user_data)
diff --git a/src/dbus.h b/src/dbus.h
index bbc76608..00c2df57 100644
--- a/src/dbus.h
+++ b/src/dbus.h
@@ -44,6 +44,8 @@
 #define IWD_AP_DIAGNOSTIC_INTERFACE "net.connman.iwd.AccessPointDiagnostic"
 #define IWD_STATION_DEBUG_INTERFACE "net.connman.iwd.StationDebug"
 #define IWD_DPP_INTERFACE "net.connman.iwd.DeviceProvisioning"
+#define IWD_NETCONFIG_AGENT_INTERFACE \
+	"net.connman.iwd.NetworkConfigurationAgent"
 
 #define IWD_BASE_PATH "/net/connman/iwd"
 #define IWD_AGENT_MANAGER_PATH IWD_BASE_PATH
diff --git a/src/netconfig-commit.c b/src/netconfig-commit.c
index d675d396..78670166 100644
--- a/src/netconfig-commit.c
+++ b/src/netconfig-commit.c
@@ -37,6 +37,7 @@
 #include "src/netdev.h"
 #include "src/ie.h"
 #include "src/resolve.h"
+#include "src/dbus.h"
 #include "src/netconfig.h"
 
 struct netconfig_commit_ops {
@@ -110,6 +111,24 @@ void netconfig_commit(struct netconfig *netconfig, uint8_t family,
 	}
 }
 
+static void netconfig_switch_backend(const struct netconfig_commit_ops *new_ops)
+{
+	const struct l_queue_entry *entry;
+
+	for (entry = l_queue_get_entries(netconfig_list); entry;
+			entry = entry->next) {
+		struct netconfig *netconfig = entry->data;
+
+		if (commit_ops->free_data)
+			commit_ops->free_data(netconfig, "");
+
+		if (new_ops->init_data)
+			new_ops->init_data(netconfig);
+	}
+
+	commit_ops = new_ops;
+}
+
 /*
  * Called by all backends when netconfig_commit finishes, synchronously or
  * asynchronously.
@@ -278,3 +297,364 @@ static void netconfig_rtnl_commit(struct netconfig *netconfig, uint8_t family,
 
 	netconfig_commit_done(netconfig, family, event, true);
 }
+
+struct netconfig_agent_data {
+	uint32_t pending_id[2];
+};
+
+struct netconfig_agent_call_data {
+	struct netconfig *netconfig;
+	uint8_t family;
+	enum l_netconfig_event event;
+};
+
+static char *netconfig_agent_name;
+static char *netconfig_agent_path;
+static unsigned int netconfig_agent_watch;
+
+static void netconfig_agent_cancel(struct netconfig *netconfig, uint8_t family,
+					const char *reasonstr)
+{
+	struct netconfig_agent_data *data = netconfig->commit_data;
+	struct l_dbus *dbus = dbus_get_bus();
+	const char *dev_path = netdev_get_path(netconfig->netdev);
+	struct l_dbus_message *message;
+	const char *method;
+
+	if (!data || !data->pending_id[INDEX_FOR_AF(family)])
+		return;
+
+	l_dbus_cancel(dbus, data->pending_id[INDEX_FOR_AF(family)]);
+	data->pending_id[INDEX_FOR_AF(family)] = 0;
+
+	method = (family == AF_INET ? "CancelIPv4" : "CancelIPv6");
+	l_debug("sending a %s(%s, %s) to %s %s", method, dev_path, reasonstr,
+		netconfig_agent_name, netconfig_agent_path);
+
+	message = l_dbus_message_new_method_call(dbus, netconfig_agent_name,
+						netconfig_agent_path,
+						IWD_NETCONFIG_AGENT_INTERFACE,
+						method);
+	l_dbus_message_set_arguments(message, "os", dev_path, reasonstr);
+	l_dbus_message_set_no_reply(message, true);
+	l_dbus_send(dbus, message);
+}
+
+static void netconfig_agent_receive_reply(struct l_dbus_message *reply,
+						void *user_data)
+{
+	struct netconfig_agent_call_data *cd = user_data;
+	struct netconfig_agent_data *data = cd->netconfig->commit_data;
+	const char *error, *text;
+	bool success = true;
+
+	l_debug("agent reply from %s %s", l_dbus_message_get_sender(reply),
+		l_dbus_message_get_path(reply));
+
+	data->pending_id[INDEX_FOR_AF(cd->family)] = 0;
+
+	if (l_dbus_message_get_error(reply, &error, &text)) {
+		success = false;
+		l_error("netconfig agent call returned %s(\"%s\")",
+			error, text);
+	} else if (!l_dbus_message_get_arguments(reply, "")) {
+		success = false;
+		l_error("netconfig agent call reply signature wrong: %s",
+			l_dbus_message_get_signature(reply));
+	}
+
+	netconfig_commit_done(cd->netconfig, cd->family, cd->event, success);
+}
+
+#define IS_IPV6_STR_FAST(str)	(strchr(str, ':') != NULL)
+
+typedef void (*netconfig_build_entry_fn)(struct l_dbus_message_builder *builder,
+					const void *data, uint8_t family);
+
+static void netconfig_agent_append_dict_dict_array(
+					struct l_dbus_message_builder *builder,
+					const char *key,
+					const struct l_queue_entry *value,
+					netconfig_build_entry_fn build_entry,
+					uint8_t family)
+{
+	l_dbus_message_builder_enter_dict(builder, "sv");
+	l_dbus_message_builder_append_basic(builder, 's', key);
+	l_dbus_message_builder_enter_variant(builder, "aa{sv}");
+	l_dbus_message_builder_enter_array(builder, "a{sv}");
+
+	for (; value; value = value->next)
+		build_entry(builder, value->data, family);
+
+	l_dbus_message_builder_leave_array(builder);
+	l_dbus_message_builder_leave_variant(builder);
+	l_dbus_message_builder_leave_dict(builder);
+}
+
+static void netconfig_agent_append_dict_strv(
+					struct l_dbus_message_builder *builder,
+					const char *key, char **value,
+					uint8_t family)
+{
+	if (!value)
+		return;
+
+	l_dbus_message_builder_enter_dict(builder, "sv");
+	l_dbus_message_builder_append_basic(builder, 's', key);
+	l_dbus_message_builder_enter_variant(builder, "as");
+	l_dbus_message_builder_enter_array(builder, "s");
+
+	for (; *value; value++) {
+		uint8_t value_family = IS_IPV6_STR_FAST((char *) *value) ?
+			AF_INET6 : AF_INET;
+
+		if (family == AF_UNSPEC || value_family == family)
+			l_dbus_message_builder_append_basic(builder, 's',
+								*value);
+	}
+
+	l_dbus_message_builder_leave_array(builder);
+	l_dbus_message_builder_leave_variant(builder);
+	l_dbus_message_builder_leave_dict(builder);
+}
+
+static void netconfig_agent_append_address(
+					struct l_dbus_message_builder *builder,
+					const void *data, uint8_t family)
+{
+	const struct l_rtnl_address *addr = data;
+	char addr_str[INET6_ADDRSTRLEN];
+	uint64_t valid_expiry_time;
+	uint64_t preferred_expiry_time;
+	uint64_t now = l_time_now();
+
+	if (l_rtnl_address_get_family(addr) != family)
+		return;
+
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+
+	l_rtnl_address_get_address(addr, addr_str);
+	dbus_append_dict_basic(builder, "Address", 's', addr_str);
+
+	if (family == AF_INET) {
+		uint8_t plen = l_rtnl_address_get_prefix_length(addr);
+		dbus_append_dict_basic(builder, "PrefixLength", 'y', &plen);
+
+		if (l_rtnl_address_get_broadcast(addr, addr_str) &&
+				strcmp(addr_str, "0.0.0.0"))
+			dbus_append_dict_basic(builder, "Broadcast", 's',
+						addr_str);
+	}
+
+	l_rtnl_address_get_expiry(addr, &preferred_expiry_time,
+					&valid_expiry_time);
+
+	if (valid_expiry_time > now) {
+		uint32_t lt = l_time_to_secs(valid_expiry_time - now);
+
+		dbus_append_dict_basic(builder, "ValidLifetime", 'u', &lt);
+	}
+
+	if (preferred_expiry_time > now) {
+		uint32_t lt = l_time_to_secs(preferred_expiry_time - now);
+
+		dbus_append_dict_basic(builder, "PreferredLifetime", 'u', &lt);
+	}
+
+	l_dbus_message_builder_leave_array(builder);
+}
+
+static void netconfig_agent_append_route(struct l_dbus_message_builder *builder,
+						const void *data,
+						uint8_t family)
+{
+	const struct l_rtnl_route *rt = data;
+	char addr_str[INET6_ADDRSTRLEN];
+	uint8_t prefix_len;
+	uint64_t expiry_time;
+	uint64_t now = l_time_now();
+	uint32_t priority;
+	uint8_t preference;
+	uint32_t mtu;
+
+	if (l_rtnl_route_get_family(rt) != family)
+		return;
+
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+
+	if (l_rtnl_route_get_dst(rt, addr_str, &prefix_len) && prefix_len) {
+		l_dbus_message_builder_enter_dict(builder, "sv");
+		l_dbus_message_builder_append_basic(builder, 's',
+							"Destination");
+		l_dbus_message_builder_enter_variant(builder, "(sy)");
+		l_dbus_message_builder_enter_struct(builder, "sy");
+		l_dbus_message_builder_append_basic(builder, 's', addr_str);
+		l_dbus_message_builder_append_basic(builder, 'y', &prefix_len);
+		l_dbus_message_builder_leave_struct(builder);
+		l_dbus_message_builder_leave_variant(builder);
+		l_dbus_message_builder_leave_dict(builder);
+	}
+
+	if (l_rtnl_route_get_gateway(rt, addr_str))
+		dbus_append_dict_basic(builder, "Router", 's', addr_str);
+
+	if (l_rtnl_route_get_prefsrc(rt, addr_str))
+		dbus_append_dict_basic(builder, "PreferredSource", 's',
+					addr_str);
+
+	expiry_time = l_rtnl_route_get_expiry(rt);
+	if (expiry_time > now) {
+		uint32_t lt = l_time_to_secs(expiry_time - now);
+
+		dbus_append_dict_basic(builder, "Lifetime", 'u', &lt);
+	}
+
+	priority = l_rtnl_route_get_priority(rt);
+	dbus_append_dict_basic(builder, "Priority", 'u', &priority);
+
+	/*
+	 * ICMPV6_ROUTER_PREF_MEDIUM is returned by default even for IPv4
+	 * routes where this property doesn't make sense so filter those out.
+	 */
+	preference = l_rtnl_route_get_preference(rt);
+	if (preference != ICMPV6_ROUTER_PREF_INVALID && family == AF_INET6)
+		dbus_append_dict_basic(builder, "Preference", 'y', &preference);
+
+	mtu = l_rtnl_route_get_mtu(rt);
+	if (mtu)
+		dbus_append_dict_basic(builder, "Priority", 'u', &mtu);
+
+	l_dbus_message_builder_leave_array(builder);
+}
+
+static void netconfig_agent_commit(struct netconfig *netconfig, uint8_t family,
+					enum l_netconfig_event event)
+{
+	struct netconfig_agent_data *data;
+	struct netconfig_agent_call_data *cd;
+	struct l_dbus *dbus = dbus_get_bus();
+	struct l_dbus_message *message;
+	struct l_dbus_message_builder *builder;
+	const char *dev_path = netdev_get_path(netconfig->netdev);
+	const char *dbus_method =
+		(family == AF_INET ? "ConfigureIPv4" : "ConfigureIPv6");
+	const char *cfg_method =
+		netconfig->static_config[INDEX_FOR_AF(family)] ?
+		"static" : "auto";
+	_auto_(l_strv_free) char **dns_list = NULL;
+	_auto_(l_strv_free) char **domains = NULL;
+
+	if (!netconfig->commit_data)
+		netconfig->commit_data = l_new(struct netconfig_agent_data, 1);
+
+	netconfig_agent_cancel(netconfig, family, "superseded");
+
+	l_debug("sending a %s(%s, ...) to %s %s", dbus_method, dev_path,
+		netconfig_agent_name, netconfig_agent_path);
+
+	message = l_dbus_message_new_method_call(dbus, netconfig_agent_name,
+						netconfig_agent_path,
+						IWD_NETCONFIG_AGENT_INTERFACE,
+						dbus_method);
+
+	/*
+	 * Build the call arguments: the Device object path and
+	 * the complicated config dict.
+	 */
+	builder = l_dbus_message_builder_new(message);
+	l_dbus_message_builder_append_basic(builder, 'o', dev_path);
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+	dbus_append_dict_basic(builder, "Method", 's', cfg_method);
+
+	netconfig_agent_append_dict_dict_array(builder, "Addresses",
+					l_netconfig_get_addresses(netconfig->nc,
+							NULL, NULL, NULL, NULL),
+					netconfig_agent_append_address, family);
+
+	netconfig_agent_append_dict_dict_array(builder, "Routes",
+					l_netconfig_get_routes(netconfig->nc,
+							NULL, NULL, NULL, NULL),
+					netconfig_agent_append_route, family);
+
+	dns_list = l_netconfig_get_dns_list(netconfig->nc);
+	netconfig_agent_append_dict_strv(builder, "DomainNameServers",
+						dns_list, family);
+
+	domains = l_netconfig_get_domain_names(netconfig->nc);
+	netconfig_agent_append_dict_strv(builder, "DomainNames",
+						domains, AF_UNSPEC);
+
+	l_dbus_message_builder_leave_array(builder);
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+
+	cd = l_new(struct netconfig_agent_call_data, 1);
+	cd->netconfig = netconfig;
+	cd->family = family;
+	cd->event = event;
+	data = netconfig->commit_data;
+	data->pending_id[INDEX_FOR_AF(family)] =
+		l_dbus_send_with_reply(dbus, message,
+					netconfig_agent_receive_reply,
+					cd, l_free);
+}
+
+static void netconfig_agent_free_data(struct netconfig *netconfig,
+					const char *reasonstr)
+{
+	if (!netconfig->commit_data)
+		return;
+
+	netconfig_agent_cancel(netconfig, AF_INET, reasonstr);
+	netconfig_agent_cancel(netconfig, AF_INET6, reasonstr);
+	l_free(l_steal_ptr(netconfig->commit_data));
+}
+
+static struct netconfig_commit_ops netconfig_agent_ops = {
+	.commit    = netconfig_agent_commit,
+	.free_data = netconfig_agent_free_data,
+};
+
+static void netconfig_agent_disconnect_handle(void *user_data)
+{
+	netconfig_unregister_agent(netconfig_agent_name, netconfig_agent_path);
+}
+
+static void netconfig_agent_disconnect_cb(struct l_dbus *dbus, void *user_data)
+{
+	l_debug("");
+	l_idle_oneshot(netconfig_agent_disconnect_handle, NULL, NULL);
+}
+
+int netconfig_register_agent(const char *name, const char *path)
+{
+	if (netconfig_agent_path)
+		return -EEXIST;
+
+	netconfig_agent_name = l_strdup(name);
+	netconfig_agent_path = l_strdup(path);
+	netconfig_agent_watch = l_dbus_add_disconnect_watch(dbus_get_bus(),
+						name,
+						netconfig_agent_disconnect_cb,
+						NULL, NULL);
+
+	netconfig_switch_backend(&netconfig_agent_ops);
+
+	return 0;
+}
+
+int netconfig_unregister_agent(const char *name, const char *path)
+{
+	if (!netconfig_agent_path || strcmp(netconfig_agent_path, path))
+		return -ENOENT;
+
+	if (strcmp(netconfig_agent_name, name))
+		return -EPERM;
+
+	l_free(l_steal_ptr(netconfig_agent_name));
+	l_free(l_steal_ptr(netconfig_agent_path));
+	l_dbus_remove_watch(dbus_get_bus(), netconfig_agent_watch);
+
+	netconfig_switch_backend(&netconfig_rtnl_ops);
+	return 0;
+}
diff --git a/src/netconfig.h b/src/netconfig.h
index 0ecd2583..289a78e9 100644
--- a/src/netconfig.h
+++ b/src/netconfig.h
@@ -81,6 +81,8 @@ void netconfig_commit_init(struct netconfig *netconfig);
 void netconfig_commit_free(struct netconfig *netconfig, const char *reasonstr);
 void netconfig_commit(struct netconfig *netconfig, uint8_t family,
 			enum l_netconfig_event event);
+int netconfig_register_agent(const char *name, const char *path);
+int netconfig_unregister_agent(const char *name, const char *path);
 
 void netconfig_dhcp_gateway_to_arp(struct netconfig *netconfig);
 void netconfig_commit_fils_macs(struct netconfig *netconfig, uint8_t family);
-- 
2.34.1

