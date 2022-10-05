Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEC346A5
	for <iwd@lists.linux.dev>; Wed,  5 Oct 2022 22:46:39 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id l1so30866pld.13
        for <iwd@lists.linux.dev>; Wed, 05 Oct 2022 15:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=m0NV1NxEdvmnEo2Hq1l0Dm4iiDx69MCEAZzaa+esYdE=;
        b=FT6YqzY4yvW7TJMynMZSu0Szjp/ttz3GMcnCbv5C+D0o4xB7J/D8kfe0z2bgTBKvNN
         j0VcVtdJ8sWNuZyD2AORvpMppfrD1V5JcOLAoZ6Bm8E5PplreNndmb5vhguxIio/Cnh3
         6qM0NmFFyoG9nUGMq/sLpcg6lLNqw9JUX3kIJRAo7FfLTY4oCdUtZF8oz/Fm8H9p/WYW
         Dc11d+MY7bdvpfkEBlPlWHYuJMAo2A0u1+6QoWSbl+OO3+8mB5M0aRjK0WdNDexU+xAu
         OSdxYTUv7JQkwcvjBDYraNLc+a83a8Ly3v4fEcR1XtteIONA6HFFxdmyGKZoAIJtJjyJ
         P1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=m0NV1NxEdvmnEo2Hq1l0Dm4iiDx69MCEAZzaa+esYdE=;
        b=w+B0+I9nlwneuOYjbE4MGLCfhr0Df/Uapk3m2fR7SM2rv7n0+tWCPxVInTm88aMOib
         ZVXYHQynPdWa/uHf3U/gCKJdltWLrm2LkVTRbMOI2gkGHw706+0rBvFg6/1INn/7/jmj
         GqbTbr2KtwSVICBF2zXyjr5px5stIKtJSZdargonlCK1KUYIp+QB6ADC3P3he6xEyDsE
         gLvL7LGoqWLuvX3MkKx2FnxvqWkSJLKEqcKGwqpII3pYR2rpBQApGQ1j3Dnl4B+EnKF8
         sB56BOuvgckjg8kKHuPfDZpJ9GhYkQ/rSoFHUbdqAWyTn46INfqcqf6nuxe2nSat6K4v
         yQSg==
X-Gm-Message-State: ACrzQf3PvcLDUvMh7+pP1NUFYqf45bWPZ21N/vJsqNQr2z636CldL4Xb
	01moOBF+w5YBJpjt7N21tl4SIn5z0sw=
X-Google-Smtp-Source: AMsMyM420lY+g0ZipwxI7LyiOfH5UpX7LPXcoIiqfSsPHcmR6zjApD05ZhGPanJD75nSfud8uyByZA==
X-Received: by 2002:a17:902:d489:b0:178:1ad6:6603 with SMTP id c9-20020a170902d48900b001781ad66603mr1669161plg.158.1665009998498;
        Wed, 05 Oct 2022 15:46:38 -0700 (PDT)
Received: from jprestwo-xps.none (h67-204-159-212.bendor.broadband.dynamic.tds.net. [67.204.159.212])
        by smtp.gmail.com with ESMTPSA id 61-20020a17090a0fc300b001fd7e56da4csm1590686pjz.39.2022.10.05.15.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 15:46:38 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/6] auto-t: add two tests for new FT behavior
Date: Wed,  5 Oct 2022 15:46:31 -0700
Message-Id: <20221005224632.780575-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221005224632.780575-1-prestwoj@gmail.com>
References: <20221005224632.780575-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These tests ensure proper behavior if FT fails to authenticate
---
 autotests/testPSK-roam/failed_roam_test.py | 160 +++++++++++++++++++++
 1 file changed, 160 insertions(+)
 create mode 100644 autotests/testPSK-roam/failed_roam_test.py

