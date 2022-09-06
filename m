Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C1F86E7
	for <iwd@lists.linux.dev>; Tue,  6 Sep 2022 19:22:10 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id m3so1733421pjo.1
        for <iwd@lists.linux.dev>; Tue, 06 Sep 2022 12:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=a0EJTgrraaNxP3P6lu+Y3n6qXx3i5JjxACZVSjM54y4=;
        b=losdje5OcM9mcRbOGNt5ZbmaPy0Dhqx3o+aZZDb91nkkqpKYo/oUsoDaGCaLQFW9Cw
         uLnaFUe4ekHZ7RdnHcIQCXwzHluo6yDJeBsJpDMUORm2ArHlCEmkNZ9M4TiB1j2yVedx
         5NvsoOHX/0jVv57gozMaw0zJzgKhTuAjxNqD1XelBpERip4T283Db4yZiEjK9t9PmHCS
         WIiTDc+MBJr6Tkm9CgV0WMxL73lJGG3eniUdfS8ByCSbSybI/eQgTlAid51XiXZpYXRq
         /6dU22CDG5JowD9K5ly+9v2vOt/KEoqPr0SXBSYrTuh7Ys4hIyL+DBMXTBhAREgKSQV0
         igDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=a0EJTgrraaNxP3P6lu+Y3n6qXx3i5JjxACZVSjM54y4=;
        b=En910li1y9cKWHS+5NBpymqxzDi76oER5YGBADt2GRX8j3wLRJORFRaSdTR5eZmdmS
         HVkrSX+EwbpJgNFoqSOhd9E3vqLmh2lljQC+dejVeQ/LQzUGidwxhLV7oBvJZyiLBFoG
         Yb87i5YoO5W+jRhFpPohch2/uX7UokH9TB/M1O3ACmMWCRffn7eG0XJdNfA772YbV0aM
         +ImYCZLOL3Y4wA3B3hAINr++JiT9uq9JgXxd38D5AFCw6OznzdDmV5PQLiopix4vSrnp
         XHGiMVBF8tBJSqv7Ijxgr17OaBrSyCVtWcMN3HO7X5nJ6ug2YL78xkMPDCle3fOjg+hv
         pDvw==
X-Gm-Message-State: ACgBeo1v8mNNhqwRFf5XNNbHFJNV31MW2a+dNjEYr7NOkdpkbXOw32x3
	yPb/b8yO0vkqQHc2InWN951No2bTkgI=
X-Google-Smtp-Source: AA6agR7zhurapEgu0UZNqybfF6JLGwPNDnbjJnKsyMMPhf3RRPZ/GA5R+2Ws2ZCAvbnL9RmZQx4QEg==
X-Received: by 2002:a17:903:24f:b0:172:7d68:cf1 with SMTP id j15-20020a170903024f00b001727d680cf1mr129959plh.55.1662492129891;
        Tue, 06 Sep 2022 12:22:09 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902684900b00172f6726d8esm10206654pln.277.2022.09.06.12.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 12:22:09 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] netdev: allow powered address change
Date: Tue,  6 Sep 2022 12:22:06 -0700
Message-Id: <20220906192207.84986-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220906192207.84986-1-prestwoj@gmail.com>
References: <20220906192207.84986-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support for MAC address changes while powered was recently added to
mac80211. This avoids the need to power down the device which both
saves time as well as preserves any allowed frequencies which may
have been disabled if the device powered down.

The code path for changing the address was reused but now just the
'up' callback will be provided directly to l_rtnl_set_mac. Since
there aren't multiple stages of callbacks the rtnl_data structure
isn't strictly needed, but the code looks cleaner and more
consistent between the powered/non-powered code paths.

The comment/debug error print was also updated to be more general
between the two MAC change code paths.
---
 src/netdev.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 3cc34fcd..3cd3e4ef 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3601,12 +3601,8 @@ static void netdev_mac_change_failed(struct netdev *netdev,
 
 		goto failed;
 	} else {
-		/*
-		 * If the interface is up we can still try and connect. This
-		 * is a very rare case and most likely will never happen.
-		 */
-		l_info("Interface still up after failing to change the MAC, "
-			"continuing with connection");
+		/* If the interface is up we can still try and connect */
+		l_info("Failed to change the MAC, continuing with connection");
 		if (netdev_begin_connection(netdev) < 0)
 			goto failed;
 
@@ -3641,8 +3637,8 @@ static void netdev_mac_power_up_cb(int error, uint16_t type,
 	netdev->mac_change_cmd_id = 0;
 
 	if (error) {
-		l_error("Error taking interface %u up for per-network MAC "
-			"generation: %s", netdev->index, strerror(-error));
+		l_error("Error changing per-network MAC on interface %u: %s",
+			netdev->index, strerror(-error));
 		netdev_mac_change_failed(netdev, req, error);
 		return;
 	}
@@ -3673,8 +3669,6 @@ static void netdev_mac_power_down_cb(int error, uint16_t type,
 		return;
 	}
 
-	l_debug("Setting generated address on ifindex: %d to: "MAC,
-					netdev->index, MAC_STR(req->addr));
 	netdev->mac_change_cmd_id = l_rtnl_set_mac(rtnl, netdev->index,
 					req->addr, true,
 					netdev_mac_power_up_cb, req,
@@ -3713,6 +3707,8 @@ static int netdev_start_powered_mac_change(struct netdev *netdev)
 {
 	struct rtnl_data *req;
 	uint8_t new_addr[6];
+	bool powered = wiphy_has_ext_feature(netdev->wiphy,
+				NL80211_EXT_FEATURE_POWERED_ADDR_CHANGE);
 
 	/* No address set in handshake, use per-network MAC generation */
 	if (l_memeqzero(netdev->handshake->spa, ETH_ALEN))
@@ -3734,9 +3730,16 @@ static int netdev_start_powered_mac_change(struct netdev *netdev)
 	req->ref++;
 	memcpy(req->addr, new_addr, sizeof(req->addr));
 
-	netdev->mac_change_cmd_id = l_rtnl_set_powered(rtnl, netdev->index,
-					false, netdev_mac_power_down_cb,
-					req, netdev_mac_destroy);
+	if (powered)
+		netdev->mac_change_cmd_id = l_rtnl_set_mac(rtnl, netdev->index,
+						req->addr, false,
+						netdev_mac_power_up_cb, req,
+						netdev_mac_destroy);
+	else
+		netdev->mac_change_cmd_id = l_rtnl_set_powered(rtnl,
+						netdev->index, false,
+						netdev_mac_power_down_cb, req,
+						netdev_mac_destroy);
 
 	if (!netdev->mac_change_cmd_id) {
 		l_free(req);
@@ -3744,6 +3747,10 @@ static int netdev_start_powered_mac_change(struct netdev *netdev)
 		return -EIO;
 	}
 
+	l_debug("Setting generated address on ifindex: %d to: "MAC" (%s)",
+					netdev->index, MAC_STR(req->addr),
+					powered ? "powered" : "power-down");
+
 	return 0;
 }
 
-- 
2.34.3

