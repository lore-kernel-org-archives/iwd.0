Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3574A41754
	for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAq/7Vq3"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6ce2de8da87so3603974a34.1
        for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 09:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699982156; x=1700586956; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABqOeyrR+B6VDoGYx3DuWNHyNf29JEtazO9NhwKGrC8=;
        b=AAq/7Vq390kQjZ/x1kG5zG180ZhdZNKHqXdQY7Q7YgX9EBt3pgMe2e9DZgU34PIRkN
         TKBw9k9mvVmoQFCfBsYRdsCRl4PydeOXntBat9bCVvzwebX75Ts7BtqvkEvE4Q0L20Il
         ztPaayGqCYMnsVe9NC8KVZlu7lflA0TvAyhbCRLy78x5LNqJJDBirg8Ru97QgqZCxS8K
         5iCK6/sl5+rkFQ2BjJ+ex+4PigKp9AXpAWt7+/KIBHCCflVStlFctQ6VcCV8OLDDFNq/
         RCCjyWC1DenJNLftLLh0vy3G/1egiJP4A2VX5L8KJDcah9bEl6HuH+JW6WVvl3l1d5pl
         W8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699982156; x=1700586956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABqOeyrR+B6VDoGYx3DuWNHyNf29JEtazO9NhwKGrC8=;
        b=WVVh7pCBr0jdsRw1BztMHLAi0kyGRPUDd+4t0n9BMwdOySiQR4PDJLfg9weaLcCJp8
         l3T6bNcXbysMJLZIAzrruJyivsxedzrfNONx64vGx45QpRF3vC/tCVAQpyD46yGQw7Rb
         +WOQDS/ZjhM883ylseUnKoe8Xi7fyt6gV4dUCKsGr95NmrlkeLTsfwh10H3lbDAAdvpN
         6MaDcLP8u25YsOrwI7acKO/YyWPKD3J+mVsVFWccUt0Pzyn+pncrN5cLRL+uJv7AqBoJ
         9+hwGG2p583szXqtE7OgyETsyGLZ3fZDarKAtSZzocLV7FEKMQdqpsA7Z2Efagpd9B+R
         1cPg==
X-Gm-Message-State: AOJu0YwDZnV8LO68sxAV5/OYCLxrBDeijffTRYopovEfghmZQ5LIB6wp
	4CTKvms2y4X58hky9BoxlLXn5f+Huic=
X-Google-Smtp-Source: AGHT+IGxW1MJww5vCiHxwjWMZTzUH81dpZnDMKNWmy/Wec5SXSYNVPng+Pzr4xTl43gECObslDpu3g==
X-Received: by 2002:a05:6870:5b8b:b0:1ea:50ec:7087 with SMTP id em11-20020a0568705b8b00b001ea50ec7087mr13275018oab.26.1699982156510;
        Tue, 14 Nov 2023 09:15:56 -0800 (PST)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id o4-20020a05687072c400b001e9a253afa3sm1429647oak.49.2023.11.14.09.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 09:15:56 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 09/11] netdev: Move CMD_NEW_KEY RX-only builder to nl80211util
Date: Tue, 14 Nov 2023 11:14:32 -0600
Message-ID: <20231114171455.1108856-9-denkenz@gmail.com>
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
 src/netdev.c      | 36 +++---------------------------------
 src/nl80211util.c | 29 +++++++++++++++++++++++++++++
 src/nl80211util.h |  6 ++++++
 3 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 64d16d6dc8c6..086c3b9d158b 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1898,36 +1898,6 @@ error:
 	netdev_setting_keys_failed(nhs, err);
 }
 
