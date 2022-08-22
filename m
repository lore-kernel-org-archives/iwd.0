Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB794A17
	for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 18:25:36 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id f17so4993041pfk.11
        for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 11:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=YYfdk7XgnOvVRTpwBE+250WpcayOI5IIwbwk9zOwtZg=;
        b=iOsCl7coLkgbcKNZ1dmUY69cGgLC43J4+ezLaW5gsw2336T8tBOy32q64P59YhIcY5
         v7nt7QNngKVEeqR/xAb1FxOO5JXK95clBA0ahmk5KK3TLAUxs4yRKi1FcGzzZFa65+xI
         1bRnE5U0SAUz9qyIR4f9shReBYLKgUlg2+jrAh1X1l79y3DQY9MkapFx8d3igtNwuLZz
         pFz5F+HJMbsshHyxrYv2EJ20fdXcIKO8SyDwjxxGGfwVlsmlaeu0NmxPUjWgh9EgF+Pp
         70//HhuHiOqNmR9cv29QOJyx/IRDIK/lQTazeD/QfKb3CiOd4gVkheENV1mFVgs5VVGR
         M8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=YYfdk7XgnOvVRTpwBE+250WpcayOI5IIwbwk9zOwtZg=;
        b=tQH/+MSgQg0mdq7e24LaL6PY5qPXKjL1sjO/oNq/cxEtLdYvNjXrXMr8HVqcgSR3Z7
         jTtEqWj6vXVQCDgZHhm5X+QZM0l2XMJ6quhA7DLseOsAoeH79QhxOWVjpLJ3gHvxTZKL
         9cY95I/OQOPOEkiwe7khM6mLWPjXM/cVhr3MwnI+kp+N8meCZlPvF810kataW3rYIf5I
         Eyh6u1zS64ueG11YOLIkiW3g7saQkGY8JyvkkXefqnHaN7MaREzbZdjJwD0JEeLqt0Z1
         ox37z9Ew4kjR3M/GnF3L+ohWjMpeqHbjdYg6aWSAGA/+C2qO3Y0n3p+mp8rbHf0mI18w
         KuZg==
X-Gm-Message-State: ACgBeo1kg9BawtyYaDjiedklaNEVwfHZcqWRy/8Jd1k8nsUJ6SOk/lAb
	zPr/PmmwuCuCkz0219LW4fUnBGvy+IU=
X-Google-Smtp-Source: AA6agR4azhf/Q3rGagijwBnYUt9EI4C4C080zdpoXOVsBn94eRhJXUWbYZr+sYdtOJ7qaMUF030JQQ==
X-Received: by 2002:a05:6a00:1a0c:b0:528:6baa:a2e3 with SMTP id g12-20020a056a001a0c00b005286baaa2e3mr22183505pfv.27.1661192736163;
        Mon, 22 Aug 2022 11:25:36 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709026f0100b00172bd4c12b2sm1612024plk.224.2022.08.22.11.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 11:25:35 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 7/9] netdev: ft: do FT authentication offchannel
Date: Mon, 22 Aug 2022 11:25:23 -0700
Message-Id: <20220822182525.2078312-7-prestwoj@gmail.com>
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

This removes the use of CMD_AUTHENTICATE from FT. The reason being that
a station should be able to authenticate to multiple BSS's, then
proceed to association with a single BSS. The kernel does not allow this
since CMD_AUTHENTICATE actually transitions to the new BSS's channel
and changes state making any failures fatal.

Instead userspace can do authentication using CMD_FRAME which allows
any failures to be recoverable (during authentication). This is
nearly identical to how FT-over-DS works where any auth failures
(during the action state) just means you can avoid that BSS but can
still transition to another without being disconnected.
---
 src/ft.c     | 103 +---------------------
 src/ft.h     |   2 -
 src/netdev.c | 243 +++++++++++++++++++++++++++++++++------------------
 3 files changed, 161 insertions(+), 187 deletions(-)

diff --git a/src/ft.c b/src/ft.c
index 14d6f4f2..ff908829 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -479,48 +479,6 @@ ft_error:
 	return false;
 }
 
