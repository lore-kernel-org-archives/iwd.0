Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A7819258E
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 22:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724451831; cv=none; b=IXGxj1RmX2bqaPbrae/IZVsoIf2Gcs/1mmzkd4Ki1m+OJefvF8VPVLpYpzBNGhebstHeFRszFHYamBh/4Fmcmdw7UzDfuCC8s0EkwlXr2KH01zbhVYmFumfontc3vYYqj2pI47tzc9C0+kwS3DP8v2CwLQNaBLV2lFjzc4fUqc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724451831; c=relaxed/simple;
	bh=z+bl8P9tasSSgCV215ezjlQmwF+2dwLJO7xYWwGBxw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rJN9rggIRtBVW71doqRAoy/u+I9n6ycgUlsXTxTufmN/+MuaWGBKEQdIKwIJ0Ni0KdryxqLNJ5cbZl3jAfMZk97sOXJHpv2uA+V+2oA5+4VuC9Addl9zwLIxlb6aSgIR+5N3gM3I4xuHjfuesLxPf7K4lgtYK4CaZGTonbmGEyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGqjgwhf; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGqjgwhf"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a1dac7f0b7so151879785a.0
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 15:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724451828; x=1725056628; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JROQ45N1DyPYU2xjIBnwVw8kQ1vHiF8U1ksLO+jJbZg=;
        b=IGqjgwhfInRGQGIyzYLzsr8s04L5SGqJrbqdpkHxZg/tp1fqfrItpd17r3mtKS1EXG
         KTiqPMPGS/FlaT/YRr//Q41iEWI4VbhTfWsIA4oQ/Ne5fPS5OeOnPvBkrNpet7RaOmfD
         68NF5jkP+1noP2MtfrU1BmtWhvsncUcpk+M1UYDXnW30lL12kSh4F1ITEpZUbQ06CbOW
         iIlFr2SccJHR+j5g1sPM0RnScRUJeL0YEMa88VIRzXN9ax0RlkfntVsrajQWZfrr+co3
         uOsrl4M2aavKCthDZIKNW+OP+hCz/JQwlwSsZeP8AMJFRwGpUTB/kAEYgPF3wVOM4+Oh
         GWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724451828; x=1725056628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JROQ45N1DyPYU2xjIBnwVw8kQ1vHiF8U1ksLO+jJbZg=;
        b=t+oHWTaRyxCDvw0XDiLfCkKNOej3P8AHbt/s/+ickd+ky9XhIkzn4NrOqEpLdDv+wn
         dg4vjJbuDJXCAF30eVPBK4kLJciykkugE2eDU76FkdmwooV5bd6qAUgjGJAhf60JjqMZ
         la3HtUksM6OS7KxN6A1yceUpmnQ3pJgsB1i1pAxLVvxuLCOlXgNu6uGCYyjaVUq3SrNc
         ZCZb+XgYbgPj89y1yf8fFiA41m5oCiPRfyN+nqyWkyw/tTp0kj03p65mCPtWn1ZU65Bt
         AN02dU6i7LpjSvaBU1xE97+XIM1FCj8rMDP9joMeMkHaGsyJ5ljK9MgLfIT8lErj098n
         fDJQ==
X-Gm-Message-State: AOJu0YxLVqD3Fmb2Hpj82l49V/+URd9eHezNiOCqbxifzMt72d1wOp5o
	N10/Rnb/ZgDliii9xMyxFqLvZp7HeqocBii4lcYB0hgc1ODQP/YkZbhGNQ==
X-Google-Smtp-Source: AGHT+IGcXzaqCnrMzWy5J5uuLEzmgMzGwKzEM5kJPhqmVxTkXjomNWZKsXJf9I7UuNSIvaSjV3e1UA==
X-Received: by 2002:a05:620a:1a9e:b0:79f:1873:5463 with SMTP id af79cd13be357-7a6896e3d4amr472894185a.6.1724451828321;
        Fri, 23 Aug 2024 15:23:48 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f41f507sm218860385a.132.2024.08.23.15.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 15:23:47 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 3/8] netdev: store signal threshold in netdev object, not globally
Date: Fri, 23 Aug 2024 15:23:34 -0700
Message-Id: <20240823222339.328006-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823222339.328006-1-prestwoj@gmail.com>
References: <20240823222339.328006-1-prestwoj@gmail.com>
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
index e0121095..1f1b9400 100644
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

