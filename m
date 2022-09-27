Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFA54A28
	for <iwd@lists.linux.dev>; Tue, 27 Sep 2022 19:47:48 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id i6so6413504pfb.2
        for <iwd@lists.linux.dev>; Tue, 27 Sep 2022 12:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=YaP2w15njeUvKXjshDQfAtOKiBNxOsAlUGfFkT/1Szo=;
        b=HFwfwocYicWwMgSQwz6svAmGX9PSZQ3T54fWJxT99fqF06wFhQNdq21ZHzG6L0BN9Q
         4dYA9J+Am9Yp64niODITT7hGQuOPpKGOuK3lfop1tXl5iWLwhZ1rptp9jjqiyCjI9UZw
         Ua6bgpwFd02mSMLqRQVFY6VBweZhN8/u0s2Ef6xkO/9f62d+wWhpoGlTkzGgZYL9s1Fw
         vlMTWMPq8OwsIDWaz5XGIyvhBBWBDruiKJUrtYAnibiuqX/yWKSaaKKizk+wbPLkTgDQ
         vRqflBqPx1ekf6A4fllurDsxqqVbC8a8OV/R/FVhuyIIMKxDVFwTTDQRn97Yj8j4KHjh
         m7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YaP2w15njeUvKXjshDQfAtOKiBNxOsAlUGfFkT/1Szo=;
        b=ZyEcTA3YDsbjOgwT27wT4UZSedH3bgubTADnQyi09YrLd9rMOp3vNT/3NskhVkGS7Z
         bBboELBrFKoJksyM8m/hty+cmIpuEJUWG2020BWJtqqx8Uyefr9d5DwwwlUcoWdvhB0L
         Ipp1olZargQkLXfpbfeHtLdsltT5LoT7Xf3i6kacHk41Gmofb+uXSryATPxoWZ2hYzhI
         CnsPB1DITWPa4TNWHfYYDJlWhQeVL5rKmltBIGxbiBeklc8Xv/7zEKcm56LgsBPel4nZ
         Xj57JE874b2JMkgwkISlGXivRrhP/zmV+JYCPTlo2smpdMm0uetaRvg0EwLrAQRWATlZ
         alMQ==
X-Gm-Message-State: ACrzQf2fgRQLOb+5+F+/6XG2m786G/qQLW3hxq9Q4GeZAltmy6KB5UKd
	POEJUkgcMr6luzeSdqjIR8/661Q16T8=
X-Google-Smtp-Source: AMsMyM6RL+fbxGJWNKHxzapD3PYjbuNVb572sD926jsFPgldxU1u5t6aOIs48sltTLyrO5+/ISXUHg==
X-Received: by 2002:a05:6a00:2402:b0:52c:81cf:8df2 with SMTP id z2-20020a056a00240200b0052c81cf8df2mr30352864pfh.40.1664308067855;
        Tue, 27 Sep 2022 12:47:47 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id b12-20020a1709027e0c00b00176a2d23d1asm2033145plm.56.2022.09.27.12.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:47:47 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v6 08/11] station: try multiple roam candidates
Date: Tue, 27 Sep 2022 12:47:28 -0700
Message-Id: <20220927194731.269732-8-prestwoj@gmail.com>
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

This converts station to using ft_action/ft_authenticate and
ft_associate and dropping the use of the netdev-only/auth-proto
logic.

Doing this allows for more flexibility if FT fails by letting
IWD try another roam candidate instead of disconnecting.
---
 src/station.c | 227 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 144 insertions(+), 83 deletions(-)

diff --git a/src/station.c b/src/station.c
index a4681ce0..4e07ef19 100644
--- a/src/station.c
+++ b/src/station.c
@@ -59,6 +59,7 @@
 #include "src/frame-xchg.h"
 #include "src/sysfs.h"
 #include "src/band.h"
+#include "src/ft.h"
 
 static struct l_queue *station_list;
 static uint32_t netdev_watch;
@@ -115,6 +116,8 @@ struct station {
 
 	uint32_t wiphy_watch;
 
+	struct wiphy_radio_work_item ft_work;
+
 	bool preparing_roam : 1;
 	bool roam_scan_full : 1;
 	bool signal_low : 1;
@@ -1676,6 +1679,8 @@ static void station_roam_state_clear(struct station *station)
 	}
 
 	l_queue_clear(station->roam_bss_list, l_free);
+
+	ft_clear_authentications(netdev_get_ifindex(station->netdev));
 }
 
 static void station_reset_connection_state(struct station *station)
@@ -1987,7 +1992,8 @@ static void station_ft_ds_action_start(struct station *station)
 		 * Fire and forget. Netdev will maintain a cache of responses
 		 * and when the time comes these can be referenced for a roam
 		 */
