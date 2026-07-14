Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA053438BD
	for <iwd@lists.linux.dev>; Tue, 14 Jul 2026 22:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784069460; cv=none; b=uplXV6p2FIalqMeqqRNGWWHX14LijH7/zzAaOP5+K267e6mDiI8hg2bSjdbQdv6p6/mdUfjXovf+JGN+C9gTFGapPBuZmSvnqJSRwHhDeriwNFyJ6M8loKMI0Wfxxdy7aovdQBchsiVWpnMiU6ted1Phf+NRVVwEf8WK43GQ55Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784069460; c=relaxed/simple;
	bh=m3bviwwPGBWEdJx14W8bJJ0tlRze8clrOo7bc+beIrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWaE3Umh5CUYqZcyFeUbGzjGGtyED+fEKCwe8UfSn0vQ51sFT/ci262Wh4BZfg7jCegK6ACHdhGPkhKI76DSQlti8tAVeoBBisgVY0tk2OzlM+lLZuUYZUgdh3hQFtJs7sC2CUxzssQ0EBdJu/T/YnrSlCRv/Z+/k7SWB8+tU0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qXooXtmk; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qXooXtmk"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aebc8cb5bcso3326402e87.2
        for <iwd@lists.linux.dev>; Tue, 14 Jul 2026 15:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784069457; x=1784674257; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e6O0usYfx74OBPETPs/Da8oXCUVp6EEkzuKls32TT6I=;
        b=qXooXtmkjvyhjHYBCEnRIwvZbfVDR+XBiD+Ak1IymiKhegw8dpH6eSdgX4SPpWmoFL
         /0UYCdF5g6KcbOMOs04UfWQWmtOWJgdVkY1V3AJJXa/nSs/AjXcE2W28BV0S+tGsVv+Q
         GpUaBc07pL0nRQ+ZcA3S1KV3rxIqcoeO4Z+s1Qj6Su8vdIhBsMYZvdm1l2Cu2E3G8lRB
         zm4p2BlJzk/SQ7qLWEYzsHoGrfGUuQtsNRjpja4n9N8dw5/W5csj4JjwRdt43iuDOtEm
         OxUTeZ5K3O6M7hJqcNXbzonSNCyWlXqWLCCE3e2Bt0zqoGaiihRW1vuLt9Cpno43RLjV
         b9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784069457; x=1784674257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e6O0usYfx74OBPETPs/Da8oXCUVp6EEkzuKls32TT6I=;
        b=ikVDEDlsl9k9I6a9X4dBd2KBKfMvQNb9ImMybH4OZnYlnTRqDyL3YciNWTeRKb2BeM
         1K8MhdmYFDOZpHi9OcJ7lD/w3IfoQE4BEgDvhm9QNkKVuFwBp3XbqMWAawwXTlYZa6P1
         moMP0e+yioBcnJr3fwGydtv7qQWzC6oWBaPsfsUvXmUpP7SE0h/FHi3tdqPk4tn0IW0G
         56zar7ptEpFjyaL13dq+CNwA+OmKhsKHoW22f3EgSavNzLf++oxCx4pxjHAfb6uFFG37
         IWWwtQIaU/XCvKs1y+h9b7zSkcMEdFjiURd0H/US7n1FXCrKpkmgdnfd077BmFhq2GFj
         DLnQ==
X-Gm-Message-State: AOJu0YwnKD67QM9HPoVtVzTDVMrvixQC8S0/lfW3HkXLmSUgmNev+sUS
	PN9jCL+mhlYMyMPAfzwgY+vmkV2yiCq1rOyHcrPLnZtFW42V7iMRqlNf9UBMHbSeawM=
X-Gm-Gg: AfdE7cnHH8Kxa9ZPMJIGx1JQFqQ5/hRe2cc7nnTa0OdacXNgFGzFEt2iGYB2XVzyVEV
	7TfkPNFpfw/g6SxZzQll+KnL/2HPIgjh+WbgOzIcmCX9pPCw6QcojyVbIJ7nhU4OOHsAsr/pKDx
	4pu5KlCj8ITo4Xssi48/N/dyZXRLd7a7dMKAm//TTOKfYqt5mxttt7DvQSNNvOBISpf4+ldyosg
	IQoGJzBiEZXDFa2NJmHjuYwNkJfMtQA/zy/nkCcbX0jomNF/3sQ1aTBhhz/skp9zeqByWcfCm+6
	YFG22vgFfpKSnxHePLrR8X2aUjaceOU7/hmlwKw7p0MfJQTZ7XZCZ+4e9lyUN/1HwysA8HO+ade
	rryvh1CJkCgvQcT28h8ojIiTwT4o+GZl+0OtZARpt1aAQtiSCmLd8D61gFgPD0z6VXuE58V+yA5
	OBQbRvkhPi26kmSzFSh1A=
X-Received: by 2002:a05:6512:66c6:10b0:5b0:bc3:dbf3 with SMTP id 2adb3069b0e04-5b15d79dabbmr47349e87.30.1784069456810;
        Tue, 14 Jul 2026 15:50:56 -0700 (PDT)
Received: from ultra-pc (s3.2dsites.ru. [188.187.190.12])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca9ddf0sm3791060e87.50.2026.07.14.15.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 15:50:55 -0700 (PDT)
From: Aleksman4o <aleksman4o@gmail.com>
To: iwd@lists.linux.dev
Cc: Aleks Man <aleksman4o@gmail.com>,
	prestwoj@gmail.com
Subject: [PATCH v3 3/3] auto-t: test BasicServiceSet RSN property
Date: Wed, 15 Jul 2026 01:48:49 +0300
Message-ID: <04c22195f4a7ddf482ce9b44abd665ea57523dcf.1784069194.git.aleksman4o@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784069194.git.aleksman4o@gmail.com>
References: <cover.1784062938.git.aleksman4o@gmail.com> <cover.1784069194.git.aleksman4o@gmail.com>
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
 .../testBasicServiceSetRSN/bss_rsn_test.py    | 70 +++++++++++++++++++
 autotests/testBasicServiceSetRSN/hw.conf      |  9 +++
 autotests/testBasicServiceSetRSN/ssidSAE.conf | 11 +++
 .../ssidTransition.conf                       | 12 ++++
 .../testBasicServiceSetRSN/ssidWPA2.conf      |  8 +++
 5 files changed, 110 insertions(+)
 create mode 100644 autotests/testBasicServiceSetRSN/bss_rsn_test.py
 create mode 100644 autotests/testBasicServiceSetRSN/hw.conf
 create mode 100644 autotests/testBasicServiceSetRSN/ssidSAE.conf
 create mode 100644 autotests/testBasicServiceSetRSN/ssidTransition.conf
 create mode 100644 autotests/testBasicServiceSetRSN/ssidWPA2.conf

diff --git a/autotests/testBasicServiceSetRSN/bss_rsn_test.py b/autotests/testBasicServiceSetRSN/bss_rsn_test.py
new file mode 100644
index 00000000..20e0b62c
--- /dev/null
+++ b/autotests/testBasicServiceSetRSN/bss_rsn_test.py
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

