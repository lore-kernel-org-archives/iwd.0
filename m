Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B133F31A98
	for <iwd@lists.linux.dev>; Wed,  8 Nov 2023 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nf5xiklr"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-66d2f3bb312so43877306d6.0
        for <iwd@lists.linux.dev>; Wed, 08 Nov 2023 09:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699464130; x=1700068930; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+95VtRm+fHyfO/FXjON6dIw+MC2yYlRNoqPvueJrcmw=;
        b=Nf5xiklru41jh7DX8SHZ8yO/x5VJcViB5fsUmzlkhEfcjPDj5xY181F8AiX+WQlj7K
         fs4ye5CYoNyxkzD668R8APG+VLw4oFd/4759vMfSEDNKxfutm68xllLwG+2WKapc1AND
         qo35zwmopGKoftZ38sr6duXYufr12iki/4DAcsMUv4sFXPVTn4IWmnVt3iJfqkoXSki7
         i3VVs9tALirOESn2nGxdg+EFgsDuO+JCwblBzss8J8WaOYYqeGPs3q7WRRMHpyUL43bY
         rSkskuMaYkHE+mJ7rZD/KAobytnxKY0sN26ID15r8auYSAY8MGGfDMJgVQdM9yecKLbi
         Et5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699464130; x=1700068930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+95VtRm+fHyfO/FXjON6dIw+MC2yYlRNoqPvueJrcmw=;
        b=RcAL8F45IS2epmAIC54l3Klqmw2m6YCUP4l7E+dVMyba/sEyDOln1w04Mm0az3XOQK
         D93anJPiRRMgXeuKuHJsqWvvzORXQ0kzvJtblzIeatJ8hVUYiq27m8h995QhrrDWhQ69
         VD57lF8crbusqhET2RtpvYvghDC4FMPQK6ck8FELx98ZxOpZe2g2uFGLCNYOW0gCWaCj
         SslyrKc7ju95ptRgXHeksOxNf0FeN7M8lJAyogdm8mq3dA3v4BnirV8/Cdjhj2rvxg3J
         PujjEdMWeytopOKwXK2FVR+3TpKFTkIzVUAyJj9lJioHmlU/4hzZc6BXFsd/XGoFkkw4
         wAVw==
X-Gm-Message-State: AOJu0Yztb/0CcpMLvw1p8iNQtXr706CurcVZYzUQDqG16u6x2hueRXtK
	hQjzBVObDWN5fyEKOjGWIIeo6sk6Rv4=
X-Google-Smtp-Source: AGHT+IEYeGzh7Rqpvq/UzRCjmSyaT1N4RYte5KHhGT7uejte+4RT0mTyCcohGnEIbAmPsQAJTqKABQ==
X-Received: by 2002:ad4:576f:0:b0:66d:618a:b347 with SMTP id r15-20020ad4576f000000b0066d618ab347mr2716104qvx.14.1699464130192;
        Wed, 08 Nov 2023 09:22:10 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id qb1-20020ad44701000000b0065d03eae7a0sm1277003qvb.82.2023.11.08.09.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 09:22:10 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 10/10] auto-t: add DPP PKEX tests
Date: Wed,  8 Nov 2023 09:21:55 -0800
Message-Id: <20231108172155.2129509-11-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231108172155.2129509-1-prestwoj@gmail.com>
References: <20231108172155.2129509-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/testDPP/hostapd.conf |   2 +-
 autotests/testDPP/hw.conf      |   5 +-
 autotests/testDPP/pkex_test.py | 209 +++++++++++++++++++++++++++++++++
 autotests/testDPP/ssidCCMP.psk |  12 ++
 autotests/util/iwd.py          |  11 +-
 5 files changed, 231 insertions(+), 8 deletions(-)
 create mode 100644 autotests/testDPP/pkex_test.py

diff --git a/autotests/testDPP/hostapd.conf b/autotests/testDPP/hostapd.conf
index 074e8228..3611933c 100644
--- a/autotests/testDPP/hostapd.conf
+++ b/autotests/testDPP/hostapd.conf
@@ -1,5 +1,5 @@
 hw_mode=g
-channel=1
+channel=6
 ssid=ssidCCMP
 
 wpa=2
diff --git a/autotests/testDPP/hw.conf b/autotests/testDPP/hw.conf
index 923595ea..a2b1470e 100644
--- a/autotests/testDPP/hw.conf
+++ b/autotests/testDPP/hw.conf
@@ -1,5 +1,5 @@
 [SETUP]
-num_radios=3
+num_radios=4
 start_iwd=0
 hwsim_medium=yes
 
@@ -8,3 +8,6 @@ rad0=wpas.conf
 
 [HOSTAPD]
 rad1=hostapd.conf
