Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B6A18BB83
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724436021; cv=none; b=iFC/0TFpuwjrgxRQTkxkoe5BeUodJwa41KBFjpCJkf8DcMjDVa6ZzdRRYtvd36bjtllZ+e/0QcCzwd8qmT9mqhp5/Mtavvy94WCpTuDFE1oM+YSe1dfheByUg5+L6fBGvq4Ywp9NZNftNyoWRXnxSqsUYAIc2xsiyNpxpIldMB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724436021; c=relaxed/simple;
	bh=btwTRtLqSGcWqZ6Ne9I+fe1S4wcBvGWmUpVBKLImO7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dHfpEaBdcVwwNEa4AvpJaXMmG2Yf4xJ4oeQLJuFpCLXvM0V9R03nLlDC1xvu1Wpxsaf0vJvGYNmhFzFK7kPdz+ChhwN0JX3lDAIKM7mz/vvOZhTuSf7BTI1lpq1478lS6tBFB4viviGr2KkM7z1w18BaPGqE0UxG+kcvSNVMjsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnwUDVdC; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnwUDVdC"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5da686531d3so1675168eaf.3
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 11:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724436018; x=1725040818; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/gRqrTjMi6ShOPOHtkjCdl7RgioLdEkQjLXtXh16+U=;
        b=WnwUDVdC7r5xGyZE6nGQvjOCjSw6pc0j718eVQu0x7p5C7gyqX7bcS/Ud2+j+W3s3k
         wwLKB4aGml/oK+mxl0xmJT8gLksVI+NMUg2Z4V5yZm/t1yXoKl7rRzjZjudmMNkNX3qj
         zeAy/L6r/az/kRUECFLUvsPex4kGjIfGjxMkFDH5oqYfo9YP2GIBPiLZhjOBXlgnYkTI
         C51JRlw7lCMAU1D5axFBNGm3Ce8Oirghc762E8wwNMjX075tObhSNyFyn3hi6mdYfMFa
         ELkbReh+PnGoDK+aPLmdqni+IMnkAy673SGRMUzGlNLOGJWLaaSS4wQyDeHuer0Yi5M+
         2f9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724436018; x=1725040818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/gRqrTjMi6ShOPOHtkjCdl7RgioLdEkQjLXtXh16+U=;
        b=fpWN3/+WqNDfdWTXwxJ6ubystybfm0l2lPe8VH+ugHsG4ONcIPUZ+ResHdwok8HCmq
         bwlRl8j3M0KHvPZk7jftUF5dHJjHFNIf+TJ+eQHVb6xqVJ9A8sPhYAsL7+Gt8eHfnwYn
         woIE17Lq/O4dXIMsot8IouVXtpAQtGqblbdxji0zgHiHLyRfq8LRiVcZiK6mtBl43HVS
         /yn1NS5m2pP/DQYmAzS1zLsGaedtJgesAQ8AnR5Ef6hBhby4ydSwbrVdPyP0JC17d99v
         p16PAru6q0KEofv/+0WuYOy3aX/JYsYoCj+0tWf8toW/2s1e2MQ8BXSQqhK2gF0XS2ej
         bEMg==
X-Gm-Message-State: AOJu0YwGRzrNa/vM9uh55kbBnBQmSF+Mpx8KRXj/YQ/7kIdFOjzsJt0X
	CDOryoT7haN2HF0DQcBx7mkcKv86OXcm7dj9AIZg52TJGrHg4bUPmFn6Mw==
X-Google-Smtp-Source: AGHT+IEI/bfkUIU+TUk5wbyhDsTOAfJE2AHITDR5iNf83MEB+46DJm/FiqrHunwVIA5rkl18+ETFhg==
X-Received: by 2002:a05:6808:bc7:b0:3de:ed0:680 with SMTP id 5614622812f47-3de2a86ef6emr3007531b6e.3.1724436018252;
        Fri, 23 Aug 2024 11:00:18 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe0f0507sm19683131cf.47.2024.08.23.11.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 11:00:17 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 3/8] netdev: store signal threshold in netdev object, not globally
Date: Fri, 23 Aug 2024 11:00:01 -0700
Message-Id: <20240823180006.317353-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823180006.317353-1-prestwoj@gmail.com>
References: <20240823180006.317353-1-prestwoj@gmail.com>
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
index 4d6aae6b..e392c654 100644
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

