Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FEE17E463
	for <iwd@lists.linux.dev>; Fri, 26 Jul 2024 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722011883; cv=none; b=hKO0QC2jtXAFm/zqWQKVtbYOP3vpnU2rBjt7U1cA2/bPMMeYbMcWPSHzkeOuGCau/XtY5x2/fqtZs+f/34bNpM9A+7ShRSTY3B6c+M1oYIMnKYvJLTc1dmaBa0kttAVuRMAZewbJfFiv6kME+HBt/+rXVK/HtNEJK4P6hm05oDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722011883; c=relaxed/simple;
	bh=UOzLrOLlpW/i5rx77xgP0PmLTJNR0ORSA04mabNWTrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i4PRtGIVMSx7VtQ1NURLarB5HLCRvs3NmOFlkD8gfqZzDTJCPoaT7XlgDWWHCSEqu4C1mT/UYTI4A69uPiH461KiPfaEJZUh7IBEN58gIYMqmu1C/vJe3WAK0MCmXh2HSPKnKUhyygZ9D72k+wS/a45FrswzOp1iMk3xLagOm+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+bFvz39; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+bFvz39"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-44ff398cefcso5196641cf.0
        for <iwd@lists.linux.dev>; Fri, 26 Jul 2024 09:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722011880; x=1722616680; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNF5ZkPARZ7yN+jz1TbO/LIa252kat/za5rNygnosvA=;
        b=T+bFvz39uvuWcpeAWSdk0LB3052R4lz+QEICdBnTq3K06b9vKxLfMtYZ6dl+VoIFa5
         mlSiVVo9nuw1/Mh5x+t/mnpWW0KLi7x8ldxPh1oQssdlOiCpsr0IqbpT0sxcz++JPwar
         RSNNg58TMZ13VbHKrH3CGCGH1Yi1vFsTQG0s+Q2wAj9ILuP7L/q2MuSCg36cqE3m7ltX
         fBVYC2l+bBdKIlAmEytypMzfHI85oJrXnUinyuXvPpy3SO8J5vwv/j0NXmRdtXX0ujh/
         dEKYmP3+uokuHUruI+fAjZuc3snl8gzSJAMcBMhC2mW2XyNr1Zid0GmQE7Y8i9PmkYQ7
         +8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722011880; x=1722616680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNF5ZkPARZ7yN+jz1TbO/LIa252kat/za5rNygnosvA=;
        b=oj7CQadasjVFY8hs/oqTGMIjKVNpvnmiYAAZI07hE0WOwf2Sz9a4LPQ4tWkTCSc1fF
         U/AGW8fvEPmiLOp6OY2cUz/423Czss4wq5aOopWp4cGza03ui++Bqk1OP7stmJ0THJ5C
         fma9yXI4K2k48lVushrC8RnZIAUqZXkLqhlsKhxWM4wT8loHozvVuzUnRYfvZrTgvjkH
         wLyTUYGrwDP06ubuJOjObebTQXTP/88xVZtTpaEFBlI5JSCCUFD1i0060lDZz9loMplY
         KCePlm0DI/zrn7MICatrEXvTNKrTU6pWk2FrSnqogwdLYxSB6WuXWeSdQmdn8duYYUQQ
         ZlvQ==
X-Gm-Message-State: AOJu0Yx0KM86HDJKk/NExuSJgNhkiaWWYjW3ISch1eJeLN0EzGPeUVZR
	nEIK7q/ROlvHCfB+4GEbIUkf0BIVp6UN5LDyjSbNd17nBJaJkEiSpvqGsA==
X-Google-Smtp-Source: AGHT+IE650KfN/jEJWuYaDjTTrvl6sZYqRcQZ4tRm3tA9Ljqq6m49at5Hw8Hxs7V/CoeQ3sC4tFy+A==
X-Received: by 2002:ac8:7d03:0:b0:446:6053:e47e with SMTP id d75a77b69052e-45004d8d0camr3552841cf.23.1722011880171;
        Fri, 26 Jul 2024 09:38:00 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe81463easm14841081cf.26.2024.07.26.09.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 09:37:59 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] netdev: fall back to RSSI polling if SET_CQM fails
