Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D702565
	for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 22:32:06 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id s90-20020a17090a2f6300b00203a685a1aaso262970pjd.1
        for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 15:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=tlHKvA+8VVh6f5ilKAureZC/XYCx5kGAHA554tEsG3A=;
        b=R2Zypm6DhWnZzg+JnVWGg08jAC5DRsmL2dBlR6hTsDDgkq+L/j0EQDUuOKu1bPl5BB
         Xd5CHvfBIB8NMGRqLi8TRkkTMHXc3oo7mny8L1ih9JJ9sRhGVkUwMO3qd7v8FS8mXSHD
         xIeQ+XdAauHYAUIh5zvIox/V+9rdWbl+CrWcS/7a69bwle7Y4W2m36nuQOTMWVlJqDhc
         QMV+T5Orfqu0uw7LjbP8jAit+RGw1E3NwFERvW00acRGrfuOQDJidDs2jrOcw41xl1jz
         VPoTTJyDFNZ2Xk2uhkoGG75F1CzL5J4uZbLkfTc5cBq1Xa/O/6+zJOj9DmT3D4mc2XV7
         SolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=tlHKvA+8VVh6f5ilKAureZC/XYCx5kGAHA554tEsG3A=;
        b=hJgebCUCg4GCkoh1vq31/187AGqFcLqjqY66XfjPjAFz0mHuFlqzPszaMdOu7z7cSI
         8azYfZuTIF1l3DIACZHWmOG/Zq2NDz8iMRsautiGGDpXrT8rwqNkrSte9rG2uOCEmjLZ
         6TcqC0J242foBzxKm+N2H63q7K/ZouQ/9GJJTCgk6pM9JcMVrReNoOSuHRk/Ymqf8VGb
         PICLiXj3jaJlJuCdK5sx40WbJ9dw7ByPxs5EXXI8ZsxXP4cMQHnv02enEgzNJ4AhtPOu
         sDDitwBgKqCcXIvSVPGpruzuUdmiPID7er3l8dBnpJeGXK9RVjIzQtBDYDL7mmDWMmAq
         4XBA==
X-Gm-Message-State: ACrzQf0LJjPill4UZWBoiKmMmw6p5L621VkI+DufcE3MNAlNYAv7lCj7
	Obutnc0Iu+lyAZPNkXq6Y+CUCIXovs4=
X-Google-Smtp-Source: AMsMyM40nEuTQHB1LmSe6kXYJCpDOUKpe8LBrjpVcFdjKjnj9qkykwgtTIoNxslArHHoWRdHBcOYNQ==
X-Received: by 2002:a17:90a:74c4:b0:203:336d:dd36 with SMTP id p4-20020a17090a74c400b00203336ddd36mr11705707pjl.107.1663799525778;
        Wed, 21 Sep 2022 15:32:05 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id r10-20020a63e50a000000b00438c0571456sm2393135pgh.24.2022.09.21.15.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 15:32:05 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 09/15] netdev: hook in RX for FT-Action/Authentication/Association
Date: Wed, 21 Sep 2022 15:31:52 -0700
Message-Id: <20220921223158.704658-9-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220921223158.704658-1-prestwoj@gmail.com>
References: <20220921223158.704658-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This forwards Action, Authentication and Association frames to
ft.c via their new hooks in netdev.

