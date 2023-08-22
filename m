Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326311CA14
	for <iwd@lists.linux.dev>; Tue, 22 Aug 2023 15:29:39 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-58d40c2debeso51765717b3.2
        for <iwd@lists.linux.dev>; Tue, 22 Aug 2023 08:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692718178; x=1693322978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mCmgO71zL3J90eG6tcMbRn9aHf6avy9jpnCHrt7Xvg=;
        b=iyjnt+22NV4Nb/W0aEcOgKgDfDwKBK83C7CAH3Fi/0HjuTmzQuVF5Zk1XUQ/GIkVe0
         oSYU5ouPo+mbCiiW8cAwRyDkqMppG6TI9MpweBLMeCZ0H3VyHKJnmrYkSIjzGqIEhY53
         zMnR3B9eGfke/EZm5yUtzohBwPB0FeFQ0Yg10SX3MyNzVSud3KDW2XuIxRcPJ6yExDyz
         36FA6UhMH+mNCyjKyv87Hq63hU0iuWSG8+ixzYEh6YhW3NSEPbINnQ9KOiYr4XRPMjkK
         j4rpeX+XATADcOSyj81cLod1DGBTq/bk7ExxaRSqa5bP0d74iGBseqrZQqElHRhWN6EH
         WLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692718178; x=1693322978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mCmgO71zL3J90eG6tcMbRn9aHf6avy9jpnCHrt7Xvg=;
        b=MyVdXk7v9aZpHRREBCSW6YsjwooWoIvJAsJbBj20u8iQkzUlOOdf6/zBicPJkqIhGk
         48Q/sf8q2xzOs/i25dUci7rxgllGmR7pF43GyVCmBI6HzseZziL5F+SDhMhCcSvPv067
         daOvYdtGzrRf611GcVyTqAhr9v6wVGZUa9HPKpiaSpWp0GZDT/wfOnd28+I0/Skrk1Jp
         AH2gN9BIlx8JM6XaixlyBXnNTasJSV9HkLGXUYC36zu7P5rVT/2p2T1Z+vP9PDoL4cMf
         LQCG+XK/A4d9bgfwVw4Mo2S9TTr3D8akfvCeQS7v4jgk+QZTpbOqeaArXy40DmwLXPzK
         zKkw==
X-Gm-Message-State: AOJu0YyLHyHismXSIeKKNcUpNxQac8T/T3yPRAs9sEKHTJfgFZcwVfem
	GbF/97Ee6krctzqDa23Wobt/RLAyiFg=
X-Google-Smtp-Source: AGHT+IHdofsiqoFon0PunHXtSgvxLFoO0bYnz55wQUrxKcoWiqp8jOKBEJfTGfkNGK0tFCUV5XYRXg==
X-Received: by 2002:a81:6ed6:0:b0:589:8b56:15f with SMTP id j205-20020a816ed6000000b005898b56015fmr10105192ywc.24.1692718177864;
        Tue, 22 Aug 2023 08:29:37 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id j189-20020a816ec6000000b0058fafe95f98sm2108796ywc.114.2023.08.22.08.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 08:29:37 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] ft: track FT auth/action response status
Date: Tue, 22 Aug 2023 08:29:29 -0700
Message-Id: <20230822152931.276136-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230822152931.276136-1-prestwoj@gmail.com>
References: <20230822152931.276136-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Certain return codes, though failures, can indicate that the AP is
just confused or booting up and treating it as a full failure may
not be the best route.

For example in some production deployments if an AP is rebooted it
may take some time for neighboring APs to exchange keys for
current associations. If a client roams during that time it will
reject saying the PMKID is invalid.

Use the ft_associate call to relay this information to station to
handle it rather than acting like there was no response. For now
this is being hard coded to status=53, but more could be added,
or the status itself could be returned if there are other specific
status codes that need to be handled.
---
 src/ft.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/src/ft.c b/src/ft.c
