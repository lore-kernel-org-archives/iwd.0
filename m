Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3294A18
	for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 18:25:34 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id r69so10125797pgr.2
        for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 11:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=MK443qbrSJ+NQ7mbUC4R5V85T6XrEWA/99+qPDUxiPE=;
        b=BmrZOg8rVCa7BHklmAaEL4vb1fp7zrvx6+JTvohBPqDrwRC9OGvw/BrgeIjuoPTjpn
         Cu5YbHiWHitCERDatGkv5dngX6LTg1w8hCJ22uYxxNZ+pQS2H51lBIlYlMdRZlGEL+Bi
         Sqzv2TYHYvIYx2cq1zwzjJSjGtTpBlYEguKiqxnK+CGY8ExmiJuR0KQlhAoKhvgE6/ma
         23Hqz6Q7j+2N0pEmtIeYnAc6gAvqSgMeFGzCimL5EEJvEFCDbLzS6psLMtYr84ztqKev
         iVcX4yCZOcxd07ex+iAqCOX6IhrTdnJYUzlYKiZOsKDH3JpXmvL8tr3gAF+1+2QQjqjj
         CW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=MK443qbrSJ+NQ7mbUC4R5V85T6XrEWA/99+qPDUxiPE=;
        b=sMl3XP78nVbxd0oxQdchxCILK+X3otgJ8IXnVdCgSIwg3XGxmJNhO8vVFFFor48Srl
         ygH/Sv0Ut5sb69l0ynoxmi6j/ESh3Eu+aEbj5lCjLrvEAdm86yUS/Va6vZh/PA6uGJLz
         XpQJRAxztUfPODxdSn50Q979AT2ZqIr0Ren0VYKkrvZXtpT1geY7TyXkRjfBnz/YetMs
         C5sqRG3l1S2GYlMsfdmWCcxbjtuOVxAknaObKohQHpeYDTVimjZBhxR6gR5vHcBZlcGB
         QtNYPxmbY21C+rU5KH3Y8CLOetoYv4rHAMWb92R95hv2pdYaQXf9WXCZcJwtQe5Vczv3
         dDvA==
X-Gm-Message-State: ACgBeo2/8zrXeA+XjwCKVpbBaS/eIFRkaTHtFFxC+XHrAC5YnSbZfCxh
	JiAErBS55uLMAiEB4ov8/keDAQVMLiE=
X-Google-Smtp-Source: AA6agR6EyULYJvoHB6KA8XF4vz05VtEF2IqH08kXWvTIX/nWdH2hDmVjYU2qnDi0T0fWv2wzNHfxXw==
X-Received: by 2002:a05:6a00:1650:b0:52f:20d6:e858 with SMTP id m16-20020a056a00165000b0052f20d6e858mr21915774pfc.36.1661192733705;
        Mon, 22 Aug 2022 11:25:33 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709026f0100b00172bd4c12b2sm1612024plk.224.2022.08.22.11.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 11:25:33 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/9] station: have station_transition_start take a list of BSS's
Date: Mon, 22 Aug 2022 11:25:19 -0700
Message-Id: <20220822182525.2078312-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220822182525.2078312-1-prestwoj@gmail.com>
References: <20220822182525.2078312-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This prepares for the FT-over-Air refactor, which will allow a
candidate list to be provided to netdev_fast_transition. For now
generate this candidate list but use the first (best) entry for the
roam.

This does slightly change the logic and all roam candidates are
added to stations->bss_list (where before only the best candidate
was), but this shouldn't effect how IWD behaves externally.
---
 src/station.c | 99 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 68 insertions(+), 31 deletions(-)

