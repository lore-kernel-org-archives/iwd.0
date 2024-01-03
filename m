Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74E41C6AE
	for <iwd@lists.linux.dev>; Wed,  3 Jan 2024 18:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVU5yCmq"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7815aca9a4eso416032985a.0
        for <iwd@lists.linux.dev>; Wed, 03 Jan 2024 10:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704307623; x=1704912423; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5vQSPwqHuKwKL0XPeLXtZhU8xw+uT2KJ5YGKGIIlRE=;
        b=JVU5yCmqh0jkCIUcctcSzMg+bItt6w5TX3X5dqSDLv/XZc3cPYSoe40HgvEvrGON58
         +Xq5oqxpgDDkRKzusdUh1BvL6iou4lC/BRgnbPVhRNHcq67+SY1U/EwLonRl9r+6wRS4
         LCuvDFNyPyptZvSdNu+V0/CSmtrq8yRMkjkIzwVe6VvrM/K3IoyIjTKwiMI+4C2LWk+3
         ayxy5/1yx75djLpPaLTp/OMA1AyIrM3soIRhwpNLJSzE0eV8D6iEndeOwi5wT2OboYEf
         impQysc/SJgGE5zutNljDcC9zDjS8pbdWrSk3Fs9KK9nXeAJy3RNIDUVg+Eh65JhuBpI
         HTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704307623; x=1704912423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5vQSPwqHuKwKL0XPeLXtZhU8xw+uT2KJ5YGKGIIlRE=;
        b=XmZHVbZ99NhJuXpAayPH2nxcaRnPQf+ULR5pufJc4vhq6JEFs12ipy1mJLjVCw9r01
         Pfr4+jV5scwQpd+wssLfZTz+JzzGKTJXFoSyOy4o4fk77UDqK1kEDSE85hCZOqtRUJdq
         1/q1fnWyNWGSozCCIHymtHURLwdEAiYm0xAY7HFWcq5eH3QbtCUp6jpT3gdEqaqeMu9D
         ZtDJm2iGql8NDgfqyJhrM5Ae77dh4hRZ25MXgTW0PSWtA4wrKy4gkq8pJpaAZNtc/Fvu
         v5/mVMq5kdJh3Df/YdYMcDuqn8mWq2/EMEBUWnmj48QhllBk4p4T+Vk/Og4u+T37ytL+
         xrtA==
X-Gm-Message-State: AOJu0YwnQuUqKjzZJR44MdScRyxUOhbDbi/zpgOgObj319iZa2P7I67m
	wi2f4KGxioGjuuozvE6bxs4DxPp7XL988A==
X-Google-Smtp-Source: AGHT+IEp9BLrUBVlsXPmOl8uEzkQQUoX7EeyqaUROVYXyeckHwOplw4vrcW/RruXsTZcSxrmLTSvHw==
X-Received: by 2002:a05:620a:24d4:b0:781:ea80:edb7 with SMTP id m20-20020a05620a24d400b00781ea80edb7mr1000773qkn.23.1704307623234;
        Wed, 03 Jan 2024 10:47:03 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id o21-20020a05620a22d500b00781a147e444sm3693370qki.92.2024.01.03.10.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 10:47:02 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/8] auto-t: add test for roaming + netconfig
Date: Wed,  3 Jan 2024 10:46:36 -0800
Message-Id: <20240103184638.533221-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103184638.533221-1-prestwoj@gmail.com>
References: <20240103184638.533221-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test ensures IWD will continue to roam and restart netconfig if
roam conditions are met prior to netconfig finishing.
---
 autotests/testNetconfigRoam/TestFT.psk        |  2 +
 .../testNetconfigRoam/ft-psk-ccmp-1.conf      | 41 +++++++++
 .../testNetconfigRoam/ft-psk-ccmp-2.conf      | 41 +++++++++
 autotests/testNetconfigRoam/hw.conf           |  8 ++
 autotests/testNetconfigRoam/main.conf         |  3 +
 .../testNetconfigRoam/netconfig_roam_test.py  | 88 +++++++++++++++++++
 6 files changed, 183 insertions(+)
 create mode 100644 autotests/testNetconfigRoam/TestFT.psk
 create mode 100644 autotests/testNetconfigRoam/ft-psk-ccmp-1.conf
 create mode 100644 autotests/testNetconfigRoam/ft-psk-ccmp-2.conf
 create mode 100644 autotests/testNetconfigRoam/hw.conf
 create mode 100644 autotests/testNetconfigRoam/main.conf
 create mode 100644 autotests/testNetconfigRoam/netconfig_roam_test.py

