Content-Type: multipart/mixed; boundary="===============4007896352286376603=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/8] auto-t: combine testBSSBlacklist tests
Date: Wed, 18 Aug 2021 15:09:32 -0700
Message-ID: <20210818220934.295721-6-prestwoj@gmail.com>
In-Reply-To: <20210818220934.295721-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4007896352286376603==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

All 4 tests were combined to reuse hwsim rule code, and improve
cleanup between running tests.
---
 .../testBSSBlacklist/all_blacklisted_test.py  |  97 --------
 autotests/testBSSBlacklist/bad_pass_test.py   |  90 -------
 autotests/testBSSBlacklist/connection_test.py | 220 +++++++++++++++---
 .../testBSSBlacklist/temp_blacklist_test.py   | 116 ---------
 4 files changed, 192 insertions(+), 331 deletions(-)
 delete mode 100644 autotests/testBSSBlacklist/all_blacklisted_test.py
 delete mode 100644 autotests/testBSSBlacklist/bad_pass_test.py
 delete mode 100644 autotests/testBSSBlacklist/temp_blacklist_test.py

diff --git a/autotests/testBSSBlacklist/all_blacklisted_test.py b/autotests=
/testBSSBlacklist/all_blacklisted_test.py
deleted file mode 100644
index 4d8cca1e..00000000
--- a/autotests/testBSSBlacklist/all_blacklisted_test.py
+++ /dev/null
@@ -1,97 +0,0 @@
-#!/usr/bin/python3
-
-import unittest
-import sys
-
-sys.path.append('../util')
-import iwd
-from iwd import IWD
-from iwd import PSKAgent
-from iwd import NetworkType
-
-from hostapd import HostapdCLI
-from hwsim import Hwsim
-
-class Test(unittest.TestCase):
-
-    def test_connection_success(self):
-        hwsim =3D Hwsim()
-
-        bss_hostapd =3D [ HostapdCLI(config=3D'ssid1.conf'),
-                        HostapdCLI(config=3D'ssid2.conf'),
-                        HostapdCLI(config=3D'ssid3.conf') ]
-        bss_radio =3D  [ hwsim.get_radio('rad0'),
-                       hwsim.get_radio('rad1'),
-                       hwsim.get_radio('rad2') ]
-
-        rule0 =3D hwsim.rules.create()
-        rule0.source =3D bss_radio[0].addresses[0]
-        rule0.bidirectional =3D True
-        rule0.signal =3D -2000
-
-        rule1 =3D hwsim.rules.create()
-        rule1.source =3D bss_radio[1].addresses[0]
-        rule1.bidirectional =3D True
-        rule1.signal =3D -8000
-
-        rule2 =3D hwsim.rules.create()
-        rule2.source =3D bss_radio[2].addresses[0]
-        rule2.bidirectional =3D True
-        rule2.signal =3D -9000
-
-        wd =3D IWD(True)
-
-        psk_agent =3D PSKAgent(["secret123", 'secret123'])
-        wd.register_psk_agent(psk_agent)
-
-        devices =3D wd.list_devices(1)
-        device =3D devices[0]
-
-        ordered_network =3D device.get_ordered_network("TestBlacklist")
-
-        self.assertEqual(ordered_network.type, NetworkType.psk)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        # Have both APs drop all packets, both should get blacklisted
-        rule0.drop =3D True
-        rule1.drop =3D True
-        rule2.drop =3D True
-
-        with self.assertRaises(iwd.FailedEx):
-            ordered_network.network_object.connect()
-
-        rule0.drop =3D False
-        rule1.drop =3D False
-        rule2.drop =3D False
-
-        # Wait for scanning (likely a quick-scan) to finish, otherwise we =
will
-        # may not have all BSS's in the list.
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        # This connect should work
-        ordered_network.network_object.connect()
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        self.assertIn(device.address, bss_hostapd[0].list_sta())
-
-        wd.unregister_psk_agent(psk_agent)
-
-        rule0.remove()
-        rule1.remove()
-        rule2.remove()
-
-    @classmethod
-    def setUpClass(cls):
-        pass
-
-    @classmethod
-    def tearDownClass(cls):
-        IWD.clear_storage()
-
-if __name__ =3D=3D '__main__':
-    unittest.main(exit=3DTrue)
diff --git a/autotests/testBSSBlacklist/bad_pass_test.py b/autotests/testBS=
SBlacklist/bad_pass_test.py
deleted file mode 100644
index 5ea5df0c..00000000
--- a/autotests/testBSSBlacklist/bad_pass_test.py
+++ /dev/null
@@ -1,90 +0,0 @@
-#!/usr/bin/python3
-
-import unittest
-import sys
-
-sys.path.append('../util')
-import iwd
-from iwd import IWD
-from iwd import PSKAgent
-from iwd import NetworkType
-
-from hostapd import HostapdCLI
-from hwsim import Hwsim
-
-class Test(unittest.TestCase):
-
-    def test_connection_success(self):
-        hwsim =3D Hwsim()
-
-        bss_hostapd =3D [ HostapdCLI(config=3D'ssid1.conf'),
-                        HostapdCLI(config=3D'ssid2.conf'),
-                        HostapdCLI(config=3D'ssid3.conf') ]
-        bss_radio =3D  [ hwsim.get_radio('rad0'),
-                       hwsim.get_radio('rad1'),
-                       hwsim.get_radio('rad2') ]
-
-        rule0 =3D hwsim.rules.create()
-        rule0.source =3D bss_radio[0].addresses[0]
-        rule0.bidirectional =3D True
-        rule0.signal =3D -2000
-
-        rule1 =3D hwsim.rules.create()
-        rule1.source =3D bss_radio[1].addresses[0]
-        rule1.bidirectional =3D True
-        rule1.signal =3D -7000
-
-        rule2 =3D hwsim.rules.create()
-        rule2.source =3D bss_radio[2].addresses[0]
-        rule2.bidirectional =3D True
-        rule2.signal =3D -8000
-
-        wd =3D IWD(True)
-
-        psk_agent =3D PSKAgent("wrong_password")
-        wd.register_psk_agent(psk_agent)
-
-        devices =3D wd.list_devices(1)
-        device =3D devices[0]
-
-        ordered_network =3D device.get_ordered_network("TestBlacklist")
-
-        self.assertEqual(ordered_network.type, NetworkType.psk)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        with self.assertRaises(iwd.FailedEx):
-            ordered_network.network_object.connect()
-
-        wd.unregister_psk_agent(psk_agent)
-
-        psk_agent =3D PSKAgent("secret123")
-        wd.register_psk_agent(psk_agent)
-
-        ordered_network.network_object.connect()
-
-        # We failed to connect bss_hostapd[0], but with a bad password. Ve=
rify
-        # that this did not trigger a blacklist and that we did reconnect
-        # successfully to bss_hostapd[0]
-        self.assertIn(device.address, bss_hostapd[0].list_sta())
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        wd.unregister_psk_agent(psk_agent)
-
-        rule0.remove()
-        rule1.remove()
-        rule2.remove()
-
-    @classmethod
-    def setUpClass(cls):
-        pass
-
-    @classmethod
-    def tearDownClass(cls):
-        IWD.clear_storage()
-
-if __name__ =3D=3D '__main__':
-    unittest.main(exit=3DTrue)
diff --git a/autotests/testBSSBlacklist/connection_test.py b/autotests/test=
BSSBlacklist/connection_test.py
index 407ee06a..bfcf0523 100644
--- a/autotests/testBSSBlacklist/connection_test.py
+++ b/autotests/testBSSBlacklist/connection_test.py
@@ -8,6 +8,7 @@ import iwd
 from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