diff --git a/autotests/testPSK-roam/failed_roam_test.py b/autotests/testPSK-roam/failed_roam_test.py
new file mode 100644
index 00000000..cac2ff4d
--- /dev/null
+++ b/autotests/testPSK-roam/failed_roam_test.py
@@ -0,0 +1,160 @@
+#! /usr/bin/python3
+
+import unittest
+import os, sys
+
+sys.path.append('../util')
+from iwd import IWD
+from iwd import NetworkType, DeviceState
+from hwsim import Hwsim
+from hostapd import HostapdCLI
+import testutil
+
+class Test(unittest.TestCase):
+    def connect(self, wd, device, hostapd):
+        ordered_network = device.get_ordered_network('TestFT', full_scan=True)
+
+        self.assertEqual(ordered_network.type, NetworkType.psk)
+
+        condition = 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condition)
+
+        device.connect_bssid(hostapd.bssid)
+
+        condition = 'obj.state == DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
+        hostapd.wait_for_event('AP-STA-CONNECTED %s' % device.address)
+
+        testutil.test_iface_operstate(device.name)
+        testutil.test_ifaces_connected(hostapd.ifname, device.name)
+
+    def verify_roam(self, wd, device, prev, new):
+        from_condition = 'obj.state == DeviceState.roaming'
+        to_condition = 'obj.state == DeviceState.connected'
+        wd.wait_for_object_change(device, from_condition, to_condition)
+
+        new.wait_for_event('AP-STA-CONNECTED %s' % device.address)
+
+        testutil.test_iface_operstate(device.name)
+        testutil.test_ifaces_connected(new.ifname, device.name)
+        self.assertRaises(Exception, testutil.test_ifaces_connected,
+                          (prev.ifname, device.name, True, True))
+
+
+    # FT-over-Air failure, should stay connected
+    def test_ft_over_air_failure(self):
+        self.bss_hostapd[0].set_value('wpa_key_mgmt', 'FT-PSK')
+        self.bss_hostapd[0].set_value('ft_over_ds', '0')
+        self.bss_hostapd[0].reload()
+        self.bss_hostapd[0].wait_for_event("AP-ENABLED")
+
+        self.bss_hostapd[1].set_value('wpa_key_mgmt', 'FT-PSK')
+        self.bss_hostapd[1].set_value('ft_over_ds', '0')
+        self.bss_hostapd[1].reload()
+        self.bss_hostapd[1].wait_for_event("AP-ENABLED")
+
+        wd = IWD(True)
+
+        device = wd.list_devices(1)[0]
+
+        self.connect(wd, device, self.bss_hostapd[0])
+
+        self.rule0.enabled = True
+
+        device.roam(self.bss_hostapd[1].bssid)
+
+        # Roam should fail...
+        device.wait_for_event('ft-over-air-roam-failed')
+        # ... but IWD should remain connected
+        self.assertTrue(device.state == DeviceState.connected)
+
+        self.rule0.enabled = False
+
+        # Try again once more
+        device.roam(self.bss_hostapd[1].bssid)
+
+        self.verify_roam(wd, device, self.bss_hostapd[0], self.bss_hostapd[1])
+
+        self.bss_hostapd[1].deauthenticate(device.address)
+        condition = 'obj.state == DeviceState.disconnected'
+        wd.wait_for_object_condition(device, condition)
+
+    # Network sets over-DS bit, but fails to authenticate. IWD should still be
+    # able to roam using FT-over-Air.
+    def test_fallback_to_over_air(self):
+        self.bss_hostapd[0].set_value('wpa_key_mgmt', 'FT-PSK')
+        self.bss_hostapd[0].set_value('ft_over_ds', '1')
+        self.bss_hostapd[0].reload()
+        self.bss_hostapd[0].wait_for_event("AP-ENABLED")
+
+        self.bss_hostapd[1].set_value('wpa_key_mgmt', 'FT-PSK')
+        self.bss_hostapd[1].set_value('ft_over_ds', '1')
+        self.bss_hostapd[1].reload()
+        self.bss_hostapd[1].wait_for_event("AP-ENABLED")
+
+        wd = IWD(True)
+
+        device = wd.list_devices(1)[0]
+
+        # Drop action frames, this will prevent FT-over-DS authentication
+        self.rule1.enabled = True
+
+        self.connect(wd, device, self.bss_hostapd[0])
+
+        device.roam(self.bss_hostapd[1].bssid)
+
+        self.rule1.enabled = False
+
+        # FT-over-DS should fail, and over-Air should take over leading to a
+        # successful roam
+        device.wait_for_event('try-ft-over-air')
+
+        self.verify_roam(wd, device, self.bss_hostapd[0], self.bss_hostapd[1])
+
+        self.bss_hostapd[1].deauthenticate(device.address)
+        condition = 'obj.state == DeviceState.disconnected'
+        wd.wait_for_object_condition(device, condition)
+
+    def tearDown(self):
+        os.system('ip link set "' + self.bss_hostapd[0].ifname + '" down')
+        os.system('ip link set "' + self.bss_hostapd[1].ifname + '" down')
+        os.system('ip link set "' + self.bss_hostapd[0].ifname + '" up')
+        os.system('ip link set "' + self.bss_hostapd[1].ifname + '" up')
+
+        self.rule0.enabled = False
+        self.rule1.enabled = False
+
+    @classmethod
+    def setUpClass(cls):
+        hwsim = Hwsim()
+
+        IWD.copy_to_storage('TestFT.psk')
+
+        cls.bss_hostapd = [ HostapdCLI(config='ft-psk-ccmp-1.conf'),
+                            HostapdCLI(config='ft-psk-ccmp-2.conf') ]
+
+        cls.bss_hostapd[0].set_address('12:00:00:00:00:01')
+        cls.bss_hostapd[1].set_address('12:00:00:00:00:02')
+
+        # Drop Authenticate frames
+        cls.rule0 = hwsim.rules.create()
+        cls.rule0.bidirectional = True
+        cls.rule0.prefix = 'b0'
+        cls.rule0.drop = True
+
+        # Drop Action frames
+        cls.rule1 = hwsim.rules.create()
+        cls.rule1.bidirectional = True
+        cls.rule1.prefix = 'd0'
+        cls.rule1.drop = True
+
+    @classmethod
+    def tearDownClass(cls):
+        IWD.clear_storage()
+        cls.bss_hostapd = None
+        cls.rule0.remove()
+        cls.rule1.remove()
+
+if __name__ == '__main__':
+    unittest.main(exit=True)
-- 
2.34.3

