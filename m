Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EBF41773
	for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMR04ijn"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1ea98ad294cso2856907fac.3
        for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 09:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699982158; x=1700586958; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Fbz7LrAeXCvRPYPPnZxViqhJz/hbgV33uJ0mY7hiPI=;
        b=lMR04ijnP2OscXrM8YUMr3pG8C5oZnRrGVsJm04jj2GvnWS6DKzVOT80W/RzwHr3W1
         2sPeXAmOQHSVdqe3R+uFK0Hu3hFIjYX9W23LSCr+qu1DPIXWFzj4P3caKshg2U3rUojA
         SVwxfWVZXSfvLx1Bkg3VfGTfgx7h0A7KmdNvXxsOBPSmS5upGIgOp4/bWC9mcnJbl3GZ
         OlvrwR/wGd5UQKx1eCFDV1PRu/aO3nKdQYYPt8Do/aB4GJtcw1WLAzhETxTvF60TSCjH
         fn7m0rhO5Mmwd508XWkINNMHZkmhgn2oI5GuK75/K8tmQbTm1r2d1bfc6ULXfrFIN7dG
         hZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699982158; x=1700586958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Fbz7LrAeXCvRPYPPnZxViqhJz/hbgV33uJ0mY7hiPI=;
        b=ZuwhYe0kf70TyNXPFMx2WYrJtE2LG0KTNJbqtrK1/4p2Sf/j7qiLViX/lYVXFA3kN3
         uDPYcfKVdtk19i8Q1gfqx5BXRHAJj07fCYFfCAddmaPgSR7zTEahdIJG1rRfgYxhDBNb
         0kfaBT+fIZuYnuaP/IwUtYWPOBUy2gcxnvW8POtPF8akU5nlMKJ2HhQED78nupnU+O7M
         e3/rnORpUxPGxAZheb+11ZRqqYrP9A/lhv8eGSFPy2TDZlU6lBOGZhQFGTHvP4vH2+IJ
         pdX4Xmp+aZRBsrCI5EvW4MTR3MWV2m5WpL5FR26qrwc5Y8sHt3qBtid7Co+ZxtvugocC
         5V8g==
X-Gm-Message-State: AOJu0Yyhxa/ExBwvE/tTg8mA8G4su31x4trkdzuhty1R/f407t/NkyVY
	tTZnq/sILnQLQn1o7ROG4TC0NOtmzbo=
X-Google-Smtp-Source: AGHT+IHfEKvG69pwOE9axskxId17IPwLR0nU8WPmvSV+RfjM22aGO8juD1pm1whCThV0yC/fqcHSvw==
X-Received: by 2002:a05:6870:a927:b0:1ea:7002:494d with SMTP id eq39-20020a056870a92700b001ea7002494dmr11232310oab.46.1699982157841;
        Tue, 14 Nov 2023 09:15:57 -0800 (PST)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id o4-20020a05687072c400b001e9a253afa3sm1429647oak.49.2023.11.14.09.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 09:15:57 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 10/11] netdev: Move CMD_REKEY_OFFLOAD builder to nl80211util
Date: Tue, 14 Nov 2023 11:14:33 -0600
Message-ID: <20231114171455.1108856-10-denkenz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231114171455.1108856-1-denkenz@gmail.com>
References: <20231114171455.1108856-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/netdev.c      | 26 +-------------------------
 src/nl80211util.c | 24 ++++++++++++++++++++++++
 src/nl80211util.h |  5 +++++
 3 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 086c3b9d158b..418626d72579 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2163,30 +2163,6 @@ static void hardware_rekey_cb(struct l_genl_msg *msg, void *data)
 	}
 }
 
-static struct l_genl_msg *netdev_build_cmd_replay_counter(struct netdev *netdev,
-							const uint8_t *kek,
-							const uint8_t *kck,
-							uint64_t replay_ctr)
-{
-	struct l_genl_msg *msg;
-
-	msg = l_genl_msg_new_sized(NL80211_CMD_SET_REKEY_OFFLOAD, 512);
-
-	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
-
-	l_genl_msg_enter_nested(msg, NL80211_ATTR_REKEY_DATA);
-	l_genl_msg_append_attr(msg, NL80211_REKEY_DATA_KEK,
-					NL80211_KEK_LEN, kek);
-	l_genl_msg_append_attr(msg, NL80211_REKEY_DATA_KCK,
-					NL80211_KCK_LEN, kck);
-	l_genl_msg_append_attr(msg, NL80211_REKEY_DATA_REPLAY_CTR,
-			NL80211_REPLAY_CTR_LEN, &replay_ctr);
-
-	l_genl_msg_leave_nested(msg);
-
-	return msg;
-}
-
 static void netdev_set_rekey_offload(uint32_t ifindex,
 					const uint8_t *kek,
 					const uint8_t *kck,
@@ -2207,7 +2183,7 @@ static void netdev_set_rekey_offload(uint32_t ifindex,
 		return;
 
 	l_debug("%d", netdev->index);
-	msg = netdev_build_cmd_replay_counter(netdev, kek, kck, replay_counter);
+	msg = nl80211_build_rekey_offload(ifindex, kek, kck, replay_counter);
 	netdev->rekey_offload_cmd_id = l_genl_family_send(nl80211, msg,
 							hardware_rekey_cb,
 							netdev, NULL);
diff --git a/src/nl80211util.c b/src/nl80211util.c
index 87e859c962e6..ef69cc718e04 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -408,6 +408,30 @@ struct l_genl_msg *nl80211_build_new_rx_key_pairwise(uint32_t ifindex,
 	return msg;
 }
 
+struct l_genl_msg *nl80211_build_rekey_offload(uint32_t ifindex,
+						const uint8_t *kek,
+						const uint8_t *kck,
+						uint64_t replay_ctr)
+{
+	struct l_genl_msg *msg;
+
+	msg = l_genl_msg_new_sized(NL80211_CMD_SET_REKEY_OFFLOAD, 512);
+
+	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &ifindex);
+
+	l_genl_msg_enter_nested(msg, NL80211_ATTR_REKEY_DATA);
+	l_genl_msg_append_attr(msg, NL80211_REKEY_DATA_KEK,
+					NL80211_KEK_LEN, kek);
+	l_genl_msg_append_attr(msg, NL80211_REKEY_DATA_KCK,
+					NL80211_KCK_LEN, kck);
+	l_genl_msg_append_attr(msg, NL80211_REKEY_DATA_REPLAY_CTR,
+			NL80211_REPLAY_CTR_LEN, &replay_ctr);
+
+	l_genl_msg_leave_nested(msg);
+
+	return msg;
+}
+
 static struct l_genl_msg *nl80211_build_set_station(uint32_t ifindex,
 					const uint8_t *addr,
 					struct nl80211_sta_flag_update *flags)
diff --git a/src/nl80211util.h b/src/nl80211util.h
index d8026a8ebc19..9f8ae17aeaa4 100644
--- a/src/nl80211util.h
+++ b/src/nl80211util.h
@@ -57,6 +57,11 @@ struct l_genl_msg *nl80211_build_new_rx_key_pairwise(uint32_t ifindex,
 						size_t tk_len,
 						uint8_t key_id);
 
+struct l_genl_msg *nl80211_build_rekey_offload(uint32_t ifindex,
+						const uint8_t *kek,
+						const uint8_t *kck,
+						uint64_t replay_ctr);
+
 struct l_genl_msg *nl80211_build_set_station_authorized(uint32_t ifindex,
 							const uint8_t *addr);
 
-- 
2.42.0

