Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7B215DBAE
	for <iwd@lists.linux.dev>; Wed, 24 Jul 2024 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721836014; cv=none; b=mM5aj8C7VB1EeKFZ2uRLY1sinyJeLcHmggf7MFZbp0Zp8bXe1TgohBJ++bfWt2Q5+j7y+o9HK1GpNAqPZMSIdtvZUma03btoKYdeLVaRUiGdn5Td+DxjwEuedZtd3f4MzfVdOk2wcv0cgKK7q3gn/ZDNpm89df609S4M4gvd8yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721836014; c=relaxed/simple;
	bh=BJHLYn4a21S7jdJH+9Q1Jmqq1q59HI4hcOCAJMco91g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sC7sVKLMbfWdnu930hd1Y/oxjO9nMaJeDQGEos92YtClvq05nz+YetAlC59oN1LztgucjE6Szegz2nGwe/NoGLEFqI28ukXAFnJi+ZP5S3bf6TI0p6eGQCb1SG9NVdMytvENdAp+HrxPbiKzAp67JjgTBzs2lBHClxwfTMeVpA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/DElXSz; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/DElXSz"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5d5846f7970so1609103eaf.3
        for <iwd@lists.linux.dev>; Wed, 24 Jul 2024 08:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721836011; x=1722440811; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBXouCzHAGxvW2umhZYkML822JM3qwt4qA7iC1rTMpw=;
        b=i/DElXSzKKsu6jlGYssBMp1OY/rnO0xAfblBhAWm9l8/3wkUOHG9AJyntmUc0+y9hb
         y21tbdkypuANCS9nDr7C/QD3HzH70Pv89PDD79gKJoMuvGpsuE7vbaj2afezYl6Z7Sq2
         8fZDSXGANoMNqcMbEi2RcuUkMMJTUFJlgaD1X0RlZJNvE9DJFpLBXWazO2gPxu3xnDEe
         9PmkK7ZDagLS2eYfI+xr+Kilvsr+XG3gFdyXOJzx32YnLoBkPQrG7+lLam8DaL8l9FVl
         E4vL05pBkpBLJVcGzwpbMAtiQIyzT9MC1SS0PzGoHvt/ifT3vMNo/U1QsmNrX6DonX5M
         ybCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721836011; x=1722440811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBXouCzHAGxvW2umhZYkML822JM3qwt4qA7iC1rTMpw=;
        b=vJ6j/7rf9gIOvxuTrUaiLePv/TlpwT8aqkcbCuj6YbzjnTvmky2umd+iQaupKxNE07
         b8/AhkT9myk1TFFgMhNkqE/giO1/4lG6HSYQVSi6ATzzkR4kjE7GZyAIVpNQILgC6ujF
         zK7VV85PT4pZkJl+ACVoMB1pAY4rvLCJUQnTQhmV5PRR2n6rj9jL/7D2eXm/TAojdeDx
         wgUU0JrlcKjShbXiq+oQLGlmWXqkRkRsMT8Vg6qr3ZKSmy7I910DcAk/eMa+aiFGpQG0
         RieNvIMaKvdF1ACUMVsZhYnocrLdP6k30GQ1Dlw8oITqwpXzWsa2wk406MppF9ee+ro+
         DyzA==
X-Gm-Message-State: AOJu0YxuwVF6PgLROU4c80l5DEMGPbEuBeuHKrwAwcH0vvks1dm17RLA
	jL7EeFa7C+2dQbAP6tp6qjIZbJIIXauF0TPT/qUf0nRwl65CmH8CIylQ3w==
X-Google-Smtp-Source: AGHT+IHB23mEOpTFePnTiAxnTvNKkClTw1iB2i97taoh4VDd8PM/fR7KOGgojvYmzpNTQKNKQu0QoA==
X-Received: by 2002:a05:6358:3389:b0:1aa:c4ea:8e5e with SMTP id e5c5f4694b2df-1acf8a32cfdmr27440155d.13.1721836011490;
        Wed, 24 Jul 2024 08:46:51 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a199013905sm589001485a.67.2024.07.24.08.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 08:46:51 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/5] auto-t: add DPP tests for state change checks
Date: Wed, 24 Jul 2024 08:46:40 -0700
Message-Id: <20240724154641.1461593-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724154641.1461593-1-prestwoj@gmail.com>
References: <20240724154641.1461593-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/testDPP/pkex_test.py         |  20 ++++-
 autotests/testDPP/state_change_test.py | 107 +++++++++++++++++++++++++
 2 files changed, 126 insertions(+), 1 deletion(-)
 create mode 100644 autotests/testDPP/state_change_test.py

diff --git a/autotests/testDPP/pkex_test.py b/autotests/testDPP/pkex_test.py
index db355225..3d3ea6d1 100644
--- a/autotests/testDPP/pkex_test.py
+++ b/autotests/testDPP/pkex_test.py
@@ -4,7 +4,7 @@ import unittest
 import sys
 
 sys.path.append('../util')
-from iwd import IWD, SharedCodeAgent
+from iwd import IWD, SharedCodeAgent, DeviceState
 from iwd import DeviceProvisioning
 from wpas import Wpas
 from hostapd import HostapdCLI