+from iwd import IWD_CONFIG_DIR
 =

 from hostapd import HostapdCLI
 from hwsim import Hwsim
@@ -15,33 +16,166 @@ from hwsim import Hwsim
 import time
 =

 class Test(unittest.TestCase):
+    def test_temp_blacklist(self):
+        rule0 =3D self.rule0
+        rule1 =3D self.rule1
+        rule2 =3D self.rule2
 =

-    def test_connection_success(self):
-        hwsim =3D Hwsim()
-
-        bss_hostapd =3D [ HostapdCLI(config=3D'ssid1.conf'),
-                        HostapdCLI(config=3D'ssid2.conf'),
-                        HostapdCLI(config=3D'ssid3.conf') ]
-        bss_radio =3D  [ hwsim.get_radio('rad0'),
-                       hwsim.get_radio('rad1'),
-                       hwsim.get_radio('rad2') ]
-
-        rule0 =3D hwsim.rules.create()
-        rule0.source =3D bss_radio[0].addresses[0]
-        rule0.bidirectional =3D True
-        rule0.signal =3D -2000
-
-        rule1 =3D hwsim.rules.create()
-        rule1.source =3D bss_radio[1].addresses[0]
-        rule1.bidirectional =3D True
+        bss_hostapd =3D self.bss_hostapd
+        wd =3D self.wd
+
+        rule0.signal =3D -8000
         rule1.signal =3D -7000