+
+[NameSpaces]
+ns0=rad2
diff --git a/autotests/testDPP/pkex_test.py b/autotests/testDPP/pkex_test.py
new file mode 100644
index 00000000..a568e619
--- /dev/null
+++ b/autotests/testDPP/pkex_test.py
@@ -0,0 +1,209 @@
+#!/usr/bin/python3
+
+import unittest
+import sys
+
+sys.path.append('../util')
+from iwd import IWD, SharedCodeAgent
+from iwd import DeviceProvisioning
+from wpas import Wpas
+from hostapd import HostapdCLI
+from hwsim import Hwsim
+from config import ctx
+from time import time
+import os
+
+class Test(unittest.TestCase):
+    def start_wpas_pkex(self, code, curve=None, **kwargs):
+        self.wpas.dpp_bootstrap_gen(type='pkex', curve=curve)
+        self.wpas.dpp_pkex_add(code=code, **kwargs)
+        if kwargs.get('role', 'configurator') == 'configurator':
+            self.wpas.dpp_configurator_create()
+            self.wpas.dpp_listen(2437)
+
+    def start_iwd_pkex_configurator(self, device, agent=False):
+        self.hapd.reload()
+        self.hapd.wait_for_event('AP-ENABLED')
+
+        IWD.copy_to_storage('ssidCCMP.psk')
+        device.autoconnect = True
+
+        condition = 'obj.state == DeviceState.connected'
+        self.wd.wait_for_object_condition(device, condition)
+
+        if agent:
+            self.agent = SharedCodeAgent(codes = {"test": "secret123"})
+
+            device.dpp_pkex_start_configurator(self.agent.path)
+        else:
+            device.dpp_pkex_configure_enrollee('secret123', identifier="test")
+
+    def test_pkex_iwd_as_enrollee(self):
+        self.start_wpas_pkex('secret123', identifier="test")
+
+        self.device[0].dpp_pkex_enroll('secret123', identifier="test")
+
+        self.wpas.wait_for_event("DPP-AUTH-SUCCESS")
+
+    def test_pkex_iwd_as_enrollee_retransmit(self):
+        self.rule_reveal_req.enabled = True
+
+        self.start_wpas_pkex('secret123', identifier="test")
+
+        self.device[0].dpp_pkex_enroll('secret123', identifier="test")
+
+        self.wpas.wait_for_event("DPP-AUTH-SUCCESS")
+
+    def test_pkex_unsupported_version(self):
+        self.start_wpas_pkex('secret123', identifier="test", version=2)
+
+        now = time()
+        self.device[0].dpp_pkex_enroll('secret123', identifier="test")
+
+        condition = "obj.started == False"
+        self.wd.wait_for_object_condition(self.device[0]._sc_device_provisioning,
+                                            condition, max_wait=125)
+
+        # Check the enrollee stopped after 2 minutes
+        elapsed = time() - now
+        self.assertLess(elapsed, 125)
+
+    def test_pkex_configurator_timeout(self):
+        self.start_iwd_pkex_configurator(self.device[0])
+
+        now = time()
+
+        condition = "obj.started == False"
+        self.wd.wait_for_object_condition(self.device[0]._sc_device_provisioning,
+                                            condition, max_wait=125)
+
+        # Check the enrollee stopped after 2 minutes
+        elapsed = time() - now
+        self.assertLess(elapsed, 125)
+
+    def test_pkex_iwd_as_configurator(self):
+        self.start_iwd_pkex_configurator(self.device[0])
+
+        self.start_wpas_pkex('secret123', identifier="test", initiator=True,
+                                            role='enrollee')
+
+        self.wpas.wait_for_event("DPP-AUTH-SUCCESS")
+        self.wpas.wait_for_event("DPP-CONF-RECEIVED")
+
+    def test_pkex_iwd_as_configurator_retransmit(self):
+        self.rule_xchg_resp.enabled = True
+        self.rule_reveal_resp.enabled = True
+
+        self.start_iwd_pkex_configurator(self.device[0])
+
+        self.start_wpas_pkex('secret123', identifier="test", initiator=True,
+                                            role='enrollee')
+
+        self.wpas.wait_for_event("DPP-AUTH-SUCCESS")
+        self.wpas.wait_for_event("DPP-CONF-RECEIVED")
+
+    def test_pkex_iwd_as_configurator_bad_group(self):
+        self.start_iwd_pkex_configurator(self.device[0])
+
+        self.start_wpas_pkex('secret123', identifier="test", initiator=True,
+                                role='enrollee', curve='P-384')
+
+        self.wpas.wait_for_event(f"DPP-RX src={self.device[0].address} freq=2437 type=8")
+        self.wpas.wait_for_event("DPP-FAIL")
+
+    def test_pkex_iwd_to_iwd(self):
+        self.start_iwd_pkex_configurator(self.device[0])
+
+        self.device[1].dpp_pkex_enroll('secret123', identifier="test")
+
+        self.device[1].autoconnect = True
+
+        condition = 'obj.state == DeviceState.connected'
+        self.wd.wait_for_object_condition(self.device[1], condition)
+
+        self.assertTrue(os.path.exists('/tmp/ns0/ssidCCMP.psk'))
+
+        with open('/tmp/ns0/ssidCCMP.psk') as f:
+            data = f.read()
+
+        self.assertIn("SendHostname", data)
+        self.assertIn("SharedCode=secret123", data)
+        self.assertIn("ExactConfig=true", data)
+
+    def test_pkex_configurator_with_agent(self):
+        self.start_iwd_pkex_configurator(self.device[0], agent=True)
+
+        self.device[1].dpp_pkex_enroll('secret123', identifier="test")
+
+        self.device[1].autoconnect = True
+
+        condition = 'obj.state == DeviceState.connected'
+        self.wd.wait_for_object_condition(self.device[1], condition)
+
+        self.agent = None
+
+    def setUp(self):
+        ns0 = ctx.get_namespace('ns0')
+        self.wpas = Wpas('wpas.conf')
+
+        self.wd = IWD(True)
+        self.wd_ns0 = IWD(True, iwd_storage_dir='/tmp/ns0', namespace=ns0)
+        self.device = []
+        self.device.append(self.wd.list_devices(1)[0])
+        self.device.append(self.wd_ns0.list_devices(1)[0])
+        self.hapd = HostapdCLI('hostapd.conf')
+        self.hapd.disable()
+        self.hwsim = Hwsim()
+
+        self.rule_xchg_resp = self.hwsim.rules.create()
+        self.rule_xchg_resp.prefix = 'd0'
+        self.rule_xchg_resp.match_offset = 24
+        self.rule_xchg_resp.match = '04 09 50 6f 9a 1a 01 08'
+        self.rule_xchg_resp.match_times = 1
+        self.rule_xchg_resp.drop = True
+
+        self.rule_reveal_resp = self.hwsim.rules.create()
+        self.rule_reveal_resp.prefix = 'd0'
+        self.rule_reveal_resp.match_offset = 24
+        self.rule_reveal_resp.match = '04 09 50 6f 9a 1a 01 0a'
+        self.rule_reveal_resp.match_times = 1
+        self.rule_reveal_resp.drop = True
+
+        self.rule_reveal_req = self.hwsim.rules.create()
+        self.rule_reveal_req.prefix = 'd0'
+        self.rule_reveal_req.match_offset = 24
+        self.rule_reveal_req.match = '04 09 50 6f 9a 1a 01 09'
+        self.rule_reveal_req.match_times = 1
+        self.rule_reveal_req.drop = True
+
+    def tearDown(self):
+        # Tests end in various states, don't fail when tearing down.
+        try:
+            self.device[0].disconnect()
+            self.device[0].dpp_pkex_stop()
+            self.device[1].disconnect()
+            self.device[1].dpp_pkex_stop()
+        except:
+            pass
+
+        self.wpas.dpp_configurator_remove()
+        self.wpas.clean_up()
+
+        self.wd = None
+        self.wd_ns0 = None
+        self.device = None
+        self.wpas = None
+        self.hapd = None
+        self.rule_xchg_resp = None
+        IWD.clear_storage()
+
+    @classmethod
+    def setUpClass(cls):
+        pass
+
+    @classmethod
+    def tearDownClass(cls):
+        pass
+
+if __name__ == '__main__':
+    unittest.main(exit=True)
\ No newline at end of file
diff --git a/autotests/testDPP/ssidCCMP.psk b/autotests/testDPP/ssidCCMP.psk
index abafdb66..d428fd34 100644
--- a/autotests/testDPP/ssidCCMP.psk
+++ b/autotests/testDPP/ssidCCMP.psk
@@ -1,2 +1,14 @@
 [Security]
 Passphrase=secret123
