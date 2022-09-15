Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E8C4C9E
	for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 22:07:55 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id i19so15302010pgi.1
        for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 15:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=1hHLQylUsIMg1K9ZAn831mw5Lh4tyc5QzZD7nA9kWHU=;
        b=dOUX2B8npsykap0PZY1Ly5VAE8sd+Jm+9f+IbwDt6m7B8FSomLyGrj5dAAEmCKQmOC
         tEqoYaqSDo9Ajx442H/+wWgLv7SzwlQN8iN/dlA+w1qbUpqhV1z8X6+Mj5T8XH+YopaP
         BNVG73KcMlTt5op/jVjEKqdUsXGV2q4RNlKHz6P+PHW9/IdeWtiYsgAZkB/vkogDXeOX
         CbEE3W4H+tdLpaR2tDEdV0fwDnM9yGgCCbH5DbQg/hHGxnVLW6EbXLU3KRiMwBaVDapf
         0xjyU/FSZ6mtsWa1QsnsKtC88BU2cM2F7AdNZCwcpOQ+cC0oSQMMAPshxnEVMmJ8h+xg
         JxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1hHLQylUsIMg1K9ZAn831mw5Lh4tyc5QzZD7nA9kWHU=;
        b=jtD1+ikFsyzUbIRdmK1lIR1bTD/OYlKsNJ8h2ptShZ1vqIpmMuf7B6yeYccOfCI3Tp
         xLHD0KDWVY0d3brM687CfyI2MlP6PyPu70+deSfTkEhpRRnNZf1yQhqHtDUFDaL3S066
         KjPXBkPwWCUu/EH0ycVs//JEi+dvbe3LlQlFp+43TkLvAUqohgI7hrznfoRuDDeauNme
         hHN/fobjRtU66VSYKaxvyhPFzcssKvCWBX8besOv7UFsJeLjBtlnLh1F5GThugyFLGx7
         XqSJEbPt73R7sZ1/eydwPgQ4QgWqmK6n4i35gbs9Gbu6nnw2DfYrmoDrZ/8IPSlFbNoW
         w+6Q==
X-Gm-Message-State: ACrzQf3IG0QIWcjFjLvnSGcTGGZPd5v+LX89arCLo5nAUWos0I0j5pUl
	pfzzziRWKESNOGoA5WrZRmWloGbraGI=
X-Google-Smtp-Source: AMsMyM4eOavWCA22lcX6OvBGT7BWkAa7ECAJfkL9n/aWi1c3W0DdiLL7PCU+iL8bmUqb4vt809/IaA==
X-Received: by 2002:aa7:8393:0:b0:537:701d:e7f3 with SMTP id u19-20020aa78393000000b00537701de7f3mr1604514pfm.50.1663279675170;
        Thu, 15 Sep 2022 15:07:55 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id k2-20020a6555c2000000b0041c0c9c0072sm12147165pgs.64.2022.09.15.15.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 15:07:54 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 06/14] netdev: use new ft_sm for over-DS
Date: Thu, 15 Sep 2022 15:07:33 -0700
Message-Id: <20220915220741.1128728-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220915220741.1128728-1-prestwoj@gmail.com>
References: <20220915220741.1128728-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FT-over-DS auth entries are now stored in ft.c itself, and a few APIs
are exposed to send the action/associate frames. This is duplicated
in netdev, which can now be removed. Currently FT-over-Air still
uses the auth-proto which has been left in place for now.

The basic flow remains the same, station initiates action frames to
possible roam candidates. Authentication takes place and the IEs
are stored in ft.c. Then, when a roam is required, association may
begin using one of the cached authentications.
---
 src/netdev.c | 255 +++++++++------------------------------------------
 1 file changed, 43 insertions(+), 212 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 03b384bb..2519feda 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -96,13 +96,6 @@ struct netdev_handshake_state {
 	enum connection_type type;
 };
 
