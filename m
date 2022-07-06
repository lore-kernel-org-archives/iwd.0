Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03702F38
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 16:57:23 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id q9so22909361wrd.8
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 09:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1GFiqqMa2YO5HXWDu0dEmxwBCLaqGlCym1bFsiK29vs=;
        b=YCe96LtOcFMvDw5sk71BvMkjGjLxdeiH+hME4+ww9WvWR66DTKnKBQ3I409WAg8Qqi
         /yVLmM2Wo+DgVzJ1ci8MWnuXx96Doglyxh6R6P1vfeb6+t+WGV/NhZi29bT7NPQ0PPff
         ur+cSwMymzQQZxj9d2PTnWlyPajmuFyoqapWyOZys+TXRwgUDC/7+4xmJiuv9CLxjBad
         LjU5X9yXZWd121oVfQjU9qpPGd0gDufXa+OnAhOO5zjEj+slbnrEZWyybecyvmpsGcC6
         dS+uMgVNJ07Rh4FQ1cSI/KxavNNpf+5a4/3WdneuZVcjISj7uT3kjuEaPimlfqf+PMXt
         VJ2w==
X-Gm-Message-State: AJIora+Ie/zroTbA1l/Udeh7fiIbkBBwA/3cxRzKZHpY7eAFDO+OvJIT
	3B464jNFVokoPt5R/TXP8GI7hO3gCkmcHSyt
X-Google-Smtp-Source: AGRyM1uo7cCTqbViJoulRr/vCd2YT5LtN3NZ2c+eWsr5RL13kuV6e3ctb+qhZj0LO8pltnvpVNeumw==
X-Received: by 2002:a5d:6083:0:b0:21b:9e6c:1d1 with SMTP id w3-20020a5d6083000000b0021b9e6c01d1mr39083521wrt.264.1657126641323;
        Wed, 06 Jul 2022 09:57:21 -0700 (PDT)
Received: from localhost.localdomain ([46.222.51.165])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b0039c5642e430sm29147856wmq.20.2022.07.06.09.57.18
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 09:57:20 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 4/5] autotests: Reuse HostapdCLI objects
Date: Wed,  6 Jul 2022 18:57:01 +0200
Message-Id: <20220706165702.3241756-4-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220706165702.3241756-1-andrew.zaborowski@intel.com>
References: <20220706165702.3241756-1-andrew.zaborowski@intel.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TestContext.start_hostapd() in tools/run-tests already creates
HostapdCLI objects for every interface assigned to hostapd, try not to
create new HostapdCLI instances for those interfaces in each test.
---
 autotests/testAP/failure_test.py                      |  4 ++--
 autotests/testAP/validation.py                        |  4 ++--
 autotests/testAPRoam/connection_test.py               |  9 ++++-----
 autotests/testBSSBlacklist/connection_test.py         |  8 ++++----
 autotests/testChannelSwitch/connection_test.py        |  4 ++--
 autotests/testDPP/connection_test.py                  |  3 +--
 autotests/testDisconnectByAP/disconnect_by_ap_test.py |  5 ++---
 autotests/testEAP-PEAPv0-CryptoBinding/ISK_test.py    |  2 --
 autotests/testEAP-PEAPv0-CryptoBinding/NoISK_test.py  |  5 ++---
 autotests/testEAP-WPS-Frag/wps_frag_test.py           |  5 ++---
 autotests/testEAP-WPS/four_digit_pin_test.py          |  3 +--
 autotests/testEAP-WPS/pin_test.py                     |  4 +---
 autotests/testEAP-WPS/push_button_test.py             |  3 +--
 autotests/testEAP/connection_test.py                  |  3 +--
 autotests/testEAPoL-spoofing/connection_test.py       |  4 ++--
 autotests/testFILS/fils_256_test.py                   |  4 ++--
 autotests/testFILS/fils_384_test.py                   |  4 ++--
 autotests/testFT-8021x-roam/connection_test.py        |  6 +++---
 autotests/testFT-FILS/connection_test.py              |  6 +++---
 autotests/testHT-VHT/connection_test.py               |  8 ++++----
 autotests/testHotspot/autoconnect_test.py             |  6 +++---
 autotests/testHotspot/hessid_test.py                  |  4 ++--
 autotests/testHotspot/hotspot_test.py                 |  6 +++---
 autotests/testHotspot/roaming_test.py                 |  4 ++--
 autotests/testNetconfig/connection_test.py            |  3 +--
 autotests/testNetconfig/static_test.py                |  3 +--
 autotests/testOWE-transition/connection_test.py       | 10 +++++-----
 autotests/testOWE/connection_test.py                  |  8 ++++----
 autotests/testPSK-roam/connection_test.py             |  6 +++---
 autotests/testPSK-roam/roam_ap_disconnect_test.py     |  6 +++---
 autotests/testPreauth-roam/connection_test.py         |  6 +++---
 autotests/testRRM/connection_test.py                  |  4 ++--
 autotests/testRoamRetry/fast_retry_test.py            |  6 +++---
 autotests/testRoamRetry/stop_retry_test.py            |  6 +++---
 autotests/testSAE-AntiClogging/clogging_test.py       |  4 ++--
 autotests/testSAE-roam/connection_test.py             |  7 +++----
 autotests/testSAE/autoconnect_test.py                 |  4 ++--
 autotests/testSAE/connection_test.py                  |  4 ++--
 autotests/testSAE/failure_test.py                     |  4 ++--
 autotests/testSAE/timeout_test.py                     |  5 ++---
 autotests/testSAQuery-spoofing/connection_test.py     |  4 ++--
 autotests/testSAQuery/connection_test.py              |  4 ++--
 autotests/testWPA2-ext-key-id/connection_test.py      | 10 ++++------
 43 files changed, 100 insertions(+), 118 deletions(-)

diff --git a/autotests/testAP/failure_test.py b/autotests/testAP/failure_test.py
index 4bd4a2aa..8888481f 100644
--- a/autotests/testAP/failure_test.py
+++ b/autotests/testAP/failure_test.py
@@ -8,13 +8,13 @@ import iwd
 from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
