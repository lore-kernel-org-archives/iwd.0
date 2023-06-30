Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6008174CA
	for <iwd@lists.linux.dev>; Fri, 30 Jun 2023 19:18:31 +0000 (UTC)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-440afc96271so827154137.3
        for <iwd@lists.linux.dev>; Fri, 30 Jun 2023 12:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688152710; x=1690744710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lh/KizBVGF3qVhS33nZOQPGoQ4WK7Amf1d6Oir1UUvw=;
        b=NmiLSjtYgSsqR9GgqPzsrO3tvMS/6N+kfhZ1bjR7ulaZcA+RWMRnYeUqJ27TWVmkAF
         fmvwUGvFrw3c9XqOjpeNgzgflNrsoeN9U2tznPiX7LyqqzksfqgM5WHgqpRKkIhvxnVn
         OpbzHBtvQcCgGp2+QgxTRoS/sbsAM/gkD09p/L0HfHJPm1qEcLcJDu9nmrijep/s+jH8
         ULd9yuP8Dpy0vg/TC9fFDYZ3+PwfNFg107qLMpObTsDEMRSMhI8hVNYgMwBPfR77f8LE
         OL7lSkjq0eJ/YqAmJUE+ZpV6bdoOpaq52/0n1M15yFVrJnDuMf1C1HWGKV1TDv97tngG
         3F9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688152710; x=1690744710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lh/KizBVGF3qVhS33nZOQPGoQ4WK7Amf1d6Oir1UUvw=;
        b=c6GtXYCAACJHGHY+qf6TrLyCjt8Kx8oxF+zJ/wAoO/FQShgx/LsljUs5Fj4Vwiqk/V
         0xFeBviFBxt6gJIVFsK+HiVvhGOUtVvQkquC5Kcq4Q7srWBR5XMf/jqeXqiUIK6OYSJ2
         uaGz2uHYfqn6a7TlCCKTLRnBQw2IQa999iNN9Sd/1xObMjLPV4KiIrCF8ucnQj6/piCf
         lVNxTLysHE/tPxt6AOKgM3EmHTAC4vhumhdGtoIUpL+oNQgAq/Sb8XDCRI7voqsckaAy
         oFmXus+TiLb4wuZUwGIrNfV8u++L4dKCXP/yUBovIOFXQfCqGa4Q7750fUJFpqlQhb8m
         aymw==
X-Gm-Message-State: ABy/qLaTxjiN7knasbA8VAYnwLL7VC0wywhFtY4s49Y3jlimicz5vM7u
	XSEHk/tLKQqexiOY3JXsB/61ubIq+cY=
X-Google-Smtp-Source: APBJJlFYqkQ2cVNOA6eXeV+uNuKGX9pjbDXtR6h2IuK4wLPugPmPZlKvnRL23zD7F6yQ0xlIY4R+FQ==
X-Received: by 2002:a05:6102:407:b0:443:5d36:4a75 with SMTP id d7-20020a056102040700b004435d364a75mr2836267vsq.31.1688152709838;
        Fri, 30 Jun 2023 12:18:29 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id dr16-20020a05621408f000b00632209f7157sm8056605qvb.143.2023.06.30.12.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 12:18:29 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 4/5] hwsim: refactor rules processing into separate file
Date: Fri, 30 Jun 2023 12:18:11 -0700
Message-Id: <20230630191812.2884637-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630191812.2884637-1-prestwoj@gmail.com>
References: <20230630191812.2884637-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This extends hwsim to allow for external/custom frame processing
by allowing separate modules to register frame callbacks and
expose APIs to send frames back to the kernel.

One benefit of this is the hwsim rules code can be separated out
which reduces the size of hwsim.c and isolates that functionality.
Another benefit is that additional processing modules could be
dropped in cleanly without modifying existing source code.

The goal here is to isolate the basic core functions of hwsim:
 - Create, list, destroy radios
 - Register to medium to kernel
 - Track radios and interface creation/removal
---
 Makefile.am   |    5 +-
 tools/hwsim.c | 1091 +++----------------------------------------------
 tools/hwsim.h |   99 +++++
 tools/rules.c | 1017 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1176 insertions(+), 1036 deletions(-)
 create mode 100644 tools/hwsim.h
 create mode 100644 tools/rules.c

diff --git a/Makefile.am b/Makefile.am
index fcdd342a..3dd426d6 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -406,7 +406,10 @@ tools_hwsim_SOURCES = tools/hwsim.c src/mpdu.h \
 					src/common.h src/common.c \
 					src/band.h src/band.c \
 					src/crypto.h src/crypto.c \
-					src/dbus.h src/dbus.c
+					src/dbus.h src/dbus.c \
+					src/watchlist.h src/watchlist.c \
+					src/module.h src/module.c \
+					tools/rules.c
 
 tools_hwsim_LDADD = $(ell_ldadd)
 tools_hwsim_CFLAGS = -DDBUS_SERVICE=\"net.connman.hwsim\"
diff --git a/tools/hwsim.c b/tools/hwsim.c
index 402b3622..7973eaf6 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -46,14 +46,15 @@
 #include "src/nl80211util.h"
 #include "src/nl80211cmd.h"
 #include "src/dbus.h"
+#include "src/watchlist.h"
+#include "src/module.h"
+#include "hwsim.h"
 
 #define HWSIM_SERVICE "net.connman.hwsim"
 
 #define HWSIM_RADIO_MANAGER_INTERFACE HWSIM_SERVICE ".RadioManager"
 #define HWSIM_RADIO_INTERFACE HWSIM_SERVICE ".Radio"
 #define HWSIM_INTERFACE_INTERFACE HWSIM_SERVICE ".Interface"
