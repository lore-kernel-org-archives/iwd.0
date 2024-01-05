Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0872DF66
	for <iwd@lists.linux.dev>; Fri,  5 Jan 2024 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLY8CRp9"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-680285e7ce8so7911906d6.0
        for <iwd@lists.linux.dev>; Fri, 05 Jan 2024 06:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704466077; x=1705070877; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/r+PrxhLULk0AIV/gOfDgqr0E3rZeZFz3B5cwT2Dg88=;
        b=aLY8CRp99X41iW9JfB5CqRGSi/5bIAqoGFqnXa6DrPsVXxnfUi8XIKfmulw4FWY7MK
         ll6NuQ5WEMRpZ5ZvHeR40/FYl34VrSDBCm9OAV99kF6WAxBn95XO0vFiaAw5yb/H0pn2
         MchgNGw83rfQfarM5lYmBwLBk7MAtxQFrCwT7yQ1F/EVv34nIeHnE3zqi96YFQT8dl6u
         3wo9Pq/l7Mve0FdjqApbOCMZWCZfVmEUfTLKNygmMQJ7Au7+EOxfdcdPMlEjrJ+ZAT1E
         GxAG3YX6VuSuCfYVEyRgbXe8C4L/JYMIOyamiOvf1TFRHyf9c2OcRLgp8vse30/EkW7m
         gMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704466077; x=1705070877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/r+PrxhLULk0AIV/gOfDgqr0E3rZeZFz3B5cwT2Dg88=;
        b=YeM0GnJKfsa5VqbYMz3Exixs34DLb3jReDxONLRX5/rvqEZr8mwq56WR95b0j/S82Y
         5lo7xZZPPZAVNPTktjghnPift+J9JbwVTYR7hPNJ3QppGuiik0LRUjNyhEzMx7t6RYyZ
         sWTm/b6xqdGn3sZkyB9bPxkKwOyf4UvpYTXdetzT284EEPRONPTH5qUy31+vPph9AUGn
         LcXkBE53dH4RHG0PRLI9FFXftArsaZkVZUjsCnQKEM8MLjXmeu1spaYbE6iMM6KclfG6
         yAs5QVQXz67nojTI/e/jnI4qecHf25XzvNO4AdoiXRZsxmafCIt+FTaKBAMUqLUcP0tQ
         whQA==
X-Gm-Message-State: AOJu0YytTPnWQCZnc4ZZPxCbOMOeRjpFItgF+rPjZhvIeeiE1W3cLgnW
	fgI0hKO/Op20ShfWWZ7dBKO7GEEPIL8=
X-Google-Smtp-Source: AGHT+IGehvA30TDOY3fQHW+v5m7nIbV/nELZxtYw4+g9lR1zypFPSlJXW6zaj1SNVWsYet7MRZZ9Rg==
X-Received: by 2002:a05:6214:29c6:b0:67f:b763:81a with SMTP id gh6-20020a05621429c600b0067fb763081amr2732822qvb.47.1704466077366;
        Fri, 05 Jan 2024 06:47:57 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id pz30-20020ad4551e000000b0067f8f04a2fcsm656843qvb.57.2024.01.05.06.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 06:47:56 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/3] auto-t: add test for roaming + netconfig
Date: Fri,  5 Jan 2024 06:47:50 -0800
Message-Id: <20240105144750.839705-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105144750.839705-1-prestwoj@gmail.com>
References: <20240105144750.839705-1-prestwoj@gmail.com>
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
 .../testNetconfigRoam/netconfig_roam_test.py  | 91 +++++++++++++++++++
 6 files changed, 186 insertions(+)
 create mode 100644 autotests/testNetconfigRoam/TestFT.psk
 create mode 100644 autotests/testNetconfigRoam/ft-psk-ccmp-1.conf
 create mode 100644 autotests/testNetconfigRoam/ft-psk-ccmp-2.conf
 create mode 100644 autotests/testNetconfigRoam/hw.conf
 create mode 100644 autotests/testNetconfigRoam/main.conf
 create mode 100644 autotests/testNetconfigRoam/netconfig_roam_test.py

v2:
 * Updated to check/ensure that IWD remains "connecting" even through
   multiple roams.

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
index 00000000..63e5eabf
--- /dev/null
+++ b/autotests/testNetconfigRoam/netconfig_roam_test.py
@@ -0,0 +1,91 @@
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
+        device.get_ordered_network('TestFT', full_scan=True)
+        device.connect_bssid(self.bss_hostapd[1].bssid)
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
+            # Station should internally transition to roaming, but remain in a
+            # connecting state on DBus
+            device.wait_for_event("ft-roaming")
+            self.assertEqual(device.state, DeviceState.connecting)
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

