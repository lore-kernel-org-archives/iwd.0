Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DF06F604
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 20:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0x0oEEK"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d048c171d6so1453085ad.1
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 12:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701893892; x=1702498692; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyQGXto/GxzHzfAsGHjVXz/14qfSbn0f8ejMzfWWMqs=;
        b=Q0x0oEEKaPnGu2QtDNQjXLNyz6TT3UWIVwXQ8AbAbQIWpdbWfGUNqptYj44Nb2bEhf
         wioT6P8dBWBqqsHVRUixWa5/4Nvw4feq7WClE+oNP6WHT8NiGjyEamu5o4MO1pgQNj/m
         KQcJNqZGbSf9xEpUf9Ei62boK6NhwGx6tMKlRqg3cllk5begpOLwWUAWCkvHE3umUCj6
         Boeo1UJOBI/fdC45Y/qLA1gTpRq/DvCRkR5804SKwe433Ibc0GrFwPTwUHQ4c+lx0ZMK
         CnFPXZg3hDe1vJRHsS4o/SThbYpat40YLrTAW6/a7nRvZsR229LYUncqIbRhCRMSWhQJ
         Enow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701893892; x=1702498692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RyQGXto/GxzHzfAsGHjVXz/14qfSbn0f8ejMzfWWMqs=;
        b=WDPBwjcWrvZZuL82VJvyvDhVyRWZlGnrqZcBNU7VJuCc48K4gsLF2Ab4VWPQWdaMIq
         4eZawgycoSVr+J/z/+ch9JbX/hBlY8UMBp+XZQbQGIlsZkfm2vQVLCbe5n8xNcfiKIdB
         6QPyHvI953uwDDUMOWZg+AaZUGZvE+vFw1Eg2SZsg9ADya6tBW7RVgf7X4g3QrN0e1Nw
         6108FZnynqxttzhNQJoSkmIdZRnMtCnRpuVmQoNTXulF9DtH+80zCePXh+5PENcvMscd
         TuH29fruxtGW4dN6wtYlKKdUjEHLL2gVNhE6mFqIJ1FuMj3xJHpM/iviK6D9WopeKr00
         ZK3A==
X-Gm-Message-State: AOJu0YwmHIrQP9C30GXrJFzrus6VaUdnp1sCReaow+qIQIFhDQYDZOOT
	pi7GNM1LnjdILGTXYIp4aJTC+fJS07LOZg==
X-Google-Smtp-Source: AGHT+IGNme2hqmsGmSEUA9ayod4/Y7pU4T52Blx7CeJ2c1z9/ayBSYw3ZOKwsfj6dsRMSMoLeNhpIg==
X-Received: by 2002:a17:903:483:b0:1d0:60cc:7ebb with SMTP id jj3-20020a170903048300b001d060cc7ebbmr1405718plb.25.1701893891971;
        Wed, 06 Dec 2023 12:18:11 -0800 (PST)
Received: from LOCLAP699.. ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id by40-20020a056a0205a800b005c2185be2basm243168pgb.54.2023.12.06.12.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 12:18:11 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 09/13] ft: add ft_handshake_setup
Date: Wed,  6 Dec 2023 12:17:58 -0800
Message-Id: <20231206201802.2139649-9-prestwoj@gmail.com>
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

This will be called from station after FT-authentication has
finished. It sets up the handshake object to perform reassociation.

This is essentially a copy-paste of ft_associate without sending
the actual frame.
---
 src/ft.c | 40 ++++++++++++++++++++++++++++++++++++++++
 src/ft.h |  2 ++
 2 files changed, 42 insertions(+)

diff --git a/src/ft.c b/src/ft.c
index d3b9234a..c612a433 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -1276,6 +1276,46 @@ int ft_associate(uint32_t ifindex, const uint8_t *addr)
 	return ret;
 }
 
+int ft_handshake_setup(uint32_t ifindex, const uint8_t *target)
+{
+	struct netdev *netdev = netdev_find(ifindex);
+	struct handshake_state *hs = netdev_get_handshake(netdev);
+	struct ft_info *info;
+	int ret = 0;
+
+	info = ft_info_find(ifindex, target);
+	if (!info)
+		return -ENOENT;
+
+	/*
+	 * Either failed or no response. This may have been an FT-over-DS
+	 * attempt so clear out the entry so FT-over-Air can try again.
+	 */
+	if (info->status != 0) {
+		int status = info->status;
+
+		l_queue_remove(info_list, info);
+		ft_info_destroy(info);
+
+		return status;
+	}
+
+	/*
+	 * This shouldn't ever fail:
+	 *  - supplicant_ie has already been validated long ago
+	 *  - l_checksum_* shouldn't fail since we presumable have kernel
+	 *    support, how else could we have made it this far.
+	 * But just in case...
+	 */
+	if (L_WARN_ON(!ft_prepare_handshake(info, hs)))
+		ret = -EINVAL;
+
+	/* After this no previous auths will be valid */
+	ft_clear_authentications(ifindex);
+
+	return ret;
+}
+
 static bool remove_ifindex(void *data, void *user_data)
 {
 	struct ft_info *info = data;
diff --git a/src/ft.h b/src/ft.h
index 51bbe3bc..23d0136e 100644
--- a/src/ft.h
+++ b/src/ft.h
@@ -39,6 +39,8 @@ void __ft_rx_action(uint32_t ifindex, const uint8_t *frame, size_t frame_len);
 void __ft_rx_authenticate(uint32_t ifindex, const uint8_t *frame,
 				size_t frame_len);
 
+int ft_handshake_setup(uint32_t ifindex, const uint8_t *target);
+
 void ft_clear_authentications(uint32_t ifindex);
 int ft_action(uint32_t ifindex, uint32_t freq, const struct scan_bss *target);
 int ft_associate(uint32_t ifindex, const uint8_t *addr);
-- 
2.34.1

