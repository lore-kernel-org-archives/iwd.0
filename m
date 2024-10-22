Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE4712F5B3
	for <iwd@lists.linux.dev>; Tue, 22 Oct 2024 19:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729624170; cv=none; b=u/AbnUXYr8Z62GhZAfzD0wANJmjNgi0UbtTX+Qb1s/ZyGwvuGZIdiIdvab5NdkDlV60hCCErw1OnT4m5MA37TzusNWaw0NIqNg/UCRbAIG+EVim3hN0bSP2I5Z9q6ofs1ioFUNIEF9jsh11CIafN7TIWBBjyUWKbdBaX5aGzQqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729624170; c=relaxed/simple;
	bh=k7hQsFIiPz5kFa7UOkMQG2YFK07kO6qA98e2/rl9tMk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jPg7WgOte60e+h3hJkuIGCBfKVUtcCtLBey13lhGZ26QlNhzAgIZRfVTnOBWQX572EyP8dHcb6r2Tsseeic2Juwx+H0memeOePTf3Ucnz4pPKBSWcJEATBC8VmOCjRrWKMsUBKGXcOxQ7Jnj8oV7hhTovxSrtGDfxwWCKlOBxpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ik1C5E20; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ik1C5E20"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43163667f0eso44577295e9.0
        for <iwd@lists.linux.dev>; Tue, 22 Oct 2024 12:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729624167; x=1730228967; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GbMU1UmrQ7as2VneU9/Yk+OqP0ZnxNDgwe4aY0Vhvg0=;
        b=ik1C5E20oABy0iVXDjZeKrQ6ShPhDpg9oawXqmvl8veuBkvyudM4VmAzI4EZ9DJDS7
         atwqH0X47ph8J46i3QMavBx01dJ6AosYtWEozBahmkpm4kw6j9ka/KxmMDj5KHLZ2pR1
         GXrckdSApCx56fS2id/yufwceI0f5AO/100SeZRDnqGimnHcJsgEBrrnwTAFaxOXDXT8
         cOIYbg2SLOiDs4C9bSLbhRKvVCx4WQr1gvb3ElGpcu1Cec0tV6Q9OQYyX+aVZneYBKhY
         wfYxawOKWxxk0nrB219gmsehZAWwQF2XSn5Wh2iexYg0eWn1zNc0JiEZawIQhCMzLxqP
         mCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729624167; x=1730228967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GbMU1UmrQ7as2VneU9/Yk+OqP0ZnxNDgwe4aY0Vhvg0=;
        b=awSWyT+F/X8LYC9ot21k4F2IyeJ4q+yLVngiAodkhUsraVq6xeMN7gLsiChnZ2tCxw
         kgBIRcAZn4W39fwMxMDOJCnDpemcIX1YM/Ml/2NIe10FBMwUcx3o1CRm2nXf6FFBEH1D
         Wy13grfgPAucUrPLA/PG1h8P/OxtsgmFV1EZ0dmXvcsKaNUSXe8rlOkOPUuuBNPgjL4I
         Eq3f8FcdjET9QtQ6c3lqX1M7pKstdoZF1R3s20nJUea2ACBJsfp2hhyYqZ3Q9E16s3n5
         Efh59saKytnhGeFRzXWdc/ZASJlBiIhuORKW+nDC1LTDG3dJ+fZ6DKYNB7sG0zC4IiBU
         XiWw==
X-Gm-Message-State: AOJu0Yz4tVDxp2wWTzXEA9YgPFk0KyC0wakShppHA2YA+N+kEtvqmwR9
	OhRwt0Ypfej98gyUptwiljSIZbulU/+Lqnan7AyQqECCVQalbq8tcclODTAf
X-Google-Smtp-Source: AGHT+IEswozwxEKhiis4bNk+SXBifuM598OS7QG+D7Z2oDeJw8/dcqvJXeUseZvw5UJigwcXySb0wQ==
X-Received: by 2002:a05:600c:46c8:b0:431:44fe:fd9a with SMTP id 5b1f17b1804b1-43184209b20mr1605265e9.19.1729624166407;
        Tue, 22 Oct 2024 12:09:26 -0700 (PDT)
Received: from LOCLAP699.localdomain ([81.145.46.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f50b15csm96032055e9.0.2024.10.22.12.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 12:09:25 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 1/2] wiphy: add OweDisable driver quirk
Date: Tue, 22 Oct 2024 12:09:18 -0700
Message-Id: <20241022190919.29005-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

