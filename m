Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE14718BC3A
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 18:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724436027; cv=none; b=p1YRt6M0cRmXPEHWiOyt1MjSk860vGqurfAAuEpUJ0tTVtRTpM7cZlUuPu68qEyOL0NVpaWBZzTahpmR0i5SPSrpbHi1FcuHFlhj5y42k3tiLGPPU1FRZjstIxYE0omRFhcosI+WKd1NvEHpSVHy+7p2E2B+d3duAdzR4LyIGcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724436027; c=relaxed/simple;
	bh=VtfRUqAptUpigOzeZjNHoVL4/+kBM519529S4p/CSgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yb3+RD1vGXQMIlR9rdrosbMtx8hOB7H81pan5JJiLQsnh1oPzWEnrpY+tMAqNGzRdAp6h0Rll7RzonRbZ62kY4dkWPHyRqqJBt3v13EJlyRKmywpt/u2FwpfvbzLSe/ljqtcCtAGYrlT4HShI6djMCJ5e5nN6D2KqxbHtbny6co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VS0Nf3ur; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VS0Nf3ur"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7093abb12edso2074231a34.3
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 11:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724436025; x=1725040825; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVb/OjA1ZX9/HSanVUxoiwPsw4Gq2DchDkWB3iptSm4=;
        b=VS0Nf3ureH6nOkixQ2mk6r/MDDZ8DJPfaHDFTmu3g/2wju3zWwgWMBNOK0tCDo53M5
         yMYfxrDJAt2UriS2ml8uaMfwS0BhW+9mtjJRhhdMyill3yOUyy8T8eqnYmZ3oSGVOGND
         lRp6D9rOmh6/vnUtgAsU0QCjhtybGqw889VMR70yiH243hCeIWm6hFCimlXEtaZsDhoi
         tqBa57Ym3WsX5Ynd8uCX4qW16PSgd5CtqhwoWDv704uS7HADk0jAMN22kWQ8beSXk3Dq
         fcSLLGt6qgMpz9b0hsGZsMCpXM+dxG3LfRKdlTcn07ilyZgScRrw5cZJu3N6FZuBKC7W
         xEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724436025; x=1725040825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVb/OjA1ZX9/HSanVUxoiwPsw4Gq2DchDkWB3iptSm4=;
        b=QsXouTt5TLy8mEVcL24C9HMua7tMFrobhPgY4rcO7b9Xw9mXLGWWWBo++JyL6RUfTL
         ggaQX/Ol0JGlugg+hgdEYNVA1wQv34euy0AeFuobEFVxuBxAUsVFZTxgZMGDynx9iRFB
         0p/fD5YGxTnbWSKb7i8EO0L+Nlvn0NWrWPO/QSZO7RoHHbDujnuVikJHXwenhzoRyKMz
         o4gYVrnTbSy6P7V41rPpyBHSjBaZI+O96lBGigWodynYJEQb0m6GavD7qz/nQY3zyVzF
         MY42JI/oqfCLyf8Fk60gXR22JfOUPtnFaQIc8jisbA+QmENS3v/sYk3TDXD7ZIIKRQPw
         ardw==
X-Gm-Message-State: AOJu0YwxJnUMcWuiLq0lOGVWKpUg+PPTnpvbNziPdiT8yDNTMhhQrpJU
	6A5lJjNg8Yedm3SZ2TKD70w1kBzTlB0FaTeE2DC749mCrEzhnRpvfvXpKA==
X-Google-Smtp-Source: AGHT+IFrd+0ldp6GaPdSd0RWBgv34ueGC6BMUnDhr+LfuPYZuTaEg+1q6oZf/NzJC9Y8ru7jC6K+kw==
X-Received: by 2002:a05:6808:138b:b0:3d9:e109:a6d3 with SMTP id 5614622812f47-3de2a8a8f3bmr3480735b6e.26.1724436024554;
        Fri, 23 Aug 2024 11:00:24 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe0f0507sm19683131cf.47.2024.08.23.11.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 11:00:24 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 8/8] auto-t: add tests for Affinities behavior
Date: Fri, 23 Aug 2024 11:00:06 -0700
Message-Id: <20240823180006.317353-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823180006.317353-1-prestwoj@gmail.com>
References: <20240823180006.317353-1-prestwoj@gmail.com>
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

