Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B546F4A18
	for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 18:25:37 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id s36-20020a17090a69a700b001faad0a7a34so14799234pjj.4
        for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 11:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=6PX1KPJLy9QhdYb+dUhKl10SKVqZTnjeXBMy2BjzQUU=;
        b=Rec7uOfB+18OA+0ACqd8GUCHw8LTn9KavtgBgeNPizkNW/RjcWQCxKenLLRbletAeN
         KPITirCxYN7mYjfbpjg9Vod116P1q2bTMuPtL5v/a07LjjA7j4ZH+L+qCoFq3dtDAWdD
         HWUhCmcdeYtdcAxNQnjolG9BHaAwXSa6pNc8p1goIVenD9KXRU1jnFy3vNoIQk+y484I
         G+tt/21frAvjpfcz8IAs5wSl5oybg1Jadqd9uLkp8V1SItkizLOKs3inahkWboumuEZx
         +g0nzsV4IUCRfVE27C1sNEUAL1SrT9GxMaOIyk+TpPvYHhe0UdlcomlmhsJE8ML0tA3m
         kA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=6PX1KPJLy9QhdYb+dUhKl10SKVqZTnjeXBMy2BjzQUU=;
        b=4vPu+9RbXdJhgW/jPEjpRMpjWCmNkD8MvHu4sx2I/tEx/OZGxOfGGP/TyQBIEVxW5Z
         qcxuwGE5qsjiLv+k3V/oKObZxdMPEnLzb+nrpJsTaRXuvsCfRwdC97hQ/1Ch0qzpqZPQ
         11+1+Da8O9ADbQlTC2RhoR1buTV/ezg/9KwHLlDMJmDfHphzL00Tb2redXyiGlpFvqgO
         NNlzdifjOvRGcp16UqkPcC2+VRvv7tTO0dUFcvPmF95GFF+PBs4AtUyrm8j/GhrkB08H
         mxBymbMtonxmBBgzxOodD7pVGdEyWb7CYAaMtsqF+fLKhNz403Av+3anV8pM4IDB6PC1
         mXZQ==
X-Gm-Message-State: ACgBeo0flYEUTzOGGE8pB1TpPQ2M0y9rw39kyKa8d258utb8VT7ISHEX
	g8kgtzFyOUgsR/0ZwT+CfiN/TktCXhQ=
X-Google-Smtp-Source: AA6agR6L83yADPN30GGaP6GLg4kUEQqYj8DfPdhtHK7erZLDsb/AXWFS4IdLEfz51ywVDni6Vm7C2g==
X-Received: by 2002:a17:90b:3d92:b0:1fb:3854:69d2 with SMTP id pq18-20020a17090b3d9200b001fb385469d2mr5135364pjb.26.1661192737077;
        Mon, 22 Aug 2022 11:25:37 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709026f0100b00172bd4c12b2sm1612024plk.224.2022.08.22.11.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 11:25:36 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 8/9] netdev: pass candidate list for netdev_fast_transition
Date: Mon, 22 Aug 2022 11:25:24 -0700
Message-Id: <20220822182525.2078312-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220822182525.2078312-1-prestwoj@gmail.com>
References: <20220822182525.2078312-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since FT-over-air authentication is done offchannel any failures
during this stage are non-fatal. This means if a BSS target fails
to authenticate for whatever reason IWD can move onto another.

netdev_fast_transition now takes a list of scan_bss candidates,
puts each into the ft_list (just like FT-over-DS) and tries each
in order, proceeding to association on the first successful
authentication. This assumes the candidate list is sorted with the
head of the queue being the best ranked.
---
 src/netdev.c  | 84 +++++++++++++++++++++++++++++++++++++++++----------
 src/netdev.h  |  2 +-
 src/station.c |  2 +-
 3 files changed, 70 insertions(+), 18 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index f38b9c9a..d5e711ef 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4591,6 +4591,25 @@ static const struct wiphy_radio_work_item_ops ft_work_ops = {
 	.do_work = netdev_ft_work_ready,
 };
 
+static bool netdev_send_ft_authenticate(struct netdev *netdev,
+					struct netdev_ft_info *info);
+
+static bool netdev_ft_try_next_bss(struct netdev *netdev)
+{
+	struct netdev_ft_info *info;
+
+	info = l_queue_pop_head(netdev->ft_list);
+	netdev_ft_entry_free(info);
+
+	/* No more candidates */
+	if (l_queue_isempty(netdev->ft_list))
+		return false;
+
+	info = l_queue_peek_head(netdev->ft_list);
+
+	return netdev_send_ft_authenticate(netdev, info);
+}
+
 static void netdev_authenticate_response_ft_cb(const struct mmpdu_header *hdr,
 						const void *body,
 						size_t body_len, int rssi,
@@ -4607,13 +4626,13 @@ static void netdev_authenticate_response_ft_cb(const struct mmpdu_header *hdr,
 					info->super.spa, info->super.aa,
 					info->super.aa, 2, &status,
 					&ies, &ies_len))
-		goto failed;
+		goto next;
 
 	if (status != 0)
