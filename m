Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D5815AD9C
	for <iwd@lists.linux.dev>; Wed, 24 Jul 2024 15:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721836015; cv=none; b=hvzo71YEJO8Q8rl8QxTXLpCW22WYbmD/y2OWAqTn3eduvbhukm8FeVVIMRNH86uwnnnF60FR77Xizo6WifK81IUwR8ESw796zm+nQgNBnhF/jjt8g1nwksVpJy5dPypw4QEJ1g6KZHSs4lChhcUswFqvpZEww5f9234Z/ldeWrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721836015; c=relaxed/simple;
	bh=mCt6Xtmel1g2crR4xVoXnJOIqgOGjh07XWdEPK1P49E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NfA7343O9VRFBaJLt85RholJa638/pghIzf9qZX0Ud/foUCATwsEvpSGuxQrfxVVuiev2YMVN19Mb8yHxsM6Z7bToQSMZPeM9aIrP1TDzyTrQxnOPCpiA5OJoOzqkTdBU2DKPsT4XaslzBgqEdHumpubjYioLHaBJWh4u/uUp6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGxg3+fu; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGxg3+fu"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7044c085338so3884977a34.2
        for <iwd@lists.linux.dev>; Wed, 24 Jul 2024 08:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721836013; x=1722440813; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cgZmPeKwEp2fof8B0EwCkazZEK5jk3BKEv55QGJ6d0=;
        b=gGxg3+fuxDuxmVcXxUrbQUipl8b9jXotUtoOXNkI82rQFGWKcM77RlZKe2yuie5+JX
         VuRwd0CWzpghHCwfqfldfiXI7wcVTUORp9qxniI1YSBTLIM35nQpA/x8+HRQ5RUq8kw6
         ie0dlGZbw7npiSfi5uSSLiG+mxHwPtfnnYg0o3NOZ4SF6WwGTXZw/usdONEANEvGsg+T
         kerEHvj3t/hMwdxpiTvAfAMRGO/f4tkLQOAQDEJzP9b9dMy3fS+THwgM4YVsV3LT5sjR
         bEk4NVWlhSQ+PXUfOVqHJIS7iHxVinJq9YI3uMpcU2/GmERBc5KRecXEk0m+AmQSmir6
         IL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721836013; x=1722440813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cgZmPeKwEp2fof8B0EwCkazZEK5jk3BKEv55QGJ6d0=;
        b=imZXxbbvXR5YOq/7Y3RAB4y/sahIAl0esoLwlgwO+Sfo9Jk/dBJ9oRkwceAq8OkQ86
         G20X+pfcv6m+VWKw+5bvHFaI1qm1ZtA6lIrXSa290W2Z5cUw0teTAMgTF0yEU0Yx9oN5
         jKmOZzTDLzUzurWnHDyp9XUqhgmbjX6bBDdzUpnC1fGScECQhiCPBKZLSBHmGwlrKMyT
         7zd8uW0NI+3fskZvUEqh9Zgsol5z5FMrUepuxEaPQZdGtZKadrewvO3vB8a4mvtO7q7m
         eT2mzKYRPfOUxOBEKg8YIPwqmkXGyfoJJ0BnCmnA76qrv6LnO8UH8JODvJlBml8LknBQ
         /yPw==
X-Gm-Message-State: AOJu0YxnRuPIpODZLMXsTPhkn+xNVyUa+4ZzoXLgK3HPQ3K2NPhx8G2a
	oXYQg8TwzJkHXiviIucKX4s1d/o6VA4KCInCrPmid9gJCrPQ/b/t1zVnRA==
X-Google-Smtp-Source: AGHT+IE7s9g0JcF0etlXK/1tRqj3b+veRn6EH4N/q4Ih+KnVPHYfObZBlYWXxZ1rvnuB6gRI3QWyDg==
X-Received: by 2002:a05:6359:4582:b0:1ac:f00b:8d5c with SMTP id e5c5f4694b2df-1acf889286emr36844655d.8.1721836012722;
        Wed, 24 Jul 2024 08:46:52 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a199013905sm589001485a.67.2024.07.24.08.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 08:46:52 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 5/5] auto-t: fix several DPP tests after station state changes
