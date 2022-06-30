Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC35F7469
	for <iwd@lists.linux.dev>; Thu, 30 Jun 2022 18:06:09 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id r66so86668pgr.2
        for <iwd@lists.linux.dev>; Thu, 30 Jun 2022 11:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lTbYUt8xK8Nfxr3ffET+JWtFWhTFZwAYpqgi+z6sjP4=;
        b=oYnq/63Nw35NwiO9syynGKPsWIOfpFjpeX7kSzcc7VyprTT8EObyJtD6ytKKzdOEcn
         sSmz5kLv+opCOEaClLq1imS2rNk88rQb+aZr0XRad6Vn6wLEE5XGxAtzNMR9jBb/3wZO
         5ULJgJZo28Yy+XDbn0WwgNwu8DM4SQutm/tmWrjEseRAwM5sFfLlHxXH+3vjpuIje0Ln
         PA3pSGSaosQxLJFvPpmt0TIA3/lUiDFTQOhP3xSWnagl9vB1tSeCH3TD11A9bAho91a8
         yG7YJnS8+IEb5RhgDaiKX25rA1W1ydjrbOiP2g2Cl4SpYwjxvZlwU+PigOHGhweRwjKo
         Yy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lTbYUt8xK8Nfxr3ffET+JWtFWhTFZwAYpqgi+z6sjP4=;
        b=TVpckSNN8NjsV3kOOMOXmN9XbJlpan35wr/Qx85IQgEJUw3vNEJ8Mk4kGWxqOITYJ4
         XMXqYH3+pMUEx0b3b1cTWVUxlbasvUZNnzmlNrR7poy707YxrUqriA2QboqnHk1G24TX
         hm3+HfPnmn2PdsjCV4v0LI+ZlXkVs4GKYb/2DfsLbw/D58hJhYphVb/n6EiCYnYwgVJK
         5EhY+dDKDekYGJhBi99Q3dCgDxS6UOIQd8Rsa1VdaIso4jT+6EBbBtMTVp4d79e5bEM5
         6agT5IuZcGn3p8brfRv64/Sz6DuR2vkrtcsQa7ExhEc8Yr0wZzq2v8a/45KGehXNc3Lg
         1bvg==
X-Gm-Message-State: AJIora915ii/D3Md0sEmI55LBUOuFANYElg4tmn0nyIVeHfQwFEgxPln
	+tZeZMHc+uSvrljUw86jp/t9jnx6JkM=
X-Google-Smtp-Source: AGRyM1uPpR0IL73Eq61UgyxUCwuvyncLBJpHm7IFLZL9POsqqbSIyQFKYcnwo9cImXbhKNl7DsUHYA==
X-Received: by 2002:a65:668b:0:b0:3f6:4026:97cd with SMTP id b11-20020a65668b000000b003f6402697cdmr8570489pgw.420.1656612369013;
        Thu, 30 Jun 2022 11:06:09 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902680600b00163ffe73300sm13777187plk.137.2022.06.30.11.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 11:06:08 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/7] auto-t: refactor testAP to reuse code
Date: Thu, 30 Jun 2022 11:03:30 -0700
Message-Id: <20220630180331.206419-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220630180331.206419-1-prestwoj@gmail.com>
References: <20220630180331.206419-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All the AP tests were basically doing the same validation. Refactor
this code into validation.py and import that into the tests.
---
 autotests/testAP/connection_test.py  | 74 ++--------------------------
 autotests/testAP/dhcp_config_test.py | 49 ++----------------
 autotests/testAP/dhcp_test.py        | 69 +++++++++-----------------
 autotests/testAP/validation.py       | 71 ++++++++++++++++++++++++++
 4 files changed, 102 insertions(+), 161 deletions(-)
 create mode 100644 autotests/testAP/validation.py

