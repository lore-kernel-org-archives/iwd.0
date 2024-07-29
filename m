Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40F41487EF
	for <iwd@lists.linux.dev>; Mon, 29 Jul 2024 12:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257067; cv=none; b=m8G9Rp+zVlSSmqymoHPR7TVN83iieJsqqbzaFupeTyR6UGvEx6luKA+tLTKnbYvvfV7eigvoOBD+JY7wbbicaxJAqcdmiQ4ET4BSUSabJBNd9XmaybgG4c7MkSE3jaYnii764tdvtEBaRPm69VAvsBKjED2yB3QpJ96ALHG7USI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257067; c=relaxed/simple;
	bh=+gQrkK+sZMZUhh0j8r95Ix509+sdIhu/RXrfAomQzCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MizHRrc8UKPV2DjfntWTBiUbiVhjU0IqBYgAYR5xEMLb3bxmD3MTMJNZEKvEQjWMqKZJDIWR56H8wL+oCX5zWLk4RHKK5WjouVyYZlo0wfbmYSG2KlCQNfWqeRAs3DiK29d01VIE3VrEvndW3aspckWoHXMUrchiQhFTfJ3DTL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnY8IsGJ; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnY8IsGJ"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b78c980981so18130126d6.2
        for <iwd@lists.linux.dev>; Mon, 29 Jul 2024 05:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722257064; x=1722861864; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JohrDw1YpOqYVOu6XykXepNIkgE3z15AcpREOSOK2NQ=;
        b=EnY8IsGJ5+N8JJVryTsa17DQnRvSNZoGwSD85DKwS4f0/WYuUJ8aiLVAa6S7L1b/Y5
         oVFFPYvACLsEsArGALgrzEUJSWZMpHD74ruP467g41/QH+gSz2xtVlBTCDCoJZuZjnJP
         agednxZMy2uFydRtPX/yp2J6SkRujbuz1x/OYCdHzayycj9QmXraeqcLvUtL7F06re3R
         HYuLuP38DIkpyBTST41fn55/J+h9fFAOqNItyvYTIDsRRB/nl90ypPnUUUk1UeNBoVlR
         kCSRGcOehHL3WejpPnCBwIhBv+HWAH0x7gsf76O+rNNanCDNkPfINiPTO+TAwC7Ub3g3
         1Wsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722257064; x=1722861864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JohrDw1YpOqYVOu6XykXepNIkgE3z15AcpREOSOK2NQ=;
        b=XsaNysCIgTX80JTj0OzD+byuZRqFKu1IHhLoIeIAqYwyVCTr5NKgFXAuvDN7WO4luR
         vl6RQkiOxPdlX/TXxFV4sUCdcXBkv1VciCwKR9ew82EFNEVcbL/Xv3SeM1OoIaKQwUna
         xVg8jDZkED9lg4HfGP6oBvTgLU2gIwMhMW+dmGomtHRIUysrcna4IxSbjy3TqLFdoEdZ
         ePNG1BWbRWtACShGQLH3NRBvbzoJpH8etd/rdsbFfElWQm6CqWvc5AOy+itCD8uxPjUi
         l1G/uao5fHzqD2dLD1vWayppY/4jSPA/yZerLQFUYhdGar5asGvY0d3/INq+liva2AzB
         m16Q==
X-Gm-Message-State: AOJu0YxmuLMyy9ENWk4m7Yp0xI5GW9umNRX3CyVOfWU/ygccfzoXf2bM
	+k357P7zlx1Wsfxf0cwCsZ3AZWbvwsARDP5MSME2YMdGNq7Hrk/0WzctiQ==
X-Google-Smtp-Source: AGHT+IFJ2eUbrgXDhBMkib+TusVklt0rn66PQqsi3dKohRTN4gcZz7TnYniQ1UGI4zjAc/4JwgUlZQ==
X-Received: by 2002:a05:6214:c2c:b0:6b7:ab54:3b97 with SMTP id 6a1803df08f44-6bb559fa829mr83788546d6.23.1722257064266;
        Mon, 29 Jul 2024 05:44:24 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8d84edsm51171266d6.14.2024.07.29.05.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 05:44:23 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/6] auto-t: add tests for set/unset affinity
Date: Mon, 29 Jul 2024 05:44:10 -0700
Message-Id: <20240729124410.1763549-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729124410.1763549-1-prestwoj@gmail.com>
References: <20240729124410.1763549-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/testSetAffinity/TestFT.psk          |   2 +
 autotests/testSetAffinity/ft-psk-ccmp-1.conf  |  41 ++++
 autotests/testSetAffinity/ft-psk-ccmp-2.conf  |  41 ++++
 autotests/testSetAffinity/hw.conf             |   8 +
 autotests/testSetAffinity/main.conf           |   5 +
 .../testSetAffinity/test_set_affinity.py      | 224 ++++++++++++++++++
 6 files changed, 321 insertions(+)
 create mode 100644 autotests/testSetAffinity/TestFT.psk
 create mode 100644 autotests/testSetAffinity/ft-psk-ccmp-1.conf
 create mode 100644 autotests/testSetAffinity/ft-psk-ccmp-2.conf
 create mode 100644 autotests/testSetAffinity/hw.conf
 create mode 100644 autotests/testSetAffinity/main.conf
 create mode 100644 autotests/testSetAffinity/test_set_affinity.py

