Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0137FAD5B
	for <iwd@lists.linux.dev>; Wed, 14 Dec 2022 21:27:02 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so595299pje.5
        for <iwd@lists.linux.dev>; Wed, 14 Dec 2022 13:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgK5nYyp2bPTH0Kk5m5Es8DVLMxBYCg+oipV9ZKgb0E=;
        b=jBSWGVWJlhtfQiiYiPJdpg7i8zL5CGeZ9J8rcU9ikAAREkkt4DEwFdQtc8pM+HCV2c
         XLfI3Ik8wfWngb13rgr1MXGP30Z5tDhWgBzu+Ed6EcTyCbEuH0regbMXP82EgewcRSqh
         M+LYEZ3DgA3dBIYW1/qfN13at2GIdrivytrftL4Uwke5jQpAiedmG5iKuBMnAB6zOU7z
         ktXrLmNJojlRi4JjHKn+XCyCQNARxA02asaPC5hIC7/Yu32ZA++5mJIUU3oRtvHcb1tT
         LjQalr1B33B2i4GYb9AFmFblo1heezpiCSfQ0Y/JzUoU5PxGlQ6oG9ntA8rHzuGXu+ij
         JZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgK5nYyp2bPTH0Kk5m5Es8DVLMxBYCg+oipV9ZKgb0E=;
        b=M9NCKDkUyOx4veqo9FtaqMr+SnBHKrbHyurW1cPJ6X1aKMjKXfvf5PaHC1NkynfFgd
         YO4+xlcPz1LCfTMls97IdV2azlR93Sy2Mcc1B+E6mAGC2CgN3YfcGN5D9Tsjn39l8T8l
         Zi2saRjJNX72ZjCNR4FqvXpQkUZ3edNU7WIJrNWwZz1CvZd+Jla2NiXYUdvQcnVaWeaV
         63Gq0Anj/pCuhtBMh8syg9A1MUoeXiip72BvlfAihQW4Kiu21RiTuWvroWzTneQQrFxf
         04CgEEBDDM/HGQwXdbydb48m2Vc0EXEiAcVsxUwuMylI1bLZyVDAKNUZeOHEpFf6qfxW
         gC9A==
X-Gm-Message-State: ANoB5pkIkxf5QYPWJYF1YnznBrqInUc96a2s8X5VMHlxKJ+VnscYsWfq
	lfTCCAXPWfohAzY5qXkGZmZBuE8F5II=
X-Google-Smtp-Source: AA0mqf6+GsUfvS3dtJjuGW5NHi/QqayE/koxCxw6Lh/6nyuom4eJzvcnpV1/BVLoAz5ESuujNRPZ4g==
X-Received: by 2002:a05:6a20:bc96:b0:af:8298:4399 with SMTP id fx22-20020a056a20bc9600b000af82984399mr1494152pzb.31.1671053222221;
        Wed, 14 Dec 2022 13:27:02 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id a8-20020a656408000000b0047063eb4098sm287653pgv.37.2022.12.14.13.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 13:27:01 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] station: remove early FT-over-DS action
Date: Wed, 14 Dec 2022 13:26:57 -0800
Message-Id: <20221214212658.1578576-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221214212658.1578576-1-prestwoj@gmail.com>
References: <20221214212658.1578576-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IWD was optimizing FT-over-DS by authenticating to multiple BSS's
at the time of connecting which then made future roams slightly
faster since they could jump right into association. So far this
hasn't posed a problem but it was reported that some AP's actually
enforce a reassociation timeout (included in 4-way handshake).

Hostapd itself does no such enforcement but anything external to
hostapd could monitor FT events and clear the cache if any exceeded
this timeout.

For now remove the early action frames and treat FT-over-DS the
same as FT-over-Air. In the future we could parse the reassociation
timeout, batch out FT-Action frames and track responses but for the
time being this just fix the issue at a small performance cost.
---
 src/station.c | 79 ++++++---------------------------------------------
 1 file changed, 8 insertions(+), 71 deletions(-)

diff --git a/src/station.c b/src/station.c
index a467b4e9..9a646934 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1973,47 +1973,6 @@ static bool station_can_fast_transition(struct handshake_state *hs,
 	return true;
 }
 