-static int ft_process_ies(struct handshake_state *hs, const uint8_t *ies,
-			size_t ies_len)
-{
-	const uint8_t *mde = NULL;
-	const uint8_t *fte = NULL;
-	bool is_rsn = hs->supplicant_ie != NULL;
-
-	/* Check 802.11r IEs */
-	if (!ies)
-		goto ft_error;
-
-	if (parse_ies(hs, hs->authenticator_ie, ies, ies_len,
-				&mde, &fte) < 0)
-		goto ft_error;
-
-	if (!mde_equal(hs->mde, mde))
-		goto ft_error;
-
-	if (is_rsn) {
-		struct ie_ft_info ft_info;
-
-		if (!ft_parse_fte(hs, hs->snonce, fte, &ft_info))
-			goto ft_error;
-
-		handshake_state_set_fte(hs, fte);
-
-		handshake_state_set_anonce(hs, ft_info.anonce);
-
-		handshake_state_set_kh_ids(hs, ft_info.r0khid,
-						ft_info.r0khid_len,
-						ft_info.r1khid);
-
-		handshake_state_derive_ptk(hs);
-	} else if (fte)
-		goto ft_error;
-
-	return 0;
-
-ft_error:
-	return -EBADMSG;
-}
-
 int ft_over_ds_parse_action_response(const uint8_t *frame, size_t frame_len,
 					const uint8_t **spa_out,
 					const uint8_t **aa_out,
@@ -597,40 +555,6 @@ void ft_info_free(struct ft_info *info)
 		destroy(info);
 }
 
