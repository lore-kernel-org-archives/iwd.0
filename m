Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776EC521CD
	for <iwd@lists.linux.dev>; Fri, 29 Sep 2023 16:20:03 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1c61acd1285so77263725ad.2
        for <iwd@lists.linux.dev>; Fri, 29 Sep 2023 09:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696004402; x=1696609202; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vX6DojQvEY5hi+VRYB+vpmiDg2V/5lxNzRmyiVThuTg=;
        b=dt95b7KWw3y4g0p+l+QnWtq5DQIeNHDqYiDyszfM+eTQ3J48YHiipKy8eU+U4oaUIm
         3/YHIdrzPqZKoFXwcUm/78AzIbgaP75tB8G8/H1ZqJt1NYwE5AzyNcu1T9YxBmkve50l
         ZWKhx1lur7VmJDf4nw1K9AhFeekFIR/kI+JzzAJIrQjM3X5Uf7y3h8bMTSg24KuhWm/d
         vK2TWDgWBlYuvXGsEC8IXZFEiGIZvx1QBxE5a6q/p6i05aHBC2XHLyckGDvtbRQYuaT3
         Z96JM9Jmtl2DncdAddnFYNCt95bjX/XV84gXG6Oq4rJtWh88Bn6ld+SIGfjzvaOrDVdF
         lUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696004402; x=1696609202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vX6DojQvEY5hi+VRYB+vpmiDg2V/5lxNzRmyiVThuTg=;
        b=XHof/TBIvf00dWnk95Md5YNt1sHCQeU1xCDhR0tnk6Mia4sIimC1nq/tyYsk6MsvRT
         MuCXjqxoKthUx/dMq4IK1wD7SEhDk+X71B1e+YP1nzQrj5Iav9pGqyzDmTPhf8Rg+Gt6
         2spYn6ThpVqACxMiCsg3EpNdkuFiiblW602cmENrchyUhvO59UIjxXK0m8qtkshiE6Ys
         nirZo5NZ9zh0MdfnuuvphlPZAkGx0UwRi+lZRe7JYa1FZ1r0GTx250VxBQr+8+tbcF9k
         4Unc+5//vnZsUnXfGepkXlZ6hO/p/PcwvmQHJL5sgv02JSsA6k16Q2us7Brc1bSwL95M
         kqWg==
X-Gm-Message-State: AOJu0YxgK27wkBbXGDjGDwz645q056noluYHuvaT1vE109THRYKA8yAG
	QYSrigYsV06DeKiRS9KwYxAzwA7ycWI=
X-Google-Smtp-Source: AGHT+IEe2SRMzz2ibeExRV3/O3BPG2mAoxVvRoue/Fd6vWTd19cLXKiq9/6vOPeTORe0zMCQBtf+Ww==
X-Received: by 2002:a17:902:cec3:b0:1bd:a22a:d409 with SMTP id d3-20020a170902cec300b001bda22ad409mr5485776plg.40.1696004402399;
        Fri, 29 Sep 2023 09:20:02 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902d18100b001b8b1f6619asm17223766plb.75.2023.09.29.09.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 09:20:02 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] wiphy: remove wiphy_get_allowed_freqs
Date: Fri, 29 Sep 2023 09:19:59 -0700
Message-Id: <20230929161959.3840935-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230929161959.3840935-1-prestwoj@gmail.com>
References: <20230929161959.3840935-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was recently added but with the modifications to
wiphy_band_is_disabled() its no longer needed.
---
 src/wiphy.c | 15 ---------------
 src/wiphy.h |  2 --
 2 files changed, 17 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index fd22f013..7c93f999 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -500,21 +500,6 @@ const struct scan_freq_set *wiphy_get_supported_freqs(
 	return wiphy->supported_freqs;
 }
 
-struct scan_freq_set *wiphy_get_allowed_freqs(const struct wiphy *wiphy,
-						uint32_t band_mask)
-{
-	struct scan_freq_set *allowed = scan_freq_set_clone(
-						wiphy->supported_freqs,
-						band_mask);
-
-	if (!wiphy_constrain_freq_set(wiphy, allowed)) {
-		scan_freq_set_free(allowed);
-		allowed = NULL;
-	}
-
-	return allowed;
-}
-
 static struct band *wiphy_get_band(const struct wiphy *wiphy, enum band_freq band)
 {
 	switch (band) {
diff --git a/src/wiphy.h b/src/wiphy.h
index d61516d5..7687dd25 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -100,8 +100,6 @@ const char *wiphy_get_path(struct wiphy *wiphy);
 uint32_t wiphy_get_supported_bands(struct wiphy *wiphy);
 const struct scan_freq_set *wiphy_get_supported_freqs(
 						const struct wiphy *wiphy);
-struct scan_freq_set *wiphy_get_allowed_freqs(const struct wiphy *wiphy,
-						uint32_t band_mask);
 
 const struct band_freq_attrs *wiphy_get_frequency_info(
 						const struct wiphy *wiphy,
-- 
2.25.1

