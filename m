Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19134C64
	for <iwd@lists.linux.dev>; Tue, 27 Sep 2022 19:47:45 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id 129so8893543pgc.5
        for <iwd@lists.linux.dev>; Tue, 27 Sep 2022 12:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=MY9n7KRpoDwJpfBeTAc2S98Qg4gHiF3n0FH5yrVXGDA=;
        b=LOCO6SgjA/qBKZIyNqMoMfC3kOvRg2i8TDP1iWbDr5/V+iRJ7Fc4pNNWNCtVFhOpvN
         xmFDSh2kOt8uhkb+yuXnA9qdVk43kaYrdylif7RidolUNhW2eyf/h4EqvDS8/8x7PjC0
         cz6fcWR3ermiA0Q7vu7WVfo7D94R7dDWGEMCeqx58Mv3447XD/1qarIuyib9/+Rqzdie
         YPVI0jAJv32yfwea0oK9tFqHXebTtakEHBiX0dszxEcoOgeL0vCNA+kcpJD0Iofhwa5l
         YSgAu1SLF2rcbyO83LFIDKGUKbMNgoMDa84karwqGJ2LLuFwWXmL8J4I7d9+wSziNnW7
         ZOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=MY9n7KRpoDwJpfBeTAc2S98Qg4gHiF3n0FH5yrVXGDA=;
        b=Dz3aIhBtM3pcxSYbE9bbx5K2FYXfL3n0LviQC6WZM0xD8nZWwxpuLRGC8t7bXCzXm5
         OwjGM6gOholjRoqLDdQU3Z8rbSWBgJMlwxokOT4mu2NeoDWGiahk5D9vIY03fvETttRV
         tVZWJq9hKyQl0+0zWiWicMnGK69kWxNlyko7/qB/TdLnrzrv+Yb47o4N3qw2Dhsko6YR
         g7Vpb7uIItIePAD7YRyNaEBsXXHeVKK6DAvHpMY6Jw4X3cuwI0UX5fww0VIKDfHEdSMO
         3AgWEHDA9boYLVLBnxT1rjcc/GeWrFwCL2lao67ptyuYzrw1qbW+ON5Krshc+hxY9+aV
         gS+w==
X-Gm-Message-State: ACrzQf2pKCZFt8Dl9PsHakKMYBxXr6K4TKlxnjkxXedTmCPpO1xZiFHn
	oQs4hkdkYV2EfGvMg9c/hbsCuMJcgZo=
X-Google-Smtp-Source: AMsMyM6o3ni4ZY+xpEM08rHogCCHDYy7Esx6aVrh8OkgrrcSMXxwaFGAxI8kmyRBmv+D/YkaJtQ48w==
X-Received: by 2002:a63:e153:0:b0:439:2fa3:74d1 with SMTP id h19-20020a63e153000000b004392fa374d1mr25711875pgk.85.1664308064804;
        Tue, 27 Sep 2022 12:47:44 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id b12-20020a1709027e0c00b00176a2d23d1asm2033145plm.56.2022.09.27.12.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:47:44 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v6 04/11] station: create list of roam candidates
Date: Tue, 27 Sep 2022 12:47:24 -0700
Message-Id: <20220927194731.269732-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220927194731.269732-1-prestwoj@gmail.com>
References: <20220927194731.269732-1-prestwoj@gmail.com>
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
be added to the sorted station->roam_bss_list (as a new 'roam_bss'
entry) as well as stations overall BSS list. If the resulting list is
empty there were no better BSS's, otherwise station can now try to roam
starting with the best candidate (head of the roam list).
---
 src/station.c | 114 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 84 insertions(+), 30 deletions(-)

diff --git a/src/station.c b/src/station.c
index 1965e035..ced7c2bd 100644
--- a/src/station.c
+++ b/src/station.c
@@ -107,6 +107,7 @@ struct station {
 
 	/* Set of frequencies to scan first when attempting a roam */
 	struct scan_freq_set *roam_freqs;
+	struct l_queue *roam_bss_list;
 
 	/* Frequencies split into subsets by priority */
 	struct scan_freq_set *scan_freqs_order[3];
@@ -129,6 +130,39 @@ struct anqp_entry {
 	uint32_t pending;
 };
 
+/*
+ * Used as entries for the roam list since holding scan_bss pointers directly
+ * from station->bss_list is not 100% safe due to the possibility of the
+ * hardware scanning and overwriting station->bss_list.
+ */
+struct roam_bss {
+	uint8_t addr[6];
+	uint16_t rank;
+	int32_t signal_strength;
+};
+
+static struct roam_bss *roam_bss_from_scan_bss(const struct scan_bss *bss)
+{
+	struct roam_bss *rbss = l_new(struct roam_bss, 1);
+
+	memcpy(rbss->addr, bss->addr, 6);
+	rbss->rank = bss->rank;
+	rbss->signal_strength = bss->signal_strength;
+
+	return rbss;
+}
+
+static int roam_bss_rank_compare(const void *a, const void *b, void *user_data)
+{
+	const struct roam_bss *new_bss = a, *bss = b;
+
+	if (bss->rank == new_bss->rank)
+		return (bss->signal_strength >
+					new_bss->signal_strength) ? 1 : -1;
+
+	return (bss->rank > new_bss->rank) ? 1 : -1;
+}
+
 struct wiphy *station_get_wiphy(struct station *station)
 {
 	return station->wiphy;
@@ -1640,6 +1674,8 @@ static void station_roam_state_clear(struct station *station)
 		scan_freq_set_free(station->roam_freqs);
 		station->roam_freqs = NULL;
 	}
+
+	l_queue_clear(station->roam_bss_list, l_free);
 }
 
 static void station_reset_connection_state(struct station *station)
