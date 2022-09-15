Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0114C91
	for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 22:08:00 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id y11so2197959pjv.4
        for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 15:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=4pB85YXkAdg40SalJpRVQqeYfyyI6OFjA3610XZ7DiU=;
        b=a/ztjQw/9tQC43yANPe0iGcr68+pBrgg07OGUYy54yhIxvZBciOapEcipd08bBqXij
         sV69Yyz+1qL7o5z3mkrkgSete+YY9D8lrpub1vyBXrzJ4cMbSc/NLNHKiMbI/dTHwwB4
         ooO5Ly6ymILOoDJx3YCzOyG8w/52P9kETSTGjUi7iCt9IvS0uJNByZ9K8VJCFD9iIyC3
         HopfQP9Ulu2WYTBky70QHyglreYYLcDuqA8HvZy9lGcZ8sofB6lCQc1pW2f++pmueG88
         2NIq05U3xeC48XzxIFfLLPxrGuIdEFM8MEwU76C949X8Yxv5W703nYxU1pUgz7UexO5J
         FEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4pB85YXkAdg40SalJpRVQqeYfyyI6OFjA3610XZ7DiU=;
        b=MjW8ggF/csbfmYTDmqDsT3udcSIGKuqjM2IPCcbpRQQ1VT0hBC2/mAmu+34AKUMDZk
         pRNuk4E469wA1q2EL1iI7aravwF1vfXvgV9qt8APg75gM8FZomvw7RfP3rKmgdHXaQ54
         h8y8ypIjP1w9JoJhuW3tUuJtpCQ+EJw34gmjhh42RTM60y4mKfQ/Z844nmZctuIjJ8B5
         6onqtp8jGhy52CufF98MtGv+i4+/PAQWDPRFsIDiZHMDFHJ+/0zxr/1d+RODwY20n4DH
         MNVaC/a9opVl/3ol+OV0nTntFF0imfPKAQVieKlS5JDwRI5vRvEhN4o1CNaJ/gnK6nBt
         zNBQ==
X-Gm-Message-State: ACrzQf0vIAw7z0lJ74Bq3kNn8SydjjbDZx/CiaI4z1fb2XYnaUkye3mD
	rFhZiEtyZMbei8xCmQakLn0evQJhUqg=
X-Google-Smtp-Source: AMsMyM6VnywWD42xvorLnqUXQnfvxfO+VDScFH7gZzJyy1SfM3O0n50Sy5Bff8xmSiW7FgAczlPjTg==
X-Received: by 2002:a17:90b:4f90:b0:202:9be9:2c92 with SMTP id qe16-20020a17090b4f9000b002029be92c92mr12900200pjb.140.1663279679567;
        Thu, 15 Sep 2022 15:07:59 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id k2-20020a6555c2000000b0041c0c9c0072sm12147165pgs.64.2022.09.15.15.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 15:07:59 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 12/14] station: create list of roam candidates
Date: Thu, 15 Sep 2022 15:07:39 -0700
Message-Id: <20220915220741.1128728-12-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220915220741.1128728-1-prestwoj@gmail.com>
References: <20220915220741.1128728-1-prestwoj@gmail.com>
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
index 79d2c755..76023520 100644
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
@@ -4396,10 +4418,12 @@ static bool station_force_roam_scan_notify(int err, struct l_queue *bss_list,
 
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

