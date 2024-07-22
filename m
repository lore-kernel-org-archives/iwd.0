Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CEF16C849
	for <iwd@lists.linux.dev>; Mon, 22 Jul 2024 18:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721672980; cv=none; b=b/nlLSTSjhqfFcKjefYAYruczihrrF+35VujYuKmSmgpznaY5EQ9pxpSA/jvyUxe52UQI1AgrtiYtdaTT/WyG0ilpVpPaI9g/5FhzVIOViBGUvo9TIg13EtwEWnen4BxjE6lLIphDtnMVozvPkEiyM5kMSAJsLEqugMnUWfxCkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721672980; c=relaxed/simple;
	bh=BJHLYn4a21S7jdJH+9Q1Jmqq1q59HI4hcOCAJMco91g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jgTE/YqtgC9wTS1n34kua+1r9tVfWfroPBRZjlrffugHpu1hPn2U2hzW94bSlEmnHGphdKZxBeGL9vk3JGXN6qd7UGzdl6TTKY1MW+NIrWCqI01VLcbbNhNK77UUiUpFmnGviGzpL/4KwlwOuDjMdvYdABSQ72qMiy2VnOfpjAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwP+emwf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwP+emwf"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc49c1f3e5so34302635ad.1
        for <iwd@lists.linux.dev>; Mon, 22 Jul 2024 11:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721672978; x=1722277778; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBXouCzHAGxvW2umhZYkML822JM3qwt4qA7iC1rTMpw=;
        b=IwP+emwfL1yRS6mmXphf8DDSmLDi86gLMsz/ZZvXjOlknx0vC3b2XOj2yGUfDmSIZ9
         VusJbKT+/C3FThB6XvcnFfDq+X/+zm/dXYIiukfm4+EsmcN4XhoMnMAJ8jrcttJPmad9
         dckL4xwILv/OCtuCIsX+8QVo0fVClW/kE6pNBUJFylrqwZat2kvRXoCZtgY9aNF7dYcw
         hdaLgi3sTC8MUPH5DshDSJ97q98vxGTHBTzweoY/zldJSI2WARUTyrB1SZQRh4A3cJli
         uSmMbfl9MGx72PEZ5Ufpl09OQVqMk28L/Q8taeLufN3c3Fd/u8KU5BZVRooaqbWruwSY
         J/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721672978; x=1722277778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBXouCzHAGxvW2umhZYkML822JM3qwt4qA7iC1rTMpw=;
        b=KEo6u7ryjfw8/zE1XwXZuzqRL3hFU+ICXUbHBU1Cv5FyLaAsaytf7GfyD6HVwSIomY
         2jDzHr2+tqYWl0MxGS3w9ajLSw3mDCW+xolRj2buBwV3ZJPEONRZbxYAbNsyxv4Aayox
         d8qroh7hnux3ev/6gxHaUpUJ2Qtiy+JpYQPE+W7ymVzPPPDpqYFnv+JGENo38v/1AXks
         uGISDBlJHsWlZc5BXr7cz09+0C2VioYf/g/S0su6bLUxxkrr622kmrUmAQdBpZFc8TCv
         UxI6AnYsT6KK3sioE83+CN+jG2foAtbxfLzPYmoTgY+xftTtUoKl0WxoXFP9d3l07RgS
         AeBw==
X-Gm-Message-State: AOJu0YydUAkMWxEtGDyQE1behbMYG/bx47NB/KhrtvwyD/6LAwuunM07
	6dpGfJAhNd8YJBY8UkcB0kh9wtNZy29FsL0fghBEgQcwJ3Sm6Uay50w/wg==
X-Google-Smtp-Source: AGHT+IEEgmovHUoPz0OKYfZ/SO/7oop6AmN7hHPvIRhoBCKg1LM9nEK/5yR58DquQziEhM8JDrMt7A==
X-Received: by 2002:a17:902:ec90:b0:1fd:9238:40f with SMTP id d9443c01a7336-1fd9238072amr33208245ad.22.1721672978054;
        Mon, 22 Jul 2024 11:29:38 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd8dff753bsm33622625ad.243.2024.07.22.11.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 11:29:37 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/5] auto-t: add DPP tests for state change checks
Date: Mon, 22 Jul 2024 11:29:31 -0700
Message-Id: <20240722182932.4091008-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722182932.4091008-1-prestwoj@gmail.com>
References: <20240722182932.4091008-1-prestwoj@gmail.com>
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

