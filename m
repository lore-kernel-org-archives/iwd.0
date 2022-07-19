Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F3A53A0
	for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 18:58:05 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id f65so14289728pgc.12
        for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 11:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CyoepEdhVbNOVeorXT/E1bVVTt7BGeWeuuUsfnt/64I=;
        b=FzfzUxeaGzm6CwHkKrjrTJFpv5L9kjTVsVVvttd+lrHVICzSttaTo0Ms7mXwRIGfGN
         gXYRgvN6RAd+vFvYZj86zn7ddjFqYn3lj0FHBmUovfLCCgz+CtaslnIP+xVHJKnqi09v
         IHqZ5ZxwxO4Ie5JgT59GN266hM1ot5WuJO51UniRPvSI5OXvTnoP0ni3uTvpRYspS9sG
         d+YttQZjynE2bJTK9cBLLiRCRk0kE92DzMBKx+WLrP3qn7ofnCCYYXnsmd7TV3XSFzPy
         O9shRExkdQYP/Hvg6rsI8Ra3iSlJLrMUkbInDtPospq51OOWg3bsZkNKy9AGCLY4qF/0
         v2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CyoepEdhVbNOVeorXT/E1bVVTt7BGeWeuuUsfnt/64I=;
        b=eylYLaG9AZG7Hhd5+iYU86BPBwvKwXs/MvXm1+ucjVbXLbRRleyFCavaAUEpa0sm6c
         lBZSwMqkS7Tuq1+5JO1l87QIv5pDhpz1+lPUa94hf8EeYNukhtCRNFw0/oo6m5qZeX5n
         zkQxQicqBVy724fPW8gnfnOwbz88qQ8K2/UWSwZMDCAwDDmRYmyHip+/FFsln953WDVL
         bnx/OG8XzspWQerjPBl/naqGiLuPzh/sLYHR5JPHTHkVssFgL4wbZquqqycyGFmEBLJE
         gEUftx78caIvaWM9yab8Tk76VjO1ZVFgELVjy4bUdVtc81/6Tq3E2Ykp92pqaGENhFO8
         mvtQ==
X-Gm-Message-State: AJIora85e8jPjr50fyHBOlVMCG8BabeG8N0FC17tII/f3znyYxYCoTB6
	Ml7VqfupR8ndtooeR+fGh43hWrcPcE8=
X-Google-Smtp-Source: AGRyM1v9tauEZvoh789g4sJUtlwTgwuaBtamNJdi8b123qus3pDo5/socjiB5rXQzqi3VJUewIYv7Q==
X-Received: by 2002:a05:6a00:234f:b0:525:1f7c:f2bf with SMTP id j15-20020a056a00234f00b005251f7cf2bfmr35308123pfj.14.1658257085418;
        Tue, 19 Jul 2022 11:58:05 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902e80700b0016c68b56be7sm11937785plg.158.2022.07.19.11.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:58:04 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 12/12] scan: increase max data rate, now for HE
Date: Tue, 19 Jul 2022 11:55:44 -0700
Message-Id: <20220719185544.456727-12-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220719185544.456727-1-prestwoj@gmail.com>
References: <20220719185544.456727-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This increases the maximum data rate which now is possible with HE.
A few comments were also updated, one to include 6G when adjusting
the rank for >4000mhz, and the other fixing a typo.
---
 src/scan.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index e1c89fb2..7fc60e32 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -1628,17 +1628,17 @@ static void scan_bss_compute_rank(struct scan_bss *bss)
 	double rank;
 	uint32_t irank;
 	/*
-	 * Maximum rate is 2340Mbps (VHT)
+	 * Maximum rate is 9607.8Mbps (HE)
 	 */
-	double max_rate = 2340000000;
+	double max_rate = 9607800000;
 
 	rank = (double)bss->data_rate / max_rate * USHRT_MAX;
 
-	/* Prefer 5G networks over 2.4G */
+	/* Prefer 5G/6G networks over 2.4G */
 	if (bss->frequency > 4000)
 		rank *= RANK_5G_FACTOR;
 
-	/* Rank loaded APs lower and lighly loaded APs higher */
+	/* Rank loaded APs lower and lightly loaded APs higher */
 	if (bss->utilization >= 192)
 		rank *= RANK_HIGH_UTILIZATION_FACTOR;
 	else if (bss->utilization <= 63)
-- 
2.34.1

