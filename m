Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C612F2E
	for <iwd@lists.linux.dev>; Thu, 22 Sep 2022 22:08:17 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id rt12so8695932pjb.1
        for <iwd@lists.linux.dev>; Thu, 22 Sep 2022 15:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=kQk45icxKu2Fq8F550VSuRi6VFifnqj1kZpSIIzA920=;
        b=T0UbfoOk8PR46BB17AhqAVmYIsiVM+6cHTHBxducDdi+RHLv5kCH0PLWazjrrMOROT
         6Kat53MMfba9o8kc0VMB66XMhNuYlMRTFFR8+NjZ3ETeNPWpoFGLhWH5PNFvKqiNcwrH
         1877NWxP9zMeWur3dZjBwOuTtsNZkHrNRlAzzq04SCn4CBL0DDhw/E+qv7mi7i5ZJkJV
         JZ+SbPXCJcMYCsrOOdgYbUYKI4cEDtM7z4xj/wGm8b5IpyRup0dL8qrauCt9M38gCwWl
         87FcqrHk7X3RnyvN7x0t+ySTUZrQS9puI6Z3nVlKm0wTPjyRoPum8KDf5mqshp2xSi1V
         lvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kQk45icxKu2Fq8F550VSuRi6VFifnqj1kZpSIIzA920=;
        b=LTFspDAkfGPKNMAV+Aqzj8w+q7a7hLxbI6BK6mDfGh17k4nqI5vVfuCxPgmz+Kix35
         FM3SclZOc3ZhRSA0aOCOU2k2znS1RPMaksIAE+eH7qXHS/LL+veA14m3rfQX0nFS2SB1
         OYpFe7ZbZMbfh/M1CKtJqHzHgB5qPGsvAAZU0QVWMozIh2QWXuYk2AwXHVwXEMzlY0X7
         tsSRL/CYXxVuHs64B2mYQr4FMpnOA9APS0IM7+TvM0M3lHlqDajlWQRQsowpCgh+DGEG
         anAEYr1HKJdslTWqCqzyaR0OAquwU8Y11ZhRIPo7IoFCOr3ezXciYUnLiFW8ZTdcZXkS
         fK1A==
X-Gm-Message-State: ACrzQf0NtK69St5e/W0pHCddHTuhZalkbTcZhvuqDDH6JcIuurqKigUh
	f0ISFsvJAJ+AIdfbTNMQCU4SSKF8IyQ=
X-Google-Smtp-Source: AMsMyM4+69sPvDTql+Wv3F3EiReWQpPZOA6dj1YH5AInmqNsv0QIX66tRUIa6MdtCr6+8t/pWzDWNQ==
X-Received: by 2002:a17:903:3282:b0:177:e91d:3e85 with SMTP id jh2-20020a170903328200b00177e91d3e85mr5434961plb.29.1663884497291;
        Thu, 22 Sep 2022 15:08:17 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id f15-20020aa7968f000000b005386162bc2asm4980448pfk.92.2022.09.22.15.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 15:08:17 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 09/11] netdev: ft: complete FT refactor
Date: Thu, 22 Sep 2022 15:08:07 -0700
Message-Id: <20220922220809.862022-9-prestwoj@gmail.com>
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
index 4005e8b6..7ca9a3f0 100644
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
index 397b1c4a..37ea4da8 100644
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