Note that this will break FT-over-Air temporarily since the
auth-proto still is in use.
---
 src/netdev.c | 147 ++++++++++++++++++++++-----------------------------
 1 file changed, 64 insertions(+), 83 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 60d832d2..e14fb7cc 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3192,13 +3192,15 @@ static void netdev_associate_event(struct l_genl_msg *msg,
 	const uint8_t *frame = NULL;
 	uint16_t status_code = MMPDU_STATUS_CODE_UNSPECIFIED;
 	int ret;
+	const struct mmpdu_header *hdr;
+	const struct mmpdu_association_response *assoc;
 
 	l_debug("");
 
 	if (!netdev->connected || netdev->aborting)
 		return;
 
-	if (!netdev->ap) {
+	if (!netdev->ap && !netdev->in_ft) {
 		netdev->associated = true;
 		netdev->in_reassoc = false;
 		return;
@@ -3238,61 +3240,59 @@ static void netdev_associate_event(struct l_genl_msg *msg,
 	if (L_WARN_ON(!frame))
 		goto assoc_failed;
 
-	if (netdev->ap) {
-		const struct mmpdu_header *hdr;
-		const struct mmpdu_association_response *assoc;
-
-		hdr = mpdu_validate(frame, frame_len);
-		if (L_WARN_ON(!hdr))
-			goto assoc_failed;
-
-		assoc = mmpdu_body(hdr);
-		status_code = L_CPU_TO_LE16(assoc->status_code);
+	hdr = mpdu_validate(frame, frame_len);
+	if (L_WARN_ON(!hdr))
+		goto assoc_failed;
 
-		ret = auth_proto_rx_associate(netdev->ap, frame, frame_len);
-		if (ret == 0) {
-			bool fils = !!(netdev->handshake->akm_suite &
-					(IE_RSN_AKM_SUITE_FILS_SHA256 |
-					 IE_RSN_AKM_SUITE_FILS_SHA384 |
-					 IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384 |
-					 IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256));
+	assoc = mmpdu_body(hdr);
+	status_code = L_CPU_TO_LE16(assoc->status_code);
 
+	if (netdev->ap)
+		ret = auth_proto_rx_associate(netdev->ap, frame,
+							frame_len);
+	else
+		ret = __ft_rx_associate(netdev->index, frame,
+							frame_len);
+	if (ret == 0) {
+		bool fils = !!(netdev->handshake->akm_suite &
+				(IE_RSN_AKM_SUITE_FILS_SHA256 |
+				 IE_RSN_AKM_SUITE_FILS_SHA384 |
+				 IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384 |
+				 IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256));
+
+		if (netdev->ap) {
 			auth_proto_free(netdev->ap);
 			netdev->ap = NULL;
+		}
 
-			netdev->sm = eapol_sm_new(netdev->handshake);
-			eapol_register(netdev->sm);
-
-			/* Just in case this was a retry */
-			netdev->ignore_connect_event = false;
-
-			/*
-			 * If in FT and/or FILS we don't force an initial 4-way
-			 * handshake and instead just keep the EAPoL state
-			 * machine for the rekeys.
-			 */
-			if (netdev->in_ft || fils)
-				eapol_sm_set_require_handshake(netdev->sm,
-								false);
+		netdev->sm = eapol_sm_new(netdev->handshake);
+		eapol_register(netdev->sm);
 
-			netdev->in_ft = false;
-			netdev->in_reassoc = false;
-			netdev->associated = true;
-			return;
-		} else if (ret == -EAGAIN) {
-			/*
-			 * Here to support OWE retries. OWE will retry
-			 * internally, but a connect event will still be emitted
-			 */
-			netdev->ignore_connect_event = true;
-			return;
-		} else if (ret > 0)
-			status_code = (uint16_t)ret;
+		/* Just in case this was a retry */
+		netdev->ignore_connect_event = false;
 
-		goto assoc_failed;
-	}
+		/*
+		 * If in FT and/or FILS we don't force an initial 4-way
+		 * handshake and instead just keep the EAPoL state
+		 * machine for the rekeys.
+		 */
+		if (netdev->in_ft || fils)
+			eapol_sm_set_require_handshake(netdev->sm,
+							false);
 
-	return;
+		netdev->in_ft = false;
+		netdev->in_reassoc = false;
+		netdev->associated = true;
+		return;
+	} else if (ret == -EAGAIN) {
+		/*
+		 * Here to support OWE retries. OWE will retry
+		 * internally, but a connect event will still be emitted
+		 */
+		netdev->ignore_connect_event = true;
+		return;
+	} else if (ret > 0)
+		status_code = (uint16_t)ret;
 
 assoc_failed:
 	netdev->result = NETDEV_RESULT_ASSOCIATION_FAILED;
@@ -4578,49 +4578,25 @@ static void netdev_ft_response_frame_event(const struct mmpdu_header *hdr,
 					int rssi, void *user_data)
 {
 	struct netdev *netdev = user_data;
-	struct netdev_ft_over_ds_info *info;
-	int ret;
-	uint16_t status_code = MMPDU_STATUS_CODE_UNSPECIFIED;
-	const uint8_t *aa;
-	const uint8_t *spa;
-	const uint8_t *ies;
-	size_t ies_len;
-	struct ft_ds_finder finder;
 
 	if (!netdev->connected)
 		return;
 
-	ret = ft_over_ds_parse_action_response(body, body_len, &spa, &aa,
-						&ies, &ies_len);
-	if (ret < 0)
-		return;
+	__ft_rx_action(netdev->index, (const uint8_t *)hdr,
+			mmpdu_header_len(hdr) + body_len);
+}
 
-	finder.spa = spa;
-	finder.aa = aa;
+static void netdev_ft_auth_response_frame_event(const struct mmpdu_header *hdr,
+					const void *body, size_t body_len,
+					int rssi, void *user_data)
+{
+	struct netdev *netdev = user_data;
 
-	info = l_queue_find(netdev->ft_ds_list, match_ft_ds_info, &finder);
-	if (!info)
+	if (!netdev->connected)
 		return;
 
-	/* Lookup successful, now check the status code */
-	if (ret > 0) {
-		status_code = (uint16_t)ret;
-		goto ft_error;
-	}
-
-	if (!ft_over_ds_parse_action_ies(&info->super, netdev->handshake,
-						ies, ies_len))
-		goto ft_error;
-
-	info->parsed = true;
-
-	return;
-
-ft_error:
-	l_debug("FT-over-DS to "MAC" failed (%d)", MAC_STR(info->super.aa),
-			status_code);
-
-	netdev_ft_over_ds_auth_failed(info, status_code);
+	__ft_rx_authenticate(netdev->index, (const uint8_t *)hdr,
+			mmpdu_header_len(hdr) + body_len);
 }
 
 static void netdev_qos_map_frame_event(const struct mmpdu_header *hdr,
@@ -5846,6 +5822,7 @@ static void netdev_add_station_frame_watches(struct netdev *netdev)
 	static const uint8_t action_sa_query_resp_prefix[2] = { 0x08, 0x01 };
 	static const uint8_t action_sa_query_req_prefix[2] = { 0x08, 0x00 };
 	static const uint8_t action_ft_response_prefix[] =  { 0x06, 0x02 };
+	static const uint8_t auth_ft_response_prefix[] = { 0x02, 0x00 };
 	static const uint8_t action_qos_map_prefix[] = { 0x01, 0x04 };
 	uint64_t wdev = netdev->wdev_id;
 
@@ -5866,6 +5843,10 @@ static void netdev_add_station_frame_watches(struct netdev *netdev)
 			sizeof(action_ft_response_prefix),
 			netdev_ft_response_frame_event, netdev, NULL);
 
+	frame_watch_add(wdev, 0, 0x00b0, auth_ft_response_prefix,
+			sizeof(auth_ft_response_prefix),
+			netdev_ft_auth_response_frame_event, netdev, NULL);
+
 	if (wiphy_supports_qos_set_map(netdev->wiphy))
 		frame_watch_add(wdev, 0, 0x00d0, action_qos_map_prefix,
 				sizeof(action_qos_map_prefix),
-- 
2.34.3

