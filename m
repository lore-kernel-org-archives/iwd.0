Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4361719307D
	for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 20:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723493705; cv=none; b=LTbhDmSh2zUEJawmByTh11raEhQfBgypuWSyIMo6TbJm3zemdAafOLVwpfbtranNRY/7aXRQ1R2q3hoOGOHCWn/EMIHQBo7jKzHqJPw0uQk/tHufVNSiyzc+nrnNi/ka7r/UqHVtww50c26fS2F7PpwboocV8sLqwsps6T01rBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723493705; c=relaxed/simple;
	bh=BjQkB9GSxjm5SBb5hv8pqkTA1rCqFHSJy1itDAprHbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ab4BS+VdpjuwyaO2MwJJ68PSZBXvjYH83bi6qoiaDBXtxUvgJCJpZ40wHBoLMEkwbvv42Q6tS97tUROROmUGhcoDiwNGCNbS295UeeFcte6dEAh0dgZpTyu+xJK5sKTS8mCtwrVmV/MkPg6aB126sYc0FPyvMeoTTHBAntPyTR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ty1EAPPV; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ty1EAPPV"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2cb5e0b020eso3694278a91.2
        for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 13:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723493703; x=1724098503; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YHvW00F3IxY3DwZw5kLlhMWYbu8nzr5MZcUrvjS2vlw=;
        b=Ty1EAPPVsoeSTOHQ25w98mtGf3752fw7/E4L+UbQ+b9eoPlxR9BlPlt/eppNlB70JT
         5sEySMhiOKL8vLZuXuhTNXW2jyf2ufKpA/mW9Zfy02kylfY8fGtUeNpVi1YOA/VZ2xtn
         NEgLupTSTZyScI5YknRYBWkiugx2ZflEiB77J7HucArGos4fq5eJ5nhGOEAYklCu+AlI
         mAaN5QwLOLJPOkLu8QbYXDYuYGHG8ANraywGfX5ChWZ+VF4UhQE8I22gPcWrGQP+wTU1
         2Ga+QFcxLxO5vdhWQJWA4+BtkuL5FyUJAC85/4FaLp/ihQj3c9vE/2fYKPWPWHfogPd7
         lWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723493703; x=1724098503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YHvW00F3IxY3DwZw5kLlhMWYbu8nzr5MZcUrvjS2vlw=;
        b=al0ktJlzqBZVuIe7vxKXpDaJs/u0A8Gcpz57tGl5DpsoQklOsRFw3BBs+7hKRpIR8S
         2EGFsF91+fT4jG+gsBbhOkYLfLWML4HFLm9/hwhUoyNFWiHsAVX2iPvIL9H+4ap/wGho
         1Fbab0OdTgpiA5qanZfsHpeMP+tV+eOInint+eTDx9LUhBm1XgcGqhY3guiG1fQZj0Ng
         6rig2UYI2tKshAGAnT18BF3HjweweV2NyJKiBVFCCJyXLRaBp1wzUB5nVDn3VDAqZ/R6
         /LWV/44R0j/a2cRDHEsFNi2yVHdi/Vb32OOA2Li1DupRvn/bfZlQh4119JRQMqIS79Rg
         LP5g==
X-Gm-Message-State: AOJu0YzCD5nVPcpE8g7dS5eeqFNhc7jFVCwcpcMmn7Ed6yiDK8AlKJkA
	39QxUeaGVRM/x8wBU6sUHqz9gBQ5T1pKNrOEboJxQNN9iL9QxLaWxpq/BQ==
X-Google-Smtp-Source: AGHT+IEEAqA7XWVRGi1sa+f0vAF5XlbsAvfJL/aEymDU1X7u79o4b2LzuyTL7XDDKJxmpRrPoTap7Q==
X-Received: by 2002:a17:90b:4c4c:b0:2c9:7f3d:6aea with SMTP id 98e67ed59e1d1-2d3926547b0mr1473778a91.32.1723493703017;
        Mon, 12 Aug 2024 13:15:03 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9c847b9sm8747368a91.23.2024.08.12.13.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 13:15:02 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2] auto-t: add SAE-H2E test for setting the default ECC group
