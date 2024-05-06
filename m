Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA364B673
	for <iwd@lists.linux.dev>; Mon,  6 May 2024 00:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714956626; cv=none; b=NL/yIjoUv+S6DCpnYXd8t/SWri/vYqyBScehUIcwS/g6swJBBlrbx/vBwveqSF3tfh7LSyHmdDWDECWiNxspJmZEJg6dHMYOltbPTtgcxWsC5FIjGO1bbkEdL6/yp6ACgIzDwIwNKuwPIXuPCRsbP2F76eXu9tpslHksRptsEa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714956626; c=relaxed/simple;
	bh=kbyJhhrxU4mE6ZZc0Mx9u/14LBLLLW915QVOrVc3t5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRjmkhiduGpIgPe8PXErI+29PmxAHDq8Mb4oXvHbVD9tsV3e3CXvV1z4poOVqb4S537p45YtbDUDuI0yV1Q9b/svPVg8Hx0H2tqD7Z9+NI2FTO+eJmvI37GhJYoBXt7jYqjuqur3G8TebmweOL4JzExERxO2wGbVc9BDxCV9rWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zd3jLt6b; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zd3jLt6b"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c96c1e27a3so294362b6e.2
        for <iwd@lists.linux.dev>; Sun, 05 May 2024 17:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714956624; x=1715561424; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTXjM9WUFKL8XGPzF+cuiI2OWaB05tCHhnayPlf4miY=;
        b=Zd3jLt6bOnZ2T6BeGqGVq5g/mlV+9oInwl8ibTAi/Rn5P5u4ZQI8ezq7umwtlxUvRE
         l+aqOMV+dwLFn64MqkfOxTkdcB1uf4jzhe6mkdYSSfHgD1DFPob18nerlL1b1e0QrnI8
         5K49H2Ugt2REOV2YIWfcFp+rlsz42QDCkcXOt+lhTjH4T7YH7C8ywNoASmkrEGKxMw3X
         Xd76dFAiYrqiBzHZziqHoG10l2eB34waEgCO53aq/D+1DlEl9PLoB9Upa5A7ojO0n3a1
         XV8SOOU/37utXg0/8wysjGvWKHF18+OK13Tbzsea0iHo34LBJS140e73xAbuhiy30gfe
         lzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714956624; x=1715561424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTXjM9WUFKL8XGPzF+cuiI2OWaB05tCHhnayPlf4miY=;
        b=DBY5lz8So4xNWwT8vuAySXGZ2AVJhpqpQYDe5zs0QYedKJx8nhy+0j8zog0aUCwUkO
         ypzDAbM6F/q6Kq6QevVBwTM7sOQ125/qT/hoTlFfelXBzlUfcQuPt63cVZKVXh3Lq01S
         qLYmnUhxkQp06Jkhx2Sfu4hDWU9j2wwdToMqMDNjcsck3qmUKw7zUJltnI5O+naVwjmz
         xuI3Kbooy1gn5oT18Cr3g4XHumMCTaTJTpyfJVqQmUhEQlLR2R46kt3q5DE5tHc6HNlF
         cBnKQVd4GOneA5Pto+qGoEMSAF3HxAAXiGzQmvKtQCPRVD5RSg3hAwwUf1+DxwRduU3V
         seIw==
X-Gm-Message-State: AOJu0Yw0aHlW5TMk18afiU4z7Z7k32LbBETN+9dxbBZjGeDPLGGyAuhK
	zkvPVbH1vAl5nBsHaOOf9ROcYMGKlMe/xsVbKYyJJNb3nHSqqIBLIAsG4Q==
X-Google-Smtp-Source: AGHT+IGUwihI8HdaHutT8LexIfVN0NzBv/NrfWiUJu2Ha6bQ6e89qt81djlCl9gPkB15zcr7/9l7nw==
X-Received: by 2002:a05:6808:300e:b0:3c7:513b:4298 with SMTP id ay14-20020a056808300e00b003c7513b4298mr12693957oib.54.1714956623754;
        Sun, 05 May 2024 17:50:23 -0700 (PDT)
