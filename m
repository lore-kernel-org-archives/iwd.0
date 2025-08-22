Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C348F7D
	for <iwd@lists.linux.dev>; Fri, 22 Aug 2025 19:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892286; cv=none; b=uNH0mVd0/WEZROD3su0kFfJJfuB4YZDttFUkJiqOkDi1bVTSwdNV+L7g+sf+9woHKo2uQeb9mujepMkyKDEPwsyV2pGNH8t9eT4+I7YcwkxE4cy3AtrvbjTuLdq8m36Qb8Py9vrhFhZn8E47TuExd3RtOBX7RigD3oScThR5YLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892286; c=relaxed/simple;
	bh=VW7fFTrUwSHKn8l8z6LnoD7sgr3QBsPPrILqdX+KHEw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sk3asO/frS0EyZ7qHYeCh4KYTaUNeHEMv9i3AHdWMtMPCLPRNEts4jl8trNkcv1ePT0pqCAxcs/bYxfWguOkyJIkzox8qubTL2/9zoA5dHETZLlNGqylM7JPI3FnNDKwecIPsowjrHjkLPGFqpuN2svLplrRbcOCLpQcETW2Bh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wl7Gy3jr; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wl7Gy3jr"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b1098f9e9eso37029831cf.0
        for <iwd@lists.linux.dev>; Fri, 22 Aug 2025 12:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755892284; x=1756497084; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p+ewRJy0huCgKqJ8wJH8W0YxPlOZmCMzdNyDGxm7NR8=;
        b=Wl7Gy3jr/Y3jW/RsQWB6dS80hL+I11VbIgsICX4JY8u/YcR5qJdUVlFdd2abnqAtqV
         duMAMzjVFtBdSaNBcFpAfoFkOGdisLKkvtoiTsmU+BBhOrsn+ZcGpQcIlyT4XnlJ9b3Y
         rPzYlzQPiaMuIZjUsD2nrwZuz0sDi8Eb8tJYd7xAD+1oLSKGnVYt26om+xfPWl0rzOTs
         bZJkqrgHvxR6GasxboIs5M8GwWctKyl0B1FtSvxRSx/sBBmbUukXuSaN3MoHBHxsMIHI
         0mXi+unjlaZ9wiTTZEoCQ0eG+U+lLTgcrSnogEXJGe+L2+DwtCSsroa8EJGzWGUFD2cR
         GTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755892284; x=1756497084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+ewRJy0huCgKqJ8wJH8W0YxPlOZmCMzdNyDGxm7NR8=;
        b=WmP62snOWhifGumcTAiaJDLZG9N363f38cM4SlVe3rR/CNGvPeK7IOtAnD4xu1PmKW
         LspVHqgR6LAW+F2itRvCUqtoF/2sU+6ril9uWWxpTCaKDV6Qr2RtLi5X4iFAtUtBJ6mK
         wYhaOHjC3PtGbK6GzATpaXNRkWJOiB5HdXuXV0Wm8GTAphRKXRSfLuhPPDHlZCnKV8zX
         THKpJH9+brDVX9FOJS9KKn3uhzi81cIR5AxXnF4P030Kkq1p6JDerpcCdKUJ+1NQEA1t
         g1x0jkAe3Kq2b5uzBxiLch9lAZZQT+uQpwtJubKpnUFSGKeQp39nrontZCI8gBCkfxoh
         LhRg==
X-Gm-Message-State: AOJu0YwtuEGoMxOHH5O0N72i2pFJJtUXDSN4N8h0OF7uXurjGFULjniH
	+N6+2LVvZvjdZV3cIvVmauTQsIZbeFFpPYUALHCSnL1r/LBR3ylGAbr6TjnRFQ==
X-Gm-Gg: ASbGncvRbREM5yzG2aUu43PehBbXOezxHXTNYQ0pTxrz+2XWmGqgcNwDjIPcmcTbwns
	Dko8skJqGHo/4IR59oel8K8i8b3O0tJBR99G3eyidqjp0EI1W+ngBhflGjxp20AXeWhI/g6VX69
	0oPmImRD59jwdXZYH9xmEcENn4nhi6rBYcjlIr0OgDm6v0W80HaYftb/hvXsteMUTUfG/Ud3jTa
	2RoOyCCRSfkLusA/C5j1hFR9RJh3hbRG2uHOpW543hjszgF5lcyTCmFi5KkP2BgkSl31Hf61mkM
	+15SZn5EPTZgFkgfIE7gMDn6/xhdexdsBbqN9tl56w+F+/DZTQb9DwZ3bNKOUU4qCXgFmWx86fo
	lA6VpXic65od0P9VE4cNqVrQvwRLUqPmF
