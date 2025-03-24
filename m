Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF2425F998
	for <iwd@lists.linux.dev>; Mon, 24 Mar 2025 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825774; cv=none; b=KDByOPxrjHRiZ0QVFbOKXtnY7SwsILuGtSdxCYL1ohmHRauFHIvxsrmFWGAeYaTAEYwkFdS/StqFEM/HsTTomMA6xDe4b31PNfnNzWAXc1+XvdTl7dzRrAhyzCtpMR3UX53G7xq8JRnybkP2p8oTh/PwD/j8rUdhKITKFAVMY5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825774; c=relaxed/simple;
	bh=D0AZH3j5Nv94fAejR5O2flars8MjA2oi5jHx9Z3OkC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k2IA6JwndJZiwWoZHb7xjjUlpEyxfPZmk+9YTFDHBiDVKY7CzF0KzZNofarxJaMuxTobkSImk4/CEUirEMK2SarYCZokFmNSgxmn5NS2hIG6MHodZq9xyY8rfeO9cvcBvDsELjvCpgXyEJa9rm3eNVbYdh6Kom2ZHT8PAm+WWfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbcAyvWi; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbcAyvWi"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22438c356c8so85447995ad.1
        for <iwd@lists.linux.dev>; Mon, 24 Mar 2025 07:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742825772; x=1743430572; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZO7ki/18WDaVCfuhFD2MZcowj6rEYFLXzQ9C8haXsic=;
        b=FbcAyvWil65UmXUDyy76qbr2bEvz1pl0Ckbtu/FJTe5mxc2RluA1vMDAroKaO/rMhT
         UBxxU7Lti57XokDiYABm6hA4Phq8XWfvz9x8kdlow2Y/ZEyVj/RWFArqjPIXvyjgYqRa
         FhXRDwSMuICoXEFlZ7KtArgC+qr2AoP2GNCbZRxwiHGU7dRw7stNQ4FbJor3k+NK9u4X
         wsCQfTwQZucDVsAdsplDmKZbemSNO7FdJxhVB2Ne8WumWkMdM2d1GeURfzk6VvG0NB+L
         drAPvPR4TvJSC0BSbOPiNQhSC8hZ1dQCN3RX1WSg5MmUAw9PjG46us23iSnTbYldNBPV
         QM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742825772; x=1743430572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZO7ki/18WDaVCfuhFD2MZcowj6rEYFLXzQ9C8haXsic=;
        b=bMiw2KKUziF7suClSbzxDykOsZtXG+v2avLFKMZIWun7Y5GiKJem5Reu1E6+wPG+pc
         Uq2N/M3lFz9jhb2D4Z3Im5YkU9wRv/edcpfn9n5tcN0ZkdffLJUxek+tfiNFNIdObs4o
         Z8GqhGx6LtaBXGuBKbmoIrZZ6vOj56DpfPlRiu3DJWjlcGnO1Bxk/DwMseqsVVcWqXof
         OHeeMH2NYXWuX2fVDiEsUGE94XNaYNPWaztjidoC1dnKQHt8X9cFYEV0i96+Z43VPLtU
         jHS872+fE2Ee6mk6CC26jtd72wi9KwpVSESQSkecyTLt109klueID1nHs+EkwDaUZfD/
         WklA==
X-Gm-Message-State: AOJu0YyMuhBrz+G1VLVTyhhWQgl+nPB6sbxmm1GhRO4Y3UiE8XnfF8+Q
	kEiYxnSb5WNaZ3gX8UUm8Mpwm7Vvk6h/nKYidAjiIuLn4dg6NH0e+OJeDA==
X-Gm-Gg: ASbGncspsf55/iemzwygE6SmrCL+WnmJ3KON6WswDu2B3cEo55Het+sUyg1uY+YZKao
	p5i64lDeIEquJ3q8lE0JxuLmFS2oRzNEowV9ClIiG1+iVwoc6ZUYQ5PuLJUr5ktdRqyeiU+iNTt
	/uWGqO6vLJ2d9Lyxog1VU7AJd/i/gcW5Ywk6j2CJwfQghrl/Zvl2E4lHUk0mDtCg/XJBMELdfT+
	7cMVi+Em8Xok+ynnHJejQmcwYFCftXactFzhJpgrVPgk19a8zvsAi0C+N+va/VEELTx+Yj09Fqt
	SUvxX2ZQXHK71925l8bGbnetC4JWwJPJojF1PwneHOeVG6pGda7XAZM=
X-Google-Smtp-Source: AGHT+IG6IOydOiPIY0QfX3B8uBRowaDMzD1NPokxJtnfh0e/fQWD2IVOhU/cvtB8oi21Mp+5Ztncpg==
X-Received: by 2002:a17:902:cf04:b0:224:5b4:b3b9 with SMTP id d9443c01a7336-22780e12a7dmr199514085ad.33.1742825771544;
        Mon, 24 Mar 2025 07:16:11 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd54efsm8007868b3a.37.2025.03.24.07.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 07:16:11 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 12/13] auto-t: add tests for AP roam blacklisting
Date: Mon, 24 Mar 2025 07:15:37 -0700
Message-Id: <20250324141538.144578-13-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324141538.144578-1-prestwoj@gmail.com>
References: <20250324141538.144578-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/testAPRoam/connection_test.py     |   2 +-
 autotests/testAPRoam/hw.conf                |   2 +
 autotests/testAPRoam/main.conf.roaming      |   6 +
 autotests/testAPRoam/roam_blacklist_test.py | 183 ++++++++++++++++++++
 4 files changed, 192 insertions(+), 1 deletion(-)
 create mode 100644 autotests/testAPRoam/main.conf.roaming
 create mode 100644 autotests/testAPRoam/roam_blacklist_test.py

diff --git a/autotests/testAPRoam/connection_test.py b/autotests/testAPRoam/connection_test.py
index a419f4aa..9d17ca87 100644
--- a/autotests/testAPRoam/connection_test.py
+++ b/autotests/testAPRoam/connection_test.py
@@ -13,7 +13,7 @@ from hostapd import HostapdCLI
 class Test(unittest.TestCase):
 
     def validate(self, expect_roam=True):
-        wd = IWD()
+        wd = IWD(True)
 
         devices = wd.list_devices(1)
         device = devices[0]
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
index 00000000..4bf07c29
--- /dev/null
+++ b/autotests/testAPRoam/main.conf.roaming
@@ -0,0 +1,6 @@
+[General]
+RoamThreshold=-66
+OptimalSignalThreshold=-72
+
+[Blacklist]
+InitialRoamRequestedTimeout=20
diff --git a/autotests/testAPRoam/roam_blacklist_test.py b/autotests/testAPRoam/roam_blacklist_test.py
new file mode 100644
index 00000000..b9108d4e
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
+        self.rule_ssid1.signal = -6700
+        self.rule_ssid2.signal = -7100
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