diff --git a/autotests/testSetAffinity/TestFT.psk b/autotests/testSetAffinity/TestFT.psk
new file mode 100644
index 00000000..e82d1295
--- /dev/null
+++ b/autotests/testSetAffinity/TestFT.psk
@@ -0,0 +1,2 @@
+[Security]
+Passphrase=EasilyGuessedPassword
diff --git a/autotests/testSetAffinity/ft-psk-ccmp-1.conf b/autotests/testSetAffinity/ft-psk-ccmp-1.conf
new file mode 100644
index 00000000..839eb496
--- /dev/null
+++ b/autotests/testSetAffinity/ft-psk-ccmp-1.conf
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
+ieee80211w=0
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
diff --git a/autotests/testSetAffinity/ft-psk-ccmp-2.conf b/autotests/testSetAffinity/ft-psk-ccmp-2.conf
new file mode 100644
index 00000000..2ffd7262
--- /dev/null
+++ b/autotests/testSetAffinity/ft-psk-ccmp-2.conf
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
+ieee80211w=0
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
diff --git a/autotests/testSetAffinity/hw.conf b/autotests/testSetAffinity/hw.conf
new file mode 100644
index 00000000..c2b35d6e
--- /dev/null
+++ b/autotests/testSetAffinity/hw.conf
@@ -0,0 +1,8 @@
+[SETUP]
+num_radios=3
+start_iwd=0
+hwsim_medium=yes
+
+[HOSTAPD]
+rad0=ft-psk-ccmp-1.conf
+rad1=ft-psk-ccmp-2.conf
diff --git a/autotests/testSetAffinity/main.conf b/autotests/testSetAffinity/main.conf
new file mode 100644
index 00000000..3d93ff57
--- /dev/null
+++ b/autotests/testSetAffinity/main.conf
@@ -0,0 +1,5 @@
+[Scan]
+DisableMacAddressRandomization=true
+
+[General]
+RoamRetryInterval=1
diff --git a/autotests/testSetAffinity/test_set_affinity.py b/autotests/testSetAffinity/test_set_affinity.py
new file mode 100644
index 00000000..8a0fdf21
--- /dev/null
+++ b/autotests/testSetAffinity/test_set_affinity.py
@@ -0,0 +1,224 @@
+#! /usr/bin/python3
+
+import unittest
+import sys, os
+import dbus
+
+sys.path.append('../util')
+from config import ctx
+import iwd
+from iwd import IWD, IWDDBusAbstract
+from iwd import NetworkType
+from hwsim import Hwsim
+from hostapd import HostapdCLI
+
+#
+# Separate client used to test DBus disconnects so we don't bring down the
+# entire IWD python library
+#
+class AffinityClient(IWDDBusAbstract):
+    def __init__(self, device_path):
+        self._bus = dbus.bus.BusConnection(address_or_type=ctx.dbus_address)
+        self._station_if = dbus.Interface(self._bus.get_object(iwd.IWD_SERVICE,
+                                      device_path), iwd.IWD_STATION_INTERFACE)
+
+    def set(self):
+        self._station_if.SetConnectedBssAffinity(reply_handler=self._success,
+                                        error_handler=self._failure)
+        self._wait_for_async_op()
+
+    def unset(self):
+        self._station_if.UnsetConnectedBssAffinity(reply_handler=self._success,
+                                        error_handler=self._failure)
+        self._wait_for_async_op()
+
+    def close(self):
+        self._bus.close()
+
+class Test(unittest.TestCase):
+    def connect(self, device, hapd):
+        ordered_network = device.get_ordered_network('TestFT', full_scan=True)
+
+        self.assertEqual(ordered_network.type, NetworkType.psk)
+
+        condition = 'not obj.connected'
+        self.wd.wait_for_object_condition(ordered_network.network_object, condition)
+
+        device.connect_bssid(hapd.bssid)
+
+        condition = 'obj.state == DeviceState.connected'
+        self.wd.wait_for_object_condition(device, condition)
+
+    def test_set_affinity(self):
+        device = self.wd.list_devices(1)[0]
+
+        self.connect(device, self.bss_hostapd[0])
+
+        device.set_connected_bss_affinity()
+
+        # IWD should not attempt to roam
+        with self.assertRaises(TimeoutError):
+            device.wait_for_event("roam-scan-triggered")
+
+        device.unset_connected_bss_affinity()
+        device.wait_for_event("roam-scan-triggered")
+
+    def test_roam_below_critical(self):
+        device = self.wd.list_devices(1)[0]
+
+        self.connect(device, self.bss_hostapd[0])
+
+        device.set_connected_bss_affinity()
+
+        # IWD should not attempt to roam
+        with self.assertRaises(TimeoutError):
+            device.wait_for_event("roam-scan-triggered")
+
+        # Lower signal past critical level
+        self.bss0_rule.signal = -9000
+
+        device.wait_for_event("roam-scan-triggered")
+
+    def test_affinity_reset_after_roam(self):
+        device = self.wd.list_devices(1)[0]
+
+        self.connect(device, self.bss_hostapd[0])
+
+        device.set_connected_bss_affinity()
+
+        # Lower signal past critical level
+        self.bss0_rule.signal = -9000
+
+        device.wait_for_event("roam-scan-triggered")
+        device.wait_for_event("ft-authenticating")
+        device.wait_for_event("associating")
+        device.wait_for_event("connected")
+
+        # Affinity should be reset, and IWD should be trying to roam
+        device.wait_for_event("roam-scan-triggered")
+
+    def test_error_conditions(self):
+        device = self.wd.list_devices(1)[0]
+
+        # Calling set while disconnected should fail
+        with self.assertRaises(iwd.NotConnectedEx):
+                device.set_connected_bss_affinity()
+
+        # Calling unset prior to a successful set should fail
+        with self.assertRaises(iwd.NotConfiguredEx):
+                device.unset_connected_bss_affinity()
+
+        self.connect(device, self.bss_hostapd[0])
+
+        device.set_connected_bss_affinity()
+
+        # Multiple calls to set should fail
+        with self.assertRaises(iwd.AlreadyExistsEx):
+             device.set_connected_bss_affinity()
+
+    def test_affinity_client_disconnect(self):
+        device = self.wd.list_devices(1)[0]
+
+        client = AffinityClient(device.device_path)
+
+        self.connect(device, self.bss_hostapd[0])
+
+        client.set()
+
+        with self.assertRaises(TimeoutError):
+            device.wait_for_event("roam-scan-triggered")
+
+        client._bus.close()
+
+        device.wait_for_event("roam-scan-triggered")
+
+    def test_affinity_client_reconnect_during_roam(self):
+        device = self.wd.list_devices(1)[0]
+
+        client = AffinityClient(device.device_path)
+
+        self.connect(device, self.bss_hostapd[0])
+
+        client.set()
+
+        # Lower signal past critical level
+        self.bss0_rule.signal = -9000
+
+        device.wait_for_event("roam-scan-triggered")
+
+        client.close()
+        del client
+        client = AffinityClient(device.device_path)
+        # setting here should get cleared after connecting
+        client.set()
+
+        device.wait_for_event("ft-authenticating")
+        device.wait_for_event("associating")
+        device.wait_for_event("connected")
+
+        # Affinity should be reset, and IWD should be trying to roam
+        device.wait_for_event("roam-scan-triggered")
+
+    def test_cleanup_with_connected_client(self):
+        device = self.wd.list_devices(1)[0]
+
+        client = AffinityClient(device.device_path)
+
+        self.connect(device, self.bss_hostapd[0])
+
+        client.set()
+        self.wd.stop()
+
+    def tearDown(self):
+        os.system('ip link set "' + self.bss_hostapd[0].ifname + '" down')
+        os.system('ip link set "' + self.bss_hostapd[1].ifname + '" down')
+        os.system('ip link set "' + self.bss_hostapd[0].ifname + '" up')
+        os.system('ip link set "' + self.bss_hostapd[1].ifname + '" up')
+
+        self.wd.stop()
+        self.wd = None
+
+    def setUp(self):
+        self.bss0_rule.signal = -8000
+        self.bss1_rule.signal = -8000
+
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
+        rad0 = hwsim.get_radio('rad0')
+        rad1 = hwsim.get_radio('rad1')
+
+        cls.bss0_rule = hwsim.rules.create()
+        cls.bss0_rule.source = rad0.addresses[0]
+        cls.bss0_rule.bidirectional = True
+        cls.bss0_rule.signal = -8000
+        cls.bss0_rule.enabled = True
+
+        cls.bss1_rule = hwsim.rules.create()
+        cls.bss1_rule.source = rad1.addresses[0]
+        cls.bss1_rule.bidirectional = True
+        cls.bss1_rule.signal = -8000
+        cls.bss1_rule.enabled = True
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
+        cls.bss0_rule.remove()
+        cls.bss1_rule.remove()
+
+if __name__ == '__main__':
+    unittest.main(exit=True)
-- 
2.34.1

