Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBB34A28
	for <iwd@lists.linux.dev>; Tue, 27 Sep 2022 19:47:50 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id w2so10644582pfb.0
        for <iwd@lists.linux.dev>; Tue, 27 Sep 2022 12:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Zc5clccuSFhqXGdp5rWxmwjlP6UlpRJVCnRRF+AG3DA=;
        b=PqzOA+pmYRVlNNfaXIoFAL0CdQRhGS6yUCNB9UZh56/aZ+PqwvSj9JY9x7CF9apfDk
         t3h6/jJHDud2hYMrdokiSccpEpD1QFme7IVmMhU1Bv7q6LcgkDx4TfnGnaCaHCraw8RM
         UJnOxidYnEsEaxenUZek3Op1kLC+dJAngtuhJvh4U0dBQ3Qu2jlCc+rXrXQa7v7nl2U4
         essUgwx2N9HlF2mTD4eS8LUuQ+tIfGZZOBH5i2vYfx5Hr2UVsoCw64savMk7QpY5TEUs
         6JaY9q8oZOr3ZEC7rcbAoBtuTVNaWzkB3GnQMMQjNKQANJ2B96LNTsDXyV4y1+L+/Kb4
         Iyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Zc5clccuSFhqXGdp5rWxmwjlP6UlpRJVCnRRF+AG3DA=;
        b=1ppTEIoiP1o2PLg8y1ZTIUGJxe5+DYK9pJLIKDKnXmjvsRMVOAn/0jGWRsKEIzDSqN
         3O3GVYen/BT9W04axMCgsBKIxpDavd8VIKIMWYMeBbvStpqumH7R0iiTA+RcwATF5OMi
         MXIM+HyPFbIVooGWRoVQgWFd/9MAqzgt3qAIecoPvv+JnIABotk8el/oYpX9Fp8CXQbt
         g/HwcH1eZrvAPebc6nX8hyZyx+/rjtE/7HZewdlMcN7Lr83zVsAY4luh8k4/B5GteOeB
         orALwxMpemV8XelWxeBqGFadvEaAOoInyrAgF4qCBA04TNY9gSfw0tlow2drAmiSjWZa
         Psdw==
X-Gm-Message-State: ACrzQf1ou/Kl2m/Gshc2Q8J7EtOBjzKzAIKHTy562cogmYnmbYVhbeiq
	qC14wAGAOQuEC4zk22aIQO1LC5ihAwM=
X-Google-Smtp-Source: AMsMyM7y60ItAejVerTczs0YcTBN1OAWPX7wi84XpXNDpqnS98D96vLPXtcvCnF+GoAqvw18kdwWeA==
X-Received: by 2002:a63:5617:0:b0:43c:9a42:fe95 with SMTP id k23-20020a635617000000b0043c9a42fe95mr14119783pgb.446.1664308069552;
        Tue, 27 Sep 2022 12:47:49 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id b12-20020a1709027e0c00b00176a2d23d1asm2033145plm.56.2022.09.27.12.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:47:49 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v6 10/11] netdev: remove FT auth proto
