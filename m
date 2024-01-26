Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2002260B
	for <iwd@lists.linux.dev>; Fri, 26 Jan 2024 20:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706300573; cv=none; b=rPjvoh2PRyoQRby/7gEQDnGRiPRVR+VbCYrCjAdtO0ABK/nOklBStbrT8bovQvC3bBNSr5OeaEC3RlDE2kN4/pTrCY5Mmya9DRm8obdZOE+v3Td+YfyaHSJIFaXC8XQ685EZXW/EasO/WEXAwGyOkTwIauWNhmBWqgM6wN16qrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706300573; c=relaxed/simple;
	bh=qVUe8BPZnq+dT6elRok0k5v/vnyX0lzsZGhFvdSGGcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pFmFw/+YaGwLP8mpKOIYB//yZ7rFly0Etn8dolqoTtw0unHr7oLWf1fOqlhG825gALzZrfAvFFCM/pfZAot2GYOcJpDx5OzYjcd8eyTD3HYEmIK4a/aPO00AHqb1MbR36xZz3+VkfMjOuZ/HA9rYZr07iOl27hJS3C7Ia8T4GkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmnTQ909; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmnTQ909"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4299f424e55so3930911cf.1
        for <iwd@lists.linux.dev>; Fri, 26 Jan 2024 12:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706300571; x=1706905371; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjhxB13PubYFTi/ivDF1ihuXnkM9cVlu0OUeGQW96W8=;
        b=nmnTQ909yEJvfuMnLBorgAt52wmGYbpdRmKJNyHeNOvyLE2Kye9bt9rKY4kHUhwfeD
         wAxFSgjJybEYuCFOqbVyvvZ9gafXn08WbEqTJTU04xHuV4P1kDW9Y/P9mdeHYpD2U5SV
         ktdpZ1bYWQ/5ZPgRqgJhP0+Q5A/sTNGtUFbT1dVzEuW4A7PxKF86Lul5M/NQftsOVeHL
         n0bf9jPC1JhwzoAaLlTfK6Q0p4pC75y4iKrSgqru2dX1SoHvWmWibktxSw396y5F5MuY
         ynaLER5BPeBXhhTkzKR2gEgZJimxa9w73WGvQQo7tbt5jI20+JXPRyffOpZP3fvjveTx
         8m9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706300571; x=1706905371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjhxB13PubYFTi/ivDF1ihuXnkM9cVlu0OUeGQW96W8=;
        b=OLzOiF+8L8EG+kX37MBFmeU+m+Dvyw1vHQJ9qj5nwzKVtT4naj2cQ2SEeN0GWw2cOQ
         5GfhMdVZn3vWlXGImKBzlfifkov0IoDARiUREdtjNStvIx4f6jMf2Plw+3s0KfNATGvq
         2P2+Fpsq/w9MkqqkRz6cr4sft7fRcCuGENRsYDwtbHXxlYhVs/cgdnQeuh10rweaTTtk
         Y4jm925Aod9smDK9DsjN1eksy0oxyiGg5Dq5r5bV2z9hhRRcqHZiCmgi9hwfl7Vpm7Rk
         rLwhhN0Fr6HYpq8iydR20LhzFT83Or+8iu5JHMwbLXhUb4bYRlXDVRylMKU0M0mwiSeG
         /ZAQ==
X-Gm-Message-State: AOJu0YyYWCQym48cmOGx5oeGPjfLNYbjmFq3XJEF+C4n49PIVrBKIbRS
	83kCs4AG4iTxLvPPAqQRVKQf9b2lneyVPc1nOCWk1T8G51nonusH25enwXdjgEE=
X-Google-Smtp-Source: AGHT+IEfd04Y9WKoV49chnmX0kyTJPTHfgg7zuNnz8ACPdasIF7xwXaITaU6+ccLLudcF0DY7dkwjQ==
X-Received: by 2002:a05:622a:1b26:b0:42a:205a:fdeb with SMTP id bb38-20020a05622a1b2600b0042a205afdebmr378591qtb.85.1706300570743;
        Fri, 26 Jan 2024 12:22:50 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id fe3-20020a05622a4d4300b0042a25f3950esm826463qtb.75.2024.01.26.12.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 12:22:50 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 4/4] auto-t: add test for known frequency sorting/maximum
Date: Fri, 26 Jan 2024 12:22:43 -0800
Message-Id: <20240126202243.91947-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126202243.91947-1-prestwoj@gmail.com>
References: <20240126202243.91947-1-prestwoj@gmail.com>
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

