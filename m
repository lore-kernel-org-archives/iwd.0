Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C74E4C91
	for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 22:07:54 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id y127so19402763pfy.5
        for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 15:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=78ArZr6x3j206Ry8lGiidW5SM5BRsWX4yBIbih3yb8g=;
        b=I4P3cqvYlK3ktH37Bfn90xXlPo8Ce7Gi4SMFP99Or3SchTbwC5CX4CiSZo2cvFvb4e
         AhKbAZivdPgFgNGTRtoTIlwL1a181eJ3zjkIOPCC3S+t6Tp1CEakG0qoDasnxuytI9TL
         Nhzc1QZIaJcwz3LmWPvzCa3rUTkblZv9NE3IsdCn3Pj0SCueRegPrGg6U6vkPx23mhKI
         5DQ02ICL5AzPZ1c2QtXxtFRUe21JGZvKEIorpnhkzhXMtrdhrHk+HY6sHJxUhK4YGLfU
         rKhZoaA+mjQSg67hZxkqxOkOaW2E7ZBDKD/cKB1H7DK4yG+poylAcMwIVeayDZmTfehb
         NAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=78ArZr6x3j206Ry8lGiidW5SM5BRsWX4yBIbih3yb8g=;
        b=XSZ2pPSJNA+6ce2iD/TYQbTkHNHGypCLeIfLwb59MmlANRjN2JpVDntxvStYm+0AHh
         zS8wszLrR0QQcy3sJ867AAvDNb/rBY3SVk+2xqc0KROWM6P0Oo4F7xrumDgr6CMLRY7J
         OYDBRgKJyfXmB0RhN8jTqadNVbEAWu2eqc7hFt+G40b5kO0zpv+YPJQPQOFqBx8QXJk8
         khdOAlbfFPzJsq3orhUqZOQOqgYuMMNuxgJzFpKSwyrxWZaH1FRlXYMfUac+yk2BAz2e
         Dc1o1e+MuqDFem1FTQLRj2VTPX89IvJjEINUJ28ZO5QmsQ7dLcr39gjsU/eFcvC0YCtX
         7pQw==
X-Gm-Message-State: ACrzQf0ITi8Di+k5LYPrnvKlzbG0hh7NMRt27r9C0BvQ+EdwO07LwcNV
	/+ulJg0TramFfAmDOEQxGsjoiKqIH3s=
X-Google-Smtp-Source: AMsMyM5EG0PFf5bTCnvo/BuBmu9Kk2iWasvZqBULYiKhGKZaZ7cmdNEa2Fec7DVhn8NFIshCg5qTaQ==
X-Received: by 2002:aa7:859a:0:b0:549:e89d:5ead with SMTP id w26-20020aa7859a000000b00549e89d5eadmr1600243pfn.63.1663279673996;
        Thu, 15 Sep 2022 15:07:53 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id k2-20020a6555c2000000b0041c0c9c0072sm12147165pgs.64.2022.09.15.15.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 15:07:53 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 04/14] frame-xchg: create global group enum
Date: Thu, 15 Sep 2022 15:07:31 -0700
Message-Id: <20220915220741.1128728-4-prestwoj@gmail.com>
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

Only P2P utilizes groups for now but to avoid conflicts in group
numbers for other modules create a global list which can be added
to as needed.
---
 src/frame-xchg.h |  7 +++++++
 src/p2p.c        | 24 +++++++++---------------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/src/frame-xchg.h b/src/frame-xchg.h
index 360bb4d4..5b55ded8 100644
--- a/src/frame-xchg.h
+++ b/src/frame-xchg.h
@@ -37,6 +37,13 @@ struct frame_xchg_prefix {
 	size_t len;
 };
 
