Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CD73F23DB
	for <iwd@lists.linux.dev>; Tue, 14 Jul 2026 21:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784063595; cv=none; b=Z5NK6w9QoTOKg54HG7EzyUTzJ5jdDF0eyAHOwloA/gNCiWF2o1d86moYfAlAjh/o7pYNlV/tWPeLdrPXHfYAtAV92fJHnbz76IRhbsQ1zeGfTUpJ7tTt7CHIsJMeWSCYxuvon5A9G3eYcxbP2i074rUVATAXmY9CI79BsyyWHmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784063595; c=relaxed/simple;
	bh=+avDLYl02jg16QfUQ/9d9V4t4Lsh6glkImD0QCEf72w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ah4BdfO7Zp6p61l5k/rB2AXQBJ8jLovAywgKOapfL1UiYr/9cov4KFwdDo5r3Dd3cmK0SpVts//+9e4mYvGEX+juOLkjyqjtcOmcMVE3HLbtoAnN9K+FFO0fAFZGgWCWp3hE5Ep8aNdFohwe1ZFn7ZSfHKQODV74NXrn6dZ8GBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRzTESiN; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRzTESiN"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aeb98460c6so1469277e87.2
        for <iwd@lists.linux.dev>; Tue, 14 Jul 2026 14:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784063592; x=1784668392; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=recLJqc0K/zdffeYtklSqGwwX2m1C+5yHGwdbNT1TZw=;
        b=RRzTESiNDzyk1eOHOkdSHO60uPqHBRiGCuyNICZamo8OAocwmM8jbGyqeVzQ5uuCOh
         MvfdXQ6DL6pUOVwob4p6MrkrhPvUb0RIvqX7YpRXMYS7hn2pqpAYAlzidCPlQVsTyoLJ
         BRiXNX02K/AvpXEl/qxI+Cbft5PneZPkmtpkms1WdKIX6Msdw4pczIO88KFwvxttvEJQ
         ph1ah1ZHv3E/ftehoa8eH8XTQ9Dzqijoy+QkQ3Ivh2oiqlbw5U6qNKOsLsVvggn9aXbo
         xza1/AXKxaKOJ+9m8tPbgQnoXVe80xwlMLOL/3ruYr3qWiVQtM/Dx5hFxtG/POG1ixNM
         bL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784063592; x=1784668392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=recLJqc0K/zdffeYtklSqGwwX2m1C+5yHGwdbNT1TZw=;
        b=WCBOcpc6laGDn4z7+ju3SRUShyzEZkCsD9PPcr25czRxS2Sk5GTwb1ciKXRkiKGowB
         ngMGt2IbmMKvc23CXpXRmBghr+wUoC/BvZISpCWEveqsAsGZPtifyhPlJ7f/JF9M/M3Z
         3VNeMz0nhF96wTZiiUUyXrcytwN6SkOJIK/q2al+VWW930n9/zcPf1WnZkbl4lOoC+qX
         XOeeSZCKX/kQPA8POpL6DpoiTqEmZ51pV+ADI9ZWbbRQKdA+1VHIKBtyTp2aQZnF5m18
         rKgQYGxQrEFd3ji9Lf+9pZiE1KbG+gjZpYulgmDyy3ayOATOivGW4WSIUEVlsmIpYteF
         rVNg==
X-Gm-Message-State: AOJu0Yw6W6tVcxtcdP59zAkYz9i8wL9MoaaZMDPNZbzIcrNFhwJ4sywp
	St9PLHW02hp/6s/vTbf8tI8LEO0g/ly6dFrhaZneII0OFH34klIxh4HW6UpYut7BmYg=