X-Google-Smtp-Source: AGHT+IHzomhYImD2vJD7qk57Gr3GkwDGBx1uKgJNvj6R3VjaCAwogFEO52/Fe9LHdPKxgqwYpOC8ew==
X-Received: by 2002:a05:622a:1993:b0:4b0:8057:1de9 with SMTP id d75a77b69052e-4b2aaa19f21mr51027041cf.3.1755892283827;
        Fri, 22 Aug 2025 12:51:23 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8e45c4asm4913221cf.46.2025.08.22.12.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 12:51:23 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 01/15] wiphy: add driver quirk for the colocated scan flag
Date: Fri, 22 Aug 2025 12:51:04 -0700
Message-Id: <20250822195118.271122-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some drivers do not handle the colocated scan flag very well and this
results in BSS's not being seen in scans. This of course results in
very poor behavior.

This has been seen on ath11k specifically but after some
conversations [1] on the linux-wireless mailing list others have
reported issues with iwlwifi acting similarly. Since there are many
hardware variants that use both ath11k and iwlwifi this new quirk
isn't being forced to those drivers, but let users configure IWD to
disable the flag if needed.

[1] https://lore.kernel.org/linux-wireless/d1e75a08-047d-7947-d51a-2e486efead77@candelatech.com/
---
 src/wiphy.c | 23 +++++++++++++++++------
 src/wiphy.h |  1 +
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index fb544fe6..c7f2805e 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -75,6 +75,8 @@ enum driver_flag {
 	OWE_DISABLE = 0x8,
 	MULTICAST_RX_DISABLE = 0x10,
 	SAE_DISABLE = 0x20,
+	/* Disables use of the NL80211_SCAN_FLAG_COLOCATED_6GHZ flag in scans */
+	COLOCATED_SCAN_DISABLE = 0x40,
 };
 
 struct driver_flag_name {
@@ -103,12 +105,13 @@ static const struct driver_info driver_infos[] = {
 };
 
 static const struct driver_flag_name driver_flag_names[] = {
-	{ "DefaultInterface",   DEFAULT_IF },
-	{ "ForcePae",           FORCE_PAE },
-	{ "PowerSaveDisable",   POWER_SAVE_DISABLE },
-	{ "OweDisable",         OWE_DISABLE },
-	{ "MulticastRxDisable", MULTICAST_RX_DISABLE },
-	{ "SaeDisable",         SAE_DISABLE },
+	{ "DefaultInterface",     DEFAULT_IF },
+	{ "ForcePae",             FORCE_PAE },
+	{ "PowerSaveDisable",     POWER_SAVE_DISABLE },
+	{ "OweDisable",           OWE_DISABLE },
+	{ "MulticastRxDisable",   MULTICAST_RX_DISABLE },
+	{ "SaeDisable",           SAE_DISABLE },
+	{ "ColocatedScanDisable", COLOCATED_SCAN_DISABLE },
 };
 
 struct wiphy {
@@ -963,6 +966,11 @@ bool wiphy_supports_multicast_rx(const struct wiphy *wiphy)
 				!(wiphy->driver_flags & MULTICAST_RX_DISABLE);
 }
 
+bool wiphy_supports_colocated_flag(const struct wiphy *wiphy)
+{
+	return !(wiphy->driver_flags & COLOCATED_SCAN_DISABLE);
+}
+
 const uint8_t *wiphy_get_ht_capabilities(const struct wiphy *wiphy,
 						enum band_freq band,
 						size_t *size)
@@ -1382,6 +1390,9 @@ static void wiphy_print_basic_info(struct wiphy *wiphy)
 		if (wiphy->driver_flags & SAE_DISABLE)
 			flags = l_strv_append(flags, "SaeDisable");
 
+		if (wiphy->driver_flags & COLOCATED_SCAN_DISABLE)
+			flags = l_strv_append(flags, "ColocatedScanDisable");
+
 		joined = l_strjoinv(flags, ' ');
 
 		l_info("\tDriver Flags: %s", joined);
diff --git a/src/wiphy.h b/src/wiphy.h
index 9fcbdcd2..19d79405 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -144,6 +144,7 @@ bool wiphy_country_is_unknown(struct wiphy *wiphy);
 bool wiphy_supports_uapsd(const struct wiphy *wiphy);
 bool wiphy_supports_cmd_offchannel(const struct wiphy *wiphy);
 bool wiphy_supports_multicast_rx(const struct wiphy *wiphy);
+bool wiphy_supports_colocated_flag(const struct wiphy *wiphy);
 
 const uint8_t *wiphy_get_ht_capabilities(const struct wiphy *wiphy,
 						enum band_freq band,
-- 
2.34.1

