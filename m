Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686541EA16
	for <iwd@lists.linux.dev>; Tue,  1 Nov 2022 20:17:57 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id b62so4008991pgc.0
        for <iwd@lists.linux.dev>; Tue, 01 Nov 2022 13:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOKtes0ZltwVRHNBy0LfGmRjRzyXYFUiWaVb+96yY0U=;
        b=N6xCgH+/1O7YtrruDWICgJV4kYU0NL+YIBOTRSrBLu5hE+E3q2mN3awb4cRuDw4EEW
         TqFz82fgPr2A9oCGp/0hIono4Tl0U0im4RoCESNF5cmHR3MpimVAaqK8i1aA3FrIJnqx
         AUhqemkCZgGUh9E1E3hxwUYejfQ4IwQtns8MIOh0zp6RSkrdS9HdL8OW1lr2PTB6hp5a
         ffai14dwCddJyRHjwzhUY1r9Z7KJ+60C90qad+mtP95MAd2MLoztr6L68b+XjRxZeyyq
         H9tDm7oybmAy9NZpTG0hdZBkmjQgTYrmc2plq6cRo+A9WnAwpSuogyCa2DaxRI3j+xXg
         se8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOKtes0ZltwVRHNBy0LfGmRjRzyXYFUiWaVb+96yY0U=;
        b=GaMQIFSsIovmX9xTy90gups+Ft6I+qrbBtmT4fx8PGPhu1EBe1hSg2kMJ7ayBnHDh5
         xuxlt01d4CMGgzD60GUNAffwJ49Bg4dz+ecHkL0ZOSrSu4MbzLVyhw/dstNWhtJ4OXt+
         Tc0hGpA5ivbRKoZbDN3FXVdECUU9vFUicCe7Ts+F4CpZjR/Ink4AdiGGAfm1ts3vn1GH
         HJ3ZkwCE2Ct82DmTQBOKxYrrwuoQhvCOAKS5EJtQIzpeFEUjm19jukZ10SMp4iccUorU
         oiqpdJulwn8XHJ9a/PONoQH7U94yng4SmPyyZMWHQUrzsr29ZfeV/ValGlm3+r0xs7bS
         U/QQ==
X-Gm-Message-State: ACrzQf0bNIWND2tmbsoWmOtD93VPwfC2TnLnoeI6Qsu4EzAqtb+v8Azv
	4E2QyOAxFqOir3+pCIcxE7WlxBSqW4E=
X-Google-Smtp-Source: AMsMyM4o8xyRGXEkVk8WAenBDnN7FmzZfLqUAyN7UH9YOBCoM0zd8QX3y1iN/ZucyVRCo/cJl3ogPA==
X-Received: by 2002:a63:7304:0:b0:46a:faa5:700f with SMTP id o4-20020a637304000000b0046afaa5700fmr18891302pgc.253.1667333876547;
        Tue, 01 Nov 2022 13:17:56 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b00180a7ff78ccsm6781681plg.126.2022.11.01.13.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:17:56 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 04/17] p2p: limit ciphers to CCMP/TKIP
Date: Tue,  1 Nov 2022 13:17:34 -0700
Message-Id: <20221101201747.143379-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221101201747.143379-1-prestwoj@gmail.com>
References: <20221101201747.143379-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The limitation of cipher selection in ap.c was done so to allow p2p to
work. Now with the ability to specify ciphers in the AP config put the
burden on p2p to limit ciphers as it needs.
---
 src/p2p.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/p2p.c b/src/p2p.c
index cfd8560a..ad2ac39f 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -1234,6 +1234,8 @@ static void p2p_group_start(struct p2p_device *dev)
 		((uint64_t) pdt->oui[2] << 24) |
 		((uint64_t) pdt->oui_type << 16) |
 		pdt->subcategory;
+	char *ciphers[] = { "TKIP", "CCMP", NULL };
+	uint16_t cipher;
 
 	l_settings_set_string(config, "General", "SSID", dev->go_group_id.ssid);
 	l_settings_set_uint(config, "General", "Channel", dev->listen_channel);
@@ -1273,6 +1275,19 @@ static void p2p_group_start(struct p2p_device *dev)
 	/* Enable netconfig, set maximum usable DHCP lease time */
 	l_settings_set_uint(config, "IPv4", "LeaseTime", 0x7fffffff);
 
+	l_settings_set_string_list(config, "Security", "PairwiseCiphers",
+					ciphers, ',');
+
+	/* TODO: P2P only plays nice with CCMP or TKIP ciphers currently */
+	cipher = wiphy_select_cipher(dev->wiphy, IE_RSN_CIPHER_SUITE_TKIP |
+						IE_RSN_CIPHER_SUITE_CCMP);
+	if (cipher == IE_RSN_CIPHER_SUITE_CCMP)
+		l_settings_set_string(config, "Security", "GroupCipher",
+					"CCMP");
+	else
+		l_settings_set_string(config, "Security", "GroupCipher",
+					"TKIP");
+
 	dev->capability.group_caps |= P2P_GROUP_CAP_GO;
 	dev->capability.group_caps |= P2P_GROUP_CAP_GROUP_FORMATION;
 	dev->capability.group_caps |= P2P_GROUP_CAP_IP_ALLOCATION;
-- 
2.34.3