Date: Wed, 24 Jul 2024 08:46:41 -0700
Message-Id: <20240724154641.1461593-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724154641.1461593-1-prestwoj@gmail.com>
References: <20240724154641.1461593-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the station state changes in DPP setting autoconnect=True was
causing DPP to stop prior to being able to scan for the network.
Instead we can start autoconnect earlier so we aren't toggling the
property while DPP is running.
---
 autotests/testDPP/connection_test.py |  6 ++----
 autotests/testDPP/pkex_test.py       | 15 ++++++---------
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/autotests/testDPP/connection_test.py b/autotests/testDPP/connection_test.py
index f72a412d..e4f07af7 100644
--- a/autotests/testDPP/connection_test.py
+++ b/autotests/testDPP/connection_test.py
@@ -38,20 +38,18 @@ class Test(unittest.TestCase):
 
     def test_iwd_as_enrollee_scan_after(self):
         self.wpas.disconnect()
+        self.device.autoconnect = True
         uri = self.device.dpp_start_enrollee()
 
         self.wpas.dpp_configurator_create(uri)
         self.wpas.dpp_configurator_start('ssidCCMP', 'secret123')
 
-        self.hapd.reload()
-
         with self.assertRaises(Exception):
             self.device.get_ordered_network('ssidCCMP', scan_if_needed=False)
 
+        self.hapd.reload()
         self.hapd.wait_for_event('AP-ENABLED')
 
-        self.device.autoconnect = True
-
         condition = 'obj.state == DeviceState.connected'
         self.wd.wait_for_object_condition(self.device, condition)
 
diff --git a/autotests/testDPP/pkex_test.py b/autotests/testDPP/pkex_test.py
index 3d3ea6d1..a651c6f6 100644
--- a/autotests/testDPP/pkex_test.py
+++ b/autotests/testDPP/pkex_test.py
@@ -160,10 +160,8 @@ class Test(unittest.TestCase):
 
     def test_pkex_iwd_to_iwd(self):
         self.start_iwd_pkex_configurator(self.device[0])
-
-        self.device[1].dpp_pkex_enroll('secret123', identifier="test")
-
         self.device[1].autoconnect = True
+        self.device[1].dpp_pkex_enroll('secret123', identifier="test")
 
         condition = 'obj.state == DeviceState.connected'
         self.wd.wait_for_object_condition(self.device[1], condition)
@@ -176,10 +174,8 @@ class Test(unittest.TestCase):
 
     def test_pkex_configurator_with_agent(self):
         self.start_iwd_pkex_configurator(self.device[0], agent=True)
-
-        self.device[1].dpp_pkex_enroll('secret123', identifier="test")
-
         self.device[1].autoconnect = True
+        self.device[1].dpp_pkex_enroll('secret123', identifier="test")
 
         condition = 'obj.state == DeviceState.connected'
         self.wd.wait_for_object_condition(self.device[1], condition)
@@ -198,8 +194,8 @@ class Test(unittest.TestCase):
 
         self.start_iwd_pkex_configurator(self.device[0])
 
-        self.device[1].dpp_pkex_enroll('secret123', identifier="test")
         self.device[1].autoconnect = False
+        self.device[1].dpp_pkex_enroll('secret123', identifier="test")
 
         condition = 'obj.state == DeviceState.connected'
         self.wd.wait_for_object_condition(self.device[1], condition)
@@ -240,8 +236,9 @@ class Test(unittest.TestCase):
 
         self.start_iwd_pkex_configurator(self.device[0], profile='ssidHidden.psk')
 
-        self.device[1].dpp_pkex_enroll('secret123', identifier="test")
         self.device[1].autoconnect = False
+        self.device[1].dpp_pkex_enroll('secret123', identifier="test")
+
 
         condition = 'obj.state == DeviceState.connected'
         self.wd.wait_for_object_condition(self.device[1], condition)
@@ -257,8 +254,8 @@ class Test(unittest.TestCase):
         self.hapd_hidden.wait_for_event('AP-ENABLED')
         self.start_iwd_pkex_configurator(self.device[0], profile='ssidHidden.psk')
 
-        self.device[1].dpp_pkex_enroll('secret123', identifier="test")
         self.device[1].autoconnect = False
+        self.device[1].dpp_pkex_enroll('secret123', identifier="test")
 
         condition = 'obj.state == DeviceState.connected'
         self.wd.wait_for_object_condition(self.device[1], condition)
-- 
2.34.1

