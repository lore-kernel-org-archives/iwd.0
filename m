Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566A73C490
	for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 18:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058877; cv=none; b=LpNaOpNArkFX6CUXUNl+Sott0MwwffgMbKx/zkeusq9kpf6PUfBR/6mS2nYmBBYAvmGaAmuW3mli0Ry+5YNxmFNaVG7X4qFFievAMiyMAxUwoP1OkMDlvbDha92QUkPoKnnb9ngtzEPNYq3sI21Xx9opY7IXZOVkh2JPTgDdbPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058877; c=relaxed/simple;
	bh=66w25IuOndLJgdyv7iLH9fM1hlzmZNanlT7adaklcwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xz+4WTBf2PegTOPG8/swVu4xywt+LSO3Buh267/NzYVthKnuoOG+4gpN8BmdGs7pir47pBKFY1R6faTMxuK7gjvJLZwFnDgx0E05hH/TjgRdIjZJYFxYS+/lJSXok7tC2rq2Jz0uFy4gXsaqI1792JVEixADOmCxqXDMmxlw2+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ewz8l8aQ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ewz8l8aQ"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42e86f37a0eso16783291cf.0
        for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 10:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709058874; x=1709663674; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCExoPFDaT1PolX168XrZ+APvd2AQKpbGCE4am2tuHw=;
        b=Ewz8l8aQS53RnJoNRrMtK8N6tc50bMQcPjag/htYiIJG+L0pLznZ3v25pjeEpPFEOo
         ibpyEVF4W8UbBDeiU/tWvgkMVUlyTqDgHrdzUvvCPt4EpVROML/7lG21Xtawku5zjb4m
         mZ5VZIUZw3qd3rmAds0Ol1VatlzVDjxSJVwDdD3mGWuRDOgvWo4Vcd6rSjfwZSmG4c89
         0RPvIRKFOu1kDKgV36STJU9wIKiZi/yJ3msyYLLLA6qUVqyKDL3/nG9B7VPQSwQQmn85
         jA6k3n1uO5yojc99njLiFunxmQ0OG7oipjSqT1EirsqVbVnu8/h9WlAffPOk4D4It2Yg
         iU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709058874; x=1709663674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCExoPFDaT1PolX168XrZ+APvd2AQKpbGCE4am2tuHw=;
        b=Cb3d9hfkBdbnS4ug67BhuWu2M0PvolfEJSEeroaCTljzSCNTF3xBOg5ikjIEgySZsR
         NwUcdnHVR9OOn3sJvPxJQ5/PawD9Kz7ip40hZZ6FlgaPbcVAqMYiLvhAmYl6LNZBdnM/
         9kmdLHGPuGY7lstupYY+I2sZGMjp1dx3JN3XmCvhHEQp8W4QmzhcA7lWGjr3C/2ctVnX
         OWNevYIE0qLkWIjF4RAr6FA1yWyQxvO4T2cfNdhesPT4QdeKEARRzq9g9P/Z6JamOH6u
         BFTH3qTeEgzvxe8c9+J+TAzGRL0olpkxLqAwDSq9PNONTq2Cjz2HybERGUJBtKL+bsMy
         O+jA==
X-Gm-Message-State: AOJu0YxTix8eRS36e68A3D6P6vOW88cq3iMzBM2yEx6DxDSFinHnU8TI
	boVFk8A62WZ26WDTXgMnGKZaKWqFyyHSBJHFq+oSkBV98J89SguQl+3Cjfms
X-Google-Smtp-Source: AGHT+IFkigVeWUCLZOkMe0hFtkLckbLBD+k6DAyohMev94Oj1dzozMi6ivNNOxRNxqbf9Atl1oMW6w==
X-Received: by 2002:ac8:5c16:0:b0:42e:68ad:d095 with SMTP id i22-20020ac85c16000000b0042e68add095mr13328259qti.0.1709058874169;
        Tue, 27 Feb 2024 10:34:34 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id jy2-20020a05622a818200b0042e3468a98csm3819617qtb.4.2024.02.27.10.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 10:34:32 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 10/11] auto-t: Add test for new SAE default group behavior
Date: Tue, 27 Feb 2024 10:34:04 -0800
Message-Id: <20240227183405.257206-10-prestwoj@gmail.com>
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

Tests the 3 possible options to UseDefaultEccGroup behave as
expected:
 - When not provided use the "auto" behavior.
 - When false, always use higher order groups
 - When true, always use default group
---
 autotests/testSAE/default_group_test.py       | 96 +++++++++++++++++++
 autotests/testSAE/hw.conf                     |  3 +-
 .../profiles/ssidSAE.psk.default_group        |  5 +
 .../testSAE/profiles/ssidSAE.psk.most_secure  |  5 +
 autotests/testSAE/ssidSAE-default-group.conf  | 12 +++
 5 files changed, 120 insertions(+), 1 deletion(-)
 create mode 100644 autotests/testSAE/default_group_test.py
 create mode 100644 autotests/testSAE/profiles/ssidSAE.psk.default_group
 create mode 100644 autotests/testSAE/profiles/ssidSAE.psk.most_secure
 create mode 100644 autotests/testSAE/ssidSAE-default-group.conf

