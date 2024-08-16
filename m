Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E781741D2
	for <iwd@lists.linux.dev>; Fri, 16 Aug 2024 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723812742; cv=none; b=hApvjGJbwCS3+ZIsMVPbUBPk6L6rNQalxIIdLZxdQh/oZufEiKraJ2y0jPlMyT5xCNU1WBrrmOZ0SqZpU9Gi3n0YBvFtvJ3ougWp/JlbsFE6h1y+NOQGALXcPnY6c8CycKtzJ6zqKNnud66jds0BDKDW9gOup5U3X4HvEJwcvkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723812742; c=relaxed/simple;
	bh=rz2zxxgcFIenkrSykQF/Xglw0PTg/msxDuJvSXRirEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Swjgs7ncMZeaolWhLNf2r4h25kRlBmdAjTjzR6R/R2K7DmVj/Y/NG7/4w8cGou5gMkU/mmpV/kiC+nL2cz/YUX79q1FoJD+ox9wBpjaozXwXAVhyILjp1e559MAwZXUS2kr9TnrIruyo5UEb/APW8NIq2Q6hhBn+lrdZD2pYDQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsiEFb7S; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsiEFb7S"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44fea44f725so15700231cf.1
        for <iwd@lists.linux.dev>; Fri, 16 Aug 2024 05:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723812739; x=1724417539; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuofz8v0KMzDxQBkLp5djOAqsITua8Ho2HF+XRC4t1A=;
        b=KsiEFb7SVAAt7OudFDu6+r9bCAkQNPMhh9mD/Xvhf4u+MCcvCVbM+xemcRsVY/Guu5
         76uaYjxQdnxUIPOlVQUrcWPM7UM7+LyPMFYWdTq0vcAs0ClPxxE5418i5CQagGQXZZU/
         dsljkr5O/NkkH0VgcqxCD4Adxyz9/EkDrVDDnAbbp5q1TXpE/6aMMPFdi5IsdscfT775
         h+PZ5Q2p22G84WNdrs4xftD1AQmxjPR+gB7J6szY2kpY+TR45/pK6+YRnoQcOsGiu1Ot
         0pfpx8D3rQaT70eOWORmgcLYuUvF9r27GT+zERMt7DumGGMSfEzI5nIHcJPwhNGZKa0D
         Y0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723812739; x=1724417539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fuofz8v0KMzDxQBkLp5djOAqsITua8Ho2HF+XRC4t1A=;
        b=NIy2LiI9nh0Ku2RRNYpvdSPPyhH+/6Sp2p1crGMSSAiizWZ9FcIZ9nvLwrqeeswrCb
         j5cBO0AsnDCww0iU8MDrNIuLXWVGQiAnSmpGNGQJD6q8GpG03MhJYU+iEC+oR2U8ooJD
         k3Dchzv+en9XDdQO5MR8IXhNzkm0sMqyiJFuo6EZTDv7hWPJwMYd6ItEdPRllu4OsYVX
         xgXpqnze+JCAXbLHcduHBET8oL7jPf8pIla/P4IPG4abHWAOaQjNdiaqHRJ35+ghTO85
         vu7Fhpcy3ZD+cj6RANICSSsF8LupQex0cXavVGR5HsA/9uTvnAfyCINNRMHtRN/AqOTQ
         fwVg==
X-Gm-Message-State: AOJu0Yy4Z0xSzi8R5Qemkj7VQb1ngxNCWJePPfLbbpBYX5BMRo3F77eq
	1r7H1zb+4TCFjEn/CClEyN8wZyK4rg0+inxDB5pa69uyR5rBjRFY8Z0lnQ==
X-Google-Smtp-Source: AGHT+IFJRfCAKqqBEPTG0i40QcHFjqN+gQfFSScvd4A0wUVQP2tjjvPGe4d7PQEwkeyAfyIKxwPU3g==
X-Received: by 2002:ac8:1005:0:b0:453:761d:7dab with SMTP id d75a77b69052e-453761d90b5mr33187091cf.2.1723812739158;
        Fri, 16 Aug 2024 05:52:19 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369ff54ffsm15921931cf.36.2024.08.16.05.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 05:52:18 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/6] station: move BasicServiceSet DBus management into station
