Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D059F2AF0D
	for <iwd@lists.linux.dev>; Tue, 13 Aug 2024 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564613; cv=none; b=nShLwp2JVJ3vIvC+Ui2kfHEnKQkoiqPnWhe3Zuq3sX4M1LMnA1UJ/EcZ5bvdf7meLg3yPg0nBRdVnncKxWmsRGFSOBbQKZtblYmlisC1X1xptPWrCzN9iaT9VLVjPgNcHRZQ0XBMnxHKV9aUMkPUGQsFXjXhPPf7WQaxY5EyAB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564613; c=relaxed/simple;
	bh=dth8Om/dpd2WPGLKj86XfvoQcZ106g4uJ095+68o3+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dFI1zxm+CU0BYdPoaAoa0a2PEaLeyfpMes1wyH4xLzARrL97LyjyyjE0+fNVdv7czd35iwgB8YYfMfd+Uu4OAAbUP9v2bfqnkr3/YVltLAKF5iho2tH6FoozetYkJo2S+dtHKPLEylE2VZXGcdM4oFTE1Ri5ERG7FGrkGV5cKuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjJP0So2; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjJP0So2"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b79293a858so30596016d6.3
        for <iwd@lists.linux.dev>; Tue, 13 Aug 2024 08:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723564610; x=1724169410; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kbjh8fJNxFHHlj8pSoOE9/0QiON10umIEqjdMpqkxO8=;
        b=AjJP0So2BeeCfH99FZF7bX2wEonttOfU1x8weDuL62MK6AWbtRKkcmEKB3cgtU09sk
         DXylCrzpgLU90IMYGFdF87C1zgfyS2gR+7/vUCNkbITzdbI58nUTms1jEIqrco9tv2U2
         XOhJcodQJ7kYyjO1Lei6eYxTguGY45E67eM4as4X3SgBNgFqI94EX3/GS3o0vPAUOX+T
         e894UgvYSIzZsXcVjn3nGw+Ml/G72q00/ZDjM9i1PoX/zPi5gLZq0gfVPsI9Jx1esJlh
         47IA01varqDY4/EXA6JU/QJNJchOaLRX4xkhDUxNmJ0q0DTs9k/mN9h/JsK9H0wZFcM6
         68qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723564610; x=1724169410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kbjh8fJNxFHHlj8pSoOE9/0QiON10umIEqjdMpqkxO8=;
        b=Nbq7x3u4skKXCc2QwXSld8hsMCpSMEs89WHgacJewd3x5HtuG4/O02Lq1FN+1e9aV+
         OkjeigOknvd1+t4qB50X2TsfbFaxNbvbMheEH4uTI8WSSt2ZTsJf8ZlrfjDWfukhYwpJ
         Q43P5uCaFvYcI4Vvsb2BhUhcenq0rHCMWzsVWJF8+6R2O2zZzds0qA1zEaPBbeICBOSL
         dIx0wy1PLV07OedaUsUPNg1MA48YYYa47SH22bJzW7mUnZ+YOPzqkNl2bjohHtEakvws
         oDA/sDamr3Vr5eVNlEsb+ZWBAi5+LHnWcBLTW6ZAkXaZ7EQ7pYh/FHxc7PXME2naxYP5
         R5xw==
X-Gm-Message-State: AOJu0YwC7Bus86btNq2Dy0ZvWF9gJm/7jyj7sINLhVaWBaG6+Tzoc/km
	YsmPDDtlud4S+SHn+SrUZvzfCQjsxieJd2CPHX56BIFd8BYEYq9YiRnqNg==
X-Google-Smtp-Source: AGHT+IHe/5tyP1+I3pIefLl/T26anRHEvx/XTO1xEwlZxGvIdAsa61pMBf32u3yHL2h/dlbrwDapeA==
X-Received: by 2002:a05:6214:2b9a:b0:6b5:116:eb54 with SMTP id 6a1803df08f44-6bf4f86ea4bmr42432326d6.47.1723564610172;
        Tue, 13 Aug 2024 08:56:50 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82ca2024sm35825706d6.72.2024.08.13.08.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 08:56:49 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/9] netdev: add critical signal threshold level
Date: Tue, 13 Aug 2024 08:56:32 -0700
Message-Id: <20240813155638.74987-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813155638.74987-1-prestwoj@gmail.com>
References: <20240813155638.74987-1-prestwoj@gmail.com>
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

