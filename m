Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DD1264600
	for <iwd@lists.linux.dev>; Tue, 25 Mar 2025 18:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925669; cv=none; b=JGjENW6tyVW/T7RcnVFUUCMYBo9ZVRI65efChd2xZZ0b0A4t39onwftwREf5UIWimycVoQ4LKw5nQKNzMP4cGFPK3PlICH2U9w7ixzTt5T6CRPoBxp+MKRkuvZItJJDBkm+GsP4dHnwXYBNZlh/qwK/DEHfc81j6ikbgcQ6St0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925669; c=relaxed/simple;
	bh=pnbQrt4PtMvHv60jJ0ylzrQ+Yt/DtcEWqPzvwExtjNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SvB2mMsck66aWA+T0AHi1sc18aca8ZvFIz+mKJ45iT8g2ntzB+yJ33xkdIQROSEXK2/svh0W0xB22vKwfSqWHm0g6/gt1k6R2hJPqrVZr0/NXF+4cvIFFhItMkjWb8tHvy6xQCjM2J5QRERDt0EeF7H10OiXtXZpLVfNDMKLGyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDktzRh+; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDktzRh+"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-301493f45aeso9712932a91.1
        for <iwd@lists.linux.dev>; Tue, 25 Mar 2025 11:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742925667; x=1743530467; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Up2jn2cYXg1gvQUCSkIn+PUWJS2DLpMVIl2iP9SCqc=;
        b=MDktzRh+zJ/ndaqwfJKd7r08T2CEo5TJJwy5uzqeSEY0hxTFlt7gFYkA+hQRzNcZIw
         rmhd/6FQtQF27DpDvPTOEGMfiZeqQ6t6d8I8DE8jKr3v1jjhoE5/3kycyU1J0hydiJ4M
         v06WK9Kd8eMkDmz5XwC9up00yu2/RC0+sSPWTSP6u2nO2oTipFoM42aO2hgPnG2C2F01
         lCyOPbaTab+GOj7hFMqGjfuzuG3WPxiK1wHEBQK2WH67X1Sm6aCdeQl3gi0HFhqbKNSv
         JudWY2de33Kb8rMv5onh8YwQOJFgpdZzHn+FXJcTbJ6I8ViijAdTku3eoxnpKbBWyc5d
         ihoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742925667; x=1743530467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Up2jn2cYXg1gvQUCSkIn+PUWJS2DLpMVIl2iP9SCqc=;
        b=cQ7izeBzmfCR+33nxHNfYFIHguW/GertcwxXlkBYvCbyVWQjZRJLcRIDrhJ9aD6GLP
         MN4wnXgzakUB8XzH98Sb/Cq+BYSXLlNh/urMizNoJ2sfrhY8rEa8VzPuoOfqB69Xzcqt
         1UVLLfgLu+wxNgDmvdYe6+hYKTyv5hkeBoOwI/R2Ec6aBfpkkebb83SQ/57fix84DliR
         f24FjALEdRFcaeEm1WrWkvwiga7On9l4t20t00pCYh6M+xPG8cnpb6K2bATkSfR1A9Yt
         DguEWX5VOXbw1diOlmziKfVIAUqIQp8Det7rXeHhEInhvqRR7hRm6ZJ1J9eiWnnsGNNF
         7sIQ==
X-Gm-Message-State: AOJu0Yy07pN7uc4s+zcT4PN52X0rxlqfRoKYIhr696wuCVA0A21VcY8i
	uEjzEor79Vejo5ts94SdV2SSlWr0nE8yAOtUTwH2IpHxcZ90m4+q4y53KA==
X-Gm-Gg: ASbGncvL4JucygO/sBCZw3MjfQqVDHovBPVdzgHGkSpjHFBrqKwBh8abwYq6CQsRXdj
	s6HA06FioN8rdp4vBC0av3GToRAiAAW1gun1RhHzzQLVpxPerTazuZLS26EEMjJcFHNE9vX5Gdr
	L3wyDMafu31CFf7mSYkO190W156CKW57wyX7ELVu/9rjwKYHwIt/8RyzPDr2jmmjrnAMPg6ItTZ
	eYORkTTDg8Ca4hEM7hMKNS1AuYEA3ot17zr5+2Hl4pUu6GmIZixbFD2QSh8Z2tJwQwxsJ4G8v26
	WK0ugq8SOgMXH3+to3C1QjqM5zDu1F5Oq9MU4ccO662R5pz6N+7dnf/NNPoy7ka6PnTn1moTTXZ
	sO9ju+/5yC+q+0Q==
