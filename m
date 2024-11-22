Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECA41DF99D
	for <iwd@lists.linux.dev>; Fri, 22 Nov 2024 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288579; cv=none; b=mfTaIBXOnZhW++6KS8h6Mx683I7QoVrgATwYLtCEkFMexRMG0SLzsh6Bg22cSiBOa6JasbL2FLwRnUMZzutRDhge5esdMH1h9Gu9dTEfVMoxWxtI0b57CpXK3fDwJhYZBVr5qVbqfWea2KCbqXQV+1nsJatFvIydLC8tUhX5x9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288579; c=relaxed/simple;
	bh=V15vIXSFqTi9eUGPQNCm/rL44+++70q67n/coRZUT8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SpYaPzL8Rm/Uxd5qiOA81vEy2dTn/G/Mt9prxRVdjGGJUR3JB9DgTeUIrgLQ7VO5lw7DpQUhSj/V205zcCBSOSIPbeII5zGUUeu6Y812KC6BpFuLdcXeb1dDuzKeSUUOjbok3qHRPjRPiaq2SERkxoobb6Pz5qEzm4QYWpd+E7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwnALOcO; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwnALOcO"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d41b209858so14056836d6.3
        for <iwd@lists.linux.dev>; Fri, 22 Nov 2024 07:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732288576; x=1732893376; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIAtRXiuA39aotQB1LBrlxaBLkR6j8CfBnDzIygHkq0=;
        b=IwnALOcOBU9j4ksfDO66JfJLpqCyNBD85Y7p4mCDjJrNG+L4QBPc6pN9A2N6C4AAnq
         5ndoi2DfgPf6M0LwoZArYCJn8HI6pkar1Agtj0hZJl7quEuIkP4hqabUOiVUkuBJvHfk
         B9NJepUdnw5GLqnn+0uIUObdnk8BDkPBYoCFQvo6pgEHPTfSlwmfnYDQdqudodcIEgq4
         Kwpx+HgigS6/nPBy7C+2DZjEg+s0OzG2h5zI742vBL2kr5g5GspIG2G1PDQ8yZhJAQJA
         F3YH2GE2x+d3GL4rkShHz/J+f73OBkRcoE5TRnlqyLlnoEx91uoc9rpF943wWPq/BmMG
         ZJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732288576; x=1732893376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIAtRXiuA39aotQB1LBrlxaBLkR6j8CfBnDzIygHkq0=;
        b=s5OwjtLehftNaonjCrMK8wUWvCAv4hAcFlkI9hWAZI+DphwM/F9IV3HfgYg7fzeseQ
         hO9i1VYz2YmyGqcRsmRkOGTN05Tk5ZNM0ugRa60BHD8Ol3k9bhsRVkWiWVrtEbJrXb51
         ZOfIW698v7j2KcbFS8JfWb5+JSf2cYB1Bu6BZ1cGiuyVr1pE9sSTOw5eH7fDmKcndXyb
         p5lViTiMTSqawVdh5TbeFddyhV48uZ7MFlur0cKdosjJGeuJrTxsyUrifr+DHMQbvNGT
         M3CCOCoPQrStaXhHmF0HcksaNa0hnJOEqnpySGPadflCf+V9yX6Ma4Fba43XPsEvaTXJ
         qzOQ==
X-Gm-Message-State: AOJu0YwKyAnBGRrA//8nwsEOI6A56DAJalBThg1t+N/+xZSOThKgebwV
	RJ1HlkmU2Qa8uR20DO3jqZdH7KNS1QBn9hSKI6obRljwr+PiYusZOrrv/Q==
X-Gm-Gg: ASbGncsoRdkQF4BOQjtRSCoabQyLnBYY2TPmwm061YuXszikgGYmZAFqDvaMDYwe2w/
	3Ab6tr1L02+s/knzU7bM+WUx37sI4AzyTcJUv+47ZyyU/U8FPownbMLmz19qIStXQGuC/vCMrDj
	7tRgCqu2dOYgxHFtwUMfEwrjSEIpn4r3vwgG7L7G8TD8/S/q2qveyZwPRbyA5SfjlSOd7WdsZWG
	ODMsgIStIrcbXQF3VZ76OM6naYPUDr1SdKhNVPDsCuK79x+uIr5iknRWva4
X-Google-Smtp-Source: AGHT+IGu4YOQuIuF8VujRnf7BxT/a4RGwFDbk7X1OvywLrt2BzrDc3dlkjKgjU7kfIDDL9Ku+aMxhQ==
X-Received: by 2002:ad4:5968:0:b0:6d4:18ce:1188 with SMTP id 6a1803df08f44-6d450adf014mr54050296d6.0.1732288575622;
        Fri, 22 Nov 2024 07:16:15 -0800 (PST)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a9a720sm10722706d6.50.2024.11.22.07.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 07:16:15 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 14/15] auto-t: add PMKSA tests
