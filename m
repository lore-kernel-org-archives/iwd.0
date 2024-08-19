Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F5C16132E
	for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 17:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724089933; cv=none; b=f9jlwNtFCgLtwVCyQtMSgb9uWh3LzEISWXaiH+X6K8ydMCpqWiIg7Av1HRijqHQP6EIl66strFCarnBACA5cpL7d1VpB23v2hi/6drTak+Jgbn5esjWtUjHtWrQMITy8pWczI43kQVotUKti8hFj5k8tDBlT/ljQOQrKTjATWaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724089933; c=relaxed/simple;
	bh=VtfRUqAptUpigOzeZjNHoVL4/+kBM519529S4p/CSgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PUavRVHvt39QQfnP8crIUFP4OAG6WDVknEm2+8XOaVIspwZG4WYt0FKgVZwZrmGHgEiQo10k1tu3/CceHM6SHY8o37c6aJi+7nvumqewfqJ3jH0kp0EWsc+4c2HWeLP0gjGmGip92bEXv2HlXVAvUZXZ9vbD59RrCjQqJIujo0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0wNboPt; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0wNboPt"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a1d066a5daso312712885a.3
        for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 10:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724089929; x=1724694729; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVb/OjA1ZX9/HSanVUxoiwPsw4Gq2DchDkWB3iptSm4=;
        b=m0wNboPtIzKPvToY7ZfL9luGkL4HlfZtEx4zESOn1rQAdN7Cut8a7sCiohFYaywbWZ
         GAXcE0IXeRRA57VPxtVYYXZ90iN9cnFz0rJHImndNMpslReLWxEkZOlLoBomXRflIZ2b
         eM7G5CrvvuUS4eOV6PcGY29wPByf1CaArPuaNInAj/5Pf9PXbd4XD13HmhWGl+2K+FNK
         nvvqs4xUSzUzWrEpN/SaHeWPliJMNPgiqtBTAAAuevY8TikHXw3NqtRi76TSfEizgTFF
         TES+wD2B9/wBTUv7Nb6P4EasgB0tltpQLFPQvuCW21l4rH0EYXi2yzklXO+vpV5iujPI
         sXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724089929; x=1724694729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVb/OjA1ZX9/HSanVUxoiwPsw4Gq2DchDkWB3iptSm4=;
        b=ihN3O89XpMaeEV8Ucyap3hgZqPBENmADkKerYPV41XNX9YshOiVKM4X8NOGkos4g7R
         YKOazep2wHXlgwNDTQdiX9oQL/7k4x7wXb3CKNb7aASkwWZcAunQvomIKv9Ys2YeHzGb
         GiYgWP4Nj+Cw1gawwXQAPSEOskOp2391oD2++I+2DdVPOLrG12EFkPYzfKHuF9MH6JJo
         Tfp608rROzw1jL9xkUE5dzjHT/pLR8Vacxjr0MnjuDSV2H784oQpJjcdYE8nAfTaM+7k
         qD2T7sXMACeDu6a36yO4LnGGAZlX56n1aq6lbwgEj7q/Gsrv14zjieoHLuPSFgyw6XD3
         RTBw==
X-Gm-Message-State: AOJu0YxuLOpEGPs/ZFmpL7f3lQ6ahbTVoaJP/KTItIRglOlIM3AX04WU
	z+EbepUYUrd3ui0ZOIMutqOKjNH8K3aWUPDzJdwCJvva6b6F55Vlcfh0dg==
X-Google-Smtp-Source: AGHT+IG3R9jeRVrwfTyDprz4wxmnnZPHiO2KwmlWZgzSP04TJp6aen2oEQIC1OoMvmotZpHUKsFmGQ==
X-Received: by 2002:a05:620a:2727:b0:7a6:56f7:7b2a with SMTP id af79cd13be357-7a656f77d33mr700461885a.26.1724089928636;
        Mon, 19 Aug 2024 10:52:08 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0e5a1csm451854685a.74.2024.08.19.10.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 10:52:08 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 8/8] auto-t: add tests for Affinities behavior
Date: Mon, 19 Aug 2024 10:51:51 -0700
Message-Id: <20240819175151.1310546-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819175151.1310546-1-prestwoj@gmail.com>
References: <20240819175151.1310546-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/testAffinity/TestFT.psk           |   2 +
 autotests/testAffinity/ft-psk-ccmp-1.conf   |  41 ++++
 autotests/testAffinity/ft-psk-ccmp-2.conf   |  41 ++++
 autotests/testAffinity/hw.conf              |   8 +
 autotests/testAffinity/main.conf            |   5 +
 autotests/testAffinity/test_set_affinity.py | 216 ++++++++++++++++++++
 6 files changed, 313 insertions(+)
 create mode 100644 autotests/testAffinity/TestFT.psk
 create mode 100644 autotests/testAffinity/ft-psk-ccmp-1.conf
 create mode 100644 autotests/testAffinity/ft-psk-ccmp-2.conf
 create mode 100644 autotests/testAffinity/hw.conf
 create mode 100644 autotests/testAffinity/main.conf
 create mode 100644 autotests/testAffinity/test_set_affinity.py

