Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620703210
	for <iwd@lists.linux.dev>; Wed, 24 Aug 2022 22:55:29 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id s31-20020a17090a2f2200b001faaf9d92easo3107061pjd.3
        for <iwd@lists.linux.dev>; Wed, 24 Aug 2022 15:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=uKoAaNJu+yLUX3Amv06DSHldyNDYPM9n7cxzUM2rcY8=;
        b=P9nMLSBCKiK2kZNYZABFpRdOAGVNf8g3ZrurfhuZMpoE/O7Wn8oNaPvEG6fl/w3vzs
         hSPik7wpYLvNnywqDGWBbY0560CStw9kRwVrqZ5F5rAojqF3UFt1VVlMDjsiALvI3tHJ
         +E4AaBI8jra8qmEtQJKbGBl9ztn//huol2/Ew5RCzveAwDzQVYlQ0U/AcaBJazFwLf9e
         8vgX+1/6HpeifYT/solJrmDhuBbTD1dtjlnrUiQLPU7WtA6c5I7h5FIV4iqqM4wcERVb
         y4/SHv31sah1F25a/XuhER1JVzZXzytCYa1dWFfJ4Hw2BhDXDP4Wn5S0MLoO5FbnzHET
         JOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=uKoAaNJu+yLUX3Amv06DSHldyNDYPM9n7cxzUM2rcY8=;
        b=6u/UaHOkKQU84nzUO0lmMjo3O2NepmYAEBdUJRU2riFfvXl9IA/34QLLbBF1XtdgY/
         wHztrTqRoLSbzwVea9BJpbM/y0nienwUvjIVfkHNpyxXR9Ruz2YRrz57lSFRlQbv2mZ4
         T1sqFFG7xpB1Gq8Vw8tn0iFnFL/Ur/t3qbI2SzVhnoz17wdI40NrfzYsAgoG8VBlQSCq
         ULCBjqL4HFNy4O/BoFZcfqvRgHBxWHez5qwRCT4tI6/OwvUdargLWtHTd4emyI5i762G
         nD5Gsve30iCkOOh5G3fS515PO3qG07o9AjfG3J+g7OcU+vUNso8j5Xl1k20ofwgW6byQ
         ftHQ==
X-Gm-Message-State: ACgBeo0ArIllWzkVlC5ogMe4hSfRy1ZtqG0iBPAVanJHvfIFif83efIV
	+BU2cwNLH6U6hqk6CH6/2Uuprp/iJ9U=
X-Google-Smtp-Source: AA6agR7yfEjNt5TLuXWGgRRtIcm6PvdDMPcHBSLUuu6VBTQ8lntH/NEJ3pnByOXdfn6aLlJckptyoQ==
X-Received: by 2002:a17:902:cec1:b0:172:e677:553b with SMTP id d1-20020a170902cec100b00172e677553bmr1028381plg.99.1661381728643;
        Wed, 24 Aug 2022 15:55:28 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id jn22-20020a170903051600b0016bcc35000asm6228682plb.302.2022.08.24.15.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 15:55:28 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 8/9] netdev: update FT-over-Air to use ft_authenticate()
Date: Wed, 24 Aug 2022 15:55:17 -0700
Message-Id: <20220824225518.2558698-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220824225518.2558698-1-prestwoj@gmail.com>
References: <20220824225518.2558698-1-prestwoj@gmail.com>
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
index ce57020b..47e98c05 100644
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
index 334e10ab..5bd2954f 100644
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
 
@@ -4369,48 +4368,6 @@ static int netdev_tx_ft_action_frame(uint32_t ifindex, const uint8_t *dest,
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
@@ -4450,7 +4407,8 @@ static int netdev_ft_tx_associate(uint32_t ifindex, const uint8_t *prev_bssid,
 	return 0;
 }
 
-static void prepare_ft(struct netdev *netdev, const struct scan_bss *target_bss)
+static void prepare_ft(struct netdev *netdev, const uint8_t *addr,
+			uint32_t frequency)
 {
 	struct netdev_handshake_state *nhs;
 
@@ -4461,15 +4419,9 @@ static void prepare_ft(struct netdev *netdev, const struct scan_bss *target_bss)
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
@@ -4543,15 +4495,10 @@ static bool netdev_ft_work_ready(struct wiphy_radio_work_item *item)
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
@@ -4566,6 +4513,27 @@ static const struct wiphy_radio_work_item_ops ft_work_ops = {
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
@@ -4574,25 +4542,20 @@ int netdev_fast_transition(struct netdev *netdev,
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
@@ -4611,7 +4574,7 @@ int netdev_fast_transition_over_ds(struct netdev *netdev,
 
 	netdev->connect_cb = cb;
 
-	prepare_ft(netdev, target_bss);
+	prepare_ft(netdev, target_bss->addr, target_bss->frequency);
 
 	wiphy_radio_work_insert(netdev->wiphy, &netdev->work,
 				WIPHY_WORK_PRIORITY_CONNECT, &ft_work_ops);
-- 
2.34.3