X-Gm-Gg: AfdE7ckJuby1FbbwJM0GTS/SmyG3IIyjePfs/pQ0hi/5NBL0C/yqJV4SnL/fAqrLcQc
	qiEevjfKUWyEmLJrFfxr8v4d127bEbRw/fYqfHD1tDFhGLOypelwtFuuwTmWOV74xBDCNTF6q0G
	i9OU8qulEjwlu8yUca8KLeTvKw0ThoEIXRNZUR9ANL7WDSvG3kQcN468oDAmWQUqnq1eePaeaHJ
	SmwQLGbEFXjahf1A2Sb08hwrqRMmLYTTe971sGvZiJWZD80Bn9gDmpSgjWpc+Sy1BtOrGISgOLU
	0PgDkxjbgeG769NS4pN1UBmZcaZNDJ+XX1dDj1fdBIRV8y0A0OQ8JkYGDHr95X0EWavpBgSmK+j
	vtCHhUkrGzz3GwB00HNkCnAKKiTNyT3QofdlboFHSDSWgftCS/ajFxVqWUXT5GN3KMg6bqToIP4
	sbJimL/oNZKCf3mA1LJA==
X-Received: by 2002:ac2:5684:0:b0:5ae:ba8f:f9fa with SMTP id 2adb3069b0e04-5b02366465amr3486155e87.18.1784063591732;
        Tue, 14 Jul 2026 14:13:11 -0700 (PDT)
Received: from ultra-pc (s3.2dsites.ru. [188.187.190.12])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca4f919sm3770435e87.20.2026.07.14.14.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 14:13:11 -0700 (PDT)
From: Aleksman4o <aleksman4o@gmail.com>
To: iwd@lists.linux.dev
Cc: Aleks Man <aleksman4o@gmail.com>,
	prestwoj@gmail.com
Subject: [PATCH v2 3/3] auto-t: test BasicServiceSet RSN property
Date: Wed, 15 Jul 2026 00:12:26 +0300
Message-ID: <b6c265063dd8c5f74d63d902a170482ae1d9272b.1784062939.git.aleksman4o@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784062938.git.aleksman4o@gmail.com>
References: <c684823d-4be1-48ba-94ac-f2c01551f832@gmail.com> <cover.1784062938.git.aleksman4o@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aleks Man <aleksman4o@gmail.com>

Verify the exact D-Bus key management and cipher capabilities for
WPA2-PSK, SAE, and transition BSSes.
---
 .../basic_service_set_rsn_test.py             | 70 +++++++++++++++++++
 autotests/testBasicServiceSetRSN/hw.conf      |  9 +++
 autotests/testBasicServiceSetRSN/ssidSAE.conf | 11 +++
 .../ssidTransition.conf                       | 12 ++++
 .../testBasicServiceSetRSN/ssidWPA2.conf      |  8 +++
 5 files changed, 110 insertions(+)
 create mode 100644 autotests/testBasicServiceSetRSN/basic_service_set_rsn_test.py
 create mode 100644 autotests/testBasicServiceSetRSN/hw.conf
 create mode 100644 autotests/testBasicServiceSetRSN/ssidSAE.conf
 create mode 100644 autotests/testBasicServiceSetRSN/ssidTransition.conf
 create mode 100644 autotests/testBasicServiceSetRSN/ssidWPA2.conf