+
+[DeviceProvisioning]
+SharedCode=secret123
+SharedCodeIdentifier=test
+ExactConfig=true
+
+[IPv4]
+SendHostname=true
+
+[Settings]
+AutoConnect=true
+Hidden=false
diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index c0ce0817..3f200beb 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -230,6 +230,11 @@ class SharedCodeAgent(dbus.service.Object):
     def Release(self):
         print("SharedCodeAgent released")
 
+    @dbus.service.method(IWD_SHARED_CODE_AGENT_INTERFACE,
+                         in_signature='s', out_signature='')
+    def Cancel(self, reason):
+        print("SharedCodeAgent canceled (%s)" % reason)
+
     @dbus.service.method(IWD_SHARED_CODE_AGENT_INTERFACE,
                          in_signature='s', out_signature='s')
     def RequestSharedCode(self, identifier):
@@ -357,12 +362,6 @@ class SharedCodeDeviceProvisioning(IWDDBusAbstract):
     def stop(self):
         self._iface.Stop()
 
-    def register_agent(self, path):
-        self._iface.RegisterSharedCodeAgent(path)
-
-    def unregister_agent(self):
-        self._iface.UnregisterSharedCodeAgent()
-
     @property
     def started(self):
         return self._properties['Started']
-- 
2.25.1

