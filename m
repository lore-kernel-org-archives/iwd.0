Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A654C64
	for <iwd@lists.linux.dev>; Tue, 27 Sep 2022 19:47:49 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id r62so6495451pgr.12
        for <iwd@lists.linux.dev>; Tue, 27 Sep 2022 12:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=2euik/D8fjnRxUszcCecN2yEIfUiLYcpVW9d8PikIpk=;
        b=d3esmkyWemPUn53t80/dKg9/QIHj5cF8QMd3pGooTy+t18y7loT8lIfGSEanKngI0h
         OZBHJiRWV0bf0K6zfSlHYmCRzzv+Grk8iuNq8Z1Wod634Gg0KGeLHyhLL+GEK2CJDbn6
         Y2jeJMuLVB6/S3HkkuPsrBsipbK8rVofB4WNuL1jfa+twv4dP0uSSO+D6PXQUxLhPI/R
         15dC8BI9mnmmRe/iW/MU8Popilzl7F8Q+PcyZbDpGCdKGH+2GKlnK43TIiEgsuTBXyyj
         y1ARjyO8MR9+HfH6wPYfwfQJ8cUUq6TJt9t8EjAW4tNFRr57sIbbM+RibYOBjp27+ZJ8
         jKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2euik/D8fjnRxUszcCecN2yEIfUiLYcpVW9d8PikIpk=;
        b=1QaXenKTAwXnt5WTbIWdBTIQi3p2F+2klRwFnsijJ1jFzV3+QlIWo+4wKSnZnu6QjI
         5NDhpfpWw9k1AXyORGwWgL5mb+0+h0ZRH+yeWo3JXMeuCtitdySfplmU1EoKwwWA0V/Q
         QvSPGymWRQ/g9+tXNpFtlBPrASOj+ClZpPtmx/uofKnRqygbTjf22SjN9l8teY3p8/P+
         rAKlhcZfxzP7hohlrSFcyZsi7cHIhM7t4CLn7CuKmryOlOs6XXRU6vA4izd4dRqC3nE4
         eFXOHRJ4KFkRtQedEHhF3i8/x4fRI8CsF33/U2dXIC/bABXp6rWhwfVkvN0valwGYQDa
         YsnA==
X-Gm-Message-State: ACrzQf07ZrTou2PMqAzJkS3ucOXmq4sCNor5J/euScGuf930OMFilZ6l
	PqokeFnaa2NdFtaBTfcfxPJ6HOIQkmY=
X-Google-Smtp-Source: AMsMyM6hFFJr0RJ5liS0oYGRtSupl4nPOQmqHUnX3yyBDdPy8RMAnsLok4GHDEKUpZHHkf5MYO/c7Q==
X-Received: by 2002:a63:1e03:0:b0:43a:a64d:f3a4 with SMTP id e3-20020a631e03000000b0043aa64df3a4mr25435135pge.121.1664308068526;
        Tue, 27 Sep 2022 12:47:48 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id b12-20020a1709027e0c00b00176a2d23d1asm2033145plm.56.2022.09.27.12.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:47:48 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v6 09/11] netdev: ft: complete FT refactor
Date: Tue, 27 Sep 2022 12:47:29 -0700
Message-Id: <20220927194731.269732-9-prestwoj@gmail.com>
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

This finalizes the refactor by moving all the handshake prep
into FT itself (most was already in there). The netdev-specific
flags and state were added into netdev_ft_tx_associate which
now avoids any need for a netdev API related to FT.

The NETDEV_EVENT_FT_ROAMED event is now emitted once FT completes
(netdev_connect_ok). This did require moving the 'in_ft' flag
setting until after the keys are set into the kernel otherwise
netdev_connect_ok has no context as to if this was FT or some
other connection attempt.

In addition the prev_snonce was removed from netdev. Restoring
the snonce has no value once association begins. If association
fails it will result in a disconnect regardless which requires
a new snonce to be generated
---
 src/ft.c     | 10 ++++++++
 src/netdev.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/src/ft.c b/src/ft.c
