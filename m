Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A530B2577A
	for <iwd@lists.linux.dev>; Wed, 20 Dec 2023 13:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UH5EJjl0"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bb7376957eso179711b6e.1
        for <iwd@lists.linux.dev>; Wed, 20 Dec 2023 05:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703077935; x=1703682735; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsEtghFtj+9LnD5X9azSosd8tgs2IfaQyu9KNm9uktw=;
        b=UH5EJjl0/vMV93VbFrOAKtU4Rs4wd1y0+S/nw32tNF9VtWZe/F487aL0M4zQlRKyun
         HLGi3bnF2re1Wjzvo/BB9lVcqs8uR6GRZPjqiFd861jcPnanYHRIy6zxiV1s2BMwVnh6
         Xy933uSL31WBZ1MpypouKQN0eehnackpBIydXz/iIqHaH1OGyYl9NftUdtsXTrdfuqQP
         Dzgg/hzxrgppc4i3TK5qFCpL4knPuI8/2VinywufdaNIWf3ULwQnD/pwuga9e9dB1RUT
         Pb+YdyashRP1XYWXCwN6az5ZKBBIjqKy/hkrAEJK/DOfqIqhme9z72UaLUukWb/2OSqS
         PZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703077935; x=1703682735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DsEtghFtj+9LnD5X9azSosd8tgs2IfaQyu9KNm9uktw=;
        b=hwSWHzrb56U5nehAMSg+QdacDK4kNhGZUovp2PVQ898L4VnYW5iT0tGVPN+4VNBtRp
         ePHkOXs01wIGpFzlckUBo7tzElHOai5RaUEP93AIeKheRwrw7EUdEnXH3UsWQYonnxS9
         3Y6S+IxKWuy6P5tpIUPqGjYP+YPnjYhcSOStAd7VjJahwuEKgF1tQuogX6NY3ThHfu9m
         1nYcm+SDUrLBpOns/I7FvM8ZgLgF0x6yHo5omih4eTw2bDN7yNlGqtZqpBOnSqzyUIis
         pJUOEBTHUqf9V5XIJiAo3pLHVfHjEOBsT+Vo5QoU/1x7A4zjhcok064Ev+TEmpi5gnzp
         xVWQ==
X-Gm-Message-State: AOJu0YwyLvOUNPq0TONWDE5GFdObJ/lL0PGs6Yu3dHpNCVAmDWRcWIXb
	5PHNNn0BblK+mowQ8wh8BkTMZxYrwSo=
X-Google-Smtp-Source: AGHT+IHviob5yEA54/ahRvOC8e8hIZlbrx+Y2SV8eimkyTkyvW/88Nf3D0LlFlv1CXSqCN5tSOrMww==
X-Received: by 2002:a05:6808:2dcc:b0:3ba:f4a:4310 with SMTP id gn12-20020a0568082dcc00b003ba0f4a4310mr24391428oib.11.1703077934667;
        Wed, 20 Dec 2023 05:12:14 -0800 (PST)
Received: from LOCLAP699.barrett-olive-branch.locus ([50.222.209.222])
        by smtp.gmail.com with ESMTPSA id j15-20020aca170f000000b003ba3a9c553esm2109591oii.30.2023.12.20.05.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 05:12:14 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/7] auto-t: update known frequency test to check order
Date: Wed, 20 Dec 2023 05:11:59 -0800
Message-Id: <20231220131200.267489-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220131200.267489-1-prestwoj@gmail.com>
References: <20231220131200.267489-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Known frequencies are stored in order of most recently used, so
add some logic to the test to exercise the reordering of frequencies
as connections are made.
---
 autotests/testKnownNetworks/frequency_test.py | 122 +++++++++++++-----
 autotests/testKnownNetworks/hw.conf           |  10 +-
 .../{ssidCCMP-2G.conf => ssidCCMP-2G-1.conf}  |   0
 .../testKnownNetworks/ssidCCMP-2G-2.conf      |   8 ++
 autotests/testKnownNetworks/ssidHotspot.conf  |   2 +-
 5 files changed, 102 insertions(+), 40 deletions(-)
 rename autotests/testKnownNetworks/{ssidCCMP-2G.conf => ssidCCMP-2G-1.conf} (100%)
 create mode 100644 autotests/testKnownNetworks/ssidCCMP-2G-2.conf

diff --git a/autotests/testKnownNetworks/frequency_test.py b/autotests/testKnownNetworks/frequency_test.py
index 83e51c06..4443d2a1 100644
--- a/autotests/testKnownNetworks/frequency_test.py
+++ b/autotests/testKnownNetworks/frequency_test.py
@@ -8,13 +8,21 @@ import iwd
 from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
