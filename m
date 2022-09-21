Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44C32585
	for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 22:32:05 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id l10so7043795plb.10
        for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 15:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=KEBc22Bu+GJg9F6gOLQO2s4cTGnD71Ye8WlrTqalfis=;
        b=qzEggPr7wh3F3hGkcu1C2jGOp97EVJpCkGD2I0NUk+FbtHjZdEyhFfJa2ZYdGD57O+
         uaokXYF5wHYZT1ffUU3fAV/JqJ1PzkaSA3pLPSgXBPNadZCrK+4Ju4BvupNoyDzEZ42g
         HpTLfZAS0YG7IENCVLFn5JyakMwabv9T/EKY1aa/X5z0orQqFHdW3IiB4cm1tza1WpIV
         E++B2I/sWMEFCKykXay2dII8TY+5sG7M7LiWu2UDFA0clWyaEzaZMZ5vJxv/FHCAq220
         6KJLp+1qxpKcTroA1jLzAQN3oNnu1KCJVhW45T8Lpn6oWQBHWuvzt7Ud7aulfHpRrvE0
         fdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KEBc22Bu+GJg9F6gOLQO2s4cTGnD71Ye8WlrTqalfis=;
        b=e0ailQp3LHFxnKej3S90MqHu0vz4sE+ppDY/v86DLQ7CAHdsw5r1bmkCTWshl1ezKb
         /ZCfhKWULRdfbfQx/MuyVVEqh3UVvHFSt0iXAVZZ9m4LW8aRBJma5y9PL66+i5FCXUBo
         wHBf8FbKxxHMDdSlVfd7TW6cuy9b+kyGU/xB30/K4dkC9d5uhQhOch1d26dZeNO3R7VL
         9MPpLlWAsQVTl4kZoYByvBKvVRSVCKuNfLizLwqZes2J0uEnK/lui36Un/N5MOY+nK3/
         DOvkN7PTHw3ro0f5A/V6BLp7gPVjpXFf9snexy0trYwzP03CteBcrYPP2uDYRRaV4a61
         kLNw==
X-Gm-Message-State: ACrzQf3JuOZ6y0lRVmyFoYAqrU/8CLBjDt8DeCDUDL0UfESuhjr8BFWQ
	I7qyc6+ogEneDBdI8CmjVvOOGoIQbIw=
X-Google-Smtp-Source: AMsMyM7QeHQ8x1eHE7mOCqwHKzM//GjYfcWEakDhGG4taOZQG4RqWkJSrGaarhlYHPonnILDrdnAdw==
X-Received: by 2002:a17:90a:1b43:b0:203:70c0:9f60 with SMTP id q61-20020a17090a1b4300b0020370c09f60mr11646866pjq.184.1663799525034;
        Wed, 21 Sep 2022 15:32:05 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id r10-20020a63e50a000000b00438c0571456sm2393135pgh.24.2022.09.21.15.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 15:32:04 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 08/15] station: create list of roam candidates
Date: Wed, 21 Sep 2022 15:31:51 -0700
Message-Id: <20220921223158.704658-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220921223158.704658-1-prestwoj@gmail.com>
References: <20220921223158.704658-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current behavior is to only find the best roam candidate, which
generally is fine. But if for whatever reason IWD fails to roam it
would be nice having a few backup BSS's rather than having to
re-scan, or worse disassociate and reconnect entirely.

This patch doesn't change the roam behavior, just prepares for
using a roam candidate list. One difference though is any roam
candidates are added to station->bss_list, rather than just the
best BSS. This shouldn't effect any external behavior.

The candidate list is built based on scan_bss rank. First we establish
a base rank, the rank of the current BSS (or zero if AP roaming). Any
BSS in the results with a higher rank, excluding the current BSS, will
be added to the sorted station->roam_bss_list as well as stations
overall BSS list. If the resulting list is empty there were no better
BSS's, otherwise station can now try to roam starting with the best
candidate (head of the roam list).
---
 src/station.c | 84 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 30 deletions(-)

diff --git a/src/station.c b/src/station.c
index 868bb725..df54936e 100644
--- a/src/station.c
+++ b/src/station.c
@@ -107,6 +107,7 @@ struct station {
 
 	/* Set of frequencies to scan first when attempting a roam */
 	struct scan_freq_set *roam_freqs;
+	struct l_queue *roam_bss_list;
 
 	/* Frequencies split into subsets by priority */
 	struct scan_freq_set *scan_freqs_order[3];
@@ -1640,6 +1641,11 @@ static void station_roam_state_clear(struct station *station)
 		scan_freq_set_free(station->roam_freqs);
 		station->roam_freqs = NULL;
 	}
+
+	if (station->roam_bss_list) {
+		l_queue_destroy(station->roam_bss_list, NULL);
+		station->roam_bss_list = NULL;
+	}
 }
 
 static void station_reset_connection_state(struct station *station)
@@ -1981,6 +1987,11 @@ static void station_roamed(struct station *station)
 			l_warn("Could not request neighbor report");
 	}
 
+	if (station->roam_bss_list) {
+		l_queue_destroy(station->roam_bss_list, NULL);
+		station->roam_bss_list = NULL;
+	}
+
 	station_ft_ds_action_start(station);
 
 	station_enter_state(station, STATION_STATE_CONNECTED);