Date: Fri, 22 Nov 2024 07:15:50 -0800
Message-Id: <20241122151551.286355-15-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122151551.286355-1-prestwoj@gmail.com>
References: <20241122151551.286355-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds a test for just PMKSA and testing expiration as well as includes
some PMKSA tests in the SAE roaming test to ensure FT/reassociation
works.
---
 autotests/testPMKSA-SAE/connection_test.py | 114 +++++++++++++++++++++
 autotests/testPMKSA-SAE/hw.conf            |   7 ++
 autotests/testPMKSA-SAE/ssidSAE.conf       |  12 +++
 autotests/testSAE-roam/connection_test.py  |  60 ++++++++++-
 4 files changed, 192 insertions(+), 1 deletion(-)
 create mode 100644 autotests/testPMKSA-SAE/connection_test.py
 create mode 100644 autotests/testPMKSA-SAE/hw.conf
 create mode 100644 autotests/testPMKSA-SAE/ssidSAE.conf

diff --git a/autotests/testPMKSA-SAE/connection_test.py b/autotests/testPMKSA-SAE/connection_test.py
new file mode 100644
index 00000000..5bab3ff8
--- /dev/null
+++ b/autotests/testPMKSA-SAE/connection_test.py
@@ -0,0 +1,114 @@
+#!/usr/bin/python3
+
+import unittest
+import sys
+
+sys.path.append('../util')
+from iwd import IWD
+from iwd import PSKAgent
+from iwd import NetworkType
+from hostapd import HostapdCLI
+import testutil
+
+class Test(unittest.TestCase):
+
+    def validate_connection(self, wd, ssid, hostapd, expected_group):
+        psk_agent = PSKAgent("secret123")
+        wd.register_psk_agent(psk_agent)
+
+        devices = wd.list_devices(1)
+        self.assertIsNotNone(devices)
+        device = devices[0]
+
+        device.disconnect()
+
+        network = device.get_ordered_network(ssid, full_scan=True)
+
+        self.assertEqual(network.type, NetworkType.psk)
+
+        network.network_object.connect()
+
+        condition = 'obj.state == DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
+        wd.wait(2)
+
+        testutil.test_iface_operstate(intf=device.name)
+        testutil.test_ifaces_connected(if0=device.name, if1=hostapd.ifname)
+
+        # Initial connection PMKSA should not be used. So we should see the
+        # SAE group set.
+        sta_status = hostapd.sta_status(device.address)
+        self.assertEqual(int(sta_status["sae_group"]), expected_group)
+
+        device.disconnect()
+
+        condition = 'not obj.connected'
+        wd.wait_for_object_condition(network.network_object, condition)
+
+        wd.unregister_psk_agent(psk_agent)
+
+        network.network_object.connect(wait=False)
+
+        condition = 'obj.state == DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
+        wd.wait(2)
+
+        testutil.test_iface_operstate(intf=device.name)
+        testutil.test_ifaces_connected(if0=device.name, if1=hostapd.ifname)
+
+        # Having connected once prior we should have a PMKSA and SAE should not
+        # have been used.
+        sta_status = hostapd.sta_status(device.address)
+        self.assertNotIn("sae_group", sta_status.keys())
+
+        device.disconnect()
+
+        condition = 'not obj.connected'
+        wd.wait_for_object_condition(network.network_object, condition)
+
+        hostapd.pmksa_flush()
+
+        wd.wait(5)
+
+        network.network_object.connect()
+
+        device.wait_for_event("pmksa-invalid-pmkid")
+
+        condition = 'obj.state == DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
+        wd.wait(2)
+
+        testutil.test_iface_operstate(intf=device.name)
+        testutil.test_ifaces_connected(if0=device.name, if1=hostapd.ifname)
+
+        # Manually flushing the PMKSA from the AP then reconnecting we should
+        # have failed (INVALID_PMKID) then retried the same BSS with SAE, not
+        # PMKSA.
+        sta_status = hostapd.sta_status(device.address)
+        self.assertEqual(int(sta_status["sae_group"]), expected_group)
+
+    def test_pmksa_sae(self):
+        self.hostapd.wait_for_event("AP-ENABLED")
+        self.validate_connection(self.wd, "ssidSAE", self.hostapd, 19)
+
+    def setUp(self):
+        self.hostapd.default()
+        self.wd = IWD(True)
+
+    def tearDown(self):
+        self.wd.clear_storage()
+        self.wd = None
+
+    @classmethod
+    def setUpClass(cls):
+        cls.hostapd = HostapdCLI(config='ssidSAE.conf')
+
+    @classmethod
+    def tearDownClass(cls):
+        pass
+
+if __name__ == '__main__':
+    unittest.main(exit=True)
diff --git a/autotests/testPMKSA-SAE/hw.conf b/autotests/testPMKSA-SAE/hw.conf
new file mode 100644
index 00000000..72b161b8
--- /dev/null
+++ b/autotests/testPMKSA-SAE/hw.conf
@@ -0,0 +1,7 @@
+[SETUP]
+num_radios=2
+start_iwd=0
+hwsim_medium=yes
+
+[HOSTAPD]
+rad0=ssidSAE.conf
diff --git a/autotests/testPMKSA-SAE/ssidSAE.conf b/autotests/testPMKSA-SAE/ssidSAE.conf
new file mode 100644
index 00000000..377646b2
--- /dev/null
+++ b/autotests/testPMKSA-SAE/ssidSAE.conf
@@ -0,0 +1,12 @@
+hw_mode=g
+channel=1
+ssid=ssidSAE
+
+wpa=2
+wpa_key_mgmt=SAE
+wpa_pairwise=CCMP
+sae_password=secret123
+sae_groups=19
+ieee80211w=2
+sae_pwe=0
+rsn_preauth=1
diff --git a/autotests/testSAE-roam/connection_test.py b/autotests/testSAE-roam/connection_test.py
index ca7234a6..718bfd77 100644
--- a/autotests/testSAE-roam/connection_test.py
+++ b/autotests/testSAE-roam/connection_test.py
@@ -13,7 +13,7 @@ import testutil
 from config import ctx
 
 class Test(unittest.TestCase):
