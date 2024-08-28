Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A501ABEA9
	for <iwd@lists.linux.dev>; Wed, 28 Aug 2024 19:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724873080; cv=none; b=Ww//7pa64yVqBohab2OSIaWOosypHcbNkVa5FRdZLyoCl3u3wnx2TWYhD7jsPwYOwR6Tv3aO2dH6Ep3J9mEmZFeJEcTsW9bXQC7vUzvXmXR8KoOXATl1NaOlkEzll24xmua4aPXnM4KVAEoloCJQhKX4YdShJN9moVIrqW8C6/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724873080; c=relaxed/simple;
	bh=/cNvou5OKwXBZSjARc8ZH2uKndES7KGCEkZ8twncnpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j2TtGKd5I1VVc70gJmXMipZuGTGLr6WNvYtSD1BI3f83BcPqEkr81Zm6nxRQ2k+ARU+OVcC0Vc7rh20Lrzx9XGuPYL0O5Xpp7AEQ/e48DsyVkxqxUCDvXWbc1ICEnduUMRQkeFC3vjwuVEOp403j/3NlPVmt2NBBkpmUw19Oz/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjv4qjhA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjv4qjhA"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-714186ce2f2so5631486b3a.0
        for <iwd@lists.linux.dev>; Wed, 28 Aug 2024 12:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724873077; x=1725477877; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=so6t1mdougBNTX+QXQBrug3QroIUHCATB/kW1/gWbtc=;
        b=kjv4qjhAK7Cu87pj79xeZBwuJX6Egw19Xud33glYqNGjlRorDzBGKHxRcth9u1+UJB
         qvde2pj+pB+w1ewSRU4LVT8UvF7q3K261lf0et39q8znTN/niNfsmGGfN6qgyw0m8YzK
         ynwo8wVBBIaHP3LLvClgys4IrH6u/ovirHK7JTTRWKaJoP50Uedn+A8gK8vsjYGF7Dko
         2pJc/n7Q36HTNhizjgCs+mPOYIJakyZvKy9om3h8uUZXUApJgmnfZnV1Yb7A0l4S+fJJ
         pbOQ/T0+2gDLfXc0tzKzVFihhavJJKYj8VW09Iyuq5+tmd6geQg0v2/upYOya25PdlQt
         MjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724873077; x=1725477877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=so6t1mdougBNTX+QXQBrug3QroIUHCATB/kW1/gWbtc=;
        b=YmRN8XMlPKE3QzF4XsXvmtafD1WuaG89/K69NX5M1+8wOxVJTataIv+zJnpYAbW7yG
         AVHDKJyxTWm5Kx6DXhgtpZPOfg7YhfWnOLL4w4Dddyoi3GwbfpLcBM/dttZ98anFgCm8
         rOx3KJpjuRNO6vGxq4ewaEf5szDki/aXmCKx11j0YA+txEWN2XzBvBNnzLMkhFaMd+gm
         FIUSrOcyBOEuvKi4kaxZDn2n1dVGXcpLIRRDp/Vh4cozsdmj8QE7Y+120u1mvWb4MltN
         jswYtr4MsiUhF1gz6D3Mq4XqfpW19KoW+AZ01lLqFQ6U6Sx8RPKLp2g6kiWYUtjfHCuP
         pqfw==
X-Gm-Message-State: AOJu0Yzu1DPCeXTY+6cEd30+FUY82cO3H218a4RXzU41FAI9ImpCz/GC
	MqI6q+FYaXAU0ykpQTRt69B3dD/0232pZX5W2zgQ98NjMsqR6dg0d6Q0tA==
X-Google-Smtp-Source: AGHT+IH9RMqkDTGt0Zdbi+w+TM9Doeprx1VAEs6FV51mDpC2JCD/jcnJYtA2wAv307KE1uhc4WYpsw==
X-Received: by 2002:a05:6a00:1387:b0:714:3a4b:f78f with SMTP id d2e1a72fcca58-715dfbf403dmr639687b3a.20.1724873077351;
        Wed, 28 Aug 2024 12:24:37 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac994a3sm11081635a12.16.2024.08.28.12.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 12:24:36 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 3/6] station: add Affinities DBus property
Date: Wed, 28 Aug 2024 12:24:25 -0700
Message-Id: <20240828192428.902761-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828192428.902761-1-prestwoj@gmail.com>
References: <20240828192428.902761-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This property will hold an array of object paths for
BasicServiceSet (BSS) objects. For the purpose of this patch
only the setter/getter and client watch is implemented. The
purpose of this array is to guide or loosely lock IWD to certain
BSS's provided that some external client has more information
about the environment than what IWD takes into account for its
roaming decisions.

