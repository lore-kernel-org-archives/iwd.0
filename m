Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C84B1741D2
	for <iwd@lists.linux.dev>; Fri, 16 Aug 2024 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723812746; cv=none; b=oGvoOIB1HJwEwBpbUCje1e/4oP9zxaAZ6PaEYzNp0sHSqcJx1x+KzM4U1Yqv/SnMTt4dVT77AkjIH0cYyibbSq9OqVOSc3+QTesBmZYMIhf86ylfrNf0bD11V5MEEDtGGnFpeHCdUJfNs/cSHPbjl02M28qX6g8KxIllce91eIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723812746; c=relaxed/simple;
	bh=8eNGP5xOxlNPfHibAF8pSEIVZ1lGWsy8Ru/702n2+jM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qcr9/N5ko0Jn99aXzFujZYlU4yfCeXiSZ/NOA5cYPqP+a7Q9j3Hn0FTkIoyVANQ+adv5TiMEAMMc61xCv/OVpSLvBM81gQ3W7+3qwB5VKgv4X0shFcsrSD+5aCAsLe16IDfYgI3k0KSfTvTfpoy7WXnvb9e2X33kAdO3mm0VMrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrYu13lK; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrYu13lK"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-70940c9657dso956232a34.1
        for <iwd@lists.linux.dev>; Fri, 16 Aug 2024 05:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723812744; x=1724417544; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmKr4wShoxfc/Ar3yqI0w/yD7Vp7QvgQQW1F8edHasQ=;
        b=LrYu13lKBGLlMobW/3LJfA78ZNPSwuED25E1+scc4OLazNxlvW0YlfgszuWWDvdXa0
         qfDd8xqsVH6RVzt39PlPLkMpLR0s435+GLR981IBIhEDBoj8nY9XI0yQquHBDCctwTcm
         jz2AkwUDTvuBdvpb+n/CwzY5UbF6ITrIXMCYTiYqQMAvWhHbnm1hsC+w/Z0XSAUlXGPh
         CfNkxUlmqbSX3TzElUV4ox/dTx1bZM2iixCnuvJ2xU1TImpmXySmu7hErmmWHgH+2vy/
         qn7Kp0cOlAIVB019MWQnYAF03iXYqEkLhQpS/YjMaxqJ9NjtUc9apownMlR9ZVQWs5EV
         /DbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723812744; x=1724417544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmKr4wShoxfc/Ar3yqI0w/yD7Vp7QvgQQW1F8edHasQ=;
        b=mYXolwFUINvHUXPACmYpXacV1sGH9Pro4quNvyo3UFWD7jbhq/EMkY6nhOxqur0A+0
         TbY6vWuPY2QNWoGhF/8xvH+WUz5EEjIFDu291ltg1eLSFSUJXec3GXlZM/TjGSNjO9p1
         ecnFPz7Pu52isGHuhvIu9QgzeH/jVDlX+oe6T5H5S3a/lSogCzbPPwhXzVz6WLTOAq8/
         plxwFpWnt/+ayna1lPHvfLtHZDeDkxPsieJzHNUknGUxIjGs8BiiuGJK0jygvvTsbhiL
         /NvfnYKSA5HjBU0wAcxLLioX8VimXjfKJdJ4ESNdh4+kp4ImQSMQfWTofHhs8ueHmnoM
         sTyQ==
X-Gm-Message-State: AOJu0YyNSr0GxLenYEjTpJaUYPeAd6Ni7ijIP6VHgVtmPRsele/tzd/Y
	vSeWLvWJarfZxQHtRAjOk+zRRGkJAYI1G9lg1dv98qFw9OzlzZKFua8ekA==
X-Google-Smtp-Source: AGHT+IEwuJ7jwdzHunkvLvu3/9A7Y1vBi6Bi/dWATVytAvvu5tk0SOlg1aGrl04ldI5YDfR56PzU0g==
X-Received: by 2002:a05:6830:6208:b0:709:4552:1f70 with SMTP id 46e09a7af769-70cac89c417mr3295328a34.24.1723812744189;
        Fri, 16 Aug 2024 05:52:24 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369ff54ffsm15921931cf.36.2024.08.16.05.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 05:52:23 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/6] auto-t: Add test for BasicServiceSets
Date: Fri, 16 Aug 2024 05:52:14 -0700
Message-Id: <20240816125214.1162415-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816125214.1162415-1-prestwoj@gmail.com>
References: <20240816125214.1162415-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 .../basic_service_set_test.py                 | 100 ++++++++++++++++++
 autotests/testBasicServiceSet/hw.conf         |   7 ++
 autotests/testBasicServiceSet/ssidTKIP-1.conf |   7 ++
 autotests/testBasicServiceSet/ssidTKIP-2.conf |   7 ++
 autotests/testBasicServiceSet/ssidTKIP.psk    |   5 +
 5 files changed, 126 insertions(+)
 create mode 100644 autotests/testBasicServiceSet/basic_service_set_test.py
 create mode 100644 autotests/testBasicServiceSet/hw.conf
 create mode 100644 autotests/testBasicServiceSet/ssidTKIP-1.conf
 create mode 100644 autotests/testBasicServiceSet/ssidTKIP-2.conf
 create mode 100644 autotests/testBasicServiceSet/ssidTKIP.psk

