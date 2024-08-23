Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4148F1C871C
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 22:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724451838; cv=none; b=em8NVYOYwWBHURJgOD6xhJOV62X7uPvwPkqGNCfmTTIigQgsGv04gFEa1YO6c3bymrX0jkdrBXj1uDLYld5VVJwaA/zScHGBVefhBUAiFiNHZKkG7smqJLoAKhnqErHkTvzzgbdEvLgMw+YD5q06an5ODlgbfKSwQAkzpteEHuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724451838; c=relaxed/simple;
	bh=VtfRUqAptUpigOzeZjNHoVL4/+kBM519529S4p/CSgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dg3EpYqbFscBUPn//dxoeLhyhS6nmAhXLmMo/W3XMB8o1C+JB1kMk0S6Dv9SlNDByXmwD+y+E9F6VNDDcYKJcdzvA/rh7ULRNOWN/6JObwr2Mm/2cc50CyjLLxq8ZDrhgXwfaqsXzsLyavdZLMfAWfO7sQJk0kb1XUA8EOmv8hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YG/JPAd/; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YG/JPAd/"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a1d6f4714bso234198785a.1
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 15:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724451835; x=1725056635; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVb/OjA1ZX9/HSanVUxoiwPsw4Gq2DchDkWB3iptSm4=;
        b=YG/JPAd/974AB01dJt0U0S77FcEhdlUeFXox7OgwFRjtVk3fSUOar65wIABpHhNmip
         0NHbhytXK3dzry4/b7p1hE3EO0+QUXeTdB+XEqm+XSg8MkGXkdejkZDh8yA+HLNfy/YD
         QX5dkrswrDtNXNWoh3yQZNwNw2kOWQxLnfEqGQHy+utT8/QhTJ7FhiIYpKiIjuSWaT9z
         FXH2pitojpSlhDlJFLUOeykdtRlkwuDJ22j9PPpnk4y+R/+n0krLUs2MohiIt3uBuPpS
         B3YWJ6kkwZfzt6EsRoIQrrI8NPgC8IJ4L7kLg2dnAmwkLHnLqiA76NgO6Zadf+6MdQBO
         1Png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724451835; x=1725056635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVb/OjA1ZX9/HSanVUxoiwPsw4Gq2DchDkWB3iptSm4=;
        b=lI6JsXvps8zZ0/12SIRyoQPApfWH2CITPBE0NWryG0OHH23uTRXxDaKRZ7VU1oAYmd
         pa/ASpiDTfIuBJE+mtmU7wP31xZAlHSDo7vzQBfuMly3HDGRhCTQj+AcHR3wnm5+m1lR
         2dQHME8Tz1xKOFWed8i/w5rWhlsIXEn1p03rLRWhuhpKXj5JHFQuYwCqbjCQ19agxfx8
         ZO3q49uVE8fQm+zHfuJ+WaTHA9Sfregtzx8NMbvDwQgRf7YPcyy0sEO2bM9YPbwf+b/p
         5hfusH2sS4V1YB2hAQ62nR5J/otZJzlcey/hGsld/4AoO+2d9cWA99om+uLhra0DG95c
         tOLw==
X-Gm-Message-State: AOJu0YwC5Zc2RYtwEZxM53Sfa3Q3twXyilziM6qlV33FR5QtEwr4DVw8
	lDsi+oFYyEbMz1HX+iK5YrGUJjvbtm9Krom9Wup6YfaHmVsXXITARGDelg==
X-Google-Smtp-Source: AGHT+IFXn1F1i9lyeHcJkROVr4xrVyZSGom5fqEO1T8FaJsSONfPwutfzzeaGBvm1q6+838TAi+Yhg==
X-Received: by 2002:a05:620a:f07:b0:7a1:d69f:5b9c with SMTP id af79cd13be357-7a67d497da6mr1673145785a.27.1724451834956;
        Fri, 23 Aug 2024 15:23:54 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f41f507sm218860385a.132.2024.08.23.15.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 15:23:54 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 8/8] auto-t: add tests for Affinities behavior
Date: Fri, 23 Aug 2024 15:23:39 -0700
Message-Id: <20240823222339.328006-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823222339.328006-1-prestwoj@gmail.com>
References: <20240823222339.328006-1-prestwoj@gmail.com>
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