@@ -210,6 +210,24 @@ class Test(unittest.TestCase):
 
         self.assertIn("SendHostname=true", settings)
 
+    def test_existing_incorrect_profile(self):
+        self.hapd.reload()
+        self.hapd.wait_for_event('AP-ENABLED')
+        IWD.copy_to_storage("existingProfile.psk", "/tmp/ns0/", "ssidCCMP.psk")
+
+        # Start connecting
+        self.device[1].autoconnect = True
+        self.wd.wait_for_object_condition(self.device[1], 'obj.state == DeviceState.connecting')
+
+        # We should be able to start DPP despite the connecting state
+        self.device[1].dpp_pkex_enroll('secret123', identifier="test")
+
+        self.start_iwd_pkex_configurator(self.device[0])
+        self.assertEqual(self.device[1].state, DeviceState.disconnected)
+
+        condition = 'obj.state == DeviceState.connected'
+        self.wd.wait_for_object_condition(self.device[1], condition)
+
     def test_existing_hidden_network(self):
         self.hapd_hidden.reload()
         self.hapd_hidden.wait_for_event('AP-ENABLED')
diff --git a/autotests/testDPP/state_change_test.py b/autotests/testDPP/state_change_test.py
new file mode 100644
index 00000000..d52f2b12
--- /dev/null
+++ b/autotests/testDPP/state_change_test.py
@@ -0,0 +1,107 @@
+#!/usr/bin/python3
+
+import unittest
+import sys
+
+sys.path.append('../util')
+from iwd import IWD, SharedCodeAgent, DeviceState
+from iwd import DeviceProvisioning
+from wpas import Wpas
+from hostapd import HostapdCLI
+from hwsim import Hwsim
+from config import ctx
+from time import time
+import os
+
+class Test(unittest.TestCase):
+    def auto_connect(self):
+        IWD.copy_to_storage('ssidCCMP.psk')
+        self.device.autoconnect = True
+
+        condition = 'obj.state == DeviceState.connected'
+        self.wd.wait_for_object_condition(self.device, condition)
+
+    def test_configurator_stops_on_disconnect(self):
+        self.auto_connect()
+
+        self.device.dpp_start_configurator()
+
+        self.device.disconnect()
+
+        condition = 'obj.state == DeviceState.disconnected'
+        self.wd.wait_for_object_condition(self.device, condition)
+
+        self.assertEqual(self.device._device_provisioning.started, False)
+
+    def test_enrollee_stops_on_connect(self):
+        # Scan to get a list of networks
+        self.device.scan()
+        self.wd.wait_for_object_condition(self.device, 'obj.scanning == True')
+        self.wd.wait_for_object_condition(self.device, 'obj.scanning == False')
+
+        self.device.dpp_start_enrollee()
+
+        network = self.device.get_ordered_network("ssidCCMP")
+        network.network_object.connect()
+
+        condition = 'obj.state == DeviceState.connected'
+        self.wd.wait_for_object_condition(self.device, condition)
+
+        self.assertEqual(self.device._device_provisioning.started, False)
+
+    def test_enrollee_disconnects_automatically(self):
+        self.auto_connect()
+
+        self.device.dpp_start_enrollee()
+
+        condition = 'obj.state == DeviceState.disconnected'
+        self.wd.wait_for_object_condition(self.device, condition)
+
+    def test_enrollee_autoconnect_stays_on(self):
+        # Put in an autoconnecting state, no saved profile though
+        self.device.autoconnect = True
+
+        self.device.dpp_start_enrollee()
+
+        # DPP should set autoconnect false, but then re-enable after it stops
+        self.wd.wait_for_object_condition(self.device, "obj.autoconnect == False")
+        self.wd.wait_for_object_condition(self.device._device_provisioning, "obj.started == True")
+
+        # Stop DPP
+        self.device.dpp_stop()
+        self.wd.wait_for_object_condition(self.device, "obj.autoconnect == True")
+
+    def test_enrollee_autoconnect_stays_off(self):
+        # Autoconnect should be off by default
+
+        self.device.dpp_start_enrollee()
+
+        # DPP should set autoconnect false, but stay off after it stops
+        self.wd.wait_for_object_condition(self.device, "obj.autoconnect == False")
+        self.wd.wait_for_object_condition(self.device._device_provisioning, "obj.started == True")
+
+        # Stop DPP
+        self.device.dpp_stop()
+        self.wd.wait_for_object_condition(self.device, "obj.autoconnect == False")
+
+    def setUp(self):
+        self.wd = IWD(True)
+        self.device = self.wd.list_devices(1)[0]
+
+    def tearDown(self):
+        self.wd.stop()
+        self.wd = None
+
+    @classmethod
+    def setUpClass(cls):
+        hapd = HostapdCLI(config="hostapd.conf")
+        hapd.reload()
+
+        hapd.wait_for_event("AP-ENABLED")
+
+    @classmethod
+    def tearDownClass(cls):
+        pass
+
+if __name__ == '__main__':
+    unittest.main(exit=True)
\ No newline at end of file
-- 
2.34.1

