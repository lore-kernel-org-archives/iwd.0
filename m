Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F20F75809
	for <iwd@lists.linux.dev>; Wed, 23 Oct 2024 17:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704190; cv=none; b=Z0z54Fez4ENgIBd8N1FkRzRWM5bUwlqipeDRY9z4xu0C8rGJ7kRRlzWz6OwJkFX8t3PzX3WOdIxaLmiXQxyV029k5IDOSAdYr3J6T7Lc69axAbgKIlM9U92jcqwhkXJqh8fw/BHft7i+atevSUVoheyEMjrcny6PVLbB+eeUK0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704190; c=relaxed/simple;
	bh=Et6idfdvQ6toD2ed8vrwN4sya/GuqyrnOmrL2ZaeoL4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gpnRAR3zyIF1+epOF71gO2Flz/fHIVvj3T76uWgEG0XXLdLxGh5LALk1+J3dqoARxm3rWkIz0gnS2iuhvR5UxVzCx1OPExrpmD/KDzzIQI8LcvLanhueScQTX5ufRqg5QtHdHeder8BazYFO51i388sJ1stXTx7ZfY/InMpToQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPZo4jh7; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPZo4jh7"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7db908c9c83so6506a12.2
        for <iwd@lists.linux.dev>; Wed, 23 Oct 2024 10:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729704188; x=1730308988; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yyipGZ74nB5NE2vzUBO8Q2hyzO0Dn/o9V44gLe7YzDw=;
        b=ZPZo4jh7D35CQYQb7TVAQPDVqevjANC/ABKOsX9Tt/t9VTtuXbWMeqHHA+e/5lLRIS
         UdjYmpHG1Gg07HJa17Xi6VMU5uwqfye1ilZ8zy1t7kVDBu4wBZEj907r740ixoZJLO9q
         Me42y7KzGAkF0OG8ihGF7w2WZhJ3adHIlGzrwuuBA3PRAo/CzzfFyHcgCgcxMymv55+e
         Ku68J52Oj3OPam9+6WE9MehzvNAJRDKQSF390cA0tdfzopWr40YhRXhP6hkG3R+d6pLw
         Hg4uP7e1GUxBmfwTb8g0stQM7mJFjDUOh1GsFcKZ4xDpA7h9mYMcigCzghH7ogsOn8+T
         dLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729704188; x=1730308988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yyipGZ74nB5NE2vzUBO8Q2hyzO0Dn/o9V44gLe7YzDw=;
        b=soF37oDVZ+SxwWGYM5fn0ij4wP1r1o90gjEVf+DN5BN4fCxFJqd0+AXvwGUaEo19Vk
         bO+oB3PYLfzyLqoSNRd12uZIQaFZCwLGlZGyoekUrgZUM+qZMySPx43CeLdsL0htnU/8
         Sjt0dpg2RPV+EaiQTwzWIVcXqU/Dd8WOCYhpbkE0vxoEen1rMpEsZxvyDlNvAh3HNSN9
         iDk5qfNI3BHQBuoE8T9GqOkyu7UCUAbohOZH7cFNWhVhO5TV095wLOAjnwzapnoLLVoq
         DD5+7oozEXjrvaFAJNca5Cr2eWAhteZ711iXbKRHRKm9ZNpqn/PRXMRBVNXn6U2kO3fa
         fEqw==
X-Gm-Message-State: AOJu0YzZct3ysyD5tER0bShBq5RDkU/sw8mjSIRcDT/efJ6zOvnuZIB6
	7LaUCtYTiqj8GQsr7gYaEjjBlATHgp8m7UWh+Bg0q2vWDxs6YRwwZm2prYiD
X-Google-Smtp-Source: AGHT+IHH8FgCcutzNLjuGGnakTWFtPx+0QI/w7sFgrZt0tcq4iahaVCnvwOhaZ5wvZy/S6mkW+UtRA==
X-Received: by 2002:a05:6a00:b48:b0:71e:1b6d:5a94 with SMTP id d2e1a72fcca58-72030b63117mr4416260b3a.5.1729704188345;
        Wed, 23 Oct 2024 10:23:08 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1407ed7sm6551923b3a.214.2024.10.23.10.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 10:23:07 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] wiphy: add OweDisable driver quirk
Date: Wed, 23 Oct 2024 10:22:54 -0700
Message-Id: <20241023172257.112771-1-prestwoj@gmail.com>
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

