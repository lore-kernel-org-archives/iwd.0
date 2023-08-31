Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8308E8F7E
	for <iwd@lists.linux.dev>; Thu, 31 Aug 2023 12:39:35 +0000 (UTC)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-58fc4eaa04fso9611977b3.0
        for <iwd@lists.linux.dev>; Thu, 31 Aug 2023 05:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693485574; x=1694090374; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jCx7i4nndOIq8flXgFUXWByBQIb5UemhO0Wq0Cq9cg=;
        b=BrMMgp+r4QufubPfDJOereayGl+WVisE3wO3WxRF1a8MJXKFFpfEvT9E4ALYz0Dvqr
         wuEkiwQDyOeMhi7M1cD75ub8zaWaup2cDOkVqx9C6/GFPdO/c7oCTYXvhK4T82nDIJlb
         vPabHZkGMDdjNULPoCnxyUPWOS+ZO7CCRT7GSuSi8xxbhbLDsE0zFsIK4LBWNV3044vw
         fkDlzeApRup9+5B+eg9243j89Ra6P6TluaoOQ/QsGdQnp+8LdM6EWtezBhZPM10kA6en
         RR7OJhbtUQGhs+4McOHfTLmzQk7q/z1yh20AXaidFiAgH1izA0OK01DAGnRqY3HOtu5c
         hB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693485574; x=1694090374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jCx7i4nndOIq8flXgFUXWByBQIb5UemhO0Wq0Cq9cg=;
        b=lEAV2V5NYK7Ol8S6NySwGL6yVq0oWm76FUnDTEeGxKuTJIi8Lv/U1CdBVriMUYfnXA
         spVTC55mQh8fURTzcOLY0GgP4PJ8g1Z/I/PHCaB3YtqiOuHvg49FbX1RGe+f3HRcV6Ms
         duMNYD+NQ9tgCvVjmYZzNDWVxEcUevvyxJgUxIUvRjkLk/xjYMpRg087W8V4ysTJMhFX
         mPcS7hHADE2w13yFkon04klF0Vq5iToG8UaZySkXP8bAB+OudOTHZTXogueDIyVBtdt7
         scULHYyTit1ajQEYW5VqmFmcHLj/9dRFgUli+27Q3ufpT0Vwhvf0pE5uX2uSHwfiDNrN
         3uQw==
X-Gm-Message-State: AOJu0Yx0/sKxJpXwavVYx4s/gTA7hdQkvIKOJUum9ZrST143vh+eurUe
	BwwXr/stAOmFR6MdGmZkqVaQO0orjLQ=
X-Google-Smtp-Source: AGHT+IGV6nTXCKF5GOF0+tdopNAMZf8x5xJTpzeMu1kRcMOy64iev7zr62EIkHggnBq7N6WzS6+s/Q==
X-Received: by 2002:a81:8746:0:b0:586:a012:c703 with SMTP id x67-20020a818746000000b00586a012c703mr5449194ywf.30.1693485574194;
        Thu, 31 Aug 2023 05:39:34 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id p5-20020a0dcd05000000b0057a44e20fb8sm380308ywd.73.2023.08.31.05.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 05:39:33 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/3] station: fall back to reassociation under certain FT failures
Date: Thu, 31 Aug 2023 05:39:23 -0700
Message-Id: <20230831123924.531560-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831123924.531560-1-prestwoj@gmail.com>
References: <20230831123924.531560-1-prestwoj@gmail.com>
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
ranking is reset removing the FT factor and it is inserted back
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
 src/station.c | 82 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 60 insertions(+), 22 deletions(-)

v3:
 * Removed FT ranking division. This is expensive and was actually
   incorrect since rbss->rank never actually included this factor
   in the first place
 * Include the FT ranking factor in the rbss->rank, then if FT
   fails use the original scan_bss rank. This also keeps the ranking
   the most up-to-date in case scan results come in prior to calling
   ft_associate.
 * Use a switch for checking ft_associate return.

