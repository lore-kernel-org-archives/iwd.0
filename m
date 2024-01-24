Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B026660BB3
	for <iwd@lists.linux.dev>; Wed, 24 Jan 2024 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706103613; cv=none; b=MBdj003rRbgZBKAVHUZvg2AelZ5+/sb1SmdLnyNfY+y88mcromkCYJvUitejzO+/3FwL7HkmlVVda5ms9aoRzQzuGJfND3/xlirGIuk7zX/wWkTACzoKEFY3JKZHI4AuOMBy7MWgZwE0LH8z7FCFtoaK9VUyMHMMS2WMEwtgLxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706103613; c=relaxed/simple;
	bh=qVUe8BPZnq+dT6elRok0k5v/vnyX0lzsZGhFvdSGGcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kLQx+QU2SET+t4yMKAZoSloPYd55ixpDO04A3pOyPRXJ7c1J92L8yukY0Vyi+M/lQvjGSLiz1cHOa0BrweHW+71BKz6dh77txybWbjnd2aaWPcguhtuDzzdXJWMVIEYEw90C+SenR6Mm7CnwPXHaAy2xojxVp46V8KU447XAGyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rq4Cmk1Q; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rq4Cmk1Q"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5ffd5620247so36703397b3.0
        for <iwd@lists.linux.dev>; Wed, 24 Jan 2024 05:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706103610; x=1706708410; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjhxB13PubYFTi/ivDF1ihuXnkM9cVlu0OUeGQW96W8=;
        b=Rq4Cmk1Q09cNSxy3NOVs/WJlW7ppoPX3yz/1jZkSKzSKjvC15ob5+UQU0sHR79UP6P
         cAm8NVOZ+QP92i1q18amhrXgJtvIHTXQ/Nx6jEwagJUJf2OaCj064nZYuotp/WzhNaMy
         KOYfXyDXbVZ56/AtZ+MFPio3fSnllziIyUawDg0f5Ce+hzBpN2zHsPlaVWxOySZCllI6
         NWsXTeSVRe6DgkeFhLaf4MMT+JSXmRB+LzrkgoKJnoglv5IGZCoU4RNLgUFWCVvCpg4N
         NLxp4IoipRlB6veQzsGUlpFegpND2KKIdq6VIoaPypOwBlw5pQyZqBNTAeacW9VAo1/b
         CVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706103610; x=1706708410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjhxB13PubYFTi/ivDF1ihuXnkM9cVlu0OUeGQW96W8=;
        b=lz7oeQgEXabihnHjw7PuVmrtyu69HTdZ92+veIJ+QRWe690hK5/qRxGyC9RqbGsPfK
         WqJqXluiIcTmEn1gcXCTyfDko4SyFikNlRaPeALAnNL/wYIF/yBpvCgvII0507Dt1fa7
         2AcclkKHk9YCtE2YRaa4c0olnEJqapNejuweaLFLplV03bc+swDMMwXgpCgyC5ZbqfnG
         i20ngQbw/fS63jH1/LCGbJ0g6JI0G2u6S8W/RoFEVsH7KWDESup2vDRe21F1zrAVOCmc
         fwWSElhXYpYxERYzvz8XStpQ4F0dIxklgxET63hKgmVZEoZsb373m4mCw0OS7tY7EKv0
         y52Q==
X-Gm-Message-State: AOJu0YwsmSNIE3uktx83Y0NAXDv34ntNwZ9585wChfLJ6pZ4VXsU3eaL
	DrImkIMBEfKNZyPGAbsTBM86ZxGNHJfT4rBnhkTb5Eb+zmsUtWxzM+dJCrFJpBo=