Date: Fri, 16 Aug 2024 05:52:10 -0700
Message-Id: <20240816125214.1162415-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816125214.1162415-1-prestwoj@gmail.com>
References: <20240816125214.1162415-1-prestwoj@gmail.com>
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
 src/station.c | 89 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 72 insertions(+), 17 deletions(-)

diff --git a/src/station.c b/src/station.c
index 06b19db3..25ddce43 100644
--- a/src/station.c
+++ b/src/station.c
@@ -350,8 +350,6 @@ static bool process_network(const void *key, void *data, void *user_data)
 	struct process_network_data *process_data = user_data;
 	struct station *station = process_data->station;
 
-	network_bss_stop_update(network, process_data->freqs);
-
 	if (!network_bss_list_isempty(network)) {
 		bool connected = network == station->connected_network;
 
@@ -431,6 +429,65 @@ static void station_print_scan_bss(const struct scan_bss *bss)
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
+static bool station_register_bss(struct station *station, struct scan_bss *bss)
+{
+	struct scan_bss *old;
+	const char *path = station_get_bss_path(station, bss);
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
@@ -518,6 +575,7 @@ static struct network *station_add_seen_bss(struct station *station,
 	}
 
 	network_bss_add(network, bss);
+	station_register_bss(station, bss);
 
 	return network;
 }
@@ -540,7 +598,7 @@ struct bss_expiration_data {
 	struct scan_bss *connected_bss;
 	uint64_t now;
 	const struct scan_freq_set *freqs;
-	struct l_queue *free_list;
+	struct station *station;
 };
 
 #define SCAN_RESULT_BSS_RETENTION_TIME (30 * 1000000)
@@ -562,20 +620,21 @@ static bool bss_free_if_expired(void *data, void *user_data)
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
@@ -823,6 +882,7 @@ static bool station_owe_transition_results(int err, struct l_queue *bss_list,
 
 		l_queue_push_tail(station->bss_list, bss);
 		network_bss_add(network, bss);
+		station_register_bss(station, bss);
 
 		continue;
 
@@ -951,7 +1011,6 @@ void station_set_scan_results(struct station *station,
 	const struct l_queue_entry *bss_entry;
 	struct network *network;
 	struct process_network_data data;
-	struct l_queue *free_list = l_queue_new();
 
 	l_queue_foreach_remove(new_bss_list, bss_free_if_ssid_not_utf8, NULL);
 
@@ -963,7 +1022,7 @@ void station_set_scan_results(struct station *station,
 	l_queue_destroy(station->autoconnect_list, NULL);
 	station->autoconnect_list = NULL;
 
-	station_bss_list_remove_expired_bsses(station, freqs, free_list);
+	station_bss_list_remove_expired_bsses(station, freqs);
 
 	for (bss_entry = l_queue_get_entries(station->bss_list); bss_entry;
 						bss_entry = bss_entry->next) {
@@ -975,12 +1034,8 @@ void station_set_scan_results(struct station *station,
 			if (old_bss == station->connected_bss)
 				station->connected_bss = new_bss;
 
-			/*
-			 * The network object is still holding a reference to
-			 * the BSS. Until we tell network to replace the BSS
-			 * with a new object, don't free it.
-			 */
-			l_queue_push_head(free_list, old_bss);
+			station_register_bss(station, new_bss);
+			scan_bss_free(old_bss);
 
 			continue;
 		}
@@ -1017,8 +1072,6 @@ void station_set_scan_results(struct station *station,
 
 	l_hashmap_foreach_remove(station->networks, process_network, &data);
 
-	l_queue_destroy(free_list, bss_free);
-
 	station->autoconnect_can_start = trigger_autoconnect;
 	station_autoconnect_start(station);
 }
@@ -2652,6 +2705,7 @@ static void station_update_roam_bss(struct station *station,
 		l_queue_remove_if(station->bss_list, bss_match, bss);
 
 	network_bss_update(network, bss);
+	station_register_bss(station, bss);
 	l_queue_push_tail(station->bss_list, bss);
 
 	if (old)
@@ -3160,6 +3214,7 @@ static void station_event_roamed(struct station *station, struct scan_bss *new)
 	struct scan_bss *stale;
 
 	network_bss_update(station->connected_network, new);
+	station_register_bss(station, new);
 
 	/* Remove new BSS if it exists in past scan results */
 	stale = l_queue_remove_if(station->bss_list, bss_match, new);
-- 
2.34.1

