Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E621C6AB
	for <iwd@lists.linux.dev>; Wed,  3 Jan 2024 18:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaEuDxmD"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-204ec50010eso3151335fac.3
        for <iwd@lists.linux.dev>; Wed, 03 Jan 2024 10:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704307625; x=1704912425; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80PvfFBt8thHLOeFqpvd019AWlbEdsq+2OkJNyj5GRc=;
        b=YaEuDxmDsCtk8muvvEAZAD8PBjjO8WHYVz+U5U6XdSEe+45KER6NfkX5c3OcTN+ccK
         Hp2IZ6058YAqM31b3A2RyzXBlRR7GVBgAISq2q490oLgKB3zsrbId+zT9Krx7boEfghR
         JkFxW70vcqh+EvkH5wmeXaHaYCzetxid4wsYB3lD5H9KAv/3SVzh/sJ5WSO8Y1xtGHxQ
         ItCfcE4bw6HSku5FSdOFirkiTNl5p0xMLqIaGAc12Bxc+Mzi5JxCyJlKWLrmAUrDM1Rs
         A3twJ9XJNeE1yyjfV99OJs6I/iNCBB+Qa400vu7UTogeJ7fJSeDA7ihE8NTscEV9AYXL
         eDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704307625; x=1704912425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80PvfFBt8thHLOeFqpvd019AWlbEdsq+2OkJNyj5GRc=;
        b=Xea7ugHw7I+fKLtHWy4QxmPaFY9MKMgaBmuAfdC2CYrWVl7HOwE3JzfX1/q6Xd4i9L
         11w5x2YGngBJ3l68sDCYHhbnBkDUnKNKzPOHYDJKgU/ZjT8ZUI2mGBiKsG+EDuruV0YV
         5hRxkTg3BeNCCmi5zHWWzfhGD+eKAwfmi/eVKgzxXJJU4HYS8AGNJ5n4FoK8m9T3XMwA
         stG2wNUaXcEVH49ZBuG6t925D8UYIClJQ24Kh1DfgpUgd65hki0ZZczoRk8XVxIlA8v8
         mO5PdWvm6auL3DSkBbg/Zk1eJo+qv1KdKQgYRw0XMJcdGwdicQMEMqCoWk7AuCwhFKd0
         +MIw==
X-Gm-Message-State: AOJu0YyBNcaQH6r7ioSr+iWKa+p1cFR1ZT7/zJkFBEma6JrkIuitIl/8
	WRK/T/b8Ifhn4eAtYeXoSmW+w+uHrJFc3w==
X-Google-Smtp-Source: AGHT+IEoVjpNf925QAw+Nddj2Q1gGw87YTMv/HyozOcIFR9rh/IsA5xjeZJCkATTbzg14iJgRMAO4Q==
X-Received: by 2002:a05:6870:7010:b0:1fa:f81d:2402 with SMTP id u16-20020a056870701000b001faf81d2402mr18766398oae.12.1704307624737;
        Wed, 03 Jan 2024 10:47:04 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id o21-20020a05620a22d500b00781a147e444sm3693370qki.92.2024.01.03.10.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 10:47:04 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 7/8] auto-t: improve failure handling in testPSK-roam
Date: Wed,  3 Jan 2024 10:46:37 -0800
Message-Id: <20240103184638.533221-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103184638.533221-1-prestwoj@gmail.com>
References: <20240103184638.533221-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This really needs to be done to many more autotests but since this
one seems to have random failures ensure that all the tests still
run if one fails. In addition add better cleanup for hwsim rules.
---
 autotests/testPSK-roam/connection_test.py     | 25 +++++++++----------
 autotests/testPSK-roam/failed_roam_test.py    |  3 +++
 .../testPSK-roam/roam_ap_disconnect_test.py   | 11 +++++---
 3 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/autotests/testPSK-roam/connection_test.py b/autotests/testPSK-roam/connection_test.py
index 8db4e4cb..2dbf1473 100644
--- a/autotests/testPSK-roam/connection_test.py
+++ b/autotests/testPSK-roam/connection_test.py
@@ -91,13 +91,9 @@ class Test(unittest.TestCase):
         wd.wait_for_object_condition(device, condition)
 
     def test_ft_psk(self):
-        wd = IWD(True)
-
-        self.validate_connection(wd)
+        self.validate_connection(self.wd)
 
     def test_ft_psk_over_ds(self):