-static struct l_genl_msg *netdev_build_cmd_new_rx_key_pairwise(
-							struct netdev *netdev,
-							uint32_t cipher,
-							const uint8_t *aa,
-							const uint8_t *tk,
-							size_t tk_len,
-							uint8_t key_id)
-{
-	uint8_t key_mode = NL80211_KEY_NO_TX;
-	uint32_t key_type = NL80211_KEYTYPE_PAIRWISE;
-	struct l_genl_msg *msg;
-
-	msg = l_genl_msg_new_sized(NL80211_CMD_NEW_KEY, 512);
-
-	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, ETH_ALEN, aa);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
-
-	l_genl_msg_enter_nested(msg, NL80211_ATTR_KEY);
-
-	l_genl_msg_append_attr(msg, NL80211_KEY_DATA, tk_len, tk);
-	l_genl_msg_append_attr(msg, NL80211_KEY_CIPHER, 4, &cipher);
-	l_genl_msg_append_attr(msg, NL80211_KEY_IDX, 1, &key_id);
-	l_genl_msg_append_attr(msg, NL80211_KEY_MODE, 1, &key_mode);
-	l_genl_msg_append_attr(msg, NL80211_KEY_TYPE, 4, &key_type);
-
-	l_genl_msg_leave_nested(msg);
-
-	return msg;
-}
-
 static void netdev_group_timeout_cb(struct l_timeout *timeout, void *user_data)
 {
 	struct netdev_handshake_state *nhs = user_data;
@@ -2037,9 +2007,9 @@ static void netdev_set_ext_tk(struct handshake_state *hs, uint8_t key_idx,
 	if (!netdev_copy_tk(tk_buf, tk, cipher, hs->authenticator))
 		goto error;
 
-	msg = netdev_build_cmd_new_rx_key_pairwise(netdev, cipher, addr, tk_buf,
-						crypto_cipher_key_len(cipher),
-						hs->active_tk_index);
+	msg = nl80211_build_new_rx_key_pairwise(netdev->index, cipher, addr,
+					tk_buf, crypto_cipher_key_len(cipher),
+					hs->active_tk_index);
 	nhs->pairwise_new_key_cmd_id =
 		l_genl_family_send(nl80211, msg, netdev_new_rx_pairwise_key_cb,
 						nhs, NULL);
diff --git a/src/nl80211util.c b/src/nl80211util.c
index 437a52d55941..87e859c962e6 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -379,6 +379,35 @@ struct l_genl_msg *nl80211_build_new_key_pairwise(uint32_t ifindex,
 	return msg;
 }
 
+struct l_genl_msg *nl80211_build_new_rx_key_pairwise(uint32_t ifindex,
+						uint32_t cipher,
+						const uint8_t addr[static 6],
+						const uint8_t *tk,
+						size_t tk_len,
+						uint8_t key_id)
+{
+	uint8_t key_mode = NL80211_KEY_NO_TX;
+	uint32_t key_type = NL80211_KEYTYPE_PAIRWISE;
+	struct l_genl_msg *msg;
+
+	msg = l_genl_msg_new_sized(NL80211_CMD_NEW_KEY, 512);
+
+	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, ETH_ALEN, addr);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &ifindex);
+
+	l_genl_msg_enter_nested(msg, NL80211_ATTR_KEY);
+
+	l_genl_msg_append_attr(msg, NL80211_KEY_DATA, tk_len, tk);
+	l_genl_msg_append_attr(msg, NL80211_KEY_CIPHER, 4, &cipher);
+	l_genl_msg_append_attr(msg, NL80211_KEY_IDX, 1, &key_id);
+	l_genl_msg_append_attr(msg, NL80211_KEY_MODE, 1, &key_mode);
+	l_genl_msg_append_attr(msg, NL80211_KEY_TYPE, 4, &key_type);
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
index 00d1ea852671..d8026a8ebc19 100644
--- a/src/nl80211util.h
+++ b/src/nl80211util.h
@@ -50,6 +50,12 @@ struct l_genl_msg *nl80211_build_new_key_pairwise(uint32_t ifindex,
 						const uint8_t *tk,
 						size_t tk_len,
 						uint8_t key_id);
+struct l_genl_msg *nl80211_build_new_rx_key_pairwise(uint32_t ifindex,
+						uint32_t cipher,
+						const uint8_t addr[static 6],
+						const uint8_t *tk,
+						size_t tk_len,
+						uint8_t key_id);
 
 struct l_genl_msg *nl80211_build_set_station_authorized(uint32_t ifindex,
 							const uint8_t *addr);
-- 
2.42.0