+        rule2.signal =3D -2000
+
+        psk_agent =3D PSKAgent("secret123")
+        wd.register_psk_agent(psk_agent)
+
+        dev1, dev2 =3D wd.list_devices(2)
+
+        ordered_network =3D dev1.get_ordered_network("TestBlacklist")
+
+        self.assertEqual(ordered_network.type, NetworkType.psk)
+
+        condition =3D 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+
+        ordered_network.network_object.connect()
+
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(dev1, condition)
+
+        self.assertIn(dev1.address, bss_hostapd[2].list_sta())
+
+        # dev1 now connected, this should max out the first AP, causing th=
e next
+        # connection to fail to this AP.
+
+        ordered_network =3D dev2.get_ordered_network("TestBlacklist")
+
+        self.assertEqual(ordered_network.type, NetworkType.psk)
+
+        condition =3D 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+
+        ordered_network.network_object.connect()
+
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(dev2, condition)
+
+        # We should have temporarily blacklisted the first BSS, and connec=
ted
+        # to this one.
+        self.assertIn(dev2.address, bss_hostapd[1].list_sta())
+
+        # Now check that the first BSS is still not blacklisted. We can
+        # disconnect dev1, opening up the AP for more connections
+        dev1.disconnect()
+        dev2.disconnect()
+
+        ordered_network =3D dev2.get_ordered_network("TestBlacklist")
+
+        self.assertEqual(ordered_network.type, NetworkType.psk)
+
+        condition =3D 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+
+        ordered_network.network_object.connect()
+
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(dev2, condition)
+
+        self.assertIn(dev2.address, bss_hostapd[2].list_sta())
+
+        wd.unregister_psk_agent(psk_agent)
+
+    def test_all_blacklisted(self):
+        wd =3D self.wd
+        bss_hostapd =3D self.bss_hostapd
+
+        rule0 =3D self.rule0
+        rule1 =3D self.rule1
+        rule2 =3D self.rule2
+
+        psk_agent =3D PSKAgent(["secret123", 'secret123'])
+        wd.register_psk_agent(psk_agent)
+
+        devices =3D wd.list_devices(1)
+        device =3D devices[0]
+
+        ordered_network =3D device.get_ordered_network("TestBlacklist")
+
+        self.assertEqual(ordered_network.type, NetworkType.psk)
+
+        condition =3D 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+
+        # Have both APs drop all packets, both should get blacklisted
+        rule0.drop =3D True
+        rule1.drop =3D True
+        rule2.drop =3D True
+
+        with self.assertRaises(iwd.FailedEx):
+            ordered_network.network_object.connect()
+
+        rule0.drop =3D False
+        rule1.drop =3D False
+        rule2.drop =3D False
+
+        # Wait for scanning (likely a quick-scan) to finish, otherwise we =
will
+        # may not have all BSS's in the list.
+        condition =3D 'not obj.scanning'
+        wd.wait_for_object_condition(device, condition)
+
+        # This connect should work
+        ordered_network.network_object.connect()
+
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
+        self.assertIn(device.address, bss_hostapd[0].list_sta())
+
+        wd.unregister_psk_agent(psk_agent)
+
+    def test_invalid_password(self):
+        wd =3D self.wd
+        bss_hostapd =3D self.bss_hostapd
+
+        psk_agent =3D PSKAgent("wrong_password")
+        wd.register_psk_agent(psk_agent)
+
+        devices =3D wd.list_devices(1)
+        device =3D devices[0]
 =