-static void station_ft_ds_action_start(struct station *station)
-{
-	struct handshake_state *hs = netdev_get_handshake(station->netdev);
-	uint16_t mdid;
-	const struct l_queue_entry *entry;
-	struct scan_bss *bss;
-	struct ie_rsn_info rsn_info;
-
-	if (!station_can_fast_transition(hs, station->connected_bss) ||
-						!(hs->mde[4] & 1))
-		return;
-
-	if (ie_parse_mobility_domain_from_data(hs->mde, hs->mde[1] + 2,
-						&mdid, NULL, NULL) < 0)
-		return;
-
-	for (entry = network_bss_list_get_entries(station->connected_network);
-						entry; entry = entry->next) {
-		bss = entry->data;
-
-		if (bss == station->connected_bss)
-			continue;
-
-		if (mdid != l_get_le16(bss->mde))
-			continue;
-
-		if (scan_bss_get_rsn_info(bss, &rsn_info) < 0)
-			continue;
-
-		if (!IE_AKM_IS_FT(rsn_info.akm_suites))
-			continue;
-
-		/*
-		 * Fire and forget. Netdev will maintain a cache of responses
-		 * and when the time comes these can be referenced for a roam
-		 */
-		ft_action(netdev_get_ifindex(station->netdev),
-				station->connected_bss->frequency, bss);
-	}
-}
-
 static void station_roamed(struct station *station)
 {
 	station->roam_scan_full = false;
@@ -2042,8 +2001,6 @@ static void station_roamed(struct station *station)
 
 	l_queue_clear(station->roam_bss_list, l_free);
 
-	station_ft_ds_action_start(station);
-
 	station_enter_state(station, STATION_STATE_CONNECTED);
 }
 
@@ -2297,7 +2254,7 @@ static bool station_ft_work_ready(struct wiphy_radio_work_item *item)
 
 	ret = ft_associate(netdev_get_ifindex(station->netdev), bss->addr);
 	if (ret == -ENOENT) {
-		station_debug_event(station, "ft-over-air-roam-failed");
+		station_debug_event(station, "ft-roam-failed");
 try_next:
 		station_transition_start(station);
 		return true;
@@ -2327,7 +2284,6 @@ static bool station_fast_transition(struct station *station,
 	const struct network_info *info = network_get_info(connected);
 	const struct iovec *vendor_ies;
 	size_t iov_elems = 0;
-	int ret;
 
 	/* Rebuild handshake RSN for target AP */
 	if (station_build_handshake_rsn(hs, station->wiphy,
@@ -2338,34 +2294,17 @@ static bool station_fast_transition(struct station *station,
 	vendor_ies = network_info_get_extra_ies(info, bss, &iov_elems);
 	handshake_state_set_vendor_ies(hs, vendor_ies, iov_elems);
 
-	if ((hs->mde[4] & 1)) {
-		ret = ft_associate(netdev_get_ifindex(station->netdev),
-					bss->addr);
-		/* No action responses from this BSS, try over air */
-		if (ret == -ENOENT) {
-			station_debug_event(station, "try-ft-over-air");
-			goto try_over_air;
-		} else if (ret < 0)
-			return false;
-
-		station->connected_bss = bss;
-		station->preparing_roam = false;
-		station_enter_state(station, STATION_STATE_FT_ROAMING);
-
-		return true;
-	} else {
-try_over_air:
-		/*
-		 * Send FT-Authenticate and insert a work item which will be
-		 * gated until authentication completes
-		 */
+	/* Both ft_action/ft_authenticate will gate the associate work item */
+	if ((hs->mde[4] & 1))
+		ft_action(netdev_get_ifindex(station->netdev),
+				station->connected_bss->frequency, bss);
+	else
 		ft_authenticate(netdev_get_ifindex(station->netdev), bss);
 
-		wiphy_radio_work_insert(station->wiphy, &station->ft_work,
+	wiphy_radio_work_insert(station->wiphy, &station->ft_work,
 				WIPHY_WORK_PRIORITY_CONNECT, &ft_work_ops);
 
-		return true;
-	}
+	return true;
 }
 
 static bool station_try_next_transition(struct station *station,
@@ -3117,8 +3056,6 @@ static void station_connect_ok(struct station *station)
 			l_warn("Could not request neighbor report");
 	}
 
-	station_ft_ds_action_start(station);
-
 	network_connected(station->connected_network);
 
 	if (station->netconfig) {
-- 
2.34.3