diff --git a/autotests/testNetconfigRoam/TestFT.psk b/autotests/testNetconfigRoam/TestFT.psk
new file mode 100644
index 00000000..e82d1295
--- /dev/null
+++ b/autotests/testNetconfigRoam/TestFT.psk
@@ -0,0 +1,2 @@
+[Security]
+Passphrase=EasilyGuessedPassword
diff --git a/autotests/testNetconfigRoam/ft-psk-ccmp-1.conf b/autotests/testNetconfigRoam/ft-psk-ccmp-1.conf
new file mode 100644
index 00000000..b46d1f27
--- /dev/null
+++ b/autotests/testNetconfigRoam/ft-psk-ccmp-1.conf
@@ -0,0 +1,41 @@
+hw_mode=g
+channel=1
+ssid=TestFT
+utf8_ssid=1
+ctrl_interface=/var/run/hostapd
+
+r1_key_holder=120000000001
+nas_identifier=dummy1
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
+rkh_pull_timeout=50
+ft_over_ds=0
+ap_table_expiration_time=36000
+ap_table_max_size=10
+rrm_neighbor_report=1
+ocv=1
diff --git a/autotests/testNetconfigRoam/ft-psk-ccmp-2.conf b/autotests/testNetconfigRoam/ft-psk-ccmp-2.conf
new file mode 100644
index 00000000..3e215457
--- /dev/null
+++ b/autotests/testNetconfigRoam/ft-psk-ccmp-2.conf
@@ -0,0 +1,41 @@
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
+rkh_pull_timeout=50
+ft_over_ds=0
+ap_table_expiration_time=36000
+ap_table_max_size=10
+rrm_neighbor_report=1
+ocv=1
diff --git a/autotests/testNetconfigRoam/hw.conf b/autotests/testNetconfigRoam/hw.conf
new file mode 100644
index 00000000..c2b35d6e
--- /dev/null
+++ b/autotests/testNetconfigRoam/hw.conf
@@ -0,0 +1,8 @@
+[SETUP]
+num_radios=3
+start_iwd=0
+hwsim_medium=yes
+
+[HOSTAPD]
+rad0=ft-psk-ccmp-1.conf
+rad1=ft-psk-ccmp-2.conf
diff --git a/autotests/testNetconfigRoam/main.conf b/autotests/testNetconfigRoam/main.conf
new file mode 100644
index 00000000..aedd4ebd
--- /dev/null
+++ b/autotests/testNetconfigRoam/main.conf
@@ -0,0 +1,3 @@
+[General]
+EnableNetworkConfiguration=true
+RoamRetryInterval=1
diff --git a/autotests/testNetconfigRoam/netconfig_roam_test.py b/autotests/testNetconfigRoam/netconfig_roam_test.py
new file mode 100644
index 00000000..c66fc107
--- /dev/null
+++ b/autotests/testNetconfigRoam/netconfig_roam_test.py
@@ -0,0 +1,88 @@
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
+from iwd import DeviceState
+from hwsim import Hwsim
+from hostapd import HostapdCLI
+import testutil
+
+class Test(unittest.TestCase):
+    def test_roam_before_netconfig(self):
+        wd = IWD(True)
+
+        device = wd.list_devices(1)[0]
+        device.autoconnect = True
+
+        self.bss_hostapd[1].wait_for_event(f'AP-STA-CONNECTED {device.address}')
+        device.wait_for_event("connecting (netconfig)")
+
+        roam_to = 0
+        roam_from = 1
+
+        # Roam back and forth, ensuring that the state transitions between
+        # roaming and connecting (netconfig).
+        for _ in range(0, 5):
+            self.rules[roam_to].signal = -2000
+            self.rules[roam_from].signal = -8000
+
+            condition = 'obj.state == DeviceState.roaming'
+            wd.wait_for_object_condition(device, condition)
+
+            self.bss_hostapd[roam_to].wait_for_event(f'AP-STA-CONNECTED {device.address}')
+            device.wait_for_event("connecting (netconfig)")
+
+            tmp = roam_from
+            roam_from = roam_to
+            roam_to = tmp
+
+        self.bss_hostapd[roam_from].deauthenticate(device.address)
+        condition = 'obj.state == DeviceState.disconnected'
+        wd.wait_for_object_condition(device, condition)
+
+    def tearDown(self):
+        os.system('ip link set "' + self.bss_hostapd[0].ifname + '" down')
+        os.system('ip link set "' + self.bss_hostapd[1].ifname + '" down')
+        os.system('ip link set "' + self.bss_hostapd[0].ifname + '" up')
+        os.system('ip link set "' + self.bss_hostapd[1].ifname + '" up')
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
+        rule0 = hwsim.rules.create()
+        rule0.source = cls.bss_hostapd[0].bssid
+        rule0.signal = -6000
+        rule0.enabled = True
+
+        rule1 = hwsim.rules.create()
+        rule1.source = cls.bss_hostapd[1].bssid
+        rule1.signal = -2000
+        rule1.enabled = True
+
+        cls.rules = [rule0, rule1]
+
+        cls.bss_hostapd[0].set_address('12:00:00:00:00:01')
+        cls.bss_hostapd[1].set_address('12:00:00:00:00:02')
+
+        HostapdCLI.group_neighbors(*cls.bss_hostapd)
+
+    @classmethod
+    def tearDownClass(cls):
+        IWD.clear_storage()
+        cls.bss_hostapd = None
+        cls.rules = None
+
+if __name__ == '__main__':
+    unittest.main(exit=True)
-- 
2.34.1

