Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8640191F86
	for <iwd@lists.linux.dev>; Thu, 29 Aug 2024 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931670; cv=none; b=k2fQ6HTE280frZgKjxciAX6PX5s8t8VMJcJESwEWVikdyzPpD3tNpaTzyXD3Nmp4vr8pP3u8LrOJji9QyS0oUeD0EnHJBL7Zezkq+mDXEYw8THL1ofQCz9KjS3j3ukvTEqrsPY08K9L7WvoTb9Tzqdblp8m6mv73nS+epF+CD4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931670; c=relaxed/simple;
	bh=7cT5JcsGKVY6X7cDZ4Pk/Ji9Jze9qLAcCSURUEn+GCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cbc1frtJJdVneK3V8k0K0pJUJU7pR6BkrnNR4GI9IB/wB2uTkBfnal//tYbK4+/dzz4TFqJZcfTYEVqWXrc0m/aZ9FOwqlFxshf5CSz3q57gPRgLMXj+826E5APqDvhHwkxE61PKZqN+0rlrtfHQCjyzaOBw8zUysazEfghlI+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwZJv/bR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwZJv/bR"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-201e64607a5so4069665ad.2
        for <iwd@lists.linux.dev>; Thu, 29 Aug 2024 04:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724931668; x=1725536468; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5OfJAe8ZW64mX7Q04gXNdWXbJK9ByzUW3zTM/JAWUs=;
        b=lwZJv/bReOspvKk2AbQwN9dkzAUrO4ufL4kmRDikeFqG21Skou+GW9nrwc8KHxOrAZ
         0BHb4/hTk16cRPy++BjIUdfpnd9RAa+4oo3J15qi6I3Hbu/TuKbYreFh4hUsLu+0IKrv
         iWKWceCBzm8s8AQ27Fo3fU3kU/ONjq7BlCsOIXJ3w1RAinhMfzQKoQFWmuVHxCQzUklq
         wkT6iCJLQmzRamXohWmymyaoVSUorErUQVOVvKZbX/xoTEFxkQjctgkTM3YtzjUOQnVB
         RZUVmJgJob6Etb4OumON3I7qkCodXAdz1YBLvGq5JsRLmV3YWW/L7OkGvwsyp2HZBozG
         Om8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724931668; x=1725536468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5OfJAe8ZW64mX7Q04gXNdWXbJK9ByzUW3zTM/JAWUs=;
        b=dSWcplK45ucVMrTyKifLa9sSLdPAfvFp1z8Aw2MuW7BfDcg5z5dVze4W2SDg57pSVK
         50UsT8PEXvRIN677s93mN731s5zsRZpH+8Cjp1WMdT1tOkFPKbv0p1Cacd5pg8ZJW1/a
         AvA1lqYQZOzxdElSh5E0o154TZx8LfBiFRqfArFFm5obPjkKZOiU2xMNIi9UoY5SaiUG
         iAmTz+Ua2YbKfKiPX/8kFwxoo4NugTiMEsqhMYzJZmrvl2iCfwIMAcgMVgSvbNSq3vPE
         9lVsaqjyMpxCvQjbcTjTDx39DFHCSFRZFJJ3CWKq2dtBhyKM/eobO/+IMZbTM1Vv+XPf
         HNnQ==
X-Gm-Message-State: AOJu0YxDXjH8zXSiZiLWzBt+QgJ1+pyaVmV78qO7P3GXTobj+4fZFp82
	3HabaIDkZFkm7j3L3bG02+zQec/rkPJmFUqOSBPHA132npCKQjNZ+Xo5ZQ==
X-Google-Smtp-Source: AGHT+IFeF/BkpFEioR80qbOEhy10z86brzfhcIyBQnQ3pyUMCs+SHaIpmUN1soABZff1DuEHT0NqeQ==
X-Received: by 2002:a17:902:e807:b0:202:1bf1:b96d with SMTP id d9443c01a7336-2050c34303fmr25525035ad.27.1724931667805;
        Thu, 29 Aug 2024 04:41:07 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b37d5sm9699315ad.25.2024.08.29.04.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 04:41:06 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 3/3] netdev: fall back to RSSI polling if SET_CQM fails
Date: Thu, 29 Aug 2024 04:41:02 -0700
Message-Id: <20240829114102.56284-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829114102.56284-1-prestwoj@gmail.com>
References: <20240829114102.56284-1-prestwoj@gmail.com>
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
 src/netdev.c | 142 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 94 insertions(+), 48 deletions(-)

v3:
 * Rebaed on top of upstream

diff --git a/src/netdev.c b/src/netdev.c
index 73fbf0c1..a3f72deb 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -190,6 +190,7 @@ struct netdev {
 	bool retry_auth : 1;
 	bool in_reassoc : 1;
 	bool privacy : 1;
+	bool cqm_poll_fallback : 1;
 };
 
 struct netdev_preauth_state {
@@ -650,6 +651,47 @@ static void netdev_set_rssi_level_idx(struct netdev *netdev)
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
@@ -686,11 +728,16 @@ static void netdev_rssi_poll_cb(struct l_genl_msg *msg, void *user_data)
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
@@ -1039,6 +1086,9 @@ static void netdev_free(void *data)
 		netdev->get_link_cmd_id = 0;
 	}
 
+	if (netdev->rssi_poll_timeout)
+		l_timeout_remove(netdev->rssi_poll_timeout);
+
 	scan_wdev_remove(netdev->wdev_id);
 
 	watchlist_destroy(&netdev->station_watches);
@@ -1093,47 +1143,6 @@ static void netdev_cqm_event_rssi_threshold(struct netdev *netdev,
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
@@ -3644,11 +3653,48 @@ static struct l_genl_msg *netdev_build_cmd_cqm_rssi_update(
 
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
@@ -3672,7 +3718,7 @@ static int netdev_cqm_rssi_update(struct netdev *netdev)
 		return -EINVAL;
 
 	if (!l_genl_family_send(nl80211, msg, netdev_cmd_set_cqm_cb,
-				NULL, NULL)) {
+				netdev, NULL)) {
 		l_genl_msg_unref(msg);
 		return -EIO;
 	}
@@ -5310,7 +5356,7 @@ int netdev_set_rssi_report_levels(struct netdev *netdev, const int8_t *levels,
 		return -EINVAL;
 
 	if (!l_genl_family_send(nl80211, cmd_set_cqm, netdev_cmd_set_cqm_cb,
-				NULL, NULL)) {
+				netdev, NULL)) {
 		l_genl_msg_unref(cmd_set_cqm);
 		return -EIO;
 	}
-- 
2.34.1

