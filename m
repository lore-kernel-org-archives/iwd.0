Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE49D1C6AE
	for <iwd@lists.linux.dev>; Wed,  3 Jan 2024 18:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jY2Dh1wZ"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78109a21144so870041785a.0
        for <iwd@lists.linux.dev>; Wed, 03 Jan 2024 10:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704307621; x=1704912421; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClWw0PW0rEcg5naiCSnI54wGpoVumWsibWgdEU3XJqA=;
        b=jY2Dh1wZBQh04Z9gsXoovCueiFfxygVxpGF+HV/PStbm6Fu8pBgKmPzmD3KZe/7pdT
         lsAld2YRlL+Uh/1wqb2P+72LMosvfV30aCg8xeEE+JfCRmtH5TkONXX0+/Kh2I6/L1GG
         IWD0pta06mftQuDUqmjDVk6FJSBrY1+2Q3MDO+AQOsmOfovG+3TNpiaSEX/jxG1sNSeq
         Rwk4r6wBMw4iNjIf2eQ7dyNtDwhD9f9W+SFIDL3B6qx4sJhFg2d6Z1K1IButTGZZQYyq
         JgaQicsY8vcEYu+Mp7AfFsO6qyDJHTSzz2JeDsVTW+3QhNl4Oz03fg0IOCuLCVzgHoi8
         oT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704307621; x=1704912421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClWw0PW0rEcg5naiCSnI54wGpoVumWsibWgdEU3XJqA=;
        b=ubxaT3Zrr1ubSd2ZjWu1Hy/iuaiUqUCzmCbXXB6Oq0dDcN0kfHBAU4+UVIkQ0/F1Hd
         7qqiLO4CNLn5y/mbpG7pKsCLrm9LaS3yP1zCzhEFNOevDnetrKRNG+WfmpZRE1ZGVgKc
         IChZiUB1Cl18yzvn8gegIce+5RBLioCEXjCU8r4E0+aCd81Sk2dZQoUvGFc0AcHBUoRE
         bsMYX2Q1Gua4wG3X78HXtIRNB9uxr7t5Q9TXJEXNGekaZkosbhaE/B+vTUMQ9HI0cbib
         rOf+hvHGYccmQPxwY7qeD1THsroTZDxxDsv37xBy4X/7p6sMQjdOV5het4+T3DxoznLi
         nKKg==
X-Gm-Message-State: AOJu0Yxcrr6s6mSrBZxlhTndJ1udvatmNuMf94HbRHazmyi6DQ+BDfGe
	mPKVauPdmbljLKYtSlS9PQFAX0i+wEpugA==
X-Google-Smtp-Source: AGHT+IGXnvSPMEuiv+jNvrQXU5UfAJl1s/flI80pkLzTKx6LK6+eEa+lAGtr78qnohSRNMwglXbeaA==
X-Received: by 2002:a05:620a:2808:b0:781:dd78:5260 with SMTP id f8-20020a05620a280800b00781dd785260mr3074251qkp.138.1704307621561;
        Wed, 03 Jan 2024 10:47:01 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id o21-20020a05620a22d500b00781a147e444sm3693370qki.92.2024.01.03.10.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 10:47:00 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/8] auto-t: update roam test to use new debug events
Date: Wed,  3 Jan 2024 10:46:35 -0800
Message-Id: <20240103184638.533221-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103184638.533221-1-prestwoj@gmail.com>
References: <20240103184638.533221-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/testPSK-roam/failed_roam_test.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/autotests/testPSK-roam/failed_roam_test.py b/autotests/testPSK-roam/failed_roam_test.py
index d42002d4..ccdec2c6 100644
--- a/autotests/testPSK-roam/failed_roam_test.py
+++ b/autotests/testPSK-roam/failed_roam_test.py
@@ -60,7 +60,7 @@ class Test(unittest.TestCase):
         self.rule0.enabled = False
 
         # IWD should then try BSS 2, and succeed
-        device.wait_for_event('ft-roam', timeout=60)
+        device.wait_for_event('ft-roaming', timeout=60)
         self.verify_roam(self.wd, device, self.bss_hostapd[0], self.bss_hostapd[2])
 
         self.bss_hostapd[2].deauthenticate(device.address)
@@ -75,7 +75,7 @@ class Test(unittest.TestCase):
 
         self.connect(self.wd, device, self.bss_hostapd[0])
 
-        device.wait_for_event('ft-roam', timeout=60)
+        device.wait_for_event('ft-roaming', timeout=60)
 
         condition = 'obj.state == DeviceState.disconnected'
         self.wd.wait_for_object_condition(device, condition)
@@ -101,14 +101,14 @@ class Test(unittest.TestCase):
         # IWD should connect, then attempt a roam to BSS 1, which should
         # fail and cause a fallback to reassociation
         device.wait_for_event('ft-fallback-to-reassoc', timeout=60)
-        device.wait_for_event('reassoc-roam', timeout=60)
+        device.wait_for_event('roaming', timeout=60)
 
         self.verify_roam(self.wd, device, self.bss_hostapd[0], self.bss_hostapd[2])
 
         # Trigger another roam
         self.rule_bss2.signal = -8000
 
-        device.wait_for_event('ft-roam', timeout=60)
+        device.wait_for_event('ft-roaming', timeout=60)
 
         # Ensure an FT roam back to a properly configured AP works.
         self.verify_roam(self.wd, device, self.bss_hostapd[2], self.bss_hostapd[1])
@@ -141,7 +141,7 @@ class Test(unittest.TestCase):
         # fail and cause the rank to be re-computed. This should then put
         # bss 1 as the next candidate (since the FT factor is removed)
         device.wait_for_event('ft-fallback-to-reassoc', timeout=60)
-        device.wait_for_event('ft-roam', timeout=60)
+        device.wait_for_event('ft-roaming', timeout=60)
 
         self.verify_roam(self.wd, device, self.bss_hostapd[0], self.bss_hostapd[1])
 
-- 
2.34.1

