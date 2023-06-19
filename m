Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6881910797
	for <iwd@lists.linux.dev>; Mon, 19 Jun 2023 15:26:01 +0000 (UTC)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-62ffe4cabecso25602746d6.1
        for <iwd@lists.linux.dev>; Mon, 19 Jun 2023 08:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687188360; x=1689780360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvjSP7iTjh3+N0OkRVEY+dGRNgXvdcsmdCzw187tvH8=;
        b=NB3PldCaAbcm+4eODHdfDRwZCASBEtLBMDH35Wpcpe4A1/i+cCM2iPKoWDS9nYIC6J
         rgzY2p3fVPZqFI6Cg6lZ3j1aallaZm3u2r0T4cDFUWV2Ap7IA1y6bfS3Cpx3NzH4Wn4q
         khQQrUWlxKfM4t/SSy2GIXMc3jukBZ+a+nDjgvVSsIb0Qq2KGd7MAksCVLPj+srn0RwV
         ewgiMkaqR6fiGs4lQJw3JyK9xLGXdt6Uoy40khAz24zIUEM1EPGiTpY8VyDDvpODKjbm
         AIcgsEmKflfXShGR6dPnaqx8W4LlUKrypiFx9djl4I01fHOKIFpBvVQeQkOmyOd6OYGg
         dIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687188360; x=1689780360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvjSP7iTjh3+N0OkRVEY+dGRNgXvdcsmdCzw187tvH8=;
        b=OrbHCHZj4/0CSRscJpF9J+hiS1rdCaKZtgwW2FmFTnriYEnBwYhOXhmS6cvMGEhoRK
         OnQ54xKXw3kd5pPlOLoq3KHJEstkh5zB3ROs1cTFvZ5XwVZaFLLIBYZoV3N2NAcFF9Jx
         ldsHtZ7vh39w0O8yOS+mcXX02AzyYDwWfYjKXYjqhXzmBXVq2pejwWMl98DtiOVIYho1
         qaSUz1nG+N1Hkm29VfQX9Zv2XjiK67E0jKZao5dDaEVLdLj3jBD2zUPousavKpDwScAU
         Xv83J1khklhgHqN77qnosLhOTHQpesmEMOW74YdluGoeKUpdy4/UYXxJG7Lk43dSXW8X
         lWJw==
X-Gm-Message-State: AC+VfDzCfP3F88RlKiz4Ptz+apGtYILJlo3BIT2ZC9GVaRJoPjcE8C9w
	9jJdP82wsZI5F78DRP+7UihsOhlRuHs=
X-Google-Smtp-Source: ACHHUZ4XgsS/Nt3Enpuu3K+J+sAcogWa/bzB3dBL5XvBbe3yNNpCdooz+FHQj5fZNRY8tbtpGFng/A==
X-Received: by 2002:a05:6214:27c9:b0:62d:f515:9320 with SMTP id ge9-20020a05621427c900b0062df5159320mr12358053qvb.28.1687188359978;
        Mon, 19 Jun 2023 08:25:59 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id j16-20020a0cf310000000b006260c683bf2sm66544qvl.53.2023.06.19.08.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 08:25:59 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/3] wiphy: remove l_info's for control port/power save
Date: Mon, 19 Jun 2023 08:25:43 -0700
Message-Id: <20230619152543.197532-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230619152543.197532-1-prestwoj@gmail.com>
References: <20230619152543.197532-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These should not have been put into a getter for wiphy and now
the driver quirks are printed out in wiphy_print_basic_info.
---
 src/wiphy.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 39ebe276..77ed2acf 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -708,11 +708,8 @@ bool wiphy_control_port_enabled(struct wiphy *wiphy)
 	const struct l_settings *settings = iwd_get_config();
 	bool enabled;
 
-	if (wiphy->driver_flags & FORCE_PAE) {
-		l_info("Not using Control Port due to driver quirks: %s",
-				wiphy_get_driver(wiphy));
+	if (wiphy->driver_flags & FORCE_PAE)
 		return false;
-	}
 
 	if (!wiphy_has_ext_feature(wiphy,
 			NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211))
@@ -727,11 +724,8 @@ bool wiphy_control_port_enabled(struct wiphy *wiphy)
 
 bool wiphy_power_save_disabled(struct wiphy *wiphy)
 {
-	if (wiphy->driver_flags & POWER_SAVE_DISABLE) {
-		l_info("Disabling power save due to driver quirks: %s",
-				wiphy_get_driver(wiphy));
+	if (wiphy->driver_flags & POWER_SAVE_DISABLE)
 		return true;
-	}
 
 	return false;
 }
-- 
2.25.1

