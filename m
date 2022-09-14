Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C1F3FC2
	for <iwd@lists.linux.dev>; Wed, 14 Sep 2022 15:54:16 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso14850454pjd.4
        for <iwd@lists.linux.dev>; Wed, 14 Sep 2022 08:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=93yyT9/J1X70nzkUQkT3bF8dS1vqLdgNt4i3dTRC3vo=;
        b=NmwZmU7b4pvjkI37wiBFgije7LTIOc/l0++ACbMlFoZ9yMskG7+hKCIE1nNs0M+fvw
         mNtGJe++9wcAKa2jCMG4RKQVAKhkyAb/tE+J0eUTk7CZ7/po+a05+w7OfnL2J6Aoz0JC
         N+swU8W65KLzZfnKkeAvZRmoDbqIfRvOPFpfyImNZSAxXFV12iiuontYzryL9W4z/2aA
         TsR7OJy9LWIbalox39G4Tsprrx/kwnZspEiqsJylKiQ1Csq7HtR200dNvi2wWHOhsEbD
         J6GhdbZdcZK3u9/qTx2f6j84gHElHeaWXv1BVF/SxJPryPb6bHy/RsgyA2r5ueUe2u1u
         1cTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=93yyT9/J1X70nzkUQkT3bF8dS1vqLdgNt4i3dTRC3vo=;
        b=s3uv7z1Q4Y00IWllBjLOfh90v0RXk7O57NZaogLG/vb0KMPT7xad2UGwfPPOqSSQ8g
         kZKtikesdMBrgUX9FKC8br6fBTzj270xxQ3OYnz5s/wlXp3vfv5VXFTTfv55Qwwr+F1y
         A7vD1HRcjwrLbwt9v8yK9gj7/XPeuQyO5gT/3kjgD8/9VBPMOJ1r+NMGAJR2U90KKLsH
         EPJS1jpTz1Euh4GeiX/sjBBskFV7b3vaYX4HhhRkSKC83Vlg6LUO9yU505af9LtICFYl
         Bx5haitpTe/PByFmvKCt9JltmNyXvsJOLa57ZIz2LKau65Z+CBp5250yZC//v2yr04/q
         8iPQ==
X-Gm-Message-State: ACgBeo2qS7D0UhgthdKKGOzKBn5l5/ybDKqBQ0064V84yMMfK8mLUjjT
	7baWvlW7L0kCGtz3U020lZe9IAZILVM=
X-Google-Smtp-Source: AA6agR7OLIAJIZHu7rdiU/MglAGZe7sheiFCHdP+jjB9wznWgiQjIJ/CMXTiUDT4CBEPUrW9/wbOxw==
X-Received: by 2002:a17:902:bd8e:b0:178:25ab:56cc with SMTP id q14-20020a170902bd8e00b0017825ab56ccmr19134545pls.86.1663170855852;
        Wed, 14 Sep 2022 08:54:15 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id gc10-20020a17090b310a00b001fd6066284dsm9379219pjb.6.2022.09.14.08.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 08:54:15 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] station: scan before a forced roam
Date: Wed, 14 Sep 2022 08:54:13 -0700
Message-Id: <20220914155413.748576-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will make the debug API more robust as well as fix issues
certain drivers have when trying to roam. Some of these drivers
may flush scan results after CMD_CONNECT which results in -ENOENT
when trying to roam with CMD_AUTHENTICATE unless you rescan
explicitly.

Now this will be taken care of automatically and station will first
scan for the BSS (or full scan if not already in results) and
attempt to roam once the BSS is seen in a fresh scan.

The logic to replace the old BSS object was factored out into its
own function to be shared by the non-debug roam scan. It was also
simplified to just update the network since this will remove the
old BSS if it exists.
---
 src/station.c | 143 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 124 insertions(+), 19 deletions(-)

diff --git a/src/station.c b/src/station.c
index 66b296b8..4faac050 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2304,6 +2304,21 @@ static void station_roam_scan_triggered(int err, void *user_data)
 	 */
 }
 
+static void station_update_roam_bss(struct station *station,
+					struct scan_bss *bss)
+{
+	struct network *network = station->connected_network;
+	struct scan_bss *old;
+
+	old = l_queue_remove_if(station->bss_list, bss_match_bssid, bss->addr);
+
+	network_bss_update(network, bss);
+	l_queue_push_tail(station->bss_list, bss);
+
+	if (old)
+		scan_bss_free(old);
+}
+
 static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 					const struct scan_freq_set *freqs,
 					void *userdata)
@@ -2412,18 +2427,7 @@ next:
 		goto fail_free_bss;
 	}
 
-	bss = network_bss_find_by_addr(network, best_bss->addr);
-	if (bss) {
-		network_bss_update(network, best_bss);
-		l_queue_remove(station->bss_list, bss);
-		scan_bss_free(bss);
-
-		l_queue_insert(station->bss_list, best_bss,
-				scan_bss_rank_compare, NULL);
-	} else {
-		network_bss_add(network, best_bss);
-		l_queue_push_tail(station->bss_list, best_bss);
-	}
+	station_update_roam_bss(station, best_bss);
 
 	station_transition_start(station, best_bss);
 
