Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3FE1D7E22
	for <iwd@lists.linux.dev>; Tue,  3 Sep 2024 19:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725391658; cv=none; b=BPjE/Hs12iG5TFjPw4Pb7Sxj8m2Br0bzCoLyKJVUo0YkLCs25XnM8b3+73HvnWp80IZrIXYCOhKvEhtp64hsLwYQ4RpYwONGdwaIfs9taHRk1bf6XrG5DAD3ViccOwOaBfUz59Y2/ZCumLYKjssUb09nonSKH4lq+BMgEmWDyNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725391658; c=relaxed/simple;
	bh=aYT8wfaejKug4GtR2Ta3ZBYbACLTPa04bEUiQTLcoZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvcfE5/aDs5E9UoukjCIt/Iizoub9bVuqfE3JjjE6MJqFiCZ4rijm/2LxlUKyDxKrKJ1lNN7ndEX0T8tRgWCpY//ofwV/tGRMZlJ5bH90blSxaHJz7/dSxEqlVVCoeAvFoXN5TjWPwgYiXKL85rIVLHyfTVx4yNW1PYaP62WzmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TW7N9f7I; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TW7N9f7I"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5353cd18c20so49495e87.0
        for <iwd@lists.linux.dev>; Tue, 03 Sep 2024 12:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725391655; x=1725996455; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Q7d6bTpKsThQJXFUDgZ+ogVX6GVkUNnprs1YFR5xKM=;
        b=TW7N9f7I2oPiVZJV2EarNDgcwXM2cLM1rkBXJeAdmQ31g/2xZ9vKINe0OT737XAaL/
         QSfIXyIs6ZYQLzski48YtGkY5seguZKFuLhzv4OS5/zwyfr4arRo/VgJKiy2gcN4Ra0C
         wDBIwRE+iPpZ36fM2/0gIFSPp34qE0x7rXcB79lxbIZKASLmZaayNa86fQx4bPqU7YVV
         nK0ENKH7LwClEms/yxX+rjgGIsKZImgCBPUxvmih4VJHwsrfxZ4/SmHVxwHSryD5Ptgf
         x6VD5p7zlHbmAJNj2v8M4tKMmEIkZW19TEF4zWfP5E7THD4HAl/56wyLbOKNPQNlgK6p
         rq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725391655; x=1725996455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Q7d6bTpKsThQJXFUDgZ+ogVX6GVkUNnprs1YFR5xKM=;
        b=TVeJndAwHlit0cScOKjp4Cq9ltS6+LXArpoXrGeApHm+Lu5a/oLRCH86Ob1kvxix5x
         Vx8RiUezjahrhmGHTOpCNUSQdQkctWmqDVKDcAo8DHC1Ym9nrThQ+zJZ58B5pTrGaHRH
         Rvxa7qUssRqFdx92dARjDoZnYLHiusnF+C/2jX6nU9Y9fBwIHS21ONa5XhNdhXBc4Ys3
         bSoimLR65hyXtSNH1hBTJm48wdKPbincYSwU4XvQpN37MIbiD7mngsaMJsCgZPPhQVCM
         Gm3OjnAryNB5I9ZBb3w1iV4msKakEyshPqmIUDvCBP7u3uLNOlaQxJQLjwOpobv8k7aE
         X7UA==
X-Forwarded-Encrypted: i=1; AJvYcCWNyHPGRnMqt+zhPLXvWDPfjm9g+SLNMYIEsPnj6wiC1FaEZGDtMVUpNg1ONLbHo2+xPTQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YxhGPCYj7Gy4uSmXk15EoMJN3VUzeMQP7Tb2If2cSUFB6HNulpw
	OnU082EKCDtn5ihKAXDMam50Q8GLbeTZu40m1oddGbcuG/RUBAadQkbFZQ==
X-Google-Smtp-Source: AGHT+IGRCO4FUufCVV/k+3rRl3guFtGw0kxQ8IKMtPh0v573XU7/oFgXIEsbhVjdgJT6NngM1ZSGJg==
X-Received: by 2002:a05:6512:2208:b0:52f:89aa:c344 with SMTP id 2adb3069b0e04-53565f18fffmr71333e87.16.1725391654189;
        Tue, 03 Sep 2024 12:27:34 -0700 (PDT)
Received: from localhost.localdomain (c71865BC1.dhcp.as2116.net. [193.91.134.113])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-535407ac1a6sm2122536e87.73.2024.09.03.12.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 12:27:33 -0700 (PDT)
From: Daniel Bond <danielbondno@gmail.com>
To: prestwoj@gmail.com
Cc: danielbondno@gmail.com,
	denkenz@gmail.com,
	iwd@lists.linux.dev
Subject: [PATCH] scan: add guard to check that results->sr is set to avoid segfault issue.
Date: Tue,  3 Sep 2024 21:27:14 +0200
Message-ID: <20240903192714.6922-1-danielbondno@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <32229467-dd4d-4207-af4e-e537500e663b@gmail.com>
References: <32229467-dd4d-4207-af4e-e537500e663b@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch created by loqs in Archlinux issue: https://gitlab.archlinux.org/archlinux/packaging/packages/iwd/-/issues/5

As mentioned in list: https://lore.kernel.org/iwd/4083bf62-20d2-46e6-bfae-c926c2acbfe9@gmail.com/
---
 src/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/scan.c b/src/scan.c
index debdeb1f..e5360d1b 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -2056,7 +2056,7 @@ static void get_survey_done(void *user_data)
 
 	sc->get_survey_cmd_id = 0;
 
-	if (!results->sr->canceled)
+	if (results->sr && !results->sr->canceled)
 		get_results(results);
 	else
 		get_scan_done(user_data);
-- 
2.46.0

