Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814233CB56D
	for <iwd@lists.linux.dev>; Wed, 29 Jul 2026 20:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785356026; cv=none; b=OY9TU/Wjt+rfuH4hTX4/7iASvgXFsDoxLCM1FYSNrqsX2jvpHOLIWulfJR3P2EEQOLI9fWiF6a5aZlKcSWpv4AHSLddHDBxq0SQIUmdQpGXMfVSdaOGXa34fhIUsr5Y45GurfiPQwyvuRP3yl7daMoNFxGPmWiS5qlGoJv3uMOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785356026; c=relaxed/simple;
	bh=SPfw7nrU+nLXgZNuuwrxj4kRoXQ9dK962E/WP0YZLyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P6K+rWhkArjUbPfwkgQStyKVO1AM9DjPDbTQCw+v/SkGkgMmw5BT301D5auFilwyRH8WXeAnY7ByRwZV54+opBzo7Q5vypOY3DCK5DvTNNOl5UaxwKn7XZkadE+7sQbMBC0yCL59a6dmBLsBUXuw4atUaxuo1OYEgHhr/Jnal8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIL75YEs; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIL75YEs"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso15984925ad.1
        for <iwd@lists.linux.dev>; Wed, 29 Jul 2026 13:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785356025; x=1785960825; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dfQanY//vYFcvfP/Xq5qzeVhdKaJUoFaA/dfl3/bX08=;
        b=YIL75YEstiGyjj1ZwZ09yV9heQoM7P/kZu7G1lKJHISKvF0hSkF29hoBl7WJHX9OhB
         2ssi91SGNR0sjBYzm7eZ20Z3jp5Akg/IqC37QgZ4uQHEfyPUH+mPXThxkqSvar+sriqT
         rb7GhRSfleJ1yRE8L6QTWvEt4at1/pPVyu96CgzwHE1lYj2zwVZkltL4QKIrCueXFrMd
         PC9gxuTzxFyHcbnwKN2FHcpPc3mIq3bVPs3rMkA+bS7wANQDWibQIwOoWlkiJUmZMJJc
         cS7SuGGl6+Z+Z53B24oAJmdV09cYj1tgpMSbjnGz3LsJkLGrUwgCDR9ghM1DIYa0JpfI
         D03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785356025; x=1785960825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dfQanY//vYFcvfP/Xq5qzeVhdKaJUoFaA/dfl3/bX08=;
        b=QrqKUeOnC/tjh/asIETYqXqXAMEcNUIiAf7P7Zv8p08OzsOlv/9eSbqcrAJYlQSNnk
         v4ZLHsPUdUX2W+2xdU7SVbfLbHuULgcz0icaPKken2dffhqABBfqjo0n19KmHph9UIS/
         WypBCGcQGb9g0tBBDSE+3mNoyzgpRGIHLn+N8tuz+CfmYTSDrHAjpzmoxZR3jkibICM7
         PTrWkEO+hdnTysaXKsNQmmTzEZqasvy8gA54vNKdbViEUWznJFwxlau8LvNPw2KYZt5r
         aW+TnNwpIwk3fLIJVgCaaSupT43MsHrKQV7B/nY3ojKjgW50bhmR0BJDIrtLVM3eGXyQ
         LBgw==
X-Gm-Message-State: AOJu0Yx/HSbf41/7N6a0OcYe2fa6I+2TyCFsOeiZv18ot201BKgPLnAK
	rHxQ2xal2rNDUK9VHulvcD5rGQ5H6QKeyBIKQaRkBC1kt5MrVqBCtFpL5Td39JlEgRo=
