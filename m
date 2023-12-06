Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06E93EA9F
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ih9vvO0j"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-77d895c298eso418080985a.3
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 07:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701875241; x=1702480041; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WIr59iK8+KfxkTwbfeDraxqS7unLhBzAqu5FX9Efps=;
        b=Ih9vvO0jv/vPBLSELWFuoB63Cnjl0AWRZLpKquQtPt0xo7bTTLQTuHvcgEQIGHGXni
         JE9Xrb0F7UX0g37yET+FFzDqC1P9R2Nk4fjGfBlCO1WUmXOIeTMVsRMIBES4WgOlBHvr
         lbJVgKknsyyf5p4SZFuHO5V1Iwow7AH/Psfg3uAUxTd3Bb7EUw2fEwGjiysgMBeeMYco
         kwvQ6jprXCVKML6PBBbQsZiEvedoj5Fx6iz52nuZh4zOK9QYZ+y5rWFw6J+ivP/WDjmm
         vb8s+87F00QZUty8J44d65mTzMsd0rvEYB/R/h6zN5ioADdj5FFKgR6m+/HRAN8YFkYv
         Lj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701875241; x=1702480041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WIr59iK8+KfxkTwbfeDraxqS7unLhBzAqu5FX9Efps=;
        b=MXvM9qWB3U2BydYhhyndiXbnXzPsLB+FizDzw/HJImQNJLOUALvskWzGcoXyDR8r6R
         qfG0TaKCSQuS4VsjEHpksKCF9QOZywqSh+cG+zX5C7Ds8obA1RmQdDb/JMPMC8gaEGAK
         m1m2uPhJtoZQ1sy+OT/zOPPBMCDkAaNf4cwrvFt9U9nyiy0ZAVweGfRAlzMr19rGQAYE
         GYNhPIazciV4q6jNPiLgOd/QXV9fPwWbtUn21aaLUomELMTCdcUqXw25ABW9KaKE4pCF
         1q+7LieK6dZ95H6jxvgxyytHRxcvYfGu1RjbP0xwoiXezN99iuLKIa/3G4K4U+CgwXPn
         +gxQ==
X-Gm-Message-State: AOJu0Yzg3ffzPkVGEYtt1KMySf0Mnjxpy+Qt+pzu4HypYsTqA5Vn83lq
	OFwsTOs+zQtxDucUfqppVs7SbQ44mrM=
X-Google-Smtp-Source: AGHT+IHX34/S8xG/fc2ofd3pYhbUf+ouv6QmhtGhRNJzAyw5uBimtoOvYAd6xRiNY/+c/tx83etdhA==
X-Received: by 2002:a05:620a:8d10:b0:77d:c8d2:7f18 with SMTP id rb16-20020a05620a8d1000b0077dc8d27f18mr1013823qkn.28.1701875241282;
        Wed, 06 Dec 2023 07:07:21 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id vy22-20020a05620a491600b0077d66277e9asm11506qkn.116.2023.12.06.07.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 07:07:20 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 6/9] netdev: add netdev_ft_reassociate
Date: Wed,  6 Dec 2023 07:07:05 -0800
Message-Id: <20231206150708.2080336-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206150708.2080336-1-prestwoj@gmail.com>
References: <20231206150708.2080336-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Essentially exposes (and renames) netdev_ft_tx_associate in order to
be called similarly to netdev_reassociate/netdev_connect where a
connect callback can be provided. This will fix the current bug where
if association times out during FT IWD will hang and never transition
to disconnected.

This also removes the calling of the FT_ROAMED event and instead just
calls the connect callback (since its now set). This unifies the
callback path for reassociation and FT roaming.
---
 src/netdev.c | 44 ++++++++++++++++++++++++++------------------
 src/netdev.h |  5 +++++
 2 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index f2e887b4..7d52ffea 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1409,16 +1409,14 @@ static void netdev_connect_ok(struct netdev *netdev)
 			scan_bss_free(netdev->fw_roam_bss);
 
 		netdev->fw_roam_bss = NULL;
-	} else if (netdev->in_ft) {
-		if (netdev->event_filter)
-			netdev->event_filter(netdev, NETDEV_EVENT_FT_ROAMED,
-						NULL, netdev->user_data);
-		netdev->in_ft = false;
 	} else if (netdev->connect_cb) {
 		netdev->connect_cb(netdev, NETDEV_RESULT_OK, NULL,
 					netdev->user_data);
 		netdev->connect_cb = NULL;
-	}
+		netdev->in_ft = false;
+		netdev->in_reassoc = false;
+	} else
+		l_warn("Connection event without a connect callback!");
 
 	netdev_rssi_polling_update(netdev);
 