X-Google-Smtp-Source: AGHT+IET4rDJce4huZeQDvORcrX/Z4fWH0dDWU44IMU1MQEF/xX+JEyzCk4RZ6r7mO1+cOurK7ePJg==
X-Received: by 2002:a17:90b:134c:b0:2f2:a664:df20 with SMTP id 98e67ed59e1d1-3030fe6df8amr29970373a91.7.1742925666673;
        Tue, 25 Mar 2025 11:01:06 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811bae9asm93770515ad.138.2025.03.25.11.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 11:01:06 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 09/10] auto-t: add tests for AP roam blacklisting
Date: Tue, 25 Mar 2025 11:00:40 -0700
Message-Id: <20250325180041.238676-9-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250325180041.238676-1-prestwoj@gmail.com>
References: <20250325180041.238676-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/testAPRoam/connection_test.py     |  56 +++---
 autotests/testAPRoam/hw.conf                |   2 +
 autotests/testAPRoam/main.conf.roaming      |   5 +
 autotests/testAPRoam/roam_blacklist_test.py | 183 ++++++++++++++++++++
 4 files changed, 223 insertions(+), 23 deletions(-)
 create mode 100644 autotests/testAPRoam/main.conf.roaming
 create mode 100644 autotests/testAPRoam/roam_blacklist_test.py

diff --git a/autotests/testAPRoam/connection_test.py b/autotests/testAPRoam/connection_test.py
index a419f4aa..1f95fb96 100644
--- a/autotests/testAPRoam/connection_test.py
+++ b/autotests/testAPRoam/connection_test.py
@@ -11,52 +11,58 @@ from iwd import NetworkType
 from hostapd import HostapdCLI
 
 class Test(unittest.TestCase):
-
-    def validate(self, expect_roam=True):
-        wd = IWD()
-
-        devices = wd.list_devices(1)
-        device = devices[0]
-
-        ordered_network = device.get_ordered_network('TestAPRoam')
+    def initial_connection(self):
+        ordered_network = self.device.get_ordered_network('TestAPRoam')
 
         self.assertEqual(ordered_network.type, NetworkType.psk)
 
         condition = 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condition)
+        self.wd.wait_for_object_condition(ordered_network.network_object, condition)
 
-        device.connect_bssid(self.bss_hostapd[0].bssid)
+        self.device.connect_bssid(self.bss_hostapd[0].bssid)
 
         condition = 'obj.state == DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
+        self.wd.wait_for_object_condition(self.device, condition)
 
         self.bss_hostapd[0].wait_for_event('AP-STA-CONNECTED')
 
         self.assertFalse(self.bss_hostapd[1].list_sta())
 
-        self.bss_hostapd[0].send_bss_transition(device.address,
-                [(self.bss_hostapd[1].bssid, '8f0000005102060603000000')],
+    def validate_roam(self, from_bss, to_bss, expect_roam=True):
+        from_bss.send_bss_transition(self.device.address,
+                self.neighbor_list,
                 disassoc_imminent=expect_roam)
 
         if expect_roam:
             from_condition = 'obj.state == DeviceState.roaming'
             to_condition = 'obj.state == DeviceState.connected'
-            wd.wait_for_object_change(device, from_condition, to_condition)
+            self.wd.wait_for_object_change(self.device, from_condition, to_condition)
 
-            self.bss_hostapd[1].wait_for_event('AP-STA-CONNECTED %s' % device.address)
+            to_bss.wait_for_event('AP-STA-CONNECTED %s' % self.device.address)
         else:
-            device.wait_for_event("no-roam-candidates")
-
-        device.disconnect()
-
-        condition = 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condition)
+            self.device.wait_for_event("no-roam-candidates")
 
     def test_disassoc_imminent(self):
-        self.validate(expect_roam=True)
+        self.initial_connection()
+        self.validate_roam(self.bss_hostapd[0], self.bss_hostapd[1])
 
     def test_no_candidates(self):
-        self.validate(expect_roam=False)
+        self.initial_connection()
+        # We now have BSS0 roam blacklisted
+        self.validate_roam(self.bss_hostapd[0], self.bss_hostapd[1])
+        # Try and trigger another roam back, which shouldn't happen since now
+        # both BSS's are roam blacklisted
+        self.validate_roam(self.bss_hostapd[1], self.bss_hostapd[0], expect_roam=False)
+
+    def setUp(self):
+        self.wd = IWD(True)
+
+        devices = self.wd.list_devices(1)
+        self.device = devices[0]
+
+    def tearDown(self):
+        self.wd = None
+        self.device = None
 
     @classmethod
     def setUpClass(cls):
