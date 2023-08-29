Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D36156D8
	for <iwd@lists.linux.dev>; Tue, 29 Aug 2023 14:51:31 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1bdbf10333bso35203695ad.1
        for <iwd@lists.linux.dev>; Tue, 29 Aug 2023 07:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693320691; x=1693925491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNiwhK9UuzONn/Y6YFYOopQok2XyPbVo/sEXkL9yRpg=;
        b=XjcGodL7fhruw+zztY0xekuriqO6Erki4/dZQipjZjhRY+7sRlEcbrqDjLqEpPClBD
         fqml9fMI0kjzwPSArFgviAfNeK4NCoacoWP2hROnvNV1oDH81bSnP3Pj+dT6rJGEz9+7
         L/EeQBtrV6skctfskRniu3B5A75FmvbyYCEPe152WtyFb5mF2tbSufK+r+v3EH0ZeFuB
         Af+YXKLeLnLAycLxolNJZmz1ALpVZcCjT+skdsRyfBAfUW7s592H++UDqejrb7TM7B++
         BGZ2+W+nEjMc5MLJJBHSu44RmXXcvuct0faCGNp0NjQNCyWF1dKVj/AtS0cueP83DYwU
         P+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693320691; x=1693925491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNiwhK9UuzONn/Y6YFYOopQok2XyPbVo/sEXkL9yRpg=;
        b=DsAbH1+qzW/ewJXsmYF70qTfOAbpmdpnuLmm911EtdWraH4323ly7ossj4kTPc0urq
         Geq+OaD5r+9EFepWKqXFGi9gvzozRTm4w39x+IoeLcEftipirJdLT8FvHgIby6WfEd6p
         LalcT+Xzgi68cok83NM0ngzZkFRLAlIT8VwNEr/MSugl93k43rlXDooz6az1D7WsVGOH
         ipzotNcjrLmfFH6t3U/YQpMnb5tb4oaBpwiefH+p9eXB3MW1eXpWAMJy1cRwsdd7krtu
         KPtGEw5Z6qAK9O5yoj7Q1XSMUrkNe3AwZOOezH0kJwDw/9JHIoC9Au9wyIVdUL3v5e5c
         JraQ==
X-Gm-Message-State: AOJu0Yyh3/KsERWP9ztOeImBfUcpbsCYkdDuVUX63Z5UZBKZCU5CbCr6
	Hbz/h/kL9GSgGyQvPqSYYdFGgFDO+Hc=
X-Google-Smtp-Source: AGHT+IHBB/a/yuoJcst+GTnYq/2UsLSbGz4PxE/Gmq2g3BWXp4DsiGzGHcFvQK311MejqMiFX/uZgQ==
X-Received: by 2002:a17:902:b784:b0:1bf:8779:e045 with SMTP id e4-20020a170902b78400b001bf8779e045mr23847706pls.50.1693320691031;
        Tue, 29 Aug 2023 07:51:31 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902654a00b001bc445e249asm9661283pln.124.2023.08.29.07.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 07:51:30 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/3] station: fall back to reassociation under certain FT failures
Date: Tue, 29 Aug 2023 07:51:15 -0700
Message-Id: <20230829145116.279949-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230829145116.279949-1-prestwoj@gmail.com>
References: <20230829145116.279949-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The auth/action status is now tracked in ft.c. If an AP rejects the
FT attempt with "Invalid PMKID" we can now assume this AP is either
mis-configured for FT or is lagging behind getting the proper keys
from neighboring APs (e.g. was just rebooted).

If we see this condition IWD can now fall back to reassociation in
an attempt to still roam to the best candidate. The fallback decision
is still rank based: if a BSS fails FT it is marked as such, its
ranking is re-computed removing the FT factor and it is inserted back
into the queue.

The motivation behind this isn't necessarily to always force a roam,
but instead to handle two cases where IWD can either make a bad roam
decision or get 'stuck' and never roam:

  1. If there is one good roam candidate and other bad ones. For
     example say BSS A is experiencing this FT key pull issue:
         Current BSS: -85dbm
         BSS A:       -55dbm
         BSS B:       -80dbm
     The current logic would fail A, and roam to B. In this case
     reassociation would have likely succeeded so it makes more sense
     to reassociate to A as a fallback.

  2. If there is only one candidate, but its failing FT. IWD will
     never try anything other than FT and repeatedly fail.