@@ -4347,6 +4351,70 @@ static struct l_dbus_message *station_get_diagnostics(struct l_dbus *dbus,
 	return NULL;
 }
 
+struct station_roam_data {
+	struct station *station;
+	struct l_dbus_message *pending;
+	uint8_t bssid[6];
+};
+
+static void station_force_roam_scan_triggered(int err, void *user_data)
+{
+	struct station_roam_data *data = user_data;
+	struct station *station = data->station;
+
+	if (err)
+		station_roam_failed(station);
+}
+
+static bool station_force_roam_scan_notify(int err, struct l_queue *bss_list,
+					const struct scan_freq_set *freqs,
+					void *user_data)
+{
+	struct station_roam_data *data = user_data;
+	struct station *station = data->station;
+	struct scan_bss *target;
+	struct l_dbus_message *reply;
+
+	if (err) {
+		reply = dbus_error_from_errno(err, data->pending);
+		goto reply;
+	}
+
+	target = l_queue_remove_if(bss_list, bss_match_bssid, data->bssid);
+	if (!target) {
+		reply = dbus_error_not_found(data->pending);
+		goto reply;
+	}
+
+	l_debug("Attempting forced roam to BSS "MAC, MAC_STR(target->addr));
+
+	/* The various roam routines expect this to be set from scanning */
+	station->preparing_roam = true;
+
+	station_update_roam_bss(station, target);
+
+	station_transition_start(station, target);
+
+	reply = l_dbus_message_new_method_return(data->pending);
+
+reply:
+	dbus_pending_reply(&data->pending, reply);
+
+	return false;
+}
+
+static void station_force_roam_scan_destroy(void *user_data)
+{
+	struct station_roam_data *data = user_data;
+
+	data->station->roam_scan_id = 0;
+
+	if (data->pending)
+		l_dbus_message_unref(data->pending);
+
+	l_free(data);
+}
+
 static struct l_dbus_message *station_force_roam(struct l_dbus *dbus,
 						struct l_dbus_message *message,
 						void *user_data)
@@ -4356,6 +4424,9 @@ static struct l_dbus_message *station_force_roam(struct l_dbus *dbus,
 	struct l_dbus_message_iter iter;
 	uint8_t *mac;
 	uint32_t mac_len;
+	struct scan_parameters params = { 0 };
+	struct scan_freq_set *freqs = NULL;
+	struct station_roam_data *data;
 
 	if (!l_dbus_message_get_arguments(message, "ay", &iter))
 		goto invalid_args;
@@ -4370,8 +4441,11 @@ static struct l_dbus_message *station_force_roam(struct l_dbus *dbus,
 		return dbus_error_not_connected(message);
 
 	target = network_bss_find_by_addr(station->connected_network, mac);
-	if (!target || target == station->connected_bss)
-		return dbus_error_invalid_args(message);
+	if (!target)
+		goto full_scan;
+
+	if (target && target == station->connected_bss)
+		return dbus_error_already_exists(message);
 
 	if (station->connected_bss->ssid_len != target->ssid_len)
 		goto invalid_args;
@@ -4380,14 +4454,45 @@ static struct l_dbus_message *station_force_roam(struct l_dbus *dbus,
 				target->ssid_len))
 		goto invalid_args;
 
-	l_debug("Attempting forced roam to BSS "MAC, MAC_STR(mac));
+	/*
+	 * Always scan before a roam to ensure the kernel has the BSS in its
+	 * cache. If we already see the BSS only scan that frequency
+	 */
+	freqs = scan_freq_set_new();
+	scan_freq_set_add(freqs, target->frequency);
 
-	/* The various roam routines expect this to be set from scanning */
-	station->preparing_roam = true;
+	params.freqs = freqs;
 
-	station_transition_start(station, target);
+full_scan:
+	params.flush = true;
 
-	return l_dbus_message_new_method_return(message);
+	data = l_new(struct station_roam_data, 1);
+	data->station = station;
+	data->pending = l_dbus_message_ref(message);
+	memcpy(data->bssid, mac, 6);
+
+	station->roam_scan_id = scan_active_full(
+					netdev_get_wdev_id(station->netdev),
+					&params,
+					station_force_roam_scan_triggered,
+					station_force_roam_scan_notify, data,
+					station_force_roam_scan_destroy);
+
+	if (freqs)
+		scan_freq_set_free(freqs);
+
+	if (!station->roam_scan_id) {
+		l_free(data);
+		return dbus_error_failed(message);
+	}
+
+	if (freqs)
+		l_debug("Scanning on %u for BSS "MAC, target->frequency,
+			MAC_STR(mac));
+	else
+		l_debug("Full scan for BSS "MAC, MAC_STR(mac));
+
+	return NULL;
 
 invalid_args:
 	return dbus_error_invalid_args(message);
-- 
2.34.3

