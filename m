Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8C425E836
	for <iwd@lists.linux.dev>; Mon, 24 Mar 2025 14:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825765; cv=none; b=qKA0/2uiRtUeW/c+BTSryen17Gg8SM3hUjKBKV9QkFm0kyXNNKUaF1KET4BCT4udNUaSXD1Ypjz1WfOJgDWTXEGVV86Aey+gu0Ov5xJ1RQQF/eT0TEkBx7AAYH0aY4Bin+hkPfYq2hGmRR+riWsRHAU5FxbLyPd8B19uzUiHjmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825765; c=relaxed/simple;
	bh=869DHHQqfD2nkyQmB1tmUVDGroKlr24OrrMxBhHhonU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AmZAOcmPFhb8SKPi1pATS8A/G2hbJzwzsPYM13OHjv6JZiVZav7NPkq4QaZ26uyzLSRwy9+Oc3bT/7tRInmidp9NikqBg0PfoDFlCQ+DMGkXRnaoPCiw/V3TpTDvn3GlurWGrac+g7O7kZcLAc6aRh0AKDkHLI7LI80hNkEuj8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVWyu51d; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVWyu51d"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22435603572so77929925ad.1
        for <iwd@lists.linux.dev>; Mon, 24 Mar 2025 07:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742825763; x=1743430563; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZ0JpN0iAS7vJdUhi58QEjPHhM60DdhDjank2X+cKUI=;
        b=kVWyu51dpLHUqCl0XxMRFtFdLxhmtLQbnxl+L2J4cIK7KwT/8x5VW8sedqgiPP8SOA
         yT9S31UVsrdzSVUIUWmnlrOQhY0uKthkTR/sJQb8StFSQEj5IDsW9Had1ziK0f9HMe7F
         e6hVjcLnVs7mfZBRPGQr1FC81rgyjZLd9gud6bJFbQnPrbammq+iPk8eOhqA7UXI+KbG
         9cYcjKPycquLxRyZFjPReIeT2s57zza+V70yddwo8i0Gyj5liWIVMda2yLCh63h3l7Jh
         iNKvSIdiLil+eXSPhR46ja9gnZkEfoL9cbPtTXvipHa4mdSmBckdwzRhnFIJNSkm1x0G
         yMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742825763; x=1743430563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZ0JpN0iAS7vJdUhi58QEjPHhM60DdhDjank2X+cKUI=;
        b=ihaZpfd4iV0HX47XfhZOwyoHAza5X53zWD5oi3Yoldc9m9KfseBh8Z0W4RTKNMhOVe
         kEgu+T68UE0jwO5zRk3lOIFcC++kh4H22u6fzMpWf9qH02jzkVivG8F3dJP0m4j0+xsB
         wJtviqWTBgZjQsrEfuJQSK4Y2k7cr2035rEUig4fjLDiUHcNyGqFoSp+rtxTzcZFNz0V
         AfEw4gDlhMfTZuDn10563gOkwcJ6EWsp0S+Lm7K4xFCvR0NqpY+TxOGMIY5RXPOk9dj9
         TKDQj+Our5OHOW1NwaXKAk6QsUZTAurCkGmcwjINw24U22Y4hrJEA8WeqKn1btv0OYmz
         pRzg==
X-Gm-Message-State: AOJu0YyYQ294r3BLBojBpWbh8Y670bmL4a7MUvyjORckCBjssPBD/Osw
	sXZ3PigRSwsaZO1tmgfRBtyu0lHcXbn5PSjW/AkIKHntA9qRbawm3ZqNAg==
X-Gm-Gg: ASbGncttLsFmh9UGH/2saUx/hSrN1e+VU7BHz1ImHxOIAZFmWD/hG/d5uLW7KUq5Pl1
	ZIX12mt10xLxzdWUH/6oSjxvnxzX+4HUj+z6CFDZNMhvNv3Ehn7CjQo9wgE4kHnGgcJQn/yQDMP
	P8plN0ISIMhezvZlJ5FPgxXbyS0gl81MAyTcj0L+SJ39cHqorb/q/bYdGkNU8cKtzBkxQSo3q0S
	k4OJnfHv6OJY5Y3fLBKwqYYPrIVajfrWkD/u85HmKLgAOutxCbzJiGYH3+E0LTLPQd6+ZKDofvr
	CYLEg4nyf0cIA2PdoFVIuUjXhTdvDd4lZ5OQbgrhZfqBIRZ0l6N2oSECjGpZCgHLTg==
