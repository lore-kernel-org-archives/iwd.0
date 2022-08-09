Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F024A10
	for <iwd@lists.linux.dev>; Tue,  9 Aug 2022 23:04:42 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id q9-20020a17090a2dc900b001f58bcaca95so395552pjm.3
        for <iwd@lists.linux.dev>; Tue, 09 Aug 2022 16:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=u30MDtW1UtsxmMMVo6xoX3AqgyeaBZ6h5XaWhS9Xljo=;
        b=FGBcFvSrdCuuymYDZ8la5BhO5j6z2QTSrNlbCmEMsUG+iITopXg6A8bNN2K8a2THlG
         8PYGMBZ2Ts8TAurIBS6leBMvlFsyT485QE5YDR8Km1FPyf0rHItmwTUy3zxDYeM+8ocI
         eEHkFAhtaE0enCtq3oTrM0feKg/tojBVDVxpeS0pCdD0ebw6vs6LSXP2lLZ2Xj7bjJsw
         eTNXdVT1CsYdHmmq+E8qg+Dma2PTU/CzvMf9urblNUBcmh982omIgPOIt719gtwQWiyP
         Sa1WQfOvBEW99sJ4hyi9hWcQAIPwBxShFlzkUt/XEn49FqfeWJrJuMfU1ImZLoGWhU3x
         5vNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=u30MDtW1UtsxmMMVo6xoX3AqgyeaBZ6h5XaWhS9Xljo=;
        b=lN02ZPihfeYklfx6sYqCrvabcvVOkJOvLX1m5UWjnj3ti0JJb6f2WdCdSC7oXhQ4lM
         NmmyZNR0I3DwveqjgqL5VM1Z1NXwrcmKMQC13yiFR5jNwhmZp73c+ES4zWCRZ7PeExgh
         ADx1gjiK4rSZ0NFm3LqwLXNrikAIWXrY7+dliKGOStELDE1CvL4XdiWJ+U7b6dVpoBvh
         o4yUwbcFOWNF79MvOA/e36KfFzdneovBzP4hCNp7swLfvg3h+rDZ488Vp3PWnZOsMs2k
         XEIy+ZnXvDDjr9/dSq/bG4niCrM27cRcIN5phfJmL9t0YAmxBJM9gNoZc+HCik/KH0da
         su9w==
X-Gm-Message-State: ACgBeo1kib9eUdyn6b/MDUUll617uchyuiaY3r/YQ4fxrR0uhny9+bLj
	qvV21IGBzkFD1GAva8mGwk1GP0gnwbY=
X-Google-Smtp-Source: AA6agR65PvWex1TJk0pFA8waiwVLYbpgeqdkvSf0NY2bvqfQSbHo3dXDJMBD2JPbalToizESihghAQ==
X-Received: by 2002:a17:902:dacb:b0:16f:6d84:b6ca with SMTP id q11-20020a170902dacb00b0016f6d84b6camr24536382plx.19.1660086282206;
        Tue, 09 Aug 2022 16:04:42 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id w13-20020a62820d000000b0052d748498edsm459063pfd.13.2022.08.09.16.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 16:04:41 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>,
	mjohnson459@gmail.com
Subject: [RFC 2/4] netdev: handle packet loss notification
Date: Tue,  9 Aug 2022 16:04:26 -0700
Message-Id: <20220809230428.215970-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220809230428.215970-1-prestwoj@gmail.com>
References: <20220809230428.215970-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This attribute was already handled and simply printed. Now a
netdev event will be sent to notify any listeners.
---
 src/netdev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 47e076e2..0d48631c 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1073,6 +1073,7 @@ static void netdev_cqm_event(struct l_genl_msg *msg, struct netdev *netdev)
 	const void *data;
 	uint32_t *rssi_event = NULL;
 	int32_t *rssi_val = NULL;
+	uint32_t *pkt_event = NULL;
 
 	if (!l_genl_attr_init(&attr, msg))
 		return;
@@ -1096,8 +1097,7 @@ static void netdev_cqm_event(struct l_genl_msg *msg, struct netdev *netdev)
 					if (len != 4)
 						continue;
 
-					l_debug("Packets lost event: %d",
-							*(uint32_t *) data);
+					pkt_event = (uint32_t *) data;
 					break;
 
 				case NL80211_ATTR_CQM_BEACON_LOSS_EVENT:
@@ -1128,7 +1128,9 @@ static void netdev_cqm_event(struct l_genl_msg *msg, struct netdev *netdev)
 			l_debug("Signal change event (above=%d)", *rssi_event);
 			netdev_cqm_event_rssi_threshold(netdev, *rssi_event);
 		}
-	}
+	} else if (pkt_event && netdev->event_filter)
+		netdev->event_filter(netdev, NETDEV_EVENT_PACKET_LOSS_NOTIFY,
+					pkt_event, netdev->user_data);
 }
 
 static void netdev_rekey_offload_event(struct l_genl_msg *msg,
-- 
2.34.3