+from hostapd import HostapdCLI
+from hwsim import Hwsim
 import testutil
 import os
 from configparser import ConfigParser
+from dataclasses import dataclass
+
+@dataclass
+class KnownFreq:
+    uuid: str
+    freqs: list
 
 class Test(unittest.TestCase):
-    def connect_network(self, wd, device, network):
-        ordered_network = device.get_ordered_network(network)
+    def connect_network(self, wd, device, network, scan=False):
+        ordered_network = device.get_ordered_network(network, full_scan=scan)
 
         condition = 'not obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condition)
@@ -29,7 +37,39 @@ class Test(unittest.TestCase):
         condition = 'not obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condition)
 
+    def read_known_freqs(self):
+        ret = {}
+        config = ConfigParser()
+        config.read('/tmp/iwd/.known_network.freq')
+        for s in config.sections():
+            ret[os.path.basename(config[s]['name'])] = KnownFreq(s, config[s]['list'].split(' '))
+
+        return ret
+
     def test_connection_success(self):
+        hostapd_psks = [
+            HostapdCLI(config="ssidCCMP-2G-1.conf"),
+            HostapdCLI(config="ssidCCMP-2G-2.conf"),
+            HostapdCLI(config="ssidCCMP-5G.conf"),
+        ]
+
+        hwsim = Hwsim()
+
+        rule0 = hwsim.rules.create()
+        rule0.source = hostapd_psks[0].bssid
+        rule0.signal = -2000
+        rule0.enabled = True
+
+        rule1 = hwsim.rules.create()
+        rule1.source = hostapd_psks[1].bssid
+        rule1.signal = -5000
+        rule1.enabled = True
+
+        rule2 = hwsim.rules.create()
+        rule2.source = hostapd_psks[2].bssid
+        rule2.signal = -7000
+        rule2.enabled = True
+
         wd = IWD(True, '/tmp')
 
         psk_agent = PSKAgent("secret123")
@@ -42,8 +82,7 @@ class Test(unittest.TestCase):
         # Connect to the PSK network, then Hotspot so IWD creates 2 entries in
         # the known frequency file.
         #
-
-        self.connect_network(wd, device, 'ssidCCMP')
+        self.connect_network(wd, device, "ssidCCMP")
 
         wd.unregister_psk_agent(psk_agent)
 
@@ -57,30 +96,27 @@ class Test(unittest.TestCase):
         psk_freqs = None
         psk_uuid = None
         hs20_freqs = None
-        hs20_uuid = None
-        config = ConfigParser()
-        config.read('/tmp/iwd/.known_network.freq')
-        for s in config.sections():
-            if os.path.basename(config[s]['name']) == 'ssidCCMP.psk':
-                psk_freqs = config[s]['list']
-                psk_freqs = psk_freqs.split(' ')
-                psk_uuid = s
-            elif os.path.basename(config[s]['name']) == 'example.conf':
-                hs20_freqs = config[s]['list']
-                hs20_freqs = hs20_freqs.split(' ')
-                hs20_uuid = s
+
+        freqs = self.read_known_freqs()
+
+        psk_freqs = freqs['ssidCCMP.psk']
+        hs20_freqs = freqs['example.conf']
 
         #
         # Verify the frequencies are what we expect
         #
         self.assertIsNotNone(psk_freqs)
-        self.assertIsNotNone(psk_uuid)
-        self.assertIn('5180', psk_freqs)
-        self.assertIn('2412', psk_freqs)
+        self.assertIsNotNone(psk_freqs.uuid)
+        # Save to compare later
+        psk_uuid = psk_freqs.uuid
+        self.assertIn('5180', psk_freqs.freqs)
+        # First should be the connected network. The other two's order is
+        # unknown since its based on whenever the BSS was seen.
+        self.assertEqual(psk_freqs.freqs[0], '2412')
 
         self.assertIsNotNone(hs20_freqs)
-        self.assertIsNotNone(hs20_uuid)
-        self.assertIn('2412', hs20_freqs)
+        self.assertIsNotNone(hs20_freqs.uuid)
+        self.assertIn('2417', hs20_freqs.freqs)
 
         #
         # Forget all know networks, this should remove all entries in the
@@ -92,11 +128,15 @@ class Test(unittest.TestCase):
         psk_agent = PSKAgent("secret123")
         wd.register_psk_agent(psk_agent)
 
+        # Rank a different BSS higher
+        rule0.signal = -7000
+        rule1.signal = -2000
+
         #
         # Reconnect, this should generate a completely new UUID since we
         # previously forgot the network.
         #
