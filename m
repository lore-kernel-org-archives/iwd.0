Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33340128384
	for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 20:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707944173; cv=none; b=idg965OlqMNMlA4rprn/zUtpKhMQ8PHaSMpNZ/sEVXPC560tBPpDBdWRs2gCijjPbd2+in92hcFPGiMDpLy/rct9fYWg8b6ziZIwtzNoK4s1zCKU1/El/b0TJj4wmCwLpeYj++0JmgmsFL1rWMJl/LhrPOJDisRKy+FYXadKEm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707944173; c=relaxed/simple;
	bh=gmyoDbbM6QSLpkwwjrwo0oNDjqAGIxeCMkb+jXZiyzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GSXNrsKCde6Bi0qSTpIJA2uTVopHs6R2VTwa6mCWp1aaW88C56VOmzmSPLfCbbkUDqSLDQV/bEf+PE/VkeFqOazqy5F33cNJjp+TSpKz6bsmI2asWAIDIwtF+8ZBedvXiZNwOmvuUYZ1Jp8pPd9KKYaOGumc5/Ez/g9DL+KkJzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLg/hmG3; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLg/hmG3"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c0a36077a5so165869b6e.0
        for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 12:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707944171; x=1708548971; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EwGnkI89/xSmfAYPeN+TwjYQTyHXnZIbTd9oXlxRhzk=;
        b=cLg/hmG3aVgLii9krPQ36oaQx/Nuwl516tXgmfOxTcEvQFA2sJIPIbcGbUY6s9U5e4
         eACXZ+z3mYJEykFMosvKCU3o6dYWevTg1IN8Ct1ZLJFTQzv4uqFe1Mr2oiMaZpojYBUN
         PuMZ0ayVjmHui153Hkxp7E0+3s+qB9zedM+abStVxXNYAnd9Enn0poq5qEWPmx6wIrll
         sppxOCeIdyV1/lHyRvjcxOMoKHCYV1HLgqOqq6kdfqNgnFfHe6IigU2cEq0Z+nkAV2pB
         zI6GKeAM8dccreqN1F3WvrD9gg25Iyc9nOI+sHcaJdMsfen9yav6Jqfmn+wYxRrxuE2q
         DcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707944171; x=1708548971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EwGnkI89/xSmfAYPeN+TwjYQTyHXnZIbTd9oXlxRhzk=;
        b=OyFyRzYmG3lVPdIVsoS3RyLQdp/bCRvpsPcquyM26XVRP6WNQHMmxdk3rTWaO+V1Gl
         nfRVnu2Fl7JH2WD9NyWYxSlYfLB9DsiQN0NOG5G0j3JPPGO3q4VBr1rWefhcrRa/YcA/
         I8zvfO/D6ZllEHY74FrblGe4RrqjgSxgyIi29eTkrjm2Wq4R7YqPL7n3ufxig9epEnpb
         bzjhxmDPGuuJP0Z7zykQlLS4DN7WxN/8ZE8gfwe1mTRdY2UB8/ZJcbvbPLdgtAdQcijI
         YIs2jJV+1K13Xs57frgOlpP2AC/qTpVazuo6D3gI+1BxiR0Sbnf8QAGfhcBNRLlGojRq
         QqUw==
X-Gm-Message-State: AOJu0YwXG4lphaAidDV75vSOzt+6G99DcuCmpua9KXuLNwURRBOM57Ci
	avi4l2GGVefjD/okHCkyiqtLdfw32jO88cbsTEA4RGow1hcorH/UatshpyE6
X-Google-Smtp-Source: AGHT+IEW3PxswYLH6V5SmEsGS17RMGeZImAcU4ESGRZyEAtNG/YGKcLMcwCRtDxhiDr4PS1k21++Mw==
X-Received: by 2002:a05:6808:a8b:b0:3bf:f34f:ee0c with SMTP id q11-20020a0568080a8b00b003bff34fee0cmr3634997oij.29.1707944171129;
        Wed, 14 Feb 2024 12:56:11 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 22-20020aca0d16000000b003c04c0b510csm343831oin.4.2024.02.14.12.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 12:56:10 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH] wiphy: Remove basename() use
Date: Wed, 14 Feb 2024 14:55:13 -0600
Message-ID: <20240214205523.1109159-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

basename use is considered harmful.  There are two versions of
basename (see man 3 basename for details).  The more intuitive version,
which is currently being used inside wiphy.c, is not supported by musl
libc implementation.  Use of the libgen version is not preferred, so
drop use of basename entirely.  Since wiphy.c is the only call site of
basename() inside iwd, open code the required logic.
---
 src/wiphy.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 3258b761af15..0d64b1b31eb8 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -1896,6 +1896,7 @@ static bool wiphy_get_driver_name(struct wiphy *wiphy)
 	unsigned int j;
 	const struct l_settings *config = iwd_get_config();
 	char **flag_list;
+	char *driver;
 
 	driver_link = l_strdup_printf("/sys/class/ieee80211/%s/device/driver",
 					wiphy->name);
@@ -1907,7 +1908,9 @@ static bool wiphy_get_driver_name(struct wiphy *wiphy)
 	}
 
 	driver_path[len] = '\0';
-	wiphy->driver_str = l_strdup(basename(driver_path));
+
+	driver = memrchr(driver_path, '/', len);
+	wiphy->driver_str = l_strdup(driver ? driver + 1 : driver_path);
 
 	for (i = 0; i < L_ARRAY_SIZE(driver_infos); i++)
 		if (!fnmatch(driver_infos[i].prefix, wiphy->driver_str, 0))
-- 
2.43.0