diff --git a/autotests/testSAE/default_group_test.py b/autotests/testSAE/default_group_test.py
new file mode 100644
index 00000000..d72c96ca
--- /dev/null
+++ b/autotests/testSAE/default_group_test.py
@@ -0,0 +1,96 @@
+#!/usr/bin/python3
+
+import unittest
+import sys
+import os
+sys.path.append('../util')
+import iwd
+from iwd import IWD
+from iwd import PSKAgent
+from iwd import NetworkType
+from hostapd import HostapdCLI
+import testutil
+
+class Test(unittest.TestCase):
+
+    def validate_connection(self, wd, rejected=False):
+        devices = wd.list_devices(1)
+        self.assertIsNotNone(devices)
+        device = devices[0]
+
+        device.autoconnect = True
+
+        if rejected:
+            device.wait_for_event("ecc-group-rejected", timeout=60)
+
+        condition = 'obj.state == DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
+        wd.wait(2)
+
+        testutil.test_iface_operstate(intf=device.name)
+        testutil.test_ifaces_connected(if0=device.name, if1=self.hostapd.ifname)
+
+        if not rejected:
+            self.assertEqual(device.event_ocurred("ecc-group-rejected"), False)
+
+        print(self.hostapd._get_status())
+
+        sta_status = self.hostapd.sta_status(device.address)
+
+        print(sta_status)
+
+        self.assertEqual(int(sta_status["sae_group"]), 19)
+
+        device.disconnect()
+
+    # IWD should:
+    #   - Connect, fail with group 20
+    #   - Retry, succeed with group 19
+    #   - Disconnect
+    #   - Connect, try only group 19
+    def test_auto_selection(self):
+        IWD.copy_to_storage("profiles/ssidSAE.psk.default", name="ssidSAE.psk")
+        self.validate_connection(self.wd, rejected=True)
+
+        self.validate_connection(self.wd, rejected=False)
+
+    # Try group 19 first
+    def test_default_group_enabled(self):
+        IWD.copy_to_storage("profiles/ssidSAE.psk.default_group", name="ssidSAE.psk")
+        self.validate_connection(self.wd)
+
+    # Same as auto-selection but won't retain the default group setting
+    def test_default_group_disabled(self):
+        IWD.copy_to_storage("profiles/ssidSAE.psk.most_secure", name="ssidSAE.psk")
+        self.validate_connection(self.wd, rejected=True)
+
+        # IWD should then retry but use only group 19
+        self.validate_connection(self.wd, rejected=True)
+
+    def setUp(self):
+        self.hostapd.default()
+        self.hostapd.set_value('sae_groups', '19')
+        self.hostapd.set_value('sae_pwe', '0')
+        self.hostapd.reload()
+        self.hostapd.wait_for_event("AP-ENABLED")
+        self.wd = IWD(True)
+
+        self.wd.clear_storage()
+        os.system("ls /tmp/iwd")
+
+    def tearDown(self):
+        self.wd.clear_storage()
+        self.wd = None
+
+    @classmethod
+    def setUpClass(cls):
+        cls.hostapd = HostapdCLI(config='ssidSAE.conf')
+        cls.hostapd.default()
+
+    @classmethod
+    def tearDownClass(cls):
+        pass
+
+if __name__ == '__main__':
+    unittest.main(exit=True)
diff --git a/autotests/testSAE/hw.conf b/autotests/testSAE/hw.conf
index cc0836b7..127bbb31 100644
--- a/autotests/testSAE/hw.conf
+++ b/autotests/testSAE/hw.conf
@@ -1,8 +1,9 @@
 [SETUP]
-num_radios=3
+num_radios=4
 start_iwd=0
 hwsim_medium=yes
 
 [HOSTAPD]
 rad0=ssidSAE.conf
 rad1=ssidSAE-H2E.conf
+rad2=ssidSAE-default-group.conf
diff --git a/autotests/testSAE/profiles/ssidSAE.psk.default_group b/autotests/testSAE/profiles/ssidSAE.psk.default_group
new file mode 100644
index 00000000..2a016107
--- /dev/null
+++ b/autotests/testSAE/profiles/ssidSAE.psk.default_group
@@ -0,0 +1,5 @@
+[Security]
+Passphrase=secret123
+
+[Settings]
+UseDefaultEccGroup=true
diff --git a/autotests/testSAE/profiles/ssidSAE.psk.most_secure b/autotests/testSAE/profiles/ssidSAE.psk.most_secure
new file mode 100644
index 00000000..3a511991
--- /dev/null
+++ b/autotests/testSAE/profiles/ssidSAE.psk.most_secure
@@ -0,0 +1,5 @@
+[Security]
+Passphrase=secret123
+
+[Settings]
+UseDefaultEccGroup=false
\ No newline at end of file
diff --git a/autotests/testSAE/ssidSAE-default-group.conf b/autotests/testSAE/ssidSAE-default-group.conf
new file mode 100644
index 00000000..752e9c7b
--- /dev/null
+++ b/autotests/testSAE/ssidSAE-default-group.conf
@@ -0,0 +1,12 @@
+hw_mode=g
+channel=1
+ssid=ssidSAE-default-group
+
+wpa=2
+wpa_key_mgmt=SAE
+wpa_pairwise=CCMP
+sae_password=secret123
+sae_groups=19
+ieee80211w=2
+sae_pwe=0
+vendor_elements=dd0cf4f5e8050500000000000000
-- 
2.34.1