-        rule2 =3D hwsim.rules.create()
-        rule2.source =3D bss_radio[2].addresses[0]
-        rule2.bidirectional =3D True
-        rule2.signal =3D -8000
+        ordered_network =3D device.get_ordered_network("TestBlacklist")
+
+        self.assertEqual(ordered_network.type, NetworkType.psk)
+
+        condition =3D 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+
+        with self.assertRaises(iwd.FailedEx):
+            ordered_network.network_object.connect()
+
+        wd.unregister_psk_agent(psk_agent)
+
+        psk_agent =3D PSKAgent("secret123")
+        wd.register_psk_agent(psk_agent)
+
+        ordered_network.network_object.connect()
+
+        # We failed to connect bss_hostapd[0], but with a bad password. Ve=
rify
+        # that this did not trigger a blacklist and that we did reconnect
+        # successfully to bss_hostapd[0]
+        self.assertIn(device.address, bss_hostapd[0].list_sta())
 =

-        wd =3D IWD(True)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
+        wd.unregister_psk_agent(psk_agent)
+
+    def test_connection_success(self):
+        wd =3D self.wd
+        bss_hostapd =3D self.bss_hostapd
+        rule0 =3D self.rule0
 =

         psk_agent =3D PSKAgent("secret123")
         wd.register_psk_agent(psk_agent)
@@ -129,19 +263,49 @@ class Test(unittest.TestCase):
 =

         self.assertIn(device.address, bss_hostapd[0].list_sta())
 =

-        wd.unregister_psk_agent(psk_agent)
+        self.wd.unregister_psk_agent(psk_agent)
 =

-        rule0.remove()
-        rule1.remove()
-        rule2.remove()
+    def setUp(self):
+        self.wd =3D IWD(True)
+
+    def tearDown(self):
+        IWD.clear_storage()
+        self.wd =3D None
 =

     @classmethod
     def setUpClass(cls):
-        IWD.copy_to_storage('main.conf')
+        cls.hwsim =3D Hwsim()
+
+        cls.bss_hostapd =3D [ HostapdCLI(config=3D'ssid1.conf'),
+                            HostapdCLI(config=3D'ssid2.conf'),
+                            HostapdCLI(config=3D'ssid3.conf') ]
+        cls.bss_radio =3D  [ cls.hwsim.get_radio('rad0'),
+                       cls.hwsim.get_radio('rad1'),
+                       cls.hwsim.get_radio('rad2') ]
+
+        cls.rule0 =3D cls.hwsim.rules.create()
+        cls.rule0.source =3D cls.bss_radio[0].addresses[0]
+        cls.rule0.bidirectional =3D True
+        cls.rule0.signal =3D -2000
+        cls.rule0.enabled =3D True
+
+        cls.rule1 =3D cls.hwsim.rules.create()
+        cls.rule1.source =3D cls.bss_radio[1].addresses[0]
+        cls.rule1.bidirectional =3D True
+        cls.rule1.signal =3D -7000
+        cls.rule1.enabled =3D True
+
+        cls.rule2 =3D cls.hwsim.rules.create()
+        cls.rule2.source =3D cls.bss_radio[2].addresses[0]
+        cls.rule2.bidirectional =3D True
+        cls.rule2.signal =3D -8000
+        cls.rule2.enabled =3D True
 =

     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
 =