Both of the above have been seen on real network deployments and
result in either poor performance (1) or eventually lead to a full
disconnect due to never roaming (2).
---
 src/station.c | 124 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 80 insertions(+), 44 deletions(-)

v2:
 * Rather than always falling back to reassociate recompute the
   rank and insert into the queue. This allows IWD to try similarly
   ranked BSS's with FT before falling back to reassociation.

diff --git a/src/station.c b/src/station.c
index 2473de2a..59191baa 100644
--- a/src/station.c
+++ b/src/station.c
@@ -73,6 +73,7 @@ static bool supports_arp_evict_nocarrier;
 static bool supports_ndisc_evict_nocarrier;
 static struct watchlist event_watches;
 static uint32_t known_networks_watch;
+static const double RANK_FT_FACTOR = 1.3;
 
 struct station {
 	enum station_state state;
@@ -147,15 +148,49 @@ struct roam_bss {
 	uint8_t addr[6];
 	uint16_t rank;
 	int32_t signal_strength;
+	bool reassoc: 1;
 };
 
-static struct roam_bss *roam_bss_from_scan_bss(const struct scan_bss *bss)
+static bool station_can_fast_transition(struct handshake_state *hs,
+					const struct scan_bss *bss)
+{
+	uint16_t mdid;
+
+	if (!hs->mde)
+		return false;
+
+	if (ie_parse_mobility_domain_from_data(hs->mde, hs->mde[1] + 2,
+						&mdid, NULL, NULL) < 0)
+		return false;
+
+	if (!(bss->mde_present && l_get_le16(bss->mde) == mdid))
+		return false;
+
+	if (hs->supplicant_ie != NULL) {
+		struct ie_rsn_info rsn_info;
+
+		if (!IE_AKM_IS_FT(hs->akm_suite))
+			return false;
+
+		if (scan_bss_get_rsn_info(bss, &rsn_info) < 0)
+			return false;
+
+		if (!IE_AKM_IS_FT(rsn_info.akm_suites))
+			return false;
+	}
+
+	return true;
+}
+
+static struct roam_bss *roam_bss_from_scan_bss(struct handshake_state *hs,
+						const struct scan_bss *bss)
 {
 	struct roam_bss *rbss = l_new(struct roam_bss, 1);
 
 	memcpy(rbss->addr, bss->addr, 6);
 	rbss->rank = bss->rank;
 	rbss->signal_strength = bss->signal_strength;
+	rbss->reassoc = !station_can_fast_transition(hs, bss);
 
 	return rbss;
 }
@@ -1942,37 +1977,6 @@ static void station_early_neighbor_report_cb(struct netdev *netdev, int err,
 				&station->roam_freqs);
 }
 
