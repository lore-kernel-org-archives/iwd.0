Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3013C3C6A9
	for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 20:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlJzTygu"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1c894e4573bso10966205ad.0
        for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 13:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140921; x=1697745721; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MA2LqZA9NCa5av6PhWUtg0c+6eBsQd5d5126UoN66bU=;
        b=MlJzTyguP+8+tAu9TNozbziZ55RUHhWkEO9h4jkN8IlopcdM58D36/XxTff6rnXnJq
         GSc3XqjSpSwSxOKUsDgCGERblQ/zpIlSKNIbZWQ1Xlo5CXwICn+efzKhpcKq7WuXKgHO
         Rg82iNYBBMChrgNixed7tGqJrnMR0SLp5GKIuOt3D27yha4IDjLvukoqcs5ofnGxTQy3
         6uSuVa9Tx42pa67ku7ydbM9VA7X4+TmJxzY1lQHL9TqHZhL22J1shVRMxTTIuKHaDr0W
         kRdP74UPVu88gozyBReVAPLpAqjtGFJYz3uYZlA1xnHY5jn/fqWYPylRc6l8bYauxSGw
         1+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140921; x=1697745721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MA2LqZA9NCa5av6PhWUtg0c+6eBsQd5d5126UoN66bU=;
        b=Sm33zwQLwjXS4Pt1X6BdNrFyFrT21bIy4EmL4NK/yU8n9IYoE3MKvulCqT2h9Ykzce
         kKpoHZx3cqI2SwAZF+TqCtccGVRJ3lTqdDdGNcUD8du+65mm+AxTeL4Ami6+/11JH5nY
         kO5bHb+2Q2bEsl6KRlvIA51T8UnpQ+keye/y+g4ko1zG1WAp34tuLPpwe6BxG4YuBn9L
         bMdAUB0OOPmqh1WJUDq7iU0/ktVQMJTFvjkjyqHJDfxiIgevwxKqIfAs4nlLqHcc3F+I
         BRdhVOMaHnr7Qj2L7P+XOgAby+nSMNsA2lDSm3KWgUd0fsrGm6qEGOQTVXhF7qZtBl++
         +1OA==
X-Gm-Message-State: AOJu0YxXM2+Ns1XST1HxmLWxJgc8mv4XzgLnLF6X1c2zULlu0Rn/o7si
	aRzTdElcdIuURvahXhwLJgPgmG2sK30=
X-Google-Smtp-Source: AGHT+IGmRlm6f2Oi+J5VqvUnFTvh1w+AqpKzVgrjbSv/oFfEfC9usacF/T+cqSIx9ysiLmI/U7AolQ==
X-Received: by 2002:a17:903:234e:b0:1c6:1fc3:6857 with SMTP id c14-20020a170903234e00b001c61fc36857mr28471159plh.27.1697140921602;
        Thu, 12 Oct 2023 13:02:01 -0700 (PDT)
Received: from localhost.localdomain (h67-204-152-76.bendor.broadband.dynamic.tds.net. [67.204.152.76])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902f68400b001c727d3ea6bsm2388057plg.74.2023.10.12.13.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:02:01 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 05/21] dpp: move/store max_roc setting into dpp_create
Date: Thu, 12 Oct 2023 13:01:34 -0700
Message-Id: <20231012200150.338401-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012200150.338401-1-prestwoj@gmail.com>
References: <20231012200150.338401-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This value won't change since its per-phy so initialize it
when creating the DPP state machine rather than every time
DPP is started.
---
 src/dpp.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 3a20f8ae..a5bc2e0a 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -111,6 +111,7 @@ struct dpp_sm {
 	uint32_t current_freq;
 	uint32_t new_freq;
 	struct scan_freq_set *presence_list;
+	uint32_t max_roc;
 
 	uint32_t offchannel_id;
 
@@ -2364,13 +2365,15 @@ static void dpp_create(struct netdev *netdev)
 	struct dpp_sm *dpp = l_new(struct dpp_sm, 1);
 	uint8_t dpp_conf_response_prefix[] = { 0x04, 0x0b };
 	uint8_t dpp_conf_request_prefix[] = { 0x04, 0x0a };
+	uint64_t wdev_id = netdev_get_wdev_id(netdev);
 
 	dpp->netdev = netdev;
 	dpp->state = DPP_STATE_NOTHING;
-	dpp->wdev_id = netdev_get_wdev_id(netdev);
+	dpp->wdev_id = wdev_id;
 	dpp->curve = l_ecc_curve_from_ike_group(19);
 	dpp->key_len = l_ecc_curve_get_scalar_bytes(dpp->curve);
 	dpp->nonce_len = dpp_nonce_len_from_key_len(dpp->key_len);
+	dpp->max_roc = wiphy_get_max_roc_duration(wiphy_find_by_wdev(wdev_id));
 	dpp->mcast_support = wiphy_has_ext_feature(
 				wiphy_find_by_wdev(dpp->wdev_id),
 				NL80211_EXT_FEATURE_MULTICAST_REGISTRATIONS);
@@ -2464,19 +2467,13 @@ static uint32_t *dpp_add_default_channels(struct dpp_sm *dpp, size_t *len_out)
 static void dpp_start_presence(struct dpp_sm *dpp, uint32_t *limit_freqs,
 					size_t limit_len)
 {
-	uint32_t max_roc = wiphy_get_max_roc_duration(
-					wiphy_find_by_wdev(dpp->wdev_id));
-
-	if (2000 < max_roc)
-		max_roc = 2000;
-
 	if (limit_freqs) {
 		dpp->freqs = l_memdup(limit_freqs, sizeof(uint32_t) * limit_len);
 		dpp->freqs_len = limit_len;
 	} else
 		dpp->freqs = dpp_add_default_channels(dpp, &dpp->freqs_len);
 
-	dpp->dwell = max_roc;
+	dpp->dwell = (dpp->max_roc < 2000) ? dpp->max_roc : 2000;
 	dpp->freqs_idx = 0;
 	dpp->current_freq = dpp->freqs[0];
 
-- 
2.25.1