diff --git a/autotests/testBasicServiceSetRSN/basic_service_set_rsn_test.py b/autotests/testBasicServiceSetRSN/basic_service_set_rsn_test.py
new file mode 100644
index 00000000..20e0b62c
--- /dev/null
+++ b/autotests/testBasicServiceSetRSN/basic_service_set_rsn_test.py
@@ -0,0 +1,70 @@
+#! /usr/bin/python3
+
+import unittest
+import sys
+
+import dbus
+
+sys.path.append('../util')
+import iwd
+from iwd import IWD
+from hwsim import Hwsim
+from hostapd import HostapdCLI
+
+BSS_INTERFACE = 'net.connman.iwd.BasicServiceSet'
+
+
+class Test(unittest.TestCase):
+    def _get_rsn(self, device, ssid):
+        ordered_network = device.get_ordered_network(ssid, full_scan=True)
+        network = ordered_network.network_object
+        self.assertEqual(len(network.extended_service_set), 1)
+
+        path = network.extended_service_set[0]
+        proxy = self.wd._bus.get_object(iwd.IWD_SERVICE, path)
+        properties = dbus.Interface(proxy, iwd.DBUS_PROPERTIES)
+
+        return properties.GetAll(BSS_INTERFACE)['RSN']
+
+    def test_rsn(self):
+        device = self.wd.list_devices(1)[0]
+
+        rsn = self._get_rsn(device, 'ssidWPA2')
+        self.assertEqual(set(map(str, rsn['KeyMgmt'])), {'wpa-psk'})
+        self.assertEqual(set(map(str, rsn['Pairwise'])), {'ccmp'})
+        self.assertEqual(str(rsn['Group']), 'ccmp')
+
+        rsn = self._get_rsn(device, 'ssidSAE')
+        self.assertEqual(set(map(str, rsn['KeyMgmt'])), {'sae'})
+        self.assertEqual(set(map(str, rsn['Pairwise'])), {'ccmp'})
+        self.assertEqual(str(rsn['Group']), 'ccmp')
+
+        rsn = self._get_rsn(device, 'ssidTransition')
+        self.assertEqual(set(map(str, rsn['KeyMgmt'])),
+                         {'wpa-psk', 'sae'})
+        self.assertEqual(set(map(str, rsn['Pairwise'])), {'ccmp'})
+        self.assertEqual(str(rsn['Group']), 'ccmp')
+
+    def setUp(self):
+        self.wd = IWD(True)
+
+    def tearDown(self):
+        self.wd.stop()
+        self.wd = None
+
+    @classmethod
+    def setUpClass(cls):
+        Hwsim()
+        cls.hostapd = [
+            HostapdCLI(config='ssidWPA2.conf'),
+            HostapdCLI(config='ssidSAE.conf'),
+            HostapdCLI(config='ssidTransition.conf'),
+        ]
+
+    @classmethod
+    def tearDownClass(cls):
+        cls.hostapd = None
+
+
+if __name__ == '__main__':
+    unittest.main(exit=True)
diff --git a/autotests/testBasicServiceSetRSN/hw.conf b/autotests/testBasicServiceSetRSN/hw.conf
new file mode 100644
index 00000000..a43062d9
--- /dev/null
+++ b/autotests/testBasicServiceSetRSN/hw.conf
@@ -0,0 +1,9 @@
+[SETUP]
+num_radios=4
+hwsim_medium=yes
+start_iwd=no
+
+[HOSTAPD]
+rad0=ssidWPA2.conf
+rad1=ssidSAE.conf
+rad2=ssidTransition.conf
diff --git a/autotests/testBasicServiceSetRSN/ssidSAE.conf b/autotests/testBasicServiceSetRSN/ssidSAE.conf
new file mode 100644
index 00000000..2ec9ae61
--- /dev/null
+++ b/autotests/testBasicServiceSetRSN/ssidSAE.conf
@@ -0,0 +1,11 @@
+hw_mode=g
+channel=2
+ssid=ssidSAE
+
+wpa=2
+wpa_key_mgmt=SAE
+wpa_pairwise=CCMP
+sae_password=secret123
+sae_groups=19
+ieee80211w=2
+sae_pwe=0
diff --git a/autotests/testBasicServiceSetRSN/ssidTransition.conf b/autotests/testBasicServiceSetRSN/ssidTransition.conf
new file mode 100644
index 00000000..00170772
--- /dev/null
+++ b/autotests/testBasicServiceSetRSN/ssidTransition.conf
@@ -0,0 +1,12 @@
+hw_mode=g
+channel=3
+ssid=ssidTransition
+
+wpa=2
+wpa_key_mgmt=WPA-PSK SAE
+wpa_pairwise=CCMP
+wpa_passphrase=secret123
+sae_password=secret123
+sae_groups=19
+ieee80211w=1
+sae_pwe=0
diff --git a/autotests/testBasicServiceSetRSN/ssidWPA2.conf b/autotests/testBasicServiceSetRSN/ssidWPA2.conf
new file mode 100644
index 00000000..d706142b
--- /dev/null
+++ b/autotests/testBasicServiceSetRSN/ssidWPA2.conf
@@ -0,0 +1,8 @@
+hw_mode=g
+channel=1
+ssid=ssidWPA2
+
+wpa=2
+wpa_key_mgmt=WPA-PSK
+wpa_pairwise=CCMP
+wpa_passphrase=secret123
-- 
2.55.0

