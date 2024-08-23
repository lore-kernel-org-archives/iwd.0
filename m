Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9016418DF62
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 18:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724436020; cv=none; b=uB51T1TQtLLtMkWFLjhe1RwvihOA67E1nk25sX1SKDWi/9AmGYwyg7bLMNIdWkbx45bRZXVAQSjWU4oqik+834I5ujujc4vY/lVqRtsw2STwNBiF2A0zoEgPGImZxU6dCiLyOy9V2RHpw0Si4mcwW/aV8mrQqvzXI2src+jRhsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724436020; c=relaxed/simple;
	bh=Wo/sCkXWEiaHPUveO577h9cB7OfoF/pXS46s7c2XYgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bWCSBjNmobaV6eSu/J2ZSPQd1ad+sQ3WjQrn0UG+HzRXYgyHLUpmOVZwWVHIaTiC6W2SbbrmbkZZ6ivxJ57tWKSGFOY3vfutyD7oD4DJSU7+iKRPQ322ebDfYXeaQ2M01Ndsu4X53VEwNPfQRdOmQ4Z0jypGiz83+l3uiYBAD9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYL7tP+y; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYL7tP+y"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-44fee8813c3so13435881cf.2
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 11:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724436017; x=1725040817; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEYhFMAhZu34BWjS3NlsYX+UeyYUy5DmaFBWfpuztkU=;
        b=hYL7tP+yBoRC4ez9fHKgznd20CpF8D7IuLltbQYjxjm3WuIhdA8RnECWJ1u8hHsy2n
         RGsSCF5dKkJnHnwbMwGYdyhWethtIBNnwL0EhKU9ygk/7FNh2tYsgR6rRbBMyLiUXbUe
         NFSECO/IfG+Wv0D/xiDN4334hBaYjmiU1gf5gMRCzpCOrPsq2ItZw3MjyxaD/6b2wjLX
         mrKXEKodF9bCnpcxkMqFefiXExGtDsxxYjZ1ESBWAiFZcChvhN9GcnJDE2+8tzm36vo8
         K7TEWu0x3fEXheoewQYgg2PaDKrDWZsDMgHqMSbg3pMvaVD88KmFzHjxGPxG0o71lKMc
         cwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724436017; x=1725040817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEYhFMAhZu34BWjS3NlsYX+UeyYUy5DmaFBWfpuztkU=;
        b=O10Pokm5A55RWZ34JzmoXNZ59KFDMDgREnmA+3bymeXsRyw8v6e05/36OCqNW3kE9Z
         8vqHBMikKyi/8xF0Twu1TpZ2Nv6tzhOYQGNkHrOkIp0QTg9VDklomD+3BRVr6V5SPeCM
         6vIulaYcQJ+EskUUWYtut8VO+516dW30RyQeGYrjPxLA9b8A13UbopGBfA0zG+O2jmPN
         IWnBT6gTgHYCo5uiFwwfvRWnROjAEEbsy/Xn1MuDk2cOZoJ2bZCuYYadnUtQ4FqLftZe
         N2/nNqvz7dvbTsN/H4FyAb+fYpOS2bOPKf/s/RNVVx+sQrGpm3ad3NHeo7LtcuNKBqxk
         rCSQ==
X-Gm-Message-State: AOJu0YzLo6MrlO3TMhyLPHwwrBlczTqmQJC19tkRfKJQu5HfQiS5iFa3
	HKDOMzXBLPL1JLq6YkSx0hhq948TA2T2FoD1sAfIyhrC1VqwfOOFxpr1Lg==
X-Google-Smtp-Source: AGHT+IHftQa2FV2mm8N27PKDgrzMnLF7qapsny2D0ZnYV6zHjQS6W2gvxDh/Foaq5pagS2QlnCCQvQ==
X-Received: by 2002:a05:622a:248d:b0:453:75bf:20db with SMTP id d75a77b69052e-4550976e7cbmr38718391cf.51.1724436016964;
        Fri, 23 Aug 2024 11:00:16 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe0f0507sm19683131cf.47.2024.08.23.11.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 11:00:16 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/8] netdev: define netdev settings in netdev.h
Date: Fri, 23 Aug 2024 11:00:00 -0700
Message-Id: <20240823180006.317353-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823180006.317353-1-prestwoj@gmail.com>
References: <20240823180006.317353-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following knownnetworks, this moves the settings into a header file
which is easier to maintain/read.
---
 src/netdev.c | 8 ++++----
 src/netdev.h | 5 +++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 494e46a5..4d6aae6b 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -6264,16 +6264,16 @@ static int netdev_init(void)
 		goto fail_netlink;
 	}
 
-	if (!l_settings_get_int(settings, "General", "RoamThreshold",
+	if (!l_settings_get_int(settings, NETDEV_ROAM_THRESHOLD,
 					&LOW_SIGNAL_THRESHOLD))
 		LOW_SIGNAL_THRESHOLD = -70;
 
-	if (!l_settings_get_int(settings, "General", "RoamThreshold5G",
+	if (!l_settings_get_int(settings, NETDEV_ROAM_TRHESHOLD_5G,
 					&LOW_SIGNAL_THRESHOLD_5GHZ))
 		LOW_SIGNAL_THRESHOLD_5GHZ = -76;
 
-	rand_addr_str = l_settings_get_value(settings, "General",
-						"AddressRandomization");
+	rand_addr_str = l_settings_get_value(settings,
+						NETDEV_ADDRESS_RANDOMIZATION);
 	if (rand_addr_str && !strcmp(rand_addr_str, "network"))
 		mac_per_ssid = true;
 
diff --git a/src/netdev.h b/src/netdev.h
index db0440d0..d718fa6a 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -29,6 +29,11 @@ struct eapol_sm;
 struct mmpdu_header;
 struct diagnostic_station_info;
 
+#define GENERAL "General"
+#define NETDEV_ADDRESS_RANDOMIZATION GENERAL, "AddressRandomization"
+#define NETDEV_ROAM_THRESHOLD GENERAL, "RoamTreshold"
+#define NETDEV_ROAM_TRHESHOLD_5G GENERAL, "RoamThreshold5G"
+
 enum netdev_result {
 	NETDEV_RESULT_OK,
 	NETDEV_RESULT_AUTHENTICATION_FAILED,
-- 
2.34.1