X-Google-Smtp-Source: AGHT+IFxKgeff8rgUQnyFvM5Nru/QiGaJN+Y8mtGdzJg8k0r1RqXhcGHIfODZwtyHKTTPeftJLZLYw==
X-Received: by 2002:a17:902:fc4f:b0:224:256e:5e4e with SMTP id d9443c01a7336-22780c7b695mr208612215ad.16.1742825762704;
        Mon, 24 Mar 2025 07:16:02 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd54efsm8007868b3a.37.2025.03.24.07.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 07:16:02 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 07/13] blacklist: add new blacklist reason, ROAM_REQUESTED
Date: Mon, 24 Mar 2025 07:15:32 -0700
Message-Id: <20250324141538.144578-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324141538.144578-1-prestwoj@gmail.com>
References: <20250324141538.144578-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a new blacklist reason as well as an option to configure
the timeout. This blacklist reason will be used in cases where a
BSS has requested IWD roam elsewhere. At that time a new blacklist
entry will be added which will be used along with some other criteria
to determine if IWD should connect/roam to that BSS again.
---
 src/blacklist.c | 16 ++++++++++++++++
 src/blacklist.h |  7 +++++++
 2 files changed, 23 insertions(+)

diff --git a/src/blacklist.c b/src/blacklist.c
index 17122840..e306195b 100644
--- a/src/blacklist.c
+++ b/src/blacklist.c
@@ -45,6 +45,7 @@
 
 static uint64_t blacklist_multiplier;
 static uint64_t blacklist_initial_timeout;
+static uint64_t blacklist_roam_initial_timeout;
 static uint64_t blacklist_max_timeout;
 
 struct blacklist_entry {
@@ -86,6 +87,13 @@ static struct blacklist_entry *blacklist_entry_new(const uint8_t *addr,
 		added = 0;
 		expires = 0;
 		break;
+	case BLACKLIST_REASON_ROAM_REQUESTED:
+		if (!blacklist_roam_initial_timeout)
+			return NULL;
+
+		added = l_time_now();
+		expires = l_time_offset(added, blacklist_roam_initial_timeout);
+		break;
 	default:
 		l_warn("Unhandled blacklist reason: %u", reason);
 		return NULL;
@@ -211,6 +219,14 @@ static int blacklist_init(void)
 	/* For easier user configuration the timeout values are in seconds */
 	blacklist_initial_timeout *= L_USEC_PER_SEC;
 
+	if (!l_settings_get_uint64(config, "Blacklist",
+					"InitialRoamRequestedTimeout",
+					&blacklist_roam_initial_timeout))
+		blacklist_roam_initial_timeout = BLACKLIST_DEFAULT_TIMEOUT;
+
+	/* For easier user configuration the timeout values are in seconds */
+	blacklist_roam_initial_timeout *= L_USEC_PER_SEC;
+
 	if (!l_settings_get_uint64(config, "Blacklist",
 					"Multiplier",
 					&blacklist_multiplier))
diff --git a/src/blacklist.h b/src/blacklist.h
index dc7891d1..8de5c1d7 100644
--- a/src/blacklist.h
+++ b/src/blacklist.h
@@ -38,6 +38,13 @@ enum blacklist_reason {
 	 * cleared.
 	 */
 	BLACKLIST_REASON_TRANSIENT_ERROR,
+	/*
+	 * This type of blacklist is added when a BSS requests IWD roams
+	 * elsewhere. This is to aid in preventing IWD from roaming/connecting
+	 * back to that BSS in the future unless there are no other "good"
+	 * candidates to connect to.
+	 */
+	BLACKLIST_REASON_ROAM_REQUESTED,
 };
 
 void blacklist_add_bss(const uint8_t *addr, enum blacklist_reason reason);
-- 
2.34.1

