Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D4725E473
	for <iwd@lists.linux.dev>; Thu, 27 Feb 2025 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740669854; cv=none; b=SjJ/64xTlc2cQiCyHO1dXoxcIBTPwzmRP/tRy0ksnIk0xF6+PK7Rgbp+CfR/UstsJ1RrjciZr8iUsj+4ZbTZH+sVDKWTKiYymZCaDDs2eRJkzPexP+66WQ4XQ8wogPJ9mLDQB2mq4U7h0IZ9y75EYLHEx12Rb/vO8krnL836hUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740669854; c=relaxed/simple;
	bh=O99rr/QJDQpXB+43bqjj32as5UAmEimjrrS31pyv018=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nK29Yu+6/OeMB0FYj8pUi8MVxiySIUUv0JoSddo2uBjl7JdEPYO20FKgusIMjWMRhtHEo3xRSvcAuaWqxbeuPT/rWXxaZvX5A+6dQTVjhVjtrZ3QRyANLAQalow1Me15CmxwSg7+dYRro7I0KqbYxL87pwQ2lGvpYAkLEekUL/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYKcWPu+; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYKcWPu+"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c24ae82de4so99344685a.1
        for <iwd@lists.linux.dev>; Thu, 27 Feb 2025 07:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740669852; x=1741274652; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zwwos29k9v3nhBqtGHV5idZUmLy+d37X54Au8BWgH1w=;
        b=JYKcWPu+CMuOF9yy8VAnBajzRZ2BhZHN6cdDjvTa9RIgyDXb40ohmmSOgZt4sFffii
         bls2higWPdfhQRGfGD26K1JDnbwUuh/f3gq/b0ZPED4jpMbncNX7gBmu9WmyMVUfyH5x
         VuFvr72GK4FbroUOxNp2fke+Q9n+iyb5pDoROFCZT+Olj0qyTd4PqvPh3awM6+2CYm/B
         TFKTAKsqwDas/3JTfbSHVK9/J0+YZoTSfGU5F/34ScN/9MeauNsaVClsaipLtGi+UYjQ
         eEI7jO3/XVMqGqRYY8Lr8z9WC2k3G4QQyt6wqjrvL4UGnx4ZHfdJClvkIc+dqMQNq+yO
         AXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740669852; x=1741274652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zwwos29k9v3nhBqtGHV5idZUmLy+d37X54Au8BWgH1w=;
        b=aZH4B0CwOgmF+GUJErEyboPcTE1oBBfVV1uIHFms5QmCJwG05be38ja+tYzsjLRKM7
         A6cJH7GSLXNDYWIHIKagZUcw6uhEUUZIFjv/kVB1f1SL4HF1VCodsJ0B0PbRjkGlbumX
         mrUPOysMR+qYpH5nzsfzBZt/piZpuKQVcPdzbGiwzXYUhOWxzZvMzZBUbp2lY7EX9zEZ
         B7+cWRX6C+agGjXLqYjV9OzSgV/msaEd0X0sGglZFPV96b1htNurYk7QAEP5ta2L2AMi
         PJI+eDvvLr2EKBZtWaIiisWgobe7azZTYsSh2TKMp8Gm2xw/NCTJEZLli4RGBzxnJFH9
         ed9g==
X-Gm-Message-State: AOJu0YwNtdXqgCye9b2QIq3YLoOZT8WfWtxehw1FsRXowS9qaC8UuQma
	h3EjUSO+sezBWTcIxNdcKH0wjoHQo/nRiQ1zIBQ7HfHeCMasbIyaMqpS6g==
X-Gm-Gg: ASbGncv+96ahJu80U8555epT9/oVy4K87iIn44Usj+JKZbD20QnfmS+83v9NGkeonXl
	g75kL7m6PJAu3b9syl530CfjF3TYUOxWdUNyoImN30PHmNgw1hshSCa5hEBFEZZkCzMOZwf+Xn0
	YmOkxlgK9dC235hWDcG7AdeX/2muZAAitmIp8yWsox/3nsDVg9ULxYGkLV2OU0rSLR4Y0XOo4Qv
	HoXCGkyAFqiV0zMkBxyEx4YMp0CU90oGWwVmBjE0CTR/FAptKPurffeE7yaWH46t+w2fYhljevk
	VXI7u3Of/YJTub/3zqDy1VTfLiPh4jcrZEic
X-Google-Smtp-Source: AGHT+IGdPVHOPXCoav0fDn6olkxHcK3eUIS+7omaFubNjdfWlM0rMmYqsrx00LAW3k2q43/3r39umw==
X-Received: by 2002:a05:620a:8015:b0:7c0:b523:e1af with SMTP id af79cd13be357-7c0cf95080amr3789795585a.37.1740669852004;
        Thu, 27 Feb 2025 07:24:12 -0800 (PST)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c378daaba9sm116564685a.94.2025.02.27.07.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 07:24:11 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] doc: document how to disable blacklisting
Date: Thu, 27 Feb 2025 07:24:07 -0800
Message-Id: <20250227152407.162387-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/iwd.config.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index 4ba7b4e7..0beb0959 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -290,9 +290,10 @@ control how long a misbehaved BSS spends on the blacklist.
    * - InitialTimeout
      - Values: uint64 value in seconds (default: **60**)
 
-       The initial time that a BSS spends on the blacklist.
+       The initial time that a BSS spends on the blacklist. Setting this to zero
+       will disable blacklisting functionality in IWD.
    * - Multiplier
-     - Values: unsigned int value in seconds (default: **30**)
+     - Values: unsigned int value greater than zero, in seconds (default: **30**)
 
        If the BSS was blacklisted previously and another connection attempt
        has failed after the initial timeout has expired, then the BSS blacklist
-- 
2.34.1

