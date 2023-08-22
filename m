Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CDD1D319
	for <iwd@lists.linux.dev>; Tue, 22 Aug 2023 15:29:40 +0000 (UTC)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-58d40c2debeso51765987b3.2
        for <iwd@lists.linux.dev>; Tue, 22 Aug 2023 08:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692718179; x=1693322979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pojhWahO9ORKZT2EB5xv1g2WbdABRaRCiXAO5Uh4gqo=;
        b=QC8n/MaaadpsfAGA1EubDgAzkjFUFWUD3qIi8Ps+F29EgFLP5RJmsZ6IzukAFxCzJj
         zobtxJxo/TugnShaA5rBIAtQwbvcsGIEC0NppL1JcgxxjPzr6inUFvwzLmW9Gc39gTvt
         MRjITaPZR8cDSZohqq1VmZrH7VJUA9Oeo++s2zL0kpQCzhfEZB1x6+1q7u79IuQAPARR
         K/tRLZKFW/8ofTeuQWs4p4T+IqG/EzLjDV8ZYyzw9ezcmHkvdyQXrIbp/vKuo7z78nwc
         SoKqKTwm2M/XjxmBVYUCsBkuNeL1/knsiTCfY1N/fkg/uNFbiG37zvC3eqlifzvLvb9I
         fgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692718179; x=1693322979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pojhWahO9ORKZT2EB5xv1g2WbdABRaRCiXAO5Uh4gqo=;
        b=GmLjzKsm3sq6QUiK2hUI560cc1ocm1tqxWI/D623+bvZDYwkwr4zlP2BgySehbVdiz
         qtNux73Frq5u34zaP+pGztK+dYQjwD6ss5cr6edaOUlG8Z3nUqcJgzfEfs/AWKt28BU1
         8MYzIdkm2VJEykGaV2gAnHD3Wk5OzyRFpW9bQIYtDwAYUNVgxhfBpoUg4t73ru52Lp7T
         2QJVNiNSbjuQ6k4vCxG3w7NCNG+wcb9iyQfEgeKSkIYCwEvZymVkn16kIpUhAuRwjVt4
         Vn/+dX8uxMr0IIIwDwkNGyoFBvPnWRoSDkojUfFywAi64xCC76yHntx4eLOXt8NQ9F6X
         Rp5Q==
X-Gm-Message-State: AOJu0YxsEnb4dDaVHL54rGd6hdsmsz0jL5ozkDUU3uyqLzeTm0eC48oo
	uPxsyI8EbPDgGvZi5AE04z62unYlXUo=
X-Google-Smtp-Source: AGHT+IEA98SFe7VLfAWPNU8mSPUfTzjmNUO+pmv9zB5TWDseSx8t2kr0XVkEqEN0yrLgX2TyPWzhsw==
X-Received: by 2002:a81:6009:0:b0:582:5527:ddc with SMTP id u9-20020a816009000000b0058255270ddcmr9653786ywb.34.1692718179090;
        Tue, 22 Aug 2023 08:29:39 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id j189-20020a816ec6000000b0058fafe95f98sm2108796ywc.114.2023.08.22.08.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 08:29:38 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] station: fall back to reassociation under certain FT failures
Date: Tue, 22 Aug 2023 08:29:30 -0700
Message-Id: <20230822152931.276136-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230822152931.276136-1-prestwoj@gmail.com>
References: <20230822152931.276136-1-prestwoj@gmail.com>
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
an attempt to still roam to the best candidate.

The motivation behind this isn't necissarily to always force a roam,
but instead to handle the case where there are no other BSS's
around. Currently IWD can get into a situation where the current
BSS link is very poor but the only cadidate is stuck in this state
where its rejecting the PMKID. When this happens it eventually leads
to a disconnect due to packet/beacon loss. Its a much better
approach to at least try reassociation.
---
 src/station.c | 129 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 82 insertions(+), 47 deletions(-)

