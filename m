Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3648B23
	for <iwd@lists.linux.dev>; Thu, 22 Sep 2022 22:08:14 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id v186so2689009pfv.11
        for <iwd@lists.linux.dev>; Thu, 22 Sep 2022 15:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8zeQ9hV7F5E7+NNg4pgVIkUZOKqYlDcLTsspPPixF/c=;
        b=Zb557IgIok74brsLU4G+Ij73TbG9/DYRzGwHhWl1kthr9+nS9+lTp/tXTL8ZDAPskr
         NrIzECCWqa4sHp/c35vTfoYex5YgGTLL5g1TRoDkZIBmS8U8JpLNsigMSUiWYFi+uDbV
         Vu+s80ol6WG4fjMYyOr7W/blHMNDFwpFLicFp+VNGwNY8aU6pcWU+FhRjNar9fqr+1te
         Z0XjxiufRZl22uzn+iV4hT1my8eUDq1o0ftF4aq99D20qo4499g/1W1R/pG5fKqnGwUi
         pZ6ANNHE7WiUOW5K0WEvcdYqItxKo5jMuz/Caqya2ed0MTei5rYeQZGLQTpe7cmAD6w5
         On7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8zeQ9hV7F5E7+NNg4pgVIkUZOKqYlDcLTsspPPixF/c=;
        b=YMkDRgLbZsKCx1NFlN82CrklJ3eChh+/iaYRHBE4y7Oa/ABi/j/SUI46p1BlZvthJl
         jnjZMglDKQ5Ia524bbZ4MSBdsLVHhyHT0OY+9YaNlDHxmRdAjt8EQQVjRtxB6ONDca1b
         bwt4d53/GbsxGxN2+2p8CyrLnINIHmzosvGqvoJ2Vf51sTNwdGKpZGhxdsZ6gavW1/D5
         xnygK8FloXziPLbr0KO/ofvAHMNd3IsLePz9VWmfIHoVkm/9+KkUmH8ygOVbA3lZaaa3
         NBCFL9vYYifxguw06ifi28H0sygP+ZAsqPnwFfwBpy/WJ5Pj9XLBkOQGeE98Q3t0yM2l
         fxiA==
X-Gm-Message-State: ACrzQf0v/fDJ/tQ9eAfWnoiEW2ivav8kcqzL+u++I2ZJ/MPHXQLmPDsL
	ARQvNn9WGfiIY+T86SlEV0Y1RDaps04=
X-Google-Smtp-Source: AMsMyM7BPEQjJ4CI8tgDfgmvd1QzDjEYzz+cuX965U5RjAbXmUjqI19KyhFCcGsW8ATonY4bBBRC3w==
X-Received: by 2002:a63:e709:0:b0:438:98e8:d1c with SMTP id b9-20020a63e709000000b0043898e80d1cmr4931458pgi.403.1663884493697;
        Thu, 22 Sep 2022 15:08:13 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id f15-20020aa7968f000000b005386162bc2asm4980448pfk.92.2022.09.22.15.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 15:08:13 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 04/11] station: create list of roam candidates
Date: Thu, 22 Sep 2022 15:08:02 -0700
Message-Id: <20220922220809.862022-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220922220809.862022-1-prestwoj@gmail.com>
References: <20220922220809.862022-1-prestwoj@gmail.com>
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
 src/station.c | 76 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 30 deletions(-)

diff --git a/src/station.c b/src/station.c
index 868bb725..991c8394 100644
--- a/src/station.c
+++ b/src/station.c
@@ -107,6 +107,7 @@ struct station {
 
 	/* Set of frequencies to scan first when attempting a roam */
 	struct scan_freq_set *roam_freqs;
+	struct l_queue *roam_bss_list;
 
 	/* Frequencies split into subsets by priority */
 	struct scan_freq_set *scan_freqs_order[3];
@@ -1640,6 +1641,8 @@ static void station_roam_state_clear(struct station *station)
 		scan_freq_set_free(station->roam_freqs);
 		station->roam_freqs = NULL;
 	}
