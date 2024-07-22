Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B72B16FF48
	for <iwd@lists.linux.dev>; Mon, 22 Jul 2024 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721672981; cv=none; b=dWfRBVyw306SfAbXc3a17Quf5kvsBPWQNa2yRR0gV3LGQQ2p0GytVG1ZuUapCoHqF/obLY361ashT/AJwSdPiXQZqIep9KPAvBedj6yHGVsmlv1Ol07PvdyRqH84vnFMfA0ngUrYwo7RljRNYwAxIaREyFWjOKZVDRg0/W7x9nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721672981; c=relaxed/simple;
	bh=mCt6Xtmel1g2crR4xVoXnJOIqgOGjh07XWdEPK1P49E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EocPj5tqDjYeJHYQhSNl597eBGbzaqrIE0jtwS9vnMQd3+qkIoWweCFCZ5c+jEmhaDENeoSEs89UiInyHpjzjSeWFA2jyovsQqZFkFamIy2Ij39viPUziD8gHech+eQNaSb4L14S/YmRd909nuAO4+NyozYW4GTxcxW4k0tp72Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Alu1RiD0; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Alu1RiD0"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7163489149eso3547963a12.1
        for <iwd@lists.linux.dev>; Mon, 22 Jul 2024 11:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721672979; x=1722277779; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cgZmPeKwEp2fof8B0EwCkazZEK5jk3BKEv55QGJ6d0=;
        b=Alu1RiD0MlTp9mZovgecOrxB3ldPVciGHVBUsByC0FmPHmXG3hDzMKFvieOPvJ0/lc
         1CvDOhv0qlVvOliiDdBNWothY6ldwIYnDTikPPYkv3MomxrsZuAHMHQVXcuXn7AWBR1k
         41KKpwpDDQx/Uv6UvTthbD9S5oZIxC/HLHL52s9WIqWKRoSS8uxXXv+HmROiJqPbBgVf
         vcuYD0aphimsWx+JlzVH3ItH8yEaFPW9E+SL3VCZAQTm+RCrUpabu6hjKWOSAkrndKI/
         qpFjBXNYs9Nl1TTwkdWRX3+iKsLKo3L+VXqxWhgvG7Iq7/zFczeueycJQNCwhWvOYoCV
         17tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721672979; x=1722277779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cgZmPeKwEp2fof8B0EwCkazZEK5jk3BKEv55QGJ6d0=;
        b=NRykzWm8HiKPbQkrXQEk4cdzz651qox+3o696ggtvsu1iWnQJ6CBA5sifLiGsGjtxD
         IKfMdfqQV1Yv5cmrzyWp8gD80mjumXuhlQRrz2ziYQgU2J7Ao0XHNFYzKKaFRDta5lSK
         aVgw8lekOTDlbs2A3S9lPL+T8bFjYGZ8+cvTXA3cU04bGhab6o/yuh6Ixz8W77BsGl1F
         MSO6zuC+MD5/uGPB5KgPen44Gg4d5Ai/k3TxUI3Dz6Rs12asD/yFNc32BFCvtkAFgJyb
         caE9L6NMMMjEAZBZJp3R9nOKxjVkPLgneiHY29eEZpfuHyFPMhsQX70DfXbpnf47qmhz
         0sCg==
X-Gm-Message-State: AOJu0YwG0zuannPeSjzQUmWCA3yPS4xU0mMMZToH6BX1fPFknPgkBr6Q
	dJVHg7As0E6yKLjt1c8mjLbkPPPz6JdovFE7lnnRwtvnfGSoYLppPAkF2w==
X-Google-Smtp-Source: AGHT+IEa7ym4GZpU12BxEche2vLV1fMjVlSaWt262UOOMuDzTA2fWHCGm+YvZZC27j8nt5NTohDcNw==
X-Received: by 2002:a05:6a21:9986:b0:1be:ca24:9647 with SMTP id adf61e73a8af0-1c4285b75c4mr9861986637.8.1721672979427;
        Mon, 22 Jul 2024 11:29:39 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd8dff753bsm33622625ad.243.2024.07.22.11.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 11:29:38 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 5/5] auto-t: fix several DPP tests after station state changes
Date: Mon, 22 Jul 2024 11:29:32 -0700
Message-Id: <20240722182932.4091008-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722182932.4091008-1-prestwoj@gmail.com>
References: <20240722182932.4091008-1-prestwoj@gmail.com>
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

