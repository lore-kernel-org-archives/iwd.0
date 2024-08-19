Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AE316132E
	for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 17:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724089925; cv=none; b=ZvEvR3kYI+DzOmZMhPD+NKTB6TalNfAVszLXD65wPvqEAQhtyt43YWBaPjHhdfkOfDKKCcTCFx53z/wPGrvZdcBrO2+sG3Viut7qRw0EEu0Ie1flJRCxm7URVWgfN90WE/bmmTesG8duD1LTa0bBD1jlBHHMPxSMJ9308jTvZCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724089925; c=relaxed/simple;
	bh=dth8Om/dpd2WPGLKj86XfvoQcZ106g4uJ095+68o3+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kJJoBb+1BMnIj5WW8d2evECnPoDgPxPLSRDimZGy+WsGap84PZ/NfBJ97J4X98V9gPHJvPid4xOT/SD8ne1vp9341kYyW1qWqY3/eWpywJgyhWJ+297KyRyUz9sP+1zNU4l2baRpyNVGPqtMRwYfVw8Pfmnh69PQC/d6/OuU7Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYzJPJIe; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYzJPJIe"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a1d7bc07b7so319907885a.0
        for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 10:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724089923; x=1724694723; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kbjh8fJNxFHHlj8pSoOE9/0QiON10umIEqjdMpqkxO8=;
        b=IYzJPJIekEw0li5fFyU6i2swQQ5OnmqjWswjO7egs8ITyHtOSrxaCR1xyfBC51O6zp
         Mzw8qSNKr92VBF/zih5zkRvstuBdtHu0Ecv4x9sWLUyvqJ9b/AnXVs9MNX8X4QKnLHnY
         aLoF5mpuX2raJ0+Xjq7mMZS0lXgmgtWkNSozpi15eR/mrn77bPSn5gbQ//hn+60sd6eD
         9kVXYVQkSziAREIckTdfcg4XC1Buhywj7NFl0Vt69KWE64YcScQ3FN56XHv0i1+tRHdR
         HPmreksG8aKJ0/N5VwZM0ibewDGzO0ro9IY2xYKAM90ULjP1L6t7/7PIJekFLrCk3Aq3
         mifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724089923; x=1724694723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kbjh8fJNxFHHlj8pSoOE9/0QiON10umIEqjdMpqkxO8=;
        b=uxkN4ymEJoUIlyOofbn1FIGshrnHf4e4KuKOOpliZ3CyDNBfi6ZZihaxX2J+3P0S/u
         iYOLR/0We8o2/qSblkgQbgmPV0a6sEoAYM1lGIQUC63CzOQxkhnrZAelIUQVvYeQDaTq
         aWS+rX15Drb0D0dqK7HTW0JKOKRUi1C5RQPhdwMhaEkfbG8Nmm4ONHyUAwlBq8IPF9qp
         0uxvSI9fCNnwZQbnBGuOYZ2Gk9W0EGJYU7pm3azRwetIivkTlvS4nY3CCAOK+Kut64q+
         htxXTr/hKejpDUttLxQkvjppjYU1EE3CUrINl5oTcnM/oiNZOQKWDLeHthi6rTsZD2lz
         /M0g==
X-Gm-Message-State: AOJu0YzPuEzBlJ43QmM9TrQWpj3SE4oouFGbea5vCs7x0kKwb4lc4hw8
	AxGC6lXHX/en+iVNagxCZXPrTx3LCGhMNUuZx/WcgUV+MtyHqclWvG5f9Q==
X-Google-Smtp-Source: AGHT+IG8MLySi9bri1pUiEQ3HJa8cmZNLhTvgexFnO++y1zKlmHa31bgSpdM0x7AjftLBH6WFzxysw==
X-Received: by 2002:a05:620a:40c7:b0:79c:f55:4fd4 with SMTP id af79cd13be357-7a5069eb83amr1167561285a.59.1724089922822;
        Mon, 19 Aug 2024 10:52:02 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0e5a1csm451854685a.74.2024.08.19.10.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 10:52:02 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/8] netdev: add critical signal threshold level
Date: Mon, 19 Aug 2024 10:51:46 -0700
Message-Id: <20240819175151.1310546-3-prestwoj@gmail.com>
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

This adds a secondary set of signal thresholds. The purpose of these
are to provide more flexibility in how IWD roams. The critical
threshold is intended to be temporary and is automatically reset
upon any connection changes: disconnects, roams, or new connections.
---
 src/netdev.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/netdev.h |  2 ++
 2 files changed, 53 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index a9648fbc..94766552 100644
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
@@ -3887,6 +3926,8 @@ done:
 	netdev->handshake = hs;
 	netdev->sm = sm;
 	netdev->cur_rssi = bss->signal_strength / 100;
+	netdev->low_signal_threshold = LOW_SIGNAL_THRESHOLD;
+	netdev->low_signal_threshold_5ghz = LOW_SIGNAL_THRESHOLD_5GHZ;
 
 	if (netdev->rssi_levels_num)
 		netdev_set_rssi_level_idx(netdev);
@@ -4260,6 +4301,8 @@ int netdev_ft_reassociate(struct netdev *netdev,
 	netdev->event_filter = event_filter;
 	netdev->connect_cb = cb;
 	netdev->user_data = user_data;
+	netdev->low_signal_threshold = LOW_SIGNAL_THRESHOLD;
+	netdev->low_signal_threshold_5ghz = LOW_SIGNAL_THRESHOLD_5GHZ;
 
 	/*
 	 * Cancel commands that could be running because of EAPoL activity
@@ -6278,6 +6321,14 @@ static int netdev_init(void)
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

