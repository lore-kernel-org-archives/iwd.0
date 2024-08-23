Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BD719258E
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 22:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724451834; cv=none; b=W/nQUlpm/D36HE886FHaQGPJU6KhdBY94rqZ9SxpIxVyLMh2XYr9RIW92Me+Fdtwrrr80uqFwu2X8yrs6PwNG+B6mAlPSaWd/n5iuKArJUBwoHEltczv9dspA0n6ySFLJBc3lkdBlSef24EnACcDFNtVABEuZllFIbjcdFExPIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724451834; c=relaxed/simple;
	bh=8GJp6LIloV0RHrttszdpIwblnKc6uljkf1d2c0MC+/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hUJEv7DmKlRMAJo9dbr1683+K03FSDO1t3JyKxJcMhQHFQgJFZLpZXn9emUzRiGhkqTzXhtA9k2Jo9L+YH3wfkJKCEhVrMxqb4DECR3KT4Ew+FDMgJpyuSR4gWDSzxmZ8zYvqNthWYV6JJJ3YmZ13SaYoFpbOA1ek0uhXlYHZZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6ICe/+K; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6ICe/+K"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a501dd544eso151324785a.2
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 15:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724451831; x=1725056631; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Do/QJpPtvafMOYYsDYzOgXAyP1tN33OB7hrK9QH18sw=;
        b=d6ICe/+KO89wBzHGPs64v8976u7nhjVY/2LYhSfzprtNt9xJf+l8YOQ6gWvwjw/d2n
         ydqXI0pCmXBC3zvpz1OZA8EixzO+CcBy5Q5d0Tn1EYiXgGpeSRl8UMfnL2b++X71Xycu
         87cqDxH+ZejI5MMSaCIf+lsFC75Vz0mUQCb22sHhqK3dAOyHBCuxpZjuB6CDrMJ14+eN
         mcqSgt6w9dLjalY3fG7Miz1Yx/Z2ZoQExGMnJl2LlJQPbkBhkJTLvswmWp/8V5qT3qVk
         VjurgkY92TkWNJocuYayjeehG/wDaSP9A540shPfLM4jvgC1xS5yPdpvan3xiGjB9sNF
         BNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724451831; x=1725056631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Do/QJpPtvafMOYYsDYzOgXAyP1tN33OB7hrK9QH18sw=;
        b=dgmj/nXmCcYFlCMMWK+WBIXnPA6DolCwb2H5UMYAy+BTvwvqnkplGndR2UH/MJJH4O
         +y5s4WM4meQ7jLB+JmVDtlr9OqL5jMf4e4ihzptmtwcPjKKgria3k000RLt9hnUdvvPJ
         B9bonAORzRqfkKXAh1SffIHrWS0ZFCS1RSPB/kFXSESTmvYBOzjZMDxzKh1FOQ7WiQI6
         pPAvXlfGbZtsER/wozG1y9XB6udvDx/KLjw6FCPnapNP8gN2KixYLbhokvwjGwcOJbt5
         O5S4e3Z4mqO/tPs2xPNvwVcbzoV5KQ6DuLnPEYszEaMk301g+1VvuRfDs2/QldPssylD
         hO/g==
X-Gm-Message-State: AOJu0YwRR+m24jc8BmzEj0Hy0zS/XD8PKszVHR5GO2n0zlpHsAXwKz3S
	5FnP5Wu57P+EDeMCq1YlpjPapAI4jzF8o3fd1YJOfQDkcVodbOS2InHXSQ==
X-Google-Smtp-Source: AGHT+IHgbJzaOfRPjRNnMg+LuaLgQxpmOlCvidvGCKa6VqOZ0daliTyz4D/TrOfj/NsX6fyRkj7Gqw==
X-Received: by 2002:a05:620a:24c6:b0:7a1:dfe4:5708 with SMTP id af79cd13be357-7a6896fc56emr361528185a.16.1724451831174;
        Fri, 23 Aug 2024 15:23:51 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f41f507sm218860385a.132.2024.08.23.15.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 15:23:50 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 5/8] station: add Affinities DBus property
Date: Fri, 23 Aug 2024 15:23:36 -0700
Message-Id: <20240823222339.328006-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823222339.328006-1-prestwoj@gmail.com>
References: <20240823222339.328006-1-prestwoj@gmail.com>
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

