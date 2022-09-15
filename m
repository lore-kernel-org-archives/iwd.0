Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7B7538E
	for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 22:08:00 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id n23-20020a17090a091700b00202a51cc78bso17489708pjn.2
        for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 15:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=kWV1A6SjzYKXZm5IbjLD5ixEoOORnEdLqa3Hn3rdG/4=;
        b=Qbs7GRuaUbCJ62PXIYNjsjBsrMC8R9pW3S7GreOhHyz3dCl9lKbNGb+GY2mzB7I9Wt
         67sGCW3pM/X9NRiwjbDIjXQG1VWQfseqvk9EQ1j0rrmKkEYlAFQ5hc4sGUoZMQbUIE97
         EJhyUd/H9zky/ma2GFceHsLPd3hrCmwILNVMDzgyzxM65Zp9IkcoBQgCUHy8WoBoceoi
         vPaSfH8ELtHwA5gxBCArNPhP7V291POMfwcka8Zrp2dhsazr2m28ptopaf3hONN2MK5j
         N+LNWRNC/rK0lEvBv67XxiyyaSzILupQIPzrenEulCgOMfLaWX2jprs1c51WWF34Ubvz
         QCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kWV1A6SjzYKXZm5IbjLD5ixEoOORnEdLqa3Hn3rdG/4=;
        b=EXLj4yBkHVV+HukTvtWcNpC/SUfzLG+4H7cIGxqph49YCb8OWrMMoMYSqU89phUdbh
         22sCW7Hf+3i3y0RSh+tp8BlvRRk0FSQpyKiI9naZFYGYdLhI7dIj+jWF8B2vfxZOsozU
         TvmNgg23jniwdrZPpeFQD4fxTPKP4UENgI84QF7Wg+2cj3Zoqag29GfLe/wCmclRQhf/
         TQFwbSvUNcBVcOrJezmDUR7Y4emhanZrbGXjKisxn/pcPmKzoFazibfaJ46gmfaz0ZJ7
         GzrrhKZO2DzVJ+wWauS4J6M4OfJvu3bTlbVbxXdLqi+N2VkUyOAs0+kYYd/VMxLrvXas
         j/pA==
X-Gm-Message-State: ACrzQf2WzVxeh1V6bXbJ+aApaHT0POYfqxqMxHz/NW5cpWjqSmq46+oY
	J/RgNSeBdO3DdvRtsZKTDqHBuVDoCmQ=
X-Google-Smtp-Source: AMsMyM7T5aSqsNqAgmozesTel2ttjEezf8A1l2VpLsQERAHORHUVr/pAzaavkqEX7CD8wCKEZNUcxQ==
X-Received: by 2002:a17:903:186:b0:178:2ca7:fae5 with SMTP id z6-20020a170903018600b001782ca7fae5mr1615775plg.173.1663279680222;
        Thu, 15 Sep 2022 15:08:00 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id k2-20020a6555c2000000b0041c0c9c0072sm12147165pgs.64.2022.09.15.15.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 15:07:59 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 13/14] station: try multiple roam candidates
Date: Thu, 15 Sep 2022 15:07:40 -0700
Message-Id: <20220915220741.1128728-13-prestwoj@gmail.com>
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

There were a few failure paths in station_transition_start which
may not always be fatal. Both FT variants could fail, e.g. if
neither FT-over-DS or FT-over-Air were able to authenticate. In
this case it would be wise to try another BSS.
---
 src/station.c | 95 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 58 insertions(+), 37 deletions(-)

diff --git a/src/station.c b/src/station.c
index 76023520..25d169dc 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2113,21 +2113,23 @@ static void station_fast_transition_cb(struct netdev *netdev,
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
@@ -2199,10 +2201,14 @@ static void station_preauthenticate_cb(struct netdev *netdev,
 		handshake_state_set_supplicant_ie(new_hs, rsne_buf);
 	}
 
-	station_transition_reassociate(station, bss, new_hs);
+	if (station_transition_reassociate(station, bss, new_hs) < 0) {
+		handshake_state_free(new_hs);
+		station_roam_failed(station);
+	}
 }
 
-static void station_transition_start(struct station *station)
+static bool station_try_next_transition(struct station *station,
+					struct scan_bss *bss)
 {
 	struct handshake_state *hs = netdev_get_handshake(station->netdev);
 	struct network *connected = station->connected_network;
@@ -2210,7 +2216,6 @@ static void station_transition_start(struct station *station)
 	struct handshake_state *new_hs;
 	struct ie_rsn_info cur_rsne, target_rsne;
 	int ret;
-	struct scan_bss *bss = l_queue_peek_head(station->roam_bss_list);
 
 	l_debug("%u, target %s", netdev_get_ifindex(station->netdev),
 			util_address_to_string(bss->addr));
@@ -2226,11 +2231,8 @@ static void station_transition_start(struct station *station)
 
 		/* Rebuild handshake RSN for target AP */
 		if (station_build_handshake_rsn(hs, station->wiphy,
-				station->connected_network, bss) < 0) {
-			l_error("rebuilding handshake rsne failed");
-			station_roam_failed(station);
-			return;
-		}
+				station->connected_network, bss) < 0)
+			return false;
 
 		/* Reset the vendor_ies in case they're different */
 		vendor_ies = network_info_get_extra_ies(info, bss, &iov_elems);
@@ -2243,29 +2245,23 @@ static void station_transition_start(struct station *station)
 			/* No action responses from this BSS, try over air */
 			if (ret == -ENOENT)
 				goto try_over_air;
-			else if (ret < 0) {
-				/*
-				 * If we are here FT-over-air will not work
-				 * either (identical checks) so try again later.
-				 */
-				station_roam_retry(station);
-				return;
-			}
+			else if (ret < 0)
+				return false;
+
+			station->connected_bss = bss;
+			station->preparing_roam = false;
+			station_enter_state(station, STATION_STATE_ROAMING);
+
+			return true;
 		} else {
 try_over_air:
 			if (netdev_fast_transition(station->netdev, bss,
 					station->connected_bss,
-					station_fast_transition_cb) < 0) {
-				station_roam_failed(station);
-				return;
-			}
-		}
-
-		station->connected_bss = bss;
-		station->preparing_roam = false;
-		station_enter_state(station, STATION_STATE_ROAMING);
+					station_fast_transition_cb) < 0)
+				return false;
 
-		return;
+			return true;
+		}
 	}
 
 	/* Non-FT transition */
@@ -2296,17 +2292,42 @@ try_over_air:
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
+	}
+
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
 	}
 
-	station_transition_reassociate(station, bss, new_hs);
+	if (!roaming)
+		station_roam_failed(station);
 }
 
 static void station_roam_scan_triggered(int err, void *user_data)
-- 
2.34.3