Date: Mon, 12 Aug 2024 13:14:57 -0700
Message-Id: <20240812201457.187703-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/testSAE/default_group_test.py       | 26 ++++++++++++-------
 .../profiles/ssidSAE-H2E.psk.default_group    |  5 ++++
 2 files changed, 22 insertions(+), 9 deletions(-)
 create mode 100644 autotests/testSAE/profiles/ssidSAE-H2E.psk.default_group

v2:
 * Include H2E profile, forgot on v1

diff --git a/autotests/testSAE/default_group_test.py b/autotests/testSAE/default_group_test.py
index d72c96ca..3b7812c3 100644
--- a/autotests/testSAE/default_group_test.py
+++ b/autotests/testSAE/default_group_test.py
@@ -13,7 +13,7 @@ import testutil
 
 class Test(unittest.TestCase):
 
-    def validate_connection(self, wd, rejected=False):
+    def validate_connection(self, wd, hostapd, rejected=False):
         devices = wd.list_devices(1)
         self.assertIsNotNone(devices)
         device = devices[0]
@@ -29,14 +29,14 @@ class Test(unittest.TestCase):
         wd.wait(2)
 
         testutil.test_iface_operstate(intf=device.name)
-        testutil.test_ifaces_connected(if0=device.name, if1=self.hostapd.ifname)
+        testutil.test_ifaces_connected(if0=device.name, if1=hostapd.ifname)
 
         if not rejected:
             self.assertEqual(device.event_ocurred("ecc-group-rejected"), False)
 
-        print(self.hostapd._get_status())
+        print(hostapd._get_status())
 
-        sta_status = self.hostapd.sta_status(device.address)
+        sta_status = hostapd.sta_status(device.address)
 
         print(sta_status)
 
@@ -51,22 +51,27 @@ class Test(unittest.TestCase):
     #   - Connect, try only group 19
     def test_auto_selection(self):
         IWD.copy_to_storage("profiles/ssidSAE.psk.default", name="ssidSAE.psk")
-        self.validate_connection(self.wd, rejected=True)
+        self.validate_connection(self.wd, self.hostapd, rejected=True)
 
-        self.validate_connection(self.wd, rejected=False)
+        self.validate_connection(self.wd, self.hostapd, rejected=False)
 
     # Try group 19 first
     def test_default_group_enabled(self):
         IWD.copy_to_storage("profiles/ssidSAE.psk.default_group", name="ssidSAE.psk")
-        self.validate_connection(self.wd)
+        self.validate_connection(self.wd, self.hostapd)
+
+    # Try group 19 first, with H2E
+    def test_default_group_enabled_h2e(self):
+        IWD.copy_to_storage("profiles/ssidSAE-H2E.psk.default_group", name="ssidSAE-H2E.psk")
+        self.validate_connection(self.wd, self.hostapd_h2e)
 
     # Same as auto-selection but won't retain the default group setting
     def test_default_group_disabled(self):
         IWD.copy_to_storage("profiles/ssidSAE.psk.most_secure", name="ssidSAE.psk")
-        self.validate_connection(self.wd, rejected=True)
+        self.validate_connection(self.wd, self.hostapd, rejected=True)
 
         # IWD should then retry but use only group 19
-        self.validate_connection(self.wd, rejected=True)
+        self.validate_connection(self.wd, self.hostapd, rejected=True)
 
     def setUp(self):
         self.hostapd.default()
@@ -88,6 +93,9 @@ class Test(unittest.TestCase):
         cls.hostapd = HostapdCLI(config='ssidSAE.conf')
         cls.hostapd.default()
 
+        cls.hostapd_h2e = HostapdCLI(config='ssidSAE-H2E.conf')
+        cls.hostapd_h2e.default()
+
     @classmethod
     def tearDownClass(cls):
         pass
diff --git a/autotests/testSAE/profiles/ssidSAE-H2E.psk.default_group b/autotests/testSAE/profiles/ssidSAE-H2E.psk.default_group
new file mode 100644
index 00000000..2a016107
--- /dev/null
+++ b/autotests/testSAE/profiles/ssidSAE-H2E.psk.default_group
@@ -0,0 +1,5 @@
+[Security]
+Passphrase=secret123
+
+[Settings]
+UseDefaultEccGroup=true
-- 
2.34.1