-#define HWSIM_RULE_MANAGER_INTERFACE HWSIM_SERVICE ".RuleManager"
-#define HWSIM_RULE_INTERFACE HWSIM_SERVICE ".Rule"
 
 enum {
 	HWSIM_CMD_UNSPEC,
@@ -112,37 +113,7 @@ enum {
 		(1 << NL80211_IFTYPE_MESH_POINT) \
 	)
 
-enum hwsim_tx_control_flags {
-	HWSIM_TX_CTL_REQ_TX_STATUS		= 1 << 0,
-	HWSIM_TX_CTL_NO_ACK			= 1 << 1,
-	HWSIM_TX_STAT_ACK			= 1 << 2,
-};
-
 #define IEEE80211_TX_RATE_TABLE_SIZE	4
-#define HWSIM_DELAY_MIN_MS		1
-#define HWSIM_MAX_PREFIX_LEN		128
-
-struct hwsim_rule {
-	unsigned int id;
-	uint8_t source[ETH_ALEN];
-	uint8_t destination[ETH_ALEN];
-	bool source_any : 1;
-	bool destination_any : 1;
-	bool bidirectional : 1;
-	bool drop : 1;
-	bool drop_ack : 1;
-	bool enabled : 1;
-	uint32_t frequency;
-	int priority;
-	int signal;
-	int delay;
-	uint8_t *prefix;
-	size_t prefix_len;
-	uint8_t *match;
-	size_t match_len;
-	uint16_t match_offset;
-	int match_times; /* negative value indicates unused */
-};
 
 struct hwsim_support {
 	const char *name;
@@ -169,8 +140,7 @@ static bool p2p_attr;
 static bool no_register = false;
 static const char *radio_name_attr;
 static struct l_dbus *dbus;
-static struct l_queue *rules;
-static unsigned int next_rule_id;
+static struct watchlist hwsim_watch;
 
 static uint32_t hwsim_iftypes = HWSIM_DEFAULT_IFTYPES;
 static const uint32_t hwsim_supported_ciphers[] = {
@@ -222,6 +192,12 @@ static void do_debug(const char *str, void *user_data)
 	l_info("%s%s", prefix, str);
 }
 
+unsigned int hwsim_watch_register(hwsim_frame_cb_t frame_cb, void *user_data,
+			hwsim_destroy_cb_t destroy)
+{
+	return watchlist_add(&hwsim_watch, frame_cb, user_data, destroy);
+}
+
 static void hwsim_disable_support(const char *disable,
 		const struct hwsim_support *map, uint32_t *mask)
 {
@@ -420,30 +396,6 @@ static void list_callback(struct l_genl_msg *msg, void *user_data)
 		l_free(hwname);
 }
 
-struct radio_info_rec {
-	int32_t id;
-	uint32_t wiphy_id;
-	char alpha2[2];
-	bool p2p;
-	bool custom_regdom;
-	uint32_t regdom_idx;
-	int channels;
-	uint8_t addrs[2][ETH_ALEN];
-	char *name;
-	bool ap_only;
-	struct l_dbus_message *pending;
-	uint32_t cmd_id;
-};
-
-struct interface_info_rec {
-	uint32_t id;
-	struct radio_info_rec *radio_rec;
-	uint8_t addr[ETH_ALEN];
-	char *name;
-	uint32_t iftype;
-	int ref;
-};
-
 static struct l_queue *radio_info;
 static struct l_queue *interface_info;
 
@@ -542,15 +494,6 @@ static const char *interface_get_path(const struct interface_info_rec *rec)
 	return path;
 }
 
-static const char *rule_get_path(struct hwsim_rule *rule)
-{
-	static char path[16];
-
-	snprintf(path, sizeof(path), "/rule%u", rule->id);
-
-	return path;
-}
-
 static bool parse_addresses(const uint8_t *buf, size_t len,
 				struct radio_info_rec *rec)
 {
@@ -1161,123 +1104,13 @@ static void rtnl_link_notify(uint16_t type, const void *data, uint32_t len,
 	}
 }
 
-struct hwsim_tx_info {
-	int8_t idx;
-	uint8_t count;
-};
-
-struct hwsim_frame {
-	int refcount;
-	uint8_t src_ether_addr[ETH_ALEN];
-	uint8_t dst_ether_addr[ETH_ALEN];
-	struct radio_info_rec *src_radio;
-	struct radio_info_rec *ack_radio;
-	uint32_t flags;
-	const uint64_t *cookie;
-	int32_t signal;
-	uint32_t frequency;
-	uint16_t tx_info_len;
-	const struct hwsim_tx_info *tx_info;
-	uint16_t payload_len;
-	const uint8_t *payload;
-	bool acked;
-	struct l_genl_msg *msg;
-	int pending_callback_count;
-};
-
-static bool radio_match_addr(const struct radio_info_rec *radio,
-				const uint8_t *addr)
-{
-	if (!radio || util_is_broadcast_address(addr))
-		return !radio && util_is_broadcast_address(addr);
-
-	return !memcmp(addr, radio->addrs[0], ETH_ALEN) ||
-		!memcmp(addr, radio->addrs[1], ETH_ALEN);
-}
-
-static void process_rules(const struct radio_info_rec *src_radio,
-				const struct radio_info_rec *dst_radio,
-				struct hwsim_frame *frame, bool ack, bool *drop,
-				uint32_t *delay)
-{
-	const struct l_queue_entry *rule_entry;
-
-	for (rule_entry = l_queue_get_entries(rules); rule_entry;
-			rule_entry = rule_entry->next) {
-		struct hwsim_rule *rule = rule_entry->data;
-
-		if (!rule->enabled)
-			continue;
-
-		if (!rule->source_any &&
-				!radio_match_addr(src_radio, rule->source) &&
-				(!rule->bidirectional ||
-				 !radio_match_addr(dst_radio, rule->source)))
-			continue;
-
-		if (!rule->destination_any &&
-				!radio_match_addr(dst_radio,
-							rule->destination) &&
-				(!rule->bidirectional ||
-				 !radio_match_addr(src_radio,
-							rule->destination)))
-			continue;
-
-		/*
-		 * If source matches only because rule->bidirectional was
-		 * true, make sure destination is "any" or matches source
-		 * radio's address.
-		 */
-		if (!rule->source_any && rule->bidirectional &&
-				radio_match_addr(dst_radio, rule->source))
-			if (!rule->destination_any &&
-					!radio_match_addr(dst_radio,
-							rule->destination))
-				continue;
-
-		if (rule->frequency && rule->frequency != frame->frequency)
-			continue;
-
-		if (rule->prefix && frame->payload_len >= rule->prefix_len) {
-			if (memcmp(rule->prefix, frame->payload,
-					rule->prefix_len) != 0)
-				continue;
-		}
-
-		if (rule->match && frame->payload_len >=
-					rule->match_len + rule->match_offset) {
-			if (memcmp(rule->match,
-					frame->payload + rule->match_offset,
-					rule->match_len))
-				continue;
-		}
-
-		/* Rule deemed to match frame, apply any changes */
-		if (rule->match_times == 0)
-			continue;
-
-		if (rule->signal)
-			frame->signal = rule->signal / 100;
-
-		/* Don't drop if this is an ACK, unless drop_ack is set */
-		if (!ack || (ack && rule->drop_ack))
-			*drop = rule->drop;
-
-		if (delay)
-			*delay = rule->delay;
-
-		if (rule->match_times > 0)
-			rule->match_times--;
-	}
-}
-
 struct send_frame_info {
 	struct hwsim_frame *frame;
 	struct radio_info_rec *radio;
 	void *user_data;
 };
 
-static bool send_frame_tx_info(struct hwsim_frame *frame)
+bool hwsim_send_tx_info(struct hwsim_frame *frame)
 {
 	struct l_genl_msg *msg;
 
@@ -1299,92 +1132,47 @@ static bool send_frame_tx_info(struct hwsim_frame *frame)
 	return true;
 }
 
-static bool send_frame(struct send_frame_info *info,
-			l_genl_msg_func_t callback,
-			l_genl_destroy_func_t destroy)
+uint32_t hwsim_send_frame(struct hwsim_frame *frame,
+				struct radio_info_rec *radio,
+				l_genl_msg_func_t callback,
+				void *user_data,
+				l_genl_destroy_func_t destroy)
 {
 	struct l_genl_msg *msg;
 	uint32_t rx_rate = 2;
-	unsigned int id;
 
 	msg = l_genl_msg_new_sized(HWSIM_CMD_FRAME,
-					128 + info->frame->payload_len);
+					128 + frame->payload_len);
 	l_genl_msg_append_attr(msg, HWSIM_ATTR_ADDR_RECEIVER, ETH_ALEN,
-				info->radio->addrs[1]);
-	l_genl_msg_append_attr(msg, HWSIM_ATTR_FRAME, info->frame->payload_len,
-				info->frame->payload);
+				radio->addrs[1]);
+	l_genl_msg_append_attr(msg, HWSIM_ATTR_FRAME, frame->payload_len,
+				frame->payload);
 	l_genl_msg_append_attr(msg, HWSIM_ATTR_RX_RATE, 4,
 				&rx_rate);
 	l_genl_msg_append_attr(msg, HWSIM_ATTR_SIGNAL, 4,
-				&info->frame->signal);
+				&frame->signal);
 	l_genl_msg_append_attr(msg, HWSIM_ATTR_FREQ, 4,
-				&info->frame->frequency);
+				&frame->frequency);
 
-	id = l_genl_family_send(hwsim, msg, callback, info, destroy);
-	if (!id) {
-		l_error("Sending HWSIM_CMD_FRAME failed");
-		return false;
-	}
-
-	return true;
+	return l_genl_family_send(hwsim, msg, callback, user_data, destroy);
 }
 
-static struct hwsim_frame *hwsim_frame_ref(struct hwsim_frame *frame)
+struct hwsim_frame *hwsim_frame_ref(struct hwsim_frame *frame)
 {
 	__sync_fetch_and_add(&frame->refcount, 1);
 
 	return frame;
 }
 
-static void hwsim_frame_unref(struct hwsim_frame *frame)
+void hwsim_frame_unref(struct hwsim_frame *frame)
 {
 	if (__sync_sub_and_fetch(&frame->refcount, 1))
 		return;
 
-	if (!frame->pending_callback_count) {
-		/*
-		 * Apparently done with this frame, send tx info and signal
-		 * the returning of an ACK frame in the opposite direction.
-		 */
-
-		if (!(frame->flags & HWSIM_TX_CTL_NO_ACK) && frame->acked) {
-			bool drop = false;
-
-			process_rules(frame->ack_radio, frame->src_radio,
-					frame, true, &drop, NULL);
-
-			if (!drop)
-				frame->flags |= HWSIM_TX_STAT_ACK;
-		}
-
-		if (frame->src_radio)
-			send_frame_tx_info(frame);
-	}
-
 	l_genl_msg_unref(frame->msg);
 	l_free(frame);
 }
 
