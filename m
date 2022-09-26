Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355B4398
	for <iwd@lists.linux.dev>; Mon, 26 Sep 2022 22:39:13 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so13922390pjm.1
        for <iwd@lists.linux.dev>; Mon, 26 Sep 2022 15:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Cca+ANdFjTDL91I8BzHBndrc/V+sFW33Mwl5MgtLN3Q=;
        b=J6bURHJ5knm7Ybl2ClE6xYwGNrbnsmhNzR7X5FHLoGMm505sO/8fP/XF1diyaZq51F
         rF/+R8WPOnOdY0kXycYBeDppWp9usdF3cj/rNBH8DKg7g4FkGr1u+LAGJvFVsBaJodoN
         0YSXLXxbnVIDOPzuPkZJC7QHU2BIiKk9sfjmGrjmO60VHYRhrEvpsmHIFYp3fs+kOZjc
         PgzlqKexPLUY+l42EAYuv49oBvJQfzG2xGcHdanjpNE5pqvT8CBLwsMsk8KkE/Ii4KSf
         65IuMN0U9lOkeXEIWknRzNZSMLhLHzFQUVUJ8P6NKpIb53XGJVfltbOEdWnP9tiB8ysN
         QoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Cca+ANdFjTDL91I8BzHBndrc/V+sFW33Mwl5MgtLN3Q=;
        b=1yhFQGNkqbE50DduFYFn5qNp+/psTTzdZ97G7cBduKndTyTbcvTQGIhVysxcGJwPVC
         ftK+PCL0wOcTpxQVUVsVm/wVvfP292pSP3OMZiRJICwBzX7/Tmgk2Nn3Um5zqOXRoo4i
         1maGTzaFPPrA6F06WBPJNY5nNdepGPl29yK++t1lXGw9gOId597o7bFGG23mrlSoRfeO
         CGwBkJXS7qhYn5WSclAsVh4HnkMKXP6fm7TbP5wEGhEiau3C7EfYrYc8v/svkDiChPG5
         gLV1e9nsgYx5NHvmPVk1B4owdgsd4rP6KKtrONyNUqIg2H0Rtv4NE8lTuEVBIIeDqylQ
         K4Eg==
X-Gm-Message-State: ACrzQf303J2AlGaDi5hZqxg9AuOHXkRy+UfPzGM6CNFTH8Af/L6KWlQb
	WisyfxFHQPM2DESPF4Rvxd5ndU6/axU=
X-Google-Smtp-Source: AMsMyM6CA7bVExXHe7ZSMiXSNM0s2VeOW1fIQklfIbU26ZE2C5K7M4HVLdzxk2VWotKxyFVK7CQ2Ww==
X-Received: by 2002:a17:903:1c4:b0:176:e348:c386 with SMTP id e4-20020a17090301c400b00176e348c386mr23629928plh.3.1664231952370;
        Mon, 26 Sep 2022 15:39:12 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id y23-20020a17090a16d700b001eee8998f2esm6983742pje.17.2022.09.26.15.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:39:12 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] netdev: differentiate connect/auth timeouts
Date: Mon, 26 Sep 2022 15:39:10 -0700
Message-Id: <20220926223910.109549-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The warnings in the authenticate and connect events were identical
so it could be difficult knowing which print it was if IWD is not
in debug mode (to see more context). The prints were changed to
indicate which event it was and for the connect event the reason
attribute is also parsed.

Note the resp_ies_len is also initialized to zero now. After making
the changes gcc was throwing a warning.
---
 src/netdev.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 7f4101be..5af6bb36 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2734,8 +2734,10 @@ static void netdev_connect_event(struct l_genl_msg *msg, struct netdev *netdev)
 	size_t ies_len = 0;
 	struct ie_tlv_iter iter;
 	const uint8_t *resp_ies = NULL;
-	size_t resp_ies_len;
+	size_t resp_ies_len = 0;
 	struct handshake_state *hs = netdev->handshake;
+	bool timeout = false;
+	uint32_t timeout_reason = 0;
 
 	l_debug("");
 
@@ -2763,8 +2765,14 @@ static void netdev_connect_event(struct l_genl_msg *msg, struct netdev *netdev)
 	while (l_genl_attr_next(&attr, &type, &len, &data)) {
 		switch (type) {
 		case NL80211_ATTR_TIMED_OUT:
-			l_warn("authentication timed out");
-			goto error;
+			timeout = true;
+			break;
+		case NL80211_ATTR_TIMEOUT_REASON:
+			if (len != 4)
+				break;
+
+			timeout_reason = l_get_u32(data);
+			break;
 		case NL80211_ATTR_STATUS_CODE:
 			if (len == sizeof(uint16_t))
 				status_code = data;
@@ -2780,6 +2788,11 @@ static void netdev_connect_event(struct l_genl_msg *msg, struct netdev *netdev)
 		}
 	}
 
+	if (timeout) {
+		l_warn("connect event timed out, reason=%u", timeout_reason);
+		goto error;
+	}
+
 	if (netdev->expect_connect_failure) {
 		/*
 		 * The kernel may think we are connected when we are actually
@@ -3106,7 +3119,7 @@ static void netdev_authenticate_event(struct l_genl_msg *msg,
 	while (l_genl_attr_next(&attr, &type, &len, &data)) {
 		switch (type) {
 		case NL80211_ATTR_TIMED_OUT:
-			l_warn("authentication timed out");
+			l_warn("authentication event timed out");
 
 			if (auth_proto_auth_timeout(netdev->ap))
 				return;
-- 
2.34.3