+
+	l_queue_clear(station->roam_bss_list, NULL);
 }
 
 static void station_reset_connection_state(struct station *station)
@@ -1981,6 +1984,8 @@ static void station_roamed(struct station *station)
 			l_warn("Could not request neighbor report");
 	}
 
+	l_queue_clear(station->roam_bss_list, NULL);
+
 	station_ft_ds_action_start(station);
 
 	station_enter_state(station, STATION_STATE_CONNECTED);
@@ -2005,6 +2010,8 @@ static void station_roam_failed(struct station *station)
 {
 	l_debug("%u", netdev_get_ifindex(station->netdev));
 
+	l_queue_clear(station->roam_bss_list, NULL);
+
 	/*
 	 * If we attempted a reassociation or a fast transition, and ended up
 	 * here then we are now disconnected.
@@ -2186,8 +2193,7 @@ static void station_preauthenticate_cb(struct netdev *netdev,
 	station_transition_reassociate(station, bss, new_hs);
 }
 
-static void station_transition_start(struct station *station,
-							struct scan_bss *bss)
+static void station_transition_start(struct station *station)
 {
 	struct handshake_state *hs = netdev_get_handshake(station->netdev);
 	struct network *connected = station->connected_network;
@@ -2195,6 +2201,7 @@ static void station_transition_start(struct station *station,
 	struct handshake_state *new_hs;
 	struct ie_rsn_info cur_rsne, target_rsne;
 	int ret;
+	struct scan_bss *bss = l_queue_peek_head(station->roam_bss_list);
 
 	l_debug("%u, target %s", netdev_get_ifindex(station->netdev),
 			util_address_to_string(bss->addr));
@@ -2334,12 +2341,10 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
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
@@ -2358,6 +2363,19 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 		ie_parse_mobility_domain_from_data(hs->mde, hs->mde[1] + 2,
 							&mdid, NULL, NULL);
 
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
@@ -2379,9 +2397,8 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 				bss->frequency, bss->rank, bss->signal_strength,
 				kbps100 / 10, kbps100 % 10);
 
-		/* Skip the BSS we are connected to if doing an AP roam */
-		if (station->ap_directed_roaming && !memcmp(bss->addr,
-				station->connected_bss->addr, 6))
+		/* Skip the BSS we are connected to */
+		if (!memcmp(bss->addr, station->connected_bss->addr, 6))
 			goto next;
 
 		/* Skip result if it is not part of the ESS */
@@ -2395,8 +2412,6 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 		if (security != orig_security)
 			goto next;
 
-		seen = true;
-
 		if (network_can_connect_bss(network, bss) < 0)
 			goto next;
 
@@ -2408,15 +2423,19 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
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
@@ -2424,25 +2443,17 @@ next:
 
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
@@ -4158,6 +4169,8 @@ static struct station *station_create(struct netdev *netdev)
 
 	station_set_autoconnect(station, autoconnect);
 
+	station->roam_bss_list = l_queue_new();
+
 	return station;
 }
 
@@ -4247,6 +4260,8 @@ static void station_free(struct station *station)
 
 	wiphy_state_watch_remove(station->wiphy, station->wiphy_watch);
 
+	l_queue_destroy(station->roam_bss_list, NULL);
+
 	l_free(station);
 }
 
@@ -4398,10 +4413,11 @@ static bool station_force_roam_scan_notify(int err, struct l_queue *bss_list,
 
 	/* The various roam routines expect this to be set from scanning */
 	station->preparing_roam = true;
+	l_queue_push_tail(station->roam_bss_list, target);
 
 	station_update_roam_bss(station, target);
 
-	station_transition_start(station, target);
+	station_transition_start(station);
 
 	reply = l_dbus_message_new_method_return(data->pending);
 
-- 
2.34.3

