Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F0328E6
	for <iwd@lists.linux.dev>; Wed, 15 Nov 2023 00:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZY/RRs0y"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-58a0154b4baso165523eaf.1
        for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 16:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700006797; x=1700611597; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AiE+vwFltgMwkcCQf1Egh7JIrottearILzKHJRFydCM=;
        b=ZY/RRs0yNjrEly9UONuiN7Fz4izgvWfQ+ua90LXYI7iWI7ngtXgGFE9VtlIQGU8d+k
         NCSEBIueoHbxSHmYv3rwP5opaeLdxhl+NGoNbNuoO3wxfS+P201LqnGuSJbAQf5qvAIE
         agyVrF9SNagl/2by7D1zUqQDVTI3Ps4Gj0zUCcryHqNBUxNngv2LuUlVu2c99O1PJ9q2
         Vz72a5Hh7sA7RroErRodvxRJ15XroN71e415isD5VsmfHNbx3jRK6e2adq31+cVOJS+Y
         iXTz8/8hKQ74fW0d+2rJh8CSSoUf7wDpdNeFx/MEqH/L8B7Wr1yGZIGYwdgbFG41pBT7
         W0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700006797; x=1700611597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AiE+vwFltgMwkcCQf1Egh7JIrottearILzKHJRFydCM=;
        b=ORNww7xy+mZ+JfUipXiWh3AH/UvHya0p0ZXkL1R/wzS5ml5dxsRH3o3EVaNgktj9Tm
         Hc4vvWHv231Vl0QPYzHFYXChlf3WDRxewL7whngBQPwJ8t27PscZBbmNEHLr6oG20FkM
         8ivnkHu0Pt26BBu2ByjB5L4/LCXpwl++b/jQpRpXYMvGots54U3vGHQ2KTsWTF0n2w0b
         aCVnfD6PGRBvodfx8+VOnLQ6W2fw/wd9wBwQfvPnzktbVuGw7BTLQPLbWpnTtb8qP2eQ
         YwfzQanmEisR0bV9RktfmsCa8Gf87KktpeyxD/IAounLTeGqTJ2Y4ekkzoU2ZORsY6ih
         jZJQ==
X-Gm-Message-State: AOJu0Yw4xXEmuV5J8ckNYf8Vo+7rNNIgBPm8LEhlzy5ajM3tVKihKLS9
	UVBUPoMqa6FxoZbxaThNckwZAmFWAZk=
X-Google-Smtp-Source: AGHT+IG8Nk/XF5de+9uo/h0OzkexyHAAbMUR8LrM6LCPOW8Jl4dwDcbKFxtcb0zOK9Ic7BE+Lrujfg==
X-Received: by 2002:a05:6871:918b:b0:1e9:88e0:b8ba with SMTP id ak11-20020a056871918b00b001e988e0b8bamr1866260oac.29.1700006797389;
        Tue, 14 Nov 2023 16:06:37 -0800 (PST)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id pi5-20020a056871d10500b001e578de89cesm1607468oac.37.2023.11.14.16.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 16:06:36 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/3] netdev: Remove improper use of netdev_connect_failed
Date: Tue, 14 Nov 2023 18:05:31 -0600
Message-ID: <20231115000547.1139157-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a roam event is received, iwd generates a firmware scan request and
notifies its event filter of the ROAMING condition.  In cases where the
firmware scan could not be started successfully, netdev_connect_failed
is invoked.  This is not a correct use of netev_connect_failed since it
doesn't actually disconnect the underlying netdev and the reflected
state becomes de-synchronized from the underlying kernel device.

The firmware scan request could currently fail for two reasons:
  1. nl80211 genl socket is in a bad state, or
  2. the scan context does not exist

Since both reasons are highly unlikely, simply use L_WARN instead.

The other two cases where netdev_connect_failed is used could only occur
if the kernel message is invalid.  The message is ignored in that case
and a warning is printed.

The situation described above also exists in netdev_get_fw_scan_cb. If
the scan could not be completed successfully, there's not much iwd can
do to recover.  Have iwd remain in roaming state and print an error.
---
 src/netdev.c | 35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index ffd903740dd9..4a418b60abcf 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4934,7 +4934,7 @@ static bool netdev_get_fw_scan_cb(int err, struct l_queue *bss_list,
 
 	if (err < 0) {
 		l_error("Failed to get scan after roam (%d)", err);
-		goto failed;
+		return false;
 	}
 
 	/*
@@ -4946,7 +4946,7 @@ static bool netdev_get_fw_scan_cb(int err, struct l_queue *bss_list,
 
 	if (!bss) {
 		l_error("Roam target BSS not found in scan results");
-		goto failed;
+		return false;
 	}
 
 	netdev->fw_roam_bss = bss;
@@ -4958,16 +4958,9 @@ static bool netdev_get_fw_scan_cb(int err, struct l_queue *bss_list,
 		return false;
 	}
 
-	if (netdev->sm) {
-		if (!eapol_start(netdev->sm))
-			goto failed;
-	}
-
-	return false;
+	if (netdev->sm)
+		L_WARN_ON(!eapol_start(netdev->sm));
 
-failed:
-	netdev_connect_failed(netdev, NETDEV_RESULT_ABORTED,
-					MMPDU_REASON_CODE_UNSPECIFIED);
 	return false;
 }
 
@@ -4998,8 +4991,8 @@ static void netdev_roam_event(struct l_genl_msg *msg, struct netdev *netdev)
 
 	netdev->operational = false;
 
-	if (!l_genl_attr_init(&attr, msg))
-		goto failed;
+	if (L_WARN_ON(!l_genl_attr_init(&attr, msg)))
+		return;
 
 	while (l_genl_attr_next(&attr, &type, &len, &data)) {
 		switch (type) {
@@ -5014,7 +5007,7 @@ static void netdev_roam_event(struct l_genl_msg *msg, struct netdev *netdev)
 
 	if (!mac) {
 		l_error("Failed to parse ATTR_MAC from CMD_ROAM");
-		goto failed;
+		return;
 	}
 
 	/* Handshake completed in firmware, just get the roamed BSS */
@@ -5031,20 +5024,14 @@ static void netdev_roam_event(struct l_genl_msg *msg, struct netdev *netdev)
 get_fw_scan:
 	handshake_state_set_authenticator_address(netdev->handshake, mac);
 
-	if (!scan_get_firmware_scan(netdev->wdev_id, netdev_get_fw_scan_cb,
-					netdev, NULL))
-		goto failed;
+	if (L_WARN_ON(!scan_get_firmware_scan(netdev->wdev_id,
+					netdev_get_fw_scan_cb,
+					netdev, NULL)))
+		return;
 
 	if (netdev->event_filter)
 		netdev->event_filter(netdev, NETDEV_EVENT_ROAMING,
 					NULL, netdev->user_data);
-
-	return;
-failed:
-	l_error("Failed to properly handle the ROAM event -- submit logs!");
-	netdev_connect_failed(netdev, NETDEV_RESULT_ABORTED,
-					MMPDU_REASON_CODE_UNSPECIFIED);
-
 }
 
 static void netdev_send_sa_query_delay(struct l_timeout *timeout,
-- 
2.42.0

