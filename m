Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163472585
	for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 22:32:09 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id q35-20020a17090a752600b002038d8a68fbso314647pjk.0
        for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 15:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=0XmSRQjn/XMCsg4DxdUZrzjSpZtwT/1LiQ+G3vLl7Xo=;
        b=J3Ml7m7wUcP479EcZend3raOftt4KRxzlB8ZRT3fijFOsw4UbXC56pt+YNRNrSjovz
         DPzMHjGZhaZvSJO2ChKCuZz3bN0mrSgxdqfsubdMVfoXI6yDckXJLLwNre1CdbOJuuUT
         XRQpQYKlQfpsXpGm6ynymF6M3fHCgk7Ij07OxEonoGIrT9zcgspkVSuVTVybLX0QbDjV
         vYJx4I5JDXV69DlbSerA/f1rKGw96B52TUgK3l06TCmGBMDgbLxUxVd8MpHVUTceWT8A
         DxA7M4K+MhScZPH0Adyv01ca3JKleI5Sd3uDHy9gpTEhH+y18WKWNqzTUuZZRsQYpi3H
         bWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0XmSRQjn/XMCsg4DxdUZrzjSpZtwT/1LiQ+G3vLl7Xo=;
        b=60+18D9G4jXU0oc8xrUdZCWLhQyYkxMmdMZ9b2YIZUR8ECTtk0Tl50JhkvahpXHzH/
         lAAGQwp/c3QS1uFCPcN67xi3FGYJMPDHD+/Hchwg9xJXUak1d2VIXC5zwDHlBY+KVbSt
         d6lwo70fsurzpB+k12HuIqtIpqUC4bgmhWJNnmEe3O0RrwKsjcxiasE7JjppWbxXCh77
         5GTdmOmL8iMMGwv5xaQ65ewUkGjuYtTuiP+aDjL0UmKyhY2THarvjcRafp93s6NctJ32
         itktpfLYpF/EOsmzYmRGuAmErk1dG99ADeUKqfn6ngw+Q5vU/DuVFl2suGUYtiFg9L6o
         SxAg==
X-Gm-Message-State: ACrzQf16BPCmstSfqdST+a2+HLzvLQQnH+3zU3rQM8bX1xV5gvrF4aym
	TVcESEvzW3Zm61YcO3wneJ/9SoantJU=
X-Google-Smtp-Source: AMsMyM66ZzKvEdjbRu5miteam3tvTBET4cMkouTK20CYHc/h17Wia1iY0supXHUe7rRf6Z54BWxmrw==
X-Received: by 2002:a17:90a:fe90:b0:202:a345:b7a6 with SMTP id co16-20020a17090afe9000b00202a345b7a6mr392970pjb.14.1663799528415;
        Wed, 21 Sep 2022 15:32:08 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id r10-20020a63e50a000000b00438c0571456sm2393135pgh.24.2022.09.21.15.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 15:32:08 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 13/15] netdev: ft: complete FT refactor
Date: Wed, 21 Sep 2022 15:31:56 -0700
Message-Id: <20220921223158.704658-13-prestwoj@gmail.com>
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
index 613c6477..65cd38cb 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -1124,9 +1124,19 @@ static void ft_info_destroy(void *data)
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
index e14fb7cc..536ae644 100644
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
@@ -3280,7 +3283,6 @@ static void netdev_associate_event(struct l_genl_msg *msg,
 			eapol_sm_set_require_handshake(netdev->sm,
 							false);
 
-		netdev->in_ft = false;
 		netdev->in_reassoc = false;
 		netdev->associated = true;
 		return;
@@ -4446,6 +4448,7 @@ static int netdev_ft_tx_associate(uint32_t ifindex, uint32_t freq,
 					struct iovec *ft_iov, size_t n_ft_iov)
 {
 	struct netdev *netdev = netdev_find(ifindex);
+	struct netdev_handshake_state *nhs;
 	struct handshake_state *hs = netdev->handshake;
 	struct l_genl_msg *msg;
 	struct iovec iov[64];
@@ -4454,6 +4457,54 @@ static int netdev_ft_tx_associate(uint32_t ifindex, uint32_t freq,
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

