Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E362F29
	for <iwd@lists.linux.dev>; Thu, 22 Sep 2022 22:08:18 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id c198so10577290pfc.13
        for <iwd@lists.linux.dev>; Thu, 22 Sep 2022 15:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=m6g5FJKY2zRSjBNF3UpZQ3csCxm1UJULO3UI6kLB7Fk=;
        b=NT3QY2gGgJGHRgjsETqiBdc76wx87dZn8CJ3L6U989HJiDZ8+47d5P9OSTeRuKiv/c
         OoWRggwBZNdQu9Niawt1/ECLjs0BV2v2b5CgAoQLbIga02w4o/1E4SfyWoQf37MSk03s
         HaKLsM+A1xEqIY9SUvGHZg0I1eWweamwSHtYFY6IpP/g8mmCROBBOJ2GQqLKzlHaI11D
         y4N+B1tHlUoubb+9hJH0AzXX9cNyy73hdJS0xyFJtFkmqHMxUs0afirYklKRR6OHU+b2
         JEC3zyGQjjI27IngnVKd8U356qY3yTaseMyUE/aIJKdTnwh10zTrurqu/eeJzHEJMQDx
         8l+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=m6g5FJKY2zRSjBNF3UpZQ3csCxm1UJULO3UI6kLB7Fk=;
        b=2Sm+YdFHD28lM6GBeXGdI4n5Q3/MSfFthcTTqv/lk7gnjvZEFxl+04bVbN2Xq0Uep3
         neo+LvmxpYuKVRBwDoMKKs5WKB/eCpQCzoXjdQ1CiGdaU4aV6WT8aSJ01LRn6nvwkdv9
         fIRmm7GmS/mAKTACaSxf88cJpLttd9GJlDfEbjroZEbmcxKM65IOqjEWMWEesyqUG4ue
         KTL8Y/08Q6PC0+Ipgrjv0xWKdZweTHt/d26b3ZK3nqzmBk2JcaaWK4sgLo3XLSFxRYKj
         OSe2wH3UTyfjqBgfpJ/eVf4ImjdJsrBrfTfdnLs+xWE90t7wuupJ4Ma8rDzpfKfn/Ku1
         mhdg==
X-Gm-Message-State: ACrzQf2MH8ywut5wyFBv/1PiGiUHvKzGiuX8pu3EHJA0/zThuVYORL3/
	91AFdZyWaf0kHR2sBw65sGEboErxuOs=
X-Google-Smtp-Source: AMsMyM4iORADJcOpKrO4xdOTI/bR8HF4K+aAd86DnO/rB5fvluN9DCLq9JsYpNwLRzuKgVYBpJQY6Q==
X-Received: by 2002:aa7:8c4f:0:b0:54d:14d5:d0c9 with SMTP id e15-20020aa78c4f000000b0054d14d5d0c9mr5758213pfd.13.1663884498182;
        Thu, 22 Sep 2022 15:08:18 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id f15-20020aa7968f000000b005386162bc2asm4980448pfk.92.2022.09.22.15.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 15:08:17 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 10/11] netdev: remove FT auth proto
Date: Thu, 22 Sep 2022 15:08:08 -0700
Message-Id: <20220922220809.862022-10-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220922220809.862022-1-prestwoj@gmail.com>
References: <20220922220809.862022-1-prestwoj@gmail.com>
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
index 37ea4da8..19509eb1 100644
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
@@ -4401,48 +4369,6 @@ static int netdev_tx_ft_frame_frame(uint32_t ifindex, uint16_t frame_type,
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
@@ -4532,98 +4458,6 @@ static int netdev_ft_tx_associate(uint32_t ifindex, uint32_t freq,
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
@@ -4672,181 +4506,6 @@ static void netdev_qos_map_frame_event(const struct mmpdu_header *hdr,
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