-static void send_frame_callback(struct l_genl_msg *msg, void *user_data)
-{
-	struct send_frame_info *info = user_data;
-
-	if (l_genl_msg_get_error(msg) == 0) {
-		info->frame->acked = true;
-		info->frame->ack_radio = info->radio;
-	}
-
-	info->frame->pending_callback_count--;
-}
-
-static void send_frame_destroy(void *user_data)
-{
-	struct send_frame_info *info = user_data;
-
-	hwsim_frame_unref(info->frame);
-	l_free(info);
-}
-
 static void send_custom_frame_callback(struct l_genl_msg *msg, void *user_data)
 {
 	struct send_frame_info *info = user_data;
@@ -1438,8 +1226,8 @@ static bool send_custom_frame(const uint8_t *addr, uint32_t freq,
 	if (!info->radio)
 		goto error;
 
-	if (!send_frame(info, send_custom_frame_callback,
-			send_custom_frame_destroy))
+	if (!hwsim_send_frame(frame, info->radio, send_custom_frame_callback,
+				info, send_custom_frame_destroy))
 		goto error;
 
 	return true;
@@ -1451,118 +1239,6 @@ error:
 	return false;
 }
 
-static void frame_delay_callback(struct l_timeout *timeout, void *user_data)
-{
-	struct send_frame_info *send_info = user_data;
-
-	if (send_frame(send_info, send_frame_callback,
-					send_frame_destroy))
-		send_info->frame->pending_callback_count++;
-	else
-		send_frame_destroy(send_info);
-
-	if (timeout)
-		l_timeout_remove(timeout);
-}
-
-
-/*
- * Process frames in a similar way to how the kernel built-in hwsim medium
- * does this, with an additional optimization for unicast frames and
- * additional modifications to frames decided by user-configurable rules.
- */
-static void process_frame(struct hwsim_frame *frame)
-{
-	const struct l_queue_entry *entry;
-	bool drop_mcast = false;
-	bool beacon = false;
-
-	if (util_is_broadcast_address(frame->dst_ether_addr))
-		process_rules(frame->src_radio, NULL, frame, false,
-				&drop_mcast, NULL);
-
-	if (frame->payload_len >= 2 &&
-			frame->payload[0] == 0x80 &&
-			frame->payload[1] == 0x00)
-		beacon = true;
-
-	for (entry = l_queue_get_entries(radio_info); entry;
-			entry = entry->next) {
-		struct radio_info_rec *radio = entry->data;
-		struct send_frame_info *send_info;
-		bool drop = drop_mcast;
-		uint32_t delay = 0;
-		const struct l_queue_entry *i;
-
-		if (radio == frame->src_radio)
-			continue;
-
-		/*
-		 * The kernel hwsim medium passes multicast frames to all
-		 * radios that are on the same frequency as this frame but
-		 * the netlink medium API only lets userspace pass frames to
-		 * radios by known hardware address.  It does check that the
-		 * receiving radio is on the same frequency though so we can
-		 * send to all known addresses.
-		 *
-		 * If the frame's Receiver Address (RA) is a multicast
-		 * address, then send the frame to every radio that is
-		 * registered.  If it's a unicast address then optimize
-		 * by only forwarding the frame to the radios that have
-		 * at least one interface with this specific address.
-		 */
-		if (!util_is_broadcast_address(frame->dst_ether_addr)) {
-			for (i = l_queue_get_entries(interface_info);
-					i; i = i->next) {
-				struct interface_info_rec *interface = i->data;
-
-				if (interface->radio_rec != radio)
-					continue;
-
-				if (!memcmp(interface->addr,
-						frame->dst_ether_addr,
-						ETH_ALEN))
-					break;
-			}
-
-			if (!i)
-				continue;
-		}
-
-		process_rules(frame->src_radio, radio, frame, false,
-				&drop, &delay);
-
-		if (drop)
-			continue;
-
-		/*
-		 * Don't bother sending beacons to other AP interfaces
-		 * if the AP interface is the only one on this phy
-		 */
-		if (beacon && radio->ap_only)
-			continue;
-
-		send_info = l_new(struct send_frame_info, 1);
-		send_info->radio = radio;
-		send_info->frame = hwsim_frame_ref(frame);
-
-		if (delay) {
-			if (!l_timeout_create_ms(delay, frame_delay_callback,
-							send_info, NULL)) {
-				l_error("Error delaying frame %ums, "
-						"frame will be dropped", delay);
-				send_frame_destroy(send_info);
-			}
-		} else
-			frame_delay_callback(NULL, send_info);
-
-	}
-
-	hwsim_frame_unref(frame);
-}
-
-
-
 static void hwsim_frame_event(struct l_genl_msg *msg)
 {
 	struct hwsim_frame *frame;
@@ -1649,17 +1325,6 @@ static void hwsim_frame_event(struct l_genl_msg *msg)
 	frame->signal = -30;
 	frame->msg = l_genl_msg_ref(msg);
 	frame->refcount = 1;
-
-	frame->src_radio = l_queue_find(radio_info, radio_info_match_addr1,
-					transmitter);
-	if (!frame->src_radio) {
-		l_error("Unknown transmitter address %s, probably need to "
-			"update radio dump code for this kernel",
-			util_address_to_string(transmitter));
-		hwsim_frame_unref(frame);
-		return;
-	}
-
 	frame->frequency = *(uint32_t *) freq;
 	frame->flags = *(uint32_t *) flags;
 
@@ -1668,7 +1333,12 @@ static void hwsim_frame_event(struct l_genl_msg *msg)
 	memcpy(frame->src_ether_addr, mpdu->address_2, ETH_ALEN);
 	memcpy(frame->dst_ether_addr, mpdu->address_1, ETH_ALEN);
 
-	process_frame(frame);
+	frame->src_radio = l_queue_find(radio_info, radio_info_match_addr1,
+					transmitter);
+
+	WATCHLIST_NOTIFY(&hwsim_watch, hwsim_frame_cb_t, frame);
+
+	hwsim_frame_unref(frame);
 }
 
 static bool get_tx_rx_addrs(struct l_genl_msg *msg, const uint8_t **tx_out,
@@ -2170,653 +1840,6 @@ static void setup_interface_interface(struct l_dbus_interface *interface)
 					interface_property_get_address, NULL);
 }
 
