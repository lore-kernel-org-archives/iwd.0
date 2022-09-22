Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE9F2F29
	for <iwd@lists.linux.dev>; Thu, 22 Sep 2022 22:08:17 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id w2so10669526pfb.0
        for <iwd@lists.linux.dev>; Thu, 22 Sep 2022 15:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=wvyfUI/Cb+pUJXwE3wOhLiZWgNEwAMy+8ld+xTzoNyY=;
        b=BQCEXIrgTRdZvb80vbgcpsx2gne4jbQqfRiJU0+RKmqwDnCrERLIcIpBeb2vUo4R3f
         iAZXOxSvIzFqfAXYCDRm5vckk87HjCUY+ZXYPnkt74Win1jwelLTI71NeRHtHP2X2elZ
         5B7oxEAiQvZbByjY4qgsJYbW44R2w83tZ/LpQQ+3rZzXg9ulLEBryZWiKnxXF2p4FGQW
         qJh8uXod4CdhJYntCUDd7HFyH9dj3TYWCGbn5FCmq4ncrEuRPFC34hoOAbojZiKPTIue
         VL55MPKcQRtY4iZMBD+2xSsI/zn1FCuavW0ocgtQoD8Nl1OgPNCclE4s/ZAo3BadY8Iw
         iL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wvyfUI/Cb+pUJXwE3wOhLiZWgNEwAMy+8ld+xTzoNyY=;
        b=lP3nIBe2SAd+f/YlfxWlmLOeDnSLMtXAO4/j8DNBwF06JCkO4NbBqipLyc218rkOf7
         dOu9WO+YyrBWrqWsrLZ6kIkmMzOpM7CwF5oDiZ8+fa+29El0Qh3JCniPgK+8WpNt4EkT
         dcG5ZuIeGjVLydqkRfThwhwdv2WFlgaff1BlzJH+Rpmcxt6lBOMcXZ6g30oagPS8qNq9
         S8mWfhXetPd5BgWY6kPR/k47HzU4C3lv0+TLF8UBiv6VRRUXr5QNagvLAmLO7lUJNseb
         846f6neDi+ILODd9MFAUudFMv/9cjg95ozr1PG47ojDM9gNs1K/5G0hFOh76MTmqzmuO
         CiOw==
X-Gm-Message-State: ACrzQf0sHm9qoZqYjSi2yHp2sVMiF9yF3zXJhHKjVtiUqhGCsVhSkXUM
	7+29NxqrEbVEXDOY06gjcpe9ATQQdRI=
X-Google-Smtp-Source: AMsMyM7oJ9oWUqZ4WMNwzqM/pOjCFsmjlch601qIbyw2k1e2zlBg5vbUZpGqDzw/x06EcUlZJ4pF6Q==
X-Received: by 2002:a63:34c5:0:b0:439:a5df:c712 with SMTP id b188-20020a6334c5000000b00439a5dfc712mr4732806pga.563.1663884496547;
        Thu, 22 Sep 2022 15:08:16 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id f15-20020aa7968f000000b005386162bc2asm4980448pfk.92.2022.09.22.15.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 15:08:16 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 08/11] station: try multiple roam candidates
Date: Thu, 22 Sep 2022 15:08:06 -0700
Message-Id: <20220922220809.862022-8-prestwoj@gmail.com>
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

This converts station to using ft_action/ft_authenticate and
ft_associate and dropping the use of the netdev-only/auth-proto
logic.

Doing this allows for more flexibility if FT fails by letting
IWD try another roam candidate instead of disconnecting.
---
 src/station.c | 213 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 131 insertions(+), 82 deletions(-)

diff --git a/src/station.c b/src/station.c
index 5f5838e7..60915618 100644
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
@@ -1643,6 +1646,8 @@ static void station_roam_state_clear(struct station *station)
 	}
 
 	l_queue_clear(station->roam_bss_list, NULL);
+
+	ft_clear_authentications(netdev_get_ifindex(station->netdev));
 }
 
 static void station_reset_connection_state(struct station *station)
@@ -1954,7 +1959,8 @@ static void station_ft_ds_action_start(struct station *station)
 		 * Fire and forget. Netdev will maintain a cache of responses
 		 * and when the time comes these can be referenced for a roam
 		 */
-		netdev_fast_transition_over_ds_action(station->netdev, bss);
+		ft_action(netdev_get_ifindex(station->netdev),
+				station->connected_bss->frequency, bss);
 	}
 }
 
@@ -2083,42 +2089,26 @@ static void station_reassociate_cb(struct netdev *netdev,
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
@@ -2190,18 +2180,98 @@ static void station_preauthenticate_cb(struct netdev *netdev,
 		handshake_state_set_supplicant_ie(new_hs, rsne_buf);
 	}
 
-	station_transition_reassociate(station, bss, new_hs);
+	if (station_transition_reassociate(station, bss, new_hs) < 0) {
+		handshake_state_free(new_hs);
+		station_roam_failed(station);
+	}
 }
 
-static void station_transition_start(struct station *station)
+static void station_transition_start(struct station *station);
+
+static bool station_ft_work_ready(struct wiphy_radio_work_item *item)
+{
+	struct station *station = l_container_of(item, struct station, ft_work);
+	struct scan_bss *bss = l_queue_pop_head(station->roam_bss_list);
+	int ret;
+
+	ret = ft_associate(netdev_get_ifindex(station->netdev), bss->addr);
+	if (ret == -ENOENT) {
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
+}
+
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
-	struct scan_bss *bss = l_queue_peek_head(station->roam_bss_list);
 
 	l_debug("%u, target %s", netdev_get_ifindex(station->netdev),
 			util_address_to_string(bss->addr));
@@ -2210,54 +2280,8 @@ static void station_transition_start(struct station *station)
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
 
@@ -2287,17 +2311,42 @@ try_over_air:
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
+	}
+
+	if (station_transition_reassociate(station, bss, new_hs) < 0) {
+		handshake_state_free(new_hs);
+		return false;
 	}
 
-	station_transition_reassociate(station, bss, new_hs);
+	return true;
+}
+
+static void station_transition_start(struct station *station)
+{
+	struct scan_bss *bss;
+	bool roaming = false;
+
+	/*
+	 * For each failed attempt pop the BSS leaving the head of the queue
+	 * with the current roam candidate.
+	 */
+	while ((bss = l_queue_peek_head(station->roam_bss_list))) {
+		roaming = station_try_next_transition(station, bss);
+		if (roaming)
+			break;
+
+		l_queue_pop_head(station->roam_bss_list);
+	}
+
+	if (!roaming)
+		station_roam_failed(station);
 }
 
 static void station_roam_scan_triggered(int err, void *user_data)
-- 
2.34.3

