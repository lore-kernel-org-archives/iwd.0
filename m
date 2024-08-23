Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEB218DF62
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 18:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724436022; cv=none; b=ag78ldjcPou3w5yJAddpaK3HC9QgjBnP/Y3w4QDvsn+Z8HL8k+9NUWBqfoBDPbj8/3/R14jkhyvGiz5/vDiW5nbvzopnvbcddnc2PrU2cFe+fmZavR/KUuyk4OPpqvMREpklzuGhJnm38EIbveC1l0gDmDWwOZe2VA6hY34X+YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724436022; c=relaxed/simple;
	bh=ZljTQtXq98cRA+kwtS2Z0zd4CWtfUqva1KNY1MkV0Go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jKwxDEg5C9N7kb6oXh8l5Y0fOq+ODHBB3qqan0eY55YSeueYApyaUc2eZ6tiHzecHaf1XJ7+KRdUHeF3BvOCIWo+PaWbY2TuclPX4WjlwMA7WCdPK+B34AMipqfDKdBssQdxWCywWC92HhND9fiwNjSzlVjZqaVgdWyK3+mlOfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAjFyvv4; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAjFyvv4"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7094468d392so1764896a34.0
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 11:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724436019; x=1725040819; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jkjOZ/MabxyN8XvAZyvEOd32VeO/sg6Mr+9d65TU/o=;
        b=IAjFyvv4B35YDdzC7kUubX6aoxByG53yXjSaESTHF84fqpNRAUMps9cPInnreOQBtq
         JdjDIHJuReMfzbdZJ8Rpc+LWZnq0UNvH8QmEZl62gAGqZ+Xd459mQgHPk2rx5/Hiw7z/
         R4dNBQ/UrpFwDtPCx4V2YWYPKimsj1lofNiP4MQyLgUQ47d/BmLTk2D5pHD7tBHGOCLP
         EtNrW1XnhFSakOkO03lTLyoRKzz/S9L49VUtFu+Opsv2Y6wTm59JgGbgQPOnsW9sbnC3
         ohFWk8321Znpdw1UVyX0Q6JDf42B0DU23JOhATrP2pwnX10dQ3/lqeypuAICS9z2qimq
         Y/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724436019; x=1725040819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jkjOZ/MabxyN8XvAZyvEOd32VeO/sg6Mr+9d65TU/o=;
        b=u3vVcCUyYdyqnSBX2u/cSM/ZXp+oj46q49PN4AD0mxeL41ltn9A5BSc/pWdgUeQVKD
         eA4eLdmg26nx0ZOHkBOWFgY53F7M2wb7wGOh+34OlwQebaIAivAqRXIC+ZZ9ZjCcc4cj
         qJ5nGxvlPifMwBpj0whB9i2U13dHyRTrOlbTMouJEOw2YtZ+ONBvRWlVL53iQS5LTBiw
         qRmXRX8MZZoSSAWQxRwnQjVrIYW7wpIoonzhs3XRJdo1nYvzppxSCZx6jftS76qBjHcL
         JR+WGvdBVKzSbYKbIOsJxNKaKsJ/HCOjTNPf40XzJDYjSD6Gjnc0U+G2Mh5cWYDeXlBq
         mwsQ==
X-Gm-Message-State: AOJu0Yy084pibcECeSsjKF1YbYSZg/oPHWg7TWDDH3fp5Ci100JKaMZr
	1qm4yC1reGyueELUsWa4uHEbv4u+44b73BF/mn6G6Uh3//ACcw4+SVpTkg==
X-Google-Smtp-Source: AGHT+IHsoZXs8m7peX7Jcxy0rhlHAJM0IYWfGBkGHPtPwHSKZNo3r0ZagHnt7k3cTER1HlBq+BtZzw==
X-Received: by 2002:a05:6830:2645:b0:703:79f5:fabb with SMTP id 46e09a7af769-70e0eb0d34emr3127681a34.11.1724436019557;
        Fri, 23 Aug 2024 11:00:19 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe0f0507sm19683131cf.47.2024.08.23.11.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 11:00:19 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 4/8] netdev: add critical signal threshold level
Date: Fri, 23 Aug 2024 11:00:02 -0700
Message-Id: <20240823180006.317353-4-prestwoj@gmail.com>
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

This adds a secondary set of signal thresholds. The purpose of these
are to provide more flexibility in how IWD roams. The critical
threshold is intended to be temporary and is automatically reset
upon any connection changes: disconnects, roams, or new connections.
---
 src/netdev.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/netdev.h |  5 +++++
 2 files changed, 56 insertions(+)

v3:
 * Moved the new settings into a #define in netdev.h

diff --git a/src/netdev.c b/src/netdev.c
index e392c654..cd3cfc78 100644
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
index d718fa6a..46845c36 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -33,6 +33,9 @@ struct diagnostic_station_info;
 #define NETDEV_ADDRESS_RANDOMIZATION GENERAL, "AddressRandomization"
 #define NETDEV_ROAM_THRESHOLD GENERAL, "RoamTreshold"
 #define NETDEV_ROAM_TRHESHOLD_5G GENERAL, "RoamThreshold5G"
+#define NETDEV_CRITICAL_ROAM_THRESHOLD GENERAL, "CriticalRoamThreshold"
+#define NETDEV_CRITICAL_ROAM_THRESHOLD_5G GENERAL, "CriticalRoamThreshold5G"
+
 
 enum netdev_result {
 	NETDEV_RESULT_OK,
@@ -202,6 +205,8 @@ int netdev_neighbor_report_req(struct netdev *netdev,
 
 int netdev_set_rssi_report_levels(struct netdev *netdev, const int8_t *levels,
 					size_t levels_num);
+int netdev_lower_signal_threshold(struct netdev *netdev);
+int netdev_raise_signal_threshold(struct netdev *netdev);
 
 int netdev_get_station(struct netdev *netdev, const uint8_t *mac,
 			netdev_get_station_cb_t cb, void *user_data,
-- 
2.34.1