-		netdev_fast_transition_over_ds_action(station->netdev, bss);
+		ft_action(netdev_get_ifindex(station->netdev),
+				station->connected_bss->frequency, bss);
 	}
 }
 
@@ -2116,42 +2122,26 @@ static void station_reassociate_cb(struct netdev *netdev,
 		station_roam_failed(station);
 }
 
-static void station_fast_transition_cb(struct netdev *netdev,
-					enum netdev_result result,
-					void *event_data,
-					void *user_data)
-{
-	struct station *station = user_data;
-
-	l_debug("%u, result: %d", netdev_get_ifindex(station->netdev), result);
-
-	if (station->state != STATION_STATE_ROAMING)
-		return;
-
-	if (result == NETDEV_RESULT_OK)
-		station_roamed(station);
-	else
-		station_roam_failed(station);
-}
-
 static void station_netdev_event(struct netdev *netdev, enum netdev_event event,
 					void *event_data, void *user_data);
 
-static void station_transition_reassociate(struct station *station,
+static int station_transition_reassociate(struct station *station,
 						struct scan_bss *bss,
 						struct handshake_state *new_hs)
 {
-	if (netdev_reassociate(station->netdev, bss, station->connected_bss,
+	int ret;
+
+	ret = netdev_reassociate(station->netdev, bss, station->connected_bss,
 				new_hs, station_netdev_event,
-				station_reassociate_cb, station) < 0) {
-		handshake_state_free(new_hs);
-		station_roam_failed(station);
-		return;
-	}
+				station_reassociate_cb, station);
+	if (ret < 0)
+		return ret;
 
 	station->connected_bss = bss;
 	station->preparing_roam = false;
 	station_enter_state(station, STATION_STATE_ROAMING);
+
+	return 0;
 }
 
 static bool bss_match_bssid(const void *a, const void *b)
@@ -2223,19 +2213,107 @@ static void station_preauthenticate_cb(struct netdev *netdev,
 		handshake_state_set_supplicant_ie(new_hs, rsne_buf);
 	}
 
-	station_transition_reassociate(station, bss, new_hs);
+	if (station_transition_reassociate(station, bss, new_hs) < 0) {
+		handshake_state_free(new_hs);
+		station_roam_failed(station);
+	}
+}
+
+static void station_transition_start(struct station *station);
+
+static bool station_ft_work_ready(struct wiphy_radio_work_item *item)
+{
+	struct station *station = l_container_of(item, struct station, ft_work);
+	struct roam_bss *rbss = l_queue_pop_head(station->roam_bss_list);
+	struct scan_bss *bss = network_bss_find_by_addr(
+					station->connected_network, rbss->addr);
+	int ret;
+
+	l_free(rbss);
+
+	/* Very unlikely, but the BSS could have gone away */
+	if (!bss)
+		goto try_next;
+
+	ret = ft_associate(netdev_get_ifindex(station->netdev), bss->addr);
+	if (ret == -ENOENT) {
+try_next:
+		station_transition_start(station);
+		return true;
+	} else if (ret < 0)
+		goto assoc_failed;
+
+	station->connected_bss = bss;
+	station->preparing_roam = false;
+	station_enter_state(station, STATION_STATE_ROAMING);
+
+	return true;
+
+assoc_failed:
+	station_roam_failed(station);
+	return true;
 }
 
