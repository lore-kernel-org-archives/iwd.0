Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912AF1EB44
	for <iwd@lists.linux.dev>; Wed,  4 Sep 2024 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462690; cv=none; b=O/Ed4Bve98+DmXcmQ9NqFnkiPm871QVta0BYteQoeGXNvm4E8iXVZzgNMGsoDsHe/Y6jmSaAoB/gyYfBPvNtdN+oIohs+tDuqNU+S3YF7FxNM0lyl1WRIp42pM0ibKgPARdhOZ7JdinsXlRrOJlOJ4oN6QoxsM54vnitIxfkGFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462690; c=relaxed/simple;
	bh=BXW9KZyrojr/YK6r5tMMCzWNJyBA4U5v0KvDNgH3ISA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bIZejWopglp5htNC9lr/Ql8/A/2z7t/6XfUH7rI+tP1WPIco3wrT7nRTogOBHvG0OQAGClqFREqJGylSB+1oehfQigv36Mb4jt/z8otix9bHqrzAmROtUqw+ykaMWn2bB6fhtG8sy65qruU+fhfKrp3sUN4UczrtYt8HTjzVd4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYs/vVeA; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYs/vVeA"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4567587224eso5079401cf.0
        for <iwd@lists.linux.dev>; Wed, 04 Sep 2024 08:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725462687; x=1726067487; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oKDhLdBCaZYRRtFz91lX6BA9IiSUHkIXgkWfyVRzeoc=;
        b=jYs/vVeAjzx4a0PRLN3m0ZCCfH9qiYCxM69sVKIh+rqrz6n7XuxH3VZzanuOkV9ms3
         hzv+zN7Tcg0f+LA+AJw5AsX344oscT6r3wiZZuY5OQQeksmjMQr+MqeSYT16NraS/Af/
         TjhMYRocS4vDmtUP81Xrddnnae2+KbCBks3gBa0gHtN2UEzolxSR/E+tPdR0BL7EdbDY
         sWMujWUHA31E9ZZXTLT2hW13TWzneNi3a0OmTSjPiFusUMIAUIeybVApNd0mnajPMp3P
         EZhLw0eLwIGuku5soxStbFJ57HhCxUMDVsTiwCuq6I7Ydo9h3Lbi9emWgvq5ufzoTL0i
         Wtrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725462687; x=1726067487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oKDhLdBCaZYRRtFz91lX6BA9IiSUHkIXgkWfyVRzeoc=;
        b=p1Ub+a8iTVyz6uEQjqZ6iE5jOCQeWE7t0sYtTGN/G1706+zupQ22t/uf73a4Cb+oaK
         SwqNF2f44uop/BzRQdNey6hhFT+XIaO3+eAerwGppzWBHKR12OHY4onjeGC0+CMnbtA8
         CC0dZxBCOoXU45Un20IB0LTgF+E3FJkNfDG1wwuW1D6MZkI5CwtqCDBzW0P3J/2LZqve
         lti1sXAI7/QtuEZYWrBJEs516h51kuc/veSal3OtLz/dQJPZ7i3O6zPTP3MPz3Um1tvG
         3Lr8tJoDT3OvMKxsy7UdJVTupHwuUyj4WzyrIPGxnz8g3yLGX1XHo+UhuVW3oxDPEna6
         LNtQ==
X-Gm-Message-State: AOJu0YysMhUbGFe8iCjVCIHbjTu3boC8fCwewBP7xKp8l/akh9QFFdxU
	r2sOrilpQfP67vXvIeVnvp5IhE476QEDFMP0wvO8M3eEEMRXcT45hGpLIg==
X-Google-Smtp-Source: AGHT+IEbM3NvNdHpq2RO5dKYt5P2RmKGd1AmUFg4w2J5YgF0L/Z4RHY8jhM0cvge30awpUx6KaqSfA==
X-Received: by 2002:a05:622a:2605:b0:456:8832:562d with SMTP id d75a77b69052e-45688325768mr218273281cf.60.1725462687094;
        Wed, 04 Sep 2024 08:11:27 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682c82771sm59216051cf.15.2024.09.04.08.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:11:26 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] monitor: fix build with INGRESS/EGRESS definitions
Date: Wed,  4 Sep 2024 08:11:22 -0700
Message-Id: <20240904151122.298818-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These new values are undefined on older kernels (e.g. 5.15)
---
 monitor/nlmon.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index f365b36f..66df08a4 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -48,6 +48,14 @@
 #define ARPHRD_NETLINK	824
 #endif
 
+#ifndef RMNET_FLAGS_INGRESS_MAP_CKSUMV5
+#define RMNET_FLAGS_INGRESS_MAP_CKSUMV5 (1U << 4)
+#endif
+
+#ifndef RMNET_FLAGS_EGRESS_MAP_CKSUMV5
+#define RMNET_FLAGS_EGRESS_MAP_CKSUMV5 (1U << 5)
+#endif
+
 #include "linux/nl80211.h"
 
 #include "ell/useful.h"
-- 
2.34.1