diff --git a/src/station.c b/src/station.c
index 2473de2a..5b827576 100644
--- a/src/station.c
+++ b/src/station.c
@@ -147,15 +147,19 @@ struct roam_bss {
 	uint8_t addr[6];
 	uint16_t rank;
 	int32_t signal_strength;
+	bool ft_failed: 1;
 };
 
-static struct roam_bss *roam_bss_from_scan_bss(const struct scan_bss *bss)
+static struct roam_bss *roam_bss_from_scan_bss(struct handshake_state *hs,
+						const struct scan_bss *bss,
+						uint16_t rank)
 {
 	struct roam_bss *rbss = l_new(struct roam_bss, 1);
 
 	memcpy(rbss->addr, bss->addr, 6);
-	rbss->rank = bss->rank;
+	rbss->rank = rank;
 	rbss->signal_strength = bss->signal_strength;
+	rbss->ft_failed = false;
 
 	return rbss;
 }
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
 
@@ -2264,34 +2272,60 @@ static void station_transition_start(struct station *station);
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
+	switch (ret) {
+	case MMPDU_STATUS_CODE_INVALID_PMKID:
+		/*
+		 * Re-insert removing FT from the ranking (scan_bss does not
+		 * take into account FT, so we can use that rank directly).
+		 * If the BSS is still the best reassociation will be used,
+		 * otherwise we'll try more FT candidates that are better ranked
+		 */
+		rbss->rank = bss->rank;
+		rbss->ft_failed = true;
+
+		l_debug("Re-inserting BSS "MAC" using reassociation, rank: %u",
+					MAC_STR(rbss->addr), rbss->rank);
+
+		l_queue_insert(station->roam_bss_list, rbss,
+				roam_bss_rank_compare, NULL);
+
+		station_debug_event(station, "ft-fallback-to-reassoc");
+
+		station_transition_start(station);
+		l_steal_ptr(rbss);
+		break;
+	case -ENOENT:
 		station_debug_event(station, "ft-roam-failed");
 try_next:
 		station_transition_start(station);
-		return true;
-	} else if (ret < 0)
-		goto assoc_failed;
+		break;
+	case 0:
+		station->connected_bss = bss;
+		station->preparing_roam = false;
+		station_enter_state(station, STATION_STATE_FT_ROAMING);
 
-	station->connected_bss = bss;
-	station->preparing_roam = false;
-	station_enter_state(station, STATION_STATE_FT_ROAMING);
+		station_debug_event(station, "ft-roam");
 
-	return true;
+		break;
+	default:
+		if (ret > 0)
+			goto try_next;
+
+		station_roam_failed(station);
+		break;
+	}
 
-assoc_failed:
-	station_roam_failed(station);
 	return true;
 }
 
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
+							rbss->ft_failed);
 		if (roaming)
 			break;
 
@@ -2581,7 +2617,7 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 		 */
 		station_update_roam_bss(station, bss);
 
-		rbss = roam_bss_from_scan_bss(bss);
+		rbss = roam_bss_from_scan_bss(hs, bss, rank);
 
 		l_queue_insert(station->roam_bss_list, rbss,
 				roam_bss_rank_compare, NULL);
@@ -4584,6 +4620,7 @@ static bool station_force_roam_scan_notify(int err, struct l_queue *bss_list,
 {
 	struct station_roam_data *data = user_data;
 	struct station *station = data->station;
+	struct handshake_state *hs = netdev_get_handshake(station->netdev);
 	struct scan_bss *target;
 	struct l_dbus_message *reply;
 
@@ -4603,7 +4640,8 @@ static bool station_force_roam_scan_notify(int err, struct l_queue *bss_list,
 	/* The various roam routines expect this to be set from scanning */
 	station->preparing_roam = true;
 	l_queue_push_tail(station->roam_bss_list,
-				roam_bss_from_scan_bss(target));
+				roam_bss_from_scan_bss(hs, target,
+				target->rank));
 
 	station_update_roam_bss(station, target);
 
-- 
2.25.1

