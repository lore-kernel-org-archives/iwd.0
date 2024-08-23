Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6F11C871D
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 22:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724451833; cv=none; b=Q8Mdb6o3pJLv/RoqcuRfnHsEfgBpSdmiAwQlMn8Pn1aWrDUbqgwYaejw9CqfayTU9X0KPecwNQp/3Ghrv42r38zWiy5VsxwL8X82GDKj1YChOLhIqYrWRzxQfyOWRcSAa74AQH/a0vzGXzn0U3DlYjpwZqELpi/jPPYV/cJIcXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724451833; c=relaxed/simple;
	bh=zfsmCn4z9Iry8iifG1YA/kr+DiQISc/q3zC2yV47waY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PkaxOnyihJ4NXIB+ySKpkiROUOIP4ZgwUREabfarXT8+gyRIFnkLtxmCRKBjH00NdAIa3lwSKoF9hw8lId53bf+n3fMDJ4fFWTGMtpVqQFIR+riIWeSXJg5dmXDtQaXpEV2E2hGnAWPl/ydxV9alLh3Y+h3scEKnKAEYAwbjkFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxTDrNNe; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxTDrNNe"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-498eb25d247so703400137.0
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 15:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724451830; x=1725056630; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+HZyfslDqDuP15B/xamTRRdgwKfXFoD+w25dHISu2A=;
        b=KxTDrNNe3RJJZvE2DRuHB6MulNuXwGP9erBao0Wj1XuKFDNTXFHY9mdQxEfYnS2T1I
         Nz8Ng013jUfc1IZ7mpGPIW1mqyfj48CI4XJ9opekc58Pyqe1TVH7cWVRpgHY4boHnCHN
         pXPwU87tQyNsWdClLWLp/j/YaqEBS+7urzcfwAjYZtsYXLDd8Do/zambyfHct1DF4kto
         1PzsqMCscZrLeKXXuSII6a1Mr3jI5YVUHqGa40gMfB/kSggNNutJSVFKwgLylz6589fe
         pu3Ebc6pcA23IrDKJhAiQ5EFSubHRHWTmvhQuLBNLpMEd1pYeRgCuNkMZThJPF2PvOq+
         lPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724451830; x=1725056630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+HZyfslDqDuP15B/xamTRRdgwKfXFoD+w25dHISu2A=;
        b=niyzHX9hB8KiGbuFHLRcs7dW0KpEPvwO5T8R0gm36BoiDVsvhSN1DuYQpPIyaHF+hQ
         DfVtIsz7XUJ3tQTFWJmVPpFDFTfF0sartvUyt8NlBFGrMvwV18MGB91SIanSj7LcNOYL
         Zfwba0Jw6BV1OqnCbzyFHwFbS7bKeyhIpqCvVDdbaYwRbSIYBozDzKqP3DHQC5azXimD
         pD1hpmmBpbRGCmJGU6HdtLnDMAJ+SRWQK8pWc7t6eDCcOdgR+gowXOl0AXN5zznDgTgY
         Cxp6po6b4fvEZCjkYUKG8d+3Up76+K45afrMI5/jyiWA5r/Cyvt3F3gvjCRIKbT0Rqai
         HwoQ==
X-Gm-Message-State: AOJu0YxiWr0xBOfsQBtmLq5YW7wbf1MPxVGupRUCGCOHFUVB3ZKzScfp
	WNUhD7LjgnXeKVmBm8yg50QoOz4APhqoUz9ywUCtbVbJxvHsvD2+mv+mhg==
X-Google-Smtp-Source: AGHT+IHJU9J0a41xDFM9OFvaLjslJFWql88T2l+j2bO2KBFY9I4yTJB69rpz/PDA2zW5O1YcdBCm+A==
X-Received: by 2002:a05:6102:38cd:b0:493:c028:bee0 with SMTP id ada2fe7eead31-498f465a262mr3529729137.15.1724451830028;
        Fri, 23 Aug 2024 15:23:50 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f41f507sm218860385a.132.2024.08.23.15.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 15:23:49 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 4/8] netdev: add critical signal threshold level
Date: Fri, 23 Aug 2024 15:23:35 -0700
Message-Id: <20240823222339.328006-4-prestwoj@gmail.com>
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

This adds a secondary set of signal thresholds. The purpose of these
are to provide more flexibility in how IWD roams. The critical
threshold is intended to be temporary and is automatically reset
upon any connection changes: disconnects, roams, or new connections.
---
 src/netdev.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/netdev.h |  4 ++++
 2 files changed, 55 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index 1f1b9400..73fbf0c1 100644
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
 
+	if (!l_settings_get_int(settings, NETDEV_CRITICAL_ROAM_THRESHOLD,
+					&CRITICAL_SIGNAL_THRESHOLD))
+		CRITICAL_SIGNAL_THRESHOLD = -80;
+
+	if (!l_settings_get_int(settings, NETDEV_CRITICAL_ROAM_THRESHOLD_5G,
+					&CRITICAL_SIGNAL_THRESHOLD_5GHZ))
+		CRITICAL_SIGNAL_THRESHOLD_5GHZ = -82;
+
 	rand_addr_str = l_settings_get_value(settings,
 						NETDEV_ADDRESS_RANDOMIZATION);
 	if (rand_addr_str && !strcmp(rand_addr_str, "network"))
diff --git a/src/netdev.h b/src/netdev.h
index c48b2c38..6299934e 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -33,6 +33,8 @@ struct diagnostic_station_info;
 #define NETDEV_ADDRESS_RANDOMIZATION GENERAL, "AddressRandomization"
 #define NETDEV_ROAM_THRESHOLD GENERAL, "RoamThreshold"
 #define NETDEV_ROAM_THRESHOLD_5G GENERAL, "RoamThreshold5G"
+#define NETDEV_CRITICAL_ROAM_THRESHOLD GENERAL, "CriticalRoamThreshold"
+#define NETDEV_CRITICAL_ROAM_THRESHOLD_5G GENERAL, "CriticalRoamThreshold5G"
 
 enum netdev_result {
 	NETDEV_RESULT_OK,
@@ -202,6 +204,8 @@ int netdev_neighbor_report_req(struct netdev *netdev,
 
 int netdev_set_rssi_report_levels(struct netdev *netdev, const int8_t *levels,
 					size_t levels_num);
+int netdev_lower_signal_threshold(struct netdev *netdev);
+int netdev_raise_signal_threshold(struct netdev *netdev);
 
 int netdev_get_station(struct netdev *netdev, const uint8_t *mac,
 			netdev_get_station_cb_t cb, void *user_data,
-- 
2.34.1

