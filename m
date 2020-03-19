Content-Type: multipart/mixed; boundary="===============3993447935261664577=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/4] auto-t: add test for AddressRandomization option
Date: Thu, 19 Mar 2020 15:02:04 -0700
Message-ID: <20200319220204.11978-4-prestwoj@gmail.com>
In-Reply-To: <20200319220204.11978-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3993447935261664577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Tests all cases of AddressRandomization=3Dnetwork

1. Deterministic generation per-network (default)
2. Full randomization per-network
3. Address override per-network
---
 .../connection_test.py                        | 86 +++++++++++++++++++
 .../testAddressRandomization/full_random.psk  |  6 ++
 autotests/testAddressRandomization/hw.conf    |  7 ++
 autotests/testAddressRandomization/main.conf  |  2 +
 .../testAddressRandomization/override.psk     |  6 ++
 .../testAddressRandomization/pernetwork.psk   |  5 ++
 .../testAddressRandomization/ssidCCMP.conf    |  7 ++
 7 files changed, 119 insertions(+)
 create mode 100644 autotests/testAddressRandomization/connection_test.py
 create mode 100644 autotests/testAddressRandomization/full_random.psk
 create mode 100644 autotests/testAddressRandomization/hw.conf
 create mode 100644 autotests/testAddressRandomization/main.conf
 create mode 100644 autotests/testAddressRandomization/override.psk
 create mode 100644 autotests/testAddressRandomization/pernetwork.psk
 create mode 100644 autotests/testAddressRandomization/ssidCCMP.conf

diff --git a/autotests/testAddressRandomization/connection_test.py b/autote=
sts/testAddressRandomization/connection_test.py
new file mode 100644
index 00000000..fab8fea9
--- /dev/null
+++ b/autotests/testAddressRandomization/connection_test.py
@@ -0,0 +1,86 @@
+#!/usr/bin/python3
+
+import unittest
+import sys
+import os
+
+sys.path.append('../util')
+import iwd
+from iwd import IWD
+from iwd import NetworkType
+import testutil
+
+class Test(unittest.TestCase):
+    def try_connection(self, wd):
+        devices =3D wd.list_devices(1)
+        device =3D devices[0]
+
+        ordered_network =3D device.get_ordered_network('ssidCCMP')
+
+        self.assertEqual(ordered_network.type, NetworkType.psk)
+
+        condition =3D 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+
+        ordered_network.network_object.connect()
+
+        condition =3D 'obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+
+        testutil.test_iface_operstate()
+        testutil.test_ifaces_connected()
+
+        device.disconnect()
+
+        condition =3D 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+
+        return device.address
+
+    def test_connection_success(self):
+        wd =3D IWD(True)
+
+        devices =3D wd.list_devices(1)
+        device =3D devices[0]
+
+        perm_addr =3D device.address
+
+        condition =3D 'not obj.scanning'
+        wd.wait_for_object_condition(device, condition)
+
+        device.scan()
+
+        condition =3D 'not obj.scanning'
+        wd.wait_for_object_condition(device, condition)
+
+        # 1. Test per-network deterministic MAC generation
+        os.system('cat pernetwork.psk > /var/lib/iwd/ssidCCMP.psk')
+        new_addr =3D self.try_connection(wd)
+        self.assertNotEqual(perm_addr, new_addr)
+        # try again to ensure the generation was deterministic
+        new_addr2 =3D self.try_connection(wd)
+        self.assertEqual(new_addr, new_addr2)
+
+        # 2. Test FullAddressRandomization
+        os.system('cat full_random.psk > /var/lib/iwd/ssidCCMP.psk')
+        new_addr =3D self.try_connection(wd)
+        self.assertNotEqual(perm_addr, new_addr)
+        # try again to make sure the generation was random
+        new_addr2 =3D self.try_connection(wd)
+        self.assertNotEqual(new_addr, new_addr2)
+
+        # 3. Test AddressOverride
+        os.system('cat override.psk > /var/lib/iwd/ssidCCMP.psk')
+        new_addr =3D self.try_connection(wd)
+        self.assertEqual(new_addr, 'e6:f6:38:a9:02:02')
+
+    @classmethod
+    def setUpClass(cls):
+        pass
+
+    @classmethod
+    def tearDownClass(cls):
+        IWD.clear_storage()
+
+if __name__ =3D=3D '__main__':
+    unittest.main(exit=3DTrue)
diff --git a/autotests/testAddressRandomization/full_random.psk b/autotests=
/testAddressRandomization/full_random.psk
new file mode 100644
index 00000000..57934287
--- /dev/null
+++ b/autotests/testAddressRandomization/full_random.psk
@@ -0,0 +1,6 @@
+[Security]
+Passphrase=3Dsecret123
+
+[Settings]
+AlwaysRandomizeAddress=3Dtrue
+AutoConnect=3Dfalse
diff --git a/autotests/testAddressRandomization/hw.conf b/autotests/testAdd=
ressRandomization/hw.conf
new file mode 100644
index 00000000..fa46c8b8
--- /dev/null
+++ b/autotests/testAddressRandomization/hw.conf
@@ -0,0 +1,7 @@
+[SETUP]
+num_radios=3D2
+start_iwd=3D0
+tmpfs_extra_stuff=3Dmain.conf
+
+[HOSTAPD]
+rad0=3DssidCCMP.conf
diff --git a/autotests/testAddressRandomization/main.conf b/autotests/testA=
ddressRandomization/main.conf
new file mode 100644
index 00000000..1b66d338
--- /dev/null
+++ b/autotests/testAddressRandomization/main.conf
@@ -0,0 +1,2 @@
+[General]
+AddressRandomization=3Dnetwork
diff --git a/autotests/testAddressRandomization/override.psk b/autotests/te=
stAddressRandomization/override.psk
new file mode 100644
index 00000000..ecce3616
--- /dev/null
+++ b/autotests/testAddressRandomization/override.psk
@@ -0,0 +1,6 @@
+[Security]
+Passphrase=3Dsecret123
+
+[Settings]
+AddressOverride=3De6:f6:38:a9:02:02
+AutoConnect=3Dfalse
diff --git a/autotests/testAddressRandomization/pernetwork.psk b/autotests/=
testAddressRandomization/pernetwork.psk
new file mode 100644
index 00000000..1150ba8c
--- /dev/null
+++ b/autotests/testAddressRandomization/pernetwork.psk
@@ -0,0 +1,5 @@
+[Security]
+Passphrase=3Dsecret123
+
+[Settings]
+AutoConnect=3Dfalse
diff --git a/autotests/testAddressRandomization/ssidCCMP.conf b/autotests/t=
estAddressRandomization/ssidCCMP.conf
new file mode 100644
index 00000000..074e8228
--- /dev/null
+++ b/autotests/testAddressRandomization/ssidCCMP.conf
@@ -0,0 +1,7 @@
+hw_mode=3Dg
+channel=3D1
+ssid=3DssidCCMP
+
+wpa=3D2
+wpa_pairwise=3DCCMP
+wpa_passphrase=3Dsecret123
-- =

2.21.1

--===============3993447935261664577==--

