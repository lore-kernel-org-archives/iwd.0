Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC79538E
	for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 22:07:57 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id a80so10827137pfa.4
        for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 15:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=PUn2GLtR/jHCrStJVxr7lJz1f8iaRSGV+wUQXehyMiY=;
        b=OgOff/sho0uhySARqqGD/oJ6i/X3S4C4XYmJczW6lhbiv4fbziCJA4oA+RYBo1guSr
         FYVTnhYFHOwuDOA0ZLZPmuNGixGL/gjQTEeR+woprm2VpwzQA75cMO0XDHphxSygO1wD
         A2YS9SQeAa6DfXAagAgwcxklUd9HRYRmqTF1R3HJbJ30kQdkXoPu8klfqV5PaB0w3R5N
         ADDCQf4nicDSRbPmW/1VRToQ4NKzGVoM8BV8JDVph2GKwodfCTYrK8PWTnxfM69wDE6A
         MN9kBwLbX2ml8LNL7Gd9gUXKWBIHTh87xx3xWExH0NycAIKH+OwJMQ9QYPnvL0uDLN6K
         xPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=PUn2GLtR/jHCrStJVxr7lJz1f8iaRSGV+wUQXehyMiY=;
        b=oblwS/Ee+4tMokL6AC0zHq+naK/E0dpEPXKHcZ4dKqxzIbfvu4E5jYUmQs0SJinNx6
         Qs3UhjQ6cCRnSQ4tafE2QaJNvOcDQjo7NS/8FYf745DK7lGMfNfRu14qhlpRKc8GDC80
         Nds9tyIrBtR55xA5uhz2kcUvNx/jEmIh3tEImvtXfB1g5Vd+xO3MMB250ZMviEsKuCkU
         r1re+quUQo+9+8Eg5HEYFcq2VDQs9vqf2/G9n3v/OoSNvhhKfMc4R50qcL7ArwEgj/PR
         UOMUWWZs2/pBnqsbkCDrhVymwaYq4trK9K+a6sREv/kpVncNhRMMg8Fgl6zLl76hUDYr
         iMHQ==
X-Gm-Message-State: ACrzQf3gnjpjbC4bVfTRnMoenzLzet9zihG4Jh3yW/DcVvL/PkwHLAmg
	gnQaYmD/sAL0484GQ3jZTZ9vsV9sYeQ=
X-Google-Smtp-Source: AMsMyM5HZAkfLm9yupV2VdfX3iy6FBjf28Ap/jLuoGZpeYzjEFI2Az5fmRA1GSxqpFh2KacXO2iddw==
X-Received: by 2002:aa7:9dde:0:b0:53e:5af7:ac10 with SMTP id g30-20020aa79dde000000b0053e5af7ac10mr1649032pfq.16.1663279676574;
        Thu, 15 Sep 2022 15:07:56 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id k2-20020a6555c2000000b0041c0c9c0072sm12147165pgs.64.2022.09.15.15.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 15:07:56 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 08/14] netdev: update FT-over-Air to use ft_authenticate()
Date: Thu, 15 Sep 2022 15:07:35 -0700
Message-Id: <20220915220741.1128728-8-prestwoj@gmail.com>
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

This removes the FT auth-proto entirely from FT-over-Air, and
instead requires using ft_authenticate/ft_associate along with
the new ft_sm state machine.

The authentication phase is now done off-channel which allows
failures to be non-fatal (eventually). Currently the behavior
isn't changed, and failing to authenticate to a BSS will result
in a disconnect.
---
 src/ft.c     |   6 +++
 src/netdev.c | 113 +++++++++++++++++----------------------------------
 2 files changed, 44 insertions(+), 75 deletions(-)

diff --git a/src/ft.c b/src/ft.c
index 559e3984..abb2f380 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -1114,6 +1114,12 @@ static void ft_prepare_handshake(struct ft_info *info,
 	if (!hs->supplicant_ie)
 		return;
 
+	if (info->authenticator_ie)
+		handshake_state_set_authenticator_ie(hs,
+						info->authenticator_ie);
+
+	memcpy(hs->mde + 2, info->mde, 3);
+
 	memcpy(hs->snonce, info->snonce, sizeof(hs->snonce));
 
 	handshake_state_set_fte(hs, info->fte);
diff --git a/src/netdev.c b/src/netdev.c
index 2519feda..cfb741db 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1395,8 +1395,7 @@ static void netdev_connect_ok(struct netdev *netdev)
 		netdev->fw_roam_bss = NULL;
 	}
 
