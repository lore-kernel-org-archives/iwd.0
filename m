Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021D8181BAC
	for <iwd@lists.linux.dev>; Wed, 17 Jul 2024 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721228137; cv=none; b=RfgIhdwPSmpCqO5Zr5hnYCGJghvplfr5hSFhlIx2MmWG6+H/ScWKBj/VSiBy9hIFt9erLN4tEzyq0RdcPiVc2Bwa2oNk/4yq4EyzPjH3FqBeSTRiGKj8USDaZtbPhtG1zDgW6XCCwHPfOtJrkvQIRPP/0FAOT23PsVqjuiD+RsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721228137; c=relaxed/simple;
	bh=c/2V3qivgem7wxMjLwhuC1XwQlgqFogeUaojRH3DJHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sk+CODJmt4K6f/17iC6SU8lko5YSmkGEQZTSit0Qo3H3C6tl6DLju03XCb9TG7Fk3TWZgtXxIHdkvD+wGvW2iGzUcGi4wDyWw9Ul2afI4iCziGJWQ4BQYYtn+THKQl/LJEMfeKL+KerUyfkETsYqr5we8O3tVB7aNT62EkC3ILE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RX/1Sn6n; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RX/1Sn6n"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79f178351d4so432892085a.0
        for <iwd@lists.linux.dev>; Wed, 17 Jul 2024 07:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721228135; x=1721832935; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cr/5yUOrGHfHDvlWYS8wXxrYoFlLdaVtu3+ed47QWLA=;
        b=RX/1Sn6nSALf+r4gEtgErkZWP0g0USnWFNqKcDHl6IYraiHMeMYuh/RDDh/hv2plzU
         mltwZlCWKI9d4+rz2UWK4VzOpDLe5QV0ngSuZwxmlUlLM2pXGPPs57rMt9aIeICY/tBE
         zHkhtl23KYfj255DOOQ6u/3bpFJdco5lCOM2oT3lJUX3Hze2YgSrSb+KxWFkBdhubXEi
         WeeaFwCpIwPQGrHNE7JOynR16+J85E9Z/egR1waNz5lwOFHIMyCgfeJiV1Fh5/caREC/
         S8ZriROAPMNRqpROm5T9Zjuez4tjhaizKbhQmLcgVa0RmYyigpdLNiCXaJqO5c+7Myw7
         mB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721228135; x=1721832935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cr/5yUOrGHfHDvlWYS8wXxrYoFlLdaVtu3+ed47QWLA=;
        b=r7PWvcFuyzPpy0enDk3iIp16HZIOkibUjRGPvXHejQGQvHvjTkcqcN0H0xfC1nDPNP
         BZzKQwxyw95imasDwOrSQZzWkYWe+gZOj1S0VL9LVmPFov2fzYT/vVeTih6hMkcvU9xC
         w1yZJDK3Zi9QLl493TJYeGgleZRp3yTa4nDVFEYpbS+QFS19DUV+rOElo3Oo8HPJtxzy
         URmJhcwkcpccy8ykGY2NOq+VTGfD7WkB/jZ1GlcKqmIPg7MCZBWeVtwlbLrFt20Xn4Sv
         GLIkPtGNoCu5ObbblrO+IvbCndBXU0o9lXiI/+to2uutqB8YrssVmLZIpmEdYRy0UxZP
         xyrg==
X-Gm-Message-State: AOJu0YxRCku/I+KKp9IRszV4gQT1dIOCrF8F3isN0Z+sO3T+P5yyuI5w
	zcGEgiixemH09A1lUAs9IEA1DNNkcDFyU/J+U0NQeRQxqufvhx1xJaCRog==
X-Google-Smtp-Source: AGHT+IEbDpCAy2mIHarV3G27fhZRTdnruC+EzgOjOGhzKMx1LCSOiAJ/EJaI4pMi0Fli7p/aWtwutA==
X-Received: by 2002:a05:620a:190f:b0:79f:556:5f31 with SMTP id af79cd13be357-7a18746e0c8mr211460585a.37.1721228134654;
        Wed, 17 Jul 2024 07:55:34 -0700 (PDT)