Date: Fri, 26 Jul 2024 09:37:52 -0700
Message-Id: <20240726163752.1651669-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240726163752.1651669-1-prestwoj@gmail.com>
References: <20240726163752.1651669-1-prestwoj@gmail.com>
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
 src/netdev.c | 155 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 104 insertions(+), 51 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 2d70fc38..c0e91e31 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -187,6 +187,7 @@ struct netdev {
 	bool retry_auth : 1;
 	bool in_reassoc : 1;
 	bool privacy : 1;
+	bool cqm_poll_fallback : 1;
 };
 
 struct netdev_preauth_state {
@@ -206,6 +207,9 @@ static struct l_genl_family *nl80211;
 static struct l_queue *netdev_list;
 static struct watchlist netdev_watches;
 static bool mac_per_ssid;
+/* Threshold RSSI for roaming to trigger, configurable in main.conf */
+static int LOW_SIGNAL_THRESHOLD;
+static int LOW_SIGNAL_THRESHOLD_5GHZ;
 
 static unsigned int iov_ie_append(struct iovec *iov,
 					unsigned int n_iov, unsigned int c,
@@ -642,6 +646,46 @@ static void netdev_set_rssi_level_idx(struct netdev *netdev)
 	netdev->cur_rssi_level_idx = new_level;
 }
 
+static void netdev_cqm_event_rssi_value(struct netdev *netdev, int rssi_val)
+{
+	bool new_rssi_low;
+	uint8_t prev_rssi_level_idx = netdev->cur_rssi_level_idx;
+	int threshold = netdev->frequency > 4000 ? LOW_SIGNAL_THRESHOLD_5GHZ :
+						LOW_SIGNAL_THRESHOLD;
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
@@ -678,11 +722,16 @@ static void netdev_rssi_poll_cb(struct l_genl_msg *msg, void *user_data)
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
@@ -1027,6 +1076,9 @@ static void netdev_free(void *data)
 		netdev->get_link_cmd_id = 0;
 	}
 
+	if (netdev->rssi_poll_timeout)
+		l_timeout_remove(netdev->rssi_poll_timeout);
+
 	scan_wdev_remove(netdev->wdev_id);
 
 	watchlist_destroy(&netdev->station_watches);
@@ -1058,10 +1110,6 @@ struct netdev *netdev_find(int ifindex)
 	return l_queue_find(netdev_list, netdev_match, L_UINT_TO_PTR(ifindex));
 }
 
-/* Threshold RSSI for roaming to trigger, configurable in main.conf */
-static int LOW_SIGNAL_THRESHOLD;
-static int LOW_SIGNAL_THRESHOLD_5GHZ;
-
 static void netdev_cqm_event_rssi_threshold(struct netdev *netdev,
 						uint32_t rssi_event)
 {
@@ -1085,46 +1133,6 @@ static void netdev_cqm_event_rssi_threshold(struct netdev *netdev,
 	netdev->event_filter(netdev, event, NULL, netdev->user_data);
 }
 
-static void netdev_cqm_event_rssi_value(struct netdev *netdev, int rssi_val)
-{
-	bool new_rssi_low;
-	uint8_t prev_rssi_level_idx = netdev->cur_rssi_level_idx;
-	int threshold = netdev->frequency > 4000 ? LOW_SIGNAL_THRESHOLD_5GHZ :
-						LOW_SIGNAL_THRESHOLD;
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
@@ -1372,6 +1380,9 @@ static void netdev_operstate_cb(int error, uint16_t type,
 							strerror(-error));
 }
 
+static int netdev_cqm_rssi_update(struct netdev *netdev);
+
+
 static void netdev_connect_ok(struct netdev *netdev)
 {
 	l_debug("");
@@ -1383,6 +1394,8 @@ static void netdev_connect_ok(struct netdev *netdev)
 
 	netdev->operational = true;
 
+	netdev_cqm_rssi_update(netdev);
+
 	if (netdev->fw_roam_bss) {
 		if (netdev->event_filter)
 			netdev->event_filter(netdev, NETDEV_EVENT_ROAMED,
@@ -3634,11 +3647,48 @@ static struct l_genl_msg *netdev_build_cmd_cqm_rssi_update(
 
 static void netdev_cmd_set_cqm_cb(struct l_genl_msg *msg, void *user_data)
 {
+	struct netdev *netdev = user_data;
 	int err = l_genl_msg_get_error(msg);
 	const char *ext_error;
 
-	if (err >= 0)
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
 		return;
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
+		return;
+	}
 
 	ext_error = l_genl_msg_get_extended_error(msg);
 	l_error("CMD_SET_CQM failed: %s",
@@ -3662,7 +3712,7 @@ static int netdev_cqm_rssi_update(struct netdev *netdev)
 		return -EINVAL;
 
 	if (!l_genl_family_send(nl80211, msg, netdev_cmd_set_cqm_cb,
-				NULL, NULL)) {
+				netdev, NULL)) {
 		l_genl_msg_unref(msg);
 		return -EIO;
 	}
@@ -4204,18 +4254,21 @@ static int netdev_tx_ft_frame(uint32_t ifindex, uint16_t frame_type,
 					uint32_t frequency, const uint8_t *dest,
 					struct iovec *iov, size_t iov_len)
 {
+
 	struct netdev *netdev = netdev_find(ifindex);
 	struct l_genl_msg *msg = nl80211_build_cmd_frame(netdev->index,
 							frame_type,
 							netdev->addr, dest,
 							frequency,
 							iov, iov_len);
+	uint32_t duration = 200;
 
 	/*
 	 * Even though the kernel is doing offchannel for Authentication this
 	 * flag is still required otherwise the kernel gives -EBUSY.
 	 */
 	l_genl_msg_append_attr(msg, NL80211_ATTR_OFFCHANNEL_TX_OK, 0, NULL);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_DURATION, 4, &duration);
 
 	if (!l_genl_family_send(nl80211, msg, netdev_ft_frame_cb,
 				netdev, NULL)) {
@@ -5260,7 +5313,7 @@ int netdev_set_rssi_report_levels(struct netdev *netdev, const int8_t *levels,
 		return -EINVAL;
 
 	if (!l_genl_family_send(nl80211, cmd_set_cqm, netdev_cmd_set_cqm_cb,
-				NULL, NULL)) {
+				netdev, NULL)) {
 		l_genl_msg_unref(cmd_set_cqm);
 		return -EIO;
 	}
-- 
2.34.1

