Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18F813B2A5
	for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083071; cv=none; b=VTrg3RWuQIg+Z9WlJuRPEgr6XlB1D2T/hlCd3M3OOv1BOKrd1r2U4tu1HTJW37DW+Aq+F1l4CZAe8FYAY3l8QhEsAveRwbc7+1rwMHLqydB2DA/JaQDMa8xh4DguUp818OrNy1QlgGy5VZosvfqCX5vBJiYb07q3em5ilATYzYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083071; c=relaxed/simple;
	bh=wQ1sYgy+XyfmWW2VsSjGNopZ+AQqSPwYV8AF/Tc8QkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c3TneyMR2ei9cARycj/vXmV1YYUKvUvuY+vLrJm/Snmqq2E5m/4bbyChI0G60rnBBnWP+6LkF1+Hjvwq3aRY0wDEyuwk09T+PIvkTgPDx1940WoA7wTxMP73uCG/SvrJF9aCLTjrwz6QIQyHSCUg1hWuXq+EIoULgxmcUNNQ910=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzMgw+FB; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzMgw+FB"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-713e460f920so1192036b3a.1
        for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 08:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724083069; x=1724687869; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDoJeKkVNCXIIp7EFX/aAAGL6EGIL4UURmjJXhZ9qyk=;
        b=WzMgw+FBTWJrImmDIcWHggL443/dEAOJ2ylE04mMjyOJIssNatQiWZNpr13SLWStH7
         BBwoyv26I+qsgcUwJTylWstTOR/SD5HiJ3KT6A4Zal/qqW7GC1bwl6JlHDZiK+KX8NHD
         UFTuHkoN+JdI3IqylNl2FKGgO09PuvpGV8dll6x8TpDY2AWwfeZWkLzmOOaYFkmtwvq4
         fwvZj6TwiGNU1PfB1ZyAygqcjyVTteKja/4V7QYtdLxBjNS42CK9ADdvev5V1TQjwxLk
         uQmUtBOFDq8jpePrja+BUbnKXuLfPRkro9M1peyecsxJYUMRM7ByJqcCsXx0wFFDtRcD
         T98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724083069; x=1724687869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDoJeKkVNCXIIp7EFX/aAAGL6EGIL4UURmjJXhZ9qyk=;
        b=SbfFMZlIQ8qr8gkMPpAc1H8HzxERNf8JDCJKPMfbNtw80Rp8UOmUhTV/WgsJrAv7Er
         RIAEpKIa6N1gekxO1NNesE70IAoEXAj3LUqn3HyrACkqUxmO3cPw2JhbSpivZ2/dfgCS
         b04sD6p38h+Z1R1tN5AP9e7GLVRBlW7e32FAOeyL1YC3MMW0FIYlstar5bxS3vFrIHQ4
         Mz6HOmHL1SsKBql2+E03tbpqos5ruHD5inzpg1ZEyaErqNiOzu25h/uofZ5HLtYKmfoP
         hYZb3G4c8a/Mu0mQY8/jjp59logdZ6mmiGXlT96GAkouZxPDIwjsgwfY0/fh/4Ek93EB
         iI6g==
X-Gm-Message-State: AOJu0YyVrJnc9/8IeYz+MQR+qOTri4P4pZwrNZ8d0V32plAXGC4rGp8k
	3vIJfu3PzEKE5qqrt0BgLymAAQjXTHMA+EVIdJwvNhJBBSyBqJ5ZAsFbzg==
X-Google-Smtp-Source: AGHT+IFz/5bc2pjuW3lRi8GbA0JQIM6n2AX/xEp6JhW4LIIgTfUb0nwPMXJGz7lNk+EpR0NSk9a3fg==
X-Received: by 2002:a05:6a00:915a:b0:70d:2b23:a714 with SMTP id d2e1a72fcca58-713c4dbec9dmr10233175b3a.4.1724083068895;
        Mon, 19 Aug 2024 08:57:48 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae0cb5asm6752277b3a.69.2024.08.19.08.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 08:57:48 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 6/6] auto-t: Add test for BasicServiceSets
Date: Mon, 19 Aug 2024 08:57:34 -0700
Message-Id: <20240819155734.1276476-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819155734.1276476-1-prestwoj@gmail.com>
References: <20240819155734.1276476-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 .../basic_service_set_test.py                 | 98 +++++++++++++++++++
 autotests/testBasicServiceSet/hw.conf         |  8 ++
 autotests/testBasicServiceSet/ssidTKIP-1.conf |  7 ++
 autotests/testBasicServiceSet/ssidTKIP-2.conf |  7 ++
 autotests/testBasicServiceSet/ssidTKIP.psk    |  5 +
 5 files changed, 125 insertions(+)
 create mode 100644 autotests/testBasicServiceSet/basic_service_set_test.py
 create mode 100644 autotests/testBasicServiceSet/hw.conf
 create mode 100644 autotests/testBasicServiceSet/ssidTKIP-1.conf
 create mode 100644 autotests/testBasicServiceSet/ssidTKIP-2.conf
 create mode 100644 autotests/testBasicServiceSet/ssidTKIP.psk