index c51a1288..8dfc1cb7 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -58,6 +58,7 @@ struct ft_info {
 	uint32_t frequency;
 	uint32_t ds_frequency;
 	uint32_t offchannel_id;
+	uint16_t status;
 
 	struct l_timeout *timeout;
 	struct wiphy_radio_work_item work;
@@ -155,6 +156,7 @@ static bool ft_parse_authentication_resp_frame(const uint8_t *data, size_t len,
 	if (memcmp(data + 16, addr3, 6))
 		return false;
 
+
 	/* Check Authentication algorithm number is FT (2) */
 	if (l_get_le16(data + 24) != 2)
 		return false;
@@ -527,8 +529,6 @@ static int ft_over_ds_parse_action_response(const uint8_t *frame,
 		return -EINVAL;
 
 	status = l_get_le16(frame + 14);
-	if (status != 0)
-		return (int)status;
 
 	if (spa_out)
 		*spa_out = spa;
@@ -541,7 +541,7 @@ static int ft_over_ds_parse_action_response(const uint8_t *frame,
 		*ies_len = frame_len - 16;
 	}
 
-	return 0;
+	return (int)status;
 }
 
 int __ft_rx_associate(uint32_t ifindex, const uint8_t *frame, size_t frame_len)
@@ -825,7 +825,7 @@ void __ft_rx_action(uint32_t ifindex, const uint8_t *frame, size_t frame_len)
 
 	ret = ft_over_ds_parse_action_response(frame, frame_len, &spa, &aa,
 						&ies, &ies_len);
-	if (ret != 0) {
+	if (ret < 0) {
 		l_debug("Could not parse action response");
 		return;
 	}
@@ -836,6 +836,14 @@ void __ft_rx_action(uint32_t ifindex, const uint8_t *frame, size_t frame_len)
 		return;
 	}
 
+	info->status = ret;
+
+	if (info->status != 0) {
+		l_debug("BSS "MAC" rejected FT action with status=%u",
+				MAC_STR(info->aa), info->status);
+		goto done;
+	}
+
 	if (!ft_parse_ies(info, hs, ies, ies_len)) {
 		l_debug("Could not parse action response IEs");
 		goto ft_error;
@@ -843,6 +851,7 @@ void __ft_rx_action(uint32_t ifindex, const uint8_t *frame, size_t frame_len)
 
 	info->parsed = true;
 
+done:
 	l_timeout_remove(info->timeout);
 	info->timeout = NULL;
 
@@ -872,6 +881,7 @@ static struct ft_info *ft_info_new(struct handshake_state *hs,
 						target_bss->rsne[1] + 2);
 
 	l_getrandom(info->snonce, 32);
+	info->status = 0xffff;
 
 	return info;
 }
@@ -998,7 +1008,6 @@ void __ft_rx_authenticate(uint32_t ifindex, const uint8_t *frame,
 	struct netdev *netdev = netdev_find(ifindex);
 	struct handshake_state *hs = netdev_get_handshake(netdev);
 	struct ft_info *info;
-	uint16_t status;
 	const uint8_t *ies;
 	size_t ies_len;
 
@@ -1008,14 +1017,14 @@ void __ft_rx_authenticate(uint32_t ifindex, const uint8_t *frame,
 
 	if (!ft_parse_authentication_resp_frame(frame, frame_len,
 					info->spa, info->aa, info->aa, 2,
-					&status, &ies, &ies_len)) {
+					&info->status, &ies, &ies_len)) {
 		l_debug("Could not parse auth response");
 		return;
 	}
 
-	if (status != 0) {
+	if (info->status != 0) {
 		l_debug("BSS "MAC" rejected FT auth with status=%u",
-				MAC_STR(info->aa), status);
+				MAC_STR(info->aa), info->status);
 		goto cancel;
 	}
 
@@ -1165,10 +1174,20 @@ int ft_associate(uint32_t ifindex, const uint8_t *addr)
 	 * attempt so clear out the entry so FT-over-Air can try again.
 	 */
 	if (!info->parsed) {
+		uint16_t status = info->status;
+
 		l_queue_remove(info_list, info);
 		ft_info_destroy(info);
 
-		return -ENOENT;
+		/*
+		 * The status may have been successful but the IEs were invalid,
+		 * treat this the same as no response.
+		 */
+		if (status == 0xffff || status == 0)
+			return -ENOENT;
+
+		/* If the AP rejected for some reason, relay this to station */
+		return (int)status;
 	}
 
 	ft_prepare_handshake(info, hs);
-- 
2.25.1