diff --git a/autotests/testAP/connection_test.py b/autotests/testAP/connection_test.py
index 02213947..273c333c 100644
--- a/autotests/testAP/connection_test.py
+++ b/autotests/testAP/connection_test.py
@@ -1,90 +1,24 @@
 #! /usr/bin/python3
 
 import unittest
-import sys, os
 
-import iwd
 from iwd import IWD
-from iwd import PSKAgent
-from iwd import NetworkType
-from hostapd import HostapdCLI
-import testutil
+from validation import validate, client_connect
 
 class Test(unittest.TestCase):
-
-    def client_connect(self, wd, dev):
-        hostapd = HostapdCLI(config='psk-ccmp.conf')
-
-        ordered_network = dev.get_ordered_network('TestAP1')
-
-        self.assertEqual(ordered_network.type, NetworkType.psk)
-
-        psk_agent = PSKAgent('Password1')
-        wd.register_psk_agent(psk_agent)
-
-        ordered_network.network_object.connect()
-
-        condition = 'obj.state == DeviceState.connected'
-        wd.wait_for_object_condition(dev, condition)
-
-        wd.unregister_psk_agent(psk_agent)
-
-        testutil.test_iface_operstate(dev.name)
-        testutil.test_ifaces_connected(hostapd.ifname, dev.name)
-
-        dev.disconnect()
-
-        condition = 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condition)
-
     def test_connection_success(self):
         wd = IWD(True)
 
         dev1, dev2 = wd.list_devices(2)
 
-        self.client_connect(wd, dev1)
+        client_connect(wd, dev1, 'TestAP1')
 
         dev1.start_ap('TestAP2', 'Password2')
 
-        try:
-            networks = {}
-            networks['TestAP1'] = dev2.get_ordered_network('TestAP1', full_scan=True)
-            networks['TestAP2'] = dev2.get_ordered_network('TestAP2', full_scan=True)
-
-            self.assertEqual(networks['TestAP1'].type, NetworkType.psk)
-            self.assertEqual(networks['TestAP2'].type, NetworkType.psk)
-
-            psk_agent = PSKAgent('Password2')
-            wd.register_psk_agent(psk_agent)
-
-            try:
-                dev2.disconnect()
-
-                condition = 'not obj.connected'
-                wd.wait_for_object_condition(dev2, condition)
-            except:
-                pass
-
-            networks['TestAP2'].network_object.connect()
-
-            condition = 'obj.state == DeviceState.connected'
-            wd.wait_for_object_condition(dev2, condition)
-
-            testutil.test_iface_operstate(dev2.name)
-            testutil.test_ifaces_connected(dev1.name, dev2.name, group=False)
-
-            wd.unregister_psk_agent(psk_agent)
-
-            dev2.disconnect()
-
-            condition = 'not obj.connected'
-            wd.wait_for_object_condition(networks['TestAP2'].network_object,
-                                         condition)
-        finally:
-            dev1.stop_ap()
+        validate(wd, dev2, dev1, 'TestAP2', 'Password2')
 
         # Finally test dev1 can go to client mode and connect again
-        self.client_connect(wd, dev1)
+        client_connect(wd, dev1, 'TestAP1')
 
     @classmethod
     def setUpClass(cls):
diff --git a/autotests/testAP/dhcp_config_test.py b/autotests/testAP/dhcp_config_test.py
index ac3a95ba..2c75d071 100644
--- a/autotests/testAP/dhcp_config_test.py
+++ b/autotests/testAP/dhcp_config_test.py
@@ -1,14 +1,10 @@
 #! /usr/bin/python3
 
 import unittest
-import sys, os
 
-import iwd
 from iwd import IWD
-from iwd import PSKAgent
-from iwd import NetworkType
 from config import ctx
-import testutil
+from validation import validate
 
 class Test(unittest.TestCase):
     def test_connection_success(self):
@@ -28,47 +24,8 @@ class Test(unittest.TestCase):
 
         dev1.start_ap('APConfig')
 
