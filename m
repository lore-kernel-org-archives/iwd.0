Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2EA1A3AB7
	for <iwd@lists.linux.dev>; Tue, 24 Sep 2024 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179517; cv=none; b=pgSnuop/xqmEHFNcs+r411+oPS3u9K88lg31et4R/O8q2L7wKNeRUA+9b2fKfWF0HWttCgjLVWYm18WTfpGC1cg5fJDEXSi1vlS4fi3ZjhdsyiKUx+PK+Vb+0qkhQI8yb9OT9COXIz/OYRaKzqHeHJnL6Y1xWOfQ14tYuT6OO9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179517; c=relaxed/simple;
	bh=osg9DviIC5Z0rbnSVMr5v4fmRBpfZcIg9/+qSJY/fp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MOKj1OZbwzYUgcbfF1ZI5H9JXrEOS6Q69bpnE5lzqGnaIvefhdP3u0K99qjjZp4vJ3www2MY6V26gb6YizdGP7RTXpE4vlDQPTOraEN3PsZIeHEVYYkVDBHHgbCxFBxh5nB/P3gphp0GCWJmH3MuuVwdmW4vSYSmVBRganoLuCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMUilmUC; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMUilmUC"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a9a30a045cso517418385a.2
        for <iwd@lists.linux.dev>; Tue, 24 Sep 2024 05:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727179515; x=1727784315; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KwLQ8lGs2AMHlshY9fQ1ypZampfp5fCrE1DHaIDeog=;
        b=gMUilmUCahFDwKnx+Q+eC1MqTyRNMWjcjRRuK0Rtco0A729ditvvwV5j8er4fCNFwk
         257Red16A0mqO6uNHr+nkv0nNHd9yI07QqG4M3UpO1AyUlHc38JXr0hZNom0NPnscF5b
         4M5gPQUXT+Dcbgbh4addwZJJFLzcy5FdrAnKPuSwuqbMSd8scKspdK2vEvqGnPFELgyT
         pa2CQGZIwXKzkg/0UK7d2EScP5nByt0GhgzdbTW9uBtlqEk6HwqRSin0fr5DpBhWTyrM
         6BLMTpn3iuqray4Qc56EwyEIMH3EUSf8MIqGzXAMXDVsXXZJKd+aLzLVjgiTjbSF5ZKw
         wB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727179515; x=1727784315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KwLQ8lGs2AMHlshY9fQ1ypZampfp5fCrE1DHaIDeog=;
        b=p/WA39Qta3hGk7Z1bMjPk5dde89W01HtOfqLNZ1UrrSqkfg8yzYviIgo2tnbvoI6w7
         j3KobMTTUkhCH5yzO07UZpNtE4nPw1ZvFTeLOVp6ErdJkjGlQWuU9akWBs/NBe/+L/ho
         7CrU7WvweCiH20HQrS/8/LwokQV1RsXJwQKcQDwHJh4x4xD/AlZkSO5knReIX/VcjZUy
         wxzBICjdE2HbyK/jWQB/rHLzp42Z7mU2DbJUZ4Po2mWxehss/xyXj1TT/z0+z02pY9at
         IFzIQ5tRv9M1q2j6wT92fbN72RoAWt5LR9NkVDJYpjqYCbhiKv7FZaLS7KPQfzREfDH2
         UimA==
X-Gm-Message-State: AOJu0Yybmy/MakXMEafWhmx/DOcwWq/wiwf7Hlhy8J8O52tOI5s1M1sd
	TUrIwSKRRO3xNTaTIs0tZd+oJj+HlsXasPJpqFlWgCGI5lHYH8NaZaxWag==
X-Google-Smtp-Source: AGHT+IEd51YjkmscShfZlfAFVsIkLXW+w7xMW2AnKD2EQCZoqp9d6/Lfsz7tEGYBhyS0xvePaY16nw==
X-Received: by 2002:a05:6214:540e:b0:6c9:e8f8:4a71 with SMTP id 6a1803df08f44-6c9e8f84a91mr51068926d6.51.1727179514929;
        Tue, 24 Sep 2024 05:05:14 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb0f4a6178sm5948056d6.7.2024.09.24.05.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 05:05:14 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 15/16] auto-t: update PKEX test to use DeviceProvisioningAgent
Date: Tue, 24 Sep 2024 05:04:46 -0700
Message-Id: <20240924120447.251761-15-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240924120447.251761-1-prestwoj@gmail.com>
References: <20240924120447.251761-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This also removes the unused import of the old SharedCodeAgent
object from the state change test
---
 autotests/testDPP/pkex_test.py         | 7 ++++---
 autotests/testDPP/state_change_test.py | 8 +-------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/autotests/testDPP/pkex_test.py b/autotests/testDPP/pkex_test.py
index a651c6f6..62172785 100644
--- a/autotests/testDPP/pkex_test.py
+++ b/autotests/testDPP/pkex_test.py
@@ -4,7 +4,7 @@ import unittest
 import sys
 
 sys.path.append('../util')
-from iwd import IWD, SharedCodeAgent, DeviceState
+from iwd import IWD, DeviceProvisioningAgent, DeviceState
 from iwd import DeviceProvisioning
 from wpas import Wpas
 from hostapd import HostapdCLI
@@ -37,9 +37,10 @@ class Test(unittest.TestCase):
         self.wd.wait_for_object_condition(device, condition)
 
         if agent:
-            self.agent = SharedCodeAgent(codes = {"test": "secret123"})
+            agent = DeviceProvisioningAgent(codes = {"test": "secret123"})
+            self.wd.register_dpp_agent(agent)
 
-            device.dpp_pkex_start_configurator(self.agent.path)
+            device.dpp_pkex_start_configurator()
         else:
             device.dpp_pkex_configure_enrollee('secret123', identifier="test")
 
diff --git a/autotests/testDPP/state_change_test.py b/autotests/testDPP/state_change_test.py
index d52f2b12..f1ac7d5e 100644
--- a/autotests/testDPP/state_change_test.py
+++ b/autotests/testDPP/state_change_test.py
@@ -4,14 +4,8 @@ import unittest
 import sys
 
 sys.path.append('../util')
-from iwd import IWD, SharedCodeAgent, DeviceState
-from iwd import DeviceProvisioning
-from wpas import Wpas
+from iwd import IWD
 from hostapd import HostapdCLI
-from hwsim import Hwsim
-from config import ctx
-from time import time
-import os
 
 class Test(unittest.TestCase):
     def auto_connect(self):
-- 
2.34.1