Received: from LOCLAP699.localdomain ([50.78.19.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160bbff41sm407195885a.53.2024.07.17.07.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 07:55:34 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/5] auto-t: Add deauth during the 4-way handshake test
Date: Wed, 17 Jul 2024 07:55:25 -0700
Message-Id: <20240717145525.2656306-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717145525.2656306-1-prestwoj@gmail.com>
References: <20240717145525.2656306-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test will fail with current upstream as IWD hangs when the
deauthenticate event arrives. Once this is fixed the test should
pass.
---
 .../disconnect_during_handshake_test.py       | 118 ++++++++++++++++++
 autotests/testPSK-roam/ft-psk-ccmp-1.conf     |   2 +-
 autotests/testPSK-roam/ft-psk-ccmp-2.conf     |   2 +-
 autotests/testPSK-roam/ft-psk-ccmp-3.conf     |   2 +-
 autotests/testPSK-roam/main.conf              |   3 +
 5 files changed, 124 insertions(+), 3 deletions(-)
 create mode 100644 autotests/testPSK-roam/disconnect_during_handshake_test.py

diff --git a/autotests/testPSK-roam/disconnect_during_handshake_test.py b/autotests/testPSK-roam/disconnect_during_handshake_test.py
new file mode 100644
index 00000000..c5016cd1
--- /dev/null
+++ b/autotests/testPSK-roam/disconnect_during_handshake_test.py
@@ -0,0 +1,118 @@
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
+    def validate_connection(self, wd):
+        device = wd.list_devices(1)[0]
+
+        ordered_network = device.get_ordered_network('TestFT', full_scan=True)
+
+        self.assertEqual(ordered_network.type, NetworkType.psk)
+
+        condition = 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condition)
+
+        self.assertFalse(self.bss_hostapd[0].list_sta())
+        self.assertFalse(self.bss_hostapd[1].list_sta())
+
+        device.connect_bssid(self.bss_hostapd[0].bssid)
+
+        condition = 'obj.state == DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
+        self.bss_hostapd[0].wait_for_event('AP-STA-CONNECTED %s' % device.address)
+
+        testutil.test_iface_operstate(device.name)
+        testutil.test_ifaces_connected(self.bss_hostapd[0].ifname, device.name)
+        self.assertRaises(Exception, testutil.test_ifaces_connected,
+                          (self.bss_hostapd[1].ifname, device.name, True, True))
+
+        self.rule0.enabled = True
+
+        device.roam(self.bss_hostapd[1].bssid)
+
+        device.clear_events()
+        device.wait_for_event("handshake-started")
+        self.bss_hostapd[1].deauthenticate(device.address, reason=15, test=1)
+
+        # Check that iwd is on BSS 1 once out of roaming state and doesn't
+        # go through 'disconnected', 'autoconnect', 'connecting' in between
+        from_condition = 'obj.state == DeviceState.roaming'
+        to_condition = 'obj.state == DeviceState.connected'
+        wd.wait_for_object_change(device, from_condition, to_condition)
+
+        self.bss_hostapd[1].wait_for_event('AP-STA-CONNECTED %s' % device.address)
+
+        testutil.test_iface_operstate(device.name)
+        testutil.test_ifaces_connected(self.bss_hostapd[1].ifname, device.name)
+        self.assertRaises(Exception, testutil.test_ifaces_connected,
+                          (self.bss_hostapd[0].ifname, device.name, True, True))
+
+    def test_disconnect_during_handshake(self):
+        self.bss_hostapd[0].set_value('wpa_key_mgmt', 'WPA-PSK')
+        self.bss_hostapd[0].reload()
+        self.bss_hostapd[0].wait_for_event("AP-ENABLED")
+
+        self.bss_hostapd[1].set_value('wpa_key_mgmt', 'WPA-PSK')
+        self.bss_hostapd[1].reload()
+        self.bss_hostapd[1].wait_for_event("AP-ENABLED")
+
+        self.validate_connection(self.wd)
+
+    def tearDown(self):
+        os.system('ip link set "' + self.bss_hostapd[0].ifname + '" down')
+        os.system('ip link set "' + self.bss_hostapd[1].ifname + '" down')
+        os.system('ip link set "' + self.bss_hostapd[0].ifname + '" up')
+        os.system('ip link set "' + self.bss_hostapd[1].ifname + '" up')
+
+        for hapd in self.bss_hostapd:
+            hapd.default()
+
+        self.wd.stop()
+        self.wd = None
+
+    def setUp(self):
+        self.wd = IWD(True)
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
+        unused = HostapdCLI(config='ft-psk-ccmp-3.conf')
+        unused.disable()
+
+        cls.bss_hostapd[0].set_address('12:00:00:00:00:01')
+        cls.bss_hostapd[1].set_address('12:00:00:00:00:02')
+
+        rad1 = hwsim.get_radio('rad1')
+
+        cls.rule0 = hwsim.rules.create()
+        cls.rule0.destination = rad1.addresses[0]
+        cls.rule0.prefix = '08'
+        cls.rule0.drop = True
+
+        HostapdCLI.group_neighbors(*cls.bss_hostapd)
+
+    @classmethod
+    def tearDownClass(cls):
+        IWD.clear_storage()
+        cls.bss_hostapd = None
+
+if __name__ == '__main__':
+    unittest.main(exit=True)
diff --git a/autotests/testPSK-roam/ft-psk-ccmp-1.conf b/autotests/testPSK-roam/ft-psk-ccmp-1.conf
index b46d1f27..839eb496 100644
--- a/autotests/testPSK-roam/ft-psk-ccmp-1.conf
+++ b/autotests/testPSK-roam/ft-psk-ccmp-1.conf
@@ -13,7 +13,7 @@ wpa=2
 wpa_key_mgmt=FT-PSK
 wpa_pairwise=CCMP
 wpa_passphrase=EasilyGuessedPassword
