Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF0515BA
	for <iwd@lists.linux.dev>; Fri, 22 Jul 2022 16:37:12 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id v16-20020a17090abb9000b001f25244c65dso1254434pjr.2
        for <iwd@lists.linux.dev>; Fri, 22 Jul 2022 09:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RCFO7wruesz0nYBxQHkS7ZnaRMC+O+2nQM8zZtTBnzQ=;
        b=Jj/LtKWULwmveC99uu/mkjxSjURwZag0TNNoUC69w3fn2BxDjgXDYbbhGR0DuAhOQR
         2al+qTPnjjek0NcCs03n81fG5frYa1CsE8XHQ1fl9Z0Gzt+QnS4KybY69dNfxkscHfFo
         8IWjVb4eepQyIvpqQkCBvRh8wMw/t3lZ+pn0V7+FKTMbmUsVKJMxGS25xL2eFsTmbO1q
         1Za35Te+txiyc0HqJFKNE2/ifkVJxTlMk4TwPTlq3DEq4RkCS2KTLPcICtwK4qORrdJf
         Q+yHzIe859OhtvwaRhEKtutksg9UbWrnmsouoxUMYsj3NEKnxyhaSfkICtnXxwMyVdh2
         RqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RCFO7wruesz0nYBxQHkS7ZnaRMC+O+2nQM8zZtTBnzQ=;
        b=S/ZINI9b195i+zESS6B9UWBmw/OnnN63L6Tv9ZQF1aT7o7N8abG+D/NXkVX7Bw6I+p
         XEHLEz3wCGf16BB2uyTxdQCqcI83UoR/lW0sBkuTD489VsptBhi6KF3j3CXj0g0RMuBd
         U5SGGSOKxRSIzjRVHz9DuZxn/PpXG685ZEgwaUrXZGfj7hYrfo1387EyDcJ9iUXkGuTq
         n57Ul8ZjdZjUE8WXibTbAMrs/Ozyb1pWAWB7rX0067hCLnlsBWzN8zPPedseDXH4aQ80
         vSsUSEhH9eUqu4lkTg1CZJ1lc/yAyUM2fz5j5bY9wxYyiaX3QnoQZyO2oKP2hKa2UZL3
         atuA==
X-Gm-Message-State: AJIora9i0aC1qxAWsKB/L7HzAA2G7qfcLSX7kfPeHZ9xaRg2uOOOpZAA
	YxQXnvGJEBzzpUJs4thfN3aqZsQLDLo=
X-Google-Smtp-Source: AGRyM1sQx7OjmOMtw+KF/pR12lj36H4ol1aSemhGl4YnN+FpdCiDqcr/bEPgzDoKZOCKW97VsBzXhw==
X-Received: by 2002:a17:90a:4402:b0:1f2:3507:5f96 with SMTP id s2-20020a17090a440200b001f235075f96mr513787pjg.22.1658507831561;
        Fri, 22 Jul 2022 09:37:11 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902e75200b0016a109c7606sm4013887plf.259.2022.07.22.09.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 09:37:11 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/7] wiphy: fix runtime error from bit shift
Date: Fri, 22 Jul 2022 09:34:11 -0700
Message-Id: <20220722163417.1119334-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The compiler treated the '1' as an int type which was not big enough
to hold a bit shift of 31. Change this to 1ULL to fix the error:

runtime error: left shift of 1 by 31 places cannot be represented in type 'int'
---
 src/wiphy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 09b99fb2..4b9e130a 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -957,7 +957,7 @@ static void wiphy_print_he_capabilities(struct band *band,
 	uint8_t width_set = bit_field(he_cap->he_phy_capa[0], 1, 7);
 
 	for (i = 0; i < 32; i++) {
-		if (!(he_cap->iftypes & (1 << i)))
+		if (!(he_cap->iftypes & (1ULL << i)))
 			continue;
 
 		if (L_WARN_ON(s >= type_buf + sizeof(type_buf)))
-- 
2.34.1