-static int ft_rx_authenticate(struct auth_proto *ap, const uint8_t *frame,
-				size_t frame_len)
-{
-	struct ft_sm *ft = l_container_of(ap, struct ft_sm, ap);
-	uint16_t status_code = MMPDU_STATUS_CODE_UNSPECIFIED;
-	const uint8_t *ies = NULL;
-	size_t ies_len;
-	int ret;
-
-	/*
-	 * Parse the Authentication Response and validate the contents
-	 * according to 12.5.2 / 12.5.4: RSN or non-RSN Over-the-air
-	 * FT Protocol.
-	 */
-	if (!ft_parse_authentication_resp_frame(frame, frame_len, ft->hs->spa,
-						ft->hs->aa, ft->hs->aa,
-						2, &status_code,
-						&ies, &ies_len))
-		goto auth_error;
-
-	/* AP Rejected the authenticate / associate */
-	if (status_code != 0)
-		goto auth_error;
-
-	ret = ft_process_ies(ft->hs, ies, ies_len);
-	if (ret < 0)
-		goto auth_error;
-
-	return ft->get_oci(ft->user_data);
-
-auth_error:
-	return (int)status_code;
-}
-
 static int ft_rx_associate(struct auth_proto *ap, const uint8_t *frame,
 				size_t frame_len)
 {
@@ -768,13 +692,6 @@ static int ft_rx_associate(struct auth_proto *ap, const uint8_t *frame,
 	return 0;
 }
 
-static int ft_rx_oci(struct auth_proto *ap)
-{
-	struct ft_sm *ft = l_container_of(ap, struct ft_sm, ap);
-
-	return ft_tx_reassociate(ft);
-}
-
 static void ft_sm_free(struct auth_proto *ap)
 {
 	struct ft_sm *ft = l_container_of(ap, struct ft_sm, ap);
@@ -863,41 +780,23 @@ bool ft_build_authenticate_ies(struct handshake_state *hs,
 static bool ft_start(struct auth_proto *ap)
 {
 	struct ft_sm *ft = l_container_of(ap, struct ft_sm, ap);
-	struct handshake_state *hs = ft->hs;
-	struct iovec iov;
-	uint8_t buf[512];
-	size_t len;
 
-	if (!ft_build_authenticate_ies(hs, hs->snonce, buf, &len))
-		return false;
-
-	iov.iov_base = buf;
-	iov.iov_len = len;
-
-	ft->tx_auth(&iov, 1, ft->user_data);
-
-	return true;
+	return ft_tx_reassociate(ft) == 0;
 }
 
 struct auth_proto *ft_over_air_sm_new(struct handshake_state *hs,
-				ft_tx_authenticate_func_t tx_auth,
 				ft_tx_associate_func_t tx_assoc,
-				ft_get_oci get_oci,
 				void *user_data)
 {
 	struct ft_sm *ft = l_new(struct ft_sm, 1);
 
-	ft->tx_auth = tx_auth;
 	ft->tx_assoc = tx_assoc;
-	ft->get_oci = get_oci;
 	ft->hs = hs;
 	ft->user_data = user_data;
 
-	ft->ap.rx_authenticate = ft_rx_authenticate;
 	ft->ap.rx_associate = ft_rx_associate;
 	ft->ap.start = ft_start;
 	ft->ap.free = ft_sm_free;
-	ft->ap.rx_oci = ft_rx_oci;
 
 	return &ft->ap;
 }
diff --git a/src/ft.h b/src/ft.h
index 6922513f..29da0dd0 100644
--- a/src/ft.h
+++ b/src/ft.h
@@ -61,9 +61,7 @@ bool ft_parse_ies(struct ft_info *info, struct handshake_state *hs,
 			const uint8_t *ies, size_t ies_len);
 
 struct auth_proto *ft_over_air_sm_new(struct handshake_state *hs,
-				ft_tx_authenticate_func_t tx_auth,
 				ft_tx_associate_func_t tx_assoc,
-				ft_get_oci get_oci,
 				void *user_data);
 
 struct auth_proto *ft_over_ds_sm_new(struct handshake_state *hs,
diff --git a/src/netdev.c b/src/netdev.c
index 6b0cd537..f38b9c9a 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -99,6 +99,7 @@ struct netdev_handshake_state {
 struct netdev_ft_info {
 	struct ft_info super;
 	struct netdev *netdev;
+	uint32_t frequency;
 
 	bool parsed : 1;
 };
@@ -138,6 +139,7 @@ struct netdev {
 	uint32_t qos_map_cmd_id;
 	uint32_t mac_change_cmd_id;
 	uint32_t get_oci_cmd_id;
+	uint32_t ft_auth_cmd_id;
 	enum netdev_result result;
 	uint16_t last_code; /* reason or status, depending on result */
 	struct l_timeout *neighbor_report_timeout;
@@ -848,6 +850,11 @@ static void netdev_connect_free(struct netdev *netdev)
 		netdev->get_oci_cmd_id = 0;
 	}
 
+	if (netdev->ft_auth_cmd_id) {
+		frame_xchg_cancel(netdev->ft_auth_cmd_id);
+		netdev->ft_auth_cmd_id = 0;
+	}
+
 	if (netdev->ft_list) {
 		l_queue_destroy(netdev->ft_list, netdev_ft_entry_free);
 		netdev->ft_list = NULL;
@@ -4359,48 +4366,6 @@ static uint32_t netdev_send_action_frame(struct netdev *netdev,
 						user_data);
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
 static int netdev_ft_tx_associate(struct iovec *ft_iov, size_t n_ft_iov,
 					void *user_data)
 {
@@ -4441,7 +4406,7 @@ static int netdev_ft_tx_associate(struct iovec *ft_iov, size_t n_ft_iov,
 	return 0;
 }
 
-static void prepare_ft(struct netdev *netdev, const struct scan_bss *target_bss)
+static void prepare_ft(struct netdev *netdev, struct netdev_ft_info *info)
 {
 	struct netdev_handshake_state *nhs;
 
@@ -4452,15 +4417,15 @@ static void prepare_ft(struct netdev *netdev, const struct scan_bss *target_bss)
 	 */
 	memcpy(netdev->prev_snonce, netdev->handshake->snonce, 32);
 
-	netdev->frequency = target_bss->frequency;
+	netdev->frequency = info->frequency;
 
 	handshake_state_set_authenticator_address(netdev->handshake,
-							target_bss->addr);
+							info->super.aa);
 
-	if (target_bss->rsne)
+	if (info->super.authenticator_ie)
 		handshake_state_set_authenticator_ie(netdev->handshake,
-							target_bss->rsne);
-	memcpy(netdev->handshake->mde + 2, target_bss->mde, 3);
+						info->super.authenticator_ie);
+	memcpy(netdev->handshake->mde + 2, info->super.mde, 3);
 
 	netdev->handshake->active_tk_index = 0;
 	netdev->associated = false;
@@ -4506,6 +4471,8 @@ static void prepare_ft(struct netdev *netdev, const struct scan_bss *target_bss)
 		eapol_sm_free(netdev->sm);
 		netdev->sm = NULL;
 	}
+
+	ft_prepare_handshake(&info->super, netdev->handshake);
 }
 
 static void netdev_ft_over_ds_auth_failed(struct netdev_ft_info *info,
@@ -4624,11 +4591,149 @@ static const struct wiphy_radio_work_item_ops ft_work_ops = {
 	.do_work = netdev_ft_work_ready,
 };
 
+static void netdev_authenticate_response_ft_cb(const struct mmpdu_header *hdr,
+						const void *body,
+						size_t body_len, int rssi,
+						void *user_data)
+{
+	struct netdev_ft_info *info = user_data;
+	struct netdev *netdev = info->netdev;
+	uint16_t status;
+	const uint8_t *ies;
+	size_t ies_len;
+
+	if (!ft_parse_authentication_resp_frame((const uint8_t *)hdr,
+					mmpdu_header_len(hdr) + body_len,
+					info->super.spa, info->super.aa,
+					info->super.aa, 2, &status,
+					&ies, &ies_len))
+		goto failed;
+
+	if (status != 0)
+		goto failed;
+
+	if (!ft_parse_ies(&info->super, netdev->handshake, ies, ies_len))
+		goto failed;
+
+	/* If we got here authentication was successful, continue with FT */
+	netdev->ap = ft_over_air_sm_new(netdev->handshake,
+					netdev_ft_tx_associate,
+					netdev);
+
+	memcpy(netdev->ap->prev_bssid, netdev->handshake->aa, ETH_ALEN);
+
+	prepare_ft(netdev, info);
+
+	wiphy_radio_work_insert(netdev->wiphy, &netdev->work,
+				WIPHY_WORK_PRIORITY_CONNECT, &ft_work_ops);
+
+	return;
+
+failed:
+	netdev_connect_failed(netdev, NETDEV_RESULT_ABORTED,
+					MMPDU_STATUS_CODE_UNSPECIFIED);
+}
+
+static const struct frame_xchg_prefix ft_prefix = {
+	.frame_type = 0x0000 | (MPDU_MANAGEMENT_SUBTYPE_AUTHENTICATION << 4),
+	.data = (uint8_t []) { 0x02, 0x00 },
+	.len = 2,
+};
+
+static void netdev_cmd_authenticate_ft_cb(int err, void *user_data)
+{
+	struct netdev_ft_info *info = user_data;
+
+	if (err < 0)
+		netdev_connect_failed(info->netdev,
+					NETDEV_RESULT_AUTHENTICATION_FAILED,
+}
+
+static bool netdev_send_ft_authenticate(struct netdev *netdev,
+					struct netdev_ft_info *info)
+{
+	uint8_t header[28 + sizeof(struct mmpdu_authentication)];
+	uint8_t ies[256];
+	size_t len;
+	struct iovec iov[3];
+	struct mmpdu_header *mpdu = (struct mmpdu_header *) header;
+	struct mmpdu_authentication *auth;
+	struct handshake_state *hs = netdev->handshake;
+
+	memset(mpdu, 0, sizeof(*mpdu));
+
+	/* Header */
+	mpdu->fc.protocol_version = 0;
+	mpdu->fc.type = MPDU_TYPE_MANAGEMENT;
+	mpdu->fc.subtype = MPDU_MANAGEMENT_SUBTYPE_AUTHENTICATION;
+	memcpy(mpdu->address_1, info->super.aa, 6);
+	memcpy(mpdu->address_2, netdev->addr, 6);
+	memcpy(mpdu->address_3, info->super.aa, 6);
+
+	/* Authentication body */
+	auth = (void *) mmpdu_body(mpdu);
+	auth->algorithm = L_CPU_TO_LE16(MMPDU_AUTH_ALGO_FT);
+	auth->transaction_sequence = L_CPU_TO_LE16(1);
+	auth->status = L_CPU_TO_LE16(0);
+
+	iov[0].iov_base = mpdu;
+	iov[0].iov_len = mmpdu_header_len(mpdu) +
+				sizeof(struct mmpdu_authentication);
+
+	if (!ft_build_authenticate_ies(hs, info->super.snonce, ies, &len))
+		return false;
+
+	iov[1].iov_base = ies;
+	iov[1].iov_len = len;
+
+	iov[2].iov_base = NULL;
+
+	netdev->ft_auth_cmd_id = frame_xchg_start(netdev->wdev_id, iov,
+			info->frequency, 0, 100, 0, 0,
+			netdev_cmd_authenticate_ft_cb, info, NULL,
+			&ft_prefix, netdev_authenticate_response_ft_cb, NULL);
+
+	return netdev->ft_auth_cmd_id != 0;
+}
+
+static void netdev_ft_info_free(struct ft_info *ft)
+{
+	struct netdev_ft_info *info = l_container_of(ft,
+					struct netdev_ft_info, super);
+
+	l_free(info);
+}
+
+static struct netdev_ft_info *netdev_ft_info_new(struct netdev *netdev,
+						const struct scan_bss *bss)
+{
+	struct handshake_state *hs = netdev->handshake;
+	struct netdev_ft_info *info;
+
+	info = l_new(struct netdev_ft_info, 1);
+	info->netdev = netdev;
+	info->frequency = bss->frequency;
+
+	memcpy(info->super.spa, hs->spa, ETH_ALEN);
+	memcpy(info->super.aa, bss->addr, ETH_ALEN);
+	memcpy(info->super.mde, bss->mde, sizeof(info->super.mde));
+
+	if (bss->rsne)
+		info->super.authenticator_ie = l_memdup(bss->rsne,
+							bss->rsne[1] + 2);
+	l_getrandom(info->super.snonce, 32);
+	info->super.free = netdev_ft_info_free;
+
+	return info;
+}
+
 int netdev_fast_transition(struct netdev *netdev,
 				const struct scan_bss *target_bss,
 				const struct scan_bss *orig_bss,
 				netdev_connect_cb_t cb)
 {
+	struct netdev_ft_info *info;
+
 	if (!netdev->operational)
 		return -ENOTCONN;
 
@@ -4637,20 +4742,14 @@ int netdev_fast_transition(struct netdev *netdev,
 			l_get_le16(target_bss->mde))
 		return -EINVAL;
 
-	prepare_ft(netdev, target_bss);
-
-	handshake_state_new_snonce(netdev->handshake);
-
 	netdev->connect_cb = cb;
 
-	netdev->ap = ft_over_air_sm_new(netdev->handshake,
-					netdev_ft_tx_authenticate,
-					netdev_ft_tx_associate,
-					netdev_get_oci, netdev);
-	memcpy(netdev->ap->prev_bssid, orig_bss->addr, ETH_ALEN);
+	info = netdev_ft_info_new(netdev, target_bss);
 
-	wiphy_radio_work_insert(netdev->wiphy, &netdev->work,
-				WIPHY_WORK_PRIORITY_CONNECT, &ft_work_ops);
+	if (!netdev_send_ft_authenticate(netdev, info)) {
+		netdev_ft_entry_free(info);
+		return -EBADMSG;
+	}
 
 	return 0;
 }
@@ -4679,9 +4778,7 @@ int netdev_fast_transition_over_ds(struct netdev *netdev,
 	if (!info || !info->parsed)
 		return -ENOENT;
 
-	prepare_ft(netdev, target_bss);
-
-	ft_prepare_handshake(&info->super, netdev->handshake);
+	prepare_ft(netdev, info);
 
 	netdev->connect_cb = cb;
 
@@ -4707,14 +4804,6 @@ static void netdev_ft_request_cb(struct l_genl_msg *msg, void *user_data)
 	}
 }
 
-static void netdev_ft_info_free(struct ft_info *ft)
-{
-	struct netdev_ft_info *info = l_container_of(ft,
-					struct netdev_ft_info, super);
-
-	l_free(info);
-}
-
 int netdev_fast_transition_over_ds_action(struct netdev *netdev,
 					const struct scan_bss *target_bss)
 {
@@ -4735,19 +4824,7 @@ int netdev_fast_transition_over_ds_action(struct netdev *netdev,
 
 	l_debug("");
 
-	info = l_new(struct netdev_ft_info, 1);
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
-	info->super.free = netdev_ft_info_free;
+	info = netdev_ft_info_new(netdev, target_bss);
 
 	ft_req[0] = 6; /* FT category */
 	ft_req[1] = 1; /* FT Request action */
-- 
2.34.3

