Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0F24A24
	for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 12:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744806862; cv=none; b=aUFetXMvu9L7rcl9M2p+UlpjN8IdQeD9znLXU8MaAoZWHvbBeHyvDSUxGRIgHj3lC0K2CkYhzZ4yZCQ/KiDYaHpp/eJDOq1XsGgDew2kxRUD7Ey+8I2KoD3lVhmjjbhhkwdVKwV6kYsDep6y1anNmUbJTZBMkhJ+TPGoy5ctQ8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744806862; c=relaxed/simple;
	bh=EGaMXt8Yryi7zOSMDX2ENsUqDz2a1brkUe7Rex+W+VA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IoP2N6i8Nzkz6UKka4ZN/+kVWmBGQeefALGd/sRGM6kTFcNXV+gn3PEJA1IzDGQ2KYHjijgdnsSqAYck0iuSPasbQCU3OTVdm9LlYgnt+jdh/BT5yVF+wan2QBvFpe3cDlltuHxyjZ+3qLbPh+mt1oFEpBNOJVGKFXxMDz+Pd+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0Q+BZ7/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0Q+BZ7/"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736b0c68092so5718088b3a.0
        for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 05:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744806858; x=1745411658; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+Q4M8gaGH5zEgfrbubTTB5hpfOt400CYT6XidDglFU=;
        b=T0Q+BZ7/h98PY8ogxkV2RSu3XLiezAbPtc2Y2ooFi2gJzy6WnpBdPa7Y2njKL5ILPx
         7cl79XwJl9gRMgptOiIODOTj7oOekEs3Diisd+r58qWJak731IlYEi6UyyhFsurrhu78
         1JIhtIFxdd1ZK75HeapU6CfZwrNgNZCZcocp7kAJ5Zg0DzPBWwRZmElcdnGd0KUU+hE6
         kPPA+TPve2lXhnomr+2JSdWBSNPuT9C7CChv0wCHIJltcfaIxu1nubfk+TKNYwtSTr9r
         Fh01dTwuo9AwOjIjHWjQ3nkr+i0BeRW8ZSBpGQ5CzwA0H/c0LPuGXEwaGoBHMI5cbFLW
         n/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744806858; x=1745411658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+Q4M8gaGH5zEgfrbubTTB5hpfOt400CYT6XidDglFU=;
        b=kSarRGxs16NewQK4ABm2Pv76tIEst3yibHfYBP+x+NBzK3b+lII+GT9dtxLJF+DMXU
         arBy7zzBImSrMnvKejCfFe0ush7AKDp8cKODs2vE67aZ7y3AfQiH8miBjASFEWvlcn4g
         snSZlcMZGpNThC1LsymfCpxQdmJo5anbr3ByUhEXZ0QzEaodIfv1gka8j3PZmRxSwQjG
         nPJBji+51cpkc4Qg4szM+M9kJA0jKBPM9GqxT7xsgAZWf9xK4I5Cuxj9L41eRa0Ywq78
         zVDdHlqAnauHIrHrUh6dg2sQuFwgld5/XhoN9NQOgODDEI+GrCt2QnbWIUoB5VGxvpTD
         mLtw==
X-Gm-Message-State: AOJu0Yyb6GvyisfdQeDFJFtctzCyqNM/iMnU0xdv7dgbAinMZvqxhZZQ
	zkrt1W/XwenscZ9++SaHRNVLjTwPiqm5S7avdOCM9JdENEm3gi9uXEBCbQ==
X-Gm-Gg: ASbGncua9mMbBw8lOizkHLpz54mBwAIJaRcGbjJDaKRTyR3lczy7TaXXrr8GW2J06nV
	BIDwnXxvY31NZmJR+aajgSBAtOcjjqiZtbPpf+T6y3SJzJI0umn4/dC/cOUQ3H0LDByWmcElgTn
	zc5rUudUw63FeABVqdPSygNDD/887rktV6H/khip2Zos1Um5S2yDOXwLEEvqf1HthdgZWo5HKgA
	9zzyweXLjSw4azd3C0MojXemqu+xQ4i3SuOVTDRzDw5KFZwADG7ZhqquWgusiidS3wQ0W/3dNVE
	POKSPAkgj6FJ19w0bUEOzLHjNiN0SV/jLqoQ5zd/siT91ySnSHo8H1T6baYJan5yIzCLB2uWC+M
	+tXU/01MsdFDP32iZ1QAWlEHNhRA=
X-Google-Smtp-Source: AGHT+IE9r8YhMlDRSOovM06pQ/+kstLQHbleg7vPKrU5IQ9L8wFVb/flvs/lue+mCb+xkjRaqtbXsA==
X-Received: by 2002:a05:6a21:350f:b0:1ee:e2ac:5159 with SMTP id adf61e73a8af0-203b3ed3b37mr2401723637.19.1744806858555;
        Wed, 16 Apr 2025 05:34:18 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0b22217ecasm1124408a12.68.2025.04.16.05.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 05:34:18 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/9] scan: fix out of bound array access for survey results
Date: Wed, 16 Apr 2025 05:34:07 -0700
Message-Id: <20250416123414.114231-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416123414.114231-1-prestwoj@gmail.com>
References: <20250416123414.114231-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The survey arrays were exactly the number of valid channels for a
given band (e.g. 14 for 2.4GHz) but since channels start at 1 this
means that the last channel for a band would overflow the array.
---
 src/scan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index aeab6516..dfd667bb 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -143,9 +143,9 @@ struct scan_survey {
 };
 
 struct scan_survey_results {
-	struct scan_survey survey_2_4[14];
-	struct scan_survey survey_5[196];
-	struct scan_survey survey_6[233];
+	struct scan_survey survey_2_4[15];
+	struct scan_survey survey_5[197];
+	struct scan_survey survey_6[234];
 };
 
 struct scan_results {
-- 
2.34.1

