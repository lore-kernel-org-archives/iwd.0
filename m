Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD3A1C5F29
	for <iwd@lists.linux.dev>; Fri, 28 Mar 2025 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743172999; cv=none; b=eXrHSBpeKNDXwqRd2kHsAF/A7wIoc2AeC2Y1uFf/3NwW1qSy8C25tJSXu1+ES966ITq0NLflWklaAZzML+lHvK04zFSFVwlJ8rV2HjU8w08skVapmpcdu425g+VC98ocgcunvpYCbEFNGoLA0IfEt9l72tdMpSt08OVICjGtvNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743172999; c=relaxed/simple;
	bh=L0VYsVo9BxzINhugH9vZ2TiJWJT5JJMjUkoqwIaV2Gk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PrDmoOLz1n8WRijYlESxog/d8WXHR6p+uw6YAjviTx8IGVwLBWzzbjX3JF4yt494rXbx40Ptbu32Yangh7cyEq6wgDx7DTdVAg5LJnkr3E1qfzO+PaxNFhVJu3nkWew/JNPhv6DfVKEgWsrC75GCFGYNAltiqO7eqKQvV0SyPeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbBu9ag1; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbBu9ag1"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22580c9ee0aso48539625ad.2
        for <iwd@lists.linux.dev>; Fri, 28 Mar 2025 07:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743172995; x=1743777795; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THaN5+ZxDbBBmftLQlVFzbpZcH0VVzq3ODef+4I46HE=;
        b=IbBu9ag1xAva2ZYko8AWDOFDgs8/1ztP3A19xmxEfQAGf4QXhQHqTGtoPgAFeKctG4
         81jayfNpJFlVsIrLKEOe4eWX9ckEoK/QoDFckpj+7upAxcwNvo/hkB2RU4h2uEhakI4z
         PSOr0qqmVdh9G4PYJOvmp8lVdTZK1faUrVfUrfmOOslfiOrhXUpncxgydzDVJb9OBGj8
         pxxJoSS5V9nwarHhPcO0IbZSICAsHmg5wYJumhYIn2wJ5XqjiiBHV1MdPDFyF/jaydKC
         JqZcXQrGBjeBo9AkqvUx2ug035kQ91+Zqpd8fFh4y94LJ9YKlVrsNCwwvwfkiabhQ197
         J+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743172995; x=1743777795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THaN5+ZxDbBBmftLQlVFzbpZcH0VVzq3ODef+4I46HE=;
        b=buUHTrb3LpWJM7D7VxBY1CprWfdpiev66T6SRRQW7o5ePZMz5fEYUGv4ctPyxOZhzh
         FUxAY//X3MlDPELXvNS3LHuXh7oXyRZTo0qAW/u0ck5n5rO1u9hxu0kZRsbrrMaPgBgz
         xGPuUTeFb9d28c1ySKvoFPyz5Ji7Qs5M1vdnk1CzgHwIDi45fuAxQz4vFohsKn3K79DP
         RekFtw5v/KJ/GwBQSoc7mtUHft8nLDwpKPfJhz/riMZs2Qu7qrTNkcRq6emE6ypYl50E
         cV3ZVQylVSxehl34ejnYJWC6in5u5SdBt7NepH5aYtZn0GgmeNtR2naI6zN5x8VTxDgX
         JGiQ==
X-Gm-Message-State: AOJu0YwH0Ni8mGSoPvALNYgbrMJiXxhaFa3ltEKGfBR2H2jniX+AQyhq
	JQOozSa0YGJ6I58ZpijcEkfIsRFOMkpvnvwgKcrDuGqcbEO8ao20cgFZLQ==
X-Gm-Gg: ASbGncsRpKxrsYiDLdFXrx2AiPTObD2qX8eXLhuCzH8CTr4XSPGrvKoe3k9mbxeUi+7
	SjQtM5vnf/S+8ltCTwk8Inc4fGKRjZubQH3e/1UX+9SJEHsNCqfQiRoH0uwBhxw9z29BEwN1th5
	AyJyP9lEqjxY6wsFjMwtqBqZiCDy3w1qk1CR6lf6l0lUVbF+k4TcYlPC8WGPExwtkeOWIagDxjv
	QiceFms/cDVEnjzkPpi/VhdHexNoly+jzaSysVWzcBREALtogBRNedXAON9+wX0G81jyhZRUpB7
	2JTkBLS5zd4M5+BElLfojE39uuDPurQSlGHk6Df8IOVxb2MonxxvFOCCymn4Zojln7amhEYQRSg
	=
X-Google-Smtp-Source: AGHT+IEF3ohAVbkP4S6JE52tVROymrZhbH4n/Ijy5OdUAkybBDZ08Ri95Nn8+Hii192isHb0VfsKbQ==
X-Received: by 2002:a17:903:1786:b0:220:d257:cdbd with SMTP id d9443c01a7336-2280491d6b2mr133234165ad.48.1743172994945;
        Fri, 28 Mar 2025 07:43:14 -0700 (PDT)
Received: from LOCLAP699.locus-demo-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eee2288sm18885515ad.87.2025.03.28.07.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 07:43:14 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 09/11] auto-t: add tests for AP roam blacklisting
Date: Fri, 28 Mar 2025 07:42:51 -0700
Message-Id: <20250328144253.421425-9-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250328144253.421425-1-prestwoj@gmail.com>
References: <20250328144253.421425-1-prestwoj@gmail.com>
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
 autotests/testAPRoam/main.conf.roaming      |   6 +
 autotests/testAPRoam/roam_blacklist_test.py | 183 ++++++++++++++++++++
 4 files changed, 224 insertions(+), 23 deletions(-)
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
index 00000000..1ff23571
--- /dev/null
+++ b/autotests/testAPRoam/main.conf.roaming
@@ -0,0 +1,6 @@
+[General]
+RoamThreshold=-72
+CriticalRoamThreshold=-72
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