Received: from localhost ([192.145.118.41])
        by smtp.gmail.com with ESMTPSA id u9-20020a056a00098900b006f3ef4e7551sm2516945pfg.217.2024.05.05.17.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 17:50:23 -0700 (PDT)
From: John Brandt <brandtwjohn@gmail.com>
To: iwd@lists.linux.dev
Cc: John Brandt <brandtwjohn@gmail.com>
Subject: [PATCH v2 14/18] ap: move toward requiring MFP when using SAE
Date: Sun,  5 May 2024 17:30:37 -0700
Message-ID: <20240506003518.320176-15-brandtwjohn@gmail.com>
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

When wanting to use SAE, confirm that MFP is also supported, and
automatically enable MFP. Advertise as MFP capable in the beacon.
---
 src/ap.c    | 13 +++++++++++--
 src/wiphy.c |  2 +-
 src/wiphy.h |  2 ++
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index ae406e16..8cebef42 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -82,6 +82,7 @@ struct ap_state {
 
 	unsigned int ciphers;
 	enum ie_rsn_cipher_suite group_cipher;
+	enum ie_rsn_cipher_suite group_management_cipher;
 	unsigned int akm_suites;
 	uint32_t beacon_interval;
 	struct l_uintset *rates;
@@ -93,6 +94,7 @@ struct ap_state {
 	struct l_timeout *wsc_pbc_timeout;
 	uint16_t wsc_dpid;
 	uint8_t wsc_uuid_r[16];
+	bool mfpc;
 
 	uint16_t last_aid;
 	struct l_queue *sta_states;
@@ -639,6 +641,9 @@ static void ap_set_rsn_info(struct ap_state *ap, struct ie_rsn_info *rsn)
 	rsn->akm_suites = ap->akm_suites;
 	rsn->pairwise_ciphers = ap->ciphers;
 	rsn->group_cipher = ap->group_cipher;
+
+	rsn->group_management_cipher = ap->group_management_cipher;
+	rsn->mfpc = ap->mfpc;
 }
 
 static void ap_wsc_exit_pbc(struct ap_state *ap)
@@ -3916,9 +3921,13 @@ static int ap_load_config(struct ap_state *ap, const struct l_settings *config,
 	for (i = 0; akms_str && akms_str[i]; i++) {
 		if (!strcmp(akms_str[i], "PSK"))
 			ap->akm_suites |= IE_RSN_AKM_SUITE_PSK;
-		else if (!strcmp(akms_str[i], "SAE"))
+		else if (!strcmp(akms_str[i], "SAE")) {
+			if (!wiphy_can_connect_sae(wiphy))
+				return -ENOTSUP;
 			ap->akm_suites |= IE_RSN_AKM_SUITE_SAE_SHA256;
-		else {
+			ap->group_management_cipher = IE_RSN_CIPHER_SUITE_BIP_CMAC;
+			ap->mfpc = true;
+		} else {
 			l_warn("Unsupported or unknown AKM suite %s",
 					akms_str[i]);
 			return -ENOTSUP;
diff --git a/src/wiphy.c b/src/wiphy.c
index fb36ebb2..fb30e7a6 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -195,7 +195,7 @@ uint16_t wiphy_get_supported_ciphers(struct wiphy *wiphy, uint16_t mask)
 	return wiphy->supported_ciphers & mask;
 }
 
-static bool wiphy_can_connect_sae(struct wiphy *wiphy)
+bool wiphy_can_connect_sae(struct wiphy *wiphy)
 {
 	/*
 	 * WPA3 Specification version 3, Section 2.2:
diff --git a/src/wiphy.h b/src/wiphy.h
index bc82a007..9472b253 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -72,6 +72,8 @@ enum ie_rsn_cipher_suite wiphy_select_cipher(struct wiphy *wiphy,
 							uint16_t mask);
 uint16_t wiphy_get_supported_ciphers(struct wiphy *wiphy, uint16_t mask);
 
+bool wiphy_can_connect_sae(struct wiphy *wiphy);
+
 enum ie_rsn_akm_suite wiphy_select_akm(struct wiphy *wiphy,
 					const struct scan_bss *bss,
 					enum security security,
-- 
2.45.0

