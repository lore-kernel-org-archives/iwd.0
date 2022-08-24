Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2779C2906
	for <iwd@lists.linux.dev>; Wed, 24 Aug 2022 22:55:27 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id bf22so18519702pjb.4
        for <iwd@lists.linux.dev>; Wed, 24 Aug 2022 15:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=78ArZr6x3j206Ry8lGiidW5SM5BRsWX4yBIbih3yb8g=;
        b=aIePHe7Fs3SIKrPpmLHMRiqsMaR2euhDljNUk7HUfWBXnO8N3vtx8hWph9XPGmH8+u
         b6TTH0vjoXRxbokeC5PlU7ca1ChHdPfrzh3hvXKuipFwm1ga7xfNPmGi2jJduu3Eh2Kk
         1onSeOu+eNy3WmpvaeatVm9X3zLAw7ayL+z56Yj7qtYhXEW+sB+nOJNCfR1DLwlwOBm6
         Iotc/eIR1ib8cag6umgs4g5WGypKBaTuYUmfRsLW7BWQb028iB+GPYicQSoSbkruk/EV
         sKIN2C6ImwQ3lLkqCDclVK00i8F5SiL1JGW5i+SNcz+CyhuVZDfHSnQ6cvQJN9Pqj7Ja
         nOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=78ArZr6x3j206Ry8lGiidW5SM5BRsWX4yBIbih3yb8g=;
        b=1rLcADv1jCtN2wWRh9OQmXcHupytRZVUeThbaEf8XoFS5OIKc/SUBQw58Vwggo/bl3
         n2rnBtCTWngrGcYB35wEx0NtM9PHCop1+jqFmgwal5fcmgKOFk0weoS7wssnU2vUtD6D
         atGvIwCGrsxxn+QViLFVqlABjcnmDnmH8xmlXncdcofd7ghEFYAYJ3tOu9CzgV4c694S
         xugMBJg0JPA28YJ2ebXP+1IPebANcZEsN+AUsc7Vup8FEqtBsfFsuGJWM9KCpDKzuNCf
         M4u0P71lWUz0JEhQ2l5srrvwvwfZvkTk22MPhlelRBcSbfuni5F9iZc4dLswk2JLWTK/
         4Gmw==
X-Gm-Message-State: ACgBeo29fqpxuO0gAb/vS+RbA7XdCa35a44uoFkdqyjy2gipfcmj5jH+
	ZVzUdGffQtBvWXjYe7UcEhN10+vJ84s=
X-Google-Smtp-Source: AA6agR6By7KoJdMXGhN90GFi8mm07j1BTWw3UGs5365kFkgdGjJbz5rbKXunYOJSMPbbh/+MO6yqwA==
X-Received: by 2002:a17:902:9888:b0:172:e456:307 with SMTP id s8-20020a170902988800b00172e4560307mr1020674plp.21.1661381726479;
        Wed, 24 Aug 2022 15:55:26 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id jn22-20020a170903051600b0016bcc35000asm6228682plb.302.2022.08.24.15.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 15:55:26 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/9] frame-xchg: create global group enum
Date: Wed, 24 Aug 2022 15:55:13 -0700
Message-Id: <20220824225518.2558698-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220824225518.2558698-1-prestwoj@gmail.com>
References: <20220824225518.2558698-1-prestwoj@gmail.com>
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

