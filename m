Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E4E3D387
	for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 18:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058875; cv=none; b=kV1gq0WdBu1BjlBgCZxFCKtKYbYgxYm37u9CklBy1mLlwld8uQlGL+Ly0B7XjkJVvTEsvWOYM/ATPryttpii8kzZFzUV5wmegb7WW7IrSOwdMn7MeoSneTTsYMZdjmQsXJjU4C+g3kXPmPgV7VImelFf4MJdzCkSGtFnXHpcnu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058875; c=relaxed/simple;
	bh=C2oBGYtyMPypzP4YY1YfmK0cdVDHw3CoOx8CnrtSnuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qK1st3nkdioSzrh0kzzPhVwf5yegaer5EhqO2WkJGeIiAhXavDx+ty2B0s9SNBv07+16ok2i8KDkv2D/MIbBtNqdDTcgDIApOl2FIim6Qvax4a01E67MBfnGDAswYNZ2YlnGcurrkwH7HMVfK8ia+qnlgt57Go0AW0IQc/+lQuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndG3tnsu; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndG3tnsu"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42e64e45214so21991581cf.1
        for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 10:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709058872; x=1709663672; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViijEWyRzRx0rjKZYc/CiH+U1ZvPILB8ubaiG80GX2g=;
        b=ndG3tnsuJ+8+m2mRIAqkCUoWSaOKpUaAwnZ1UrrtxKfSmlwdkvvr0pC0cR0Sz6Rm0Y
         c8tQNDsJG/uHS159fFqwed8Zv0F3AQmdOw8G//9U/lXG0KplVI2/90X1/PX+iGy1iYkj
         wMUvUi6EmeWmYDwP5DUJKimbwJuPmehs4AnWth5SxSS+taJMlDeiFG56WhiMKn/ayyuu
         PM8nvhBfTZhZN+h9w9xTJBU3fNPeWMiPWKAUXOG9Q77WiBlCThbuHrtHbp55+swngBGW
         OkJUiR6Y/etI7spXZIHgPBx3vKS6tvYjRyLRMHp909aVINkqO0TzNvdMSnABcRS0MsHA
         wHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709058872; x=1709663672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ViijEWyRzRx0rjKZYc/CiH+U1ZvPILB8ubaiG80GX2g=;
        b=W6lXJzAxrj32BgD2Qr2LYq5QZ5h9hehUJNkooCgQte6eihvEbsHXSywGADv4k4BIfV
         iRNR38lVm2/57o9iR9/AOGde72B2hhcnNMbbb7RTTLlu5itkvQ80YfU2jbsSqvWp1SWk
         1pa0EV8k7tF7FE82Bb7K/NrnIirSJxNunM4jiAYKDv1cvsbk+oG/sNWEqwDF8eoOSjSi
         sc5NTuetcOJxYlx7Rh1Zc5B5fMM/ov40dGmxtOItUrSw4ap1Bwuwy4XpckRosBZtUXfk
         y2tP2PoBVm22ZpSGxdl4YFp7zXl0mrHp/BWnV7a3UOTSz86sGEbRXFY0u/A2txYUtzUZ
         GbTA==
X-Gm-Message-State: AOJu0Yxp+POTOcMd5o6KnJC4D+Lucaut0ayql6/RIpIUjQx7BB1qMyET
	4tGKT0ew1XouhqWcgKC+IthXBQ17X3b0YdWHcyb9LcAl3lvwOHUccfuyj/wh
X-Google-Smtp-Source: AGHT+IGTh0m97EHtRyBcx202UhyUHRVzf4gpyPMDQFDKrWotl92K9F/pXCNYF+Ec/JXCbEAgTT1Y4A==
X-Received: by 2002:a05:622a:28f:b0:42e:8f31:9172 with SMTP id z15-20020a05622a028f00b0042e8f319172mr5114133qtw.45.1709058872054;
        Tue, 27 Feb 2024 10:34:32 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id jy2-20020a05622a818200b0042e3468a98csm3819617qtb.4.2024.02.27.10.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 10:34:31 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 09/11] auto-t: refactor/fix testSAE