-static bool station_can_fast_transition(struct handshake_state *hs,
-					struct scan_bss *bss)
-{
-	uint16_t mdid;
-
-	if (!hs->mde)
-		return false;
-
-	if (ie_parse_mobility_domain_from_data(hs->mde, hs->mde[1] + 2,
-						&mdid, NULL, NULL) < 0)
-		return false;
-
-	if (!(bss->mde_present && l_get_le16(bss->mde) == mdid))
-		return false;
-
-	if (hs->supplicant_ie != NULL) {
-		struct ie_rsn_info rsn_info;
-
-		if (!IE_AKM_IS_FT(hs->akm_suite))
-			return false;
-
-		if (scan_bss_get_rsn_info(bss, &rsn_info) < 0)
-			return false;
-
-		if (!IE_AKM_IS_FT(rsn_info.akm_suites))
-			return false;
-	}
-
-	return true;
-}
-
 static void station_disconnect_on_error_cb(struct netdev *netdev, bool success,
 					void *user_data)
 {
@@ -2169,10 +2173,14 @@ static int station_transition_reassociate(struct station *station,
 	if (ret < 0)
 		return ret;
 
+	l_debug("");
+
 	station->connected_bss = bss;
 	station->preparing_roam = false;
 	station_enter_state(station, STATION_STATE_ROAMING);
 
+	station_debug_event(station, "reassoc-roam");
+
 	return 0;
 }
 
@@ -2264,19 +2272,43 @@ static void station_transition_start(struct station *station);
 static bool station_ft_work_ready(struct wiphy_radio_work_item *item)
 {
 	struct station *station = l_container_of(item, struct station, ft_work);
-	struct roam_bss *rbss = l_queue_pop_head(station->roam_bss_list);
-	struct scan_bss *bss = network_bss_find_by_addr(
-					station->connected_network, rbss->addr);
+	_auto_(l_free) struct roam_bss *rbss = l_queue_pop_head(
+							station->roam_bss_list);
+	struct scan_bss *bss;
 	int ret;
 
-	l_free(rbss);
-
 	/* Very unlikely, but the BSS could have gone away */
+	bss = network_bss_find_by_addr(station->connected_network, rbss->addr);
 	if (!bss)
 		goto try_next;
 
 	ret = ft_associate(netdev_get_ifindex(station->netdev), bss->addr);
-	if (ret == -ENOENT) {
+	if (ret > 0) {
+		if (ret != MMPDU_STATUS_CODE_INVALID_PMKID) {
+			station_debug_event(station, "ft-roam-failed");
+			goto try_next;
+		}
+
+		/*
+		 * Re-insert removing FT from the ranking. If the BSS is still
+		 * the best reassociation will be used, otherwise we'll try
+		 * more FT candidates that are better ranked
+		 */
+		rbss->rank /= RANK_FT_FACTOR;
+		rbss->reassoc = true;
+
+		l_debug("Re-inserting BSS "MAC" forcing reassociation, rank: %u",
+					MAC_STR(rbss->addr), rbss->rank);
+
+		l_queue_insert(station->roam_bss_list, rbss,
+				roam_bss_rank_compare, NULL);
+
+		station_debug_event(station, "ft-fallback-to-reassoc");
+
+		station_transition_start(station);
+		l_steal_ptr(rbss);
+		return true;
+	} else if (ret == -ENOENT) {
 		station_debug_event(station, "ft-roam-failed");
 try_next:
 		station_transition_start(station);
@@ -2288,6 +2320,8 @@ try_next:
 	station->preparing_roam = false;
 	station_enter_state(station, STATION_STATE_FT_ROAMING);
 
+	station_debug_event(station, "ft-roam");
+
 	return true;
 
 assoc_failed:
@@ -2349,7 +2383,8 @@ done:
 }
 
 static bool station_try_next_transition(struct station *station,
-					struct scan_bss *bss)
+					struct scan_bss *bss,
+					bool no_ft)
 {
 	struct handshake_state *hs = netdev_get_handshake(station->netdev);
 	struct network *connected = station->connected_network;
@@ -2364,7 +2399,7 @@ static bool station_try_next_transition(struct station *station,
 	station->ap_directed_roaming = false;
 
 	/* Can we use Fast Transition? */
-	if (station_can_fast_transition(hs, bss))
+	if (station_can_fast_transition(hs, bss) && !no_ft)
 		return station_fast_transition(station, bss);
 
 	/* Non-FT transition */
@@ -2425,7 +2460,8 @@ static void station_transition_start(struct station *station)
 		struct scan_bss *bss = network_bss_find_by_addr(
 					station->connected_network, rbss->addr);
 
-		roaming = station_try_next_transition(station, bss);
+		roaming = station_try_next_transition(station, bss,
+							rbss->reassoc);
 		if (roaming)
 			break;
 
@@ -2490,7 +2526,6 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 	struct scan_bss *current_bss = station->connected_bss;
 	struct scan_bss *bss;
 	double cur_bss_rank = 0.0;
-	static const double RANK_FT_FACTOR = 1.3;
 	uint16_t mdid;
 	enum security orig_security, security;
 
@@ -2581,7 +2616,7 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 		 */
 		station_update_roam_bss(station, bss);
 
-		rbss = roam_bss_from_scan_bss(bss);
+		rbss = roam_bss_from_scan_bss(hs, bss);
 
 		l_queue_insert(station->roam_bss_list, rbss,
 				roam_bss_rank_compare, NULL);
@@ -4584,6 +4619,7 @@ static bool station_force_roam_scan_notify(int err, struct l_queue *bss_list,
 {
 	struct station_roam_data *data = user_data;
 	struct station *station = data->station;
+	struct handshake_state *hs = netdev_get_handshake(station->netdev);
 	struct scan_bss *target;
 	struct l_dbus_message *reply;
 
@@ -4603,7 +4639,7 @@ static bool station_force_roam_scan_notify(int err, struct l_queue *bss_list,
 	/* The various roam routines expect this to be set from scanning */
 	station->preparing_roam = true;
 	l_queue_push_tail(station->roam_bss_list,
-				roam_bss_from_scan_bss(target));
+				roam_bss_from_scan_bss(hs, target));
 
 	station_update_roam_bss(station, target);
 
-- 
2.25.1

