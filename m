Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0BC1A0AF3
	for <iwd@lists.linux.dev>; Tue, 13 Aug 2024 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564620; cv=none; b=NIlWAKA96469E8BHNZQaRD8ULy1fPb1Cjc+GBPVDxN6h0WGr0amOCm4+sLWOYmImLtX9cEGTPk1y6qYEsmQc8SCqCuc5dNkoVA4WxaBLearmZzcL0C/ATsojt8Vm2QGaowf4hR0KY58t5FrCUtgoTcDeqhO7uPuxM/0NeFjegTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564620; c=relaxed/simple;
	bh=8hLMnJe9bIdtE+LX70MNwmIvB2g5jRKJo39S8/tGCVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GKCCQdCEGgsrDCSrLYT2ZLBIvCUyLob4H8Sjd/EoAc/cLdeXouL5VKzIBHCcqN1xUeQRTHyirj2BFpqs/2I7017E1J88Z6lDUbAD0zd5zkkigEktCwHDnJoisdq0jksiHnyuee625rPymwrzj4RUD4KzNLKAC1aqaMcYUrJxbzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPKKLE56; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPKKLE56"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b78c980981so31857726d6.2
        for <iwd@lists.linux.dev>; Tue, 13 Aug 2024 08:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723564617; x=1724169417; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uKfMHqNkvdM8b0cHGDx72DZKGmRqCA0kvcVQsRlpbM=;
        b=MPKKLE56MNq+1RWSgOUvtikQowTGmk2w88xlpZznFDvUqdd8ET4SpoXG3/dQJA9ZOP
         sVxT4I2NmTERWlBOC+GooKSJqLexLu+WLKpVUGmE2lv+jBaI4Ro5rHN5CLtqjtvUdeg1
         YkXagZS6VffaTA39cqJeBTukGj6m5QZ9tM9UCgM1H+Xi5jOzSb5VTYVwATa/IDnIPgVb
         hAfEe7riCiSgp+vhE7MRAARBRUBHgxdxSwBzl6WkDqSGOVFjwIH0lTSGNpE9lsbjgnss
         n4nQijTjB43us9oi7QGQs5LhJjPQyOt3FYCdm8EuCXCwSy4O9yZm+wbAIwoq7AYAcabk
         xANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723564617; x=1724169417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uKfMHqNkvdM8b0cHGDx72DZKGmRqCA0kvcVQsRlpbM=;
        b=CiTbdeq3wW5bc+k/Mzw+XcZfi95NgcyM7VJ7FxacL/X8pD6H32DN7y/OWBVV037x0i
         3yQUqDo2HNEI5CTrRbpsMP7ezlbxSGeYNRukfEpfnPFMeZSJxLQvxsdLzJ0/50kcw0iL
         d2AfNSrcx0734rpocfeFE95V3z421xXT094adIwUsOhNLnelEcyEEDQJg6H8OHjavGG8
         zf1Lr4gUzfMwQBhMp1G/93Iii+Stmb2sq7iFlQkRQ7YExlKPjbmzjGxFl8fI1lEmuqWi
         WNBgtNokcHzJe6WeoWTNMttYxoRFv/IStHGch4ZuMEHj25i1YvhXV0zPN10+G8bB32h+
         Td2A==
X-Gm-Message-State: AOJu0YxA5sF0DUz+RSUYH7ZKZWHUOT/FoNZH635L3aAm576TDlMrkeST
	KTrNfq5ZqzuJ3ljMLvrBKGnbhOSVQe1L3SFzQz/cz6a8cmSm7z4Cpz6fFg==
X-Google-Smtp-Source: AGHT+IHFu+sjIvqpdjiYMoov7ibJd1T0PBS215F5B1AZZPLD9XLl/cMdc8EGelgOftSPy8KpDg46hQ==
X-Received: by 2002:a05:6214:468c:b0:6bb:be58:f282 with SMTP id 6a1803df08f44-6bf4f884af2mr54070626d6.53.1723564616973;
        Tue, 13 Aug 2024 08:56:56 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82ca2024sm35825706d6.72.2024.08.13.08.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 08:56:56 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 9/9] auto-t: add tests for Affinities behavior
Date: Tue, 13 Aug 2024 08:56:38 -0700
Message-Id: <20240813155638.74987-9-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813155638.74987-1-prestwoj@gmail.com>
References: <20240813155638.74987-1-prestwoj@gmail.com>
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
 autotests/testAffinity/test_set_affinity.py | 231 ++++++++++++++++++++
 6 files changed, 328 insertions(+)
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
index 00000000..efd914a4
--- /dev/null
+++ b/autotests/testAffinity/test_set_affinity.py
@@ -0,0 +1,231 @@
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
+    def test_affinity_directed_roaming(self):
+        device = self.wd.list_devices(1)[0]
+        network = device.get_ordered_network("TestFT").network_object
+
+        self.bss0_rule.signal = -7500
+        self.bss1_rule.signal = -7500
+
+        self.connect(device, self.bss_hostapd[0])
+
+        # Don't set the affinity on the current BSS, but on the other
+        affinities = [path for path in network.extended_service_set if path != device.connected_bss]
+
+        device.affinities = affinities
+
+        # We should roam to the other BSS.
+        device.wait_for_event("ft-authenticating")
+        device.wait_for_event("associating")
+        device.wait_for_event("connected")
+
+        # The affinity should still be set on this new BSS, causing the roam
+        # threshold to drop. We should not roam in this case.
+        with self.assertRaises(TimeoutError):
+            device.wait_for_event("roam-scan-triggered")
+
+        # Now set the affinity back to the prior BSS, which should adjust the
+        # ranking such that we roam back
+        device.affinities = [device.connected_bss]
+
+        device.wait_for_event("ft-authenticating")
+        device.wait_for_event("associating")
+        device.wait_for_event("connected")
+
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

