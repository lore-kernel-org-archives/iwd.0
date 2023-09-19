Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28D8347B4
	for <iwd@lists.linux.dev>; Tue, 19 Sep 2023 16:59:27 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1c43166b7e5so41052685ad.3
        for <iwd@lists.linux.dev>; Tue, 19 Sep 2023 09:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695142767; x=1695747567; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhUGICV688qItYF76Q82MOfxXXk3cjDAABRYlHyBycY=;
        b=TKP4PAEQPTnPTs/iwSnsJV7d2EpLCPh3JNqCglj1ANJUR7PsGRk5avfdAWtyLpWkLE
         46oNAAn4V7tC+DvHwh46tPpynquSvV0+YQ0bSDFr+g1F8iHc4Dr7oZGH0j8Uy+0M7DWx
         IHWlmmQ2W4AWkbHajyCSIIHxnP9dwiSltxmye7D1YXBDj1YbGTfZSfDydo5GzHd/ckm6
         6Fg/2OutfvyCb0q6g9zS+n9NTu2j2mSQH8eLR03oh14RpmRAzEIqSTskv5UGnoWdfWkf
         yudctJpXrqOTiezXnIUL/hzYY3oHfDlQ+NEoVJWdkrJttG5budxWieI/hVWr3L3shiYp
         QdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695142767; x=1695747567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhUGICV688qItYF76Q82MOfxXXk3cjDAABRYlHyBycY=;
        b=H8KjBDkjev3fB+NrLaZmeeTTMD0A5DWkbev1SVpqPeiTJ+vGZFxnzUNyzJXTWgPqtu
         LZLJY0IZsikRXVi+rNOq5+OAHr5K22jzg/P76cBumJyuqoaT11sosbEnXeJvVTpf0V/h
         jQp9128lbJySsKBr+/0p6OIZ8mW1hTwzJ2+HzYmZaKgq1zAFoAP28xBqUl4iA2gxDtTJ
         LIY+cjtphR49xGrb4JVGxgbwkWBHEXWeklN65CgLMV6bgzCi6TjMX6uTDMceBiKKgzHW
         nl7xfM7sbyC1jblAoar5UMrZpz/iJqyxtNmKQtWv1PSJBAbj09XNZrNi4QaJ6VwDhm3d
         fbSw==
X-Gm-Message-State: AOJu0YymZ8FAA4L1dZto4yZc3nKWqYl0K5aG+8tGrTpBSdRV791Ob9p9
	kzlVl80vCpeyslG1b8tX74wOx8xIIdU=
X-Google-Smtp-Source: AGHT+IEF7nXgMqnDaQjM/SjoHdZBs9v2G4KZTFvLRJiTv6cFm00zPRWyMa3MLwZU1HsIBlyTRqkM6A==
X-Received: by 2002:a17:902:e851:b0:1b8:8af0:416f with SMTP id t17-20020a170902e85100b001b88af0416fmr2642plg.1.1695142766933;
        Tue, 19 Sep 2023 09:59:26 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090301d200b001b8c689060dsm10323399plh.28.2023.09.19.09.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 09:59:26 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] unit: include frequency 7115 in test-band
Date: Tue, 19 Sep 2023 09:59:23 -0700
Message-Id: <20230919165923.1352279-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230919165923.1352279-1-prestwoj@gmail.com>
References: <20230919165923.1352279-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test was not including the last frequency in the 6ghz spectrum.
---
 unit/test-band.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unit/test-band.c b/unit/test-band.c
index caddbcdd..e27531f7 100644
--- a/unit/test-band.c
+++ b/unit/test-band.c
@@ -644,7 +644,7 @@ static void test_6ghz_freqs(const void *data)
 	uint32_t i;
 	enum band_freq band;
 
-	for (i = 5955; i < 7115; i += 20) {
+	for (i = 5955; i <= 7115; i += 20) {
 		assert(band_freq_to_channel(i, &band) != 0);
 		assert(band == BAND_FREQ_6_GHZ);
 	}
-- 
2.25.1