-struct netdev_ft_over_ds_info {
-	struct ft_ds_info super;
-	struct netdev *netdev;
-
-	bool parsed : 1;
-};
-
 struct netdev_ext_key_info {
 	uint16_t proto;
 	bool noencrypt;
@@ -128,6 +121,7 @@ struct netdev {
 	struct eapol_sm *sm;
 	struct auth_proto *ap;
 	struct owe_sm *owe_sm;
+	struct ft_sm *ft_sm;
 	struct handshake_state *handshake;
 	uint32_t connect_cmd_id;
 	uint32_t disconnect_cmd_id;
@@ -176,8 +170,6 @@ struct netdev {
 	struct l_genl_msg *auth_cmd;
 	struct wiphy_radio_work_item work;
 
-	struct l_queue *ft_ds_list;
-
 	struct netdev_ext_key_info *ext_key_info;
 
 	bool connected : 1;
@@ -752,13 +744,6 @@ static void netdev_preauth_destroy(void *data)
 	l_free(state);
 }
 
-static void netdev_ft_ds_entry_free(void *data)
-{
-	struct netdev_ft_over_ds_info *info = data;
-
-	ft_ds_info_free(&info->super);
-}
-
 static void netdev_connect_free(struct netdev *netdev)
 {
 	if (netdev->work.id)
@@ -779,6 +764,11 @@ static void netdev_connect_free(struct netdev *netdev)
 		netdev->owe_sm = NULL;
 	}
 
+	if (netdev->ft_sm) {
+		ft_sm_free(netdev->ft_sm);
+		netdev->ft_sm = NULL;
+	}
+
 	eapol_preauth_cancel(netdev->index);
 
 	if (netdev->handshake) {
@@ -847,11 +837,6 @@ static void netdev_connect_free(struct netdev *netdev)
 		l_genl_family_cancel(nl80211, netdev->get_oci_cmd_id);
 		netdev->get_oci_cmd_id = 0;
 	}
-
-	if (netdev->ft_ds_list) {
-		l_queue_destroy(netdev->ft_ds_list, netdev_ft_ds_entry_free);
-		netdev->ft_ds_list = NULL;
-	}
 }
 
 static void netdev_connect_failed(struct netdev *netdev,
@@ -962,11 +947,6 @@ static void netdev_free(void *data)
 	if (netdev->fw_roam_bss)
 		scan_bss_free(netdev->fw_roam_bss);
 
-	if (netdev->ft_ds_list) {
-		l_queue_destroy(netdev->ft_ds_list, netdev_ft_ds_entry_free);
-		netdev->ft_ds_list = NULL;
-	}
-
 	scan_wdev_remove(netdev->wdev_id);
 
 	watchlist_destroy(&netdev->station_watches);
@@ -1415,9 +1395,12 @@ static void netdev_connect_ok(struct netdev *netdev)
 		netdev->fw_roam_bss = NULL;
 	}
 
-	if (netdev->ft_ds_list) {
-		l_queue_destroy(netdev->ft_ds_list, netdev_ft_ds_entry_free);
-		netdev->ft_ds_list = NULL;
+	/* TODO: Create only for over-DS. Over-air still uses auth-proto */
+	if (netdev->handshake->mde && (netdev->handshake->mde[4] & 1)) {
+		if (netdev->ft_sm)
+			ft_sm_free(netdev->ft_sm);
+
+		netdev->ft_sm = ft_sm_new(netdev->handshake);
 	}
 
 	if (netdev->connect_cb) {
@@ -3198,7 +3181,7 @@ static void netdev_associate_event(struct l_genl_msg *msg,
 	if (!netdev->connected || netdev->aborting)
 		return;
 
-	if (!netdev->ap) {
+	if (!netdev->ap && !netdev->ft_sm) {
 		netdev->associated = true;
 		netdev->in_reassoc = false;
 		return;
@@ -3238,7 +3221,7 @@ static void netdev_associate_event(struct l_genl_msg *msg,
 	if (L_WARN_ON(!frame))
 		goto assoc_failed;
 
-	if (netdev->ap) {
+	if (netdev->ap || netdev->ft_sm) {
 		const struct mmpdu_header *hdr;
 		const struct mmpdu_association_response *assoc;
 
@@ -3249,7 +3232,12 @@ static void netdev_associate_event(struct l_genl_msg *msg,
 		assoc = mmpdu_body(hdr);
 		status_code = L_CPU_TO_LE16(assoc->status_code);
 
-		ret = auth_proto_rx_associate(netdev->ap, frame, frame_len);
+		if (netdev->ap)
+			ret = auth_proto_rx_associate(netdev->ap, frame,
+							frame_len);
+		else
+			ret = __ft_rx_associate(netdev->index, frame,
+							frame_len);
 		if (ret == 0) {
 			bool fils = !!(netdev->handshake->akm_suite &
 					(IE_RSN_AKM_SUITE_FILS_SHA256 |
@@ -3257,8 +3245,10 @@ static void netdev_associate_event(struct l_genl_msg *msg,
 					 IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384 |
 					 IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256));
 
-			auth_proto_free(netdev->ap);
-			netdev->ap = NULL;
+			if (netdev->ap) {
+				auth_proto_free(netdev->ap);
+				netdev->ap = NULL;
+			}
 
 			netdev->sm = eapol_sm_new(netdev->handshake);
 			eapol_register(netdev->sm);
@@ -4533,81 +4523,6 @@ static void prepare_ft(struct netdev *netdev, const struct scan_bss *target_bss)
 	}
 }
 
-static void netdev_ft_over_ds_auth_failed(struct netdev_ft_over_ds_info *info,
-						uint16_t status)
-{
-	l_queue_remove(info->netdev->ft_ds_list, info);
-	ft_ds_info_free(&info->super);
-}
-
-struct ft_ds_finder {
-	const uint8_t *spa;
-	const uint8_t *aa;
-};
-
-static bool match_ft_ds_info(const void *a, const void *b)
-{
-	const struct netdev_ft_over_ds_info *info = a;
-	const struct ft_ds_finder *finder = b;
-
-	if (memcmp(info->super.spa, finder->spa, 6))
-		return false;
-	if (memcmp(info->super.aa, finder->aa, 6))
-		return false;
-
-	return true;
-}
-
-static void netdev_ft_response_frame_event(const struct mmpdu_header *hdr,
-					const void *body, size_t body_len,
-					int rssi, void *user_data)
-{
-	struct netdev *netdev = user_data;
-	struct netdev_ft_over_ds_info *info;
-	int ret;
-	uint16_t status_code = MMPDU_STATUS_CODE_UNSPECIFIED;
-	const uint8_t *aa;
-	const uint8_t *spa;
-	const uint8_t *ies;
-	size_t ies_len;
-	struct ft_ds_finder finder;
-
-	if (!netdev->connected)
-		return;
-
-	ret = ft_over_ds_parse_action_response(body, body_len, &spa, &aa,
-						&ies, &ies_len);
-	if (ret < 0)
-		return;
-
-	finder.spa = spa;
-	finder.aa = aa;
-
-	info = l_queue_find(netdev->ft_ds_list, match_ft_ds_info, &finder);
-	if (!info)
-		return;
-
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
-}
-
 static void netdev_qos_map_frame_event(const struct mmpdu_header *hdr,
 					const void *body, size_t body_len,
 					int rssi, void *user_data)
@@ -4634,16 +4549,23 @@ static bool netdev_ft_work_ready(struct wiphy_radio_work_item *item)
 {
 	struct netdev *netdev = l_container_of(item, struct netdev, work);
 
-	if (!auth_proto_start(netdev->ap)) {
-		/* Restore original nonce */
-		memcpy(netdev->handshake->snonce, netdev->prev_snonce, 32);
+	if (netdev->ft_sm) {
+		if (ft_associate(netdev->ft_sm, netdev->handshake->aa))
+			goto assoc_failed;
 
-		netdev_connect_failed(netdev, NETDEV_RESULT_ABORTED,
-						MMPDU_STATUS_CODE_UNSPECIFIED);
-		return true;
+		return false;
 	}
 
-	return false;
+	if (auth_proto_start(netdev->ap))
+		return false;
+
+assoc_failed:
+	/* Restore original nonce */
+	memcpy(netdev->handshake->snonce, netdev->prev_snonce, 32);
+
+	netdev_connect_failed(netdev, NETDEV_RESULT_ABORTED,
+						MMPDU_STATUS_CODE_UNSPECIFIED);
+	return true;
 }
 
 static const struct wiphy_radio_work_item_ops ft_work_ops = {
@@ -4684,124 +4606,38 @@ int netdev_fast_transition_over_ds(struct netdev *netdev,
 					const struct scan_bss *orig_bss,
 					netdev_connect_cb_t cb)
 {
-	struct netdev_ft_over_ds_info *info;
-	struct ft_ds_finder finder;
-
 	if (!netdev->operational)
 		return -ENOTCONN;
 
-	if (!netdev->handshake->mde || !target_bss->mde_present ||
+	if (!netdev->ft_sm || !netdev->handshake->mde ||
+			!target_bss->mde_present ||
 			l_get_le16(netdev->handshake->mde + 2) !=
 			l_get_le16(target_bss->mde))
 		return -EINVAL;
 
-	finder.spa = netdev->addr;
-	finder.aa = target_bss->addr;
-
-	info = l_queue_find(netdev->ft_ds_list, match_ft_ds_info, &finder);
-
-	if (!info || !info->parsed)
-		return -ENOENT;
-
 	netdev->connect_cb = cb;
 
-	netdev->ap = ft_over_ds_sm_new(netdev->handshake,
-					netdev_ft_tx_associate,
-					netdev);
 	prepare_ft(netdev, target_bss);
 
-	ft_over_ds_prepare_handshake(&info->super, netdev->handshake);
-
 	wiphy_radio_work_insert(netdev->wiphy, &netdev->work,
 				WIPHY_WORK_PRIORITY_CONNECT, &ft_work_ops);
 
 	return 0;
 }
 
-static void netdev_ft_request_cb(struct l_genl_msg *msg, void *user_data)
-{
-	struct netdev_ft_over_ds_info *info = user_data;
-
-	if (l_genl_msg_get_error(msg) < 0) {
-		l_error("Could not send CMD_FRAME for FT-over-DS");
-		netdev_ft_over_ds_auth_failed(info,
-					MMPDU_STATUS_CODE_UNSPECIFIED);
-	}
-}
-
-static void netdev_ft_ds_info_free(struct ft_ds_info *ft)
-{
-	struct netdev_ft_over_ds_info *info = l_container_of(ft,
-					struct netdev_ft_over_ds_info, super);
-
-	l_free(info);
-}
-
 int netdev_fast_transition_over_ds_action(struct netdev *netdev,
 					const struct scan_bss *target_bss)
 {
-	struct netdev_ft_over_ds_info *info;
-	uint8_t ft_req[14];
-	struct handshake_state *hs = netdev->handshake;
-	struct iovec iovs[5];
-	uint8_t buf[512];
-	size_t len;
-
 	if (!netdev->operational)
 		return -ENOTCONN;
 
-	if (!netdev->handshake->mde || !target_bss->mde_present ||
+	if (!netdev->ft_sm || !netdev->handshake->mde ||
+			!target_bss->mde_present ||
 			l_get_le16(netdev->handshake->mde + 2) !=
 			l_get_le16(target_bss->mde))
 		return -EINVAL;
 
-	l_debug("");
-
-	info = l_new(struct netdev_ft_over_ds_info, 1);
-	info->netdev = netdev;
-
-	memcpy(info->super.spa, hs->spa, ETH_ALEN);
-	memcpy(info->super.aa, target_bss->addr, ETH_ALEN);
-	memcpy(info->super.mde, target_bss->mde, sizeof(info->super.mde));
-
-	if (target_bss->rsne)
-		info->super.authenticator_ie = l_memdup(target_bss->rsne,
-						target_bss->rsne[1] + 2);
-
-	l_getrandom(info->super.snonce, 32);
-	info->super.free = netdev_ft_ds_info_free;
-
-	ft_req[0] = 6; /* FT category */
-	ft_req[1] = 1; /* FT Request action */
-	memcpy(ft_req + 2, netdev->addr, 6);
-	memcpy(ft_req + 8, info->super.aa, 6);
-
-	iovs[0].iov_base = ft_req;
-	iovs[0].iov_len = sizeof(ft_req);
-
-	if (!ft_build_authenticate_ies(hs, info->super.snonce, buf, &len))
-		goto failed;
-
-	iovs[1].iov_base = buf;
-	iovs[1].iov_len = len;
-
-	iovs[2].iov_base = NULL;
-
-	if (!netdev->ft_ds_list)
-		netdev->ft_ds_list = l_queue_new();
-
-	l_queue_push_head(netdev->ft_ds_list, info);
-
-	netdev_send_action_framev(netdev, netdev->handshake->aa, iovs, 2,
-					netdev->frequency,
-					netdev_ft_request_cb,
-					info);
-
-	return 0;
-
-failed:
-	l_free(info);
-	return -EIO;
+	return ft_action(netdev->ft_sm, target_bss);
 }
 
 static void netdev_preauth_cb(const uint8_t *pmk, void *user_data)
@@ -5829,7 +5665,6 @@ static void netdev_add_station_frame_watches(struct netdev *netdev)
 	static const uint8_t action_neighbor_report_prefix[2] = { 0x05, 0x05 };
 	static const uint8_t action_sa_query_resp_prefix[2] = { 0x08, 0x01 };
 	static const uint8_t action_sa_query_req_prefix[2] = { 0x08, 0x00 };
-	static const uint8_t action_ft_response_prefix[] =  { 0x06, 0x02 };
 	static const uint8_t action_qos_map_prefix[] = { 0x01, 0x04 };
 	uint64_t wdev = netdev->wdev_id;
 
@@ -5846,10 +5681,6 @@ static void netdev_add_station_frame_watches(struct netdev *netdev)
 			sizeof(action_sa_query_req_prefix),
 			netdev_sa_query_req_frame_event, netdev, NULL);
 
-	frame_watch_add(wdev, 0, 0x00d0, action_ft_response_prefix,
-			sizeof(action_ft_response_prefix),
-			netdev_ft_response_frame_event, netdev, NULL);
-
 	if (wiphy_supports_qos_set_map(netdev->wiphy))
 		frame_watch_add(wdev, 0, 0x00d0, action_qos_map_prefix,
 				sizeof(action_qos_map_prefix),
-- 
2.34.3