X-Gm-Gg: AR+sD13OY65ds3+r2gMH0MSvL/Gi5MUUrZiSzyCEAoGPeFdoALzGiPmTeMDJ9BQOX9M
	OE8bnEvwHy3caiD/h5hWOv9W5RQ4Yo4Qv85dGt9ZN0USp3YapPfqFBDVH9c0CxT0kWB8iOBVjFO
	9uBum5hFrcvR6WwV4JZwOnhcKTW0M5hX5n5POEstefYXIsLGxwAzk0fHI0ZRm+HKPio6RKRZTX6
	nn7yzRScrCsNSSnAIlcDzwCIovBpRvfpezW2AZQqpE8zPmyEuA2sBkJJRoh//IKcXq/UkvX88mH
	646SYSkmV6HfwcjSspXwOxatIxg66eceXBrK3DOFwofJ+kVxRdjd/MWlYogC7Iim0/+GSM/yc3u
	szaeDnl+mqFsuonLg0GO0hbn25WwqScptGNf+NGzwtlupmDIrh0eZPRI90fOBVAG8/IXIPHVkbw
	bpKJq0qDFxv9uPS777UasDHscq+OESqtvQBNSBNwNu+3YzYD9Chr7kx7emjo8=
X-Received: by 2002:a17:903:1786:b0:2cf:4339:aaa with SMTP id d9443c01a7336-2d033b11ce4mr2991955ad.12.1785356024637;
        Wed, 29 Jul 2026 13:13:44 -0700 (PDT)
Received: from arch ([49.204.97.234])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d37368sm23550885eec.22.2026.07.29.13.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 13:13:43 -0700 (PDT)
From: arpan <arpanpramanik015@gmail.com>
To: iwd@lists.linux.dev
Cc: arpan <arpanpramanik015@gmail.com>
Subject: [PATCH] netdev: Fix premature ECSA channel switch timeout for mt7925
Date: Thu, 30 Jul 2026 01:43:16 +0530
Message-ID: <20260729201316.85499-1-arpanpramanik015@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mt7925 cards get stuck and disconnect during Extended Channel Switch
Announcement (ECSA) events because the kernel considers them stuck.

This occurs because the kernel sends an imminent channel switch
notification (NL80211_CMD_CH_SWITCH_NOTIFY with the
NL80211_ATTR_CH_SWITCH_COUNT attribute present) prior to the physical
switch. iwd was previously ignoring the countdown attribute and
immediately initiating an active scan to re-query the AP. Sending a
scan command while the firmware is trying to tune the radio causes the
mt7925 firmware to time out.

This patch adds a check to see if the countdown attribute is present for
mt7925 interfaces. If it is, we wait for the second notification (which
omits the count) that confirms the switch is physically completed before
proceeding with the internal state updates.

Signed-off-by: Arpan <arpanpramanik015@gmail.com>
---
 src/netdev.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index e639a1f8..96b48ac3 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -5428,12 +5428,32 @@ static void netdev_channel_switch_event(struct l_genl_msg *msg,
 {
 	_auto_(l_free) struct band_chandef *chandef = NULL;
 
+	uint32_t count;
+	const char *driver;
+
 	if (netdev->type != NL80211_IFTYPE_STATION)
 		return;
 
 	if (L_WARN_ON(!netdev->connected))
 		return;
 
+	driver = wiphy_get_driver(netdev_get_wiphy(netdev));
+
+	/*
+	 * If the channel switch countdown is present, the switch is imminent
+	 * but has not happened yet. Wait for the second CH_SWITCH_NOTIFY
+	 * event (which omits the count) to avoid interrupting the firmware
+	 * by prematurely starting a scan.
+	 *
+	 * Restrict this workaround to mt7925 cards as requested.
+	 */
+	if (driver && !strncmp(driver, "mt7925", 6) &&
+			nl80211_parse_attrs(msg, NL80211_ATTR_CH_SWITCH_COUNT, &count,
+				NL80211_ATTR_UNSPEC) == 0) {
+		l_debug("Channel switch imminent in %u TBTTs, waiting...", count);
+		return;
+	}
+
 	chandef = l_new(struct band_chandef, 1);
 
 	if (nl80211_parse_chandef(msg, chandef) < 0) {
-- 
2.55.0