diff --git a/autotests/testBasicServiceSet/basic_service_set_test.py b/autotests/testBasicServiceSet/basic_service_set_test.py
new file mode 100644
index 00000000..58b21ac0
--- /dev/null
+++ b/autotests/testBasicServiceSet/basic_service_set_test.py
@@ -0,0 +1,98 @@
+#! /usr/bin/python3
+
+import unittest
+import sys, os
+
+sys.path.append('../util')
+import iwd
+from iwd import IWD
+from iwd import PSKAgent
+from iwd import NetworkType
+from hwsim import Hwsim
+from hostapd import HostapdCLI
+import testutil
+
+class Test(unittest.TestCase):
+    def test_bss_unregister(self):
+        device = self.wd.list_devices(1)[0]
+
+        ordered_network = device.get_ordered_network('ssidTKIP', full_scan=True)
+        network = ordered_network.network_object
+
+        self.assertEqual(len(network.extended_service_set), 2)
+
+        ends = [parts.split('/')[-1] for parts in network.extended_service_set]
+
+        self.assertIn(self.bss_hostapd[0].bssid.replace(':', ''), ends)
+        self.assertIn(self.bss_hostapd[1].bssid.replace(':', ''), ends)
+
+        self.rule_bss1.enabled = True
+
+        # Even with flushing, the kernel still seems to return the scan
+        # results
+        self.wd.wait(40)
+        ordered_network = device.get_ordered_network('ssidTKIP', full_scan=True)
+        network = ordered_network.network_object
+
+        ends = [parts.split('/')[-1] for parts in network.extended_service_set]
+
+        self.assertIn(self.bss_hostapd[0].bssid.replace(':', ''), ends)
+        self.assertNotIn(self.bss_hostapd[1].bssid.replace(':', ''), ends)
+
+        self.rule_bss0.enabled = True
+
+        self.wd.wait(40)
+        ordered_networks = device.get_ordered_networks('ssidTKIP', full_scan=True)
+        self.assertIsNone(ordered_networks)
+
+        self.rule_bss0.enabled = False
+
+        ordered_networks = device.get_ordered_networks('ssidTKIP', full_scan=True)
+        ends = [parts.split('/')[-1] for parts in network.extended_service_set]
+
+        self.assertIn(self.bss_hostapd[0].bssid.replace(':', ''), ends)
+        self.assertNotIn(self.bss_hostapd[1].bssid.replace(':', ''), ends)
+
+    def tearDown(self):
+        self.rule_bss0.enabled = False
+        self.rule_bss1.enabled = False
+
+        self.wd.stop()
+        self.wd.wait(10)
+        self.wd = None
+
+    def setUp(self):
+        self.wd = IWD(True)
+
+    @classmethod
+    def setUpClass(cls):
+        hwsim = Hwsim()
+
+        IWD.copy_to_storage('ssidTKIP.psk')
+
+        cls.bss_hostapd = [ HostapdCLI(config='ssidTKIP-1.conf'),
+                            HostapdCLI(config='ssidTKIP-2.conf') ]
+
+
+        rad0 = hwsim.get_radio('rad0')
+        rad1 = hwsim.get_radio('rad1')
+
+        cls.rule_bss0 = hwsim.rules.create()
+        cls.rule_bss0.source = rad0.addresses[0]
+        cls.rule_bss0.bidirectional = True
+        cls.rule_bss0.drop = True
+
+        cls.rule_bss1 = hwsim.rules.create()
+        cls.rule_bss1.source = rad1.addresses[0]
+        cls.rule_bss1.bidirectional = True
+        cls.rule_bss1.drop = True
+
+    @classmethod
+    def tearDownClass(cls):
+        IWD.clear_storage()
+        cls.bss_hostapd = None
+        cls.rule_bss0.remove()
+        cls.rule_bss1.remove()
+
+if __name__ == '__main__':
+    unittest.main(exit=True)
diff --git a/autotests/testBasicServiceSet/hw.conf b/autotests/testBasicServiceSet/hw.conf
new file mode 100644
index 00000000..60dd64b8
--- /dev/null
+++ b/autotests/testBasicServiceSet/hw.conf
@@ -0,0 +1,8 @@
+[SETUP]
+num_radios=3
+hwsim_medium=yes
+start_iwd=no
+
+[HOSTAPD]
+rad0=ssidTKIP-1.conf
+rad1=ssidTKIP-2.conf
diff --git a/autotests/testBasicServiceSet/ssidTKIP-1.conf b/autotests/testBasicServiceSet/ssidTKIP-1.conf
new file mode 100644
index 00000000..11ef15f0
--- /dev/null
+++ b/autotests/testBasicServiceSet/ssidTKIP-1.conf
@@ -0,0 +1,7 @@
+hw_mode=g
+channel=1
+ssid=ssidTKIP
+
+wpa=1
+wpa_pairwise=TKIP
+wpa_passphrase=secret123
diff --git a/autotests/testBasicServiceSet/ssidTKIP-2.conf b/autotests/testBasicServiceSet/ssidTKIP-2.conf
new file mode 100644
index 00000000..0ed132c1
--- /dev/null
+++ b/autotests/testBasicServiceSet/ssidTKIP-2.conf
@@ -0,0 +1,7 @@
+hw_mode=g
+channel=2
+ssid=ssidTKIP
+
+wpa=1
+wpa_pairwise=TKIP
+wpa_passphrase=secret123
diff --git a/autotests/testBasicServiceSet/ssidTKIP.psk b/autotests/testBasicServiceSet/ssidTKIP.psk
new file mode 100644
index 00000000..85d25d8d
--- /dev/null
+++ b/autotests/testBasicServiceSet/ssidTKIP.psk
@@ -0,0 +1,5 @@
+[Security]
+Passphrase=secret123
+
+[Settings]
+AutoConnect=False
-- 
2.34.1