diff --git a/autotests/testAffinity/TestFT.psk b/autotests/testAffinity/TestFT.psk
new file mode 100644
index 00000000..e82d1295
--- /dev/null
+++ b/autotests/testAffinity/TestFT.psk
@@ -0,0 +1,2 @@
+[Security]
+Passphrase=EasilyGuessedPassword
diff --git a/autotests/testAffinity/ft-psk-ccmp-1.conf b/autotests/testAffinity/ft-psk-ccmp-1.conf
new file mode 100644
index 00000000..839eb496
--- /dev/null
+++ b/autotests/testAffinity/ft-psk-ccmp-1.conf
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
diff --git a/autotests/testAffinity/ft-psk-ccmp-2.conf b/autotests/testAffinity/ft-psk-ccmp-2.conf
new file mode 100644
index 00000000..2ffd7262
--- /dev/null
+++ b/autotests/testAffinity/ft-psk-ccmp-2.conf
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
diff --git a/autotests/testAffinity/hw.conf b/autotests/testAffinity/hw.conf
new file mode 100644
index 00000000..c2b35d6e
--- /dev/null
+++ b/autotests/testAffinity/hw.conf
@@ -0,0 +1,8 @@
+[SETUP]
+num_radios=3
+start_iwd=0
+hwsim_medium=yes
+
+[HOSTAPD]
+rad0=ft-psk-ccmp-1.conf
+rad1=ft-psk-ccmp-2.conf
diff --git a/autotests/testAffinity/main.conf b/autotests/testAffinity/main.conf
new file mode 100644
index 00000000..3d93ff57
--- /dev/null
+++ b/autotests/testAffinity/main.conf
@@ -0,0 +1,5 @@
+[Scan]
+DisableMacAddressRandomization=true
+
+[General]
+RoamRetryInterval=1
diff --git a/autotests/testAffinity/test_set_affinity.py b/autotests/testAffinity/test_set_affinity.py
new file mode 100644
index 00000000..5754aee0
--- /dev/null
+++ b/autotests/testAffinity/test_set_affinity.py
@@ -0,0 +1,216 @@
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
+        self._station_prop_if = dbus.Interface(
+                        self._bus.get_object(iwd.IWD_SERVICE, device_path),
+                        iwd.DBUS_PROPERTIES)
+
+    def set(self, values):
+        self._station_prop_if.Set(iwd.IWD_STATION_INTERFACE, 'Affinities', dbus.Array([dbus.ObjectPath(v) for v in values], signature="o"))
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
+        print(device.connected_bss)
+
+        device.affinities = [device.connected_bss]
+
+        # IWD should not attempt to roam
+        with self.assertRaises(TimeoutError):
+            device.wait_for_event("roam-scan-triggered")
+
+        device.affinities = []
+        device.wait_for_event("roam-scan-triggered")
+
+    def test_roam_below_critical(self):
+        device = self.wd.list_devices(1)[0]
+
+        self.connect(device, self.bss_hostapd[0])
+
+        device.affinities = [device.connected_bss]
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
+    def test_error_conditions(self):
+        device = self.wd.list_devices(1)[0]
+
+        # Calling set while disconnected should fail
+        with self.assertRaises(iwd.NotConnectedEx):
+            device.affinities = ["/some/path"]
+
+        self.connect(device, self.bss_hostapd[0])
+
+        device.affinities = [device.connected_bss]
+
+        # An invalid path should fail
+        with self.assertRaises(iwd.InvalidArgumentsEx):
+            device.affinities = [device.connected_bss, "/an/invalid/path"]
+
+    def test_affinity_client_disconnect(self):
+        device = self.wd.list_devices(1)[0]
+
+        client = AffinityClient(device.device_path)
+
+        self.connect(device, self.bss_hostapd[0])
+
+        client.set([device.connected_bss])
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
+        client.set([device.connected_bss])
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
+        client.set([device.connected_bss])
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
+        client.set([device.connected_bss])
+        self.wd.stop()
+
+    def test_affinity_removed_after_roam(self):
+        device = self.wd.list_devices(1)[0]
+
+        self.connect(device, self.bss_hostapd[0])
+
+        device.affinities = [device.connected_bss]
+
+        # Lower signal past critical level
+        self.bss0_rule.signal = -9000
+
+        device.wait_for_event("roam-scan-triggered")
+
+        device.wait_for_event("ft-authenticating")
+        device.wait_for_event("associating")
+        device.wait_for_event("connected")
+
+        self.assertEqual(device.affinities, [])
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