For the time being, the array is limited to only the connected
BSS path, and any roams or disconnects will clear the array.

The intended use case for this is if the device is stationary
an external client could reduce the likelihood of roaming by
setting the affinity to the current BSS.
---
 src/station.c | 174 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 174 insertions(+)

v5:
 * reworked a lot of the logic removing the loop and instead just
   trying to get the first path, and fail if a second exists. Also
   fixed some cleanup on error paths
 * Check for FW roaming, and don't allow the affinities to be set if
   that is enabled.
 * Return PermissionDenied error if a client is already managing the
   affinities.

diff --git a/src/station.c b/src/station.c
index 30a1232a..1eeefe75 100644
--- a/src/station.c
+++ b/src/station.c
@@ -128,6 +128,10 @@ struct station {
 
 	uint64_t last_roam_scan;
 
+	struct l_queue *affinities;
+	unsigned int affinity_watch;
+	char *affinity_client;
+
 	bool preparing_roam : 1;
 	bool roam_scan_full : 1;
 	bool signal_low : 1;
@@ -449,6 +453,14 @@ static const char *station_get_bss_path(struct station *station,
 	return __network_path_append_bss(network_path, bss);
 }
 
+static bool match_bss_path(const void *data, const void *user_data)
+{
+	const char *path1 = data;
+	const char *path2 = user_data;
+
+	return !strcmp(path1, path2);
+}
+
 static bool station_unregister_bss(struct station *station,
 					struct scan_bss *bss)
 {
@@ -457,6 +469,8 @@ static bool station_unregister_bss(struct station *station,
 	if (L_WARN_ON(!path))
 		return false;
 
+	l_queue_remove_if(station->affinities, match_bss_path, path);
+
 	return l_dbus_unregister_object(dbus_get_bus(), path);
 }
 
@@ -1740,6 +1754,13 @@ static void station_enter_state(struct station *station,
 		station_set_evict_nocarrier(station, true);
 		station_set_drop_neighbor_discovery(station, false);
 		station_set_drop_unicast_l2_multicast(station, false);
+
+		if (station->affinity_watch) {
+			l_dbus_remove_watch(dbus_get_bus(),
+						station->affinity_watch);
+			station->affinity_watch = 0;
+		}
+
 		break;
 	case STATION_STATE_DISCONNECTING:
 	case STATION_STATE_NETCONFIG:
@@ -1747,6 +1768,12 @@ static void station_enter_state(struct station *station,
 	case STATION_STATE_ROAMING:
 	case STATION_STATE_FT_ROAMING:
 	case STATION_STATE_FW_ROAMING:
+		if (station->affinity_watch) {
+			l_dbus_remove_watch(dbus_get_bus(),
+						station->affinity_watch);
+			station->affinity_watch = 0;
+		}
+
 		station_set_evict_nocarrier(station, false);
 		break;
 	}
@@ -4520,6 +4547,144 @@ static bool station_property_get_state(struct l_dbus *dbus,
 	return true;
 }
 
+static bool station_property_get_affinities(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct station *station = user_data;
+	const struct l_queue_entry *e;
+
+	if (!station->connected_network)
+		return false;
+
+	l_dbus_message_builder_enter_array(builder, "o");
+
+	for (e = l_queue_get_entries(station->affinities); e; e = e->next) {
+		const char *path = e->data;
+
+		l_dbus_message_builder_append_basic(builder, 'o', path);
+	}
+
+	l_dbus_message_builder_leave_array(builder);
+
+	return true;
+}
+
+static void station_affinity_disconnected_cb(struct l_dbus *dbus,
+						void *user_data)
+{
+	struct station *station = user_data;
+
+	l_dbus_remove_watch(dbus_get_bus(), station->affinity_watch);
+	station->affinity_watch = 0;
+
+	l_debug("client that set affinity has disconnected");
+}
+
+static void station_affinity_watch_destroy(void *user_data)
+{
+	struct station *station = user_data;
+	bool empty = l_queue_length(station->affinities) == 0;
+
+	l_free(station->affinity_client);
+	station->affinity_client = NULL;
+
+	l_queue_clear(station->affinities, l_free);
+
+	if (!empty)
+		l_dbus_property_changed(dbus_get_bus(),
+					netdev_get_path(station->netdev),
+					IWD_STATION_INTERFACE, "Affinities");
+}
+
+static struct l_dbus_message *station_property_set_affinities(
+					struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_iter *new_value,
+					l_dbus_property_complete_cb_t complete,
+					void *user_data)
+{
+	struct station *station = user_data;
+	struct l_dbus_message_iter array;
+	const char *sender = l_dbus_message_get_sender(message);
+	char *old_path = l_queue_peek_head(station->affinities);
+	const char *new_path = NULL;
+	struct scan_bss *new_bss = NULL;
+	struct scan_bss *old_bss = NULL;
+
+	if (!station->connected_network)
+		return dbus_error_not_connected(message);
+
+	if (wiphy_supports_firmware_roam(station->wiphy))
+		return dbus_error_not_supported(message);
+
+	if (station->affinity_watch &&
+				strcmp(station->affinity_client, sender)) {
+		l_warn("Only one client may manage Affinities property");
+		return dbus_error_permission_denied(message);
+	}
+
+	if (!l_dbus_message_iter_get_variant(new_value, "ao", &array))
+		return dbus_error_invalid_args(message);
+
+	/* Get first entry, there should be only one */
+	l_dbus_message_iter_next_entry(&array, &new_path);
+
+	if (l_dbus_message_iter_next_entry(&array, &new_path))
+		return dbus_error_invalid_args(message);
+
+	old_path = l_queue_peek_head(station->affinities);
+	if (old_path)
+		old_bss = l_dbus_object_get_data(dbus_get_bus(),
+						old_path, IWD_BSS_INTERFACE);
+	if (new_path)
+		new_bss = l_dbus_object_get_data(dbus,
+						new_path, IWD_BSS_INTERFACE);
+
+	/* Either the same path, or both arrays are empty */
+	if (old_bss == new_bss) {
+		complete(dbus, message, NULL);
+		return NULL;
+	}
+
+	/*
+	 * TODO: For now only allow the affinities array to contain a single
+	 *       value, the connected BSS path. Any other values will be
+	 *       rejected. This could change in the future.
+	 */
+	if (new_bss && new_bss != station->connected_bss)
+		return dbus_error_invalid_args(message);
+
+	l_queue_clear(station->affinities, l_free);
+
+	/*
+	 * Adding a new BSS, create a watch for this DBus client so if it
+	 * disconnects we can clear the affinities list
+	 */
+	if (new_path) {
+		l_queue_push_head(station->affinities, l_strdup(new_path));
+
+		if (!station->affinity_watch) {
+			station->affinity_client = l_strdup(sender);
+			station->affinity_watch = l_dbus_add_disconnect_watch(
+					dbus, sender,
+					station_affinity_disconnected_cb,
+					station,
+					station_affinity_watch_destroy);
+		}
+	/* The list was cleared, remove the watch */
+	} else if (station->affinity_watch)
+		l_dbus_remove_watch(dbus, station->affinity_watch);
+
+	complete(dbus, message, NULL);
+
+	l_dbus_property_changed(dbus, netdev_get_path(station->netdev),
+				IWD_STATION_INTERFACE, "Affinities");
+
+	return NULL;
+}
+
 void station_foreach(station_foreach_func_t func, void *user_data)
 {
 	const struct l_queue_entry *entry;
@@ -4750,6 +4915,7 @@ static struct station *station_create(struct netdev *netdev)
 	station_set_autoconnect(station, autoconnect);
 
 	station->roam_bss_list = l_queue_new();
+	station->affinities = l_queue_new();
 
 	return station;
 }
@@ -4842,6 +5008,11 @@ static void station_free(struct station *station)
 
 	l_queue_destroy(station->roam_bss_list, l_free);
 
+	if (station->affinity_watch)
+		l_dbus_remove_watch(dbus_get_bus(), station->affinity_watch);
+
+	l_queue_destroy(station->affinities, l_free);
+
 	l_free(station);
 }
 
@@ -4878,6 +5049,9 @@ static void station_setup_interface(struct l_dbus_interface *interface)
 					station_property_get_scanning, NULL);
 	l_dbus_interface_property(interface, "State", 0, "s",
 					station_property_get_state, NULL);
+	l_dbus_interface_property(interface, "Affinities", 0, "ao",
+					station_property_get_affinities,
+					station_property_set_affinities);
 }
 
 static void station_destroy_interface(void *user_data)
-- 
2.34.1

