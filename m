Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991765390
	for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 22:08:01 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so23727575pjq.3
        for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 15:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=IMbb6A4I6vDuEfUYKyusDPlNHCJdQXi9Nop+9SVuioI=;
        b=ZJx5QA9Vut517suqcmTtDxsf5o9+z+r0ktAq848296Bl9s7AXjmsDJDDShyy59rPwQ
         4v18dNcghY1j/tq/r3TyolNjZXCvHLKA3LEZbRTcqs7fmp8NCD2MIahfAgkMc5WxTyxu
         PiaZHQlj10qKQE6ypoU8eM4GWCObrovUxHdcv9nuzCKWAWlm6kBSqsGzFEZRovMVLnr+
         sfWtpagMEtKG7td0qg6MZzskXkze1zD9zFPXxaawr1OvwcYHnqvQkzqQ+g7zj8J9fvL2
         M3U1UC6HQ9M3N6t0exvV2MBoU4pEhLfz/FEg2BSiPrEZPea4Z4iRBu8K+fIxBjzizoKu
         h9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IMbb6A4I6vDuEfUYKyusDPlNHCJdQXi9Nop+9SVuioI=;
        b=K5HpFLgz2WtPvk+/QN+lWagJ+nV7zE1Dp+d3W/YduBBghaSfx6BNhXX66PPv0MT3Iy
         W6+5TlycXb6r7LcXmJY+hNr/i2p1V7KxgACYlY+y45YHZnKIOhlrodEK1fRPx7lCFRh9
         ydMkPT9ZF/kTntKikk3G4HwdE8BHYltO/E8xMtoEAVvnbcRmqOqb7eKsOWz72nZnddTz
         5rkXFL7djnS6SaTh29UTDYNVB3P0EetUvXVQqD6K2IQcSHsKmzK+UdvXH/vaA8Svdl+w
         sBWtqxShr6MNOVUQrVlDrLWLZJ2CRBSlb9CTvKa7+6pZSH7IPWo3ciZnzZC/BkZI7oYp
         efLA==
X-Gm-Message-State: ACrzQf2grd88pEIZryoUP9lpkNhW2Relo1aVjmlXQEk51Ide5JFOCVm+
	R25orOhKJCCZnF2MgtKa7O7C9OXjYg0=
X-Google-Smtp-Source: AMsMyM4y5WlIKX6kFoJ9MML/2dSUCJqcsUeZ8fRWr4CPVc05imfxGz0vBqw2xBiJNSRvIIZQtdWbhg==
X-Received: by 2002:a17:902:d548:b0:178:41dd:899 with SMTP id z8-20020a170902d54800b0017841dd0899mr1653308plf.149.1663279680935;
        Thu, 15 Sep 2022 15:08:00 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id k2-20020a6555c2000000b0041c0c9c0072sm12147165pgs.64.2022.09.15.15.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 15:08:00 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 14/14] netdev: add NETDEV_EVENT_FT_AUTHENTICATE, handle in station
Date: Thu, 15 Sep 2022 15:07:41 -0700
Message-Id: <20220915220741.1128728-14-prestwoj@gmail.com>
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

Once FT-Authenticate finishes station needs to know regardless of
the outcome. For a success the current BSS/roam state needs to be
updated, and for failure station may attempt to FT to a different
BSS>
---
 src/netdev.c  | 12 +++++-------
 src/netdev.h  |  1 +
 src/station.c | 18 ++++++++++++++++++
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 52ad89ba..00c33691 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4525,19 +4525,17 @@ static void netdev_ft_authenticate_cb(int err, const uint8_t *addr,
 {
 	struct netdev *netdev = user_data;
 
+	if (netdev->event_filter)
+		netdev->event_filter(netdev, NETDEV_EVENT_FT_AUTHENTICATE,
+					&err, netdev->user_data);
+
 	if (err < 0)
-		goto ft_failed;
+		return;
 
 	prepare_ft(netdev, addr, frequency);
 
 	wiphy_radio_work_insert(netdev->wiphy, &netdev->work,
 				WIPHY_WORK_PRIORITY_CONNECT, &ft_work_ops);
-
-	return;
-
-ft_failed:
-	netdev_connect_failed(netdev, NETDEV_RESULT_AUTHENTICATION_FAILED,
-					MMPDU_STATUS_CODE_UNSPECIFIED);
 }
 
 int netdev_fast_transition(struct netdev *netdev,
diff --git a/src/netdev.h b/src/netdev.h
index dcf3ad1b..55df9b22 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -50,6 +50,7 @@ enum netdev_event {
 	NETDEV_EVENT_RSSI_THRESHOLD_HIGH,
 	NETDEV_EVENT_RSSI_LEVEL_NOTIFY,
 	NETDEV_EVENT_PACKET_LOSS_NOTIFY,
+	NETDEV_EVENT_FT_AUTHENTICATE,
 };
 
 enum netdev_watch_event {
diff --git a/src/station.c b/src/station.c
index 25d169dc..47e6d39b 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3134,6 +3134,21 @@ static void station_packets_lost(struct station *station, uint32_t num_pkts)
 	station_start_roam(station);
 }
 
+static void station_ft_authenticate_event(struct station *station, int err)
+{
+	struct scan_bss *target = l_queue_pop_head(station->roam_bss_list);
+
+	if (err) {
+		/* Failed target popped, continue trying more targets */
+		station_transition_start(station);
+		return;
+	}
+
+	station->connected_bss = target;
+	station->preparing_roam = false;
+	station_enter_state(station, STATION_STATE_ROAMING);
+}
+
 static void station_netdev_event(struct netdev *netdev, enum netdev_event event,
 					void *event_data, void *user_data)
 {
@@ -3172,6 +3187,9 @@ static void station_netdev_event(struct netdev *netdev, enum netdev_event event,
 	case NETDEV_EVENT_PACKET_LOSS_NOTIFY:
 		station_packets_lost(station, l_get_u32(event_data));
 		break;
+	case NETDEV_EVENT_FT_AUTHENTICATE:
+		station_ft_authenticate_event(station, *((int *)event_data));
+		break;
 	}
 }
 
-- 
2.34.3

