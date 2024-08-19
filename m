Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50A813698F
	for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083065; cv=none; b=k0e+q9QwEXEptepNzcb9UYAxFZpAX0WGibdW+CAW34dl7Wt+8riNhSnV2gZKWycXVuwZ2IjCAaehIAyHlmKj9Nlhb4GcENAynpUsR1acbfTzReOF7PyiTtMBSM9pWiZh0JzAovYrkk6nRf1Eija3fKiPJsIHlAK2mMAeT8+Ff9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083065; c=relaxed/simple;
	bh=qVS0WEusawa8e9zmO93xAlJSemRdRXWTa9cFK8H5yjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hq5IvP2m8/mmOO57OwyPARod1O3dKfRrepBmpLMAYHyEaJ8iwlDeHiSUvS1EOZB3o+aLa4msXyTfqP/dL1UIlqLGR1bQr8JT3bQ0BWIQyZ6EjEmUflVn6Jel6HtbjhdaY9AMxDlCxhiXU/7E89wu91EmAr6Ckk8WSpfFvmbUUhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZ/PcFeb; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZ/PcFeb"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70d162eef54so2811460b3a.3
        for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 08:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724083063; x=1724687863; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68ags4Z/fglRocc1Zec5AK6s5R+ogqTtMIGOd/mlYiI=;
        b=IZ/PcFebVKZkLy2BWJC6j7E4iRbEUZX0KFLAs8ykrxVGjUa9+Q7oqm7cMmBmaaLD29
         zCUX4xIAIVj4s42eaF8WRAMp+z0Yg50ornbGe00JmtewMDI9jZ6kx/PfTb/Jp0eyYIPv
         YGRIAtbQp13nmG09UPMZQBb0LOw+jmCp0hxESVcbOlp1WoVFMJKyu6H1whRUqtNSthRH
         UfxbNSd/+cluB1O9dZadaIWN5HzX0ESwFhHpjlJpuU5xpbHgLRXM04IzUD6PBfpOVuCm
         ycs0XU3UR7STBeX6RvAy6UcS7hU/4UlEv4P6uWtTX+1K0jJjfTCgZM4g/pLskAYwObYB
         a1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724083063; x=1724687863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68ags4Z/fglRocc1Zec5AK6s5R+ogqTtMIGOd/mlYiI=;
        b=DYBGWWuXKQwir2B+V8GKlgLc8OaxPcIzn9AhpSjaMaHrcmi7VulFl/o3Qusa349CfW
         uVP9SneP5Sobr4qfwZhehn6bpddMnfHyFzrNgdkbyKVq4NmI3H4YVgbmgttiR9iSRFm8
         Eclv21vnBPz8nF7PI4XqaCGTOZaCd3mBX7LyPNy8m5zkrCiwWO95hqIVXHxeCJhaWSwR
         XUiK93DERzSPDypQA2wVi3Nn0+HNYEGOxp+2B5LelvR4y2aoofGuAkNFHzz1dNXFMtRi
         BljfWfoROXLkeoU75lAaJJzr4VDY5RjGJw0laZu8+9DVTTJPQ12v3GMVUeiDSjQWOls/
         8CoQ==
X-Gm-Message-State: AOJu0Ywpfu/JrhRyxbAN0FbZbfWOR5blP4xX9uyNOJyilzPDCSeCT1N+
	dkKbJWzSmxNwiCvqwjcLRMMRkY46RwMBHKkiPGl8MXwREBgFWkEPfuaS+w==
X-Google-Smtp-Source: AGHT+IH3Dj+qyA0AHumL/H2aQOO3aDwHsErjv2IRNHSZHFCfm1tJZM4tn8b+nyVl21N2YzwRY7KwMQ==
X-Received: by 2002:a05:6a21:3998:b0:1c0:f5be:a3ca with SMTP id adf61e73a8af0-1c904fc0f42mr10770208637.30.1724083062630;
        Mon, 19 Aug 2024 08:57:42 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae0cb5asm6752277b3a.69.2024.08.19.08.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 08:57:42 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/6] station: move BasicServiceSet DBus management into station
