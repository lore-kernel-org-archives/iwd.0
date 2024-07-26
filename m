Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A923BBF1
	for <iwd@lists.linux.dev>; Fri, 26 Jul 2024 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722016926; cv=none; b=kpcvkn4J2nPwwe1dFps97QT2nF5lK6Gxty65FWYKUPib804mQXSnEyvHQrp3oxu4vcTgZd297aSwliByvQmVKdIruJYFMRDTOPnJnXTdidILgZnkqb4F2F18C9tkDii+IIPJPwEvfJduhA8WSZH/+Nj9eIEwAcv9/v6CHA+cdn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722016926; c=relaxed/simple;
	bh=/QBvcYRv/QuBLo2peiVZ6trFiOhu6YMZJfPICZCtz+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uZPLTe4av6JZ+8ZkWZmUElQjMPNYs5Cpj8rXg2+OoHYIqpeQjZmSOmHoFa3RLDBoj07YjUOtntBGn7C32SIJFpVCOJXvPRrwqiWgkFIz1C/qybLU3ndRTiIfiesvLDr8kdbgQ67qhSvv28aAMJd0IQmKR8nkDG1PpvoMeLdjZoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GishLNMC; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GishLNMC"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b7a3b75133so6907936d6.2
        for <iwd@lists.linux.dev>; Fri, 26 Jul 2024 11:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722016923; x=1722621723; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcftX5HJW/ffAWLqOplaweDSHLZMd/m9+wbktsfZfmo=;
        b=GishLNMCxZeI+DOgWCEUi0xjcGchnpsSCuV52bymojSyZ3MZPqyO7zEymYNKDxZs2J
         rtBGdmNWdQHRDxOVs03CjzdyR2kCSgSGqe00dpY7Fh9hoRc9pV5d6KhMeMCK/3Zf4QK+
         pQzPBst0EJ8O3OW5H1GKjZMLbSkYXjSxncx56V1EC/YOX9CmRhWOkVK2ouDpbz2AyExh
         Jb4MeP56r4gU+sEZGfz0RtRRicRcbFOYM9s3/SUmEY+/Oa3j8GP66DvicMpfi8IXOGka
         jjdXOJsLrl6kpkq+VuRuHbldgLBdzAlY5ByrZcp097eJiAS1dp/oQH/XasSTktnS/mF9
         TmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722016923; x=1722621723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcftX5HJW/ffAWLqOplaweDSHLZMd/m9+wbktsfZfmo=;
        b=CD2s4reDgO3kMz2M/XMYWwSWXE4OWV8TR8omBwfnT4zRPIQM3ZUFziW3OdjGMdlSMl
         FW77DAqsPBF010XrMSvY1Rx2xnNNPUTpxZStE+obWM17md0cfIWEu2/ew7qOmTmRT7/O
         zQVKlhCMdPmC4Ekjvwm8r+vRuspGzRaz2vIPpIRB3jKrzecd7TRSX6lwOpsqZCUc95cR
         sE2Fc9ZNc4X0Gvg95WZeyLsMQzKjptUlMCMZ98h3fTmV/XwnEQ8wrMUxoNUprYTHInwZ
         uzgsanxvFZZ+ZY6Cs9x1zOI5YTSjet7znSuMCS4U5mxsINGSVL804Yi9fCSbeRLTUEr5
         PB7A==
X-Gm-Message-State: AOJu0YxjngLf7lVhO2JMipDK0/CaQab5FVVxacPMOoS54O9RGdeye8i9
	k1tq61P+WWXjZfnAUp2QkiE7C+K98h+V8kEQBoOuZR+yAdP1NIw8GLd+Yw==
X-Google-Smtp-Source: AGHT+IFjqSuCLrSFFBb53rHiFR3Eb2HFnD8Ry83GlB35X9lJCmXG4JrOHDt2QOOdPNuWveL5x1FMpQ==
X-Received: by 2002:a05:6214:1247:b0:6b4:dd2a:aa44 with SMTP id 6a1803df08f44-6bb55a83e51mr8909176d6.37.1722016923315;
        Fri, 26 Jul 2024 11:02:03 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8fccc8sm18877166d6.46.2024.07.26.11.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 11:02:03 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/3] netdev: fall back to RSSI polling if SET_CQM fails
Date: Fri, 26 Jul 2024 11:01:57 -0700
Message-Id: <20240726180157.1654827-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240726180157.1654827-1-prestwoj@gmail.com>
References: <20240726180157.1654827-1-prestwoj@gmail.com>
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
 src/netdev.c | 147 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 96 insertions(+), 51 deletions(-)

v2:
 * Removed some changes that shouldn't have been in this patch

diff --git a/src/netdev.c b/src/netdev.c
index 2d70fc38..47825c1c 100644
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
@@ -3634,11 +3642,48 @@ static struct l_genl_msg *netdev_build_cmd_cqm_rssi_update(
 
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
@@ -3662,7 +3707,7 @@ static int netdev_cqm_rssi_update(struct netdev *netdev)
 		return -EINVAL;
 
 	if (!l_genl_family_send(nl80211, msg, netdev_cmd_set_cqm_cb,
-				NULL, NULL)) {
+				netdev, NULL)) {
 		l_genl_msg_unref(msg);
 		return -EIO;
 	}
@@ -5260,7 +5305,7 @@ int netdev_set_rssi_report_levels(struct netdev *netdev, const int8_t *levels,
 		return -EINVAL;
 
 	if (!l_genl_family_send(nl80211, cmd_set_cqm, netdev_cmd_set_cqm_cb,
-				NULL, NULL)) {
+				netdev, NULL)) {
 		l_genl_msg_unref(cmd_set_cqm);
 		return -EIO;
 	}
-- 
2.34.1