@@ -65,6 +71,10 @@ class Test(unittest.TestCase):
         cls.bss_hostapd = [ HostapdCLI(config='ssid1.conf'),
                             HostapdCLI(config='ssid2.conf'),
                             HostapdCLI(config='ssid3.conf') ]
+        cls.neighbor_list = [
+            (cls.bss_hostapd[0].bssid, "8f0000005101060603000000"),
+            (cls.bss_hostapd[1].bssid, "8f0000005102060603000000"),
+        ]
 
     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testAPRoam/hw.conf b/autotests/testAPRoam/hw.conf
index 00a31063..46b1d4a8 100644
--- a/autotests/testAPRoam/hw.conf
+++ b/autotests/testAPRoam/hw.conf
@@ -1,5 +1,7 @@
 [SETUP]
 num_radios=4
+hwsim_medium=true
+start_iwd=false
 
 [HOSTAPD]
 rad0=ssid1.conf
diff --git a/autotests/testAPRoam/main.conf.roaming b/autotests/testAPRoam/main.conf.roaming
new file mode 100644
index 00000000..e19adbf3
--- /dev/null
+++ b/autotests/testAPRoam/main.conf.roaming
@@ -0,0 +1,5 @@
+[General]
+RoamThreshold=-72
+
+[Blacklist]
+InitialRoamRequestedTimeout=20
diff --git a/autotests/testAPRoam/roam_blacklist_test.py b/autotests/testAPRoam/roam_blacklist_test.py
new file mode 100644
index 00000000..883deea5
--- /dev/null
+++ b/autotests/testAPRoam/roam_blacklist_test.py
@@ -0,0 +1,183 @@
+#!/usr/bin/python3
+
+import unittest
+import sys
+
+sys.path.append('../util')
+import iwd
+from iwd import IWD, IWD_CONFIG_DIR
+from iwd import NetworkType
+
+from hostapd import HostapdCLI
+from hwsim import Hwsim
+
+class Test(unittest.TestCase):
+    def validate_connected(self, hostapd):
+        ordered_network = self.device.get_ordered_network('TestAPRoam')
+
+        self.assertEqual(ordered_network.type, NetworkType.psk)
+
+        condition = 'not obj.connected'
+        self.wd.wait_for_object_condition(ordered_network.network_object, condition)
+
+        self.device.connect_bssid(hostapd.bssid)
+
+        condition = 'obj.state == DeviceState.connected'
+        self.wd.wait_for_object_condition(self.device, condition)
+
+        hostapd.wait_for_event('AP-STA-CONNECTED')
+
+    def validate_ap_roamed(self, from_hostapd, to_hostapd):
+        from_hostapd.send_bss_transition(
+            self.device.address, self.neighbor_list, disassoc_imminent=True
+        )
+
+        from_condition = 'obj.state == DeviceState.roaming'
+        to_condition = 'obj.state == DeviceState.connected'
+        self.wd.wait_for_object_change(self.device, from_condition, to_condition)
+
+        to_hostapd.wait_for_event('AP-STA-CONNECTED %s' % self.device.address)
+
+        self.device.wait_for_event("ap-roam-blacklist-added")
+
+    def test_roam_to_optimal_candidates(self):
+        # In this test IWD will naturally transition down the list after each
+        # BSS gets roam blacklisted. All BSS's are above the RSSI thresholds.
+        self.rule_ssid1.signal = -5000
+        self.rule_ssid2.signal = -6500
+        self.rule_ssid3.signal = -6900
+
+        # Connect to BSS0
+        self.validate_connected(self.bss_hostapd[0])
+
+        # AP directed roam to BSS1
+        self.validate_ap_roamed(self.bss_hostapd[0], self.bss_hostapd[1])
+
+        # AP directed roam to BSS2
+        self.validate_ap_roamed(self.bss_hostapd[1], self.bss_hostapd[2])
+
+    def test_avoiding_under_threshold_bss(self):
+        # In this test IWD will blacklist BSS0, then roam the BSS1. BSS1 will
+        # then tell IWD to roam, but it should go back to BSS0 since the only
+        # non-blacklisted BSS is under the roam threshold.
+        self.rule_ssid1.signal = -5000
+        self.rule_ssid2.signal = -6500
+        self.rule_ssid3.signal = -7300
+
+        # Connect to BSS0
+        self.validate_connected(self.bss_hostapd[0])
+
+        # AP directed roam to BSS1
+        self.validate_ap_roamed(self.bss_hostapd[0], self.bss_hostapd[1])
+
+        # AP directed roam, but IWD should choose BSS0 since BSS2 is -73dB
+        self.validate_ap_roamed(self.bss_hostapd[1], self.bss_hostapd[0])
+
+    def test_connect_to_roam_blacklisted_bss(self):
+        # In this test a BSS will be roam blacklisted, but all other options are
+        # below the RSSI threshold so IWD should roam back to the blacklisted
+        # BSS.
+        self.rule_ssid1.signal = -5000
+        self.rule_ssid2.signal = -8000
+        self.rule_ssid3.signal = -8500
+
+        # Connect to BSS0
+        self.validate_connected(self.bss_hostapd[0])
+
+        # AP directed roam, should connect to BSS1 as its the next best
+        self.validate_ap_roamed(self.bss_hostapd[0], self.bss_hostapd[1])
+
+        # Connected to BSS1, but the signal is bad, so IWD should try to roam
+        # again. BSS0 is still blacklisted, but its the only reasonable option
+        # since both BSS1 and BSS2 are below the set RSSI threshold (-72dB)
+
+        from_condition = 'obj.state == DeviceState.roaming'
+        to_condition = 'obj.state == DeviceState.connected'
+        self.wd.wait_for_object_change(self.device, from_condition, to_condition)
+
+        # IWD should have connected to BSS0, even though its roam blacklisted
+        self.bss_hostapd[0].wait_for_event('AP-STA-CONNECTED %s' % self.device.address)
+
+    def test_blacklist_during_roam_scan(self):
+        # Tests that an AP roam request mid-roam results in the AP still being
+        # blacklisted even though the request itself doesn't directly trigger
+        # a roam.
+        self.rule_ssid1.signal = -7300
+        self.rule_ssid2.signal = -7500
+        self.rule_ssid3.signal = -8500
+
+        # Connect to BSS0 under the roam threshold so IWD will immediately try
+        # roaming elsewhere
+        self.validate_connected(self.bss_hostapd[0])
+
+        self.device.wait_for_event("roam-scan-triggered")
+
+        self.bss_hostapd[0].send_bss_transition(
+            self.device.address, self.neighbor_list, disassoc_imminent=True
+        )
+        self.device.wait_for_event("ap-roam-blacklist-added")
+
+        # BSS0 should have gotten blacklisted even though IWD was mid-roam,
+        # causing IWD to choose BSS1 when it gets is results.
+
+        from_condition = 'obj.state == DeviceState.roaming'
+        to_condition = 'obj.state == DeviceState.connected'
+        self.wd.wait_for_object_change(self.device, from_condition, to_condition)
+
+        self.bss_hostapd[1].wait_for_event('AP-STA-CONNECTED %s' % self.device.address)
+
+    def setUp(self):
+        self.wd = IWD(True)
+
+        devices = self.wd.list_devices(1)
+        self.device = devices[0]
+
+
+    def tearDown(self):
+        self.wd = None
+        self.device = None
+
+
+    @classmethod
+    def setUpClass(cls):
+        IWD.copy_to_storage("main.conf.roaming", IWD_CONFIG_DIR, "main.conf")
+        IWD.copy_to_storage('TestAPRoam.psk')
+        hwsim = Hwsim()
+
+        cls.bss_hostapd = [ HostapdCLI(config='ssid1.conf'),
+                            HostapdCLI(config='ssid2.conf'),
+                            HostapdCLI(config='ssid3.conf') ]
+        HostapdCLI.group_neighbors(*cls.bss_hostapd)
+
+        rad0 = hwsim.get_radio('rad0')
+        rad1 = hwsim.get_radio('rad1')
+        rad2 = hwsim.get_radio('rad2')
+
+        cls.neighbor_list = [
+            (cls.bss_hostapd[0].bssid, "8f0000005101060603000000"),
+            (cls.bss_hostapd[1].bssid, "8f0000005102060603000000"),
+            (cls.bss_hostapd[2].bssid, "8f0000005103060603000000"),
+        ]
+
+
+        cls.rule_ssid1 = hwsim.rules.create()
+        cls.rule_ssid1.source = rad0.addresses[0]
+        cls.rule_ssid1.bidirectional = True
+        cls.rule_ssid1.enabled = True
+
+        cls.rule_ssid2 = hwsim.rules.create()
+        cls.rule_ssid2.source = rad1.addresses[0]
+        cls.rule_ssid2.bidirectional = True
+        cls.rule_ssid2.enabled = True
+
+        cls.rule_ssid3 = hwsim.rules.create()
+        cls.rule_ssid3.source = rad2.addresses[0]
+        cls.rule_ssid3.bidirectional = True
+        cls.rule_ssid3.enabled = True
+
+    @classmethod
+    def tearDownClass(cls):
+        IWD.clear_storage()
+
+if __name__ == '__main__':
+    unittest.main(exit=True)
-- 
2.34.1

