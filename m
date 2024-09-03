Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84079F9DF
	for <iwd@lists.linux.dev>; Tue,  3 Sep 2024 18:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725386821; cv=none; b=VUj9RbbOLsdHTD/E3CMEsexHNG86K5Misbw3ngLgxa2UOvIoIGAoU3edA/m5GnAVPKhFOZHDxSXM3nifFzkVn45Fd6kzOYJ4LATy7GRhGE8OLXkC8K0Tv7kAq7qKx9CIFoFf40o+3dN/uAZyO5rYNUeyhm2Qd51c6Ak7q4pqqx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725386821; c=relaxed/simple;
	bh=HXLEx27SErB3KWqGHko0ZBB2q9fGw5oOXVgxT2VWj4M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NTBxvd+2lQsvwRPlPKaalzUqOir5GRx7b2n7bzfSBWnfgRjWPtTRY4ql7UuXiksRtue28heuvbbEz/maYGWqQhZuS10cFgEDHKqQ7fT8dlFW0InLWfE/NMssO02oKsZEEM7KLnxS6NyguVMBattXjJqsyj5vzvL9+bt3OONmbfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYS7BEG+; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYS7BEG+"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a8086485a5so351480285a.2
        for <iwd@lists.linux.dev>; Tue, 03 Sep 2024 11:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725386818; x=1725991618; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yQ3inv44LSYvUTbsTVCoNzDSH0IJOP8Wc2DLIsLwx50=;
        b=UYS7BEG+EuFg//O9k/DXv1YtxT5GuJPWhqw9jRAdB1t9rvCqX06rghyPOkNaWcoIzZ
         zxMUdVmmi8o/63aRB9nYpGAy5v553DbJO70IedACmm7nNJEZ6rbF4jxOPjrhWIgT5zXA
         edlr9w8ealnlwAUtcttFxt6F8im0SaAE0M2Aby556uYCBhyS7ZNQ5dwS5JpfwRle+y5J
         cYiIXijpYO62LcgW9wYLd4cbgvyVMmKy8WjvqCCUUN7dcM4aCsXhXaiYJS4qnZGfKQdH
         O/4x+SG+4WyA+aQc0RwQVXlOC7YLEc2yovXLqrkCZa7ype4m4xeZZ63geRafcq3YBRti
         Ee6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725386818; x=1725991618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yQ3inv44LSYvUTbsTVCoNzDSH0IJOP8Wc2DLIsLwx50=;
        b=FkvmSnehEeC8bRO8jzyk5l+6RYUyNfXblq0PazyWbbw+Dsnxx2phOe50c47OIlNLpv
         B5hjE7kvqoi2IIU3sBM/euVeVQaj14gED2t/XDenhkgyntlbtt1yXm4wzuGWMy/YCMOi
         YsyNXp9/aBRPodHvNXmIDf9YxReV6WRUY/OM9xYi/3gu54H20XG2caT6h+puwlh92WMr
         bIExJGooAoCC/CjGlzhZNwrZ0b+SAiv8oQ5BDbDACD5Wci7DerG/N7vO5Z669P8Lgzz4
         gpqOjr102nnmDY2aYH99LbMwNsqg1UcUKxvHFlgznMeD3qzMn/ztEz66dT1NkGv/GMy7
         kt+A==
X-Gm-Message-State: AOJu0YwVmlPVixJDZ6+j7+4q/UyK4sVFh8CK7ovc7DasnQDncFOyZCBg
	d7i071r5tHa2+3OMEy9CIxTbq55d+rwGywSNvnDIz5YcIyC68pC3gf2FmQ==
X-Google-Smtp-Source: AGHT+IEf5PN8ZD4SFLesTtvH4IiaB0uJcDQ4PW0ttSpBtGmiBFSBMxDMojWDtUcfpzXXr4r9EV87NQ==
X-Received: by 2002:a05:6214:5884:b0:6b5:4573:4ac5 with SMTP id 6a1803df08f44-6c33e684c51mr183252726d6.45.1725386817919;
        Tue, 03 Sep 2024 11:06:57 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340db129bsm55248936d6.144.2024.09.03.11.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 11:06:57 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 1/2] netdev: fall back to RSSI polling if SET_CQM fails
Date: Tue,  3 Sep 2024 11:06:52 -0700
Message-Id: <20240903180653.205405-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some drivers fail to set a CQM threshold and report not supported.
Its unclear exactly why but if this happens roaming is effectively
broken.

To work around this enable RSSI polling if -ENOTSUP is returned.
The polling callback has been changed to emit the HIGH/LOW signal
threshold events instead of just the RSSI level index, just as if
a CQM event came from the kernel.
---
 src/netdev.c | 158 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 108 insertions(+), 50 deletions(-)

v4:
 * Track the command IDs for SET_CQM