diff --git a/src/station.c b/src/station.c
index 2473de2a..733b4196 100644
--- a/src/station.c
+++ b/src/station.c
@@ -147,15 +147,49 @@ struct roam_bss {
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
@@ -1942,37 +1976,6 @@ static void station_early_neighbor_report_cb(struct netdev *netdev, int err,
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
@@ -2169,10 +2172,14 @@ static int station_transition_reassociate(struct station *station,
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
 
@@ -2259,27 +2266,51 @@ static void station_preauthenticate_cb(struct netdev *netdev,
 	}
 }
 
-static void station_transition_start(struct station *station);
+static void station_transition_start(struct station *station, bool no_ft);
 
 static bool station_ft_work_ready(struct wiphy_radio_work_item *item)
 {
 	struct station *station = l_container_of(item, struct station, ft_work);
-	struct roam_bss *rbss = l_queue_pop_head(station->roam_bss_list);
-	struct scan_bss *bss = network_bss_find_by_addr(
-					station->connected_network, rbss->addr);
+	L_AUTO_FREE_VAR(struct roam_bss *, rbss) = l_queue_pop_head(
+							station->roam_bss_list);
+	struct scan_bss *bss;
 	int ret;
 
-	l_free(rbss);
+	/* Already failed FT, then failed reassociation, disregard this BSS */
+	if (rbss->reassoc) {
+		l_free(l_steal_ptr(rbss));
+
+		rbss = l_queue_pop_head(station->roam_bss_list);
+		if (!rbss)
+			goto assoc_failed;
+	}
 
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
+		rbss->reassoc = true;
+
+		l_queue_push_head(station->roam_bss_list, rbss);
+
+		station_debug_event(station, "ft-fallback-to-reassoc");
+
+		/* FT failed, attempt reassociation as a last resort */
+		station_transition_start(station, true);
+		l_steal_ptr(rbss);
+		return true;
+	} else if (ret == -ENOENT) {
 		station_debug_event(station, "ft-roam-failed");
 try_next:
-		station_transition_start(station);
+		station_transition_start(station, false);
 		return true;
 	} else if (ret < 0)
 		goto assoc_failed;
@@ -2288,6 +2319,8 @@ try_next:
 	station->preparing_roam = false;
 	station_enter_state(station, STATION_STATE_FT_ROAMING);
 
+	station_debug_event(station, "ft-roam");
+
 	return true;
 
 assoc_failed:
@@ -2349,7 +2382,8 @@ done:
 }
 
 static bool station_try_next_transition(struct station *station,
-					struct scan_bss *bss)
+					struct scan_bss *bss,
+					bool no_ft)
 {
 	struct handshake_state *hs = netdev_get_handshake(station->netdev);
 	struct network *connected = station->connected_network;
@@ -2364,7 +2398,7 @@ static bool station_try_next_transition(struct station *station,
 	station->ap_directed_roaming = false;
 
 	/* Can we use Fast Transition? */
-	if (station_can_fast_transition(hs, bss))
+	if (station_can_fast_transition(hs, bss) && !no_ft)
 		return station_fast_transition(station, bss);
 
 	/* Non-FT transition */
@@ -2412,7 +2446,7 @@ static bool station_try_next_transition(struct station *station,
 	return true;
 }
 
-static void station_transition_start(struct station *station)
+static void station_transition_start(struct station *station, bool no_ft)
 {
 	struct roam_bss *rbss;
 	bool roaming = false;
@@ -2425,7 +2459,7 @@ static void station_transition_start(struct station *station)
 		struct scan_bss *bss = network_bss_find_by_addr(
 					station->connected_network, rbss->addr);
 
-		roaming = station_try_next_transition(station, bss);
+		roaming = station_try_next_transition(station, bss, no_ft);
 		if (roaming)
 			break;
 
@@ -2581,7 +2615,7 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 		 */
 		station_update_roam_bss(station, bss);
 
-		rbss = roam_bss_from_scan_bss(bss);
+		rbss = roam_bss_from_scan_bss(hs, bss);
 
 		l_queue_insert(station->roam_bss_list, rbss,
 				roam_bss_rank_compare, NULL);
@@ -2600,7 +2634,7 @@ next:
 		goto fail;
 	}
 
-	station_transition_start(station);
+	station_transition_start(station, false);
 
 	return true;
 
@@ -4584,6 +4618,7 @@ static bool station_force_roam_scan_notify(int err, struct l_queue *bss_list,
 {
 	struct station_roam_data *data = user_data;
 	struct station *station = data->station;
+	struct handshake_state *hs = netdev_get_handshake(station->netdev);
 	struct scan_bss *target;
 	struct l_dbus_message *reply;
 
@@ -4603,11 +4638,11 @@ static bool station_force_roam_scan_notify(int err, struct l_queue *bss_list,
 	/* The various roam routines expect this to be set from scanning */
 	station->preparing_roam = true;
 	l_queue_push_tail(station->roam_bss_list,
-				roam_bss_from_scan_bss(target));
+				roam_bss_from_scan_bss(hs, target));
 
 	station_update_roam_bss(station, target);
 
-	station_transition_start(station);
+	station_transition_start(station, false);
 
 	reply = l_dbus_message_new_method_return(data->pending);
 
-- 
2.25.1

