Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE5219069B
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724436024; cv=none; b=W8G1Oqnt8gbUdULKdc984dXCnVESQ+j99GgOzMZlCAPMZNVsUc3vVsQJbtvjlw0gW3w+LrrmMwJxU621SUFvE0VlOGLSzFyuUv6WgkcdBfsSmb2oVDvDzMfcDSpYTbIVHZH3RGrNk6YPva0KOna3IGlqHlLc3lrLqO5WGNAF460=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724436024; c=relaxed/simple;
	bh=8GJp6LIloV0RHrttszdpIwblnKc6uljkf1d2c0MC+/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nHs07MWgWOZE2Wc31xpRBlb3ApV/mU4+96AMHAd93UM/0PegrwK5iyVmIgOhQMrUacA/5dh5akL50Jg86ov8VCwuZQ7h79E0h5CJxQdgv6KMHLbqqtvCqYS6qLoQN7OCe7/R1mov9ofMIp8rEHvwObPBevoRn56t7VHvbBmSzrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBGaB4tE; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBGaB4tE"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44fff73f223so12436131cf.2
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 11:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724436021; x=1725040821; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Do/QJpPtvafMOYYsDYzOgXAyP1tN33OB7hrK9QH18sw=;
        b=WBGaB4tEmxIE9ZMJeP6IElXffPMXkUCxu8vkIQwgC3FDeIbl+ygj54WCo2oGpy0e4L
         0I/sLJi2Eh5tJfqhHV09Q6rhbSL9YR2Y25/eomwjKYuT2fexmnJJHKV4jT85ejzHT+o7
         WCHCnDdcY5Z10Kaoedm4TC4XHGuSZyx0dTPAIN4Ym4A9GifsznTHMVNcLWvqy9NewVRZ
         0OokNmBGA8Ped5SyW4ETtDQEpdm7AXYKT7ZsbcQiBHzetVztmIjkzgJ9tHO1F7OnQT/6
         Pv8YHp/FFiT/m6+VyjLahlXsQM/z5KPD451QpMCtFNogtFtf1JzzyqB1IjK7OfrXjORD
         t68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724436021; x=1725040821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Do/QJpPtvafMOYYsDYzOgXAyP1tN33OB7hrK9QH18sw=;
        b=uPneaAv9bg/V7QydFTy1j+Fii4PM1VNJym5DEbTmYZuHot2HzH+rb8Hn93dPraVKSG
         ZuZ4MeoeAMTa1rkK84lX5Ymv7lEfqAUa4Ad7Pd81HAwE4SIlf7XJzw8v2pgpS4JADytp
         T67G6iGRqqvCmp1vI+sjDWkWvQ1htE2aC/gy/cx/2KJWEAojp6klxoSsec8mmesRVSIE
         sz6wlXTH33YOxv3QWnovIx3tXNUoxrUNoAr/l5K6wY5NK19BPLkEz37l3/LyqpRuOYy9
         kZfM18vZF6MqQ53a/ekbTI4rZOfug4ESIPeVjhfR/RWGGo35i9Q0UXONcTlftUomONgi
         EDkg==
X-Gm-Message-State: AOJu0YwPDdeW45fbk1+wWdnaodo8yYCj0nuv/4WMH75ecYeIeiFvIF1N
	ypJ/VJ7vuZ28zrR33hIzNL52i1lCZCZ/q3Qk2seU1AoIKljYPLHP8H08PA==
X-Google-Smtp-Source: AGHT+IE4nVN3bZVgKb3eL3aRRSQhmTEZtgnwOfsywf1e9DZ3BgUldSLzKkKwOtuTsVloz5zpVjLXlA==
X-Received: by 2002:a05:622a:4203:b0:447:e542:ab00 with SMTP id d75a77b69052e-455097c22d1mr29818041cf.50.1724436020824;
        Fri, 23 Aug 2024 11:00:20 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe0f0507sm19683131cf.47.2024.08.23.11.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 11:00:20 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 5/8] station: add Affinities DBus property
Date: Fri, 23 Aug 2024 11:00:03 -0700
Message-Id: <20240823180006.317353-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823180006.317353-1-prestwoj@gmail.com>
References: <20240823180006.317353-1-prestwoj@gmail.com>
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
purpose of this array is to guide or loosly lock IWD to certain
BSS's provided that some external client has more information
about the environment than what IWD takes into account for its
roaming decisions.

For the time being, the array is limited to only the connected
BSS path, and any roams or disconnects will clear the array.

The intended use case for this is if the device is stationary
an external client could reduce the likelihood of roaming by
setting the affinity to the current BSS.
---
 src/station.c | 145 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/src/station.c b/src/station.c
index 30a1232a..c72d42ae 100644
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
@@ -4520,6 +4547,118 @@ static bool station_property_get_state(struct l_dbus *dbus,
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
+
+	l_free(station->affinity_client);
+	station->affinity_client = NULL;
+
+	l_queue_destroy(station->affinities, l_free);
+	station->affinities = NULL;
+
+	l_dbus_property_changed(dbus_get_bus(),
+				netdev_get_path(station->netdev),
+				IWD_STATION_INTERFACE, "Affinities");
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
+	const char *path;
+	struct l_queue *new_affinities;
+
+	if (!station->connected_network)
+		return dbus_error_not_connected(message);
+
+	if (!station->affinity_watch) {
+		station->affinity_client = l_strdup(sender);
+		station->affinity_watch = l_dbus_add_disconnect_watch(dbus,
+					sender,
+					station_affinity_disconnected_cb,
+					station,
+					station_affinity_watch_destroy);
+	} else if (strcmp(station->affinity_client, sender)) {
+		l_warn("Only one client may manage Affinities property");
+		return dbus_error_not_available(message);
+	}
+
+	if (!l_dbus_message_iter_get_variant(new_value, "ao", &array))
+		return dbus_error_invalid_args(message);
+
+	new_affinities = l_queue_new();
+
+	while (l_dbus_message_iter_next_entry(&array, &path)) {
+		struct scan_bss *bss = l_dbus_object_get_data(dbus_get_bus(),
+						path,
+						IWD_BSS_INTERFACE);
+
+		/*
+		 * TODO: For now only allow the affinities array to contain the
+		 *       connected BSS path. Any other values will be rejected.
+		 *       This could change in the future.
+		 */
+		if (bss != station->connected_bss) {
+			l_queue_destroy(new_affinities, l_free);
+			return dbus_error_invalid_args(message);
+		}
+
+		l_queue_push_head(new_affinities, l_strdup(path));
+	}
+
+	l_queue_destroy(station->affinities, l_free);
+	station->affinities = new_affinities;
+
+	l_dbus_property_changed(dbus, netdev_get_path(station->netdev),
+				IWD_STATION_INTERFACE, "Affinities");
+
+	complete(dbus, message, NULL);
+
+	return NULL;
+}
+
 void station_foreach(station_foreach_func_t func, void *user_data)
 {
 	const struct l_queue_entry *entry;
@@ -4842,6 +4981,9 @@ static void station_free(struct station *station)
 
 	l_queue_destroy(station->roam_bss_list, l_free);
 
+	if (station->affinity_watch)
+		l_dbus_remove_watch(dbus_get_bus(), station->affinity_watch);
+
 	l_free(station);
 }
 
@@ -4878,6 +5020,9 @@ static void station_setup_interface(struct l_dbus_interface *interface)
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