-    def validate_connection(self, wd, ft=True):
+    def validate_connection(self, wd, ft=True, check_used_pmksa=False):
         device = wd.list_devices(1)[0]
 
         # This won't guarantee all BSS's are found, but at least ensures that
@@ -37,6 +37,14 @@ class Test(unittest.TestCase):
         self.assertRaises(Exception, testutil.test_ifaces_connected,
                           (self.bss_hostapd[1].ifname, device.name, True, True))
 
+        # If PMKSA was used, hostapd should not include the sae_group key in
+        # its status for the station.
+        sta_status = self.bss_hostapd[0].sta_status(device.address)
+        if check_used_pmksa:
+            self.assertNotIn("sae_group", sta_status.keys())
+        else:
+            self.assertIn("sae_group", sta_status.keys())
+
         device.roam(self.bss_hostapd[1].bssid)
 
         # Check that iwd is on BSS 1 once out of roaming state and doesn't
@@ -88,6 +96,31 @@ class Test(unittest.TestCase):
 
         self.validate_connection(wd, True)
 
+    def test_ft_roam_pmksa(self):
+        wd = IWD(True)
+
+        self.bss_hostapd[0].set_value('wpa_key_mgmt', 'FT-SAE SAE')
+        self.bss_hostapd[0].reload()
+        self.bss_hostapd[0].wait_for_event("AP-ENABLED")
+        self.bss_hostapd[1].set_value('wpa_key_mgmt', 'FT-SAE SAE')
+        self.bss_hostapd[1].reload()
+        self.bss_hostapd[1].wait_for_event("AP-ENABLED")
+        self.bss_hostapd[2].set_value('wpa_key_mgmt', 'FT-PSK')
+        self.bss_hostapd[2].reload()
+        self.bss_hostapd[2].wait_for_event("AP-ENABLED")
+
+        self.validate_connection(wd, True)
+
+        device = wd.list_devices(1)[0]
+        device.disconnect()
+
+        for hapd in self.bss_hostapd:
+            hapd.deauthenticate(device.address)
+
+        wd.wait(5)
+
+        self.validate_connection(wd, True, check_used_pmksa=True)
+
     def test_reassociate_roam_success(self):
         wd = IWD(True)
 
@@ -103,6 +136,31 @@ class Test(unittest.TestCase):
 
         self.validate_connection(wd, False)
 
+    def test_reassociate_roam_pmksa(self):
+        wd = IWD(True)
+
+        self.bss_hostapd[0].set_value('wpa_key_mgmt', 'SAE')
+        self.bss_hostapd[0].reload()
+        self.bss_hostapd[0].wait_for_event("AP-ENABLED")
+        self.bss_hostapd[1].set_value('wpa_key_mgmt', 'SAE')
+        self.bss_hostapd[1].reload()
+        self.bss_hostapd[1].wait_for_event("AP-ENABLED")
+        self.bss_hostapd[2].set_value('wpa_key_mgmt', 'WPA-PSK')
+        self.bss_hostapd[2].reload()
+        self.bss_hostapd[2].wait_for_event("AP-ENABLED")
+
+        self.validate_connection(wd, False)
+
+        device = wd.list_devices(1)[0]
+        device.disconnect()
+
+        for hapd in self.bss_hostapd:
+            hapd.deauthenticate(device.address)
+
+        wd.wait(5)
+
+        self.validate_connection(wd, False, check_used_pmksa=True)
+
     def tearDown(self):
         os.system('ip link set "' + self.bss_hostapd[0].ifname + '" down')
         os.system('ip link set "' + self.bss_hostapd[1].ifname + '" down')
-- 
2.34.1