-from hostapd import HostapdCLI
+from config import ctx
 import testutil
 
 class Test(unittest.TestCase):
 
     def client_connect(self, wd, dev):
-        hostapd = HostapdCLI(config='psk-ccmp.conf')
+        hostapd = ctx.get_hapd_instance('psk-ccmp.conf').cli
 
         ordered_network = dev.get_ordered_network('TestAP1', True)
 
diff --git a/autotests/testAP/validation.py b/autotests/testAP/validation.py
index b1b867ef..4b195a55 100644
--- a/autotests/testAP/validation.py
+++ b/autotests/testAP/validation.py
@@ -1,6 +1,6 @@
 from iwd import PSKAgent
 from iwd import NetworkType
-from hostapd import HostapdCLI
+from config import ctx
 import testutil
 
 def validate(wd, sta_dev, ap_dev, ssid, passphrase,
@@ -45,7 +45,7 @@ def validate(wd, sta_dev, ap_dev, ssid, passphrase,
             ap_dev.stop_ap()
 
 def client_connect(wd, dev, ssid):
-    hostapd = HostapdCLI(config='psk-ccmp.conf')
+    hostapd = ctx.get_hapd_instance('psk-ccmp.conf').cli
 
     ordered_network = dev.get_ordered_network(ssid)
 
diff --git a/autotests/testAPRoam/connection_test.py b/autotests/testAPRoam/connection_test.py
index 41d70f3a..e299810f 100644
--- a/autotests/testAPRoam/connection_test.py
+++ b/autotests/testAPRoam/connection_test.py
@@ -7,15 +7,14 @@ sys.path.append('../util')
 import iwd
 from iwd import IWD
 from iwd import NetworkType
-
-from hostapd import HostapdCLI
+from config import ctx
 
 class Test(unittest.TestCase):
 
     def test_connection_success(self):
-        bss_hostapd = [ HostapdCLI(config='ssid1.conf'),
-                        HostapdCLI(config='ssid2.conf'),
-                        HostapdCLI(config='ssid3.conf') ]
+        bss_hostapd = [ ctx.get_hapd_instance('ssid1.conf').cli,
+                        ctx.get_hapd_instance('ssid2.conf').cli,
+                        ctx.get_hapd_instance('ssid3.conf').cli ]
 
         wd = IWD()
 
diff --git a/autotests/testBSSBlacklist/connection_test.py b/autotests/testBSSBlacklist/connection_test.py
index 9631a322..35f33671 100644
--- a/autotests/testBSSBlacklist/connection_test.py
+++ b/autotests/testBSSBlacklist/connection_test.py
@@ -9,8 +9,8 @@ from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
 from iwd import IWD_CONFIG_DIR
+from config import ctx
 
-from hostapd import HostapdCLI
 from hwsim import Hwsim
 
 import time
@@ -271,9 +271,9 @@ class Test(unittest.TestCase):
     def setUpClass(cls):
         cls.hwsim = Hwsim()
 
-        cls.bss_hostapd = [ HostapdCLI(config='ssid1.conf'),
-                            HostapdCLI(config='ssid2.conf'),
-                            HostapdCLI(config='ssid3.conf') ]
+        cls.bss_hostapd = [ ctx.get_hapd_instance('ssid1.conf').cli,
+                            ctx.get_hapd_instance('ssid2.conf').cli,
+                            ctx.get_hapd_instance('ssid3.conf').cli ]
         cls.bss_radio =  [ cls.hwsim.get_radio('rad0'),
                        cls.hwsim.get_radio('rad1'),
                        cls.hwsim.get_radio('rad2') ]
diff --git a/autotests/testChannelSwitch/connection_test.py b/autotests/testChannelSwitch/connection_test.py
index 03d24a77..5a8e8d62 100644
--- a/autotests/testChannelSwitch/connection_test.py
+++ b/autotests/testChannelSwitch/connection_test.py
@@ -8,13 +8,13 @@ import iwd
 from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
-from hostapd import HostapdCLI
+from config import ctx
 import testutil
 
 class Test(unittest.TestCase):
 
     def test_connection_success(self):
-        hapd = HostapdCLI()
+        hapd = ctx.get_hapd_instance().cli
         wd = IWD()
 
         psk_agent = PSKAgent("secret123")
diff --git a/autotests/testDPP/connection_test.py b/autotests/testDPP/connection_test.py
index 0cab5ff1..8e2cbf38 100644
--- a/autotests/testDPP/connection_test.py
+++ b/autotests/testDPP/connection_test.py
@@ -7,7 +7,6 @@ sys.path.append('../util')
 from iwd import IWD
 from iwd import DeviceProvisioning
 from wpas import Wpas
-from hostapd import HostapdCLI
 from hwsim import Hwsim
 from config import ctx
 
@@ -136,7 +135,7 @@ class Test(unittest.TestCase):
         self.wpas = Wpas('wpas.conf')
         self.wd = IWD(True)
         self.device = self.wd.list_devices(1)[0]
-        self.hapd = HostapdCLI('hostapd.conf')
+        self.hapd = ctx.get_hapd_instance('hostapd.conf').cli
         self.hapd.disable()
         self.hwsim = Hwsim()
 
diff --git a/autotests/testDisconnectByAP/disconnect_by_ap_test.py b/autotests/testDisconnectByAP/disconnect_by_ap_test.py
index f3c71358..d62825b8 100644
--- a/autotests/testDisconnectByAP/disconnect_by_ap_test.py
+++ b/autotests/testDisconnectByAP/disconnect_by_ap_test.py
@@ -8,8 +8,7 @@ import iwd
 from iwd import IWD
 from iwd import DeviceState
 from iwd import NetworkType
-
-from hostapd import HostapdCLI
+from config import ctx
 
 class Test(unittest.TestCase):
 
@@ -19,7 +18,7 @@ class Test(unittest.TestCase):
         devices = wd.list_devices(1)
         device = devices[0]
 
-        hostapd = HostapdCLI(config='ssidOpen.conf')
+        hostapd = ctx.get_hapd_instance('ssidOpen.conf').cli
 
         ordered_network = device.get_ordered_network('ssidOpen', full_scan=True)
 
diff --git a/autotests/testEAP-PEAPv0-CryptoBinding/ISK_test.py b/autotests/testEAP-PEAPv0-CryptoBinding/ISK_test.py
index 07382623..f01de812 100644
--- a/autotests/testEAP-PEAPv0-CryptoBinding/ISK_test.py
+++ b/autotests/testEAP-PEAPv0-CryptoBinding/ISK_test.py
@@ -10,8 +10,6 @@ from iwd import IWD
 from iwd import NetworkType
 import testutil
 
-from hostapd import HostapdCLI
-
 class Test(unittest.TestCase):
 
     def validate_connection(self, wd):
diff --git a/autotests/testEAP-PEAPv0-CryptoBinding/NoISK_test.py b/autotests/testEAP-PEAPv0-CryptoBinding/NoISK_test.py
index 0323fdc1..9248120f 100644
--- a/autotests/testEAP-PEAPv0-CryptoBinding/NoISK_test.py
+++ b/autotests/testEAP-PEAPv0-CryptoBinding/NoISK_test.py
@@ -9,13 +9,12 @@ import iwd
 from iwd import IWD
 from iwd import NetworkType
 import testutil
-
-from hostapd import HostapdCLI
+from config import ctx
 
 class Test(unittest.TestCase):
 
     def validate_connection(self, wd):
-        hostapd = HostapdCLI(config='ssidEAP-PEAPv0-NoISK.conf')
+        hostapd = ctx.get_hapd_instance('ssidEAP-PEAPv0-NoISK.conf').cli
 
         self.assertIsNotNone(hostapd)
 
diff --git a/autotests/testEAP-WPS-Frag/wps_frag_test.py b/autotests/testEAP-WPS-Frag/wps_frag_test.py
index dcaf1ae2..8036cc17 100644
--- a/autotests/testEAP-WPS-Frag/wps_frag_test.py
+++ b/autotests/testEAP-WPS-Frag/wps_frag_test.py
@@ -7,8 +7,7 @@ sys.path.append('../util')
 import iwd
 from iwd import IWD
 from iwd import DeviceState
-
-from hostapd import HostapdCLI
+from config import ctx
 
 class Test(unittest.TestCase):
 
@@ -31,7 +30,7 @@ class Test(unittest.TestCase):
 
     @classmethod
     def setUpClass(cls):
-        cls.hostapd = HostapdCLI(config='ssid-wps-small-mtu.conf')
+        cls.hostapd = ctx.get_hapd_instance('ssid-wps-small-mtu.conf').cli
 
         cls.hostapd.wps_push_button()
 
diff --git a/autotests/testEAP-WPS/four_digit_pin_test.py b/autotests/testEAP-WPS/four_digit_pin_test.py
index d30492fb..ba98aac1 100644
--- a/autotests/testEAP-WPS/four_digit_pin_test.py
+++ b/autotests/testEAP-WPS/four_digit_pin_test.py
@@ -5,7 +5,6 @@ import sys
 
 sys.path.append('../util')
 from iwd import IWD
-from hostapd import HostapdCLI
 from config import ctx
 
 class Test(unittest.TestCase):
@@ -44,7 +43,7 @@ class Test(unittest.TestCase):
 
     @classmethod
     def setUpClass(cls):
-        cls.hostapd = HostapdCLI(config='ssidWPS.conf')
+        cls.hostapd = ctx.get_hapd_instance('ssidWPS.conf').cli
 
     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testEAP-WPS/pin_test.py b/autotests/testEAP-WPS/pin_test.py
index e2fef335..57dc07e6 100644
--- a/autotests/testEAP-WPS/pin_test.py
+++ b/autotests/testEAP-WPS/pin_test.py
@@ -8,8 +8,6 @@ import iwd
 from iwd import IWD
 from iwd import DeviceState
 
-from hostapd import HostapdCLI
-
 class Test(unittest.TestCase):
 
     def pin_success(self, wd):
@@ -41,7 +39,7 @@ class Test(unittest.TestCase):
 
     @classmethod
     def setUpClass(cls):
-        cls.hostapd = HostapdCLI(config='ssidWPS.conf')
+        cls.hostapd = ctx.get_hapd_instance('ssidWPS.conf').cli
 
     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testEAP-WPS/push_button_test.py b/autotests/testEAP-WPS/push_button_test.py
index e2b4c2b2..bc29fd4c 100644
--- a/autotests/testEAP-WPS/push_button_test.py
+++ b/autotests/testEAP-WPS/push_button_test.py
@@ -5,7 +5,6 @@ import sys
 
 sys.path.append('../util')
 from iwd import IWD
-from hostapd import HostapdCLI
 from config import ctx
 
 class Test(unittest.TestCase):
@@ -43,7 +42,7 @@ class Test(unittest.TestCase):
 
     @classmethod
     def setUpClass(cls):
-        cls.hostapd = HostapdCLI(config='ssidWPS.conf')
+        cls.hostapd = ctx.get_hapd_instance('ssidWPS.conf').cli
 
     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testEAP/connection_test.py b/autotests/testEAP/connection_test.py
index fe048b48..44ba9cae 100644
--- a/autotests/testEAP/connection_test.py
+++ b/autotests/testEAP/connection_test.py
@@ -11,7 +11,6 @@ from iwd import PSKAgent
 from hlrauc import AuthCenter
 from ofono import Ofono
 from config import ctx
-from hostapd import HostapdCLI
 
 import testutil
 import traceback
@@ -255,7 +254,7 @@ class Test(unittest.TestCase):
     @classmethod
     def setUpClass(cls):
         cls.wd = IWD()
-        cls.hostapd = HostapdCLI()
+        cls.hostapd = ctx.get_hapd_instance().cli
 
     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testEAPoL-spoofing/connection_test.py b/autotests/testEAPoL-spoofing/connection_test.py
index ecddddd6..16f0d39f 100644
--- a/autotests/testEAPoL-spoofing/connection_test.py
+++ b/autotests/testEAPoL-spoofing/connection_test.py
@@ -9,7 +9,7 @@ from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
 from hwsim import Hwsim
-from hostapd import HostapdCLI
+from config import ctx
 
 from time import sleep
 
@@ -18,7 +18,7 @@ class Test(unittest.TestCase):
     def test_connection_success(self):
         hwsim = Hwsim()
 
-        hostapd = HostapdCLI(config='ssidCCMP.conf')
+        hostapd = ctx.get_hapd_instance('ssidCCMP.conf').cli
         radio = hwsim.get_radio('rad0')
 
         wd = IWD()
diff --git a/autotests/testFILS/fils_256_test.py b/autotests/testFILS/fils_256_test.py
index 5fa371e1..3451932c 100644
--- a/autotests/testFILS/fils_256_test.py
+++ b/autotests/testFILS/fils_256_test.py
@@ -8,12 +8,12 @@ sys.path.append('../util')
 import iwd
 from iwd import IWD
 from iwd import NetworkType
-from hostapd import HostapdCLI
+from config import ctx
 import testutil
 
 class Test(unittest.TestCase):
     def test_connection_success(self):
-        hapd = HostapdCLI(config='ssidFILS-256.conf')
+        hapd = ctx.get_hapd_instance('ssidFILS-256.conf').cli
 
         wd = IWD(True)
 
diff --git a/autotests/testFILS/fils_384_test.py b/autotests/testFILS/fils_384_test.py
index b7174418..43ce6dec 100644
--- a/autotests/testFILS/fils_384_test.py
+++ b/autotests/testFILS/fils_384_test.py
@@ -8,12 +8,12 @@ sys.path.append('../util')
 import iwd
 from iwd import IWD
 from iwd import NetworkType
-from hostapd import HostapdCLI
+from config import ctx
 import testutil
 
 class Test(unittest.TestCase):
     def test_connection_success(self):
-        hapd = HostapdCLI(config='ssidFILS-384.conf')
+        hapd = ctx.get_hapd_instance('ssidFILS-384.conf').cli
 
         wd = IWD(True)
 
diff --git a/autotests/testFT-8021x-roam/connection_test.py b/autotests/testFT-8021x-roam/connection_test.py
index 6853bdb0..a928441a 100644
--- a/autotests/testFT-8021x-roam/connection_test.py
+++ b/autotests/testFT-8021x-roam/connection_test.py
@@ -6,7 +6,7 @@ import sys, os
 sys.path.append('../util')
 from iwd import IWD
 from iwd import NetworkType
-from hostapd import HostapdCLI
+from config import ctx
 import testutil
 
 class Test(unittest.TestCase):
@@ -63,8 +63,8 @@ class Test(unittest.TestCase):
     def setUpClass(cls):
         IWD.copy_to_storage('TestFT.8021x')
 
-        cls.bss_hostapd = [ HostapdCLI(config='ft-eap-ccmp-1.conf'),
-                            HostapdCLI(config='ft-eap-ccmp-2.conf') ]
+        cls.bss_hostapd = [ ctx.get_hapd_instance('ft-eap-ccmp-1.conf').cli,
+                            ctx.get_hapd_instance('ft-eap-ccmp-2.conf').cli ]
 
         # Set interface addresses to those expected by hostapd config files
         os.system('ip link set dev "' + cls.bss_hostapd[0].ifname + '" down')
diff --git a/autotests/testFT-FILS/connection_test.py b/autotests/testFT-FILS/connection_test.py
index c1deb77c..dc7b0ce9 100644
--- a/autotests/testFT-FILS/connection_test.py
+++ b/autotests/testFT-FILS/connection_test.py
@@ -6,7 +6,7 @@ import sys, os
 sys.path.append('../util')
 from iwd import IWD
 from iwd import NetworkType
-from hostapd import HostapdCLI
+from config import ctx
 import testutil
 
 class Test(unittest.TestCase):
@@ -125,8 +125,8 @@ class Test(unittest.TestCase):
         os.system('ip link set lo up')
         IWD.copy_to_storage('TestFT.8021x')
 
-        cls.bss_hostapd = [ HostapdCLI(config='ft-eap-ccmp-1.conf'),
-                            HostapdCLI(config='ft-eap-ccmp-2.conf') ]
+        cls.bss_hostapd = [ ctx.get_hapd_instance('ft-eap-ccmp-1.conf').cli,
+                            ctx.get_hapd_instance('ft-eap-ccmp-2.conf').cli ]
 
         # Set interface addresses to those expected by hostapd config files
         os.system('ip link set dev "' + cls.bss_hostapd[0].ifname + '" down')
diff --git a/autotests/testHT-VHT/connection_test.py b/autotests/testHT-VHT/connection_test.py
index 0297cb9b..f24db787 100644
--- a/autotests/testHT-VHT/connection_test.py
+++ b/autotests/testHT-VHT/connection_test.py
@@ -10,7 +10,7 @@ from iwd import PSKAgent
 from iwd import NetworkType
 from hwsim import Hwsim
 import testutil
-from hostapd import HostapdCLI
+from config import ctx
 
 class Test(unittest.TestCase):
     def do_connect(self, wd, device, hostapd):
@@ -40,9 +40,9 @@ class Test(unittest.TestCase):
 
     def test_connection_success(self):
         hwsim = Hwsim()
-        non_ht_hostapd = HostapdCLI(config='non-ht-vht.conf')
-        ht_hostapd = HostapdCLI(config='ht.conf')
-        vht_hostapd = HostapdCLI(config='vht.conf')
+        non_ht_hostapd = ctx.get_hapd_instance('non-ht-vht.conf').cli
+        ht_hostapd = ctx.get_hapd_instance('ht.conf').cli
+        vht_hostapd = ctx.get_hapd_instance('vht.conf').cli
         non_ht_radio = hwsim.get_radio('rad0')
         ht_radio = hwsim.get_radio('rad1')
         vht_radio = hwsim.get_radio('rad2')
diff --git a/autotests/testHotspot/autoconnect_test.py b/autotests/testHotspot/autoconnect_test.py
index 8b718dc7..a858e702 100644
--- a/autotests/testHotspot/autoconnect_test.py
+++ b/autotests/testHotspot/autoconnect_test.py
@@ -8,7 +8,7 @@ sys.path.append('../util')
 from iwd import IWD
 from iwd import IWD_CONFIG_DIR
 from iwd import NetworkType
-from hostapd import HostapdCLI
+from config import ctx
 import testutil
 
 class Test(unittest.TestCase):
@@ -16,8 +16,8 @@ class Test(unittest.TestCase):
     def test_connection_success(self):
         wd = self.wd
 
-        hapd_hotspot = HostapdCLI(config='ssidHotspot.conf')
-        hapd_wpa = HostapdCLI(config='ssidWPA2-1.conf')
+        hapd_hotspot = ctx.get_hapd_instance('ssidHotspot.conf').cli
+        hapd_wpa = ctx.get_hapd_instance('ssidWPA2-1.conf').cli
 
         self.assertEqual(len(wd.list_known_networks()), 2)
 
diff --git a/autotests/testHotspot/hessid_test.py b/autotests/testHotspot/hessid_test.py
index 4a47e5c7..1711dc65 100644
--- a/autotests/testHotspot/hessid_test.py
+++ b/autotests/testHotspot/hessid_test.py
@@ -9,7 +9,7 @@ from iwd import IWD
 from iwd import IWD_CONFIG_DIR
 from iwd import PSKAgent
 from iwd import NetworkType
-from hostapd import HostapdCLI
+from config import ctx
 import testutil
 
 class Test(unittest.TestCase):
@@ -17,7 +17,7 @@ class Test(unittest.TestCase):
     def test_connection_success(self):
         wd = self.wd
 
-        hapd = HostapdCLI(config='ssidHotspot.conf')
+        hapd = ctx.get_hapd_instance('ssidHotspot.conf').cli
 
         psk_agent = PSKAgent('abc', ('domain\\user', 'testpasswd'))
         wd.register_psk_agent(psk_agent)
diff --git a/autotests/testHotspot/hotspot_test.py b/autotests/testHotspot/hotspot_test.py
index ed9ee830..ec075d5a 100644
--- a/autotests/testHotspot/hotspot_test.py
+++ b/autotests/testHotspot/hotspot_test.py
@@ -9,7 +9,7 @@ from iwd import IWD
 from iwd import IWD_CONFIG_DIR
 from iwd import PSKAgent
 from iwd import NetworkType
-from hostapd import HostapdCLI
+from config import ctx
 import testutil
 
 class Test(unittest.TestCase):
@@ -53,14 +53,14 @@ class Test(unittest.TestCase):
         wd.unregister_psk_agent(psk_agent)
 
     def test_hotspot(self):
-        hapd = HostapdCLI(config='ssidHotspot.conf')
+        hapd = ctx.get_hapd_instance('ssidHotspot.conf').cli
         hapd.set_value('disable_dgaf', '0')
         hapd.reload()
 
         self.validate_connection(self.wd, hapd)
 
     def test_dgaf_disabled(self):
-        hapd = HostapdCLI(config='ssidHotspot.conf')
+        hapd = ctx.get_hapd_instance('ssidHotspot.conf').cli
         hapd.set_value('disable_dgaf', '1')
         hapd.reload()
 
diff --git a/autotests/testHotspot/roaming_test.py b/autotests/testHotspot/roaming_test.py
index 1d785700..8ca964ce 100644
--- a/autotests/testHotspot/roaming_test.py
+++ b/autotests/testHotspot/roaming_test.py
@@ -9,7 +9,7 @@ from iwd import IWD
 from iwd import IWD_CONFIG_DIR
 from iwd import PSKAgent
 from iwd import NetworkType
-from hostapd import HostapdCLI
+from config import ctx
 import testutil
 
 class Test(unittest.TestCase):
@@ -17,7 +17,7 @@ class Test(unittest.TestCase):
     def test_connection_success(self):
         wd = self.wd
 
-        hapd = HostapdCLI(config='ssidHotspot.conf')
+        hapd = ctx.get_hapd_instance('ssidHotspot.conf').cli
 
         devices = wd.list_devices(1)
         device = devices[0]
diff --git a/autotests/testNetconfig/connection_test.py b/autotests/testNetconfig/connection_test.py
index cf90993a..d13be7e0 100644
--- a/autotests/testNetconfig/connection_test.py
+++ b/autotests/testNetconfig/connection_test.py
@@ -8,7 +8,6 @@ import iwd
 from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
-from hostapd import HostapdCLI
 import testutil
 from config import ctx
 import os
@@ -195,7 +194,7 @@ class Test(unittest.TestCase):
                 pass
 
         cls.ns1 = ctx.get_namespace('ns1')
-        cls.hapd = HostapdCLI('ap-ns1.conf')
+        cls.hapd = ctx.get_hapd_instance('ap-ns1.conf').cli
         # TODO: This could be moved into test-runner itself if other tests ever
         #       require this functionality (p2p, FILS, etc.). Since its simple
         #       enough it can stay here for now.
diff --git a/autotests/testNetconfig/static_test.py b/autotests/testNetconfig/static_test.py
index 01d694ca..a4f33614 100644
--- a/autotests/testNetconfig/static_test.py
+++ b/autotests/testNetconfig/static_test.py
@@ -8,7 +8,6 @@ import iwd
 from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
-from hostapd import HostapdCLI
 import testutil
 from config import ctx
 import os
@@ -117,7 +116,7 @@ class Test(unittest.TestCase):
             except:
                 pass
 
-        hapd = HostapdCLI('ap-main.conf')
+        hapd = ctx.get_hapd_instance('ap-main.conf').cli
         # TODO: This could be moved into test-runner itself if other tests ever
         #       require this functionality (p2p, FILS, etc.). Since it's simple
         #       enough it can stay here for now.
diff --git a/autotests/testOWE-transition/connection_test.py b/autotests/testOWE-transition/connection_test.py
index 89f97338..c3878b15 100644
--- a/autotests/testOWE-transition/connection_test.py
+++ b/autotests/testOWE-transition/connection_test.py
@@ -7,7 +7,7 @@ sys.path.append('../util')
 import iwd
 from iwd import IWD
 from iwd import NetworkType
-from hostapd import HostapdCLI
+from config import ctx
 from hwsim import Hwsim
 import testutil
 
@@ -234,10 +234,10 @@ class Test(unittest.TestCase):
 
     def setUp(self):
         self.wd = IWD(True)
-        self.hapd_owe = HostapdCLI(config='ssidOWE.conf')
-        self.hapd_open = HostapdCLI(config='ssidOpen.conf')
-        self.hapd_owe2 = HostapdCLI(config='ssidOWE-2.conf')
-        self.hapd_open2 = HostapdCLI(config='ssidOpen-2.conf')
+        self.hapd_owe = ctx.get_hapd_instance('ssidOWE.conf').cli
+        self.hapd_open = ctx.get_hapd_instance('ssidOpen.conf').cli
+        self.hapd_owe2 = ctx.get_hapd_instance('ssidOWE-2.conf').cli
+        self.hapd_open2 = ctx.get_hapd_instance('ssidOpen-2.conf').cli
 
         self.hwsim = Hwsim()
 
diff --git a/autotests/testOWE/connection_test.py b/autotests/testOWE/connection_test.py
index 391d8cf5..ac7b954f 100644
--- a/autotests/testOWE/connection_test.py
+++ b/autotests/testOWE/connection_test.py
@@ -7,13 +7,13 @@ sys.path.append('../util')
 import iwd
 from iwd import IWD
 from iwd import NetworkType
-from hostapd import HostapdCLI
+from config import ctx
 import testutil
 
 class Test(unittest.TestCase):
 
     def test_connection_success(self):
-        hapd = HostapdCLI(config='ssidOWE-1.conf')
+        hapd = ctx.get_hapd_instance('ssidOWE-1.conf').cli
 
         wd = IWD()
 
@@ -33,8 +33,8 @@ class Test(unittest.TestCase):
         device.disconnect()
 
     def test_reassociate(self):
-        hapd0 = HostapdCLI(config='ssidOWE-1.conf')
-        hapd1 = HostapdCLI(config='ssidOWE-2.conf')
+        hapd0 = ctx.get_hapd_instance('ssidOWE-1.conf').cli
+        hapd1 = ctx.get_hapd_instance('ssidOWE-2.conf').cli
 
         wd = IWD()
 
diff --git a/autotests/testPSK-roam/connection_test.py b/autotests/testPSK-roam/connection_test.py
index f1b43130..8a3a6bcc 100644
--- a/autotests/testPSK-roam/connection_test.py
+++ b/autotests/testPSK-roam/connection_test.py
@@ -9,7 +9,7 @@ from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
 from hwsim import Hwsim
-from hostapd import HostapdCLI
+from config import ctx
 import testutil
 
 class Test(unittest.TestCase):
@@ -146,8 +146,8 @@ class Test(unittest.TestCase):
 
         IWD.copy_to_storage('TestFT.psk')
 
-        cls.bss_hostapd = [ HostapdCLI(config='ft-psk-ccmp-1.conf'),
-                            HostapdCLI(config='ft-psk-ccmp-2.conf') ]
+        cls.bss_hostapd = [ ctx.get_hapd_instance('ft-psk-ccmp-1.conf').cli,
+                            ctx.get_hapd_instance('ft-psk-ccmp-2.conf').cli ]
         rad2 = hwsim.get_radio('rad2')
 
         cls.rule0 = hwsim.rules.create()
diff --git a/autotests/testPSK-roam/roam_ap_disconnect_test.py b/autotests/testPSK-roam/roam_ap_disconnect_test.py
index 760c25fa..f3fbe658 100644
--- a/autotests/testPSK-roam/roam_ap_disconnect_test.py
+++ b/autotests/testPSK-roam/roam_ap_disconnect_test.py
@@ -7,7 +7,7 @@ sys.path.append('../util')
 from iwd import IWD
 from iwd import NetworkType
 from hwsim import Hwsim
-from hostapd import HostapdCLI
+from config import ctx
 
 class Test(unittest.TestCase):
     #
@@ -72,8 +72,8 @@ class Test(unittest.TestCase):
 
         IWD.copy_to_storage('TestFT.psk')
 
-        cls.bss_hostapd = [ HostapdCLI(config='ft-psk-ccmp-1.conf'),
-                            HostapdCLI(config='ft-psk-ccmp-2.conf') ]
+        cls.bss_hostapd = [ ctx.get_hapd_instance('ft-psk-ccmp-1.conf').cli,
+                            ctx.get_hapd_instance('ft-psk-ccmp-2.conf').cli ]
         cls.bss_hostapd[1].disable()
 
         cls.bss_hostapd[0].set_value('ocv', '0')
diff --git a/autotests/testPreauth-roam/connection_test.py b/autotests/testPreauth-roam/connection_test.py
index 26475698..857cd51c 100644
--- a/autotests/testPreauth-roam/connection_test.py
+++ b/autotests/testPreauth-roam/connection_test.py
@@ -6,13 +6,13 @@ import sys, os
 sys.path.append('../util')
 from iwd import IWD
 from iwd import NetworkType
-from hostapd import HostapdCLI
+from config import ctx
 import testutil
 
 class Test(unittest.TestCase):
     def test_preauth_success(self):
-        bss_hostapd = [ HostapdCLI(config='eaptls-preauth-1.conf'),
-                        HostapdCLI(config='eaptls-preauth-2.conf') ]
+        bss_hostapd = [ ctx.get_hapd_instance('eaptls-preauth-1.conf').cli,
+                        ctx.get_hapd_instance('eaptls-preauth-2.conf').cli ]
 
         bss0_addr = bss_hostapd[0].bssid
         bss1_addr = bss_hostapd[1].bssid
diff --git a/autotests/testRRM/connection_test.py b/autotests/testRRM/connection_test.py
index 4d894958..412bf6cb 100644
--- a/autotests/testRRM/connection_test.py
+++ b/autotests/testRRM/connection_test.py
@@ -8,7 +8,7 @@ import iwd
 from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
-from hostapd import HostapdCLI
+from config import ctx
 import testutil
 
 # Table beacon with wildcard BSSID
@@ -25,7 +25,7 @@ beacon_passive_duration = '510b0000c80000ffffffffffff020100'
 class Test(unittest.TestCase):
 
     def test_connection_success(self):
-        hapd = HostapdCLI(config='ssidRRM.conf')
+        hapd = ctx.get_hapd_instance('ssidRRM.conf').cli
         wd = IWD()
 
         psk_agent = PSKAgent("secret123")
diff --git a/autotests/testRoamRetry/fast_retry_test.py b/autotests/testRoamRetry/fast_retry_test.py
index b45daada..4d9c52f0 100644
--- a/autotests/testRoamRetry/fast_retry_test.py
+++ b/autotests/testRoamRetry/fast_retry_test.py
@@ -8,10 +8,10 @@ import iwd
 from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
+from config import ctx
 
 import testutil
 
-from hostapd import HostapdCLI
 from hwsim import Hwsim
 
 class Test(unittest.TestCase):
@@ -21,8 +21,8 @@ class Test(unittest.TestCase):
     def test_fast_retry(self):
         hwsim = Hwsim()
 
-        bss_hostapd = [ HostapdCLI(config='ssid1.conf'),
-                        HostapdCLI(config='ssid2.conf') ]
+        bss_hostapd = [ ctx.get_hapd_instance('ssid1.conf').cli,
+                        ctx.get_hapd_instance('ssid2.conf').cli ]
         bss_radio =  [ hwsim.get_radio('rad0'),
                        hwsim.get_radio('rad1') ]
 
diff --git a/autotests/testRoamRetry/stop_retry_test.py b/autotests/testRoamRetry/stop_retry_test.py
index 3957d12d..b9b323f1 100644
--- a/autotests/testRoamRetry/stop_retry_test.py
+++ b/autotests/testRoamRetry/stop_retry_test.py
@@ -8,10 +8,10 @@ import iwd
 from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
+from config import ctx
 
 import testutil
 
-from hostapd import HostapdCLI
 from hwsim import Hwsim
 
 class Test(unittest.TestCase):
@@ -20,8 +20,8 @@ class Test(unittest.TestCase):
     def test_stop_retry(self):
         hwsim = Hwsim()
 
-        bss_hostapd = [ HostapdCLI(config='ssid1.conf'),
-                        HostapdCLI(config='ssid2.conf') ]
+        bss_hostapd = [ ctx.get_hapd_instance('ssid1.conf').cli,
+                        ctx.get_hapd_instance('ssid2.conf').cli ]
         bss_radio =  [ hwsim.get_radio('rad0'),
                        hwsim.get_radio('rad1') ]
 
diff --git a/autotests/testSAE-AntiClogging/clogging_test.py b/autotests/testSAE-AntiClogging/clogging_test.py
index 172dfecf..b61f21ee 100644
--- a/autotests/testSAE-AntiClogging/clogging_test.py
+++ b/autotests/testSAE-AntiClogging/clogging_test.py
@@ -8,7 +8,7 @@ import iwd
 from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
-from hostapd import HostapdCLI
+from config import ctx
 
 class Test(unittest.TestCase):
 
@@ -65,7 +65,7 @@ class Test(unittest.TestCase):
 
     @classmethod
     def setUpClass(cls):
-        cls.hostapd = HostapdCLI(config='ssidSAE-Clogging.conf')
+        cls.hostapd = ctx.get_hapd_instance('ssidSAE-Clogging.conf').cli
 
     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testSAE-roam/connection_test.py b/autotests/testSAE-roam/connection_test.py
index 2c8cd799..3fad22b9 100644
--- a/autotests/testSAE-roam/connection_test.py
+++ b/autotests/testSAE-roam/connection_test.py
@@ -8,7 +8,6 @@ import iwd
 from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
-from hostapd import HostapdCLI
 import testutil
 from config import ctx
 
@@ -116,9 +115,9 @@ class Test(unittest.TestCase):
 
     @classmethod
     def setUpClass(cls):
-        cls.bss_hostapd = [ HostapdCLI(config='ft-sae-1.conf'),
-                            HostapdCLI(config='ft-sae-2.conf'),
-                            HostapdCLI(config='ft-psk-3.conf') ]
+        cls.bss_hostapd = [ ctx.get_hapd_instance('ft-sae-1.conf').cli,
+                            ctx.get_hapd_instance('ft-sae-2.conf').cli,
+                            ctx.get_hapd_instance('ft-psk-3.conf').cli ]
 
         ctx.start_process(['ip', 'link', 'set', 'dev', cls.bss_hostapd[0].ifname, 'down']).wait()
         ctx.start_process(['ip', 'link', 'set', 'dev', cls.bss_hostapd[0].ifname, \
diff --git a/autotests/testSAE/autoconnect_test.py b/autotests/testSAE/autoconnect_test.py
index 64a60e7c..9bfb33ec 100644
--- a/autotests/testSAE/autoconnect_test.py
+++ b/autotests/testSAE/autoconnect_test.py
@@ -8,7 +8,7 @@ import iwd
 from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
-from hostapd import HostapdCLI
+from config import ctx
 
 class Test(unittest.TestCase):
 
@@ -53,7 +53,7 @@ class Test(unittest.TestCase):
 
     @classmethod
     def setUpClass(cls):
-        cls.hostapd = HostapdCLI(config='ssidSAE.conf')
+        cls.hostapd = ctx.get_hapd_instance('ssidSAE.conf').cli
         IWD.copy_to_storage('ssidSAE.psk')
         pass
 
diff --git a/autotests/testSAE/connection_test.py b/autotests/testSAE/connection_test.py
index c67f8c83..4e7e98bc 100644
--- a/autotests/testSAE/connection_test.py
+++ b/autotests/testSAE/connection_test.py
@@ -8,7 +8,7 @@ import iwd
 from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
-from hostapd import HostapdCLI
+from config import ctx
 import testutil
 
 class Test(unittest.TestCase):
@@ -95,7 +95,7 @@ class Test(unittest.TestCase):
 
     @classmethod
     def setUpClass(cls):
-        cls.hostapd = HostapdCLI(config='ssidSAE.conf')
+        cls.hostapd = ctx.get_hapd_instance('ssidSAE.conf').cli
 
     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testSAE/failure_test.py b/autotests/testSAE/failure_test.py
index e61bf585..d1efbcf7 100644
--- a/autotests/testSAE/failure_test.py
+++ b/autotests/testSAE/failure_test.py
@@ -8,7 +8,7 @@ import iwd
 from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
-from hostapd import HostapdCLI
+from config import ctx
 
 class Test(unittest.TestCase):
 
@@ -37,7 +37,7 @@ class Test(unittest.TestCase):
         self.validate_connection(wd, 'InvalidSecret')
 
     def test_no_supported_groups(self):
-        hostapd = HostapdCLI(config='ssidSAE.conf')
+        hostapd = ctx.get_hapd_instance('ssidSAE.conf').cli
         hostapd.set_value('sae_groups', '1')
         hostapd.reload()
 
diff --git a/autotests/testSAE/timeout_test.py b/autotests/testSAE/timeout_test.py
index 1413bb4a..73342d6c 100644
--- a/autotests/testSAE/timeout_test.py
+++ b/autotests/testSAE/timeout_test.py
@@ -9,7 +9,6 @@ from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
 from hwsim import Hwsim
-from hostapd import HostapdCLI
 from config import ctx
 
 class Test(unittest.TestCase):
@@ -40,7 +39,7 @@ class Test(unittest.TestCase):
         # needed because the hwsim rule only matches once and must be matched
         # on the first commit, not during group negotiation.
         #
-        hostapd = HostapdCLI(config='ssidSAE.conf')
+        hostapd = ctx.get_hapd_instance('ssidSAE.conf').cli
         hostapd.set_value('vendor_elements', 'dd0cf4f5e8050500000000000000')
         hostapd.set_value('sae_groups', '19')
         hostapd.reload()
@@ -64,7 +63,7 @@ class Test(unittest.TestCase):
         rule0.remove()
 
     def test_sta_confirm_not_acked(self):
-        hostapd = HostapdCLI(config='ssidSAE.conf')
+        hostapd = ctx.get_hapd_instance('ssidSAE.conf').cli
         hostapd.set_value('vendor_elements', 'dd0cf4f5e8050500000000000000')
         hostapd.set_value('sae_groups', '19')
         hostapd.reload()
diff --git a/autotests/testSAQuery-spoofing/connection_test.py b/autotests/testSAQuery-spoofing/connection_test.py
index 0ff0615f..3ec28114 100644
--- a/autotests/testSAQuery-spoofing/connection_test.py
+++ b/autotests/testSAQuery-spoofing/connection_test.py
@@ -9,7 +9,7 @@ from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
 from hwsim import Hwsim
-from hostapd import HostapdCLI
+from config import ctx
 
 from time import sleep
 
@@ -18,7 +18,7 @@ class Test(unittest.TestCase):
     def test_connection_success(self):
         hwsim = Hwsim()
 
-        hostapd = HostapdCLI(config='ssidCCMP.conf')
+        hostapd = ctx.get_hapd_instance('ssidCCMP.conf').cli
         radio = hwsim.get_radio('rad0')
 
         wd = IWD()
diff --git a/autotests/testSAQuery/connection_test.py b/autotests/testSAQuery/connection_test.py
index 03280d0e..a4706237 100644
--- a/autotests/testSAQuery/connection_test.py
+++ b/autotests/testSAQuery/connection_test.py
@@ -8,12 +8,12 @@ import iwd
 from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
-from hostapd import HostapdCLI
+from config import ctx
 
 class Test(unittest.TestCase):
 
     def test_connection_success(self):
-        hostapd = HostapdCLI(config='ssidCCMP.conf')
+        hostapd = ctx.get_hapd_instance('ssidCCMP.conf').cli
 
         wd = IWD()
 
diff --git a/autotests/testWPA2-ext-key-id/connection_test.py b/autotests/testWPA2-ext-key-id/connection_test.py
index afd48149..2b9f5635 100644
--- a/autotests/testWPA2-ext-key-id/connection_test.py
+++ b/autotests/testWPA2-ext-key-id/connection_test.py
@@ -10,13 +10,11 @@ from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
 from hwsim import Hwsim
-from hostapd import HostapdCLI
+from config import ctx
 import testutil
 
 class Test(unittest.TestCase):
     def validate(self, wd, resend_m3=False):
-        hapd = HostapdCLI('ssidCCMP.conf')
-
         psk_agent = PSKAgent("secret123")
         wd.register_psk_agent(psk_agent)
 
@@ -42,10 +40,10 @@ class Test(unittest.TestCase):
         # Rekey 5 times just to make sure the key ID can be toggled back and
         # forth without causing problems.
         for i in range(5):
-            hapd.rekey(device.address)
+            self.hapd.rekey(device.address)
 
             if resend_m3:
-                hapd.resend_m3(device.address)
+                self.hapd.resend_m3(device.address)
 
             testutil.test_iface_operstate()
             testutil.test_ifaces_connected()
@@ -101,7 +99,7 @@ class Test(unittest.TestCase):
 
     @classmethod
     def setUpClass(cls):
-        cls.hapd = HostapdCLI()
+        cls.hapd = ctx.get_hapd_instance().cli
 
     @classmethod
     def tearDownClass(cls):
-- 
2.34.1