-static void station_transition_start(struct station *station)
+static const struct wiphy_radio_work_item_ops ft_work_ops = {
+	.do_work = station_ft_work_ready,
+};
+
+static bool station_fast_transition(struct station *station,
+					struct scan_bss *bss)
+{
+	struct handshake_state *hs = netdev_get_handshake(station->netdev);
+	struct network *connected = station->connected_network;
+	const struct network_info *info = network_get_info(connected);
+	const struct iovec *vendor_ies;
+	size_t iov_elems = 0;
+	int ret;
+
+	/* Rebuild handshake RSN for target AP */
+	if (station_build_handshake_rsn(hs, station->wiphy,
+				station->connected_network, bss) < 0)
+		return false;
+
+	/* Reset the vendor_ies in case they're different */
+	vendor_ies = network_info_get_extra_ies(info, bss, &iov_elems);
+	handshake_state_set_vendor_ies(hs, vendor_ies, iov_elems);
+
+	if ((hs->mde[4] & 1)) {
+		ret = ft_associate(netdev_get_ifindex(station->netdev),
+					bss->addr);
+		/* No action responses from this BSS, try over air */
+		if (ret == -ENOENT)
+			goto try_over_air;
+		else if (ret < 0)
+			return false;
+
+		station->connected_bss = bss;
+		station->preparing_roam = false;
+		station_enter_state(station, STATION_STATE_ROAMING);
+
+		return true;
+	} else {
+try_over_air:
+		/*
+		 * Send FT-Authenticate and insert a work item which will be
+		 * gated until authentication completes
+		 */
+		ft_authenticate(netdev_get_ifindex(station->netdev), bss);
+
+		wiphy_radio_work_insert(station->wiphy, &station->ft_work,
+				WIPHY_WORK_PRIORITY_CONNECT, &ft_work_ops);
+
+		return true;
+	}
+}
+
+static bool station_try_next_transition(struct station *station,
+					struct scan_bss *bss)
 {
 	struct handshake_state *hs = netdev_get_handshake(station->netdev);
 	struct network *connected = station->connected_network;
 	enum security security = network_get_security(connected);
 	struct handshake_state *new_hs;
 	struct ie_rsn_info cur_rsne, target_rsne;
-	int ret;
-	struct roam_bss *rbss = l_queue_peek_head(station->roam_bss_list);
-	struct scan_bss *bss = network_bss_find_by_addr(connected, rbss->addr);
 
 	l_debug("%u, target %s", netdev_get_ifindex(station->netdev),
 			util_address_to_string(bss->addr));
@@ -2244,54 +2322,8 @@ static void station_transition_start(struct station *station)
 	station->ap_directed_roaming = false;
 
 	/* Can we use Fast Transition? */
-	if (station_can_fast_transition(hs, bss)) {
-		const struct network_info *info = network_get_info(connected);
-		const struct iovec *vendor_ies;
-		size_t iov_elems = 0;
-
-		/* Rebuild handshake RSN for target AP */
-		if (station_build_handshake_rsn(hs, station->wiphy,
-				station->connected_network, bss) < 0) {
-			l_error("rebuilding handshake rsne failed");
-			station_roam_failed(station);
-			return;
-		}
-
-		/* Reset the vendor_ies in case they're different */
-		vendor_ies = network_info_get_extra_ies(info, bss, &iov_elems);
-		handshake_state_set_vendor_ies(hs, vendor_ies, iov_elems);
-
-		if ((hs->mde[4] & 1)) {
-			ret = netdev_fast_transition_over_ds(station->netdev,
-					bss, station->connected_bss,
-					station_fast_transition_cb);
-			/* No action responses from this BSS, try over air */
-			if (ret == -ENOENT)
-				goto try_over_air;
-			else if (ret < 0) {
-				/*
-				 * If we are here FT-over-air will not work
-				 * either (identical checks) so try again later.
-				 */
-				station_roam_retry(station);
-				return;
-			}
-		} else {
-try_over_air:
-			if (netdev_fast_transition(station->netdev, bss,
-					station->connected_bss,
-					station_fast_transition_cb) < 0) {
-				station_roam_failed(station);
-				return;
-			}
-		}
-
-		station->connected_bss = bss;
-		station->preparing_roam = false;
-		station_enter_state(station, STATION_STATE_ROAMING);
-
-		return;
-	}
+	if (station_can_fast_transition(hs, bss))
+		return station_fast_transition(station, bss);
 
 	/* Non-FT transition */
 
@@ -2321,17 +2353,46 @@ try_over_air:
 		if (netdev_preauthenticate(station->netdev, bss,
 						station_preauthenticate_cb,
 						station) >= 0)
-			return;
+			return true;
 	}
 
 	new_hs = station_handshake_setup(station, connected, bss);
 	if (!new_hs) {
 		l_error("station_handshake_setup failed in reassociation");
-		station_roam_failed(station);
-		return;
+		return false;
 	}
 
-	station_transition_reassociate(station, bss, new_hs);
+	if (station_transition_reassociate(station, bss, new_hs) < 0) {
+		handshake_state_free(new_hs);
+		return false;
+	}
+
+	return true;
+}
+
+static void station_transition_start(struct station *station)
+{
+	struct roam_bss *rbss;
+	bool roaming = false;
+
+	/*
+	 * For each failed attempt pop the BSS leaving the head of the queue
+	 * with the current roam candidate.
+	 */
+	while ((rbss = l_queue_peek_head(station->roam_bss_list))) {
+		struct scan_bss *bss = network_bss_find_by_addr(
+					station->connected_network, rbss->addr);
+
+		roaming = station_try_next_transition(station, bss);
+		if (roaming)
+			break;
+
+		l_queue_pop_head(station->roam_bss_list);
+		l_free(rbss);
+	}
+
+	if (!roaming)
+		station_roam_failed(station);
 }
 
 static void station_roam_scan_triggered(int err, void *user_data)
-- 
2.34.3