Date: Tue, 27 Feb 2024 10:34:03 -0800
Message-Id: <20240227183405.257206-9-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227183405.257206-1-prestwoj@gmail.com>
References: <20240227183405.257206-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SAE test made some assumptions on certain conditions due to
there being no way of checking if those conditions were met
Mainly the use of H2E/hunt-and-peck.

We assumed that when we told hostapd to use H2E or hunt/peck it
would but in reality it was not. Hostapd is apparently not very
good at swapping between the two with a simple "reload" command.
Once H2E is enabled it appears that it cannot be undone.
Similarly the vendor elements seem to carry over from test to
test, and sometimes not which causes unintended behavior.

To fix this create separate APs for the specific scenario being
tested:
 - Hunt and peck
 - H2E
 - Special vendor_element simulating buggy APs

Another issue found was that if password identifies are used
hostapd automatically chooses H2E which was not intented, at
least based on the test names (in reality it wasn't causing any
problems).

The tests have also been improved to use hostapds "sta_status"
command which contains the group number used when authenticating,
so now that at least can be verified.
---
 autotests/testSAE/autoconnect_test.py         | 32 +++++++-------
 autotests/testSAE/connection_test.py          | 42 +++++++++----------
 autotests/testSAE/hw.conf                     |  3 +-
 .../ssidSAE-H2E.psk.default}                  |  0
 .../testSAE/profiles/ssidSAE.psk.default      |  2 +
 .../{ => profiles}/ssidSAE.psk.identifier     |  0
 autotests/testSAE/ssidSAE-H2E.conf            | 12 ++++++
 autotests/testSAE/ssidSAE.conf                |  1 -
 8 files changed, 52 insertions(+), 40 deletions(-)
 rename autotests/testSAE/{ssidSAE.psk.default => profiles/ssidSAE-H2E.psk.default} (100%)
 create mode 100644 autotests/testSAE/profiles/ssidSAE.psk.default
 rename autotests/testSAE/{ => profiles}/ssidSAE.psk.identifier (100%)
 create mode 100644 autotests/testSAE/ssidSAE-H2E.conf

diff --git a/autotests/testSAE/autoconnect_test.py b/autotests/testSAE/autoconnect_test.py
index 4ce3b845..605de14d 100644
--- a/autotests/testSAE/autoconnect_test.py
+++ b/autotests/testSAE/autoconnect_test.py
@@ -12,8 +12,7 @@ from hostapd import HostapdCLI
 
 class Test(unittest.TestCase):
 
-    def validate_connection(self, wd):
-
+    def validate_connection(self, wd, ssid):
         devices = wd.list_devices(1)
         self.assertIsNotNone(devices)
         device = devices[0]
@@ -25,7 +24,7 @@ class Test(unittest.TestCase):
         condition = 'obj.connected_network is not None'
         wd.wait_for_object_condition(device, condition)
 
-        ordered_network = device.get_ordered_network('ssidSAE')
+        ordered_network = device.get_ordered_network(ssid)
 
         self.assertTrue(ordered_network.network_object.connected)
 
@@ -35,29 +34,27 @@ class Test(unittest.TestCase):
         wd.wait_for_object_condition(ordered_network.network_object, condition)
 
     def test_SAE(self):
-        IWD.copy_to_storage("ssidSAE.psk.default", name="ssidSAE.psk")
+        IWD.copy_to_storage("profiles/ssidSAE.psk.default", name="ssidSAE.psk")
         self.hostapd.wait_for_event("AP-ENABLED")
 
         wd = IWD(True)
-        self.validate_connection(wd)
+        self.validate_connection(wd, "ssidSAE")
 
     def test_SAE_H2E(self):
-        IWD.copy_to_storage("ssidSAE.psk.default", name="ssidSAE.psk")
-        self.hostapd.set_value('sae_pwe', '1')
-        self.hostapd.set_value('sae_groups', '20')
-        self.hostapd.reload()
-        self.hostapd.wait_for_event("AP-ENABLED")
+        IWD.copy_to_storage("profiles/ssidSAE.psk.default", name="ssidSAE-H2E.psk")
+        self.hostapd_h2e.set_value('sae_groups', '20')
+        self.hostapd_h2e.reload()
+        self.hostapd_h2e.wait_for_event("AP-ENABLED")
         wd = IWD(True)
