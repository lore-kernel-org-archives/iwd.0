Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4201474CF
	for <iwd@lists.linux.dev>; Mon, 29 Jul 2024 12:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257063; cv=none; b=Ca2gavoZ3eoXbWmeYOxQ90irFMZZToQvNESbkVeAwq+XIox3F3ZlDsoMnxnTU0S+nC4dW5zZCtiSKow/iE9SrK9w4+apNeS7tJLzH25LZutYqzJFUO+HXVJIhbx/YJTTRak+ZxAM95ZhTo95PVIbs9PYe6H6ibpUWMy8P7xu4/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257063; c=relaxed/simple;
	bh=ZMXepfIOR5PDI/Wwo7y82bfrh6nXGBya/TTZVzj68w0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b9GaE2jxYn9EtXbO/ZVFScANEgaEdo0pGioaILiQyMeonDZqy3KXTyn9RUqCJiHNX0uEA0uxO7HQociDXKOdTO51IjXVz5i2CyY2MgN1nTad9PbK5hwS9pn0SIsFOR2mKNvjTJoBwiIto0kjw7otNVyalut4oXoBIofD0bp/FRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCtYpdq5; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCtYpdq5"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b6199ef089so19043906d6.3
        for <iwd@lists.linux.dev>; Mon, 29 Jul 2024 05:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722257061; x=1722861861; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BK/zxYy03R51FquWBPz7yeXqzJ59CvYxYqHnWf2zW1Q=;
        b=TCtYpdq5JMcHIDc0sMN8pmc7jrKIiiB7PcLjTwZLPUtlkiXYfAM8R5OFKXnUIIwoCD
         uKEwyxR5jIKdgi0Qzh8ZcOCxli/ayon7w09nCZ1xdvkJiJJB6t/va74P0kqPQKOma3px
         Ca2agoVUhnA+z4wCaWGVx+lCBwman4/pBcEjZJ/HNA1ErBtM72c9D4FXEbFnBMTV5PqF
         ORGZvdUgDOlW+MEhdEo/Bizhv0SozylxCUkNqTKJ7n+d6THQ763VV2rUJL9A3poAFIlI
         KwIv7c0IsJGpOx44IyCFIc3/v86zQ5kcpJ8UXSS9XxALiiYGFfZVpGPBicDQP4AvyIXE
         qImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722257061; x=1722861861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BK/zxYy03R51FquWBPz7yeXqzJ59CvYxYqHnWf2zW1Q=;
        b=QbxsfTapd+hdqY6yDl73jUaVWJg6Thz5ht3ZCZuubZBvwcIAd+dyOwD2WT8fr8ZgC+
         Wfq4mZOF7xpif7y4g+ebGZWQbI6xfeAP4tacHLUlnBhm9IysH9qR538r/incbpdAU+rQ
         /9caC+WHGAMZ/9wIFsCLfdOErj2axxZ4GzARBmqShIz02XxuaLNYGzgWa2NOPeg+RR9Q
         gp/4KwSQRKvU0viddZjGtPnE+ZEYYjCN4PtaSpRLoOt/SASXgTu5PNyUPf8vva78BQg2
         d79hwvHV3wiWw24rbs4FTXZ9ByuNVM+6uEmb+g5W9q04lfeLKSNKQvTHGd6QRYCY16o1
         9P/Q==
X-Gm-Message-State: AOJu0YyxaTqAtIKwqHRU8rudSmHu1iXzzvmmFnImPUM7f8ISauyKJDkU
	SvwwYy+GyDhQi/kBIqbnNFzbfzfsT6XkfwpnrXnyX/8+h+F0R1WZuX1exw==
X-Google-Smtp-Source: AGHT+IFJqMwAID2zgqx04gvUAPwV3DGetR+zFE/3OXsCvP94FhWfz58jUJL1/7hEdSq1UJuCFLNT2A==
X-Received: by 2002:a05:6214:2a4a:b0:6b5:7f22:d7ca with SMTP id 6a1803df08f44-6bb5599a916mr80729646d6.5.1722257060955;
        Mon, 29 Jul 2024 05:44:20 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8d84edsm51171266d6.14.2024.07.29.05.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 05:44:20 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/6] netdev: add critical signal threshold level
Date: Mon, 29 Jul 2024 05:44:07 -0700
Message-Id: <20240729124410.1763549-3-prestwoj@gmail.com>
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

This adds a secondary set of signal thresholds. The purpose of these
are to provide more flexibility in how IWD roams. The critical
threshold is intended to be temporary and is automatically reset
upon any connection changes: disconnects, roams, or new connections.
---
 src/netdev.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/netdev.h |  2 ++
 2 files changed, 53 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index db1ad380..852ad569 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -212,6 +212,8 @@ static bool mac_per_ssid;
 /* Threshold RSSI for roaming to trigger, configurable in main.conf */
 static int LOW_SIGNAL_THRESHOLD;
 static int LOW_SIGNAL_THRESHOLD_5GHZ;
