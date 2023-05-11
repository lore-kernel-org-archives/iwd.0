Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EE4206BA
	for <iwd@lists.linux.dev>; Thu, 11 May 2023 18:52:57 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7577f03e131so285669485a.0
        for <iwd@lists.linux.dev>; Thu, 11 May 2023 11:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683831176; x=1686423176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNg016PugZYoeR5Wm/9eUpXCKEK7alYUmSPofUnE8QM=;
        b=Qx+mMzLw+k60RLDPUwd+ws8qZTwz5LOhJGBwo+IziczPEOxpG58esa+8zB8zls7FOq
         Gr1iOmztkHU7KiUvqu10gvvTMFMRbbcaHXZ1u4CVk4vbZwmDB7t6PEXeKB2TjAx8yCs/
         gRDFMND8J6beSabugWijsSP3pO2XJ7aVhMm6RnkmOMtY0YZMW3pzt4SR8hZDjdsNhrJx
         W2a6EhJwQdOWWJ5ApDGOArmocFw1aSU862Yc/TaSEPA4K9Ae9XP9L2jj8t6K8NCmsMIV
         d1NjJKOMUa9Ecob/92hkezl27/8R3N/sK7O/zPGaWcy6i10Z4bzFcOZgZymfFl61u/nY
         LiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683831176; x=1686423176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNg016PugZYoeR5Wm/9eUpXCKEK7alYUmSPofUnE8QM=;
        b=V4VkfUjk3XCooYqFTP9rtifqLndYdte8JvEzXhPhRpTcuIdc/GXsubZv0MFUZFaXKG
         gICECM4PPlEcsIISncbRriV64+YQQCO9zeRwMAJx9lwr1YGoxV1/VdNfN0tlKuGgm3eJ
         EES9D7uzyq4VbU4fn+5i3rIqe13BmRD0JUkBROQw/Hlcau/7lzaBu32K5m6tjJcK4c0a
         mULyJVwXdC5fow63btGevvsMtXDdCT2yVOP+fIXy0fL12Dgh8ByKlkWKO2LBI9Xhqjzn
         VjUj5ljI5LYaDyyQPhaqnRCaxBBIGncVUYU90+ehVsUqrY5rVcD4S+eTMRYKYCOvnjAr
         HTGg==
X-Gm-Message-State: AC+VfDwdrdiuU6Ag2+lJF3da2cxaTF4kRhTJ6MtZcsTPENz+Bu3WkwCz
	3PjcEXU/W//EkB9KLqtadMWJh4S31UQ=
X-Google-Smtp-Source: ACHHUZ76hIkaXQ8d1/YwRQgf8yiUbm6BfPh/peCKd6Fis3i6T4nB12dnbeKOp3ffTEL+X/GdigkvaA==
X-Received: by 2002:a05:6214:226f:b0:56e:af49:7a1d with SMTP id gs15-20020a056214226f00b0056eaf497a1dmr36047622qvb.24.1683831175885;
        Thu, 11 May 2023 11:52:55 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id c16-20020a0ca9d0000000b005ef6b124d39sm2484017qvb.5.2023.05.11.11.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:52:55 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/3] auto-t: modify PSK-roam test to use FT failure path
Date: Thu, 11 May 2023 11:52:50 -0700
Message-Id: <20230511185251.79563-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230511185251.79563-1-prestwoj@gmail.com>
References: <20230511185251.79563-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds another radio so IWD hits the FT failure path after
authentication to the first BSS fails. This causes a wiphy work
item to be rescheduled which previously was unsafe.
---
 autotests/testPSK-roam/connection_test.py     | 13 ++++---
 autotests/testPSK-roam/failed_roam_test.py    | 33 ++++++++++------
 autotests/testPSK-roam/ft-psk-ccmp-3.conf     | 39 +++++++++++++++++++
 autotests/testPSK-roam/hw.conf                |  3 +-
 .../testPSK-roam/roam_ap_disconnect_test.py   |  4 +-
 5 files changed, 74 insertions(+), 18 deletions(-)
 create mode 100644 autotests/testPSK-roam/ft-psk-ccmp-3.conf

v2:
 * Added the hostapd configuration which was missing from the last
   patch set.

diff --git a/autotests/testPSK-roam/connection_test.py b/autotests/testPSK-roam/connection_test.py
index 7a135e95..459c25cf 100644
--- a/autotests/testPSK-roam/connection_test.py
+++ b/autotests/testPSK-roam/connection_test.py
@@ -48,7 +48,7 @@ class Test(unittest.TestCase):
             self.rule2.enabled = True
             # Send 100 packets (to be dropped), should trigger beacon loss
             testutil.tx_packets(device.name, self.bss_hostapd[0].ifname, 100)