Date: Mon, 19 Aug 2024 08:57:30 -0700
Message-Id: <20240819155734.1276476-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819155734.1276476-1-prestwoj@gmail.com>
References: <20240819155734.1276476-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to an unnoticed bug after adding the BasicServiceSet object into
network, it became clear that since station already owns the scan_bss
objects it makes sense for it to manage the associated DBus objects
as well. This way network doesn't have to jump through hoops to
determine if the scan_bss object was remove, added, or updated. It
can just manage its list as it did prior.

From the station side this makes things very easy. When scan results
come in we either update or add a new DBus object. And any time a
scan_bss is freed we remove the DBus object.
---
 src/station.c | 91 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 74 insertions(+), 17 deletions(-)

v2:
 * For station_register_bss() the caller always has access to the network
   object so pass that and use network_get_path() instead of deriving the
   entire path manually. For unregistration we still have to derive it
   because we don't have a network object handy.
 
diff --git a/src/station.c b/src/station.c
index 06b19db3..2a58c69a 100644
--- a/src/station.c
+++ b/src/station.c
@@ -350,8 +350,6 @@ static bool process_network(const void *key, void *data, void *user_data)
 	struct process_network_data *process_data = user_data;
 	struct station *station = process_data->station;
 
-	network_bss_stop_update(network, process_data->freqs);
-
 	if (!network_bss_list_isempty(network)) {
 		bool connected = network == station->connected_network;
 
@@ -431,6 +429,66 @@ static void station_print_scan_bss(const struct scan_bss *bss)
 			optional);
 }
 
+static const char *station_get_bss_path(struct station *station,
+						struct scan_bss *bss)
+{
+	enum security security;
+	char ssid[33];
+	const char *network_path;
+
+	memcpy(ssid, bss->ssid, bss->ssid_len);
+	ssid[bss->ssid_len] = '\0';
+
+	if (scan_bss_get_security(bss, &security) < 0)
+		return NULL;
+
+	network_path = iwd_network_get_path(station, ssid, security);
+	if (!network_path)
+		return NULL;
+
+	return __network_path_append_bss(network_path, bss);
+}
+
+static bool station_unregister_bss(struct station *station,
+					struct scan_bss *bss)
+{
+	const char *path = station_get_bss_path(station, bss);
+
+	if (L_WARN_ON(!path))
+		return false;
+
+	return l_dbus_unregister_object(dbus_get_bus(), path);
+}
+
+static bool station_register_bss(struct network *network, struct scan_bss *bss)
+{
+	struct scan_bss *old;
+	const char *path = __network_path_append_bss(network_get_path(network),
+							bss);
+
+	if (L_WARN_ON(!path))
+		return false;
+
+	/*
+	 * If we find this path in the object tree update the data to the new
+	 * scan_bss pointer, as this one will be freed soon.
+	 */
+	old = l_dbus_object_get_data(dbus_get_bus(), path, IWD_BSS_INTERFACE);
+	if (old)
+		return l_dbus_object_set_data(dbus_get_bus(), path,
+						IWD_BSS_INTERFACE, bss);
+
+	if (!l_dbus_object_add_interface(dbus_get_bus(), path,
+						IWD_BSS_INTERFACE, bss))
+		return false;
+
+	if (!l_dbus_object_add_interface(dbus_get_bus(), path,
+					L_DBUS_INTERFACE_PROPERTIES, bss))
+		return false;
+
+	return true;
+}
+
 /*
  * Returns the network object the BSS was added to or NULL if ignored.
  */
@@ -518,6 +576,7 @@ static struct network *station_add_seen_bss(struct station *station,
 	}
 
 	network_bss_add(network, bss);
+	station_register_bss(network, bss);
 
 	return network;
 }
@@ -540,7 +599,7 @@ struct bss_expiration_data {
 	struct scan_bss *connected_bss;
 	uint64_t now;
 	const struct scan_freq_set *freqs;
-	struct l_queue *free_list;
+	struct station *station;
 };
 
 #define SCAN_RESULT_BSS_RETENTION_TIME (30 * 1000000)