-static int rule_compare_priority(const void *a, const void *b, void *user)
-{
-	const struct hwsim_rule *rule_a = a;
-	const struct hwsim_rule *rule_b = b;
-
-	return (rule_a->priority > rule_b->priority) ? 1 : -1;
-}
-
-static struct l_dbus_message *rule_add(struct l_dbus *dbus,
-					struct l_dbus_message *message,
-					void *user_data)
-{
-	struct hwsim_rule *rule;
-	const char *path;
-	struct l_dbus_message *reply;
-
-	rule = l_new(struct hwsim_rule, 1);
-	rule->id = next_rule_id++;
-	rule->source_any = true;
-	rule->destination_any = true;
-	rule->delay = 0;
-	rule->enabled = false;
-	rule->match_times = -1;
-	rule->drop_ack = true;
-
-	if (!rules)
-		rules = l_queue_new();
-
-	l_queue_insert(rules, rule, rule_compare_priority, NULL);
-	path = rule_get_path(rule);
-
-	if (!l_dbus_object_add_interface(dbus, path,
-					HWSIM_RULE_INTERFACE, rule))
-		l_info("Unable to add the %s interface to %s",
-				HWSIM_RULE_INTERFACE, path);
-
-	if (!l_dbus_object_add_interface(dbus, path,
-					L_DBUS_INTERFACE_PROPERTIES, NULL))
-		l_info("Unable to add the %s interface to %s",
-				L_DBUS_INTERFACE_PROPERTIES, path);
-
-	reply = l_dbus_message_new_method_return(message);
-	l_dbus_message_set_arguments(reply, "o", path);
-
-	return reply;
-}
-
-static void setup_rule_manager_interface(struct l_dbus_interface *interface)
-{
-	l_dbus_interface_method(interface, "AddRule", 0,
-				rule_add, "o", "", "path");
-}
-
-static void destroy_rule(void *user_data)
-{
-	struct hwsim_rule *rule = user_data;
-
-	if (rule->prefix)
-		l_free(rule->prefix);
-
-	if (rule->match)
-		l_free(rule->match);
-
-	l_free(rule);
-}
-
-static struct l_dbus_message *rule_remove(struct l_dbus *dbus,
-						struct l_dbus_message *message,
-						void *user_data)
-{
-	struct hwsim_rule *rule = user_data;
-	const char *path;
-
-	path = rule_get_path(rule);
-	l_queue_remove(rules, rule);
-
-	destroy_rule(rule);
-
-	l_dbus_unregister_object(dbus, path);
-
-	return l_dbus_message_new_method_return(message);
-}
-
-static bool rule_property_get_source(struct l_dbus *dbus,
-					struct l_dbus_message *message,
-					struct l_dbus_message_builder *builder,
-					void *user_data)
-{
-	struct hwsim_rule *rule = user_data;
-	const char *str;
-
-	if (rule->source_any)
-		str = "any";
-	else
-		str = util_address_to_string(rule->source);
-
-	l_dbus_message_builder_append_basic(builder, 's', str);
-
-	return true;
-}
-
-static struct l_dbus_message *rule_property_set_source(struct l_dbus *dbus,
-					struct l_dbus_message *message,
-					struct l_dbus_message_iter *new_value,
-					l_dbus_property_complete_cb_t complete,
-					void *user_data)
-{
-	struct hwsim_rule *rule = user_data;
-	const char *str;
-
-	if (!l_dbus_message_iter_get_variant(new_value, "s", &str))
-		return dbus_error_invalid_args(message);
-
-	if (!strcmp(str, "any"))
-		rule->source_any = true;
-	else {
-		if (!util_string_to_address(str, rule->source))
-			return dbus_error_invalid_args(message);
-
-		rule->source_any = false;
-	}
-
-	return l_dbus_message_new_method_return(message);
-}
-
-static bool rule_property_get_destination(struct l_dbus *dbus,
-					struct l_dbus_message *message,
-					struct l_dbus_message_builder *builder,
-					void *user_data)
-{
-	struct hwsim_rule *rule = user_data;
-	const char *str;
-
-	if (rule->destination_any)
-		str = "any";
-	else if (util_is_broadcast_address(rule->destination))
-		str = "multicast";
-	else
-		str = util_address_to_string(rule->destination);
-
-	l_dbus_message_builder_append_basic(builder, 's', str);
-
-	return true;
-}
-
-static struct l_dbus_message *rule_property_set_destination(
-					struct l_dbus *dbus,
-					struct l_dbus_message *message,
-					struct l_dbus_message_iter *new_value,
-					l_dbus_property_complete_cb_t complete,
-					void *user_data)
-{
-	struct hwsim_rule *rule = user_data;
-	const char *str;
-
-	if (!l_dbus_message_iter_get_variant(new_value, "s", &str))
-		return dbus_error_invalid_args(message);
-
-	if (!strcmp(str, "any"))
-		rule->destination_any = true;
-	else if (!strcmp(str, "multicast")) {
-		rule->destination[0] = 0x80;
-		rule->destination_any = false;
-	} else {
-		if (!util_string_to_address(str, rule->destination))
-			return dbus_error_invalid_args(message);
-
-		rule->destination_any = false;
-	}
-
-	return l_dbus_message_new_method_return(message);
-}
-
-static bool rule_property_get_bidirectional(struct l_dbus *dbus,
-					struct l_dbus_message *message,
-					struct l_dbus_message_builder *builder,
-					void *user_data)
-{
-	struct hwsim_rule *rule = user_data;
-	bool bval = rule->bidirectional;
-
-	l_dbus_message_builder_append_basic(builder, 'b', &bval);
-
-	return true;
-}
-
-static struct l_dbus_message *rule_property_set_bidirectional(
-					struct l_dbus *dbus,
-					struct l_dbus_message *message,
-					struct l_dbus_message_iter *new_value,
-					l_dbus_property_complete_cb_t complete,
-					void *user_data)
-{
-	struct hwsim_rule *rule = user_data;
-	bool bval;
-
-	if (!l_dbus_message_iter_get_variant(new_value, "b", &bval))
-		return dbus_error_invalid_args(message);
-
-	rule->bidirectional = bval;
-
-	return l_dbus_message_new_method_return(message);
-}
-
-static bool rule_property_get_frequency(struct l_dbus *dbus,
-					struct l_dbus_message *message,
-					struct l_dbus_message_builder *builder,
-					void *user_data)
-{
-	struct hwsim_rule *rule = user_data;
-
-	l_dbus_message_builder_append_basic(builder, 'u', &rule->frequency);
-
-	return true;
-}
-
-static struct l_dbus_message *rule_property_set_frequency(struct l_dbus *dbus,
-					struct l_dbus_message *message,
-					struct l_dbus_message_iter *new_value,
-					l_dbus_property_complete_cb_t complete,
-					void *user_data)
-{
-	struct hwsim_rule *rule = user_data;
-
-	if (!l_dbus_message_iter_get_variant(new_value, "u", &rule->frequency))
-		return dbus_error_invalid_args(message);
-
-	return l_dbus_message_new_method_return(message);
-}
-
-static bool rule_property_get_priority(struct l_dbus *dbus,
-					struct l_dbus_message *message,
-					struct l_dbus_message_builder *builder,
-					void *user_data)
-{
-	struct hwsim_rule *rule = user_data;
-	int16_t intval = rule->priority;
-
-	l_dbus_message_builder_append_basic(builder, 'n', &intval);
-
-	return true;
-}
-
-static struct l_dbus_message *rule_property_set_priority(struct l_dbus *dbus,
-					struct l_dbus_message *message,
-					struct l_dbus_message_iter *new_value,
-					l_dbus_property_complete_cb_t complete,
-					void *user_data)
-{
-	struct hwsim_rule *rule = user_data;
-	int16_t intval;
-
-	if (!l_dbus_message_iter_get_variant(new_value, "n", &intval))
-		return dbus_error_invalid_args(message);
-
-	rule->priority = intval;
-	l_queue_remove(rules, rule);
-	l_queue_insert(rules, rule, rule_compare_priority, NULL);
-
-	return l_dbus_message_new_method_return(message);
-}
-
-static bool rule_property_get_signal(struct l_dbus *dbus,
-					struct l_dbus_message *message,
-					struct l_dbus_message_builder *builder,
-					void *user_data)
-{
-	struct hwsim_rule *rule = user_data;
-	int16_t intval = rule->signal;
-
-	l_dbus_message_builder_append_basic(builder, 'n', &intval);
-
-	return true;
-}
-
-static struct l_dbus_message *rule_property_set_signal(struct l_dbus *dbus,
-					struct l_dbus_message *message,
-					struct l_dbus_message_iter *new_value,
-					l_dbus_property_complete_cb_t complete,
-					void *user_data)
-{
-	struct hwsim_rule *rule = user_data;
-	int16_t intval;
-
-	if (!l_dbus_message_iter_get_variant(new_value, "n", &intval) ||
-			intval > 0 || intval < -10000)
-		return dbus_error_invalid_args(message);
-
-	rule->signal = intval;
-
-	return l_dbus_message_new_method_return(message);
-}
-
-static bool rule_property_get_drop(struct l_dbus *dbus,
-					struct l_dbus_message *message,
-					struct l_dbus_message_builder *builder,
-					void *user_data)
-{
-	struct hwsim_rule *rule = user_data;
-	bool bval = rule->drop;
-
-	l_dbus_message_builder_append_basic(builder, 'b', &bval);
-
-	return true;
-}
-
-static struct l_dbus_message *rule_property_set_drop(
-					struct l_dbus *dbus,
-					struct l_dbus_message *message,
-					struct l_dbus_message_iter *new_value,
-					l_dbus_property_complete_cb_t complete,
-					void *user_data)
-{
-	struct hwsim_rule *rule = user_data;
-	bool bval;
-
-	if (!l_dbus_message_iter_get_variant(new_value, "b", &bval))
-		return dbus_error_invalid_args(message);
-
-	rule->drop = bval;
-
-	return l_dbus_message_new_method_return(message);
-}
-
-static bool rule_property_get_delay(struct l_dbus *dbus,
-					struct l_dbus_message *message,
-					struct l_dbus_message_builder *builder,
-					void *user_data)
-{
-	struct hwsim_rule *rule = user_data;
-
-	l_dbus_message_builder_append_basic(builder, 'u', &rule->delay);
-
-	return true;
-}
-
-static struct l_dbus_message *rule_property_set_delay(
-					struct l_dbus *dbus,
-					struct l_dbus_message *message,
-					struct l_dbus_message_iter *new_value,
-					l_dbus_property_complete_cb_t complete,
-					void *user_data)
-{
-	struct hwsim_rule *rule = user_data;
-	uint32_t val;
-
-	if (!l_dbus_message_iter_get_variant(new_value, "u", &val) ||
-				val < HWSIM_DELAY_MIN_MS)
-		return dbus_error_invalid_args(message);
-
-	rule->delay = val;
-
-	return l_dbus_message_new_method_return(message);
-}
-
-static bool rule_property_get_prefix(struct l_dbus *dbus,
-					struct l_dbus_message *message,
-					struct l_dbus_message_builder *builder,
-					void *user_data)
-{
-	struct hwsim_rule *rule = user_data;
-	size_t i;
-
-	l_dbus_message_builder_enter_array(builder, "y");
-
-	for (i = 0; i < rule->prefix_len; i++)
-		l_dbus_message_builder_append_basic(builder, 'y',
-							rule->prefix + i);
-
-	l_dbus_message_builder_leave_array(builder);
-
-	return true;
-}
-
-static struct l_dbus_message *rule_property_set_prefix(
-					struct l_dbus *dbus,
-					struct l_dbus_message *message,
-					struct l_dbus_message_iter *new_value,
-					l_dbus_property_complete_cb_t complete,
-					void *user_data)
-{
-	struct hwsim_rule *rule = user_data;
-	struct l_dbus_message_iter iter;
-	const uint8_t *prefix;
-	uint32_t len;
-
-	if (!l_dbus_message_iter_get_variant(new_value, "ay", &iter))
-		goto invalid_args;
-
-	if (!l_dbus_message_iter_get_fixed_array(&iter,
-						(const void **)&prefix, &len))
-		goto invalid_args;
-
-	if (len > HWSIM_MAX_PREFIX_LEN)
-		goto invalid_args;
-
-	if (rule->prefix)
-		l_free(rule->prefix);
-
-	rule->prefix = l_memdup(prefix, len);
-	rule->prefix_len = len;
-
-	return l_dbus_message_new_method_return(message);
-
-invalid_args:
-	return dbus_error_invalid_args(message);
-}
-
-static bool rule_property_get_match(struct l_dbus *dbus,
-					struct l_dbus_message *message,
-					struct l_dbus_message_builder *builder,
-					void *user_data)
-{
-	struct hwsim_rule *rule = user_data;
-	size_t i;
-
-	l_dbus_message_builder_enter_array(builder, "y");
-
-	for (i = 0; i < rule->match_len; i++)
-		l_dbus_message_builder_append_basic(builder, 'y',
-							rule->match + i);
-
-	l_dbus_message_builder_leave_array(builder);
-
-	return true;
-}
-
-static struct l_dbus_message *rule_property_set_match(
-					struct l_dbus *dbus,
-					struct l_dbus_message *message,
-					struct l_dbus_message_iter *new_value,
-					l_dbus_property_complete_cb_t complete,
-					void *user_data)
-{
-	struct hwsim_rule *rule = user_data;
-	struct l_dbus_message_iter iter;
-	const uint8_t *match;
-	uint32_t len;
-
-	if (!l_dbus_message_iter_get_variant(new_value, "ay", &iter))
-		goto invalid_args;
-
-	if (!l_dbus_message_iter_get_fixed_array(&iter,
-						(const void **)&match, &len))
-		goto invalid_args;
-
-	if (len > HWSIM_MAX_PREFIX_LEN)
-		goto invalid_args;
-
-	if (rule->match)
-		l_free(rule->match);
-
-	rule->match = l_memdup(match, len);
-	rule->match_len = len;
-
-	return l_dbus_message_new_method_return(message);
-
-invalid_args:
-	return dbus_error_invalid_args(message);
-}
-
-static bool rule_property_get_match_offset(struct l_dbus *dbus,
-					struct l_dbus_message *message,
-					struct l_dbus_message_builder *builder,
-					void *user_data)
-{
-	struct hwsim_rule *rule = user_data;
-	uint16_t val = rule->match_offset;
-
-	l_dbus_message_builder_append_basic(builder, 'q', &val);
-
-	return true;
-}
-
-static struct l_dbus_message *rule_property_set_match_offset(
-					struct l_dbus *dbus,
-					struct l_dbus_message *message,
-					struct l_dbus_message_iter *new_value,
-					l_dbus_property_complete_cb_t complete,
-					void *user_data)
-{
-	struct hwsim_rule *rule = user_data;
-	uint16_t val;
-
-	if (!l_dbus_message_iter_get_variant(new_value, "q", &val))
-		return dbus_error_invalid_args(message);
-
-	rule->match_offset = val;
-
-	return l_dbus_message_new_method_return(message);
-}
-
-static bool rule_property_get_enabled(struct l_dbus *dbus,
-					struct l_dbus_message *message,
-					struct l_dbus_message_builder *builder,
-					void *user_data)
-{
-	struct hwsim_rule *rule = user_data;
-	bool bval = rule->enabled;
-
-	l_dbus_message_builder_append_basic(builder, 'b', &bval);
-
-	return true;
-}
-
-static struct l_dbus_message *rule_property_set_enabled(
-					struct l_dbus *dbus,
-					struct l_dbus_message *message,
-					struct l_dbus_message_iter *new_value,
-					l_dbus_property_complete_cb_t complete,
-					void *user_data)
-{
-	struct hwsim_rule *rule = user_data;
-	bool bval;
-
-	if (!l_dbus_message_iter_get_variant(new_value, "b", &bval))
-		return dbus_error_invalid_args(message);
-
-	rule->enabled = bval;
-
-	return l_dbus_message_new_method_return(message);
-}
-
-static bool rule_property_get_match_times(struct l_dbus *dbus,
-					struct l_dbus_message *message,
-					struct l_dbus_message_builder *builder,
-					void *user_data)
-{
-	struct hwsim_rule *rule = user_data;
-	uint16_t val = rule->match_times;
-
-	l_dbus_message_builder_append_basic(builder, 'q', &val);
-
-	return true;
-}
-
-static struct l_dbus_message *rule_property_set_match_times(
-					struct l_dbus *dbus,
-					struct l_dbus_message *message,
-					struct l_dbus_message_iter *new_value,
-					l_dbus_property_complete_cb_t complete,
-					void *user_data)
-{
-	struct hwsim_rule *rule = user_data;
-	uint16_t val;
-
-	if (!l_dbus_message_iter_get_variant(new_value, "q", &val))
-		return dbus_error_invalid_args(message);
-
-	rule->match_times = val;
-
-	return l_dbus_message_new_method_return(message);
-}
-
-static bool rule_property_get_drop_ack(struct l_dbus *dbus,
-					struct l_dbus_message *message,
-					struct l_dbus_message_builder *builder,
-					void *user_data)
-{
-	struct hwsim_rule *rule = user_data;
-	bool bval = rule->drop_ack;
-
-	l_dbus_message_builder_append_basic(builder, 'b', &bval);
-
-	return true;
-}
-
-static struct l_dbus_message *rule_property_set_drop_ack(
-					struct l_dbus *dbus,
-					struct l_dbus_message *message,
-					struct l_dbus_message_iter *new_value,
-					l_dbus_property_complete_cb_t complete,
-					void *user_data)
-{
-	struct hwsim_rule *rule = user_data;
-	bool bval;
-
-	if (!l_dbus_message_iter_get_variant(new_value, "b", &bval))
-		return dbus_error_invalid_args(message);
-
-	rule->drop_ack = bval;
-
-	return l_dbus_message_new_method_return(message);
-}
-
-static void setup_rule_interface(struct l_dbus_interface *interface)
-{
-	l_dbus_interface_method(interface, "Remove", 0, rule_remove, "", "");
-
-	l_dbus_interface_property(interface, "Source",
-					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "s",
-					rule_property_get_source,
-					rule_property_set_source);
-	l_dbus_interface_property(interface, "Destination",
-					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "s",
-					rule_property_get_destination,
-					rule_property_set_destination);
-	l_dbus_interface_property(interface, "Bidirectional",
-					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "b",
-					rule_property_get_bidirectional,
-					rule_property_set_bidirectional);
-	l_dbus_interface_property(interface, "Frequency",
-					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "u",
-					rule_property_get_frequency,
-					rule_property_set_frequency);
-	l_dbus_interface_property(interface, "Priority",
-					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "n",
-					rule_property_get_priority,
-					rule_property_set_priority);
-	l_dbus_interface_property(interface, "SignalStrength",
-					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "n",
-					rule_property_get_signal,
-					rule_property_set_signal);
-	l_dbus_interface_property(interface, "Drop",
-					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "b",
-					rule_property_get_drop,
-					rule_property_set_drop);
-	l_dbus_interface_property(interface, "Delay",
-					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "u",
-					rule_property_get_delay,
-					rule_property_set_delay);
-	l_dbus_interface_property(interface, "Prefix",
-					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "ay",
-					rule_property_get_prefix,
-					rule_property_set_prefix);
-	l_dbus_interface_property(interface, "MatchBytes",
-					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "ay",
-					rule_property_get_match,
-					rule_property_set_match);
-	l_dbus_interface_property(interface, "MatchBytesOffset",
-					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "q",
-					rule_property_get_match_offset,
-					rule_property_set_match_offset);
-	l_dbus_interface_property(interface, "Enabled",
-					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "b",
-					rule_property_get_enabled,
-					rule_property_set_enabled);
-	l_dbus_interface_property(interface, "MatchTimes",
-					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "q",
-					rule_property_get_match_times,
-					rule_property_set_match_times);
-	l_dbus_interface_property(interface, "DropAck",
-					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "b",
-					rule_property_get_drop_ack,
-					rule_property_set_drop_ack);
-}
-
 static void request_name_callback(struct l_dbus *dbus, bool success,
 					bool queued, void *user_data)
 {
@@ -2839,6 +1862,15 @@ static void disconnect_callback(void *user_data)
 	l_main_quit();
 }
 
