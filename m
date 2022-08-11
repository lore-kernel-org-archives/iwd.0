Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4073B2CA7
	for <iwd@lists.linux.dev>; Thu, 11 Aug 2022 17:59:06 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id z187so17080848pfb.12
        for <iwd@lists.linux.dev>; Thu, 11 Aug 2022 10:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=AroT2anseqTNB9gatoNKuqu8wrkjWl9lttltD2/hzS0=;
        b=NjSbB6a1jA1ySM56rGj5o3v99F6U3gGSz2/m6KWeEq/zWToIovJIQIqiUEaWc1F4lD
         7/SAiX5AmtXYqLviMIlGcQgWVu+lWS+GS41YCWRcb0+InSSPVKWSvs9Cr9QEgzr2gBtg
         0cZgeG201csoZvD3gJCLdP2DmgeG5iYbv3XRIt5+rbgA4/NS3d/O6J40P1PNJtoL8Tt8
         x44c3UB0N7rPeCgJFHpvry4bgdYhZADRJ5ztKDSeo3aYHRAQ71Rlkunjh47Nw2fnrHin
         o/93EhPavI922PSJD4iVCCU7M7e9u27JbXvJAI0N8kTbwEFc/oBN/OcCezE2zYhe4zYG
         WzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=AroT2anseqTNB9gatoNKuqu8wrkjWl9lttltD2/hzS0=;
        b=AWdy9iumEkYoslb2ClU76dmw/or5O/nmOMgaaDmMugjFh3bv7m3gTE74krH2f897kF
         RXEe+F8eKuMQbEfQMPxsSBzdC3PeJsT/Ntj9cHoO9RnZ21pO6fk/mzLxKmVySNQunNZD
         ESWvpN4IQa8kjCEqrFWsPE+PBJgUtR+5JTltR42dK1IJaOLr4FHnMxNXJDkc4gqzZBDK
         EssVSFxpW6V2qRQsz4UAfIj3tkmExtNGxBjC7vFNEi1Q7NFIA7AqMW5hbeKgqhAANGcP
         Cgp3go+YSIz5E1LOOQgdgp0amoNSLUAEPU8GI57JuAcpQ2nxMBZGyyIoayYRGqeo95oL
         bqiA==
X-Gm-Message-State: ACgBeo3kfj3pttO6AAhfj3+GM901vWa5MrA5/ZEU34fII2X+sM+t0UUn
	lHPpVEwTMr992+HBdqohL8njkechevE=
X-Google-Smtp-Source: AA6agR4snMXCQU5z0BYUY8n5lsJSWLX3cFN2xwxv5winIVdxrhs8Oe1zex31nWQ2xf6iDx7LlrRDzA==
X-Received: by 2002:a63:565c:0:b0:41d:17e1:32f with SMTP id g28-20020a63565c000000b0041d17e1032fmr160124pgm.445.1660240745340;
        Thu, 11 Aug 2022 10:59:05 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id w125-20020a626283000000b0052ab602a7d0sm4292685pfb.100.2022.08.11.10.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 10:59:04 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/6] client: add station-debug command interface
Date: Thu, 11 Aug 2022 10:58:58 -0700
Message-Id: <20220811175900.443310-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220811175900.443310-1-prestwoj@gmail.com>
References: <20220811175900.443310-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This lets iwctl call methods on .StationDebug. The command
name is called 'debug'. This can only be used when both iwctl
and IWD are in developer mode (-E)
---
 Makefile.am            |   4 +-
 client/station-debug.c | 451 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 454 insertions(+), 1 deletion(-)
 create mode 100644 client/station-debug.c

diff --git a/Makefile.am b/Makefile.am
index cffb0738..ed93d000 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -301,7 +301,9 @@ client_iwctl_SOURCES = client/main.c \
 			client/wsc.c client/station.c \
 			client/diagnostic.c client/diagnostic.h \
 			client/daemon.c client/daemon.h \
-			client/dpp.c
+			client/dpp.c client/station-debug.c \
+			src/util.c src/util.h \
+			src/band.c src/band.h
 
 client_iwctl_LDADD = $(ell_ldadd) $(READLINE_LIBS)
 