-ieee80211w=1
+ieee80211w=0
 rsn_preauth=1
 rsn_preauth_interfaces=lo
 disable_pmksa_caching=0
diff --git a/autotests/testPSK-roam/ft-psk-ccmp-2.conf b/autotests/testPSK-roam/ft-psk-ccmp-2.conf
index 3e215457..2ffd7262 100644
--- a/autotests/testPSK-roam/ft-psk-ccmp-2.conf
+++ b/autotests/testPSK-roam/ft-psk-ccmp-2.conf
@@ -13,7 +13,7 @@ wpa=2
 wpa_key_mgmt=FT-PSK
 wpa_pairwise=CCMP
 wpa_passphrase=EasilyGuessedPassword
-ieee80211w=1
+ieee80211w=0
 rsn_preauth=1
 rsn_preauth_interfaces=lo
 disable_pmksa_caching=0
diff --git a/autotests/testPSK-roam/ft-psk-ccmp-3.conf b/autotests/testPSK-roam/ft-psk-ccmp-3.conf
index 3e215457..2ffd7262 100644
--- a/autotests/testPSK-roam/ft-psk-ccmp-3.conf
+++ b/autotests/testPSK-roam/ft-psk-ccmp-3.conf
@@ -13,7 +13,7 @@ wpa=2
 wpa_key_mgmt=FT-PSK
 wpa_pairwise=CCMP
 wpa_passphrase=EasilyGuessedPassword
-ieee80211w=1
+ieee80211w=0
 rsn_preauth=1
 rsn_preauth_interfaces=lo
 disable_pmksa_caching=0
diff --git a/autotests/testPSK-roam/main.conf b/autotests/testPSK-roam/main.conf
index 3d93ff57..a6887c9c 100644
--- a/autotests/testPSK-roam/main.conf
+++ b/autotests/testPSK-roam/main.conf
@@ -3,3 +3,6 @@ DisableMacAddressRandomization=true
 
 [General]
 RoamRetryInterval=1
+
+# For disconnect_during_handshake_test
+ManagementFrameProtection=0
-- 
2.34.1