-        try:
-            networks = {}
-            networks['APConfig'] = dev2.get_ordered_network('APConfig', full_scan=True)
-
-            self.assertEqual(networks['APConfig'].type, NetworkType.psk)
-
-            psk_agent = PSKAgent('password123')
-            wd.register_psk_agent(psk_agent)
-
-            try:
-                dev2.disconnect()
-
-                condition = 'not obj.connected'
-                wd.wait_for_object_condition(dev2, condition)
-            except:
-                pass
-
-            networks['APConfig'].network_object.connect()
-
-            condition = 'obj.state == DeviceState.connected'
-            wd.wait_for_object_condition(dev2, condition)
-
-            testutil.test_iface_operstate(dev2.name)
-            #
-            # TODO: cannot yet check the AP interface IP since its in a
-            #       different namespace.
-            #
-            testutil.test_ip_address_match(dev2.name, "192.168.1.3")
-
-            testutil.test_ip_connected(('192.168.1.3', ctx), ('192.168.1.1', ns0))
-
-            wd.unregister_psk_agent(psk_agent)
-
-            dev2.disconnect()
-
-            condition = 'not obj.connected'
-            wd.wait_for_object_condition(networks['APConfig'].network_object,
-                                         condition)
-
-        finally:
-            dev1.stop_ap()
+        validate(wd, dev2, dev1, 'APConfig', 'password123',
+                    sta_ip_info=('192.168.1.3', ctx), ap_ip_info=('192.168.1.1', ns0))
 
     @classmethod
     def setUpClass(cls):
diff --git a/autotests/testAP/dhcp_test.py b/autotests/testAP/dhcp_test.py
index a8f89eb0..aa50fdb4 100644
--- a/autotests/testAP/dhcp_test.py
+++ b/autotests/testAP/dhcp_test.py
@@ -10,6 +10,8 @@ from iwd import NetworkType
 from config import ctx
 import testutil
 
+from validation import validate
+
 class Test(unittest.TestCase):
     def test_connection_success(self):
         wd = IWD(True, '/tmp/dhcp')
@@ -25,59 +27,36 @@ class Test(unittest.TestCase):
         with self.assertRaises(iwd.AlreadyExistsEx):
             dev4.start_ap('TestAP4', 'Password4')
 
-        try:
-            networks = {}
-            networks['TestAP2'] = dev2.get_ordered_network('TestAP2', full_scan=True)
-
-            self.assertEqual(networks['TestAP2'].type, NetworkType.psk)
-
-            psk_agent = PSKAgent('Password2')
-            wd.register_psk_agent(psk_agent)
-
-            try:
-                dev2.disconnect()
-
-                condition = 'not obj.connected'
-                wd.wait_for_object_condition(dev2, condition)
-            except:
-                pass
+        validate(wd, dev2, dev1, 'TestAP2', 'Password2', ip_checks=False)
 
-            networks['TestAP2'].network_object.connect()
+        network = dev2.get_ordered_network('TestAP2', full_scan=True)
 
-            condition = 'obj.state == DeviceState.connected'
-            wd.wait_for_object_condition(dev2, condition)
-
-            testutil.test_iface_operstate(dev2.name)
-            testutil.test_ifaces_connected(dev1.name, dev2.name, group=False)
-
-            try:
-                testutil.test_ip_address_match(dev1.name, "192.168.80.1")
-                testutil.test_ip_address_match(dev2.name, "192.168.80.2")
-                ip = "192.168.80.1"
-            except:
-                testutil.test_ip_address_match(dev1.name, "192.168.80.17")
-                testutil.test_ip_address_match(dev2.name, "192.168.80.18")
-                ip = "192.168.80.17"
-
-            wd.unregister_psk_agent(psk_agent)
+        try:
+            testutil.test_ip_address_match(dev1.name, "192.168.80.1")
+            testutil.test_ip_address_match(dev2.name, "192.168.80.2")
+            ip = "192.168.80.1"
+        except:
+            testutil.test_ip_address_match(dev1.name, "192.168.80.17")
+            testutil.test_ip_address_match(dev2.name, "192.168.80.18")
+            ip = "192.168.80.17"
 