-        self.validate_connection(wd)
+        self.validate_connection(wd, "ssidSAE-H2E")
 
     def test_SAE_H2E_password_identifier(self):
-        IWD.copy_to_storage("ssidSAE.psk.identifier", name="ssidSAE.psk")
-        self.hostapd.set_value('sae_pwe', '1')
-        self.hostapd.set_value('sae_groups', '20')
-        self.hostapd.reload()
-        self.hostapd.wait_for_event("AP-ENABLED")
+        IWD.copy_to_storage("profiles/ssidSAE.psk.identifier", name="ssidSAE-H2E.psk")
+        self.hostapd_h2e.set_value('sae_groups', '20')
+        self.hostapd_h2e.reload()
+        self.hostapd_h2e.wait_for_event("AP-ENABLED")
         wd = IWD(True)
-        self.validate_connection(wd)
+        self.validate_connection(wd, "ssidSAE-H2E")
 
     def setUp(self):
         self.hostapd.default()
@@ -68,6 +65,7 @@ class Test(unittest.TestCase):
     @classmethod
     def setUpClass(cls):
         cls.hostapd = HostapdCLI(config='ssidSAE.conf')
+        cls.hostapd_h2e = HostapdCLI(config='ssidSAE-H2E.conf')
 
 if __name__ == '__main__':
     unittest.main(exit=True)
diff --git a/autotests/testSAE/connection_test.py b/autotests/testSAE/connection_test.py
index ecb464e2..f7776385 100644
--- a/autotests/testSAE/connection_test.py
+++ b/autotests/testSAE/connection_test.py
@@ -13,7 +13,7 @@ import testutil
 
 class Test(unittest.TestCase):
 
-    def validate_connection(self, wd):
+    def validate_connection(self, wd, ssid, hostapd, expected_group):
         psk_agent = PSKAgent("secret123")
         wd.register_psk_agent(psk_agent)
 
@@ -23,11 +23,11 @@ class Test(unittest.TestCase):
 
         device.disconnect()
 
-        network = device.get_ordered_network('ssidSAE', full_scan=True)
+        network = device.get_ordered_network(ssid, full_scan=True)
 
         self.assertEqual(network.type, NetworkType.psk)
 
-        network.network_object.connect()
+        network.network_object.connect(wait=False)
 
         condition = 'obj.state == DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
@@ -35,7 +35,11 @@ class Test(unittest.TestCase):
         wd.wait(2)
 
         testutil.test_iface_operstate(intf=device.name)
-        testutil.test_ifaces_connected(if0=device.name, if1=self.hostapd.ifname)
+        testutil.test_ifaces_connected(if0=device.name, if1=hostapd.ifname)
+
+        sta_status = hostapd.sta_status(device.address)
+
+        self.assertEqual(int(sta_status["sae_group"]), expected_group)
 
         device.disconnect()
 
@@ -46,37 +50,31 @@ class Test(unittest.TestCase):
 
     def test_SAE(self):
         self.hostapd.wait_for_event("AP-ENABLED")
-        self.validate_connection(self.wd)
+        self.validate_connection(self.wd, "ssidSAE", self.hostapd, 19)
 
     def test_SAE_force_group_19(self):
         # Vendor data from APs which require group 19 be used first
-        # TODO: (for all tests) verify the expected group was used
-        self.hostapd.set_value('vendor_elements', 'dd0cf4f5e8050500000000000000')
         self.hostapd.reload()
         self.hostapd.wait_for_event("AP-ENABLED")
-        self.validate_connection(self.wd)
+        self.validate_connection(self.wd, "ssidSAE-default-group", self.hostapd_defgroup, 19)
 
     def test_SAE_Group20(self):
         self.hostapd.set_value('sae_groups', '20')
-        self.hostapd.set_value('vendor_elements', '')
         self.hostapd.reload()
         self.hostapd.wait_for_event("AP-ENABLED")
-        self.validate_connection(self.wd)
+        self.validate_connection(self.wd, "ssidSAE", self.hostapd, 20)
 
     def test_SAE_H2E(self):