+static int CRITICAL_SIGNAL_THRESHOLD;
+static int CRITICAL_SIGNAL_THRESHOLD_5GHZ;
 
 static unsigned int iov_ie_append(struct iovec *iov,
 					unsigned int n_iov, unsigned int c,
@@ -841,6 +843,10 @@ static void netdev_connect_free(struct netdev *netdev)
 		l_genl_family_cancel(nl80211, netdev->get_oci_cmd_id);
 		netdev->get_oci_cmd_id = 0;
 	}
+
+	/* Reset thresholds back to default */
+	netdev->low_signal_threshold = LOW_SIGNAL_THRESHOLD;
+	netdev->low_signal_threshold_5ghz = LOW_SIGNAL_THRESHOLD_5GHZ;
 }
 
 static void netdev_connect_failed(struct netdev *netdev,
@@ -3674,6 +3680,39 @@ static int netdev_cqm_rssi_update(struct netdev *netdev)
 	return 0;
 }
 
+static int netdev_set_signal_thresholds(struct netdev *netdev, int threshold,
+					int threshold_5ghz)
+{
+	int current = netdev->frequency > 4000 ?
+					netdev->low_signal_threshold_5ghz :
+					netdev->low_signal_threshold;
+	int new = netdev->frequency > 4000 ? threshold_5ghz : threshold;
+
+	if (current == new)
+		return -EALREADY;
+
+	l_debug("changing low signal threshold to %d", new);
+
+	netdev->low_signal_threshold = threshold;
+	netdev->low_signal_threshold_5ghz = threshold_5ghz;
+
+	netdev_cqm_rssi_update(netdev);
+
+	return 0;
+}
+
+int netdev_lower_signal_threshold(struct netdev *netdev)
+{
+	return netdev_set_signal_thresholds(netdev, CRITICAL_SIGNAL_THRESHOLD,
+						CRITICAL_SIGNAL_THRESHOLD_5GHZ);
+}
+
+int netdev_raise_signal_threshold(struct netdev *netdev)
+{
+	return netdev_set_signal_thresholds(netdev, LOW_SIGNAL_THRESHOLD,
+						LOW_SIGNAL_THRESHOLD_5GHZ);
+}
+
 static bool netdev_connection_work_ready(struct wiphy_radio_work_item *item)
 {
 	struct netdev *netdev = l_container_of(item, struct netdev, work);
@@ -3884,6 +3923,8 @@ build_cmd_connect:
 	netdev->handshake = hs;
 	netdev->sm = sm;
 	netdev->cur_rssi = bss->signal_strength / 100;
+	netdev->low_signal_threshold = LOW_SIGNAL_THRESHOLD;
+	netdev->low_signal_threshold_5ghz = LOW_SIGNAL_THRESHOLD_5GHZ;
 
 	if (netdev->rssi_levels_num)
 		netdev_set_rssi_level_idx(netdev);
@@ -4257,6 +4298,8 @@ int netdev_ft_reassociate(struct netdev *netdev,
 	netdev->event_filter = event_filter;
 	netdev->connect_cb = cb;
 	netdev->user_data = user_data;
+	netdev->low_signal_threshold = LOW_SIGNAL_THRESHOLD;
+	netdev->low_signal_threshold_5ghz = LOW_SIGNAL_THRESHOLD_5GHZ;
 
 	/*
 	 * Cancel commands that could be running because of EAPoL activity
@@ -6279,6 +6322,14 @@ static int netdev_init(void)
 					&LOW_SIGNAL_THRESHOLD_5GHZ))
 		LOW_SIGNAL_THRESHOLD_5GHZ = -76;
 
+	if (!l_settings_get_int(settings, "General", "CriticalRoamThreshold",
+					&CRITICAL_SIGNAL_THRESHOLD))
+		CRITICAL_SIGNAL_THRESHOLD = -80;
+
+	if (!l_settings_get_int(settings, "General", "CriticalRoamThreshold5G",
+					&CRITICAL_SIGNAL_THRESHOLD_5GHZ))
+		CRITICAL_SIGNAL_THRESHOLD_5GHZ = -82;
+
 	rand_addr_str = l_settings_get_value(settings, "General",
 						"AddressRandomization");
 	if (rand_addr_str && !strcmp(rand_addr_str, "network"))
diff --git a/src/netdev.h b/src/netdev.h
index db0440d0..3a772256 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -197,6 +197,8 @@ int netdev_neighbor_report_req(struct netdev *netdev,
 
 int netdev_set_rssi_report_levels(struct netdev *netdev, const int8_t *levels,
 					size_t levels_num);
+int netdev_lower_signal_threshold(struct netdev *netdev);
+int netdev_raise_signal_threshold(struct netdev *netdev);
 
 int netdev_get_station(struct netdev *netdev, const uint8_t *mac,
 			netdev_get_station_cb_t cb, void *user_data,
-- 
2.34.1

