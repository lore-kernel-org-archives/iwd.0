Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9BE4A17
	for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 18:25:33 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id c2so10694963plo.3
        for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 11:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=VjVcuI/u0rJMbr1M/MD6lzT4QAzs5eSFQPyZCGKGx6U=;
        b=Gm8LAKUBQUskOjOexTmhqPUmQw+YGkR7BXgl+1E1YldetUeCcVg1aD45alrTsM0Jx2
         H9SfER+igwTRziudhSoGjDUgsgxbhsCeN95pvFnl90mESxglioGtcXipfenNrDUyBDyJ
         3M8caw7rwD7LEVTyJmvre3we/EN64sudbdeVG5kKHpXuschsi+RuUn82B7Iwf2ssOw6d
         E8JsWNECdq031OKhapXI8Qx0jnXt2Lg1taCq9gYreOaRTU9CAtbWscaMrzPKPmmP6PDL
         zrrYYOj/Ch9xuASzq6APhQviluWB0N6kSdX00Ejs0JkoLiSdr2CLEsPXIcH5ODmw1Ovu
         owYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=VjVcuI/u0rJMbr1M/MD6lzT4QAzs5eSFQPyZCGKGx6U=;
        b=WVUq+g3/pphT2G33arEQBRKif73kL/srKzwTZGItXzX8rZiYreAmwMXH1zjkCfHunF
         urlrW6BzBYOvdRnRKK6dcuXiBUE3AZuP97bL0+ejB0o7bF1AyI17ZK8EXKmATW8s+npI
         /lHCzqnpf4xUINQJbhfOULDjCnl+EuOMKfHpD40m+lDgUxasqDaRBFU+Dve5DmsTfSbh
         KNyX6ZDTjr1S/EAJrRiA9UacOQ+ms/EeNYdnsWA3yBQ3KLDMQvuiSFhtBZLyfslMo7rI
         Cg20qPkZZb9w7COKI5pnxZViZ/qhhg/dIUWQvvcXFwX26J0MzQ46HSVvuQafa2hup1HE
         naig==
X-Gm-Message-State: ACgBeo03jp5ZID+LcX820RV4BXdfptDsBSX1UplLIahTsJxKRfUHlydU
	uh7kyIgCqdlxZu+IkxVmsLuJNZ28Sbs=
X-Google-Smtp-Source: AA6agR7D8E/cAeqe0xE2jiTYfDCDpqoV/HrCGgJM7V3fdrphhwM3/Q3Cv+eUfVAlYHBgjPYI11k6Ug==
X-Received: by 2002:a17:903:1ce:b0:16f:145c:a842 with SMTP id e14-20020a17090301ce00b0016f145ca842mr21105040plh.83.1661192733029;
        Mon, 22 Aug 2022 11:25:33 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709026f0100b00172bd4c12b2sm1612024plk.224.2022.08.22.11.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 11:25:32 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/9] ft: netdev: rename structs/APIs to prepare for refactor
Date: Mon, 22 Aug 2022 11:25:18 -0700
Message-Id: <20220822182525.2078312-2-prestwoj@gmail.com>
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

Much of the over-DS processing can be combined with over-air once
the authenticate stage is performed via CMD_FRAME. To prepare for
this rename all the 'over_ds' structs/APIs so the name makes sense
once used with the over-air code path.
---
 src/ft.c     | 17 +++++------
 src/ft.h     | 17 ++++-------
 src/netdev.c | 81 ++++++++++++++++++++++++++--------------------------
 3 files changed, 53 insertions(+), 62 deletions(-)

diff --git a/src/ft.c b/src/ft.c
index 2285a86f..04ae2775 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -348,7 +348,7 @@ static bool ft_verify_rsne(const uint8_t *rsne, const uint8_t *pmk_r0_name,
 	return true;
 }
 
