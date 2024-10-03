Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501F5148823
	for <iwd@lists.linux.dev>; Thu,  3 Oct 2024 12:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727960307; cv=none; b=q0KlHfE2Sj0uM7gO0XQpvpmLE4HPB2LYLWlGBnReQdPJZKacoDcgJUJMTTXZznRYzjab4IdBJnqohPwxRtqmjoKsC5y+WZNQ9e0Dc8rzaf4qQa5dWlkhlw9a345eOuzY23LOEVhGCeP7WeVL4YcKUpaHu5NvufwuC8oUT86rD9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727960307; c=relaxed/simple;
	bh=PUPkD8+gG/4qMB1Hh/KfTEFGVuh/NNDZ6/hVNrVFqmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IzCWd+8XKaKs/PIr57hFViL6LalKZTW6HZ501P14cDXYPf8DpYmA9A9g2F4QYRvFVufNKt3kT+PNdqxjQsn+QyzzYKOibM3aaS/T0aypYvATpG7FFecoe90dmTwgs0z88dJhbiSXDZQHpUpksgxPjAF0stzBs7d6GsifsnKU9Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPmio+SZ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPmio+SZ"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37ce14ab7eeso828211f8f.2
        for <iwd@lists.linux.dev>; Thu, 03 Oct 2024 05:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727960304; x=1728565104; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g5YttcIQ7Z7hz8aSAg6KRrCMAtmbQrEBthycJp553xs=;
        b=QPmio+SZiVOJhIcKHkd9c9z8pbw31BPEZdu+LZv6+/yrN77BHWa3/fVXmexELl0xA1
         nAVxwpMN4vc8WsNJLElejUmUa5eToFjXmuAbqwHTakpLbkLAj2MlzmAkzj+qQhM4BB4l
         RGpCPgQExtHmzLMHz4xrOSVYNqPlOHgVMLgdJuVcRyGqjedICEDJti2+hUvNSOC6wGVq
         JRf9sOxq1rLmA+afOIXQT76UhldkIZtXG7/2ditaPCxi1XaWV7jDm1NEIAtpwM57j3II
         wYwvMKhgNv6xrYbnWcGdirqKK36lpM5sQ4whX6zwmUbs2vSEgafqWjI+t/Z7KxZCWF3b
         iWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727960304; x=1728565104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g5YttcIQ7Z7hz8aSAg6KRrCMAtmbQrEBthycJp553xs=;
        b=emR8ZMlYXdU2tk29KW1sTy/TDfPYekdyqvTbs8OVjDQAFgmYPZAZevbtKZx+J+heP+
         KCPu95INxju7BLArWkhhVMG+CwRM1akNx83RsTsTQs2UiWFijDeSBPRSDvInkvpi2rv9
         /rtNEeMYpkNESc1ls1QiuFo8qGvHQ8TVCvUiOEOF2OlHB4Aiw78wVYKWzHlpcy3k4kNh
         I+ApxB4MhnrLqvJ872OaMvkH3wV0PxmwE/UcIGxa1sp8MImBHTXLkCkik7N3yFOkHjnL
         V8HDkThFy5UjP+flAtZEcJfgoI3q8l7ALJim7iDHd8c+Bk7OXPviLOsUh+bYpz5Sqiv2
         k3Cw==
X-Gm-Message-State: AOJu0YyILtywydBXKIDwY21ngJ2H3LvpXMnjtxBDj5EKVyqXzzcMBr74
	wwDHU7TNzs+73TdKV8GnjBwoHnU9CSyb1/WFmoBvgRmW9OKIpt4qNlsUqQqe
X-Google-Smtp-Source: AGHT+IGsT+vbyaYuvDYOhO9Gi+kKqu8z9bM3VgGUxUqjBOVkkXBCa0QrerloQ+SveCvl46dEo5iHdg==
X-Received: by 2002:a5d:58d2:0:b0:37c:cea2:826f with SMTP id ffacd0b85a97d-37cfb8b562bmr5470992f8f.2.1727960304008;
        Thu, 03 Oct 2024 05:58:24 -0700 (PDT)
Received: from LOCLAP699.localdomain ([81.145.46.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d08242d79sm1219222f8f.51.2024.10.03.05.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 05:58:23 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] netdev: fix crash in the RSSI polling fallback workaround
Date: Thu,  3 Oct 2024 05:58:17 -0700
Message-Id: <20241003125817.75004-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prior to adding the polling fallback this code path was only used for
signal level list notifications and netdev_rssi_polling_update() was
structured as such, where if the RSSI list feature existed there was
nothing to be done as the kernel handled the notifications.

For certain mediatek cards this is broken, hence why the fallback was
added. But netdev_rssi_polling_update() was never changed to take
this into account which bypassed the timer cleanup on disconnections
resulting in a crash when the timer fired after IWD was disconnected:

iwd: ++++++++ backtrace ++++++++
iwd: #0  0x7b5459642520 in /lib/x86_64-linux-gnu/libc.so.6
iwd: #1  0x7b54597aedf4 in /lib/x86_64-linux-gnu/libc.so.6
iwd: #2  0x49f82d in l_netlink_message_append() at ome/jprestwood/iwd/ell/netlink.c:825
iwd: #3  0x4a0c12 in l_genl_msg_append_attr() at ome/jprestwood/iwd/ell/genl.c:1522
iwd: #4  0x405c61 in netdev_rssi_poll() at ome/jprestwood/iwd/src/netdev.c:764
iwd: #5  0x49cce4 in timeout_callback() at ome/jprestwood/iwd/ell/timeout.c:70
iwd: #6  0x49c2ed in l_main_iterate() at ome/jprestwood/iwd/ell/main.c:455 (discriminator 2)
iwd: #7  0x49c3bc in l_main_run() at ome/jprestwood/iwd/ell/main.c:504
iwd: #8  0x49c5f0 in l_main_run_with_signal() at ome/jprestwood/iwd/ell/main.c:632
iwd: #9  0x4049ed in main() at ome/jprestwood/iwd/src/main.c:614
iwd: #10 0x7b5459629d90 in /lib/x86_64-linux-gnu/libc.so.6
iwd: #11 0x7b5459629e40 in /lib/x86_64-linux-gnu/libc.so.6
iwd: +++++++++++++++++++++++++++

To fix this we need to add checks for the cqm_poll_fallback flag in
netdev_rssi_polling_update().
---
 src/netdev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index d298977a..8379a598 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -769,11 +769,12 @@ static void netdev_rssi_poll(struct l_timeout *timeout, void *user_data)
 /* To be called whenever operational or rssi_levels_num are updated */
 static void netdev_rssi_polling_update(struct netdev *netdev)
 {
-	if (wiphy_has_ext_feature(netdev->wiphy,
+	if (!netdev->cqm_poll_fallback && wiphy_has_ext_feature(netdev->wiphy,
 					NL80211_EXT_FEATURE_CQM_RSSI_LIST))
 		return;
 
-	if (netdev->operational && netdev->rssi_levels_num > 0) {
+	if (netdev->operational && (netdev->rssi_levels_num > 0 ||
+					netdev->cqm_poll_fallback)) {
 		if (netdev->rssi_poll_timeout)
 			return;
 
-- 
2.34.1

