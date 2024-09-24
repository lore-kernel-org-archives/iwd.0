Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D9B19ADA6
	for <iwd@lists.linux.dev>; Tue, 24 Sep 2024 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179499; cv=none; b=IdvShSHAhD70G7od3q3F4c2UPal6aOr0+lc1PTVfq8SwYCJUSkIrLs5dPw4OEW7svLiYXwutmWEk7IRGeJXiqTj/sVD4ZNbtC1hlEqQRz+mPvKo2tk3oksoIXByE15aB9eAWjhzF7aswMd5GYyJWorJHpGfAj2ZgRW7O2wzL38M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179499; c=relaxed/simple;
	bh=z0yBTUKx5fKOKjGm23Ru/35W7KY5QasPJR4dWIGgFxY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vap4DAy2Xdx6Uqd3yV3NDEPDodJHwXQ/S08b7dqrVYjAVHgcSmSu2Llq4ZQwLn0sERsRmRfmixIuxs72wKiPgm+Kk85frMwvivk3DjqArRgrwcRbCd4O+9Xn8C5QAO/sQokcu9lxZ+mXC9sj232kGSw+6TlE24hBO63+P7x1WdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTGl9aj6; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTGl9aj6"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a9b3cd75e5so550091985a.0
        for <iwd@lists.linux.dev>; Tue, 24 Sep 2024 05:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727179496; x=1727784296; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EJo5gxtRrPtF/Pc3AD1/CwaBVPj8+nPLub6e463m9g0=;
        b=iTGl9aj6W7830LR3yyNZtJd0rh6+vs8r4ZgtTzN/N6dMH/vSrMhQID1l3jI6gxg6+B
         n3Z1hHErLLC8tMKeTM5wUp5xe2i0ojzKv55YWCqzlp08X8bfFz+A6kVR+KZfa/Sp4St6
         W6c1lUF7SGbhAiZgme6Qqy05QbyeGiX556h+WeBUux1eB7rwAkjioSkUUYucGN2rvjEm
         ZN9HaGlpXPQBOqr37A/GObc2pNNFs9Yhu5BqyZt7r7tLkCF89GG96kZCN7jrnvasKrD2
         cMbRmvTPP7GhsOjdmg9uFIOG8hI1lPsWg9TM0dP/HoE30oAzWQBPf0s9ACK6jBXaNKmP
         SQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727179496; x=1727784296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EJo5gxtRrPtF/Pc3AD1/CwaBVPj8+nPLub6e463m9g0=;
        b=jbqEBLuWwJp5XJtag5yqfdQ4EMMq4dUiiMhDCf4jHjhNMN/cwwQ65+hdh8HFqJ5lFI
         +jVk8LOOqal8AozbDgf5SH0hSHqaUcqc9blNPNQ+nYEsAgQU4Na3y/H6YHvotaAIIShs
         Sv7DaXQZ6WzL+vK6LsgdL59fGCjRBgTNf/yANpVOfnL/8Lu/mh25cPv/KyUqJzw6kYqi
         o7Q5Z0/vrxMqLTNepVVO3EW4IZZtGybw+YX1itDolZaPvLGvAiNDBjQMDMWGe9rJlpw0
         A964dhwUvcBVx3OZ5iKMUrM63LwopcX3jaO7h0ljXZE0PHq5RX2nNsJSRip7nUJXr17V
         OGEA==
X-Gm-Message-State: AOJu0YxrrvHiYvGLLXTOl4D6gQPV/3+VSTd7N7vtu6raV9UKsilXb/9N
	DvfTSFgU8yZBB8JQLXNDOMpc3x2rO7YOj5mY4Hd68UXxNLlyyo1T4xbctg==
X-Google-Smtp-Source: AGHT+IGKQ++MqAz41sUWYfYi18S8QC01TFQ7sjKHit9tu5fPFfyJDGPeERHUY0PqjpXxt9Qc2YOxrA==
X-Received: by 2002:a05:6214:3d9a:b0:6c5:bc97:3498 with SMTP id 6a1803df08f44-6c7bd5b7f0emr193729266d6.45.1727179496051;
        Tue, 24 Sep 2024 05:04:56 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb0f4a6178sm5948056d6.7.2024.09.24.05.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 05:04:55 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 01/16] ie: add IE_AKM_IS_PSK
Date: Tue, 24 Sep 2024 05:04:32 -0700
Message-Id: <20240924120447.251761-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/ie.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/ie.h b/src/ie.h
index 4498785a..28931a01 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -399,6 +399,15 @@ static inline bool IE_AKM_IS_8021X(uint32_t akm)
 			IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384);
 }
 
+static inline bool IE_AKM_IS_PSK(uint32_t akm)
+{
+	return akm & (IE_RSN_AKM_SUITE_PSK |
+			IE_RSN_AKM_SUITE_FT_USING_PSK |
+			IE_RSN_AKM_SUITE_PSK_SHA256 |
+			IE_RSN_AKM_SUITE_SAE_SHA256 |
+			IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256);
+}
+
 static inline bool IE_CIPHER_IS_GCMP_CCMP(uint32_t cipher_suite)
 {
 	return cipher_suite & (IE_RSN_CIPHER_SUITE_CCMP |
-- 
2.34.1