Date: Tue, 27 Sep 2022 12:47:30 -0700
Message-Id: <20220927194731.269732-10-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220927194731.269732-1-prestwoj@gmail.com>
References: <20220927194731.269732-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This removes the FT auth-proto from netdev and all associated helpers
and APIs.
---
 src/netdev.c | 341 ---------------------------------------------------
 src/netdev.h |  11 +-
 2 files changed, 1 insertion(+), 351 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index d9f75567..206907b8 100644
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
@@ -145,7 +138,6 @@ struct netdev {
 	struct l_timeout *sa_query_delay;
 	struct l_timeout *group_handshake_timeout;
 	uint16_t sa_query_id;
-	uint8_t prev_snonce[32];
 	int8_t rssi_levels[16];
 	uint8_t rssi_levels_num;
 	uint8_t cur_rssi_level_idx;
@@ -176,8 +168,6 @@ struct netdev {
 	struct l_genl_msg *auth_cmd;
 	struct wiphy_radio_work_item work;
 
-	struct l_queue *ft_ds_list;
-
 	struct netdev_ext_key_info *ext_key_info;
 
 	bool connected : 1;
@@ -752,13 +742,6 @@ static void netdev_preauth_destroy(void *data)
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
@@ -847,11 +830,6 @@ static void netdev_connect_free(struct netdev *netdev)
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
@@ -962,11 +940,6 @@ static void netdev_free(void *data)
 	if (netdev->fw_roam_bss)
 		scan_bss_free(netdev->fw_roam_bss);
 
-	if (netdev->ft_ds_list) {
-		l_queue_destroy(netdev->ft_ds_list, netdev_ft_ds_entry_free);
-		netdev->ft_ds_list = NULL;
-	}
-
 	scan_wdev_remove(netdev->wdev_id);
 
 	watchlist_destroy(&netdev->station_watches);
@@ -1424,11 +1397,6 @@ static void netdev_connect_ok(struct netdev *netdev)
 		netdev->connect_cb = NULL;
 	}
 
-	if (netdev->ft_ds_list) {
-		l_queue_destroy(netdev->ft_ds_list, netdev_ft_ds_entry_free);
-		netdev->ft_ds_list = NULL;
-	}
-
 	netdev_rssi_polling_update(netdev);
 
 	if (netdev->work.id)
@@ -4414,48 +4382,6 @@ static int netdev_tx_ft_frame(uint32_t ifindex, uint16_t frame_type,
 	return 0;
 }
 
-static void netdev_cmd_authenticate_ft_cb(struct l_genl_msg *msg,
-						void *user_data)
-{
-	struct netdev *netdev = user_data;
-
-	netdev->connect_cmd_id = 0;
-
-	if (l_genl_msg_get_error(msg) < 0)
-		netdev_connect_failed(netdev,
-					NETDEV_RESULT_AUTHENTICATION_FAILED,
-					MMPDU_STATUS_CODE_UNSPECIFIED);
-}
-
-static void netdev_ft_tx_authenticate(struct iovec *iov,
-					size_t iov_len, void *user_data)
-{
-	struct netdev *netdev = user_data;
-	struct l_genl_msg *cmd_authenticate;
-
-	cmd_authenticate = netdev_build_cmd_authenticate(netdev,
-							NL80211_AUTHTYPE_FT);
-	l_genl_msg_append_attrv(cmd_authenticate, NL80211_ATTR_IE, iov,
-					iov_len);
-
-	netdev->connect_cmd_id = l_genl_family_send(nl80211,
-						cmd_authenticate,
-						netdev_cmd_authenticate_ft_cb,
-						netdev, NULL);
-	if (!netdev->connect_cmd_id) {
-		l_genl_msg_unref(cmd_authenticate);
-		goto restore_snonce;
-	}
-
-	return;
-
-restore_snonce:
-	memcpy(netdev->handshake->snonce, netdev->prev_snonce, 32);
-
-	netdev_connect_failed(netdev, NETDEV_RESULT_AUTHENTICATION_FAILED,
-					MMPDU_STATUS_CODE_UNSPECIFIED);
-}
-
 static int netdev_ft_tx_associate(uint32_t ifindex, uint32_t freq,
 					const uint8_t *prev_bssid,
 					struct iovec *ft_iov, size_t n_ft_iov)
@@ -4545,98 +4471,6 @@ static int netdev_ft_tx_associate(uint32_t ifindex, uint32_t freq,
 	return 0;
 }
 
-static void prepare_ft(struct netdev *netdev, const struct scan_bss *target_bss)
-{
-	struct netdev_handshake_state *nhs;
-
-	/*
-	 * We reuse the handshake_state object and reset what's needed.
-	 * Could also create a new object and copy most of the state but
-	 * we would end up doing more work.
-	 */
-	memcpy(netdev->prev_snonce, netdev->handshake->snonce, 32);
-
-	netdev->frequency = target_bss->frequency;
-
-	handshake_state_set_authenticator_address(netdev->handshake,
-							target_bss->addr);
-
-	if (target_bss->rsne)
-		handshake_state_set_authenticator_ie(netdev->handshake,
-							target_bss->rsne);
-	memcpy(netdev->handshake->mde + 2, target_bss->mde, 3);
-
-	netdev->handshake->active_tk_index = 0;
-	netdev->associated = false;
-	netdev->operational = false;
-	netdev->in_ft = true;
-
-	handshake_state_set_chandef(netdev->handshake, NULL);
-
-	/*
-	 * Cancel commands that could be running because of EAPoL activity
-	 * like re-keying, this way the callbacks for those commands don't
-	 * have to check if failures resulted from the transition.
-	 */
-	nhs = l_container_of(netdev->handshake,
-				struct netdev_handshake_state, super);
-
-	/* reset key states just as we do in initialization */
-	nhs->complete = false;
-	nhs->ptk_installed = false;
-	nhs->gtk_installed = true;
-	nhs->igtk_installed = true;
-
-	if (nhs->group_new_key_cmd_id) {
-		l_genl_family_cancel(nl80211, nhs->group_new_key_cmd_id);
-		nhs->group_new_key_cmd_id = 0;
-	}
-
-	if (nhs->group_management_new_key_cmd_id) {
-		l_genl_family_cancel(nl80211,
-			nhs->group_management_new_key_cmd_id);
-		nhs->group_management_new_key_cmd_id = 0;
-	}
-
-	if (netdev->rekey_offload_cmd_id) {
-		l_genl_family_cancel(nl80211, netdev->rekey_offload_cmd_id);
-		netdev->rekey_offload_cmd_id = 0;
-	}
-
-	netdev_rssi_polling_update(netdev);
-	netdev_cqm_rssi_update(netdev);
-
-	if (netdev->sm) {
-		eapol_sm_free(netdev->sm);
-		netdev->sm = NULL;
-	}
-}
-
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
 static void netdev_ft_response_frame_event(const struct mmpdu_header *hdr,
 					const void *body, size_t body_len,
 					int rssi, void *user_data)
@@ -4685,181 +4519,6 @@ static void netdev_qos_map_frame_event(const struct mmpdu_header *hdr,
 	netdev_send_qos_map_set(netdev, body + 4, body_len - 4);
 }
 
-static bool netdev_ft_work_ready(struct wiphy_radio_work_item *item)
-{
-	struct netdev *netdev = l_container_of(item, struct netdev, work);
-
-	if (!auth_proto_start(netdev->ap)) {
-		/* Restore original nonce */
-		memcpy(netdev->handshake->snonce, netdev->prev_snonce, 32);
-
-		netdev_connect_failed(netdev, NETDEV_RESULT_ABORTED,
-						MMPDU_STATUS_CODE_UNSPECIFIED);
-		return true;
-	}
-
-	return false;
-}
-
-static const struct wiphy_radio_work_item_ops ft_work_ops = {
-	.do_work = netdev_ft_work_ready,
-};
-
-int netdev_fast_transition(struct netdev *netdev,
-				const struct scan_bss *target_bss,
-				const struct scan_bss *orig_bss,
-				netdev_connect_cb_t cb)
-{
-	if (!netdev->operational)
-		return -ENOTCONN;
-
-	if (!netdev->handshake->mde || !target_bss->mde_present ||
-			l_get_le16(netdev->handshake->mde + 2) !=
-			l_get_le16(target_bss->mde))
-		return -EINVAL;
-
-	netdev->connect_cb = cb;
-
-	netdev->ap = ft_over_air_sm_new(netdev->handshake,
-					netdev_ft_tx_authenticate,
-					netdev_ft_tx_associate,
-					netdev_get_oci, netdev);
-	prepare_ft(netdev, target_bss);
-
-	handshake_state_new_snonce(netdev->handshake);
-
-	wiphy_radio_work_insert(netdev->wiphy, &netdev->work,
-				WIPHY_WORK_PRIORITY_CONNECT, &ft_work_ops);
-
-	return 0;
-}
-
-int netdev_fast_transition_over_ds(struct netdev *netdev,
-					const struct scan_bss *target_bss,
-					const struct scan_bss *orig_bss,
-					netdev_connect_cb_t cb)
-{
-	struct netdev_ft_over_ds_info *info;
-	struct ft_ds_finder finder;
-
-	if (!netdev->operational)
-		return -ENOTCONN;
-
-	if (!netdev->handshake->mde || !target_bss->mde_present ||
-			l_get_le16(netdev->handshake->mde + 2) !=
-			l_get_le16(target_bss->mde))
-		return -EINVAL;
-
-	finder.spa = netdev->addr;
-	finder.aa = target_bss->addr;
-
-	info = l_queue_find(netdev->ft_ds_list, match_ft_ds_info, &finder);
-
-	if (!info || !info->parsed)
-		return -ENOENT;
-
-	netdev->connect_cb = cb;
-
-	netdev->ap = ft_over_ds_sm_new(netdev->handshake,
-					netdev_ft_tx_associate,
-					netdev);
-	prepare_ft(netdev, target_bss);
-
-	ft_over_ds_prepare_handshake(&info->super, netdev->handshake);
-
-	wiphy_radio_work_insert(netdev->wiphy, &netdev->work,
-				WIPHY_WORK_PRIORITY_CONNECT, &ft_work_ops);
-
-	return 0;
-}
-
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
-int netdev_fast_transition_over_ds_action(struct netdev *netdev,
-					const struct scan_bss *target_bss)
-{
-	struct netdev_ft_over_ds_info *info;
-	uint8_t ft_req[14];
-	struct handshake_state *hs = netdev->handshake;
-	struct iovec iovs[5];
-	uint8_t buf[512];
-	size_t len;
-
-	if (!netdev->operational)
-		return -ENOTCONN;
-
-	if (!netdev->handshake->mde || !target_bss->mde_present ||
-			l_get_le16(netdev->handshake->mde + 2) !=
-			l_get_le16(target_bss->mde))
-		return -EINVAL;
-
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
-	if (!ft_build_authenticate_ies(hs, false, info->super.snonce,
-						buf, &len))
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
-}
-
 static void netdev_preauth_cb(const uint8_t *pmk, void *user_data)
 {
 	struct netdev_preauth_state *preauth = user_data;
diff --git a/src/netdev.h b/src/netdev.h
index c5933ad0..73d38c32 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -166,16 +166,7 @@ int netdev_reassociate(struct netdev *netdev,
 			struct handshake_state *hs,
 			netdev_event_func_t event_filter,
 			netdev_connect_cb_t cb, void *user_data);
-int netdev_fast_transition(struct netdev *netdev,
-				const struct scan_bss *target_bss,
-				const struct scan_bss *orig_bss,
-				netdev_connect_cb_t cb);
-int netdev_fast_transition_over_ds_action(struct netdev *netdev,
-					const struct scan_bss *target_bss);
-int netdev_fast_transition_over_ds(struct netdev *netdev,
-					const struct scan_bss *target_bss,
-					const struct scan_bss *orig_bss,
-					netdev_connect_cb_t cb);
+
 int netdev_preauthenticate(struct netdev *netdev,
 				const struct scan_bss *target_bss,
 				netdev_preauthenticate_cb_t cb,
-- 
2.34.3

