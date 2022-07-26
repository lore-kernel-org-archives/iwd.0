Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E934F5390
	for <iwd@lists.linux.dev>; Tue, 26 Jul 2022 17:09:32 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id 6so13637158pgb.13
        for <iwd@lists.linux.dev>; Tue, 26 Jul 2022 10:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cTnwEXVZ31oHReA81rvxjD/SAzbDjuxQKl7Dj/EUJV8=;
        b=Vq7PZR4zEf74sp1Nm7zGjphDrwfqxd/YrcdEzakasGefZGwOeQPg8fbfvVBsoMxX6M
         Mf7F136OX9hcOp7HmG+oRrN3C1KackJsy6UCE0aZWuiaUSvzlYp0oumst8dcCkAh8Zda
         gd+Nq7+WKYD2wJsdLrBTBgcXzmSQ5nxETmwQe4ikG84dlkQ5ust4xoCUHfHHeo60yjuR
         MljnunE4SFZECLpNv6Bdf252oB9PeZRGESt/DgUMdJthGBUyjnWWIbBdj59n+r+lYefw
         YkeVmdLwi33b6EeYoCiYkptQqNLxrsyyx36XT46K5lVCa5kI7N/LelqZd4TwQlErSb8Q
         Ouuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cTnwEXVZ31oHReA81rvxjD/SAzbDjuxQKl7Dj/EUJV8=;
        b=diBRc+0NbfuVGOFS412vVKZicTz7ncbS/dW6DYO4Y/++kJ0aBPcIuL5wrq5fqC4mDe
         z0tV5hFiQWO1KwMxHSLChZ0aIyABwhUxX1yNl/+ROrKksCRV/si2LCkD8Qx2G64EiOcM
         hvB7ex4NU7KasGtEqchzW9mEtJau4Qs7nuCYgnvOGD6PxcnpGok0r7dGCL6Ejh10Pi13
         rIaNVOQsJnHZfOSViPbW/UbJf53+Xkv4l8VIxbJKynPeKKw82PISBF+wXPUbq2HSXgMH
         6+JzQTumm7N3IK15h1Ipzvxmjqk/BDl/mczbj+S883J8RKuxc+iif6Cz/5sKEh9++xEU
         vGwA==
X-Gm-Message-State: AJIora+q0BroIqtaG8FfHWoQDg9jB7aAS1CA7ZdHTC6Q+cMDZ7skgrBH
	1pKM8cTOPDQkM3VCi2JH2stTnP6lvGY=
X-Google-Smtp-Source: AGRyM1uLnHNg1iy08jMsNN4ylFW8PFb66oGwjsaauXEOVG5CasYcP5Ews1FhoAp+A4rdRVf0qOeunA==
X-Received: by 2002:a65:6e41:0:b0:412:4c1f:9936 with SMTP id be1-20020a656e41000000b004124c1f9936mr16181897pgb.455.1658855371939;
        Tue, 26 Jul 2022 10:09:31 -0700 (PDT)
Received: from jprestwo-xps.none (h208-100-169-68.bendor.broadband.dynamic.tds.net. [208.100.169.68])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b0016c09e23b18sm11778694pli.154.2022.07.26.10.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:09:31 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 09/10] wiphy: constrain scan set by disabled frequencies
Date: Tue, 26 Jul 2022 10:09:19 -0700
Message-Id: <20220726170920.15929-9-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220726170920.15929-1-prestwoj@gmail.com>
References: <20220726170920.15929-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the addition of disabled_freqs, wiphy_constrain_freq_set needs
to also remove any frequencies which are disabled.
---
 src/wiphy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index 5329e8e4..30653b91 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -707,6 +707,7 @@ bool wiphy_constrain_freq_set(const struct wiphy *wiphy,
 						struct scan_freq_set *set)
 {
 	scan_freq_set_constrain(set, wiphy->supported_freqs);
+	scan_freq_set_subtract(set, wiphy->disabled_freqs);
 
 	if (!scan_freq_set_get_bands(set))
 		/* The set is empty. */
-- 
2.34.3

