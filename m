Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F718C13
	for <iwd@lists.linux.dev>; Thu, 31 Aug 2023 12:39:30 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-59254e181a2so9330217b3.1
        for <iwd@lists.linux.dev>; Thu, 31 Aug 2023 05:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693485569; x=1694090369; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4GyF5Z2tT95ItPHRu72vUwbX6kkO12PgZ/NrhU6aHvc=;
        b=gRSpxF07xDgc5ngs89N85A2mx5rKNK7vQYHyqqePavufoQsKN5VdiZc+/L6SN8zIAq
         Ajecu4IuHlCLVgJAuphDy+1biM5S7DQxj9aMD5qGG+1dwQPMZlDq63FoWEYsoNfl11Zo
         7g+kKPM2R1FjbHJiC/oaHKRB5VtJyE8dOELYGkPsIU8DvGJqg05f5FVl2M6RyQKVrUWi
         gCV8Wgy+7BHw8ysA5yS0nLAqabMbKywpP+0ctH0ah4g14wAEroIPyuP4eYWBv3e5P/rV
         pSfhLBb092RVyqumKFABoE9hTK1GBcFz5qOk8bZA8pEewiIh4oApQjL3Ql0dnr+RsBJX
         DGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693485569; x=1694090369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4GyF5Z2tT95ItPHRu72vUwbX6kkO12PgZ/NrhU6aHvc=;
        b=Mw9TwhP0BnsXBVlCRrFm01LzMzsUI18Dl0SgATwNqLJe5LeQlkcHt3Y07YxNDNoGCG
         djjXPlDobb5ECTrRp3J6K3ZyCH3wT9+sQMSUDfg3xkKBAptpZimio36vNXmpCy3x/bdZ
         9R5eBeabBCNZdGvaCYvwTEAo/UcudF6wkzarrj6J90CZdf29YIbqDEnACbh1PyHeM2Ff
         b4fHurxK++xuOe5HbtGPQDAuryemNmuwMfQzLr9Fn9IHxmcxGUGoim5pFPOpqIdStOHG
         W3SN7bGa0Gza9eBYr/kmDxR06NkSAfr36Rej5Vc3HZi6tgEGNt6BP1QNeYLBcQz9qmkJ
         txpw==
X-Gm-Message-State: AOJu0YxaEds0bfB6aZMFj/tbdOTJKJSVLNtCwZlgGJyXIWNf0QL0DoJL
	FnPF3VFMJVF/neGN2tTtFLcgPtgRTHU=
X-Google-Smtp-Source: AGHT+IHRLn7NNTHLO8Nq6epPb9ODX8+q5Nt5IwsC2lnf8ZXqsub4rl1iHD5gacJdJCjHFJ12Tgs5fA==
X-Received: by 2002:a81:6c52:0:b0:57a:5b6f:d41 with SMTP id h79-20020a816c52000000b0057a5b6f0d41mr5324758ywc.42.1693485568898;
        Thu, 31 Aug 2023 05:39:28 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id p5-20020a0dcd05000000b0057a44e20fb8sm380308ywd.73.2023.08.31.05.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 05:39:28 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/3] ft: track FT auth/action response status
Date: Thu, 31 Aug 2023 05:39:22 -0700
Message-Id: <20230831123924.531560-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Use the ft_associate call return to communicate the status (if any)
that was in the auth/action response. If there was a parsing error
or no response -ENOENT is still returned.
---
 src/ft.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

v3:
 * Reordered action parsing to not set IEs unless status == 0

diff --git a/src/ft.c b/src/ft.c
index c51a1288..2cc611b8 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -58,13 +58,14 @@ struct ft_info {
 	uint32_t frequency;
 	uint32_t ds_frequency;
 	uint32_t offchannel_id;
+	/* Status of Authenticate/Action frame response, or error (< 0) */
+	int status;
 
 	struct l_timeout *timeout;
 	struct wiphy_radio_work_item work;
 
 	struct ie_ft_info ft_info;
 
-	bool parsed : 1;
 	bool onchannel : 1;
 };
 
@@ -526,22 +527,23 @@ static int ft_over_ds_parse_action_response(const uint8_t *frame,
 	if (memcmp(spa, hdr->address_1, 6))
 		return -EINVAL;
 
-	status = l_get_le16(frame + 14);
-	if (status != 0)
-		return (int)status;
-
 	if (spa_out)
 		*spa_out = spa;
 
 	if (aa_out)
 		*aa_out = aa;
 
+	status = l_get_le16(frame + 14);
+	if (status != 0)
+		goto done;
+
 	if (ies_out && ies_len) {
 		*ies_out = frame + 16;
 		*ies_len = frame_len - 16;
 	}
 
-	return 0;
+done:
+	return (int)status;
 }
 
 int __ft_rx_associate(uint32_t ifindex, const uint8_t *frame, size_t frame_len)
@@ -825,7 +827,7 @@ void __ft_rx_action(uint32_t ifindex, const uint8_t *frame, size_t frame_len)
 
 	ret = ft_over_ds_parse_action_response(frame, frame_len, &spa, &aa,
 						&ies, &ies_len);
-	if (ret != 0) {
+	if (ret < 0) {
 		l_debug("Could not parse action response");
 		return;
 	}
@@ -836,13 +838,22 @@ void __ft_rx_action(uint32_t ifindex, const uint8_t *frame, size_t frame_len)
 		return;
 	}
 
+
+	if (ret != 0) {
+		l_debug("BSS "MAC" rejected FT action with status=%u",
+				MAC_STR(info->aa), ret);
+		info->status = ret;
+		goto done;
+	}
+
 	if (!ft_parse_ies(info, hs, ies, ies_len)) {
 		l_debug("Could not parse action response IEs");
 		goto ft_error;
 	}
 
-	info->parsed = true;
+	info->status = ret;
 
+done:
 	l_timeout_remove(info->timeout);
 	info->timeout = NULL;
 
@@ -872,6 +883,7 @@ static struct ft_info *ft_info_new(struct handshake_state *hs,
 						target_bss->rsne[1] + 2);
 
 	l_getrandom(info->snonce, 32);
+	info->status = -ENOENT;
 
 	return info;
 }
@@ -1016,6 +1028,7 @@ void __ft_rx_authenticate(uint32_t ifindex, const uint8_t *frame,
 	if (status != 0) {
 		l_debug("BSS "MAC" rejected FT auth with status=%u",
 				MAC_STR(info->aa), status);
+		info->status = status;
 		goto cancel;
 	}
 
@@ -1024,7 +1037,7 @@ void __ft_rx_authenticate(uint32_t ifindex, const uint8_t *frame,
 		goto cancel;
 	}
 
-	info->parsed = true;
+	info->status = status;
 
 cancel:
 	/*
@@ -1164,11 +1177,13 @@ int ft_associate(uint32_t ifindex, const uint8_t *addr)
 	 * Either failed or no response. This may have been an FT-over-DS
 	 * attempt so clear out the entry so FT-over-Air can try again.
 	 */
-	if (!info->parsed) {
+	if (info->status != 0) {
+		int status = info->status;
+
 		l_queue_remove(info_list, info);
 		ft_info_destroy(info);
 
-		return -ENOENT;
+		return status;
 	}
 
 	ft_prepare_handshake(info, hs);
-- 
2.25.1