-            dev2.disconnect()
+        dev2.disconnect()
 
-            condition = 'not obj.connected'
-            wd.wait_for_object_condition(networks['TestAP2'].network_object,
-                                         condition)
+        condition = 'not obj.connected'
+        wd.wait_for_object_condition(network.network_object, condition)
 
-            # This should release the IP */
-            dev1.stop_ap()
+        # This should release the IP */
+        dev1.stop_ap()
 
-            # This should now succeed and the IP should match the old IP dev1
-            # got initially.
-            dev4.start_ap('TestAP4', 'Password4')
+        # This should now succeed and the IP should match the old IP dev1
+        # got initially.
+        dev4.start_ap('TestAP4', 'Password4')
 
-            testutil.test_ip_address_match(dev4.name, ip)
+        testutil.test_ip_address_match(dev4.name, ip)
 
-        finally:
-            dev1.stop_ap()
+        dev1.stop_ap()
+        dev3.stop_ap()
+        dev4.stop_ap()
 
     @classmethod
     def setUpClass(cls):
diff --git a/autotests/testAP/validation.py b/autotests/testAP/validation.py
new file mode 100644
index 00000000..b1b867ef
--- /dev/null
+++ b/autotests/testAP/validation.py
@@ -0,0 +1,71 @@
+from iwd import PSKAgent
+from iwd import NetworkType
+from hostapd import HostapdCLI
+import testutil
+
+def validate(wd, sta_dev, ap_dev, ssid, passphrase,
+                sta_ip_info=None, ap_ip_info=None, ip_checks=True):
+    try:
+        network = sta_dev.get_ordered_network(ssid, full_scan=True)
+
+        if network.type != NetworkType.psk:
+            raise Exception("Network type mismatch")
+
+        psk_agent = PSKAgent(passphrase)
+        wd.register_psk_agent(psk_agent)
+
+        network.network_object.connect()
+
+        condition = 'obj.state == DeviceState.connected'
+        wd.wait_for_object_condition(sta_dev, condition)
+
+        testutil.test_iface_operstate(sta_dev.name)
+
+        # This implies separate namespaces so the iface names won't exist
+        if not sta_ip_info or not ap_ip_info:
+            testutil.test_ifaces_connected(ap_dev.name, sta_dev.name, group=False)
+
+        if not ip_checks:
+            return
+
+        if sta_ip_info:
+            testutil.test_ip_address_match(sta_dev.name, sta_ip_info[0])
+
+        if sta_ip_info and ap_ip_info:
+            testutil.test_ip_connected(sta_ip_info, ap_ip_info)
+
+        wd.unregister_psk_agent(psk_agent)
+
+        sta_dev.disconnect()
+
+        condition = 'not obj.connected'
+        wd.wait_for_object_condition(network.network_object, condition)
+    finally:
+        if ip_checks:
+            ap_dev.stop_ap()
+
+def client_connect(wd, dev, ssid):
+    hostapd = HostapdCLI(config='psk-ccmp.conf')
+
+    ordered_network = dev.get_ordered_network(ssid)
+
+    if ordered_network.type != NetworkType.psk:
+        raise Exception("Network type mismatch")
+
+    psk_agent = PSKAgent('Password1')
+    wd.register_psk_agent(psk_agent)
+
+    ordered_network.network_object.connect()
+
+    condition = 'obj.state == DeviceState.connected'
+    wd.wait_for_object_condition(dev, condition)
+
+    wd.unregister_psk_agent(psk_agent)
+
+    testutil.test_iface_operstate(dev.name)
+    testutil.test_ifaces_connected(hostapd.ifname, dev.name)
+
+    dev.disconnect()
+
+    condition = 'not obj.connected'
+    wd.wait_for_object_condition(ordered_network.network_object, condition)
-- 
2.34.1