-            device.wait_for_event('packet-loss-roam', timeout=30)
+            device.wait_for_event('packet-loss-roam', timeout=60)
         else:
             device.roam(self.bss_hostapd[1].bssid)
 
@@ -173,19 +173,22 @@ class Test(unittest.TestCase):
         IWD.copy_to_storage('TestFT.psk')
 
         cls.bss_hostapd = [ HostapdCLI(config='ft-psk-ccmp-1.conf'),
-                            HostapdCLI(config='ft-psk-ccmp-2.conf') ]
+                            HostapdCLI(config='ft-psk-ccmp-2.conf'),
+                            HostapdCLI(config='ft-psk-ccmp-3.conf') ]
+        cls.bss_hostapd[2].disable()
+
         rad0 = hwsim.get_radio('rad0')
-        rad2 = hwsim.get_radio('rad2')
+        rad3 = hwsim.get_radio('rad3')
 
         cls.rule0 = hwsim.rules.create()
-        cls.rule0.source = rad2.addresses[0]
+        cls.rule0.source = rad3.addresses[0]
         cls.rule0.bidirectional = True
         cls.rule0.signal = -2000
         cls.rule0.prefix = 'b0'
         cls.rule0.drop = True
 
         cls.rule1 = hwsim.rules.create()
-        cls.rule1.source = rad2.addresses[0]
+        cls.rule1.source = rad3.addresses[0]
         cls.rule1.prefix = '08'
         cls.rule1.drop = True
 
diff --git a/autotests/testPSK-roam/failed_roam_test.py b/autotests/testPSK-roam/failed_roam_test.py
index 360c1de5..eda2b4e2 100644
--- a/autotests/testPSK-roam/failed_roam_test.py
+++ b/autotests/testPSK-roam/failed_roam_test.py
@@ -62,21 +62,17 @@ class Test(unittest.TestCase):
 
         self.rule0.enabled = True
 
-        device.roam(self.bss_hostapd[1].bssid)
-
-        # Roam should fail...
-        device.wait_for_event('ft-roam-failed')
+        # IWD should connect, then attempt a roam to BSS 1, which should fail...
+        device.wait_for_event('ft-roam-failed', timeout=60)
         # ... but IWD should remain connected
         self.assertTrue(device.state == DeviceState.connected)
 
         self.rule0.enabled = False
 
-        # Try again once more
-        device.roam(self.bss_hostapd[1].bssid)
-
-        self.verify_roam(wd, device, self.bss_hostapd[0], self.bss_hostapd[1])
+        # IWD should then try BSS 2, and succeed
+        self.verify_roam(wd, device, self.bss_hostapd[0], self.bss_hostapd[2])
 
-        self.bss_hostapd[1].deauthenticate(device.address)
+        self.bss_hostapd[2].deauthenticate(device.address)
         condition = 'obj.state == DeviceState.disconnected'
         wd.wait_for_object_condition(device, condition)
 
@@ -88,6 +84,7 @@ class Test(unittest.TestCase):
 
         self.rule0.enabled = False
         self.rule1.enabled = False
+        self.rule2.enabled = False
 
     @classmethod
     def setUpClass(cls):
@@ -96,14 +93,16 @@ class Test(unittest.TestCase):
         IWD.copy_to_storage('TestFT.psk')
 
         cls.bss_hostapd = [ HostapdCLI(config='ft-psk-ccmp-1.conf'),
-                            HostapdCLI(config='ft-psk-ccmp-2.conf') ]
+                            HostapdCLI(config='ft-psk-ccmp-2.conf'),
+                            HostapdCLI(config='ft-psk-ccmp-3.conf') ]
 
         cls.bss_hostapd[0].set_address('12:00:00:00:00:01')
         cls.bss_hostapd[1].set_address('12:00:00:00:00:02')
+        cls.bss_hostapd[2].set_address('12:00:00:00:00:03')
 
         # Drop Authenticate frames
         cls.rule0 = hwsim.rules.create()
-        cls.rule0.bidirectional = True
+        cls.rule0.source = hwsim.get_radio('rad1').addresses[0]
         cls.rule0.prefix = 'b0'
         cls.rule0.drop = True
 
@@ -113,6 +112,18 @@ class Test(unittest.TestCase):
         cls.rule1.prefix = 'd0'
         cls.rule1.drop = True
 