@@ -2005,6 +2016,11 @@ static void station_roam_failed(struct station *station)
 {
 	l_debug("%u", netdev_get_ifindex(station->netdev));
 
+	if (station->roam_bss_list) {
+		l_queue_destroy(station->roam_bss_list, NULL);
+		station->roam_bss_list = NULL;
+	}
+
 	/*
 	 * If we attempted a reassociation or a fast transition, and ended up
 	 * here then we are now disconnected.
@@ -2186,8 +2202,7 @@ static void station_preauthenticate_cb(struct netdev *netdev,
 	station_transition_reassociate(station, bss, new_hs);
 }
 
-static void station_transition_start(struct station *station,
-							struct scan_bss *bss)
+static void station_transition_start(struct station *station)
 {
 	struct handshake_state *hs = netdev_get_handshake(station->netdev);
 	struct network *connected = station->connected_network;
@@ -2195,6 +2210,7 @@ static void station_transition_start(struct station *station,
 	struct handshake_state *new_hs;
 	struct ie_rsn_info cur_rsne, target_rsne;
 	int ret;
+	struct scan_bss *bss = l_queue_peek_head(station->roam_bss_list);
 
 	l_debug("%u, target %s", netdev_get_ifindex(station->netdev),
 			util_address_to_string(bss->addr));
@@ -2334,12 +2350,10 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 	struct handshake_state *hs = netdev_get_handshake(station->netdev);
 	struct scan_bss *current_bss = station->connected_bss;
 	struct scan_bss *bss;
-	struct scan_bss *best_bss = NULL;
-	double best_bss_rank = 0.0;
+	double cur_bss_rank = 0.0;
 	static const double RANK_FT_FACTOR = 1.3;
 	uint16_t mdid;
 	enum security orig_security, security;
-	bool seen = false;
 
 	if (err) {
 		station_roam_failed(station);
@@ -2358,6 +2372,21 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 		ie_parse_mobility_domain_from_data(hs->mde, hs->mde[1] + 2,
 							&mdid, NULL, NULL);
 
+	station->roam_bss_list = l_queue_new();
+
+	/*
+	 * Find the current BSS rank, use the updated result if it exists. If
+	 * this is an AP roam keep the current rank as zero to force the roam
+	 * to occur.
+	 */
+	bss = l_queue_find(bss_list, bss_match_bssid, current_bss->addr);
+	if (bss && !station->ap_directed_roaming) {
+		cur_bss_rank = bss->rank;
+
+		if (hs->mde && bss->mde_present && l_get_le16(bss->mde) == mdid)
+			cur_bss_rank *= RANK_FT_FACTOR;
+	}
+
 	/*
 	 * BSSes in the bss_list come already ranked with their initial
 	 * association preference rank value.  We only need to add preference
@@ -2379,9 +2408,8 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 				bss->frequency, bss->rank, bss->signal_strength,
 				kbps100 / 10, kbps100 % 10);
 
-		/* Skip the BSS we are connected to if doing an AP roam */
-		if (station->ap_directed_roaming && !memcmp(bss->addr,
-				station->connected_bss->addr, 6))
+		/* Skip the BSS we are connected to */
+		if (!memcmp(bss->addr, station->connected_bss->addr, 6))
 			goto next;
 
 		/* Skip result if it is not part of the ESS */
@@ -2395,8 +2423,6 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 		if (security != orig_security)
 			goto next;
 
-		seen = true;
-
 		if (network_can_connect_bss(network, bss) < 0)
 			goto next;
 
@@ -2408,15 +2434,19 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 		if (hs->mde && bss->mde_present && l_get_le16(bss->mde) == mdid)
 			rank *= RANK_FT_FACTOR;
 
-		if (rank > best_bss_rank) {
-			if (best_bss)
-				scan_bss_free(best_bss);
+		if (rank <= cur_bss_rank)
+			goto next;
 
-			best_bss = bss;
-			best_bss_rank = rank;
+		/*
+		 * We need to update/add any potential roam candidate so
+		 * station/network know it exists.
+		 */
+		station_update_roam_bss(station, bss);
 
-			continue;
-		}
+		l_queue_insert(station->roam_bss_list, bss,
+				scan_bss_rank_compare, NULL);
+
+		continue;
 
 next:
 		scan_bss_free(bss);
@@ -2424,25 +2454,17 @@ next:
 
 	l_queue_destroy(bss_list, NULL);
 
-	if (!seen)
-		goto fail_free_bss;
-
 	/* See if we have anywhere to roam to */
-	if (!best_bss || scan_bss_addr_eq(best_bss, station->connected_bss)) {
+	if (l_queue_isempty(station->roam_bss_list)) {
 		station_debug_event(station, "no-roam-candidates");
-		goto fail_free_bss;
+		goto fail;
 	}
 
-	station_update_roam_bss(station, best_bss);
-
-	station_transition_start(station, best_bss);
+	station_transition_start(station);
 
 	return true;
 
-fail_free_bss:
-	if (best_bss)
-		scan_bss_free(best_bss);
-
+fail:
 	station_roam_failed(station);
 
 	return true;
@@ -4398,10 +4420,12 @@ static bool station_force_roam_scan_notify(int err, struct l_queue *bss_list,
 
 	/* The various roam routines expect this to be set from scanning */
 	station->preparing_roam = true;
+	station->roam_bss_list = l_queue_new();
+	l_queue_push_tail(station->roam_bss_list, target);
 
 	station_update_roam_bss(station, target);
 
-	station_transition_start(station, target);
+	station_transition_start(station);
 
 	reply = l_dbus_message_new_method_return(data->pending);
 
-- 
2.34.3

