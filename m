Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1459B186E2A
	for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 17:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724089924; cv=none; b=LxKjsXYN84MERRXggHJkd8Pgt7v+xpqN2PQGn+U9TZ+WcyxkoNzqcs3MsosdslREsiaYimYUqJESggOLEctNWW+ctrGZKLgWZh1qhKoWjzAUhPZlPkCrxfDt6mRqwp2j76eUkTKEgO+nQ+sP8qukqnG/BUL9fTNcB2Z9MO55bu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724089924; c=relaxed/simple;
	bh=3ACyH0wBcHI5aXAjWAcnc1ZlymMSvIai99xD4di9yuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J1YUdoqi/dg8jsYWNjSBwPTyhDjGlvLSpFYZ8jTfbvr2KByAm64JPjB2+wDIrT/PtilnqCjBjY67aavjuaNJvFQX7d1WYB6EOq/9NAmjGC8dcYqXVouMJozq+s52b2NH1eyhaK6sP7xulH7+aLY6DtvJLwH2k7uGb48ACaHm9NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZxBP3Up; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZxBP3Up"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a1d7bc07b7so319906685a.0
        for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 10:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724089922; x=1724694722; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lU2YFi0z6iWwdFzjptg9xLGk32SzO7YL037hOMc5X4=;
        b=SZxBP3UpRhLYy45U1KZKGj8oQAzdkALf3t+wJ7U/gTerFeFTkh9N0R/5FyHl+uM6Wu
         EEClRWr40c4mY6R4SvCZQnetynEsCpfpG8OVADkhaF3mwIduIod0K63aU4csnu8PmdpO
         pYEY/zhhCFL1Ws4m0hrbksPe2lE/AEy5TpWwlusJM27ZsH5m/yMLBAfyW7ETY8LKhZJb
         HH+cyIoeohj5Q7NzPWBe9NyzUuprV8E1osH+PJhc1KOvmSrlND1T7a9rOdaYjEAp6FRR
         6HXFfPd6QahoibHdDzP8NwkHw7yqL6npebmbIPXTNH3A8yzaJvIeQwEjpmWK2cRAwhqR
         M6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724089922; x=1724694722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8lU2YFi0z6iWwdFzjptg9xLGk32SzO7YL037hOMc5X4=;
        b=mD2nC/9W8FHulvzOPbm6D8f/MjnPQgqFbmNFipy9LbLVKuYPp9kPXP+PzavkAk1bCe
         T4eFEqM1P71YXX4Dok2M2zDkLdBjVS2okL9ZgjyJWiAi+yb47F0kjR3nfSW9JDt8jiuA
         mr5Z6Tz8cASMySN6XVFOj7gtR3wrT+jfilHQZ3Yn9okIgSOLAdI8xA6wDkMpMLyR2z1Z
         iu1biWQl8kazHxxPl5s8JBicMzd16yAnA5L8LA5iQtk0jAG0WGEw10TO1QIshakk0emz
         mshP2GMvQg6Rt4JYoo2+ShmY8RbKcmkoS2t5nw//wr6pKF4FcNtZM0WwCCYBCm2od+J9
         us2g==
X-Gm-Message-State: AOJu0YxkgAmLlGAwA2l47EcN/Vb72EiorZdVREL1h9H2s0R8i3T0KKgV
	cgsBKrFBDBdMGrbK2cOOASgfdRD524ObpnYxf1/4LwCmvJXjpCPKeLgqcQ==
X-Google-Smtp-Source: AGHT+IHb6kP5wr4lTBk/E3/j1KQalFpGLWGxF7dNAoBGCIQycyXcOUbzbr1scR9kVlNBm91Y8BffsQ==
X-Received: by 2002:a05:620a:438e:b0:7a6:684f:c07e with SMTP id af79cd13be357-7a6684fd42amr24243385a.19.1724089921730;
        Mon, 19 Aug 2024 10:52:01 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0e5a1csm451854685a.74.2024.08.19.10.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 10:52:01 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/8] netdev: store signal threshold in netdev object, not globally
Date: Mon, 19 Aug 2024 10:51:45 -0700
Message-Id: <20240819175151.1310546-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819175151.1310546-1-prestwoj@gmail.com>
References: <20240819175151.1310546-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This prepares for the ability to toggle between two signal
thresholds in netdev. Since each netdev may not need/want the
same threshold store it in the netdev object rather than globally.
---
 src/netdev.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 494e46a5..a9648fbc 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -172,6 +172,9 @@ struct netdev {
 
 	struct netdev_ext_key_info *ext_key_info;
 
+	int low_signal_threshold;
+	int low_signal_threshold_5ghz;
+
 	bool connected : 1;
 	bool associated : 1;
 	bool operational : 1;
@@ -206,6 +209,9 @@ static struct l_genl_family *nl80211;
 static struct l_queue *netdev_list;
 static struct watchlist netdev_watches;
 static bool mac_per_ssid;
+/* Threshold RSSI for roaming to trigger, configurable in main.conf */
+static int LOW_SIGNAL_THRESHOLD;
+static int LOW_SIGNAL_THRESHOLD_5GHZ;
 
 static unsigned int iov_ie_append(struct iovec *iov,
 					unsigned int n_iov, unsigned int c,
@@ -1058,10 +1064,6 @@ struct netdev *netdev_find(int ifindex)
 	return l_queue_find(netdev_list, netdev_match, L_UINT_TO_PTR(ifindex));
 }
 
-/* Threshold RSSI for roaming to trigger, configurable in main.conf */
-static int LOW_SIGNAL_THRESHOLD;
-static int LOW_SIGNAL_THRESHOLD_5GHZ;
-
 static void netdev_cqm_event_rssi_threshold(struct netdev *netdev,
 						uint32_t rssi_event)
 {
@@ -1089,8 +1091,9 @@ static void netdev_cqm_event_rssi_value(struct netdev *netdev, int rssi_val)
 {
 	bool new_rssi_low;
 	uint8_t prev_rssi_level_idx = netdev->cur_rssi_level_idx;
-	int threshold = netdev->frequency > 4000 ? LOW_SIGNAL_THRESHOLD_5GHZ :
-						LOW_SIGNAL_THRESHOLD;
+	int threshold = netdev->frequency > 4000 ?
+					netdev->low_signal_threshold_5ghz :
+					netdev->low_signal_threshold;
 
 	if (!netdev->connected)
 		return;
@@ -3585,8 +3588,9 @@ static struct l_genl_msg *netdev_build_cmd_cqm_rssi_update(
 	uint32_t hyst = 5;
 	int thold_count;
 	int32_t thold_list[levels_num + 2];
-	int threshold = netdev->frequency > 4000 ? LOW_SIGNAL_THRESHOLD_5GHZ :
-						LOW_SIGNAL_THRESHOLD;
+	int threshold = netdev->frequency > 4000 ?
+					netdev->low_signal_threshold_5ghz :
+					netdev->low_signal_threshold;
 
 	if (levels_num == 0) {
 		thold_list[0] = threshold;
@@ -6163,6 +6167,8 @@ struct netdev *netdev_create_from_genl(struct l_genl_msg *msg,
 	l_strlcpy(netdev->name, ifname, IFNAMSIZ);
 	netdev->wiphy = wiphy;
 	netdev->pae_over_nl80211 = pae_io == NULL;
+	netdev->low_signal_threshold = LOW_SIGNAL_THRESHOLD;
+	netdev->low_signal_threshold_5ghz = LOW_SIGNAL_THRESHOLD_5GHZ;
 
 	if (set_mac)
 		memcpy(netdev->set_mac_once, set_mac, 6);
-- 
2.34.1