index de628941..a4277cbe 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -1123,9 +1123,19 @@ static void ft_info_destroy(void *data)
 static void ft_prepare_handshake(struct ft_info *info,
 					struct handshake_state *hs)
 {
+	handshake_state_set_authenticator_address(hs, info->aa);
+
+	memcpy(hs->mde + 2, info->mde, 3);
+
+	handshake_state_set_chandef(hs, NULL);
+
 	if (!hs->supplicant_ie)
 		return;
 
+	if (info->authenticator_ie)
+		handshake_state_set_authenticator_ie(hs,
+							info->authenticator_ie);
+
 	memcpy(hs->snonce, info->snonce, sizeof(hs->snonce));
 
 	handshake_state_set_fte(hs, info->fte);
diff --git a/src/netdev.c b/src/netdev.c
index 029e96ad..d9f75567 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1413,6 +1413,15 @@ static void netdev_connect_ok(struct netdev *netdev)
 			scan_bss_free(netdev->fw_roam_bss);
 
 		netdev->fw_roam_bss = NULL;
+	} else if (netdev->in_ft) {
+		if (netdev->event_filter)
+			netdev->event_filter(netdev, NETDEV_EVENT_FT_ROAMED,
+						NULL, netdev->user_data);
+		netdev->in_ft = false;
+	} else if (netdev->connect_cb) {
+		netdev->connect_cb(netdev, NETDEV_RESULT_OK, NULL,
+					netdev->user_data);
+		netdev->connect_cb = NULL;
 	}
 
 	if (netdev->ft_ds_list) {
@@ -1420,12 +1429,6 @@ static void netdev_connect_ok(struct netdev *netdev)
 		netdev->ft_ds_list = NULL;
 	}
 
-	if (netdev->connect_cb) {
-		netdev->connect_cb(netdev, NETDEV_RESULT_OK, NULL,
-					netdev->user_data);
-		netdev->connect_cb = NULL;
-	}
-
 	netdev_rssi_polling_update(netdev);
 
 	if (netdev->work.id)
@@ -3293,7 +3296,6 @@ static void netdev_associate_event(struct l_genl_msg *msg,
 			eapol_sm_set_require_handshake(netdev->sm,
 							false);
 
-		netdev->in_ft = false;
 		netdev->in_reassoc = false;
 		netdev->associated = true;
 		return;
@@ -4459,6 +4461,7 @@ static int netdev_ft_tx_associate(uint32_t ifindex, uint32_t freq,
 					struct iovec *ft_iov, size_t n_ft_iov)
 {
 	struct netdev *netdev = netdev_find(ifindex);
+	struct netdev_handshake_state *nhs;
 	struct handshake_state *hs = netdev->handshake;
 	struct l_genl_msg *msg;
 	struct iovec iov[64];
@@ -4467,6 +4470,54 @@ static int netdev_ft_tx_associate(uint32_t ifindex, uint32_t freq,
 	enum mpdu_management_subtype subtype =
 				MPDU_MANAGEMENT_SUBTYPE_REASSOCIATION_REQUEST;
 
+	/*
+	 * At this point there is no going back with FT so reset all the flags
+	 * needed to associate with a new BSS.
+	 */
+	netdev->frequency = freq;
+	netdev->handshake->active_tk_index = 0;
+	netdev->associated = false;
+	netdev->operational = false;
+	netdev->in_ft = true;
+
+	/*
+	 * Cancel commands that could be running because of EAPoL activity
+	 * like re-keying, this way the callbacks for those commands don't
+	 * have to check if failures resulted from the transition.
+	 */
+	nhs = l_container_of(netdev->handshake,
+				struct netdev_handshake_state, super);
+
+	/* reset key states just as we do in initialization */
+	nhs->complete = false;
+	nhs->ptk_installed = false;
+	nhs->gtk_installed = true;
+	nhs->igtk_installed = true;
+
+	if (nhs->group_new_key_cmd_id) {
+		l_genl_family_cancel(nl80211, nhs->group_new_key_cmd_id);
+		nhs->group_new_key_cmd_id = 0;
+	}
+
+	if (nhs->group_management_new_key_cmd_id) {
+		l_genl_family_cancel(nl80211,
+			nhs->group_management_new_key_cmd_id);
+		nhs->group_management_new_key_cmd_id = 0;
+	}
+
+	if (netdev->rekey_offload_cmd_id) {
+		l_genl_family_cancel(nl80211, netdev->rekey_offload_cmd_id);
+		netdev->rekey_offload_cmd_id = 0;
+	}
+
+	netdev_rssi_polling_update(netdev);
+	netdev_cqm_rssi_update(netdev);
+
+	if (netdev->sm) {
+		eapol_sm_free(netdev->sm);
+		netdev->sm = NULL;
+	}
+
 	msg = netdev_build_cmd_associate_common(netdev);
 
 	c_iov = netdev_populate_common_ies(netdev, hs, msg, iov, n_iov, c_iov);
-- 
2.34.3