+        # Causes IWD to immediately roam away from BSS 0
+        cls.rule2 = hwsim.rules.create()
+        cls.rule2.source = hwsim.get_radio('rad0').addresses[0]
+        cls.rule2.signal = -8000
+        cls.rule2.enabled = True
+
+        # Causes IWD to first prefer BSS 1 to roam, then BSS 2.
+        cls.rule3 = hwsim.rules.create()
+        cls.rule3.source = hwsim.get_radio('rad2').addresses[0]
+        cls.rule3.signal = -7000
+        cls.rule3.enabled = True
+
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
diff --git a/autotests/testPSK-roam/ft-psk-ccmp-3.conf b/autotests/testPSK-roam/ft-psk-ccmp-3.conf
new file mode 100644
index 00000000..a42e175d
--- /dev/null
+++ b/autotests/testPSK-roam/ft-psk-ccmp-3.conf
@@ -0,0 +1,39 @@
+hw_mode=g
+channel=2
+ssid=TestFT
+utf8_ssid=1
+ctrl_interface=/var/run/hostapd
+
+r1_key_holder=120000000002
+nas_identifier=dummy2
+
+wpa=2
+# Can support WPA-PSK and FT-PSK (space separated list) and/or EAP at the same
+# time but we want to force FT
+wpa_key_mgmt=FT-PSK
+wpa_pairwise=CCMP
+wpa_passphrase=EasilyGuessedPassword
+ieee80211w=1
+rsn_preauth=1
+rsn_preauth_interfaces=lo
+disable_pmksa_caching=0
+# Allow PMK cache to be shared opportunistically among configured interfaces
+# and BSSes (i.e., all configurations within a single hostapd process).
+okc=1
+mobility_domain=1234
+reassociation_deadline=60000
+r0kh=12:00:00:00:00:01 dummy1 000102030405060708090a0b0c0d0e0f
+r0kh=12:00:00:00:00:02 dummy2 000102030405060708090a0b0c0d0e0f
+r1kh=12:00:00:00:00:01 00:00:00:00:00:01 000102030405060708090a0b0c0d0e0f
+r1kh=12:00:00:00:00:02 00:00:00:00:00:02 000102030405060708090a0b0c0d0e0f
+# Push mode only needed for 8021x, not PSK mode since msk already known
+pmk_r1_push=0
+# Allow locally generated FT response so we don't have to configure push/pull
+# between BSSes running as separate hostapd processes as in the test-runner
+# case.  Only works with FT-PSK, otherwise brctl needs to be installed and
+# CONFIG_BRIDGE enabled in the kernel.
+ft_psk_generate_local=1
+ft_over_ds=0
+ap_table_expiration_time=36000
+ap_table_max_size=10
+rrm_neighbor_report=1
diff --git a/autotests/testPSK-roam/hw.conf b/autotests/testPSK-roam/hw.conf
index c2b35d6e..da9e385c 100644
--- a/autotests/testPSK-roam/hw.conf
+++ b/autotests/testPSK-roam/hw.conf
@@ -1,8 +1,9 @@
 [SETUP]
-num_radios=3
+num_radios=4
 start_iwd=0
 hwsim_medium=yes
 
 [HOSTAPD]
 rad0=ft-psk-ccmp-1.conf
 rad1=ft-psk-ccmp-2.conf
+rad2=ft-psk-ccmp-3.conf
diff --git a/autotests/testPSK-roam/roam_ap_disconnect_test.py b/autotests/testPSK-roam/roam_ap_disconnect_test.py
index 416541ce..130e1702 100644
--- a/autotests/testPSK-roam/roam_ap_disconnect_test.py
+++ b/autotests/testPSK-roam/roam_ap_disconnect_test.py
@@ -70,8 +70,10 @@ class Test(unittest.TestCase):
         IWD.copy_to_storage('TestFT.psk')
 
         cls.bss_hostapd = [ HostapdCLI(config='ft-psk-ccmp-1.conf'),
-                            HostapdCLI(config='ft-psk-ccmp-2.conf') ]
+                            HostapdCLI(config='ft-psk-ccmp-2.conf'),
+                            HostapdCLI(config='ft-psk-ccmp-3.conf') ]
         cls.bss_hostapd[1].disable()
+        cls.bss_hostapd[2].disable()
 
         cls.bss_hostapd[0].set_value('ocv', '0')
         cls.bss_hostapd[0].set_value('ieee80211w', '0')
-- 
2.25.1

