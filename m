Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E836F61F
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIW+8r0I"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d0c94397c0so1253345ad.2
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 12:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701893892; x=1702498692; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8ajSUum+U4KJg54/Nve5xodtgkJ4Z3hifVFPGvmfaM=;
        b=CIW+8r0IgC3+uJ+VZDxtWkWSN6LQrtM8kXxib0lOlCE0Xu4LWvJkIwLDWn6nrYcekx
         Qpv0+8/YGvPJlUckzThzV5JZ9rnx6Le/11XNfNgJVuPYjP8uFB7XDEqkgDmqQaGzPWn2
         S87RLHkxkHL/KqgrODJrZfrILiAm1GPtIthMyoj3NkqLFqplO7N9fCHYu2fB/OLwPDgO
         1KOjFjCyPthMkkpFFJx5i/8WkcDXAXYTGs+uOXWZH6g9VcIixaSiCZfTi/TrvgBQhWIq
         GV3Oe9sBu57NzWav2MPMAfIhFZuRLDGzWjwOKTfeQaphmulF8v8rsHeN0vC64qnraDcC
         15QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701893892; x=1702498692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8ajSUum+U4KJg54/Nve5xodtgkJ4Z3hifVFPGvmfaM=;
        b=f43Q4z3N24tA9ugZsAzIYkiRpUBd5GBqAi0HzWKhJgaeTnxVb7YMDSX+K/zVdzwM9i
         EZI+IhC3c1LQv7qgt+cgwZG4Bd8lH4nNuzc4ZeiHX6lxwxw3ynIbLtPQ1qfWCXM8jPts
         lTTd1nYZ3a6l4o/ox6D7VHB0fkcwVabvna3BRptgeK+ljvLMLNVMTJL9CYs/dnkabDnl
         HHqCQcPapx2scyqP9kRaEaj8jay9RKu7S+Da9i2vn7XWvf2pEJ9ILrhjv1uSeHQ8wfEA
         +y0e+tuhD8g7Z2VnHx9idBtzu/YWbdl2BTrc92yW2lxtKsIA436YpF4bwfN+nkMmfjDt
         PrHw==
X-Gm-Message-State: AOJu0YwK0MbDMI20DdPw1Wy44bp1f/wpcliqhbhjYEeKuYQlFk+QTBUP
	NUKvvdokYXSWYnBHFdfpXRxD6FJKVeQrzA==
X-Google-Smtp-Source: AGHT+IHO25WLCOPkudPcvChAt+JUiMSr41SYbmGel6D9gB38DesTHIDEBuJa8KP3JoJZSxsSFCifZw==
X-Received: by 2002:a17:902:c94b:b0:1d0:6ffd:ae11 with SMTP id i11-20020a170902c94b00b001d06ffdae11mr1687058pla.120.1701893892455;
        Wed, 06 Dec 2023 12:18:12 -0800 (PST)
Received: from LOCLAP699.. ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id by40-20020a056a0205a800b005c2185be2basm243168pgb.54.2023.12.06.12.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 12:18:12 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 10/13] netdev: add netdev_ft_reassociate
Date: Wed,  6 Dec 2023 12:17:59 -0800
Message-Id: <20231206201802.2139649-10-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206201802.2139649-1-prestwoj@gmail.com>
References: <20231206201802.2139649-1-prestwoj@gmail.com>
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
 src/netdev.c | 43 +++++++++++++++++++++++++------------------
 src/netdev.h |  5 +++++
 2 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index b9dc930e..522baf7a 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1409,16 +1409,13 @@ static void netdev_connect_ok(struct netdev *netdev)
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
+	} else
+		l_warn("Connection event without a connect callback!");
 
 	netdev_rssi_polling_update(netdev);
 
@@ -4205,13 +4202,14 @@ static int netdev_tx_ft_frame(uint32_t ifindex, uint16_t frame_type,
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
@@ -4223,11 +4221,14 @@ static int netdev_ft_tx_associate(uint32_t ifindex, uint32_t freq,
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
@@ -4271,15 +4272,22 @@ static int netdev_ft_tx_associate(uint32_t ifindex, uint32_t freq,
 
 	c_iov = netdev_populate_common_ies(netdev, hs, msg, iov, n_iov, c_iov);
 
-	if (!L_WARN_ON(n_iov - c_iov < n_ft_iov)) {
-		memcpy(iov + c_iov, ft_iov, sizeof(*ft_iov) * n_ft_iov);
-		c_iov += n_ft_iov;
-	}
+	if (hs->supplicant_ie)
+		c_iov = iov_ie_append(iov, n_iov, c_iov, hs->supplicant_ie,
+					IE_LEN(hs->supplicant_ie));
+
+	if (hs->supplicant_fte)
+		c_iov = iov_ie_append(iov, n_iov, c_iov, hs->supplicant_fte,
+					IE_LEN(hs->supplicant_fte));
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
@@ -6256,7 +6264,6 @@ static int netdev_init(void)
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