diff --git a/client/station-debug.c b/client/station-debug.c
new file mode 100644
index 00000000..4009fbbe
--- /dev/null
+++ b/client/station-debug.c
@@ -0,0 +1,451 @@
+#include <ell/ell.h>
+#include "ell/useful.h"
+
+#include "client/command.h"
+#include "client/dbus-proxy.h"
+#include "client/device.h"
+#include "client/display.h"
+#include "client/properties.h"
+#include "client/network.h"
+#include "src/util.h"
+
+struct station_debug {
+	struct l_queue *network_list;
+	bool autoconnect;
+};
+
+struct network {
+	char *ssid;
+	struct l_queue *bss_list;
+};
+
+struct bss {
+	char addr[18];
+	uint32_t frequency;
+	int8_t rssi;
+	int32_t rank;
+	uint8_t mde[3];
+};
+
+static void network_free(void *data)
+{
+	struct network *network = data;
+
+	l_queue_destroy(network->bss_list, l_free);
+}
+
+static void *station_debug_create(void)
+{
+	struct station_debug *debug = l_new(struct station_debug, 1);
+
+	debug->network_list = l_queue_new();
+
+	return debug;
+}
+
+static void station_debug_destroy(void *data)
+{
+	struct station_debug *debug = data;
+
+	l_queue_destroy(debug->network_list, network_free);
+
+	l_free(debug);
+}
+
+static void check_errors_method_callback(struct l_dbus_message *message,
+								void *user_data)
+{
+	dbus_message_has_error(message);
+}
+
+static enum cmd_status cmd_debug_connect(const char *device_name,
+						char **argv, int argc)
+{
+
+	const struct proxy_interface *debug_i;
+	uint8_t addr[6];
+
+	if (argc < 1)
+		return CMD_STATUS_INVALID_ARGS;
+
+	debug_i = device_proxy_find(device_name, IWD_STATION_DEBUG_INTERFACE);
+	if (!debug_i) {
+		display_error("IWD not in developer mode");
+		return CMD_STATUS_INVALID_VALUE;
+	}
+
+	if (!util_string_to_address(argv[0], addr))
+		return CMD_STATUS_INVALID_ARGS;
+
+	proxy_interface_method_call(debug_i, "ConnectBssid", "ay",
+					check_errors_method_callback, 6,
+					addr[0], addr[1], addr[2],
+					addr[3], addr[4], addr[5]);
+	return CMD_STATUS_TRIGGERED;
+}
+
+static enum cmd_status cmd_debug_roam(const char *device_name,
+						char **argv, int argc)
+{
+	const struct proxy_interface *debug_i;
+	uint8_t addr[6];
+
+	if (argc < 1)
+		return CMD_STATUS_INVALID_ARGS;
+
+	debug_i = device_proxy_find(device_name, IWD_STATION_DEBUG_INTERFACE);
+	if (!debug_i) {
+		display_error("IWD not in developer mode");
+		return CMD_STATUS_INVALID_VALUE;
+	}
+
+	if (!util_string_to_address(argv[0], addr))
+		return CMD_STATUS_INVALID_ARGS;
+
+	proxy_interface_method_call(debug_i, "Roam", "ay",
+					check_errors_method_callback, 6,
+					addr[0], addr[1], addr[2],
+					addr[3], addr[4], addr[5]);
+	return CMD_STATUS_TRIGGERED;
+}
+
+static void get_byte_array(struct l_dbus_message_iter *variant, uint8_t *out,
+				unsigned int len)
+{
+	struct l_dbus_message_iter array;
+	uint32_t elems = 6;
+	uint8_t *a;
+
+	if (!l_dbus_message_iter_get_variant(variant, "ay", &array))
+		goto error;
+
+	if (!l_dbus_message_iter_get_fixed_array(&array, &a, &elems))
+		goto error;
+
+	if (elems != len)
+		goto error;
+
+	memcpy(out, a, len);
+
+	return;
+
+error:
+	display_error("Invalid Address element");
+}
+
+static void get_address(struct l_dbus_message_iter *variant,
+			char addr_out[static 18])
+{
+	char *s;
+
+	if (!l_dbus_message_iter_get_variant(variant, "s", &s))
+		goto error;
+
+	if (strlen(s) != 17)
+		goto error;
+
+	strcpy(addr_out, s);
+
+	return;
+
+error:
+	display_error("Invalid Address element");
+}
+
+static uint32_t get_u32(struct l_dbus_message_iter *variant)
+{
+	uint32_t u32 = 0;
+
+	if (!l_dbus_message_iter_get_variant(variant, "u", &u32))
+		display_error("Invalid Frequency element");
+
+	return u32;
+}
+
+static uint32_t get_u16(struct l_dbus_message_iter *variant)
+{
+	uint32_t u16 = 0;
+
+	if (!l_dbus_message_iter_get_variant(variant, "q", &u16))
+		display_error("Invalid Frequency element");
+
+	return u16;
+}
+
+static uint32_t get_i32(struct l_dbus_message_iter *variant)
+{
+	int32_t i32 = 0;
+
+	if (!l_dbus_message_iter_get_variant(variant, "i", &i32))
+		display_error("Invalid Frequency element");
+
+	return i32;
+}
+
+static void display_bss(struct bss *bss)
+{
+	char row[128];
+
+	sprintf(row, "%s%-*s  %s  %-*i  %-*u  %-*i  %02x%02x%02x",
+		MARGIN MARGIN, 4, "", bss->addr, 4, bss->rssi,
+		6, bss->frequency, 8, bss->rank,
+		bss->mde[0], bss->mde[1], bss->mde[2]);
+
+	display("%s\n", row);
+
+	return;
+}
+
+static void get_networks_method_callback(struct l_dbus_message *message,
+								void *user_data)
+{
+	struct proxy_interface *debug_i = user_data;
+	struct station_debug *debug = proxy_interface_get_data(debug_i);
+	struct l_dbus_message_iter iter;
+	struct l_dbus_message_iter variant;
+	struct l_dbus_message_iter array;
+	struct l_dbus_message_iter dict;
+	const char *key;
+
+	if (dbus_message_has_error(message))
+		return;
+
+	if (!l_dbus_message_get_arguments(message, "a{oaa{sv}}", &iter)) {
+		l_error("Failed to parse GetDiagnostics message");
+		return;
+	}
+
+	display_table_header("Available Networks (debug)",
+				"%s%-*s  %-*s  %-*s  %-*s  %-*s  %-*s  %-*s",
+				"", 2, "", 4, "SSID", 17, "BSSID", 4, "RSSI",
+				6, "Freq", 8, "Rank", 10, "MDE");
+
+	while (l_dbus_message_iter_next_entry(&iter, &key, &array)) {
+		struct network *network = l_new(struct network, 1);
+		const struct proxy_interface *net_i = network_get_proxy(key);
+
+		if (net_i)
+			network->ssid = l_strdup(network_get_name(net_i));
+		else
+			network->ssid = l_strdup("");
+
+		network->bss_list = l_queue_new();
+
+		if (!strcmp(key, "/hidden"))
+			display_table_row(MARGIN MARGIN, 3, 32, "Hidden BSS's",
+					18, "", 6, "");
+		else
+			display_table_row(MARGIN MARGIN, 3, 32, network->ssid,
+					18, "", 6, "");
+
+		while (l_dbus_message_iter_next_entry(&array, &dict)) {
+			struct bss *bss = l_new(struct bss, 1);
+
+			while (l_dbus_message_iter_next_entry(&dict, &key,
+								&variant)) {
+				if (!strcmp(key, "Address"))
+					get_address(&variant, bss->addr);
+				else if (!strcmp(key, "Frequency"))
+					bss->frequency = get_u32(&variant);
+				else if (!strcmp(key, "RSSI"))
+					bss->rssi = get_i32(&variant);
+				else if (!strcmp(key, "Rank"))
+					bss->rank = get_u16(&variant);
+				else if (!strcmp(key, "MDE"))
+					get_byte_array(&variant, bss->mde, 3);
+			}
+
+			display_bss(bss);
+
+			l_queue_push_tail(network->bss_list, bss);
+		}
+
+		l_queue_push_tail(debug->network_list, network);
+	}
+
+	display_table_footer();
+}
+
+static enum cmd_status cmd_debug_get_networks(const char *device_name,
+						char **argv, int argc)
+{
+	const struct proxy_interface *debug_i;
+
+	debug_i = device_proxy_find(device_name, IWD_STATION_DEBUG_INTERFACE);
+	if (!debug_i) {
+		display_error("IWD not in developer mode");
+		return CMD_STATUS_INVALID_VALUE;
+	}
+
+	proxy_interface_method_call(debug_i, "GetNetworks", "",
+					get_networks_method_callback);
+
+	return CMD_STATUS_TRIGGERED;
+}
+
+static char *connect_debug_cmd_arg_completion(const char *text, int state,
+						const char *device_name)
+{
+	const struct proxy_interface *debug_i;
+	struct station_debug *debug;
+	static const struct l_queue_entry *n_entry;
+	static const struct l_queue_entry *b_entry;
+	size_t len = strlen(text);
+
+	debug_i = device_proxy_find(device_name, IWD_STATION_DEBUG_INTERFACE);
+	if (!debug_i)
+		return NULL;
+
+	debug = proxy_interface_get_data(debug_i);
+
+	if (!state)
+		n_entry = l_queue_get_entries(debug->network_list);
+
+	while (n_entry) {
+		struct network *network = n_entry->data;
+
+		n_entry = n_entry->next;
+
+		if (!b_entry)
+			b_entry = l_queue_get_entries(network->bss_list);
+
+		while (b_entry) {
+			struct bss *bss = b_entry->data;
+
+			b_entry = b_entry->next;
+
+			if (len > strlen(bss->addr))
+				return NULL;
+
+			if (strncmp(text, bss->addr, len))
+				continue;
+
+			return l_strdup_printf(MAC, MAC_STR(bss->addr));
+		}
+	}
+
+	return NULL;
+}
+
+static const char *get_autoconnect_tostr(const void *data)
+{
+	const struct station_debug *debug = data;
+
+	return debug->autoconnect ? "on" : "off";
+}
+
+static void update_autoconnect(void *data, struct l_dbus_message_iter *variant)
+{
+	struct station_debug *debug = data;
+	bool value;
+
+	if (!l_dbus_message_iter_get_variant(variant, "b", &value)) {
+		debug->autoconnect = false;
+
+		return;
+	}
+
+	debug->autoconnect = value;
+}
+
+static const struct proxy_interface_property debug_properties[] = {
+	{ "AutoConnect",  "b", update_autoconnect,  get_autoconnect_tostr, true,
+			properties_builder_append_on_off_variant,
+			properties_on_off_opts },
+	{ }
+};
+
+static enum cmd_status cmd_debug_set_autoconnect(const char *device_name,
+						char **argv, int argc)
+{
+	const struct proxy_interface *proxy = device_proxy_find(device_name,
+						IWD_STATION_DEBUG_INTERFACE);
+
+	if (!proxy) {
+		display_error("IWD not in developer mode");
+		return CMD_STATUS_INVALID_VALUE;
+	}
+
+	if (argc != 1)
+		return CMD_STATUS_INVALID_ARGS;
+
+	if (!proxy_property_set(proxy, "AutoConnect", argv[0],
+						check_errors_method_callback))
+		return CMD_STATUS_INVALID_VALUE;
+
+	return CMD_STATUS_TRIGGERED;
+}
+
+static const struct command station_debug_commands[] = {
+	{ "<wlan>", "connect", "<bssid>", cmd_debug_connect,
+					"Connect to a specific BSS", false,
+					connect_debug_cmd_arg_completion },
+	{ "<wlan>", "roam", "<bssid>", cmd_debug_roam,
+					"Roam to a BSS", false },
+	{ "<wlan>", "get-networks", NULL, cmd_debug_get_networks,
+					"Get networks", true },
+	{ "<wlan>", "autoconnect", "on|off", cmd_debug_set_autoconnect,
+					"Set AutoConnect property", false },
+	{ }
+};
+
+static char *family_debug_arg_completion(const char *text, int state)
+{
+	return device_arg_completion(text, state, station_debug_commands,
+						IWD_STATION_DEBUG_INTERFACE);
+}
+
+static char *entity_debug_arg_completion(const char *text, int state)
+{
+	return command_entity_arg_completion(text, state,
+						station_debug_commands);
+}
+
+static struct command_family station_debug_command_family = {
+	.caption = "Station Debug",
+	.name = "debug",
+	.command_list = station_debug_commands,
+	.family_arg_completion = family_debug_arg_completion,
+	.entity_arg_completion = entity_debug_arg_completion,
+};
+
+static int station_debug_command_family_init(void)
+{
+	command_family_register(&station_debug_command_family);
+
+	return 0;
+}
+
+static void station_debug_command_family_exit(void)
+{
+	command_family_unregister(&station_debug_command_family);
+}
+
+COMMAND_FAMILY(station_debug_command_family, station_debug_command_family_init,
+					station_debug_command_family_exit)
+
+static const struct proxy_interface_type_ops station_debug_ops = {
+	.create = station_debug_create,
+	.destroy = station_debug_destroy,
+};
+
+static struct proxy_interface_type station_debug_interface_type = {
+	.interface = IWD_STATION_DEBUG_INTERFACE,
+	.ops = &station_debug_ops,
+	.properties = debug_properties,
+};
+
+static int station_debug_interface_init(void)
+{
+	proxy_interface_type_register(&station_debug_interface_type);
+
+	return 0;
+}
+
+static void station_debug_interface_exit(void)
+{
+	proxy_interface_type_unregister(&station_debug_interface_type);
+}
+
+INTERFACE_TYPE(station_debug_interface_type, station_debug_interface_init,
+					station_debug_interface_exit)
-- 
2.34.3