@@ -562,20 +621,21 @@ static bool bss_free_if_expired(void *data, void *user_data)
 			bss->time_stamp + SCAN_RESULT_BSS_RETENTION_TIME))
 		return false;
 
-	l_queue_push_head(expiration_data->free_list, bss);
+	station_unregister_bss(expiration_data->station, bss);
+
+	scan_bss_free(bss);
 
 	return true;
 }
 
 static void station_bss_list_remove_expired_bsses(struct station *station,
-					const struct scan_freq_set *freqs,
-					struct l_queue *free_list)
+					const struct scan_freq_set *freqs)
 {
 	struct bss_expiration_data data = {
 		.now = l_time_now(),
 		.connected_bss = station->connected_bss,
 		.freqs = freqs,
-		.free_list = free_list,
+		.station = station,
 	};
 
 	l_queue_foreach_remove(station->bss_list, bss_free_if_expired, &data);
@@ -823,6 +883,7 @@ static bool station_owe_transition_results(int err, struct l_queue *bss_list,
 
 		l_queue_push_tail(station->bss_list, bss);
 		network_bss_add(network, bss);
+		station_register_bss(network, bss);
 
 		continue;
 
@@ -951,7 +1012,6 @@ void station_set_scan_results(struct station *station,
 	const struct l_queue_entry *bss_entry;
 	struct network *network;
 	struct process_network_data data;
-	struct l_queue *free_list = l_queue_new();
 
 	l_queue_foreach_remove(new_bss_list, bss_free_if_ssid_not_utf8, NULL);
 
@@ -963,7 +1023,7 @@ void station_set_scan_results(struct station *station,
 	l_queue_destroy(station->autoconnect_list, NULL);
 	station->autoconnect_list = NULL;
 
-	station_bss_list_remove_expired_bsses(station, freqs, free_list);
+	station_bss_list_remove_expired_bsses(station, freqs);
 
 	for (bss_entry = l_queue_get_entries(station->bss_list); bss_entry;
 						bss_entry = bss_entry->next) {
@@ -975,12 +1035,7 @@ void station_set_scan_results(struct station *station,
 			if (old_bss == station->connected_bss)
 				station->connected_bss = new_bss;
 
-			/*
-			 * The network object is still holding a reference to
-			 * the BSS. Until we tell network to replace the BSS
-			 * with a new object, don't free it.
-			 */
-			l_queue_push_head(free_list, old_bss);
+			scan_bss_free(old_bss);
 
 			continue;
 		}
@@ -1007,6 +1062,8 @@ void station_set_scan_results(struct station *station,
 		if (!scan_freq_set_contains(freqs, bss->frequency))
 			continue;
 
+		station_register_bss(network, bss);
+
 		station_start_anqp(station, network, bss);
 	}
 
@@ -1017,8 +1074,6 @@ void station_set_scan_results(struct station *station,
 
 	l_hashmap_foreach_remove(station->networks, process_network, &data);
 
-	l_queue_destroy(free_list, bss_free);
-
 	station->autoconnect_can_start = trigger_autoconnect;
 	station_autoconnect_start(station);
 }
@@ -2652,6 +2707,7 @@ static void station_update_roam_bss(struct station *station,
 		l_queue_remove_if(station->bss_list, bss_match, bss);
 
 	network_bss_update(network, bss);
+	station_register_bss(network, bss);
 	l_queue_push_tail(station->bss_list, bss);
 
 	if (old)
@@ -3160,6 +3216,7 @@ static void station_event_roamed(struct station *station, struct scan_bss *new)
 	struct scan_bss *stale;
 
 	network_bss_update(station->connected_network, new);
+	station_register_bss(station->connected_network, new);
 
 	/* Remove new BSS if it exists in past scan results */
 	stale = l_queue_remove_if(station->bss_list, bss_match, new);
-- 
2.34.1