+        cls.hwsim.rules.remove_all()
+
 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
diff --git a/autotests/testBSSBlacklist/temp_blacklist_test.py b/autotests/=
testBSSBlacklist/temp_blacklist_test.py
deleted file mode 100644
index cbd07ad2..00000000
--- a/autotests/testBSSBlacklist/temp_blacklist_test.py
+++ /dev/null
@@ -1,116 +0,0 @@
-#!/usr/bin/python3
-
-import unittest
-import sys
-
-sys.path.append('../util')
-import iwd
-from iwd import IWD
-from iwd import PSKAgent
-from iwd import NetworkType
-
-from hostapd import HostapdCLI
-from hwsim import Hwsim
-
-class Test(unittest.TestCase):
-
-    def test_connection_success(self):
-        hwsim =3D Hwsim()
-
-        bss_hostapd =3D [ HostapdCLI(config=3D'ssid1.conf'),
-                        HostapdCLI(config=3D'ssid2.conf'),
-                        HostapdCLI(config=3D'ssid3.conf') ]
-        bss_radio =3D  [ hwsim.get_radio('rad0'),
-                       hwsim.get_radio('rad1'),
-                       hwsim.get_radio('rad2') ]
-
-        rule0 =3D hwsim.rules.create()
-        rule0.source =3D bss_radio[0].addresses[0]
-        rule0.bidirectional =3D True
-        rule0.signal =3D -8000
-
-        rule1 =3D hwsim.rules.create()
-        rule1.source =3D bss_radio[1].addresses[0]
-        rule1.bidirectional =3D True
-        rule1.signal =3D -7000
-
-        rule2 =3D hwsim.rules.create()
-        rule2.source =3D bss_radio[2].addresses[0]
-        rule2.bidirectional =3D True
-        rule2.signal =3D -2000
-
-        wd =3D IWD(True)
-
-        psk_agent =3D PSKAgent("secret123")
-        wd.register_psk_agent(psk_agent)
-
-        dev1, dev2 =3D wd.list_devices(2)
-
-        ordered_network =3D dev1.get_ordered_network("TestBlacklist")
-
-        self.assertEqual(ordered_network.type, NetworkType.psk)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        ordered_network.network_object.connect()
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(dev1, condition)
-
-        self.assertIn(dev1.address, bss_hostapd[2].list_sta())
-
-        # dev1 now connected, this should max out the first AP, causing th=
e next
-        # connection to fail to this AP.
-
-        ordered_network =3D dev2.get_ordered_network("TestBlacklist")
-
-        self.assertEqual(ordered_network.type, NetworkType.psk)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        ordered_network.network_object.connect()
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(dev2, condition)
-
-        # We should have temporarily blacklisted the first BSS, and connec=
ted
-        # to this one.
-        self.assertIn(dev2.address, bss_hostapd[1].list_sta())
-
-        # Now check that the first BSS is still not blacklisted. We can
-        # disconnect dev1, opening up the AP for more connections
-        dev1.disconnect()
-        dev2.disconnect()
-
-        ordered_network =3D dev2.get_ordered_network("TestBlacklist")
-
-        self.assertEqual(ordered_network.type, NetworkType.psk)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        ordered_network.network_object.connect()
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(dev2, condition)
-
-        self.assertIn(dev2.address, bss_hostapd[2].list_sta())
-
-        wd.unregister_psk_agent(psk_agent)
-
-        rule0.remove()
-        rule1.remove()
-        rule2.remove()
-
-    @classmethod
-    def setUpClass(cls):
-        IWD.copy_to_storage('main.conf')
-
-    @classmethod
-    def tearDownClass(cls):
-        IWD.clear_storage()
-
-if __name__ =3D=3D '__main__':
-    unittest.main(exit=3DTrue)
-- =

2.31.1

--===============4007896352286376603==--