-        self.connect_network(wd, device, 'ssidCCMP')
+        self.connect_network(wd, device, 'ssidCCMP', scan=True)
 
         wd.unregister_psk_agent(psk_agent)
 
@@ -107,21 +147,33 @@ class Test(unittest.TestCase):
         psk_freqs = None
         psk_uuid2 = None
         hs20_freqs = None
-        config = ConfigParser()
-        config.read('/tmp/iwd/.known_network.freq')
-        for s in config.sections():
-            self.assertNotEqual(os.path.basename(config[s]['name']),
-                                    'example.conf')
-            if os.path.basename(config[s]['name']) == 'ssidCCMP.psk':
-                psk_freqs = config[s]['list']
-                psk_freqs = psk_freqs.split(' ')
-                psk_uuid2 = s
+
+        freqs = self.read_known_freqs()
+
+        psk_freqs = freqs['ssidCCMP.psk']
 
         self.assertIsNotNone(psk_freqs)
-        self.assertIsNotNone(psk_uuid2)
-        self.assertNotEqual(psk_uuid, psk_uuid2)
-        self.assertIn('5180', psk_freqs)
-        self.assertIn('2412', psk_freqs)
+        self.assertIsNotNone(psk_freqs.uuid)
+        self.assertNotEqual(psk_uuid2, psk_freqs.uuid)
+        self.assertIn('5180', psk_freqs.freqs)
+        # The 2417 frequency BSS should be first
+        self.assertEqual(psk_freqs.freqs[0], '2417')
+
+        # Rank the 5G BSS highest
+        rule0.signal = -7000
+        rule1.signal = -7000
+        rule2.signal = -2000
+
+        print("CONNECTING AGAGIn")
+        self.connect_network(wd, device, 'ssidCCMP', scan=True)
+
+        freqs = self.read_known_freqs()
+
+        psk_freqs = freqs['ssidCCMP.psk']
+
+        # The 5180 frequency BSS should now be first, followed by 2417
+        self.assertEqual(psk_freqs.freqs[0], '5180')
+        self.assertEqual(psk_freqs.freqs[1], '2417')
 
     @classmethod
     def setUpClass(cls):
diff --git a/autotests/testKnownNetworks/hw.conf b/autotests/testKnownNetworks/hw.conf
index 8a7ef73a..9fb3dbd5 100644
--- a/autotests/testKnownNetworks/hw.conf
+++ b/autotests/testKnownNetworks/hw.conf
@@ -1,10 +1,12 @@
 [SETUP]
-num_radios=5
+num_radios=6
 start_iwd=0
 reg_domain=US
+hwsim_medium=true
 
 [HOSTAPD]
 rad0=ssidNew.conf
-rad1=ssidCCMP-2G.conf
-rad2=ssidCCMP-5G.conf
-rad3=ssidHotspot.conf
+rad1=ssidCCMP-2G-1.conf
+rad2=ssidCCMP-2G-2.conf
+rad3=ssidCCMP-5G.conf
+rad4=ssidHotspot.conf
diff --git a/autotests/testKnownNetworks/ssidCCMP-2G.conf b/autotests/testKnownNetworks/ssidCCMP-2G-1.conf
similarity index 100%
rename from autotests/testKnownNetworks/ssidCCMP-2G.conf
rename to autotests/testKnownNetworks/ssidCCMP-2G-1.conf
diff --git a/autotests/testKnownNetworks/ssidCCMP-2G-2.conf b/autotests/testKnownNetworks/ssidCCMP-2G-2.conf
new file mode 100644
index 00000000..0d806fde
--- /dev/null
+++ b/autotests/testKnownNetworks/ssidCCMP-2G-2.conf
@@ -0,0 +1,8 @@
+hw_mode=g
+channel=2
+ssid=ssidCCMP
+
+wpa=2
+wpa_pairwise=CCMP
+wpa_passphrase=secret123
+beacon_int=10
diff --git a/autotests/testKnownNetworks/ssidHotspot.conf b/autotests/testKnownNetworks/ssidHotspot.conf
index 95170c84..35b31fbe 100644
--- a/autotests/testKnownNetworks/ssidHotspot.conf
+++ b/autotests/testKnownNetworks/ssidHotspot.conf
@@ -1,6 +1,6 @@
 #ctrl_interface=/var/run/hostapd
 hw_mode=g
-channel=1
+channel=2
 wpa=2
 ssid=Hotspot
 rsn_pairwise=CCMP
-- 
2.34.1

