Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDE21CACE8
	for <iwd@lists.linux.dev>; Wed, 23 Oct 2024 18:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729708161; cv=none; b=mEisAXhJZ0uTBISHCOgHJRsi7uRzjnpsYrWml9cu36nWy+GiEEdjq3GlqbgEkMurJqPcW81ynT/+h857JGlr0FGyM4IL7krdJ143l3YQd/AiUeFsBePoUmRY1ih3NiHsFaQE3CqNSkAUnLoz3+OCHVEYB2EX8+yGvJ2y77b7JQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729708161; c=relaxed/simple;
	bh=Et6idfdvQ6toD2ed8vrwN4sya/GuqyrnOmrL2ZaeoL4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XGr6uOE5qzy4yuCq0QW9EPb2oPYnPFEHpgRBhu4Bm5NA4QwKoU7frEyql0KZ4y5CrzOQZR52EHr308ORie2oa0XjXl++hIzkTT96tfrJPrQalnf4AMv+kbLf291XRj17O114bQy1zVn1eJzIhiGj2o3xPlIQVXeedKReBAUb74c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMAx8ZZW; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMAx8ZZW"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ea8ecacf16so57517a12.1
        for <iwd@lists.linux.dev>; Wed, 23 Oct 2024 11:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729708159; x=1730312959; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yyipGZ74nB5NE2vzUBO8Q2hyzO0Dn/o9V44gLe7YzDw=;
        b=YMAx8ZZWt20R+9MktNcUhV8s+daF6bv2U6u/PLTdPPwo8+U1tYsDzigLfAi+C6aJ5P
         MVsacvIx8eU2nBuc38Txv7Y26631mcZA++CI8y7UWmRYDG2UARrYOYHTqCwuU/ur8Sgx
         tgp8J/EdalIWAALjV7PVWEKjGiayfW9ftldkHjQfzlNHUbC75P8ykjNjvz3b8xIfsUM6
         bq/yh3XXQutfnxbR0EyRa39kUSpnSpOgaZaKU+udch91L8Ih/NCWAmNPggu4x+2gidY9
         bm1Kkv+ZI6s1c2a76NtHLa0QcmUzKqElFfENFygDWrbTgx6mVtUZ5vBLPPvfgoBsSMXI
         JuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729708159; x=1730312959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yyipGZ74nB5NE2vzUBO8Q2hyzO0Dn/o9V44gLe7YzDw=;
        b=fefStl5Aw9ZN1NoNDbJivuytSVf5qZ4MLtyiZC0Bgiz39Je+6L5+7i8QJ8CmyjJ0LA
         IjHBkt3Zzw2DcFDnPkK6F/t2etuiGegz/W4w2vwI4f9ZX8q+b0nFufNBAmE0utued1Hf
         pLro0kNMXro13dXHePDijQ+NfFzN5zup2YCEhMutz5j8Pe6cGdKnMphCSeciOKJRpMlr
         WJHEUNzq+Fy9fANoTPvVEHiwbNws8RbF/X/ImlLsgqZkzA4g1YJ0f9ixpDtcVBnC6d2g
         S9p8hvj170lMCNdOudGqT0ABYz1RvAqRYlw85JI18u8M5wEN1nPblhC36bNM/nvMVQLd
         pyRQ==
X-Gm-Message-State: AOJu0YyI6rxv1amBPn8+KwocAyasAuGMuKFNvKvGabQl2LRgyD7fPVgb
	vQygiQG6bk5UtiUNmzdh2d5la6GpNQxq8yFLRpuQizgQe+AFB6VeH/RkoTZ2
X-Google-Smtp-Source: AGHT+IHAagNx5b+JSROXOYF2aNzT3zGxlo1EVoHW/Bbvh77GvFfHmqZmeGnVIiwmyZhU8TjWWuxbCw==
X-Received: by 2002:a05:6a21:170f:b0:1d0:7df2:cf39 with SMTP id adf61e73a8af0-1d978ad5892mr3911717637.7.1729708159265;
        Wed, 23 Oct 2024 11:29:19 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeabc11a7sm7024871a12.60.2024.10.23.11.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 11:29:18 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/4] wiphy: add OweDisable driver quirk
Date: Wed, 23 Oct 2024 11:29:09 -0700
Message-Id: <20241023182912.128388-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some drivers like brcmfmac don't support OWE but from userspace its
not possible to query this information. Rather than completely
blacklist brcmfmac we can allow the user to configure this and
disable OWE in IWD.
---
 src/wiphy.c | 16 +++++++++++++++-
 src/wiphy.h |  1 +
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index cc0e6dd7..d57d657a 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -72,6 +72,7 @@ enum driver_flag {
 	DEFAULT_IF = 0x1,
 	FORCE_PAE = 0x2,
 	POWER_SAVE_DISABLE = 0x4,
+	OWE_DISABLE = 0x8,
 };
 
 struct driver_flag_name {
@@ -103,6 +104,7 @@ static const struct driver_flag_name driver_flag_names[] = {
 	{ "DefaultInterface", DEFAULT_IF },
 	{ "ForcePae",         FORCE_PAE },
 	{ "PowerSaveDisable", POWER_SAVE_DISABLE },
+	{ "OweDisable",       OWE_DISABLE },
 };
 
 struct wiphy {
@@ -344,7 +346,8 @@ wpa2_personal:
 		if (info->akm_suites & IE_RSN_AKM_SUITE_PSK)
 			return IE_RSN_AKM_SUITE_PSK;
 	} else if (security == SECURITY_NONE) {
-		if (info->akm_suites & IE_RSN_AKM_SUITE_OWE)
+		if (info->akm_suites & IE_RSN_AKM_SUITE_OWE &&
+					!wiphy_owe_disabled(wiphy))
 			return IE_RSN_AKM_SUITE_OWE;
 	}
 
@@ -721,6 +724,14 @@ bool wiphy_power_save_disabled(struct wiphy *wiphy)
 	return false;
 }
 
+bool wiphy_owe_disabled(struct wiphy *wiphy)
+{
+	if (wiphy->driver_flags & OWE_DISABLE)
+		return true;
+
+	return false;
+}
+
 const uint8_t *wiphy_get_extended_capabilities(struct wiphy *wiphy,
 							uint32_t iftype)
 {
@@ -1355,6 +1366,9 @@ static void wiphy_print_basic_info(struct wiphy *wiphy)
 		if (wiphy->driver_flags & POWER_SAVE_DISABLE)
 			flags = l_strv_append(flags, "PowerSaveDisable");
 
+		if (wiphy->driver_flags & OWE_DISABLE)
+			flags = l_strv_append(flags, "OweDisable");
+
 		joined = l_strjoinv(flags, ' ');
 
 		l_info("\tDriver Flags: %s", joined);
diff --git a/src/wiphy.h b/src/wiphy.h
index fe7e9e49..a68e48c3 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -134,6 +134,7 @@ const char *wiphy_get_name(struct wiphy *wiphy);
 bool wiphy_uses_default_if(struct wiphy *wiphy);
 bool wiphy_control_port_enabled(struct wiphy *wiphy);
 bool wiphy_power_save_disabled(struct wiphy *wiphy);
+bool wiphy_owe_disabled(struct wiphy *wiphy);
 const uint8_t *wiphy_get_extended_capabilities(struct wiphy *wiphy,
 							uint32_t iftype);
 const uint8_t *wiphy_get_rm_enabled_capabilities(struct wiphy *wiphy);
-- 
2.34.1

