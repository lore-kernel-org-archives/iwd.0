Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D48D1E25E1
	for <iwd@lists.linux.dev>; Mon, 10 Mar 2025 21:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741642885; cv=none; b=cpo3y4LYj6U7fkCLg1TTMVLLMkYS3CZ570ZntmdEKk85u2H2Xut78VQoYuVdC9qgReXTzSsAiZOOloiC2n1fVznb/DB6c9Sc0CQciORL359KNy1ODSqBBk3NHvO+u1NgbYcjgFKka7/tl0DlHYVMRglIPgDMKqow3tq+ZZmUMZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741642885; c=relaxed/simple;
	bh=DgQz+47eb6MRzQ7XuoYC13sW2oZDH0N7tu4Ow/4BwwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EYA+R2/KtVGX4uTpPj+o+JIQb5JBlxnGmKcb2WYLHWImTsSRdzVHj9ZA/pYEdvwekHj9h72fLII+XGVCc8DwtfjKogmosk322GU5V6m4jiQ4z3Zb+90tx8EmmBLMRjFD2/Bc9+0mqNZ/IwOlvuTZhKqGietsjqOLCH3LDbqlDqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1Cu1Dtn; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1Cu1Dtn"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-474f836eb4cso36401811cf.3
        for <iwd@lists.linux.dev>; Mon, 10 Mar 2025 14:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741642882; x=1742247682; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYoe+3H8/5yAERsOoYL6MzUOf1VoKgTy+zK3fCZIX1M=;
        b=F1Cu1DtnVFCDlO5KpekVjuWthS8VMxkDV4oXDV4Yer3RKasOeJqCrBNU/LNczUR94e
         azAmnNxjii/9ZkQMN+ltTtjBGAPPPy2T93QoFxWcb+6KCKpumNyoO25AeNC7OP7nEYoW
         7uOsHfDAWvw+JtgN2tprY+Jm5vTbFwSwLChE5F+hVjz7mAJTGDdifAOij77s3GULF3IE
         FwUyGw8e85IQkhX/a1JQOtqxpElIzIkXmAhisyfzczgLQH3Ay+4re+tQ9exctwo0a5gX
         uxa3vLhF1l5gsl1zhBa9UbGh9FWlxpUxYVcmiYYf37xFYD23T+D9Bx2FxAZk7EUhxBR5
         roAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741642882; x=1742247682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYoe+3H8/5yAERsOoYL6MzUOf1VoKgTy+zK3fCZIX1M=;
        b=LktTAxWDM08iO0fcy2S4d1WvwQCa1cpYZlb0o2ViSDAOxSrkhOtJa7RtOrUeaYCpvH
         0Ep3qjnzNuiZZEAPbHMHwRu1fwwGllBgSu4sIjp6t+AXKNmn6V1Z/yRnL7qMqEHlNuvN
         kUM/3VD4oetWZKC+uHGqUGnIrRPWVdsphmZ+1zemuAfbMmoaB8EXAmUiIAL7Tqwboz22
         zrBET2FdyDi0pveL7ykP/LiB7TO750JZgF2Wzc2ouJvA2wzb3Zl7aiiy4qz1Q0w0HG2u
         HlQyztqMUswmG84EujUbi7nl1B+5j9xxdqyS1mQIbDmKh6NHEscDfJ/iANtAi8xk5Bb9
         BxTw==
X-Gm-Message-State: AOJu0Yw1gx5028770QVZgHAeji7tsF+kJDavyliitLBiA62yiOHONWA2
	jUfKqHmSWHAKvKYv1CFQ1+SpMzbI2n812YAGtZ+ncM42k4JjmXdmgdjQjA==
X-Gm-Gg: ASbGncsohRw2a915LWRTrxJnBfmKlH3PKPNBLY7Z9gpTZHXigjqW1olgP2v5niu9sN7
	482xtadYJpm9+j88VmJeLmX/IW3k0dOmBudrojCTIzEXQ6nzr5G3Q3MIO6S1z4daJDpNZVWvB31
	SByK+ogHqM52THfIyQrnWZRYyGv8p1pAHiDlBzL0GMZJVjdCv2/59fLDGtPLWLBxMLRTLhfGSwY
	pBrgrTbmqTF88rJ4Gk2F9rBN0sqb6I5TO9bi2M8H1Uzqs6aiuAKlcoQbegCwDvUvzvxti3nuwCn
	vYJ0pFL+t9QhndlOsgGlDZAHfmpRnPd75IoYa5LAbnQV4xYUq80f13743GJL+xeWOFBdgNdOw0z
	42Ro=
X-Google-Smtp-Source: AGHT+IFuJ3cK49a0/GQSi5nIz7UK9aUK1Jk9p+sPZBmnfD1tbB96jo8GqNfDDkJDINNn67Io3uj1VA==
X-Received: by 2002:a05:622a:1993:b0:472:12f1:ba4a with SMTP id d75a77b69052e-4761095065emr249644531cf.4.1741642882209;
        Mon, 10 Mar 2025 14:41:22 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476772de5absm30487841cf.66.2025.03.10.14.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 14:41:21 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 8/8] auto-t: add test for AP roam blacklisting
Date: Mon, 10 Mar 2025 14:40:59 -0700
Message-Id: <20250310214059.20809-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310214059.20809-1-prestwoj@gmail.com>
References: <20250310214059.20809-1-prestwoj@gmail.com>
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
 autotests/testAPRoam/main.conf              |   5 +
 autotests/testAPRoam/roam_blacklist_test.py | 154 ++++++++++++++++++++
 4 files changed, 162 insertions(+), 1 deletion(-)
 create mode 100644 autotests/testAPRoam/main.conf
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
diff --git a/autotests/testAPRoam/main.conf b/autotests/testAPRoam/main.conf
new file mode 100644
index 00000000..9c9fb994
--- /dev/null
+++ b/autotests/testAPRoam/main.conf
@@ -0,0 +1,5 @@
+[Rank]
+OptimalSignalThreshold=-72
+
+[Blacklist]
+InitialRoamRequestedTimeout=20
diff --git a/autotests/testAPRoam/roam_blacklist_test.py b/autotests/testAPRoam/roam_blacklist_test.py
new file mode 100644
index 00000000..259f6aa5
--- /dev/null
+++ b/autotests/testAPRoam/roam_blacklist_test.py
@@ -0,0 +1,154 @@
+#!/usr/bin/python3
+
+import unittest
+import sys
+
+sys.path.append('../util')
+import iwd
+from iwd import IWD
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

