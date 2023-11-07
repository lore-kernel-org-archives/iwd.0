Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432CA30F8F
	for <iwd@lists.linux.dev>; Tue,  7 Nov 2023 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOtsqnxi"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7789cc5c8ccso465856085a.0
        for <iwd@lists.linux.dev>; Tue, 07 Nov 2023 06:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699366306; x=1699971106; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9u+hty29+P7c9zIKJAJcDefyW9mA99xF7TP5MMp1a9A=;
        b=FOtsqnxiIiAsTVRKEJb49By70Wi8wL1cTsP1/GJ7Qqk579s+L/YDekSQ2sWwR1wLlM
         nw6GgLOVureSTqtbkz9ssEICh3W7W4wmuSMPbYEWUcYaLQMOQA2ZaSjJyy92B4OVHUgA
         ClEqjiPBpjKVR075ptAPehAUGETe15TxBFKlvJ2Q0z0Oi0AtXLkY4N7XtyN/GB81qTDz
         i0Zo5GAR7OmkBztvpB+0FV7asbaBLS8aVZ1aQuBH4DKcr4Ro7OZwLyhxu5JixnCAHVip
         9XW4e7GLpePgjvwEpgq2X83SyO+JaXc0ESr+sTuPWvn8c7geHegE+jced5cyzabTu6G8
         9tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699366306; x=1699971106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9u+hty29+P7c9zIKJAJcDefyW9mA99xF7TP5MMp1a9A=;
        b=PuGzragwP+r1i2nAuxSW4q0IVPtm7C04hACtgB1+LxlxcJTsM6enPjkZ8btWNqabD2
         av4YOx3JBhkkW5QuF/NNsQ4a17DV1HHUq1udfT0qPo3X5KE4XOIyaIk5P0pY19rRc3Mb
         X4OQpBM0ft3aN9VpG0NZG56HtexBvowl8GVgfunSFkw/SxF6t50uZtFAtZfJ6woUP5Pi
         SeNFU1tPi1alDMj5yNWvzXnXFvjyGSuMmPuW/k1BABd9X2p2knnyScEafJLJj/BioRkT
         crQQMY34yC99dkNlaKVwop1pjJvksGh76jQttHcbPugD7g0m8tStscwEZOAXpgfxXvzk
         vdwA==
X-Gm-Message-State: AOJu0YxQVNWLlty55aSB6jgqParmfFtyCkoeVJU09L577Fm3gW7hIvzz
	dqsadn8K10eEMLrY6RqumLhgoxSn1sg=
X-Google-Smtp-Source: AGHT+IG8KkpIPnPmrjHmygdVBpiHELeQBWRB7LiHVFVUhrwRI+pTrwjZJc/BtAZiVC6Ssd4FLvsmvQ==
X-Received: by 2002:a05:620a:46a2:b0:774:220c:1547 with SMTP id bq34-20020a05620a46a200b00774220c1547mr3787060qkb.34.1699366305753;
        Tue, 07 Nov 2023 06:11:45 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id b7-20020a05620a04e700b00765aa3ffa07sm4204890qkh.98.2023.11.07.06.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 06:11:45 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/2] netdev: handle/send beacon loss event
Date: Tue,  7 Nov 2023 06:11:40 -0800
Message-Id: <20231107141140.1706441-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231107141140.1706441-1-prestwoj@gmail.com>
References: <20231107141140.1706441-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/netdev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index 56c6ebd2..86712658 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1054,6 +1054,7 @@ static void netdev_cqm_event(struct l_genl_msg *msg, struct netdev *netdev)
 	uint32_t *rssi_event = NULL;
 	int32_t *rssi_val = NULL;
 	uint32_t *pkt_event = NULL;
+	bool beacon_loss = false;
 
 	if (!l_genl_attr_init(&attr, msg))
 		return;
@@ -1081,7 +1082,7 @@ static void netdev_cqm_event(struct l_genl_msg *msg, struct netdev *netdev)
 					break;
 
 				case NL80211_ATTR_CQM_BEACON_LOSS_EVENT:
-					l_debug("Beacon lost event");
+					beacon_loss = true;
 					break;
 
 				case NL80211_ATTR_CQM_RSSI_LEVEL:
@@ -1111,6 +1112,9 @@ static void netdev_cqm_event(struct l_genl_msg *msg, struct netdev *netdev)
 	} else if (pkt_event && netdev->event_filter)
 		netdev->event_filter(netdev, NETDEV_EVENT_PACKET_LOSS_NOTIFY,
 					pkt_event, netdev->user_data);
+	else if (beacon_loss && netdev->event_filter)
+		netdev->event_filter(netdev, NETDEV_EVENT_BEACON_LOSS_NOTIFY,
+					NULL, netdev->user_data);
 }
 
 static void netdev_rekey_offload_event(struct l_genl_msg *msg,
-- 
2.25.1