X-Google-Smtp-Source: AGHT+IGzDLf+908YuqDm4eBohrNfZwgYBQUCTBQZgiHJU0HO8y8cHuXDCCqo+fx7IMBZf+lm+segww==
X-Received: by 2002:a25:84c4:0:b0:dbd:bf0d:d97f with SMTP id x4-20020a2584c4000000b00dbdbf0dd97fmr653063ybm.126.1706103610297;
        Wed, 24 Jan 2024 05:40:10 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id ly4-20020a0562145c0400b0068688a2964asm3470456qvb.113.2024.01.24.05.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 05:40:10 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/4] auto-t: add test for known frequency sorting/maximum
Date: Wed, 24 Jan 2024 05:40:01 -0800
Message-Id: <20240124134001.20453-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124134001.20453-1-prestwoj@gmail.com>
References: <20240124134001.20453-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify the existing frequency test to check that the ordering
lines up with the ranking of the BSS.

Add a test to check that quick scans limit the number of known
frequencies.
---
 autotests/testKnownNetworks/frequency_test.py | 110 ++++++++++++++++--
 autotests/testKnownNetworks/hw.conf           |   1 +
 2 files changed, 102 insertions(+), 9 deletions(-)

diff --git a/autotests/testKnownNetworks/frequency_test.py b/autotests/testKnownNetworks/frequency_test.py
index 83e51c06..c2fd1290 100644
--- a/autotests/testKnownNetworks/frequency_test.py
+++ b/autotests/testKnownNetworks/frequency_test.py
@@ -4,17 +4,15 @@ import unittest
 import sys
 
 sys.path.append('../util')
-import iwd
 from iwd import IWD
 from iwd import PSKAgent
-from iwd import NetworkType
-import testutil
+from hwsim import Hwsim
 import os
 from configparser import ConfigParser
 
 class Test(unittest.TestCase):
     def connect_network(self, wd, device, network):
-        ordered_network = device.get_ordered_network(network)
+        ordered_network = device.get_ordered_network(network, full_scan=True)
 
         condition = 'not obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condition)
@@ -30,7 +28,7 @@ class Test(unittest.TestCase):
         wd.wait_for_object_condition(ordered_network.network_object, condition)
 
     def test_connection_success(self):
-        wd = IWD(True, '/tmp')
+        wd = self.wd
 
         psk_agent = PSKAgent("secret123")
         wd.register_psk_agent(psk_agent)
@@ -38,6 +36,11 @@ class Test(unittest.TestCase):
         devices = wd.list_devices(1)
         device = devices[0]
 
+
+        # Set the signals so that the 2.4GHz ranking will be higher
+        self.ssidccmp_2g_rule.signal = -2000
+        self.ssidccmp_5g_rule.signal = -8000
+
         #
         # Connect to the PSK network, then Hotspot so IWD creates 2 entries in
         # the known frequency file.
@@ -75,8 +78,10 @@ class Test(unittest.TestCase):
         #
         self.assertIsNotNone(psk_freqs)
         self.assertIsNotNone(psk_uuid)
-        self.assertIn('5180', psk_freqs)
-        self.assertIn('2412', psk_freqs)
+
+        # The 2.4GHz frequency should come first, as it was ranked higher
+        self.assertEqual('2412', psk_freqs[0])
+        self.assertEqual('5180', psk_freqs[1])
 
         self.assertIsNotNone(hs20_freqs)
         self.assertIsNotNone(hs20_uuid)
@@ -92,6 +97,10 @@ class Test(unittest.TestCase):
         psk_agent = PSKAgent("secret123")
         wd.register_psk_agent(psk_agent)
 
+        # Now set the signals so that the 5GHz ranking will be higher
+        self.ssidccmp_2g_rule.signal = -8000
+        self.ssidccmp_5g_rule.signal = -2000
+
         #
         # Reconnect, this should generate a completely new UUID since we
         # previously forgot the network.
@@ -120,8 +129,78 @@ class Test(unittest.TestCase):
         self.assertIsNotNone(psk_freqs)
         self.assertIsNotNone(psk_uuid2)
         self.assertNotEqual(psk_uuid, psk_uuid2)
