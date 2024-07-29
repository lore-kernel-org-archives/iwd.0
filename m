Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497BB1487EF
	for <iwd@lists.linux.dev>; Mon, 29 Jul 2024 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257062; cv=none; b=nOJebibsj8Hao3MtTtXYdqIS3rd+j04w/iHrD5aBpQSiy1zYmh/p3ed2F0mw1aHi17Zw57OKGFiZg1HHKi0xNGoC3pJ33InQ+CcHE41ZGuqO9dnI6GjjgdZF6sUZtdPGNB7nFyChLFr9hyz9JKcWwSmaWUaGjeBCKvcgAunuV3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257062; c=relaxed/simple;
	bh=9eJ8l+OYeZPhw+5/ItVYu1yZlS49AMV+Qiay9rtAZ0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iHQE5Np02cueSHt/tfPeoG2zs9E5DnbkXiPZJPnQr/Ly75nWVRxHalV4Lo1R20a0bQ3wFJMwbddEaMqpdxxB9354Nmdv1EG9nsDFYhLfSu+IxVfgr+mv8/p5NSYpe7tbbVt+5PVtTEUOIHfO4Z9GBCnqpYEX0SEatyatti/hb30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQXi0v/V; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQXi0v/V"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b795574f9dso17534586d6.0
        for <iwd@lists.linux.dev>; Mon, 29 Jul 2024 05:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722257060; x=1722861860; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XqzRrcsOWy6k4wsW6OBmYdNAeAZ/1tJMTg0PuJyMZk=;
        b=TQXi0v/V1WqRXbvR6a2M7QgerwGryeScyRHw8B6n+6K8y7hd4N1sjFOhywQouXWarp
         Pma6Dy4BrqMBuZ9APQe0wURfRA+t7ioJLxnnmy424ribgR18akKckBB8wrfNO9S1zsv7
         ms8YrqBuVdJMzdvu9SbIftqGQ9UMDphQb+fqmRENx7tLL/yAZhHQta8tau3mrCU7bSHq
         EMX4jMmF7F3qtBhiFs8zUfOS1ZosZzarBjUo/SyK40d0yN5fjNxFFoJUhwRJqnucvylj
         HJEfXoa4SkN3zrYItmxgSQneeyUxGaZ6mAOnlOdOPKeJBYzXcLSiiYA860Y0zSgVvLNj
         syeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722257060; x=1722861860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XqzRrcsOWy6k4wsW6OBmYdNAeAZ/1tJMTg0PuJyMZk=;
        b=YGuk5jNpIF2OA4Ha6JDk8oC8VQa6lWxyr7katWoJfasKKXJgdd57zIcTm4faPTWtmd
         sqvJczRDR+RdlAEgi52eHWniJn7sf4nHJd/DgnlpfegomIu2DGm4v6CZRMu/cFwkC8OZ
         +PSsGmGxE2UByJeWC98Wxwj4BMIVkbBZJU5c53XqucyZo1tdw/DdxudQPSCUrjq7LU7s
         wO3gXGZaFSlVyOc5f8beRGqQaBfdCPr7BOOewTOa3qg07D4ux+QXeapDiheO8TTQT2G4
         1CrtKpplKe6H410rnQVXyRXhWNaQ3UiSal0PkMetQcOFgITk0s9I4N8xJyXXNisWq0n3
         JIlQ==
X-Gm-Message-State: AOJu0Yymj2b8pZ5F0bq9wPFTaeHr0di76Y1XUJKzcC5VvQLJr8PBDghZ
	w3ELBYlhPYuw6phC4F1mPH2DkGdKzXpeDOzFJo84hGTXljso02+9uDBtxg==
X-Google-Smtp-Source: AGHT+IHFD4FaqMGv0bdiqNIrOEdrEIxHb8TdAFsmbunsNPWeXrqnf9wbwI+nxoFXoxX4JPs6cW+khg==
X-Received: by 2002:a05:6214:4105:b0:6b5:e5fc:b8dc with SMTP id 6a1803df08f44-6bb55a06c43mr90508336d6.15.1722257059875;
        Mon, 29 Jul 2024 05:44:19 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8d84edsm51171266d6.14.2024.07.29.05.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 05:44:19 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/6] netdev: store signal threshold in netdev object, not globally
Date: Mon, 29 Jul 2024 05:44:06 -0700
Message-Id: <20240729124410.1763549-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729124410.1763549-1-prestwoj@gmail.com>
References: <20240729124410.1763549-1-prestwoj@gmail.com>
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
index 2d70fc38..db1ad380 100644
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
@@ -6164,6 +6168,8 @@ struct netdev *netdev_create_from_genl(struct l_genl_msg *msg,
 	l_strlcpy(netdev->name, ifname, IFNAMSIZ);
 	netdev->wiphy = wiphy;
 	netdev->pae_over_nl80211 = pae_io == NULL;
+	netdev->low_signal_threshold = LOW_SIGNAL_THRESHOLD;
+	netdev->low_signal_threshold_5ghz = LOW_SIGNAL_THRESHOLD_5GHZ;
 
 	if (set_mac)
 		memcpy(netdev->set_mac_once, set_mac, 6);
-- 
2.34.1

