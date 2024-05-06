Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB3E28EB
	for <iwd@lists.linux.dev>; Mon,  6 May 2024 00:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714956342; cv=none; b=eXq6LKtuA67sARhmEVjRsVLZUlbegEwSLBSp8sU8xOG7Msmg29KiZ37GH3IoKfK2RLHL+fSvo86irbZAGqt49jSomghE3vL2V3xl6lGLM1PLx02HBMDiHiobBgvy8eXdO47KXytCnK71+6pZBOSNB/DE9XX+ZFMWrlwxbpWqACc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714956342; c=relaxed/simple;
	bh=jNR8IihZLKfjwMAygd1WFGDQjc/Ew7pAnL9n17hFtOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bi0iaetl7a/cEKZGeojzyTqwJUBw/cNamz/wO8MBOiMiCoEGYDyj5n/6JYLhB2p2sJ5Xpq7z2sOYrSDwqekxAP3YFiZiAXWvepwqZBKdtGcY5pplb+ZxVYya0xMnOmhrLVSMCpDEkQ0BpQINa+FkrJoc+clVR6OPN0JygHA9O9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdpCawoe; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdpCawoe"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso519297a12.3
        for <iwd@lists.linux.dev>; Sun, 05 May 2024 17:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714956340; x=1715561140; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nBnq88RAoXUrvOe2O0RRbR/QVucTgDmeKC1b5eQZp0=;
        b=KdpCawoehdyw9wUEA59iS0wSbLc7+KIAiJm+V4dZjD+ts/WEEYUnQxblYZDen+XOcN
         hKwD01I8e+E10JGsDAjwbLMzrJz56iVLpf2O5ZydoeJeWsQqh2riyV92PuS0CrOfYR3N
         Ux0LBu80PDaCSjgOTcWJFFWTktHvv+ayynxLgZVq9AuOHjlNatJxn2y2z55AX37eKf7w
         WDRd5J92tqoAzVRpqGxpGeFHvTK4hI4B3gaNlfUKDvoFHs6bGYZPGw88CLo4W3YKdsb7
         FdbflUAYbTKNg8u2pxy++2dlZ9S6Sa+galwu5wetB63vBnWowK1sfPisC2NU93b+42C0
         0ZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714956340; x=1715561140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nBnq88RAoXUrvOe2O0RRbR/QVucTgDmeKC1b5eQZp0=;
        b=dqDo4JO1kXaK6uZMptV50zpwz32vCerpllakEg9I0GQfY+GmQ81A/CHVUOEArsuJGL
         XBGWshoGXTFEGoPrflrrPnGI/gFgzRwzS47tqmObnMwMADOecu6GjuqqhcA0uRBzOucV
         gOlNWyfvNXIH65nunXzUg1Dp6XNprxny8KYQZSQzCHP3crCaXDZTpY+WezSl1a5+0TOZ
         gTbi7tGqX3VWzukEgUb2k/jurB9rhMbYpFAYMH/fGtP2WR6RWRPKrqdVsFV2qKu2S56o
         L1SVlreR+IVebdSCsWV2eFqzf++9XLVyEVPlYfvaqjxOKX+55wu8zv2PTRlMJm+ZcWhS
         R2BQ==
X-Gm-Message-State: AOJu0YzDWzhQmNMD9x95+LsDT9LfCdsUGnZ1ZC6orfCznyF0Qi3HjvEM
	u7j2QALgwr0EdKrUcO7mr3/vUGGqgBjPKS0cMsjdTPruxQ3g1SmI4zf5rg==
X-Google-Smtp-Source: AGHT+IHYz0VfcZbCahGk7+Y4M5NVKEa7GdW2EAy5ut73SylwV3pfSG43iX9qHRXWDN53XAuGgeQhGQ==
X-Received: by 2002:a17:90a:8185:b0:2b2:c73a:7acc with SMTP id e5-20020a17090a818500b002b2c73a7accmr6854497pjn.37.1714956340405;
        Sun, 05 May 2024 17:45:40 -0700 (PDT)
Received: from localhost ([192.145.118.41])
        by smtp.gmail.com with ESMTPSA id ta5-20020a17090b4ec500b002b2cada0c6fsm8792828pjb.26.2024.05.05.17.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 17:45:40 -0700 (PDT)
From: John Brandt <brandtwjohn@gmail.com>
To: iwd@lists.linux.dev
Cc: John Brandt <brandtwjohn@gmail.com>
Subject: [PATCH v2 01/18] ap: ability to advertise PSK and SAE
Date: Sun,  5 May 2024 17:30:24 -0700
Message-ID: <20240506003518.320176-2-brandtwjohn@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506003518.320176-1-brandtwjohn@gmail.com>
References: <20240506003518.320176-1-brandtwjohn@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the configuration option AKMSuites under Security so it becomes
possible to support both PSK and SAE. This influences the advertised
AKMs in the beacon.
---
 src/ap.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/src/ap.c b/src/ap.c
index b4e7593e..d50f9e4f 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -80,6 +80,7 @@ struct ap_state {
 
 	unsigned int ciphers;
 	enum ie_rsn_cipher_suite group_cipher;
+	unsigned int akm_suites;
 	uint32_t beacon_interval;
 	struct l_uintset *rates;
 	uint32_t start_stop_cmd_id;
@@ -631,7 +632,7 @@ static void ap_drop_rsna(struct sta_state *sta)
 static void ap_set_rsn_info(struct ap_state *ap, struct ie_rsn_info *rsn)
 {
 	memset(rsn, 0, sizeof(*rsn));
-	rsn->akm_suites = IE_RSN_AKM_SUITE_PSK;
+	rsn->akm_suites = ap->akm_suites;
 	rsn->pairwise_ciphers = ap->ciphers;
 	rsn->group_cipher = ap->group_cipher;
 }
@@ -3620,6 +3621,7 @@ static int ap_load_config(struct ap_state *ap, const struct l_settings *config,
 	size_t len;
 	L_AUTO_FREE_VAR(char *, strval) = NULL;
 	_auto_(l_strv_free) char **ciphers_str = NULL;
+	_auto_(l_strv_free) char **akms_str = NULL;
 	uint16_t cipher_mask;
 	int err;
 	int i;
@@ -3838,6 +3840,28 @@ static int ap_load_config(struct ap_state *ap, const struct l_settings *config,
 		ap->ciphers |= cipher;
 	}
 
+	akms_str = l_settings_get_string_list(config, "Security",
+						"AKMSuites", ',');
+	for (i = 0; akms_str && akms_str[i]; i++) {
+		if (!strcmp(akms_str[i], "PSK"))
+			ap->akm_suites |= IE_RSN_AKM_SUITE_PSK;
+		else if (!strcmp(akms_str[i], "SAE"))
+			ap->akm_suites |= IE_RSN_AKM_SUITE_SAE_SHA256;
+		else {
+			l_warn("Unsupported or unknown AKM suite %s",
+					akms_str[i]);
+			return -ENOTSUP;
+		}
+	}
+
+	if (ap->akm_suites == 0) {
+		/*
+		 * Default behavior if no AKMs are specified but a passphrase
+		 * is to only enable PSK == WPA2.
+		 */
+		 ap->akm_suites |= IE_RSN_AKM_SUITE_PSK;
+	}
+
 	if (!ap->ciphers) {
 		/*
 		 * Default behavior if no ciphers are specified, disable TKIP
-- 
2.45.0