diff --git a/src/station.c b/src/station.c
index 66b296b8..33cea14a 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2181,13 +2181,14 @@ static void station_preauthenticate_cb(struct netdev *netdev,
 }
 
 static void station_transition_start(struct station *station,
-							struct scan_bss *bss)
+						struct l_queue *candidates)
 {
 	struct handshake_state *hs = netdev_get_handshake(station->netdev);
 	struct network *connected = station->connected_network;
 	enum security security = network_get_security(connected);
 	struct handshake_state *new_hs;
 	struct ie_rsn_info cur_rsne, target_rsne;
+	struct scan_bss *bss = l_queue_peek_head(candidates);
 	int ret;
 
 	l_debug("%u, target %s", netdev_get_ifindex(station->netdev),
@@ -2311,14 +2312,15 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 	struct station *station = userdata;
 	struct network *network = station->connected_network;
 	struct handshake_state *hs = netdev_get_handshake(station->netdev);
-	struct scan_bss *current_bss = station->connected_bss;
+	struct scan_bss *current_bss;
 	struct scan_bss *bss;
-	struct scan_bss *best_bss = NULL;
-	double best_bss_rank = 0.0;
+	struct scan_bss *old_bss = NULL;
+	double cur_bss_rank = 0.0;
 	static const double RANK_FT_FACTOR = 1.3;
 	uint16_t mdid;
 	enum security orig_security, security;
 	bool seen = false;
+	struct l_queue *candidates = NULL;
 
 	if (err) {
 		station_roam_failed(station);
@@ -2337,6 +2339,27 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 		ie_parse_mobility_domain_from_data(hs->mde, hs->mde[1] + 2,
 							&mdid, NULL, NULL);
 
+	/* Ranks better than the current BSS will go into the candidates list */
+	current_bss = l_queue_find(bss_list, bss_match_bssid,
+					station->connected_bss->addr);
+	if (!current_bss) {
+		cur_bss_rank = 0;
+		current_bss = station->connected_bss;
+	} else
+		cur_bss_rank = current_bss->rank;
+
+	if (hs->mde)
+		cur_bss_rank *= RANK_FT_FACTOR;
+
+	/*
+	 * TODO: Best to base this check off the actual transition request by
+	 *       looking at disassociation imminent and bss termination bits.
+	 *       For now keep existing behavior by always roaming if there are
+	 *       any candidates.
+	 */
+	if (station->ap_directed_roaming)
+		cur_bss_rank = 0;
+
 	/*
 	 * BSSes in the bss_list come already ranked with their initial
 	 * association preference rank value.  We only need to add preference
@@ -2387,51 +2410,59 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 		if (hs->mde && bss->mde_present && l_get_le16(bss->mde) == mdid)
 			rank *= RANK_FT_FACTOR;
 
-		if (rank > best_bss_rank) {
-			if (best_bss)
-				scan_bss_free(best_bss);
+		if (rank <= cur_bss_rank)
+			goto next;
+
+		if (!candidates)
+			candidates = l_queue_new();
 
-			best_bss = bss;
-			best_bss_rank = rank;
+		l_queue_insert(candidates, bss, scan_bss_rank_compare, NULL);
 
-			continue;
+		l_debug("Adding BSS "MAC" as roam candidate",
+					MAC_STR(bss->addr));
+		/*
+		 * Should only get here if the rank is better than our current
+		 * BSS. Any BSS's here need to be added to the bss_list in case
+		 * they are chosen to roam to. This also avoids the need to
+		 * free candidates entries separately.
+		 */
+		old_bss = network_bss_find_by_addr(network, bss->addr);
+		if (old_bss) {
+			network_bss_update(network, bss);
+			l_queue_remove(station->bss_list, old_bss);
+			scan_bss_free(old_bss);
+
+			l_queue_insert(station->bss_list, bss,
+					scan_bss_rank_compare, NULL);
+		} else {
+			network_bss_add(network, bss);
+			l_queue_push_tail(station->bss_list, bss);
 		}
 
+		continue;
 next:
 		scan_bss_free(bss);
 	}
 
 	l_queue_destroy(bss_list, NULL);
 
-	if (!seen)
-		goto fail_free_bss;
+	bss = l_queue_peek_head(candidates);
 
 	/* See if we have anywhere to roam to */
-	if (!best_bss || scan_bss_addr_eq(best_bss, station->connected_bss)) {
-		station_debug_event(station, "no-roam-candidates");
+	if (!seen || !bss || scan_bss_addr_eq(bss, station->connected_bss))
 		goto fail_free_bss;
-	}
 
-	bss = network_bss_find_by_addr(network, best_bss->addr);
-	if (bss) {
-		network_bss_update(network, best_bss);
-		l_queue_remove(station->bss_list, bss);
-		scan_bss_free(bss);
+	station_transition_start(station, candidates);
 
-		l_queue_insert(station->bss_list, best_bss,
-				scan_bss_rank_compare, NULL);
-	} else {
-		network_bss_add(network, best_bss);
-		l_queue_push_tail(station->bss_list, best_bss);
-	}
-
-	station_transition_start(station, best_bss);
+	l_queue_destroy(candidates, NULL);
 
 	return true;
 
 fail_free_bss:
-	if (best_bss)
-		scan_bss_free(best_bss);
+	station_debug_event(station, "no-roam-candidates");
+
+	if (candidates)
+		l_queue_destroy(candidates, NULL);
 
 	station_roam_failed(station);
 
@@ -4356,6 +4387,7 @@ static struct l_dbus_message *station_force_roam(struct l_dbus *dbus,
 	struct l_dbus_message_iter iter;
 	uint8_t *mac;
 	uint32_t mac_len;
+	struct l_queue *candidate;
 
 	if (!l_dbus_message_get_arguments(message, "ay", &iter))
 		goto invalid_args;
@@ -4385,7 +4417,12 @@ static struct l_dbus_message *station_force_roam(struct l_dbus *dbus,
 	/* The various roam routines expect this to be set from scanning */
 	station->preparing_roam = true;
 
-	station_transition_start(station, target);
+	candidate = l_queue_new();
+	l_queue_push_head(candidate, target);
+
+	station_transition_start(station, candidate);
+
+	l_queue_destroy(candidate, NULL);
 
 	return l_dbus_message_new_method_return(message);
 
-- 
2.34.3

