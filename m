Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804264C9D
	for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 22:07:53 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id fv3so19173536pjb.0
        for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 15:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=2qZbaQeHLyRqXYAjQshAbfLBQvVsqAwSasiuN/IIkBU=;
        b=KfWYI7BOy+Jk9AzFtkFJeXZbcg99ifh+5DgzzcEgXLJarRa4HIGQjpqzmdKaKRdIll
         ygdjKXP9EqTSmZGA/Qd6p76EJpVrmAg6K2lWBxRDCJdhtqI9dzJe9zUab4fYRmu2B7BX
         FO9579TofCGF/h8W0C7FZmgXeDESdBQy+ivUudwnXwb2cKu03kwedQqtemLCRoQApvC9
         5AjiugEwrgbRNf243VLSfA1ndAY4m83AOgSJ/WLJa65erutNn6+Bdb9ikKZXWTshvggw
         IPzgJ4NE0RRgDC1kCPtlSRDq+GiMrWtVYkvwk1p3f7D0ovbdZvHvvRmSGtPKar1bprsh
         Xlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2qZbaQeHLyRqXYAjQshAbfLBQvVsqAwSasiuN/IIkBU=;
        b=C3G8sp3aU+ff63rF6SDLSRSZdlnQNIooE6wrR0MGNMmrKnmgrA8gXaIs0nW8L8YTpw
         sRvt1V1WKEbHaFEywlRgDYNaoSxc+266hkqzZkHBGQOKPuiWANcZjJAzYY/V868lR8WI
         hDx3LL5QQdH4ynFjywFdM4R3fO4wwVMPc+9ePhGRuENrv6Oaw3UndCZqQmcyNxYNfq32
         IXjGYlRk4Lcv72jmM73VTr6stm6JMK7EZhHy/KggAOIl8CSattgPMB6XuZJEMYicKM1t
         UxYE55rluF+vWMzzW/jesTno1XIx1qTD76An+vNsnT+y9hnNvfIlMbu1iZ0WHIDwYk28
         +hTQ==
X-Gm-Message-State: ACrzQf0JlMA/G0BBpT1jr+4dCKHUuCRfod7S2jTh639BrkAY4eAt3qrl
	56CrlJluBKSpe9j6DLTWBv5SrK2TY0k=
X-Google-Smtp-Source: AMsMyM4bHShG54GvZVXLHthnEhs9sfyJxzXz7yLv/r9h1Oxe+fyBmfaPvWLNMYXaYD/Ql2foSxHI1A==
X-Received: by 2002:a17:903:32cc:b0:178:41c1:2e41 with SMTP id i12-20020a17090332cc00b0017841c12e41mr1655198plr.126.1663279672749;
        Thu, 15 Sep 2022 15:07:52 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id k2-20020a6555c2000000b0041c0c9c0072sm12147165pgs.64.2022.09.15.15.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 15:07:52 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 02/14] station: don't set OCVC for FT AKMs
Date: Thu, 15 Sep 2022 15:07:29 -0700
Message-Id: <20220915220741.1128728-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220915220741.1128728-1-prestwoj@gmail.com>
References: <20220915220741.1128728-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using OCV in FT is now disabled, so if the AKM is FT don't set the
capability or AP's may reject FT attempts.
---
 src/station.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index 4faac050..79d2c755 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1110,9 +1110,15 @@ build_ie:
 	 * seen that they do not include the OCI in the 4-way handshake yet
 	 * still advertise the capability. Because of this OCV is disabled if
 	 * any offload features are detected (since IWD prefers to use offload).
+	 *
+	 * TODO: For now OCV is disabled if the network is FT capable. This is
+	 *       being done until support in the kernel is added to
+	 *       automatically include the OCI element for the association
+	 *       request.
 	 */
 	info.ocvc = !disable_ocv && bss_info.ocvc && info.mfpc &&
-			!wiphy_can_offload(wiphy);
+			!wiphy_can_offload(wiphy) &&
+			!IE_AKM_IS_FT(info.akm_suites);
 
 	/*
 	 * IEEE 802.11-2020 9.4.2.24.4 states extended key IDs can only be used
-- 
2.34.3