-static int ft_parse_ies(struct handshake_state *hs,
+static int parse_ies(struct handshake_state *hs,
 			const uint8_t *authenticator_ie,
 			const uint8_t *ies, size_t ies_len,
 			const uint8_t **mde_out,
@@ -471,16 +471,14 @@ static bool mde_equal(const uint8_t *mde1, const uint8_t *mde2)
 	return memcmp(mde1, mde1, mde1[1] + 2) == 0;
 }
 
-bool ft_over_ds_parse_action_ies(struct ft_ds_info *info,
-					struct handshake_state *hs,
-					const uint8_t *ies,
-					size_t ies_len)
+bool ft_parse_ies(struct ft_info *info, struct handshake_state *hs,
+			const uint8_t *ies, size_t ies_len)
 {
 	const uint8_t *mde = NULL;
 	const uint8_t *fte = NULL;
 	bool is_rsn = hs->supplicant_ie != NULL;
 
-	if (ft_parse_ies(hs, info->authenticator_ie, ies, ies_len,
+	if (parse_ies(hs, info->authenticator_ie, ies, ies_len,
 				&mde, &fte) < 0)
 		return false;
 
@@ -512,7 +510,7 @@ static int ft_process_ies(struct handshake_state *hs, const uint8_t *ies,
 	if (!ies)
 		goto ft_error;
 
-	if (ft_parse_ies(hs, hs->authenticator_ie, ies, ies_len,
+	if (parse_ies(hs, hs->authenticator_ie, ies, ies_len,
 				&mde, &fte) < 0)
 		goto ft_error;
 
@@ -585,8 +583,7 @@ int ft_over_ds_parse_action_response(const uint8_t *frame, size_t frame_len,
 	return 0;
 }
 
-bool ft_over_ds_prepare_handshake(struct ft_ds_info *info,
-					struct handshake_state *hs)
+bool ft_prepare_handshake(struct ft_info *info, struct handshake_state *hs)
 {
 	if (!hs->supplicant_ie)
 		return true;
@@ -606,7 +603,7 @@ bool ft_over_ds_prepare_handshake(struct ft_ds_info *info,
 	return true;
 }
 
-void ft_ds_info_free(struct ft_ds_info *info)
+void ft_info_free(struct ft_info *info)
 {
 	__typeof__(info->free) destroy = info->free;
 
diff --git a/src/ft.h b/src/ft.h
index f90fc1b2..8bb31b28 100644
--- a/src/ft.h
+++ b/src/ft.h
@@ -28,9 +28,7 @@ typedef int (*ft_tx_associate_func_t)(struct iovec *ie_iov, size_t iov_len,
 					void *user_data);
 typedef int (*ft_get_oci)(void *user_data);
 
-typedef void (*ft_ds_free_func_t)(void *user_data);
-
-struct ft_ds_info {
+struct ft_info {
 	uint8_t spa[6];
 	uint8_t aa[6];
 	uint8_t snonce[32];
@@ -40,10 +38,10 @@ struct ft_ds_info {
 
 	struct ie_ft_info ft_info;
 
-	void (*free)(struct ft_ds_info *s);
+	void (*free)(struct ft_info *s);
 };
 
-void ft_ds_info_free(struct ft_ds_info *info);
+void ft_info_free(struct ft_info *info);
 
 bool ft_build_authenticate_ies(struct handshake_state *hs, bool ocvc,
 				const uint8_t *new_snonce, uint8_t *buf,
@@ -54,10 +52,8 @@ int ft_over_ds_parse_action_response(const uint8_t *frame, size_t frame_len,
 					const uint8_t **aa_out,
 					const uint8_t **ies_out,
 					size_t *ies_len);
-bool ft_over_ds_parse_action_ies(struct ft_ds_info *info,
-					struct handshake_state *hs,
-					const uint8_t *ies,
-					size_t ies_len);
+bool ft_parse_ies(struct ft_info *info, struct handshake_state *hs,
+			const uint8_t *ies, size_t ies_len);
 
 struct auth_proto *ft_over_air_sm_new(struct handshake_state *hs,
 				ft_tx_authenticate_func_t tx_auth,
@@ -69,5 +65,4 @@ struct auth_proto *ft_over_ds_sm_new(struct handshake_state *hs,
 				ft_tx_associate_func_t tx_assoc,
 				void *user_data);
 
-bool ft_over_ds_prepare_handshake(struct ft_ds_info *info,
-					struct handshake_state *hs);
+bool ft_prepare_handshake(struct ft_info *info, struct handshake_state *hs);
diff --git a/src/netdev.c b/src/netdev.c
index 0d48631c..165dc157 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -96,8 +96,8 @@ struct netdev_handshake_state {
 	enum connection_type type;
 };
 
-struct netdev_ft_over_ds_info {
-	struct ft_ds_info super;
+struct netdev_ft_info {
+	struct ft_info super;
 	struct netdev *netdev;
 
 	bool parsed : 1;
@@ -176,7 +176,7 @@ struct netdev {
 	struct l_genl_msg *auth_cmd;
 	struct wiphy_radio_work_item work;
 
-	struct l_queue *ft_ds_list;
+	struct l_queue *ft_list;
 
 	struct netdev_ext_key_info *ext_key_info;
 
@@ -752,11 +752,11 @@ static void netdev_preauth_destroy(void *data)
 	l_free(state);
 }
 
-static void netdev_ft_ds_entry_free(void *data)
+static void netdev_ft_entry_free(void *data)
 {
-	struct netdev_ft_over_ds_info *info = data;
+	struct netdev_ft_info *info = data;
 
-	ft_ds_info_free(&info->super);
+	ft_info_free(&info->super);
 }
 
 static void netdev_connect_free(struct netdev *netdev)
@@ -848,9 +848,9 @@ static void netdev_connect_free(struct netdev *netdev)
 		netdev->get_oci_cmd_id = 0;
 	}
 
-	if (netdev->ft_ds_list) {
-		l_queue_destroy(netdev->ft_ds_list, netdev_ft_ds_entry_free);
-		netdev->ft_ds_list = NULL;
+	if (netdev->ft_list) {
+		l_queue_destroy(netdev->ft_list, netdev_ft_entry_free);
+		netdev->ft_list = NULL;
 	}
 }
 
@@ -962,9 +962,9 @@ static void netdev_free(void *data)
 	if (netdev->fw_roam_bss)
 		scan_bss_free(netdev->fw_roam_bss);
 
-	if (netdev->ft_ds_list) {
-		l_queue_destroy(netdev->ft_ds_list, netdev_ft_ds_entry_free);
-		netdev->ft_ds_list = NULL;
+	if (netdev->ft_list) {
+		l_queue_destroy(netdev->ft_list, netdev_ft_entry_free);
+		netdev->ft_list = NULL;
 	}
 
 	scan_wdev_remove(netdev->wdev_id);
@@ -1415,9 +1415,9 @@ static void netdev_connect_ok(struct netdev *netdev)
 		netdev->fw_roam_bss = NULL;
 	}
 
-	if (netdev->ft_ds_list) {
-		l_queue_destroy(netdev->ft_ds_list, netdev_ft_ds_entry_free);
-		netdev->ft_ds_list = NULL;
+	if (netdev->ft_list) {
+		l_queue_destroy(netdev->ft_list, netdev_ft_entry_free);
+		netdev->ft_list = NULL;
 	}
 
 	if (netdev->connect_cb) {
@@ -4508,22 +4508,22 @@ static void prepare_ft(struct netdev *netdev, const struct scan_bss *target_bss)
 	}
 }
 
-static void netdev_ft_over_ds_auth_failed(struct netdev_ft_over_ds_info *info,
+static void netdev_ft_over_ds_auth_failed(struct netdev_ft_info *info,
 						uint16_t status)
 {
-	l_queue_remove(info->netdev->ft_ds_list, info);
-	ft_ds_info_free(&info->super);
+	l_queue_remove(info->netdev->ft_list, info);
+	ft_info_free(&info->super);
 }
 
-struct ft_ds_finder {
+struct ft_finder {
 	const uint8_t *spa;
 	const uint8_t *aa;
 };
 
-static bool match_ft_ds_info(const void *a, const void *b)
+static bool match_ft_info(const void *a, const void *b)
 {
-	const struct netdev_ft_over_ds_info *info = a;
-	const struct ft_ds_finder *finder = b;
+	const struct netdev_ft_info *info = a;
+	const struct ft_finder *finder = b;
 
 	if (memcmp(info->super.spa, finder->spa, 6))
 		return false;
@@ -4538,14 +4538,14 @@ static void netdev_ft_response_frame_event(const struct mmpdu_header *hdr,
 					int rssi, void *user_data)
 {
 	struct netdev *netdev = user_data;
-	struct netdev_ft_over_ds_info *info;
+	struct netdev_ft_info *info;
 	int ret;
 	uint16_t status_code = MMPDU_STATUS_CODE_UNSPECIFIED;
 	const uint8_t *aa;
 	const uint8_t *spa;
 	const uint8_t *ies;
 	size_t ies_len;
-	struct ft_ds_finder finder;
+	struct ft_finder finder;
 
 	if (!netdev->connected)
 		return;
@@ -4558,7 +4558,7 @@ static void netdev_ft_response_frame_event(const struct mmpdu_header *hdr,
 	finder.spa = spa;
 	finder.aa = aa;
 
-	info = l_queue_find(netdev->ft_ds_list, match_ft_ds_info, &finder);
+	info = l_queue_find(netdev->ft_list, match_ft_info, &finder);
 	if (!info)
 		return;
 
@@ -4568,8 +4568,7 @@ static void netdev_ft_response_frame_event(const struct mmpdu_header *hdr,
 		goto ft_error;
 	}
 
-	if (!ft_over_ds_parse_action_ies(&info->super, netdev->handshake,
-						ies, ies_len))
+	if (!ft_parse_ies(&info->super, netdev->handshake, ies, ies_len))
 		goto ft_error;
 
 	info->parsed = true;
@@ -4661,8 +4660,8 @@ int netdev_fast_transition_over_ds(struct netdev *netdev,
 					const struct scan_bss *orig_bss,
 					netdev_connect_cb_t cb)
 {
-	struct netdev_ft_over_ds_info *info;
-	struct ft_ds_finder finder;
+	struct netdev_ft_info *info;
+	struct ft_finder finder;
 
 	if (!netdev->operational)
 		return -ENOTCONN;
@@ -4675,14 +4674,14 @@ int netdev_fast_transition_over_ds(struct netdev *netdev,
 	finder.spa = netdev->addr;
 	finder.aa = target_bss->addr;
 
-	info = l_queue_find(netdev->ft_ds_list, match_ft_ds_info, &finder);
+	info = l_queue_find(netdev->ft_list, match_ft_info, &finder);
 
 	if (!info || !info->parsed)
 		return -ENOENT;
 
 	prepare_ft(netdev, target_bss);
 
-	ft_over_ds_prepare_handshake(&info->super, netdev->handshake);
+	ft_prepare_handshake(&info->super, netdev->handshake);
 
 	netdev->connect_cb = cb;
 
@@ -4699,7 +4698,7 @@ int netdev_fast_transition_over_ds(struct netdev *netdev,
 
 static void netdev_ft_request_cb(struct l_genl_msg *msg, void *user_data)
 {
-	struct netdev_ft_over_ds_info *info = user_data;
+	struct netdev_ft_info *info = user_data;
 
 	if (l_genl_msg_get_error(msg) < 0) {
 		l_error("Could not send CMD_FRAME for FT-over-DS");
@@ -4708,10 +4707,10 @@ static void netdev_ft_request_cb(struct l_genl_msg *msg, void *user_data)
 	}
 }
 
-static void netdev_ft_ds_info_free(struct ft_ds_info *ft)
+static void netdev_ft_info_free(struct ft_info *ft)
 {
-	struct netdev_ft_over_ds_info *info = l_container_of(ft,
-					struct netdev_ft_over_ds_info, super);
+	struct netdev_ft_info *info = l_container_of(ft,
+					struct netdev_ft_info, super);
 
 	l_free(info);
 }
@@ -4719,7 +4718,7 @@ static void netdev_ft_ds_info_free(struct ft_ds_info *ft)
 int netdev_fast_transition_over_ds_action(struct netdev *netdev,
 					const struct scan_bss *target_bss)
 {
-	struct netdev_ft_over_ds_info *info;
+	struct netdev_ft_info *info;
 	uint8_t ft_req[14];
 	struct handshake_state *hs = netdev->handshake;
 	struct iovec iovs[5];
@@ -4736,7 +4735,7 @@ int netdev_fast_transition_over_ds_action(struct netdev *netdev,
 
 	l_debug("");
 
-	info = l_new(struct netdev_ft_over_ds_info, 1);
+	info = l_new(struct netdev_ft_info, 1);
 	info->netdev = netdev;
 
 	memcpy(info->super.spa, hs->spa, ETH_ALEN);
@@ -4748,7 +4747,7 @@ int netdev_fast_transition_over_ds_action(struct netdev *netdev,
 						target_bss->rsne[1] + 2);
 
 	l_getrandom(info->super.snonce, 32);
-	info->super.free = netdev_ft_ds_info_free;
+	info->super.free = netdev_ft_info_free;
 
 	ft_req[0] = 6; /* FT category */
 	ft_req[1] = 1; /* FT Request action */
@@ -4767,10 +4766,10 @@ int netdev_fast_transition_over_ds_action(struct netdev *netdev,
 
 	iovs[2].iov_base = NULL;
 
-	if (!netdev->ft_ds_list)
-		netdev->ft_ds_list = l_queue_new();
+	if (!netdev->ft_list)
+		netdev->ft_list = l_queue_new();
 
-	l_queue_push_head(netdev->ft_ds_list, info);
+	l_queue_push_head(netdev->ft_list, info);
 
 	netdev_send_action_framev(netdev, netdev->handshake->aa, iovs, 2,
 					netdev->frequency,
-- 
2.34.3