diff --git a/src/netdev.c b/src/netdev.c
index 73fbf0c1..14fe41b4 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -133,6 +133,7 @@ struct netdev {
 	uint32_t get_oci_cmd_id;
 	uint32_t get_link_cmd_id;
 	uint32_t power_save_cmd_id;
+	uint32_t set_cqm_cmd_id;
 	enum netdev_result result;
 	uint16_t last_code; /* reason or status, depending on result */
 	struct l_timeout *neighbor_report_timeout;
@@ -190,6 +191,7 @@ struct netdev {
 	bool retry_auth : 1;
 	bool in_reassoc : 1;
 	bool privacy : 1;
+	bool cqm_poll_fallback : 1;
 };
 
 struct netdev_preauth_state {
@@ -650,6 +652,47 @@ static void netdev_set_rssi_level_idx(struct netdev *netdev)
 	netdev->cur_rssi_level_idx = new_level;
 }
 
+static void netdev_cqm_event_rssi_value(struct netdev *netdev, int rssi_val)
+{
+	bool new_rssi_low;
+	uint8_t prev_rssi_level_idx = netdev->cur_rssi_level_idx;
+	int threshold = netdev->frequency > 4000 ?
+					netdev->low_signal_threshold_5ghz :
+					netdev->low_signal_threshold;
+
+	if (!netdev->connected)
+		return;
+
+	if (rssi_val > 127)
+		rssi_val = 127;
+	else if (rssi_val < -127)
+		rssi_val = -127;
+
+	netdev->cur_rssi = rssi_val;
+
+	if (!netdev->event_filter)
+		return;
+
+	new_rssi_low = rssi_val < threshold;
+	if (netdev->cur_rssi_low != new_rssi_low) {
+		int event = new_rssi_low ?
+			NETDEV_EVENT_RSSI_THRESHOLD_LOW :
+			NETDEV_EVENT_RSSI_THRESHOLD_HIGH;
+
+		netdev->cur_rssi_low = new_rssi_low;
+		netdev->event_filter(netdev, event, NULL, netdev->user_data);
+	}
+
+	if (!netdev->rssi_levels_num)
+		return;
+
+	netdev_set_rssi_level_idx(netdev);
+	if (netdev->cur_rssi_level_idx != prev_rssi_level_idx)
+		netdev->event_filter(netdev, NETDEV_EVENT_RSSI_LEVEL_NOTIFY,
+					&netdev->cur_rssi_level_idx,
+					netdev->user_data);
+}
+
 static void netdev_rssi_poll_cb(struct l_genl_msg *msg, void *user_data)
 {
 	struct netdev *netdev = user_data;
@@ -686,11 +729,16 @@ static void netdev_rssi_poll_cb(struct l_genl_msg *msg, void *user_data)
 	netdev->cur_rssi = info.cur_rssi;
 
 	/*
-	 * Note we don't have to handle LOW_SIGNAL_THRESHOLD here.  The
-	 * CQM single threshold RSSI monitoring should work even if the
-	 * kernel driver doesn't support multiple thresholds.  So the
-	 * polling only handles the client-supplied threshold list.
+	 * If the CMD_SET_CQM call failed RSSI polling was started. In this case
+	 * we should behave just like its a CQM event and check both the RSSI
+	 * level indexes and the HIGH/LOW thresholds.
 	 */
+	if (netdev->cqm_poll_fallback) {
+		netdev_cqm_event_rssi_value(netdev, info.cur_rssi);
+		goto done;
+	}
+
+	/* Otherwise just update the level notifications, CQM events work */
 	netdev_set_rssi_level_idx(netdev);
 	if (netdev->cur_rssi_level_idx != prev_rssi_level_idx)
 		netdev->event_filter(netdev, NETDEV_EVENT_RSSI_LEVEL_NOTIFY,
@@ -1031,6 +1079,11 @@ static void netdev_free(void *data)
 		netdev->get_station_cmd_id = 0;
 	}
 
+	if (netdev->set_cqm_cmd_id) {
+		l_genl_family_cancel(nl80211, netdev->set_cqm_cmd_id);
+		netdev->set_cqm_cmd_id = 0;
+	}
+
 	if (netdev->fw_roam_bss)
 		scan_bss_free(netdev->fw_roam_bss);
 
@@ -1039,6 +1092,9 @@ static void netdev_free(void *data)
 		netdev->get_link_cmd_id = 0;
 	}
 
+	if (netdev->rssi_poll_timeout)
+		l_timeout_remove(netdev->rssi_poll_timeout);
+
 	scan_wdev_remove(netdev->wdev_id);
 
 	watchlist_destroy(&netdev->station_watches);
@@ -1093,47 +1149,6 @@ static void netdev_cqm_event_rssi_threshold(struct netdev *netdev,
 	netdev->event_filter(netdev, event, NULL, netdev->user_data);
 }
 
-static void netdev_cqm_event_rssi_value(struct netdev *netdev, int rssi_val)
-{
-	bool new_rssi_low;
-	uint8_t prev_rssi_level_idx = netdev->cur_rssi_level_idx;
-	int threshold = netdev->frequency > 4000 ?
-					netdev->low_signal_threshold_5ghz :
-					netdev->low_signal_threshold;
-
-	if (!netdev->connected)
-		return;
-
-	if (rssi_val > 127)
-		rssi_val = 127;
-	else if (rssi_val < -127)
-		rssi_val = -127;
-
-	netdev->cur_rssi = rssi_val;
-
-	if (!netdev->event_filter)
-		return;
-
-	new_rssi_low = rssi_val < threshold;
-	if (netdev->cur_rssi_low != new_rssi_low) {
-		int event = new_rssi_low ?
-			NETDEV_EVENT_RSSI_THRESHOLD_LOW :
-			NETDEV_EVENT_RSSI_THRESHOLD_HIGH;
-
-		netdev->cur_rssi_low = new_rssi_low;
-		netdev->event_filter(netdev, event, NULL, netdev->user_data);
-	}
-
-	if (!netdev->rssi_levels_num)
-		return;
-
-	netdev_set_rssi_level_idx(netdev);
-	if (netdev->cur_rssi_level_idx != prev_rssi_level_idx)
-		netdev->event_filter(netdev, NETDEV_EVENT_RSSI_LEVEL_NOTIFY,
-					&netdev->cur_rssi_level_idx,
-					netdev->user_data);
-}
-
 static void netdev_cqm_event(struct l_genl_msg *msg, struct netdev *netdev)
 {
 	struct l_genl_attr attr;
@@ -3644,11 +3659,50 @@ static struct l_genl_msg *netdev_build_cmd_cqm_rssi_update(
 
 static void netdev_cmd_set_cqm_cb(struct l_genl_msg *msg, void *user_data)
 {
+	struct netdev *netdev = user_data;
 	int err = l_genl_msg_get_error(msg);
 	const char *ext_error;
 
-	if (err >= 0)
+	netdev->set_cqm_cmd_id = 0;
+
+	if (err >= 0) {
+		/*
+		 * Looking at some driver code it appears that the -ENOTSUP CQM
+		 * failure could be transient. Just in case, reset the fallback
+		 * flag if CQM happens to start working again.
+		 */
+		if (netdev->cqm_poll_fallback) {
+			l_debug("CMD_SET_CQM succeeded, stop polling fallback");
+
+			if (netdev->rssi_poll_timeout) {
+				l_timeout_remove(netdev->rssi_poll_timeout);
+				netdev->rssi_poll_timeout = NULL;
+			}
+
+			netdev->cqm_poll_fallback = false;
+		}
+
+		return;
+	}
+
+	/*
+	 * Some drivers enable beacon filtering but also use software CQM which
+	 * mac80211 detects and returns -ENOTSUP. There is no way to check this
+	 * ahead of time so if we see this start polling in order to get RSSI
+	 * updates.
+	 */
+	if (err == -ENOTSUP) {
+		l_debug("CMD_SET_CQM not supported, falling back to polling");
+		netdev->cqm_poll_fallback = true;
+
+		if (netdev->rssi_poll_timeout)
+			return;
+
+		netdev->rssi_poll_timeout = l_timeout_create(1,
+						netdev_rssi_poll, netdev, NULL);
+
 		return;
+	}
 
 	ext_error = l_genl_msg_get_extended_error(msg);
 	l_error("CMD_SET_CQM failed: %s",
@@ -3671,8 +3725,10 @@ static int netdev_cqm_rssi_update(struct netdev *netdev)
 	if (!msg)
 		return -EINVAL;
 
-	if (!l_genl_family_send(nl80211, msg, netdev_cmd_set_cqm_cb,
-				NULL, NULL)) {
+	netdev->set_cqm_cmd_id = l_genl_family_send(nl80211, msg,
+						netdev_cmd_set_cqm_cb,
+						netdev, NULL);
+	if (!netdev->set_cqm_cmd_id) {
 		l_genl_msg_unref(msg);
 		return -EIO;
 	}
@@ -5309,8 +5365,10 @@ int netdev_set_rssi_report_levels(struct netdev *netdev, const int8_t *levels,
 	if (!cmd_set_cqm)
 		return -EINVAL;
 
-	if (!l_genl_family_send(nl80211, cmd_set_cqm, netdev_cmd_set_cqm_cb,
-				NULL, NULL)) {
+	netdev->set_cqm_cmd_id = l_genl_family_send(nl80211, cmd_set_cqm,
+							netdev_cmd_set_cqm_cb,
+							netdev, NULL);
+	if (!netdev->set_cqm_cmd_id) {
 		l_genl_msg_unref(cmd_set_cqm);
 		return -EIO;
 	}
-- 
2.34.1

