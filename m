Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9E613AA4D
	for <iwd@lists.linux.dev>; Thu, 18 Jul 2024 11:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721303132; cv=none; b=MCivtirp/vV/Q8bumRxtdNMhm3B4Pt6u1M7YGsiYBh1eXqdg41v44S5Lig8IMuM6//I3C02+2FLuzbqxG3Km/mDgnoYjP6S+T2GzCWyXEqMiqvTmuV5Q32Z0ZOH8ouefAw3wW1ClxcZLWTCPXPPus4BoLVsBPFY5f6FhLnhBEyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721303132; c=relaxed/simple;
	bh=aRFxYDwmCE7MOGSuIVN6TwwDLykzntRea7DdsZuQBdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bu7JWV1kJCahpyV+MJvublSJVTl4x5IEaJBUcZu2VTa07iVGOt1kJiecDterNcOic2aMV9nrJSyDfuP30W94FA1D9shPSIlA+9fpmLO9qOxro1MagVmKCfiEQ2Z3gPa7+g0aLu4QkVMOJoLZKVrLU1iOJoxy/rxeZCCOCsL5Ti0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMIuvBzF; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMIuvBzF"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-447d6edc6b1so1034501cf.0
        for <iwd@lists.linux.dev>; Thu, 18 Jul 2024 04:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721303129; x=1721907929; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OhsN8zELOQglnO4wFDWd+oiNlSYExCT5xs8E7+DKXI=;
        b=aMIuvBzFh0HHzFFJrPfYsQf/HBFkyJQrNPUI4jpxRK2R76oDAYYMnvYjHWvS1FNReP
         319m7gD82cjPXUQQv7KGtvkNp/07FxNi7A27V+phlZ/N3X5I4GUvD2013CPsElBOQPT2
         5PFrQQrDNuFylCtU4+eLMOYY+02OX5BLt89o8s8NnFxiFZvmpjjKtylfxWJR3Z9tmleb
         YwZWswhA2P0Jd+/hGbhOWxoRYU2Sjk5pNc4WbMcLdP+Vq8yK/x6fmBEKubIR1Zt9RQCg
         OptVIJYmZfv67ayItkFTrpwT8YzQq2ZMKFodIDQ2ODWzDegghLwynVtjEAndlFdprMUR
         RTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721303129; x=1721907929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7OhsN8zELOQglnO4wFDWd+oiNlSYExCT5xs8E7+DKXI=;
        b=AZPBm0e88GPvGlZdjIBzuAbKTDwts/t7dNLjqBnWJejv+QTN/hzRipd15WiZWNmwxV
         obJHF0cEiOBAXBlUrmoN86gH2qZWec/aOFA+iXLge5jfsH2mgPjecUgrAM4PUOAZ2arm
         juQCdWM8kTf6fbrl2bTysXVwA4BRvfr1+NvbGp5730KpGgqA6B6aVUk+3OMnM6f65H0Z
         thcFwSunsF950wlmThhaIwcljQ1e3YBl6F2rURGu0Nlcy7/YD9CImoAi+vsSjbx3mokv
         EaQHgkWsPeDHju1ib0zSpOhYELpIKkmiPBIV/kSPMzPFrP8nQf4yNTOiExkQYp98PyHc
         94gA==
X-Gm-Message-State: AOJu0Yx9gfAyDlUCoetWFdxsPzKqbl63cEw9nZ7eaNeeO6M29/4Dbfz5
	9sGvvDBdx0NNZB4TzZCMsC4HYN7lrlssI5pt1xh9GDl7Rz5Lz2my9NnCgg==
X-Google-Smtp-Source: AGHT+IHwfjYwWLjpFxqdZm83bWREVQliQGuvG6trl84I6fMCRLuKG/3IvkuyKturpufqVRRRmApwYA==
X-Received: by 2002:a05:6214:2b0f:b0:6b4:fbec:952f with SMTP id 6a1803df08f44-6b78cacf392mr59364856d6.25.1721303129568;
        Thu, 18 Jul 2024 04:45:29 -0700 (PDT)
Received: from LOCLAP699.localdomain ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b79c5138bbsm7292006d6.61.2024.07.18.04.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 04:45:29 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 10/11] auto-t: Add deauth during the 4-way handshake test
Date: Thu, 18 Jul 2024 04:45:13 -0700
Message-Id: <20240718114514.2916258-11-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718114514.2916258-1-prestwoj@gmail.com>
References: <20240718114514.2916258-1-prestwoj@gmail.com>
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
 .../disconnect_during_handshake_test.py       | 112 ++++++++++++++++++
 autotests/testPSK-roam/ft-psk-ccmp-1.conf     |   2 +-
 autotests/testPSK-roam/ft-psk-ccmp-2.conf     |   2 +-
 autotests/testPSK-roam/ft-psk-ccmp-3.conf     |   2 +-
 autotests/testPSK-roam/main.conf              |   3 +
 5 files changed, 118 insertions(+), 3 deletions(-)
 create mode 100644 autotests/testPSK-roam/disconnect_during_handshake_test.py

diff --git a/autotests/testPSK-roam/disconnect_during_handshake_test.py b/autotests/testPSK-roam/disconnect_during_handshake_test.py
new file mode 100644
index 00000000..026081c3
--- /dev/null
+++ b/autotests/testPSK-roam/disconnect_during_handshake_test.py
@@ -0,0 +1,112 @@
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
+        to_condition = 'obj.state == DeviceState.disconnected'
+        wd.wait_for_object_change(device, from_condition, to_condition)
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
+        cls.rule0.remove()
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