+const struct l_queue_entry *hwsim_get_radios(void)
+{
+	return l_queue_get_entries(radio_info);
+}
+const struct l_queue_entry *hwsim_get_interfaces(void)
+{
+	return l_queue_get_entries(interface_info);
+}
+
 static bool setup_dbus_hwsim(void)
 {
 	dbus = l_dbus_new_default(L_DBUS_SYSTEM_BUS);
@@ -2872,21 +1904,6 @@ static bool setup_dbus_hwsim(void)
 		return false;
 	}
 
-	if (!l_dbus_register_interface(dbus, HWSIM_RULE_MANAGER_INTERFACE,
-					setup_rule_manager_interface,
-					NULL, false)) {
-		l_error("Unable to register the %s interface",
-			HWSIM_RULE_MANAGER_INTERFACE);
-		return false;
-	}
-
-	if (!l_dbus_register_interface(dbus, HWSIM_RULE_INTERFACE,
-					setup_rule_interface, NULL, false)) {
-		l_error("Unable to register the %s interface",
-			HWSIM_RULE_INTERFACE);
-		return false;
-	}
-
 	if (!l_dbus_object_add_interface(dbus, "/",
 						HWSIM_RADIO_MANAGER_INTERFACE,
 						NULL)) {
@@ -2895,14 +1912,6 @@ static bool setup_dbus_hwsim(void)
 		return false;
 	}
 
-	if (!l_dbus_object_add_interface(dbus, "/",
-						HWSIM_RULE_MANAGER_INTERFACE,
-						NULL)) {
-		l_info("Unable to add the %s interface to /",
-			HWSIM_RULE_MANAGER_INTERFACE);
-		return false;
-	}
-
 	l_dbus_set_ready_handler(dbus, ready_callback, dbus, NULL);
 	l_dbus_set_disconnect_handler(dbus, disconnect_callback, NULL, NULL);
 
@@ -2983,6 +1992,7 @@ static void hwsim_ready(void)
 	struct l_genl_msg *msg;
 	size_t msg_size;
 	uint32_t radio_id;
+	uint8_t addr[6];
 
 	switch (action) {
 	case ACTION_LIST:
@@ -3039,6 +2049,10 @@ static void hwsim_ready(void)
 					sizeof(uint32_t) * hwsim_num_ciphers,
 					hwsim_ciphers);
 
+		addr[0] = 0x02;
+		l_getrandom(addr + 1, 5);
+		l_genl_msg_append_attr(msg, HWSIM_ATTR_PERM_ADDR, 6, addr);
+
 		l_genl_family_send(hwsim, msg, create_callback, NULL, NULL);
 
 		break;
@@ -3056,6 +2070,9 @@ static void hwsim_ready(void)
 		if (!setup_dbus_hwsim())
 			goto error;
 