@@ -4205,13 +4203,14 @@ static int netdev_tx_ft_frame(uint32_t ifindex, uint16_t frame_type,
 	return 0;
 }
 
-static int netdev_ft_tx_associate(uint32_t ifindex, uint32_t freq,
-					const uint8_t *prev_bssid,
-					struct iovec *ft_iov, size_t n_ft_iov)
+int netdev_ft_reassociate(struct netdev *netdev,
+				const struct scan_bss *target_bss,
+				const struct scan_bss *orig_bss,
+				netdev_event_func_t event_filter,
+				netdev_connect_cb_t cb, void *user_data)
 {
-	struct netdev *netdev = netdev_find(ifindex);
-	struct netdev_handshake_state *nhs;
 	struct handshake_state *hs = netdev->handshake;
+	struct netdev_handshake_state *nhs;
 	struct l_genl_msg *msg;
 	struct iovec iov[64];
 	unsigned int n_iov = L_ARRAY_SIZE(iov);
@@ -4223,11 +4222,14 @@ static int netdev_ft_tx_associate(uint32_t ifindex, uint32_t freq,
 	 * At this point there is no going back with FT so reset all the flags
 	 * needed to associate with a new BSS.
 	 */
-	netdev->frequency = freq;
+	netdev->frequency = target_bss->frequency;
 	netdev->handshake->active_tk_index = 0;
 	netdev->associated = false;
 	netdev->operational = false;
 	netdev->in_ft = true;
+	netdev->event_filter = event_filter;
+	netdev->connect_cb = cb;
+	netdev->user_data = user_data;
 
 	/*
 	 * Cancel commands that could be running because of EAPoL activity
@@ -4271,15 +4273,22 @@ static int netdev_ft_tx_associate(uint32_t ifindex, uint32_t freq,
 
 	c_iov = netdev_populate_common_ies(netdev, hs, msg, iov, n_iov, c_iov);
 
-	if (!L_WARN_ON(n_iov - c_iov < n_ft_iov)) {
-		memcpy(iov + c_iov, ft_iov, sizeof(*ft_iov) * n_ft_iov);
-		c_iov += n_ft_iov;
-	}
+	if (hs->supplicant_ie)
+		c_iov = iov_ie_append(iov, n_iov, c_iov, hs->supplicant_ie,
+					IE_LEN(hs->supplicant_ie));
+
+	if (hs->fte)
+		c_iov = iov_ie_append(iov, n_iov, c_iov, hs->fte,
+					IE_LEN(hs->fte));
+
+	if (hs->mde)
+		c_iov = iov_ie_append(iov, n_iov, c_iov, hs->mde,
+					IE_LEN(hs->mde));
 
 	mpdu_sort_ies(subtype, iov, c_iov);
 
 	l_genl_msg_append_attr(msg, NL80211_ATTR_PREV_BSSID, ETH_ALEN,
-				prev_bssid);
+				orig_bss->addr);
 	l_genl_msg_append_attrv(msg, NL80211_ATTR_IE, iov, c_iov);
 
 	netdev->connect_cmd_id = l_genl_family_send(nl80211, msg,
@@ -6256,7 +6265,6 @@ static int netdev_init(void)
 	__eapol_set_install_pmk_func(netdev_set_pmk);
 
 	__ft_set_tx_frame_func(netdev_tx_ft_frame);
-	__ft_set_tx_associate_func(netdev_ft_tx_associate);
 
 	unicast_watch = l_genl_add_unicast_watch(genl, NL80211_GENL_NAME,
 						netdev_unicast_notify,
diff --git a/src/netdev.h b/src/netdev.h
index 03d1b6e9..fb31b571 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -165,6 +165,11 @@ int netdev_reassociate(struct netdev *netdev,
 			struct handshake_state *hs,
 			netdev_event_func_t event_filter,
 			netdev_connect_cb_t cb, void *user_data);
+int netdev_ft_reassociate(struct netdev *netdev,
+				const struct scan_bss *target_bss,
+				const struct scan_bss *orig_bss,
+				netdev_event_func_t event_filter,
+				netdev_connect_cb_t cb, void *user_data);
 
 int netdev_preauthenticate(struct netdev *netdev,
 				const struct scan_bss *target_bss,
-- 
2.34.1