-        self.hostapd.set_value('sae_pwe', '1')
-        self.hostapd.set_value('vendor_elements', '')
-        self.hostapd.reload()
-        self.hostapd.wait_for_event("AP-ENABLED")
-        self.validate_connection(self.wd)
+        self.hostapd_h2e.set_value('sae_groups', '19')
+        self.hostapd_h2e.reload()
+        self.hostapd_h2e.wait_for_event("AP-ENABLED")
+        self.validate_connection(self.wd, "ssidSAE-H2E", self.hostapd_h2e, 19)
 
     def test_SAE_H2E_Group20(self):
-        self.hostapd.set_value('sae_pwe', '1')
-        self.hostapd.set_value('sae_groups', '20')
-        self.hostapd.set_value('vendor_elements', '')
-        self.hostapd.reload()
-        self.hostapd.wait_for_event("AP-ENABLED")
-        self.validate_connection(self.wd)
+        self.hostapd_h2e.set_value('sae_groups', '20')
+        self.hostapd_h2e.reload()
+        self.hostapd_h2e.wait_for_event("AP-ENABLED")
+        self.validate_connection(self.wd, "ssidSAE-H2E", self.hostapd_h2e, 20)
 
     def setUp(self):
         self.hostapd.default()
@@ -89,6 +87,8 @@ class Test(unittest.TestCase):
     @classmethod
     def setUpClass(cls):
         cls.hostapd = HostapdCLI(config='ssidSAE.conf')
+        cls.hostapd_h2e = HostapdCLI(config='ssidSAE-H2E.conf')
+        cls.hostapd_defgroup = HostapdCLI(config='ssidSAE-default-group.conf')
 
     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testSAE/hw.conf b/autotests/testSAE/hw.conf
index 72b161b8..cc0836b7 100644
--- a/autotests/testSAE/hw.conf
+++ b/autotests/testSAE/hw.conf
@@ -1,7 +1,8 @@
 [SETUP]
-num_radios=2
+num_radios=3
 start_iwd=0
 hwsim_medium=yes
 
 [HOSTAPD]
 rad0=ssidSAE.conf
+rad1=ssidSAE-H2E.conf
diff --git a/autotests/testSAE/ssidSAE.psk.default b/autotests/testSAE/profiles/ssidSAE-H2E.psk.default
similarity index 100%
rename from autotests/testSAE/ssidSAE.psk.default
rename to autotests/testSAE/profiles/ssidSAE-H2E.psk.default
diff --git a/autotests/testSAE/profiles/ssidSAE.psk.default b/autotests/testSAE/profiles/ssidSAE.psk.default
new file mode 100644
index 00000000..abafdb66
--- /dev/null
+++ b/autotests/testSAE/profiles/ssidSAE.psk.default
@@ -0,0 +1,2 @@
+[Security]
+Passphrase=secret123
diff --git a/autotests/testSAE/ssidSAE.psk.identifier b/autotests/testSAE/profiles/ssidSAE.psk.identifier
similarity index 100%
rename from autotests/testSAE/ssidSAE.psk.identifier
rename to autotests/testSAE/profiles/ssidSAE.psk.identifier
diff --git a/autotests/testSAE/ssidSAE-H2E.conf b/autotests/testSAE/ssidSAE-H2E.conf
new file mode 100644
index 00000000..ea963135
--- /dev/null
+++ b/autotests/testSAE/ssidSAE-H2E.conf
@@ -0,0 +1,12 @@
+hw_mode=g
+channel=1
+ssid=ssidSAE-H2E
+
+wpa=2
+wpa_key_mgmt=SAE
+wpa_pairwise=CCMP
+sae_password=secret123
+sae_password=withidentifier|id=myidentifier
+sae_groups=19
+ieee80211w=2
+sae_pwe=1
diff --git a/autotests/testSAE/ssidSAE.conf b/autotests/testSAE/ssidSAE.conf
index f5ce537d..4ec254aa 100644
--- a/autotests/testSAE/ssidSAE.conf
+++ b/autotests/testSAE/ssidSAE.conf
@@ -6,7 +6,6 @@ wpa=2
 wpa_key_mgmt=SAE
 wpa_pairwise=CCMP
 sae_password=secret123
-sae_password=withidentifier|id=myidentifier
 sae_groups=19
 ieee80211w=2
 sae_pwe=0
-- 
2.34.1