diff --git a/autotests/testBasicServiceSet/basic_service_set_test.py b/autotests/testBasicServiceSet/basic_service_set_test.py
new file mode 100644
index 00000000..c99f1901
--- /dev/null
+++ b/autotests/testBasicServiceSet/basic_service_set_test.py
@@ -0,0 +1,100 @@
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
+from hwsim import Hwsim
+from hostapd import HostapdCLI
+import testutil
+
+class Test(unittest.TestCase):
+    def test_bss_unregister(self):
+        device = self.wd.list_devices(1)[0]
+
+        ordered_network = device.get_ordered_network('ssidTKIP', full_scan=True)
+        network = ordered_network.network_object
+
+        self.assertEqual(len(network.extended_service_set), 2)
+
+        ends = [parts.split('/')[-1] for parts in network.extended_service_set]
+
+        self.assertIn(self.bss_hostapd[0].bssid.replace(':', ''), ends)
+        self.assertIn(self.bss_hostapd[1].bssid.replace(':', ''), ends)
+
+        self.rule_bss1.enabled = True
+
+        # Even with flushing, the kernel still seems to return the scan
+        # results
+        self.wd.wait(40)
+        ordered_network = device.get_ordered_network('ssidTKIP', full_scan=True)
+        network = ordered_network.network_object
+
+        ends = [parts.split('/')[-1] for parts in network.extended_service_set]
+
+        self.assertIn(self.bss_hostapd[0].bssid.replace(':', ''), ends)
+        self.assertNotIn(self.bss_hostapd[1].bssid.replace(':', ''), ends)
+
+        self.rule_bss0.enabled = True
+
+        self.wd.wait(40)
+        ordered_networks = device.get_ordered_networks('ssidTKIP', full_scan=True)
+        self.assertIsNone(ordered_networks)
+
+        self.rule_bss0.enabled = False
+
+        ordered_networks = device.get_ordered_networks('ssidTKIP', full_scan=True)
+        ends = [parts.split('/')[-1] for parts in network.extended_service_set]
+
+        self.assertIn(self.bss_hostapd[0].bssid.replace(':', ''), ends)
+        self.assertNotIn(self.bss_hostapd[1].bssid.replace(':', ''), ends)
+
+    def tearDown(self):
+        self.rule_bss0.enabled = False
+        self.rule_bss1.enabled = False
+
+        self.wd.stop()
+        self.wd.wait(10)
+        self.wd = None
+
+    def setUp(self):
+        self.wd = IWD(True)
+
+    @classmethod
+    def setUpClass(cls):
+        hwsim = Hwsim()
+
+        IWD.copy_to_storage('ssidTKIP.psk')
+
+        cls.bss_hostapd = [ HostapdCLI(config='ssidTKIP-1.conf'),
+                            HostapdCLI(config='ssidTKIP-2.conf') ]
+
+
+        rad0 = hwsim.get_radio('rad0')
+        rad1 = hwsim.get_radio('rad1')
+
+        cls.rule_bss0 = hwsim.rules.create()
+        cls.rule_bss0.source = rad0.addresses[0]
+        cls.rule_bss0.bidirectional = True
+        cls.rule_bss0.drop = True
+
+        cls.rule_bss1 = hwsim.rules.create()
+        cls.rule_bss1.source = rad1.addresses[0]
+        cls.rule_bss1.bidirectional = True
+        cls.rule_bss1.drop = True
+
+
+
+    @classmethod
+    def tearDownClass(cls):
+        IWD.clear_storage()
+        cls.bss_hostapd = None
+        cls.rule_bss0.remove()
+        cls.rule_bss1.remove()
+
+if __name__ == '__main__':
+    unittest.main(exit=True)
diff --git a/autotests/testBasicServiceSet/hw.conf b/autotests/testBasicServiceSet/hw.conf
new file mode 100644
index 00000000..ff1075fa
--- /dev/null
+++ b/autotests/testBasicServiceSet/hw.conf
@@ -0,0 +1,7 @@
+[SETUP]
+num_radios=3
+hwsim_medium=yes
+
+[HOSTAPD]
+rad0=ssidTKIP-1.conf
+rad1=ssidTKIP-2.conf
diff --git a/autotests/testBasicServiceSet/ssidTKIP-1.conf b/autotests/testBasicServiceSet/ssidTKIP-1.conf
new file mode 100644
index 00000000..11ef15f0
--- /dev/null
+++ b/autotests/testBasicServiceSet/ssidTKIP-1.conf
@@ -0,0 +1,7 @@
+hw_mode=g
+channel=1
+ssid=ssidTKIP
+
+wpa=1
+wpa_pairwise=TKIP
+wpa_passphrase=secret123
diff --git a/autotests/testBasicServiceSet/ssidTKIP-2.conf b/autotests/testBasicServiceSet/ssidTKIP-2.conf
new file mode 100644
index 00000000..0ed132c1
--- /dev/null
+++ b/autotests/testBasicServiceSet/ssidTKIP-2.conf
@@ -0,0 +1,7 @@
+hw_mode=g
+channel=2
+ssid=ssidTKIP
+
+wpa=1
+wpa_pairwise=TKIP
+wpa_passphrase=secret123
diff --git a/autotests/testBasicServiceSet/ssidTKIP.psk b/autotests/testBasicServiceSet/ssidTKIP.psk
new file mode 100644
index 00000000..85d25d8d
--- /dev/null
+++ b/autotests/testBasicServiceSet/ssidTKIP.psk
@@ -0,0 +1,5 @@
+[Security]
+Passphrase=secret123
+
+[Settings]
+AutoConnect=False
-- 
2.34.1

