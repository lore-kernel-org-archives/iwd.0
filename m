Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE18C41744
	for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOX1Bd97"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1f4e17c1edfso1949495fac.0
        for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 09:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699982155; x=1700586955; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wc2F2cwzb/8V3d03+M15TY+na+UMBijhWVv0q9U/3+M=;
        b=kOX1Bd97eikB2OhfeCez9EGiJcMttqVpic7TvWENOfgD6AKyiWCMcwp+78BwAthVSn
         52vNj7K16kdHEAPrhZ2kryyW327YMm6pp38Uf5KZz8OmoX6XzpxIAxaAM2KQ+JxrL57T
         99512ZromZAxk9st1GiDI5Hl53xf3tluf7nsDOVIi8jju4dCDFD3FGODk8qdWHKQRNzg
         EZj+7onyHCAqT1r9Ij5nK47dvu3Ho2bcwtaiGHeS9wZB1+OpoykH0rUhixBZLKPqLRQZ
         erGtB5X8MpRukBpV4BmC6FPCy+6T7ikzPFsvY4HssfvpGs+ph7z4ugSRyVYwI/JQ+12E
         akuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699982155; x=1700586955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wc2F2cwzb/8V3d03+M15TY+na+UMBijhWVv0q9U/3+M=;
        b=cS7LuVKvqB1ONXmQjDWIjMgjykhJA2sE/gmN0O9l1rmK930qy33r3/ABWCwFRzEZlA
         boGSSbrjx6quhgvykvoHl3K+zaAhII4G22H07AoNVlgrPkl/9Jg5fmYk8bZYW2YQBndy
         IMkT+aDNG4XptEup3SI9GsG8lE6fmDqicR88ULDE9qLr/7YkJqY+lZ5R0b3KlgL/PIPK
         /jVLwpMXZQ7R+r4rE9VXRqEQATa6d5YgTMIsV2NMLSWsbAJz4dVlmilX0PZrggXnBnLr
         6bMluYh+lsyXtDDm9E7GbpSGPekZLEwTaZ7HGdSXgghJIF3mfUPdQaBcFrBrRcAL1T+O
         rZXA==
X-Gm-Message-State: AOJu0Yxaov8faUlBcUI2UrLHmyxM0GwMAf8go57A1//rcwl2cQXHYZ78
	7NBT9jt5v47PNrkSmj5jdd9L3m5H+Hk=
X-Google-Smtp-Source: AGHT+IHKYwz0w+pID75rhV537lcAM4VvTHGuI4O3zLXbvrs0whkm0m8kSgFDkpWAB7UWUGhpB8Ricw==
X-Received: by 2002:a05:6870:c144:b0:1eb:1fa3:7af6 with SMTP id g4-20020a056870c14400b001eb1fa37af6mr13822968oad.18.1699982155451;
        Tue, 14 Nov 2023 09:15:55 -0800 (PST)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id o4-20020a05687072c400b001e9a253afa3sm1429647oak.49.2023.11.14.09.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 09:15:54 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 08/11] netdev: Move pairwise NEW_KEY builder to nl80211util
Date: Tue, 14 Nov 2023 11:14:31 -0600
Message-ID: <20231114171455.1108856-8-denkenz@gmail.com>
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
 src/netdev.c      | 27 +++------------------------
 src/nl80211util.c | 20 ++++++++++++++++++++
 src/nl80211util.h |  6 ++++++
 3 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 38fb759058c3..64d16d6dc8c6 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1898,27 +1898,6 @@ error:
 	netdev_setting_keys_failed(nhs, err);
 }
 
-static struct l_genl_msg *netdev_build_cmd_new_key_pairwise(
-							struct netdev *netdev,
-							uint32_t cipher,
-							const uint8_t *aa,
-							const uint8_t *tk,
-							size_t tk_len,
-							uint8_t key_id)
-{
-	struct l_genl_msg *msg;
-
-	msg = l_genl_msg_new_sized(NL80211_CMD_NEW_KEY, 512);
-
-	l_genl_msg_append_attr(msg, NL80211_ATTR_KEY_DATA, tk_len, tk);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_KEY_CIPHER, 4, &cipher);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, ETH_ALEN, aa);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_KEY_IDX, 1, &key_id);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
-
-	return msg;
-}
-
 static struct l_genl_msg *netdev_build_cmd_new_rx_key_pairwise(
 							struct netdev *netdev,
 							uint32_t cipher,
@@ -2024,9 +2003,9 @@ static void netdev_set_tk(struct handshake_state *hs, uint8_t key_index,
 	if (!netdev_copy_tk(tk_buf, tk, cipher, hs->authenticator))
 		goto invalid_key;
 
-	msg = netdev_build_cmd_new_key_pairwise(netdev, cipher, addr, tk_buf,
-						crypto_cipher_key_len(cipher),
-						key_index);
+	msg = nl80211_build_new_key_pairwise(netdev->index, cipher, addr,
+					tk_buf, crypto_cipher_key_len(cipher),
+					key_index);
 	nhs->pairwise_new_key_cmd_id =
 		l_genl_family_send(nl80211, msg, netdev_new_pairwise_key_cb,
 						nhs, NULL);
diff --git a/src/nl80211util.c b/src/nl80211util.c
index 1d1d7099e575..437a52d55941 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -359,6 +359,26 @@ struct l_genl_msg *nl80211_build_new_key_group(uint32_t ifindex, uint32_t cipher
 	return msg;
 }
 
+struct l_genl_msg *nl80211_build_new_key_pairwise(uint32_t ifindex,
+						uint32_t cipher,
+						const uint8_t addr[static 6],
+						const uint8_t *tk,
+						size_t tk_len,
+						uint8_t key_id)
+{
+	struct l_genl_msg *msg;
+
+	msg = l_genl_msg_new_sized(NL80211_CMD_NEW_KEY, 512);
+
+	l_genl_msg_append_attr(msg, NL80211_ATTR_KEY_DATA, tk_len, tk);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_KEY_CIPHER, 4, &cipher);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, ETH_ALEN, addr);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_KEY_IDX, 1, &key_id);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &ifindex);
+
+	return msg;
+}
+
 static struct l_genl_msg *nl80211_build_set_station(uint32_t ifindex,
 					const uint8_t *addr,
 					struct nl80211_sta_flag_update *flags)
diff --git a/src/nl80211util.h b/src/nl80211util.h
index 755133a37bb7..00d1ea852671 100644
--- a/src/nl80211util.h
+++ b/src/nl80211util.h
@@ -44,6 +44,12 @@ struct l_genl_msg *nl80211_build_new_key_group(uint32_t ifindex,
 					const uint8_t *key, size_t key_len,
 					const uint8_t *ctr, size_t ctr_len,
 					const uint8_t *addr);
+struct l_genl_msg *nl80211_build_new_key_pairwise(uint32_t ifindex,
+						uint32_t cipher,
+						const uint8_t addr[static 6],
+						const uint8_t *tk,
+						size_t tk_len,
+						uint8_t key_id);
 
 struct l_genl_msg *nl80211_build_set_station_authorized(uint32_t ifindex,
 							const uint8_t *addr);
-- 
2.42.0