+		if (iwd_modules_init())
+			goto error;
+
 		if (!l_genl_family_register(hwsim, "config", hwsim_config,
 						NULL, NULL)) {
 			l_error("Failed to create hwsim config listener\n");
@@ -3094,7 +2111,6 @@ static void family_discovered(const struct l_genl_family_info *info,
 	else if (!strcmp(l_genl_family_info_get_name(info), NL80211_GENL_NAME))
 		nl80211 = l_genl_family_new(genl, NL80211_GENL_NAME);
 }
-
 static void discovery_done(void *user_data)
 {
 	if (!hwsim) {
@@ -3265,15 +2281,20 @@ int main(int argc, char *argv[])
 		goto done;
 	}
 
+	watchlist_init(&hwsim_watch, NULL);
+
 	exit_status = l_main_run_with_signal(signal_handler, NULL);
 
+	watchlist_destroy(&hwsim_watch);
+
+	iwd_modules_exit();
+
 	l_genl_family_free(hwsim);
 	l_genl_family_free(nl80211);
 	l_genl_unref(genl);
 
 	l_dbus_destroy(dbus);
 	hwsim_radio_cache_cleanup();
-	l_queue_destroy(rules, destroy_rule);
 
 	l_netlink_destroy(rtnl);
 
diff --git a/tools/hwsim.h b/tools/hwsim.h
new file mode 100644
index 00000000..480270b9
--- /dev/null
+++ b/tools/hwsim.h
@@ -0,0 +1,99 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2023  Intel Corporation. All rights reserved.
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
+struct l_genl_msg;
+struct l_dbus;
+
+#define HWSIM_SERVICE "net.connman.hwsim"
+
+enum hwsim_tx_control_flags {
+	HWSIM_TX_CTL_REQ_TX_STATUS		= 1 << 0,
+	HWSIM_TX_CTL_NO_ACK			= 1 << 1,
+	HWSIM_TX_STAT_ACK			= 1 << 2,
+};
+
+struct radio_info_rec {
+	int32_t id;
+	uint32_t wiphy_id;
+	char alpha2[2];
+	bool p2p;
+	bool custom_regdom;
+	uint32_t regdom_idx;
+	int channels;
+	uint8_t addrs[2][ETH_ALEN];
+	char *name;
+	bool ap_only;
+	struct l_dbus_message *pending;
+	uint32_t cmd_id;
+};
+
+struct interface_info_rec {
+	uint32_t id;
+	struct radio_info_rec *radio_rec;
+	uint8_t addr[ETH_ALEN];
+	char *name;
+	uint32_t iftype;
+	int ref;
+};
+
+struct hwsim_tx_info {
+	int8_t idx;
+	uint8_t count;
+};
+
+struct hwsim_frame {
+	int refcount;
+	uint8_t src_ether_addr[ETH_ALEN];
+	uint8_t dst_ether_addr[ETH_ALEN];
+	struct radio_info_rec *src_radio;
+	struct radio_info_rec *ack_radio;
+	uint32_t flags;
+	const uint64_t *cookie;
+	int32_t signal;
+	uint32_t frequency;
+	uint16_t tx_info_len;
+	const struct hwsim_tx_info *tx_info;
+	uint16_t payload_len;
+	const uint8_t *payload;
+	bool acked;
+	struct l_genl_msg *msg;
+	int pending_callback_count;
+};
+
+typedef void (*hwsim_frame_cb_t)(struct hwsim_frame *frame, void *user_data);
+typedef void (*hwsim_destroy_cb_t)(void *user_data);
+
+unsigned int hwsim_watch_register(hwsim_frame_cb_t frame_cb, void *user_data,
+			hwsim_destroy_cb_t destroy);
+
+uint32_t hwsim_send_frame(struct hwsim_frame *frame,
+				struct radio_info_rec *radio,
+				l_genl_msg_func_t callback,
+				void *user_data,
+				l_genl_destroy_func_t destroy);
+bool hwsim_send_tx_info(struct hwsim_frame *frame);
+
+const struct l_queue_entry *hwsim_get_radios(void);
+const struct l_queue_entry *hwsim_get_interfaces(void);
+
+struct hwsim_frame *hwsim_frame_ref(struct hwsim_frame *frame);
+void hwsim_frame_unref(struct hwsim_frame *frame);
diff --git a/tools/rules.c b/tools/rules.c
new file mode 100644
index 00000000..291b2079
--- /dev/null
+++ b/tools/rules.c
@@ -0,0 +1,1017 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2023  Intel Corporation. All rights reserved.
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
+#include <stdlib.h>
+#include <stdio.h>
+#include <linux/if_ether.h>
+
+#include <ell/ell.h>
+#include "ell/useful.h"
+
+#include "src/module.h"
+#include "src/util.h"
+#include "src/dbus.h"
+#include "hwsim.h"
+
+#define HWSIM_MAX_PREFIX_LEN		128
+#define HWSIM_DELAY_MIN_MS		1
+
+#define HWSIM_RULE_MANAGER_INTERFACE HWSIM_SERVICE ".RuleManager"
+#define HWSIM_RULE_INTERFACE HWSIM_SERVICE ".Rule"
+
+struct hwsim_rule {
+	unsigned int id;
+	uint8_t source[ETH_ALEN];
+	uint8_t destination[ETH_ALEN];
+	bool source_any : 1;
+	bool destination_any : 1;
+	bool bidirectional : 1;
+	bool drop : 1;
+	bool drop_ack : 1;
+	bool enabled : 1;
+	uint32_t frequency;
+	int priority;
+	int signal;
+	int delay;
+	uint8_t *prefix;
+	size_t prefix_len;
+	uint8_t *match;
+	size_t match_len;
+	uint16_t match_offset;
+	int match_times; /* negative value indicates unused */
+};
+
+struct delay_frame_info {
+	struct hwsim_frame *frame;
+	struct radio_info_rec *radio;
+};
+
+static struct l_queue *rules;
+static unsigned int next_rule_id;
+
+static const char *rule_get_path(struct hwsim_rule *rule)
+{
+	static char path[16];
+
+	snprintf(path, sizeof(path), "/rule%u", rule->id);
+
+	return path;
+}
+
+static int rule_compare_priority(const void *a, const void *b, void *user)
+{
+	const struct hwsim_rule *rule_a = a;
+	const struct hwsim_rule *rule_b = b;
+
+	return (rule_a->priority > rule_b->priority) ? 1 : -1;
+}
+
+static struct l_dbus_message *rule_add(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					void *user_data)
+{
+	struct hwsim_rule *rule;
+	const char *path;
+	struct l_dbus_message *reply;
+
+	rule = l_new(struct hwsim_rule, 1);
+	rule->id = next_rule_id++;
+	rule->source_any = true;
+	rule->destination_any = true;
+	rule->delay = 0;
+	rule->enabled = false;
+	rule->match_times = -1;
+	rule->drop_ack = true;
+
+	if (!rules)
+		rules = l_queue_new();
+
+	l_queue_insert(rules, rule, rule_compare_priority, NULL);
+	path = rule_get_path(rule);
+
+	if (!l_dbus_object_add_interface(dbus, path,
+					HWSIM_RULE_INTERFACE, rule))
+		l_info("Unable to add the %s interface to %s",
+				HWSIM_RULE_INTERFACE, path);
+
+	if (!l_dbus_object_add_interface(dbus, path,
+					L_DBUS_INTERFACE_PROPERTIES, NULL))
+		l_info("Unable to add the %s interface to %s",
+				L_DBUS_INTERFACE_PROPERTIES, path);
+
+	reply = l_dbus_message_new_method_return(message);
+	l_dbus_message_set_arguments(reply, "o", path);
+
+	return reply;
+}
+
+static void setup_rule_manager_interface(struct l_dbus_interface *interface)
+{
+	l_dbus_interface_method(interface, "AddRule", 0,
+				rule_add, "o", "", "path");
+}
+
+static void destroy_rule(void *user_data)
+{
+	struct hwsim_rule *rule = user_data;
+
+	if (rule->prefix)
+		l_free(rule->prefix);
+
+	if (rule->match)
+		l_free(rule->match);
+
+	l_free(rule);
+}
+
+static struct l_dbus_message *rule_remove(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct hwsim_rule *rule = user_data;
+	const char *path;
+
+	path = rule_get_path(rule);
+	l_queue_remove(rules, rule);
+
+	destroy_rule(rule);
+
+	l_dbus_unregister_object(dbus, path);
+
+	return l_dbus_message_new_method_return(message);
+}
+
+static bool rule_property_get_source(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct hwsim_rule *rule = user_data;
+	const char *str;
+
+	if (rule->source_any)
+		str = "any";
+	else
+		str = util_address_to_string(rule->source);
+
+	l_dbus_message_builder_append_basic(builder, 's', str);
+
+	return true;
+}
+
+static struct l_dbus_message *rule_property_set_source(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_iter *new_value,
+					l_dbus_property_complete_cb_t complete,
+					void *user_data)
+{
+	struct hwsim_rule *rule = user_data;
+	const char *str;
+
+	if (!l_dbus_message_iter_get_variant(new_value, "s", &str))
+		return dbus_error_invalid_args(message);
+
+	if (!strcmp(str, "any"))
+		rule->source_any = true;
+	else {
+		if (!util_string_to_address(str, rule->source))
+			return dbus_error_invalid_args(message);
+
+		rule->source_any = false;
+	}
+
+	return l_dbus_message_new_method_return(message);
+}
+
+static bool rule_property_get_destination(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct hwsim_rule *rule = user_data;
+	const char *str;
+
+	if (rule->destination_any)
+		str = "any";
+	else if (util_is_broadcast_address(rule->destination))
+		str = "multicast";
+	else
+		str = util_address_to_string(rule->destination);
+
+	l_dbus_message_builder_append_basic(builder, 's', str);
+
+	return true;
+}
+
+static struct l_dbus_message *rule_property_set_destination(
+					struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_iter *new_value,
+					l_dbus_property_complete_cb_t complete,
+					void *user_data)
+{
+	struct hwsim_rule *rule = user_data;
+	const char *str;
+
+	if (!l_dbus_message_iter_get_variant(new_value, "s", &str))
+		return dbus_error_invalid_args(message);
+
+	if (!strcmp(str, "any"))
+		rule->destination_any = true;
+	else if (!strcmp(str, "multicast")) {
+		rule->destination[0] = 0x80;
+		rule->destination_any = false;
+	} else {
+		if (!util_string_to_address(str, rule->destination))
+			return dbus_error_invalid_args(message);
+
+		rule->destination_any = false;
+	}
+
+	return l_dbus_message_new_method_return(message);
+}
+
+static bool rule_property_get_bidirectional(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct hwsim_rule *rule = user_data;
+	bool bval = rule->bidirectional;
+
+	l_dbus_message_builder_append_basic(builder, 'b', &bval);
+
+	return true;
+}
+
+static struct l_dbus_message *rule_property_set_bidirectional(
+					struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_iter *new_value,
+					l_dbus_property_complete_cb_t complete,
+					void *user_data)
+{
+	struct hwsim_rule *rule = user_data;
+	bool bval;
+
+	if (!l_dbus_message_iter_get_variant(new_value, "b", &bval))
+		return dbus_error_invalid_args(message);
+
+	rule->bidirectional = bval;
+
+	return l_dbus_message_new_method_return(message);
+}
+
+static bool rule_property_get_frequency(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct hwsim_rule *rule = user_data;
+
+	l_dbus_message_builder_append_basic(builder, 'u', &rule->frequency);
+
+	return true;
+}
+
+static struct l_dbus_message *rule_property_set_frequency(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_iter *new_value,
+					l_dbus_property_complete_cb_t complete,
+					void *user_data)
+{
+	struct hwsim_rule *rule = user_data;
+
+	if (!l_dbus_message_iter_get_variant(new_value, "u", &rule->frequency))
+		return dbus_error_invalid_args(message);
+
+	return l_dbus_message_new_method_return(message);
+}
+
+static bool rule_property_get_priority(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct hwsim_rule *rule = user_data;
+	int16_t intval = rule->priority;
+
+	l_dbus_message_builder_append_basic(builder, 'n', &intval);
+
+	return true;
+}
+
+static struct l_dbus_message *rule_property_set_priority(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_iter *new_value,
+					l_dbus_property_complete_cb_t complete,
+					void *user_data)
+{
+	struct hwsim_rule *rule = user_data;
+	int16_t intval;
+
+	if (!l_dbus_message_iter_get_variant(new_value, "n", &intval))
+		return dbus_error_invalid_args(message);
+
+	rule->priority = intval;
+	l_queue_remove(rules, rule);
+	l_queue_insert(rules, rule, rule_compare_priority, NULL);
+
+	return l_dbus_message_new_method_return(message);
+}
+
+static bool rule_property_get_signal(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct hwsim_rule *rule = user_data;
+	int16_t intval = rule->signal;
+
+	l_dbus_message_builder_append_basic(builder, 'n', &intval);
+
+	return true;
+}
+
+static struct l_dbus_message *rule_property_set_signal(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_iter *new_value,
+					l_dbus_property_complete_cb_t complete,
+					void *user_data)
+{
+	struct hwsim_rule *rule = user_data;
+	int16_t intval;
+
+	if (!l_dbus_message_iter_get_variant(new_value, "n", &intval) ||
+			intval > 0 || intval < -10000)
+		return dbus_error_invalid_args(message);
+
+	rule->signal = intval;
+
+	return l_dbus_message_new_method_return(message);
+}
+
+static bool rule_property_get_drop(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct hwsim_rule *rule = user_data;
+	bool bval = rule->drop;
+
+	l_dbus_message_builder_append_basic(builder, 'b', &bval);
+
+	return true;
+}
+
+static struct l_dbus_message *rule_property_set_drop(
+					struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_iter *new_value,
+					l_dbus_property_complete_cb_t complete,
+					void *user_data)
+{
+	struct hwsim_rule *rule = user_data;
+	bool bval;
+
+	if (!l_dbus_message_iter_get_variant(new_value, "b", &bval))
+		return dbus_error_invalid_args(message);
+
+	rule->drop = bval;
+
+	return l_dbus_message_new_method_return(message);
+}
+
+static bool rule_property_get_delay(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct hwsim_rule *rule = user_data;
+
+	l_dbus_message_builder_append_basic(builder, 'u', &rule->delay);
+
+	return true;
+}
+
+static struct l_dbus_message *rule_property_set_delay(
+					struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_iter *new_value,
+					l_dbus_property_complete_cb_t complete,
+					void *user_data)
+{
+	struct hwsim_rule *rule = user_data;
+	uint32_t val;
+
+	if (!l_dbus_message_iter_get_variant(new_value, "u", &val) ||
+				val < HWSIM_DELAY_MIN_MS)
+		return dbus_error_invalid_args(message);
+
+	rule->delay = val;
+
+	return l_dbus_message_new_method_return(message);
+}
+
+static bool rule_property_get_prefix(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct hwsim_rule *rule = user_data;
+	size_t i;
+
+	l_dbus_message_builder_enter_array(builder, "y");
+
+	for (i = 0; i < rule->prefix_len; i++)
+		l_dbus_message_builder_append_basic(builder, 'y',
+							rule->prefix + i);
+
+	l_dbus_message_builder_leave_array(builder);
+
+	return true;
+}
+
+static struct l_dbus_message *rule_property_set_prefix(
+					struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_iter *new_value,
+					l_dbus_property_complete_cb_t complete,
+					void *user_data)
+{
+	struct hwsim_rule *rule = user_data;
+	struct l_dbus_message_iter iter;
+	const uint8_t *prefix;
+	uint32_t len;
+
+	if (!l_dbus_message_iter_get_variant(new_value, "ay", &iter))
+		goto invalid_args;
+
+	if (!l_dbus_message_iter_get_fixed_array(&iter,
+						(const void **)&prefix, &len))
+		goto invalid_args;
+
+	if (len > HWSIM_MAX_PREFIX_LEN)
+		goto invalid_args;
+
+	if (rule->prefix)
+		l_free(rule->prefix);
+
+	rule->prefix = l_memdup(prefix, len);
+	rule->prefix_len = len;
+
+	return l_dbus_message_new_method_return(message);
+
+invalid_args:
+	return dbus_error_invalid_args(message);
+}
+
+static bool rule_property_get_match(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct hwsim_rule *rule = user_data;
+	size_t i;
+
+	l_dbus_message_builder_enter_array(builder, "y");
+
+	for (i = 0; i < rule->match_len; i++)
+		l_dbus_message_builder_append_basic(builder, 'y',
+							rule->match + i);
+
+	l_dbus_message_builder_leave_array(builder);
+
+	return true;
+}
+
+static struct l_dbus_message *rule_property_set_match(
+					struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_iter *new_value,
+					l_dbus_property_complete_cb_t complete,
+					void *user_data)
+{
+	struct hwsim_rule *rule = user_data;
+	struct l_dbus_message_iter iter;
+	const uint8_t *match;
+	uint32_t len;
+
+	if (!l_dbus_message_iter_get_variant(new_value, "ay", &iter))
+		goto invalid_args;
+
+	if (!l_dbus_message_iter_get_fixed_array(&iter,
+						(const void **)&match, &len))
+		goto invalid_args;
+
+	if (len > HWSIM_MAX_PREFIX_LEN)
+		goto invalid_args;
+
+	if (rule->match)
+		l_free(rule->match);
+
+	rule->match = l_memdup(match, len);
+	rule->match_len = len;
+
+	return l_dbus_message_new_method_return(message);
+
+invalid_args:
+	return dbus_error_invalid_args(message);
+}
+
+static bool rule_property_get_match_offset(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct hwsim_rule *rule = user_data;
+	uint16_t val = rule->match_offset;
+
+	l_dbus_message_builder_append_basic(builder, 'q', &val);
+
+	return true;
+}
+
+static struct l_dbus_message *rule_property_set_match_offset(
+					struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_iter *new_value,
+					l_dbus_property_complete_cb_t complete,
+					void *user_data)
+{
+	struct hwsim_rule *rule = user_data;
+	uint16_t val;
+
+	if (!l_dbus_message_iter_get_variant(new_value, "q", &val))
+		return dbus_error_invalid_args(message);
+
+	rule->match_offset = val;
+
+	return l_dbus_message_new_method_return(message);
+}
+
+static bool rule_property_get_enabled(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct hwsim_rule *rule = user_data;
+	bool bval = rule->enabled;
+
+	l_dbus_message_builder_append_basic(builder, 'b', &bval);
+
+	return true;
+}
+
+static struct l_dbus_message *rule_property_set_enabled(
+					struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_iter *new_value,
+					l_dbus_property_complete_cb_t complete,
+					void *user_data)
+{
+	struct hwsim_rule *rule = user_data;
+	bool bval;
+
+	if (!l_dbus_message_iter_get_variant(new_value, "b", &bval))
+		return dbus_error_invalid_args(message);
+
+	rule->enabled = bval;
+
+	return l_dbus_message_new_method_return(message);
+}
+
+static bool rule_property_get_match_times(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct hwsim_rule *rule = user_data;
+	uint16_t val = rule->match_times;
+
+	l_dbus_message_builder_append_basic(builder, 'q', &val);
+
+	return true;
+}
+
+static struct l_dbus_message *rule_property_set_match_times(
+					struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_iter *new_value,
+					l_dbus_property_complete_cb_t complete,
+					void *user_data)
+{
+	struct hwsim_rule *rule = user_data;
+	uint16_t val;
+
+	if (!l_dbus_message_iter_get_variant(new_value, "q", &val))
+		return dbus_error_invalid_args(message);
+
+	rule->match_times = val;
+
+	return l_dbus_message_new_method_return(message);
+}
+
+static bool rule_property_get_drop_ack(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct hwsim_rule *rule = user_data;
+	bool bval = rule->drop_ack;
+
+	l_dbus_message_builder_append_basic(builder, 'b', &bval);
+
+	return true;
+}
+
+static struct l_dbus_message *rule_property_set_drop_ack(
+					struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_iter *new_value,
+					l_dbus_property_complete_cb_t complete,
+					void *user_data)
+{
+	struct hwsim_rule *rule = user_data;
+	bool bval;
+
+	if (!l_dbus_message_iter_get_variant(new_value, "b", &bval))
+		return dbus_error_invalid_args(message);
+
+	rule->drop_ack = bval;
+
+	return l_dbus_message_new_method_return(message);
+}
+
+static void setup_rule_interface(struct l_dbus_interface *interface)
+{
+	l_dbus_interface_method(interface, "Remove", 0, rule_remove, "", "");
+
+	l_dbus_interface_property(interface, "Source",
+					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "s",
+					rule_property_get_source,
+					rule_property_set_source);
+	l_dbus_interface_property(interface, "Destination",
+					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "s",
+					rule_property_get_destination,
+					rule_property_set_destination);
+	l_dbus_interface_property(interface, "Bidirectional",
+					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "b",
+					rule_property_get_bidirectional,
+					rule_property_set_bidirectional);
+	l_dbus_interface_property(interface, "Frequency",
+					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "u",
+					rule_property_get_frequency,
+					rule_property_set_frequency);
+	l_dbus_interface_property(interface, "Priority",
+					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "n",
+					rule_property_get_priority,
+					rule_property_set_priority);
+	l_dbus_interface_property(interface, "SignalStrength",
+					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "n",
+					rule_property_get_signal,
+					rule_property_set_signal);
+	l_dbus_interface_property(interface, "Drop",
+					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "b",
+					rule_property_get_drop,
+					rule_property_set_drop);
+	l_dbus_interface_property(interface, "Delay",
+					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "u",
+					rule_property_get_delay,
+					rule_property_set_delay);
+	l_dbus_interface_property(interface, "Prefix",
+					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "ay",
+					rule_property_get_prefix,
+					rule_property_set_prefix);
+	l_dbus_interface_property(interface, "MatchBytes",
+					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "ay",
+					rule_property_get_match,
+					rule_property_set_match);
+	l_dbus_interface_property(interface, "MatchBytesOffset",
+					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "q",
+					rule_property_get_match_offset,
+					rule_property_set_match_offset);
+	l_dbus_interface_property(interface, "Enabled",
+					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "b",
+					rule_property_get_enabled,
+					rule_property_set_enabled);
+	l_dbus_interface_property(interface, "MatchTimes",
+					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "q",
+					rule_property_get_match_times,
+					rule_property_set_match_times);
+	l_dbus_interface_property(interface, "DropAck",
+					L_DBUS_PROPERTY_FLAG_AUTO_EMIT, "b",
+					rule_property_get_drop_ack,
+					rule_property_set_drop_ack);
+}
+
+static bool radio_match_addr(const struct radio_info_rec *radio,
+				const uint8_t *addr)
+{
+	if (!radio || util_is_broadcast_address(addr))
+		return !radio && util_is_broadcast_address(addr);
+
+	return !memcmp(addr, radio->addrs[0], ETH_ALEN) ||
+		!memcmp(addr, radio->addrs[1], ETH_ALEN);
+}
+
+static void process_rules(const struct radio_info_rec *src_radio,
+				const struct radio_info_rec *dst_radio,
+				struct hwsim_frame *frame, bool ack, bool *drop,
+				uint32_t *delay)
+{
+	const struct l_queue_entry *rule_entry;
+
+	for (rule_entry = l_queue_get_entries(rules); rule_entry;
+			rule_entry = rule_entry->next) {
+		struct hwsim_rule *rule = rule_entry->data;
+
+		if (!rule->enabled)
+			continue;
+
+		if (!rule->source_any &&
+				!radio_match_addr(src_radio, rule->source) &&
+				(!rule->bidirectional ||
+				 !radio_match_addr(dst_radio, rule->source)))
+			continue;
+
+		if (!rule->destination_any &&
+				!radio_match_addr(dst_radio,
+							rule->destination) &&
+				(!rule->bidirectional ||
+				 !radio_match_addr(src_radio,
+							rule->destination)))
+			continue;
+
+		/*
+		 * If source matches only because rule->bidirectional was
+		 * true, make sure destination is "any" or matches source
+		 * radio's address.
+		 */
+		if (!rule->source_any && rule->bidirectional &&
+				radio_match_addr(dst_radio, rule->source))
+			if (!rule->destination_any &&
+					!radio_match_addr(dst_radio,
+							rule->destination))
+				continue;
+
+		if (rule->frequency && rule->frequency != frame->frequency)
+			continue;
+
+		if (rule->prefix && frame->payload_len >= rule->prefix_len) {
+			if (memcmp(rule->prefix, frame->payload,
+					rule->prefix_len) != 0)
+				continue;
+		}
+
+		if (rule->match && frame->payload_len >=
+					rule->match_len + rule->match_offset) {
+			if (memcmp(rule->match,
+					frame->payload + rule->match_offset,
+					rule->match_len))
+				continue;
+		}
+
+		/* Rule deemed to match frame, apply any changes */
+		if (rule->match_times == 0)
+			continue;
+
+		if (rule->signal)
+			frame->signal = rule->signal / 100;
+
+		/* Don't drop if this is an ACK, unless drop_ack is set */
+		if (!ack || (ack && rule->drop_ack))
+			*drop = rule->drop;
+
+		if (delay)
+			*delay = rule->delay;
+
+		if (rule->match_times > 0)
+			rule->match_times--;
+	}
+}
+
+static void send_frame_callback(struct l_genl_msg *msg, void *user_data)
+{
+	struct delay_frame_info *info = user_data;
+
+	if (l_genl_msg_get_error(msg) == 0) {
+		info->frame->acked = true;
+		info->frame->ack_radio = info->radio;
+	}
+
+	info->frame->pending_callback_count--;
+}
+
+static void ack_frame(struct hwsim_frame *frame)
+{
+	if (!frame->pending_callback_count) {
+		/*
+		 * Apparently done with this frame, send tx info and signal
+		 * the returning of an ACK frame in the opposite direction.
+		 */
+
+		if (!(frame->flags & HWSIM_TX_CTL_NO_ACK) && frame->acked) {
+			bool drop = false;
+
+			process_rules(frame->ack_radio, frame->src_radio,
+					frame, true, &drop, NULL);
+
+			if (!drop)
+				frame->flags |= HWSIM_TX_STAT_ACK;
+		}
+
+		if (frame->src_radio)
+			hwsim_send_tx_info(frame);
+	}
+}
+
+static void send_frame_destroy(void *user_data)
+{
+	struct delay_frame_info *info = user_data;
+	struct hwsim_frame *frame = info->frame;
+
+	if (frame->refcount > 1) {
+		hwsim_frame_unref(frame);
+		l_free(info);
+
+		return;
+	}
+
+	ack_frame(frame);
+}
+
+static void frame_delay_callback(struct l_timeout *timeout, void *user_data)
+{
+	struct delay_frame_info *info = user_data;
+
+	if (hwsim_send_frame(info->frame, info->radio, send_frame_callback,
+				info, send_frame_destroy))
+		info->frame->pending_callback_count++;
+	else
+		send_frame_destroy(info);
+
+	if (timeout)
+		l_timeout_remove(timeout);
+}
+
+/*
+ * Process frames in a similar way to how the kernel built-in hwsim medium
+ * does this, with an additional optimization for unicast frames and
+ * additional modifications to frames decided by user-configurable rules.
+ */
+static void rules_process_frame(struct hwsim_frame *frame, void *user_data)
+{
+	const struct l_queue_entry *entry;
+	bool drop_mcast = false;
+	bool beacon = false;
+
+	/* Unknown source, ignore */
+	if (!frame->src_radio)
+		return;
+
+	if (util_is_broadcast_address(frame->dst_ether_addr))
+		process_rules(frame->src_radio, NULL, frame, false,
+				&drop_mcast, NULL);
+
+	if (frame->payload_len >= 2 &&
+			frame->payload[0] == 0x80 &&
+			frame->payload[1] == 0x00)
+		beacon = true;
+
+	for (entry = hwsim_get_radios(); entry; entry = entry->next) {
+		struct radio_info_rec *radio = entry->data;
+		struct delay_frame_info *info;
+		bool drop = drop_mcast;
+		uint32_t delay = 0;
+		const struct l_queue_entry *i;
+
+		if (radio == frame->src_radio)
+			continue;
+
+		/*
+		 * The kernel hwsim medium passes multicast frames to all
+		 * radios that are on the same frequency as this frame but
+		 * the netlink medium API only lets userspace pass frames to
+		 * radios by known hardware address.  It does check that the
+		 * receiving radio is on the same frequency though so we can
+		 * send to all known addresses.
+		 *
+		 * If the frame's Receiver Address (RA) is a multicast
+		 * address, then send the frame to every radio that is
+		 * registered.  If it's a unicast address then optimize
+		 * by only forwarding the frame to the radios that have
+		 * at least one interface with this specific address.
+		 */
+		if (!util_is_broadcast_address(frame->dst_ether_addr)) {
+			for (i = hwsim_get_interfaces(); i; i = i->next) {
+				struct interface_info_rec *interface = i->data;
+
+				if (interface->radio_rec != radio)
+					continue;
+
+				if (!memcmp(interface->addr,
+						frame->dst_ether_addr,
+						ETH_ALEN))
+					break;
+			}
+
+			if (!i)
+				continue;
+		}
+
+		process_rules(frame->src_radio, radio, frame, false,
+				&drop, &delay);
+
+		if (drop)
+			continue;
+
+		/*
+		 * Don't bother sending beacons to other AP interfaces
+		 * if the AP interface is the only one on this phy
+		 */
+		if (beacon && radio->ap_only)
+			continue;
+
+		info = l_new(struct delay_frame_info, 1);
+		info->radio = radio;
+		info->frame = hwsim_frame_ref(frame);
+
+		if (delay) {
+			if (!l_timeout_create_ms(delay, frame_delay_callback,
+							info, NULL)) {
+				l_error("Error delaying frame %ums, "
+						"frame will be dropped", delay);
+				hwsim_frame_unref(info->frame);
+				l_free(info);
+			}
+		} else
+			frame_delay_callback(NULL, info);
+	}
+
+	/*
+	 * If the frame was dropped to all radios we still need to signal this
+	 * information to the kernel.
+	 */
+	ack_frame(frame);
+}
+
+static int rules_init(void)
+{
+	struct l_dbus *dbus = dbus_get_bus();
+
+	l_debug("");
+
+	if (!l_dbus_register_interface(dbus, HWSIM_RULE_MANAGER_INTERFACE,
+					setup_rule_manager_interface,
+					NULL, false)) {
+		l_error("Unable to register the %s interface",
+			HWSIM_RULE_MANAGER_INTERFACE);
+		return -EINVAL;
+	}
+
+	if (!l_dbus_register_interface(dbus, HWSIM_RULE_INTERFACE,
+					setup_rule_interface, NULL, false)) {
+		l_error("Unable to register the %s interface",
+			HWSIM_RULE_INTERFACE);
+		return -EINVAL;
+	}
+
+	if (!l_dbus_object_add_interface(dbus, "/",
+						HWSIM_RULE_MANAGER_INTERFACE,
+						NULL)) {
+		l_info("Unable to add the %s interface to /",
+			HWSIM_RULE_MANAGER_INTERFACE);
+		return -EINVAL;
+	}
+
+	hwsim_watch_register(rules_process_frame, NULL, NULL);
+
+	return 0;
+}
+
+static void rules_exit(void)
+{
+	l_queue_destroy(rules, destroy_rule);
+}
+
+IWD_MODULE(rules, rules_init, rules_exit);
-- 
2.25.1

