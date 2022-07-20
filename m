Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24397489
	for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 22:17:16 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id f11so88550plr.4
        for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 15:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r28ZFcfxUrmrlT1fhyZI+HYXwvVxgOPhLo/OAmIYktY=;
        b=Kb4iDtH0dCxvOA3bWcHn0F7SsAkNjkK6RcD0gp7fX+9vW5dsoNN6LU96kV+0+roKQE
         l3MrDiGXmTt18neswYuJpDYLgUJeNrdJz+f/HlXEU6/UFBMZ+ItIQFF1+TIfPT7cIPc1
         6RpmiEn6s01tohcXFhgYsP5SJy4q1kzPsZL4qaTtpmW0rh95JKZz0V3/6W3FetYv95gw
         FCu8Q5XRwXqi/v9/mFzIglB8HiZK3RExY75YkaEa270IAp8F4c3KLzZXAQda6ZDBDYmX
         7tP+0PjJ0H9Y+5DL2pxXdxmujkMN6Qcmir46gcFznDEuxqjhge9Gew4d0NnuQU/xV0at
         gfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r28ZFcfxUrmrlT1fhyZI+HYXwvVxgOPhLo/OAmIYktY=;
        b=p6XXB/fQ4etzDcAzM9DNdyGPtKLt2lVgswBs/wGBinynCRc7HCqu7ipruTQOw0k6mQ
         sJxvBl1xPRgZdQATI2Mfl1FM7h/J7lVatPA0TjPz34OayfwwERFePmB2h0kk/Ldw3pk4
         R9DltZ+4J1R/eaN2gE2qsyJKkX9sMR1b3SMatFrdMdQeCseOtRvfDxIIuWkVZjKpl1HN
         GaD5RzWhhlwOHBrFwTpSh3WZXruUL6dBsYfIZsH001QvefzqukeOY2J1wzkYC6/S7Vpg
         UPb2Cn/BQuru1bjtwzrfic6FqNnjcZaJTTdzYPRBstn0yRvfaY2jZOrJF1rJOE/iqXh9
         X6RQ==
X-Gm-Message-State: AJIora9F0FMXNOgF9QJ9Ndi0ob3XQo2tH3+9h4oZhsCSpZb5wsGsdcar
	zFifryEvnn3piC12gXBAcgHX62uv84o=
X-Google-Smtp-Source: AGRyM1vLQ+GOwpuipKw/boNRP8eY0+ND1YVGkAaxaH//ioVh0uzyaehcVRHhoEMuL/JQbkJZJCwe/A==
X-Received: by 2002:a17:90a:e7c4:b0:1f0:78a7:bf37 with SMTP id kb4-20020a17090ae7c400b001f078a7bf37mr8003129pjb.77.1658355435967;
        Wed, 20 Jul 2022 15:17:15 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id q10-20020a170903204a00b0016a1e2d148csm75859pla.32.2022.07.20.15.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 15:17:15 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v6 4/5] build: add ie.c/netdev.h to test-band build
Date: Wed, 20 Jul 2022 15:15:06 -0700
Message-Id: <20220720221507.886811-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220720221507.886811-1-prestwoj@gmail.com>
References: <20220720221507.886811-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 Makefile.am | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 80377613..cffb0738 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -466,7 +466,8 @@ unit_test_kdf_sha256_LDADD = $(ell_ldadd)
 unit_test_ie_SOURCES = unit/test-ie.c src/ie.h src/ie.c
 unit_test_ie_LDADD = $(ell_ldadd)
 
-unit_test_band_SOURCES = unit/test-band.c src/band.h src/band.c
+unit_test_band_SOURCES = unit/test-band.c src/band.h src/band.c src/netdev.h \
+					src/ie.h src/ie.c
 unit_test_band_LDADD = $(ell_ldadd)
 
 unit_test_crypto_SOURCES = unit/test-crypto.c \
-- 
2.34.1