-        self.assertIn('5180', psk_freqs)
-        self.assertIn('2412', psk_freqs)
+        # Now the 5GHz frequency should be first
+        self.assertEqual('5180', psk_freqs[0])
+        self.assertEqual('2412', psk_freqs[1])
+
+    def test_maximum_frequencies(self):
+        psk_agent = PSKAgent("secret123")
+        self.wd.register_psk_agent(psk_agent)
+
+        devices = self.wd.list_devices(1)
+        device = devices[0]
+
+        # Connect and generate a known frequencies file
+        self.connect_network(self.wd, device, 'ssidCCMP')
+
+        self.wd.unregister_psk_agent(psk_agent)
+
+        #
+        # Rewrite the known frequencies file to move the valid network
+        # frequencies to the end, past the maximum for a quick scan
+        #
+        config = ConfigParser()
+        config.read('/tmp/iwd/.known_network.freq')
+        for s in config.sections():
+            if os.path.basename(config[s]['name']) == 'ssidCCMP.psk':
+                config.set(s, 'list', "2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 2484 2412 5180")
+                break
+
+        self.wd.stop()
+
+        with open('/tmp/iwd/.known_network.freq', 'w') as f:
+            config.write(f)
+
+        self.wd = IWD(True)
+
+        devices = self.wd.list_devices(1)
+        device = devices[0]
+
+        device.autoconnect = True
+
+        device.wait_for_event("autoconnect_quick")
+
+        condition = "obj.scanning == True"
+        self.wd.wait_for_object_condition(device, condition)
+
+        condition = "obj.scanning == False"
+        self.wd.wait_for_object_condition(device, condition)
+
+        #
+        # Check that the quick scan didn't return any results
+        #
+        with self.assertRaises(Exception):
+            device.get_ordered_network("ssidCCMP", scan_if_needed=False)
+
+        device.wait_for_event("autoconnect_full")
+
+        condition = "obj.scanning == True"
+        self.wd.wait_for_object_condition(device, condition)
+
+        condition = "obj.scanning == False"
+        self.wd.wait_for_object_condition(device, condition)
+
+        #
+        # The full scan should now see the network
+        #
+        device.get_ordered_network("ssidCCMP", scan_if_needed=False)
+
+    def setUp(self):
+        self.wd = IWD(True)
+
+    def tearDown(self):
+        self.wd.stop()
+        self.wd = None
 
     @classmethod
     def setUpClass(cls):
@@ -129,10 +208,23 @@ class Test(unittest.TestCase):
         conf = '[General]\nDisableANQP=0\n'
         os.system('echo "%s" > /tmp/main.conf' % conf)
 
+        hwsim = Hwsim()
+
+        cls.ssidccmp_2g_rule = hwsim.rules.create()
+        cls.ssidccmp_2g_rule.source = hwsim.get_radio('rad1').addresses[0]
+        cls.ssidccmp_2g_rule.enabled = True
+
+        cls.ssidccmp_5g_rule = hwsim.rules.create()
+        cls.ssidccmp_5g_rule.source = hwsim.get_radio('rad2').addresses[0]
+        cls.ssidccmp_5g_rule.enabled = True
+
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
         os.remove('/tmp/main.conf')
 
+        cls.ssidccmp_2g_rule.remove()
+        cls.ssidccmp_5g_rule.remove()
+
 if __name__ == '__main__':
     unittest.main(exit=True)
diff --git a/autotests/testKnownNetworks/hw.conf b/autotests/testKnownNetworks/hw.conf
index 8a7ef73a..f68b63a5 100644
--- a/autotests/testKnownNetworks/hw.conf
+++ b/autotests/testKnownNetworks/hw.conf
@@ -2,6 +2,7 @@
 num_radios=5
 start_iwd=0
 reg_domain=US
+hwsim_medium=yes
 
 [HOSTAPD]
 rad0=ssidNew.conf
-- 
2.34.1