@@ -1981,6 +2017,8 @@ static void station_roamed(struct station *station)
 			l_warn("Could not request neighbor report");
 	}
 
+	l_queue_clear(station->roam_bss_list, l_free);
+
 	station_ft_ds_action_start(station);
 
 	station_enter_state(station, STATION_STATE_CONNECTED);
@@ -2005,6 +2043,8 @@ static void station_roam_failed(struct station *station)
 {
 	l_debug("%u", netdev_get_ifindex(station->netdev));
 
+	l_queue_clear(station->roam_bss_list, l_free);
+
 	/*
 	 * If we attempted a reassociation or a fast transition, and ended up
 	 * here then we are now disconnected.
@@ -2186,8 +2226,7 @@ static void station_preauthenticate_cb(struct netdev *netdev,
 	station_transition_reassociate(station, bss, new_hs);
 }
 
-static void station_transition_start(struct station *station,
-							struct scan_bss *bss)
+static void station_transition_start(struct station *station)
 {
 	struct handshake_state *hs = netdev_get_handshake(station->netdev);
 	struct network *connected = station->connected_network;
@@ -2195,6 +2234,8 @@ static void station_transition_start(struct station *station,
 	struct handshake_state *new_hs;
 	struct ie_rsn_info cur_rsne, target_rsne;
 	int ret;
+	struct roam_bss *rbss = l_queue_peek_head(station->roam_bss_list);
+	struct scan_bss *bss = network_bss_find_by_addr(connected, rbss->addr);
 
 	l_debug("%u, target %s", netdev_get_ifindex(station->netdev),
 			util_address_to_string(bss->addr));
@@ -2333,12 +2374,10 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
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
@@ -2357,6 +2396,19 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
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
@@ -2370,6 +2422,7 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 	while ((bss = l_queue_pop_head(bss_list))) {
 		double rank;
 		uint32_t kbps100 = DIV_ROUND_CLOSEST(bss->data_rate, 100000);
+		struct roam_bss *rbss;
 
 		l_debug("Processing BSS '%s' with SSID: %s, freq: %u, rank: %u,"
 				" strength: %i, data_rate: %u.%u",
@@ -2378,9 +2431,8 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 				bss->frequency, bss->rank, bss->signal_strength,
 				kbps100 / 10, kbps100 % 10);
 
-		/* Skip the BSS we are connected to if doing an AP roam */
-		if (station->ap_directed_roaming && !memcmp(bss->addr,
-				station->connected_bss->addr, 6))
+		/* Skip the BSS we are connected to */
+		if (!memcmp(bss->addr, station->connected_bss->addr, 6))
 			goto next;
 
 		/* Skip result if it is not part of the ESS */
@@ -2394,8 +2446,6 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 		if (security != orig_security)
 			goto next;
 
-		seen = true;
-
 		if (network_can_connect_bss(network, bss) < 0)
 			goto next;
 
@@ -2407,15 +2457,21 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
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
+		rbss = roam_bss_from_scan_bss(bss);
+
+		l_queue_insert(station->roam_bss_list, rbss,
+				roam_bss_rank_compare, NULL);
+
+		continue;
 
 next:
 		scan_bss_free(bss);
@@ -2423,25 +2479,17 @@ next:
 
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
@@ -4156,6 +4204,8 @@ static struct station *station_create(struct netdev *netdev)
 
 	station_set_autoconnect(station, autoconnect);
 
+	station->roam_bss_list = l_queue_new();
+
 	return station;
 }
 
@@ -4245,6 +4295,8 @@ static void station_free(struct station *station)
 
 	wiphy_state_watch_remove(station->wiphy, station->wiphy_watch);
 
+	l_queue_destroy(station->roam_bss_list, l_free);
+
 	l_free(station);
 }
 
@@ -4396,10 +4448,12 @@ static bool station_force_roam_scan_notify(int err, struct l_queue *bss_list,
 
 	/* The various roam routines expect this to be set from scanning */
 	station->preparing_roam = true;
+	l_queue_push_tail(station->roam_bss_list,
+				roam_bss_from_scan_bss(target));
 
 	station_update_roam_bss(station, target);
 
-	station_transition_start(station, target);
+	station_transition_start(station);
 
 	reply = l_dbus_message_new_method_return(data->pending);
 
-- 
2.34.3