-	/* TODO: Create only for over-DS. Over-air still uses auth-proto */
-	if (netdev->handshake->mde && (netdev->handshake->mde[4] & 1)) {
+	if (netdev->handshake->mde) {
 		if (netdev->ft_sm)
 			ft_sm_free(netdev->ft_sm);
 
@@ -4375,48 +4374,6 @@ static int netdev_tx_ft_action_frame(uint32_t ifindex, const uint8_t *dest,
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
 static int netdev_ft_tx_associate(uint32_t ifindex, const uint8_t *prev_bssid,
 					struct iovec *ft_iov, size_t n_ft_iov)
 {
@@ -4456,7 +4413,8 @@ static int netdev_ft_tx_associate(uint32_t ifindex, const uint8_t *prev_bssid,
 	return 0;
 }
 
-static void prepare_ft(struct netdev *netdev, const struct scan_bss *target_bss)
+static void prepare_ft(struct netdev *netdev, const uint8_t *addr,
+			uint32_t frequency)
 {
 	struct netdev_handshake_state *nhs;
 
@@ -4467,15 +4425,9 @@ static void prepare_ft(struct netdev *netdev, const struct scan_bss *target_bss)
 	 */
 	memcpy(netdev->prev_snonce, netdev->handshake->snonce, 32);
 
-	netdev->frequency = target_bss->frequency;
-
-	handshake_state_set_authenticator_address(netdev->handshake,
-							target_bss->addr);
+	handshake_state_set_authenticator_address(netdev->handshake, addr);
 
-	if (target_bss->rsne)
-		handshake_state_set_authenticator_ie(netdev->handshake,
-							target_bss->rsne);
-	memcpy(netdev->handshake->mde + 2, target_bss->mde, 3);
+	netdev->frequency = frequency;
 
 	netdev->handshake->active_tk_index = 0;
 	netdev->associated = false;
@@ -4549,15 +4501,10 @@ static bool netdev_ft_work_ready(struct wiphy_radio_work_item *item)
 {
 	struct netdev *netdev = l_container_of(item, struct netdev, work);
 
-	if (netdev->ft_sm) {
-		if (ft_associate(netdev->ft_sm, netdev->handshake->aa))
-			goto assoc_failed;
-
-		return false;
-	}
+	if (ft_associate(netdev->ft_sm, netdev->handshake->aa))
+		goto assoc_failed;
 
-	if (auth_proto_start(netdev->ap))
-		return false;
+	return false;
 
 assoc_failed:
 	/* Restore original nonce */
@@ -4572,6 +4519,27 @@ static const struct wiphy_radio_work_item_ops ft_work_ops = {
 	.do_work = netdev_ft_work_ready,
 };
 
+static void netdev_ft_authenticate_cb(int err, const uint8_t *addr,
+					uint32_t frequency,
+					void *user_data)
+{
+	struct netdev *netdev = user_data;
+
+	if (err < 0)
+		goto ft_failed;
+
+	prepare_ft(netdev, addr, frequency);
+
+	wiphy_radio_work_insert(netdev->wiphy, &netdev->work,
+				WIPHY_WORK_PRIORITY_CONNECT, &ft_work_ops);
+
+	return;
+
+ft_failed:
+	netdev_connect_failed(netdev, NETDEV_RESULT_AUTHENTICATION_FAILED,
+					MMPDU_STATUS_CODE_UNSPECIFIED);
+}
+
 int netdev_fast_transition(struct netdev *netdev,
 				const struct scan_bss *target_bss,
 				const struct scan_bss *orig_bss,
@@ -4580,25 +4548,20 @@ int netdev_fast_transition(struct netdev *netdev,
 	if (!netdev->operational)
 		return -ENOTCONN;
 
-	if (!netdev->handshake->mde || !target_bss->mde_present ||
+	if (!netdev->ft_sm || !netdev->handshake->mde ||
+			!target_bss->mde_present ||
 			l_get_le16(netdev->handshake->mde + 2) !=
 			l_get_le16(target_bss->mde))
 		return -EINVAL;
 
 	netdev->connect_cb = cb;
 
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
+	/*
+	 * ft_authenticate uses offchannel so we cant start a wiphy work item
+	 * until that completes
+	 */
+	return ft_authenticate(netdev->ft_sm, target_bss,
+				netdev_ft_authenticate_cb, netdev);
 }
 
 int netdev_fast_transition_over_ds(struct netdev *netdev,
@@ -4617,7 +4580,7 @@ int netdev_fast_transition_over_ds(struct netdev *netdev,
 
 	netdev->connect_cb = cb;
 
-	prepare_ft(netdev, target_bss);
+	prepare_ft(netdev, target_bss->addr, target_bss->frequency);
 
 	wiphy_radio_work_insert(netdev->wiphy, &netdev->work,
 				WIPHY_WORK_PRIORITY_CONNECT, &ft_work_ops);
-- 
2.34.3