-        wd = IWD(True)
-
         self.bss_hostapd[0].set_value('ft_over_ds', '1')
         self.bss_hostapd[0].reload()
         self.bss_hostapd[0].wait_for_event("AP-ENABLED")
@@ -106,11 +102,9 @@ class Test(unittest.TestCase):
         self.bss_hostapd[1].reload()
         self.bss_hostapd[1].wait_for_event("AP-ENABLED")
 
-        self.validate_connection(wd, over_ds=True)
+        self.validate_connection(self.wd, over_ds=True)
 
     def test_reassociate_psk(self):
-        wd = IWD(True)
-
         self.bss_hostapd[0].set_value('wpa_key_mgmt', 'WPA-PSK')
         self.bss_hostapd[0].reload()
         self.bss_hostapd[0].wait_for_event("AP-ENABLED")
@@ -119,12 +113,10 @@ class Test(unittest.TestCase):
         self.bss_hostapd[1].reload()
         self.bss_hostapd[1].wait_for_event("AP-ENABLED")
 
-        self.validate_connection(wd)
+        self.validate_connection(self.wd)
 
     def test_roam_packet_loss(self):
-        wd = IWD(True)
-
-        self.validate_connection(wd, pkt_loss=True)
+        self.validate_connection(self.wd, pkt_loss=True)
 
     def tearDown(self):
         os.system('ip link set "' + self.bss_hostapd[0].ifname + '" down')
@@ -139,6 +131,12 @@ class Test(unittest.TestCase):
         for hapd in self.bss_hostapd:
             hapd.default()
 
+        self.wd.stop()
+        self.wd = None
+
+    def setUp(self):
+        self.wd = IWD(True)
+
     @classmethod
     def setUpClass(cls):
         hwsim = Hwsim()
@@ -178,8 +176,9 @@ class Test(unittest.TestCase):
     def tearDownClass(cls):
         IWD.clear_storage()
         cls.bss_hostapd = None
-        cls.rule0.enabled = False
         cls.rule0.remove()
+        cls.rule1.remove()
+        cls.rule2.remove()
 
 if __name__ == '__main__':
     unittest.main(exit=True)
diff --git a/autotests/testPSK-roam/failed_roam_test.py b/autotests/testPSK-roam/failed_roam_test.py
index ccdec2c6..12e439f6 100644
--- a/autotests/testPSK-roam/failed_roam_test.py
+++ b/autotests/testPSK-roam/failed_roam_test.py
@@ -227,6 +227,9 @@ class Test(unittest.TestCase):
         cls.bss_hostapd = None
         cls.rule0.remove()
         cls.rule1.remove()
+        cls.rule2.remove()
+        cls.rule3.remove()
+        cls.assoc_rule.remove()
 
 if __name__ == '__main__':
     unittest.main(exit=True)
diff --git a/autotests/testPSK-roam/roam_ap_disconnect_test.py b/autotests/testPSK-roam/roam_ap_disconnect_test.py
index b5775990..76c62ea0 100644
--- a/autotests/testPSK-roam/roam_ap_disconnect_test.py
+++ b/autotests/testPSK-roam/roam_ap_disconnect_test.py
@@ -14,8 +14,7 @@ class Test(unittest.TestCase):
     # Tests a crash reported where multiple roam scans combined with an AP
     # disconnect result in a crash getting scan results.
     #
-    def validate(self):
-        wd = IWD(True)
+    def validate(self, wd):
         device = wd.list_devices(1)[0]
 
         ordered_network = device.get_ordered_network('TestFT', full_scan=True)
@@ -43,14 +42,15 @@ class Test(unittest.TestCase):
         wd.wait_for_object_condition(device, condition)
 
     def test_ap_disconnect_no_neighbors(self):
-        self.validate()
+        self.validate(self.wd)
 
     def test_ap_disconnect_neighbors(self):
         HostapdCLI.group_neighbors(*self.bss_hostapd)
 
-        self.validate()
+        self.validate(self.wd)
 
     def setUp(self):
+        self.wd = IWD(True)
         self.bss_hostapd[0].reload()
         self.bss_hostapd[0].wait_for_event("AP-ENABLED")
 
@@ -63,6 +63,9 @@ class Test(unittest.TestCase):
         self.bss_hostapd[0].remove_neighbor(self.bss_hostapd[1].bssid)
         self.bss_hostapd[1].remove_neighbor(self.bss_hostapd[0].bssid)
 
+        self.wd.stop()
+        self.wd = None
+
     @classmethod
     def setUpClass(cls):
         hwsim = Hwsim()
-- 
2.34.1