+enum frame_xchg_group {
+	FRAME_GROUP_DEFAULT = 0,
+	FRAME_GROUP_P2P_LISTEN,
+	FRAME_GROUP_P2P_CONNECT,
+	FRAME_GROUP_FT,
+};
+
 bool frame_watch_add(uint64_t wdev_id, uint32_t group, uint16_t frame_type,
 			const uint8_t *prefix, size_t prefix_len,
 			frame_watch_cb_t handler, void *user_data,
diff --git a/src/p2p.c b/src/p2p.c
index 45a1b70b..cfd8560a 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -190,12 +190,6 @@ static const int channels_scan_2_4_other[] = { 2, 3, 4, 5, 7, 8, 9, 10 };
  */
 #define P2P_GO_INTENT 2
 
-enum {
-	FRAME_GROUP_DEFAULT = 0,
-	FRAME_GROUP_LISTEN,
-	FRAME_GROUP_CONNECT,
-};
-
 static bool p2p_device_match(const void *a, const void *b)
 {
 	const struct p2p_device *dev = a;
@@ -718,7 +712,7 @@ static void p2p_connection_reset(struct p2p_device *dev)
 
 	netdev_watch_remove(dev->conn_netdev_watch_id);
 
-	frame_watch_group_remove(dev->wdev_id, FRAME_GROUP_CONNECT);
+	frame_watch_group_remove(dev->wdev_id, FRAME_GROUP_P2P_CONNECT);
 	frame_xchg_stop_wdev(dev->wdev_id);
 
 	if (!dev->enabled || (dev->enabled && dev->start_stop_cmd_id)) {
@@ -2527,13 +2521,13 @@ respond:
 
 	if (status == P2P_STATUS_SUCCESS)
 		p2p_peer_frame_xchg(peer, iov, dev->addr, 0, 600, 0, true,
-					FRAME_GROUP_CONNECT,
+					FRAME_GROUP_P2P_CONNECT,
 					p2p_go_negotiation_resp_done,
 					&p2p_frame_go_neg_confirm,
 					p2p_go_negotiation_confirm_cb, NULL);
 	else
 		p2p_peer_frame_xchg(peer, iov, dev->addr, 0, 0, 0, true,
-					FRAME_GROUP_CONNECT,
+					FRAME_GROUP_P2P_CONNECT,
 					p2p_go_negotiation_resp_err_done, NULL);
 
 	l_debug("GO Negotiation Response sent with status %i", status);
@@ -2804,7 +2798,7 @@ static bool p2p_go_negotiation_resp_cb(const struct mmpdu_header *mpdu,
 	iov[iov_len].iov_base = NULL;
 
 	p2p_peer_frame_xchg(dev->conn_peer, iov, dev->conn_peer->device_addr,
-				0, 0, 0, false, FRAME_GROUP_CONNECT,
+				0, 0, 0, false, FRAME_GROUP_P2P_CONNECT,
 				p2p_go_negotiation_confirm_done, NULL);
 	l_free(confirm_body);
 
@@ -2893,7 +2887,7 @@ static void p2p_start_go_negotiation(struct p2p_device *dev)
 
 	p2p_peer_frame_xchg(dev->conn_peer, iov, dev->conn_peer->device_addr,
 				100, resp_timeout, 256, false,
-				FRAME_GROUP_CONNECT,
+				FRAME_GROUP_P2P_CONNECT,
 				p2p_go_negotiation_req_done,
 				&p2p_frame_go_neg_resp,
 				p2p_go_negotiation_resp_cb, NULL);
@@ -3035,7 +3029,7 @@ static void p2p_start_provision_discovery(struct p2p_device *dev)
 	 * sent to the P2P Device Address of the P2P Group Owner"
 	 */
 	p2p_peer_frame_xchg(dev->conn_peer, iov, dev->conn_peer->device_addr,
-				200, 600, 8, false, FRAME_GROUP_CONNECT,
+				200, 600, 8, false, FRAME_GROUP_P2P_CONNECT,
 				p2p_provision_disc_req_done,
 				&p2p_frame_pd_resp, p2p_provision_disc_resp_cb,
 				NULL);
@@ -4167,9 +4161,9 @@ static void p2p_device_discovery_start(struct p2p_device *dev)
 		dev->listen_channel = channels_social[l_getrandom_uint32() %
 						L_ARRAY_SIZE(channels_social)];
 
-	frame_watch_add(dev->wdev_id, FRAME_GROUP_LISTEN, 0x0040,
+	frame_watch_add(dev->wdev_id, FRAME_GROUP_P2P_LISTEN, 0x0040,
 			(uint8_t *) "", 0, p2p_device_probe_cb, dev, NULL);
-	frame_watch_add(dev->wdev_id, FRAME_GROUP_LISTEN, 0x00d0,
+	frame_watch_add(dev->wdev_id, FRAME_GROUP_P2P_LISTEN, 0x00d0,
 			p2p_frame_go_neg_req.data, p2p_frame_go_neg_req.len,
 			p2p_device_go_negotiation_req_cb, dev, NULL);
 
@@ -4187,7 +4181,7 @@ static void p2p_device_discovery_stop(struct p2p_device *dev)
 		l_timeout_remove(dev->scan_timeout);
 
 	p2p_device_roc_cancel(dev);
-	frame_watch_group_remove(dev->wdev_id, FRAME_GROUP_LISTEN);
+	frame_watch_group_remove(dev->wdev_id, FRAME_GROUP_P2P_LISTEN);
 }
 
 static void p2p_device_enable_cb(struct l_genl_msg *msg, void *user_data)
-- 
2.34.3