-		goto failed;
+		goto next;
 
 	if (!ft_parse_ies(&info->super, netdev->handshake, ies, ies_len))
-		goto failed;
+		goto next;
 
 	/* If we got here authentication was successful, continue with FT */
 	netdev->ap = ft_over_air_sm_new(netdev->handshake,
@@ -4627,11 +4646,17 @@ static void netdev_authenticate_response_ft_cb(const struct mmpdu_header *hdr,
 	wiphy_radio_work_insert(netdev->wiphy, &netdev->work,
 				WIPHY_WORK_PRIORITY_CONNECT, &ft_work_ops);
 
+	l_queue_destroy(netdev->ft_list, netdev_ft_entry_free);
+	netdev->ft_list = NULL;
+
 	return;
 
-failed:
-	netdev_connect_failed(netdev, NETDEV_RESULT_ABORTED,
-					MMPDU_STATUS_CODE_UNSPECIFIED);
+next:
+	if (netdev_ft_try_next_bss(netdev))
+		return;
+
+	netdev_connect_failed(netdev, NETDEV_RESULT_AUTHENTICATION_FAILED,
+				MMPDU_STATUS_CODE_UNSPECIFIED);
 }
 
 static const struct frame_xchg_prefix ft_prefix = {
@@ -4644,9 +4669,14 @@ static void netdev_cmd_authenticate_ft_cb(int err, void *user_data)
 {
 	struct netdev_ft_info *info = user_data;
 
-	if (err < 0)
-		netdev_connect_failed(info->netdev,
-					NETDEV_RESULT_AUTHENTICATION_FAILED,
+	if (err == 0)
+		return;
+
+	if (netdev_ft_try_next_bss(info->netdev))
+		return;
+
+	netdev_connect_failed(info->netdev, NETDEV_RESULT_AUTHENTICATION_FAILED,
+					MMPDU_STATUS_CODE_UNSPECIFIED);
 }
 
 static bool netdev_send_ft_authenticate(struct netdev *netdev,
@@ -4728,26 +4758,48 @@ static struct netdev_ft_info *netdev_ft_info_new(struct netdev *netdev,
 }
 
 int netdev_fast_transition(struct netdev *netdev,
-				const struct scan_bss *target_bss,
+				struct l_queue *candidates,
 				const struct scan_bss *orig_bss,
 				netdev_connect_cb_t cb)
 {
 	struct netdev_ft_info *info;
+	const struct l_queue_entry *entry;
 
 	if (!netdev->operational)
 		return -ENOTCONN;
 
-	if (!netdev->handshake->mde || !target_bss->mde_present ||
-			l_get_le16(netdev->handshake->mde + 2) !=
-			l_get_le16(target_bss->mde))
+	if (!netdev->handshake->mde)
 		return -EINVAL;
 
-	netdev->connect_cb = cb;
+	/* Initialize info for all candidates */
+	for (entry = l_queue_get_entries(candidates); entry;
+						entry = entry->next) {
+		struct scan_bss *bss = entry->data;
 
-	info = netdev_ft_info_new(netdev, target_bss);
+		if (!bss->mde_present ||
+				l_get_le16(netdev->handshake->mde + 2) !=
+				l_get_le16(bss->mde))
+			continue;
+
+		info = netdev_ft_info_new(netdev, bss);
+
+		if (!netdev->ft_list)
+			netdev->ft_list = l_queue_new();
+
+		l_queue_push_tail(netdev->ft_list, info);
+	}
+
+	if (l_queue_isempty(netdev->ft_list))
+		return -EINVAL;
+
+	/* Begin with first candidate */
+	info = l_queue_peek_head(netdev->ft_list);
+
+	netdev->connect_cb = cb;
 
 	if (!netdev_send_ft_authenticate(netdev, info)) {
-		netdev_ft_entry_free(info);
+		l_queue_destroy(netdev->ft_list, netdev_ft_entry_free);
+		netdev->ft_list = NULL;
 		return -EBADMSG;
 	}
 
diff --git a/src/netdev.h b/src/netdev.h
index d13bc5e6..f5818350 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -164,7 +164,7 @@ int netdev_reassociate(struct netdev *netdev, struct scan_bss *target_bss,
 			netdev_event_func_t event_filter,
 			netdev_connect_cb_t cb, void *user_data);
 int netdev_fast_transition(struct netdev *netdev,
-				const struct scan_bss *target_bss,
+				struct l_queue *candidates,
 				const struct scan_bss *orig_bss,
 				netdev_connect_cb_t cb);
 int netdev_fast_transition_over_ds_action(struct netdev *netdev,
diff --git a/src/station.c b/src/station.c
index 601c3916..1f0330b1 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2238,7 +2238,7 @@ static void station_transition_start(struct station *station,
 			}
 		} else {
 try_over_air:
-			if (netdev_fast_transition(station->netdev, bss,
+			if (netdev_fast_transition(station->netdev, candidates,
 					station->connected_bss,
 					station_fast_transition_cb) < 0) {
 				station_roam_failed(station);
-- 
2.34.3

