Content-Type: multipart/mixed; boundary="===============2036829244954909853=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 3/4] auto-t: Test PEAPv0 cryptobinding
Date: Fri, 31 Jan 2020 14:25:16 -0800
Message-ID: <20200131222517.8182-3-tim.a.kourt@linux.intel.com>
In-Reply-To: <20200131222517.8182-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2036829244954909853==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 .../misc/secrets/eap-user-peap-v0-mschapv2.text    |  4 ++
 autotests/testEAP-PEAPv0-CryptoBinding/ISK_test.py | 63 ++++++++++++++++
 .../testEAP-PEAPv0-CryptoBinding/NoISK_test.py     | 83 ++++++++++++++++++=
++++
 autotests/testEAP-PEAPv0-CryptoBinding/hw.conf     |  9 +++
 autotests/testEAP-PEAPv0-CryptoBinding/main.conf   |  2 +
 .../ssidEAP-PEAPv0-ISK.8021x                       | 12 ++++
 .../ssidEAP-PEAPv0-ISK.conf                        | 12 ++++
 .../ssidEAP-PEAPv0-NoISK.8021x                     | 12 ++++
 .../ssidEAP-PEAPv0-NoISK.conf                      | 12 ++++
 9 files changed, 209 insertions(+)
 create mode 100644 autotests/misc/secrets/eap-user-peap-v0-mschapv2.text
 create mode 100644 autotests/testEAP-PEAPv0-CryptoBinding/ISK_test.py
 create mode 100644 autotests/testEAP-PEAPv0-CryptoBinding/NoISK_test.py
 create mode 100644 autotests/testEAP-PEAPv0-CryptoBinding/hw.conf
 create mode 100644 autotests/testEAP-PEAPv0-CryptoBinding/main.conf
 create mode 100644 autotests/testEAP-PEAPv0-CryptoBinding/ssidEAP-PEAPv0-I=
SK.8021x
 create mode 100644 autotests/testEAP-PEAPv0-CryptoBinding/ssidEAP-PEAPv0-I=
SK.conf
 create mode 100644 autotests/testEAP-PEAPv0-CryptoBinding/ssidEAP-PEAPv0-N=
oISK.8021x
 create mode 100644 autotests/testEAP-PEAPv0-CryptoBinding/ssidEAP-PEAPv0-N=
oISK.conf

diff --git a/autotests/misc/secrets/eap-user-peap-v0-mschapv2.text b/autote=
sts/misc/secrets/eap-user-peap-v0-mschapv2.text
new file mode 100644
index 00000000..c91693c4
--- /dev/null
+++ b/autotests/misc/secrets/eap-user-peap-v0-mschapv2.text
@@ -0,0 +1,4 @@
+# Phase 1 users
+* PEAP [ver=3D0]
+# Phase 2
+"secure(a)identity.com" MSCHAPV2 "testpasswd" [2]
diff --git a/autotests/testEAP-PEAPv0-CryptoBinding/ISK_test.py b/autotests=
/testEAP-PEAPv0-CryptoBinding/ISK_test.py
new file mode 100644
index 00000000..7ba49384
--- /dev/null
+++ b/autotests/testEAP-PEAPv0-CryptoBinding/ISK_test.py
@@ -0,0 +1,63 @@
+#!/usr/bin/python3
+
+import unittest
+import sys
+import time
+
+sys.path.append('../util')
+import iwd
+from iwd import IWD
+from iwd import NetworkType
+import testutil
+
+from hostapd import HostapdCLI
+from hostapd import hostapd_map
+
+class Test(unittest.TestCase):
+
+    def validate_connection(self, wd):
+        devices =3D wd.list_devices(1)
+        self.assertIsNotNone(devices)
+        device =3D devices[0]
+
+        condition =3D 'not obj.scanning'
+        wd.wait_for_object_condition(device, condition)
+
+        device.scan()
+
+        condition =3D 'not obj.scanning'
+        wd.wait_for_object_condition(device, condition)
+
+        ordered_network =3D device.get_ordered_network('ssidEAP-PEAPv0-ISK=
')
+
+        self.assertEqual(ordered_network.type, NetworkType.eap)
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
+        device.disconnect()
+
+        condition =3D 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+
+
+    def test_connection_success(self):
+        wd =3D IWD(True)
+
+        self.validate_connection(wd)
+
+    @classmethod
+    def setUpClass(cls):
+        IWD.copy_to_storage('ssidEAP-PEAPv0-ISK.8021x')
+
+    @classmethod
+    def tearDownClass(cls):
+        IWD.clear_storage()
+
+if __name__ =3D=3D '__main__':
+    unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-PEAPv0-CryptoBinding/NoISK_test.py b/autotes=
ts/testEAP-PEAPv0-CryptoBinding/NoISK_test.py
new file mode 100644
index 00000000..fde8bfc2
--- /dev/null
+++ b/autotests/testEAP-PEAPv0-CryptoBinding/NoISK_test.py
@@ -0,0 +1,83 @@
+#!/usr/bin/python3
+
+import unittest
+import sys
+import time
+
+sys.path.append('../util')
+import iwd
+from iwd import IWD
+from iwd import NetworkType
+import testutil
+
+from hostapd import HostapdCLI
+from hostapd import hostapd_map
+
+class Test(unittest.TestCase):
+
+    def validate_connection(self, wd):
+        hostapd =3D None
+
+        for hostapd_if in list(hostapd_map.values()):
+            hpd =3D HostapdCLI(hostapd_if)
+            if hpd.get_config_value('ssid') =3D=3D 'ssidEAP-PEAPv0-NoISK':
+                hostapd =3D hpd
+                break
+
+        self.assertIsNotNone(hostapd)
+
+        devices =3D wd.list_devices(1)
+        self.assertIsNotNone(devices)
+        device =3D devices[0]
+
+        condition =3D 'not obj.scanning'
+        wd.wait_for_object_condition(device, condition)
+
+        device.scan()
+
+        condition =3D 'not obj.scanning'
+        wd.wait_for_object_condition(device, condition)
+
+        ordered_network =3D device.get_ordered_network('ssidEAP-PEAPv0-NoI=
SK')
+
+        self.assertEqual(ordered_network.type, NetworkType.eap)
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
+        hostapd.eapol_reauth(device.address)
+
+        wd.wait(10)
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
+
+    def test_connection_success(self):
+        wd =3D IWD(True)
+
+        self.validate_connection(wd)
+
+    @classmethod
+    def setUpClass(cls):
+        IWD.copy_to_storage('ssidEAP-PEAPv0-NoISK.8021x')
+
+    @classmethod
+    def tearDownClass(cls):
+        IWD.clear_storage()
+
+if __name__ =3D=3D '__main__':
+    unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-PEAPv0-CryptoBinding/hw.conf b/autotests/tes=
tEAP-PEAPv0-CryptoBinding/hw.conf
new file mode 100644
index 00000000..cceb79fb
--- /dev/null
+++ b/autotests/testEAP-PEAPv0-CryptoBinding/hw.conf
@@ -0,0 +1,9 @@
+[SETUP]
+num_radios=3D3
+start_iwd=3D0
+max_test_exec_interval_sec=3D60
+tmpfs_extra_stuff=3D../misc/certs:../misc/secrets:main.conf
+
+[HOSTAPD]
+rad0=3DssidEAP-PEAPv0-NoISK.conf
+rad1=3DssidEAP-PEAPv0-ISK.conf
diff --git a/autotests/testEAP-PEAPv0-CryptoBinding/main.conf b/autotests/t=
estEAP-PEAPv0-CryptoBinding/main.conf
new file mode 100644
index 00000000..55a5543e
--- /dev/null
+++ b/autotests/testEAP-PEAPv0-CryptoBinding/main.conf
@@ -0,0 +1,2 @@
+[General]
+UseDefaultInterface=3Dtrue
diff --git a/autotests/testEAP-PEAPv0-CryptoBinding/ssidEAP-PEAPv0-ISK.8021=
x b/autotests/testEAP-PEAPv0-CryptoBinding/ssidEAP-PEAPv0-ISK.8021x
new file mode 100644
index 00000000..56eed087
--- /dev/null
+++ b/autotests/testEAP-PEAPv0-CryptoBinding/ssidEAP-PEAPv0-ISK.8021x
@@ -0,0 +1,12 @@
+[Security]
+EAP-Method=3DPEAP
+EAP-Identity=3Dopen(a)identity.com
+EAP-PEAP-CACert=3D/tmp/certs/cert-ca.pem
+EAP-PEAP-ClientCert=3D/tmp/certs/cert-client.pem
+EAP-PEAP-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
+EAP-PEAP-Phase2-Method=3DMSCHAPV2
+EAP-PEAP-Phase2-Identity=3Dsecure(a)identity.com
+EAP-PEAP-Phase2-Password=3Dtestpasswd
+
+[Settings]
+AutoConnect=3Dfalse
diff --git a/autotests/testEAP-PEAPv0-CryptoBinding/ssidEAP-PEAPv0-ISK.conf=
 b/autotests/testEAP-PEAPv0-CryptoBinding/ssidEAP-PEAPv0-ISK.conf
new file mode 100644
index 00000000..c9980bd9
--- /dev/null
+++ b/autotests/testEAP-PEAPv0-CryptoBinding/ssidEAP-PEAPv0-ISK.conf
@@ -0,0 +1,12 @@
+hw_mode=3Dg
+channel=3D1
+ssid=3DssidEAP-PEAPv0-ISK
+
+wpa=3D3
+wpa_key_mgmt=3DWPA-EAP
+ieee8021x=3D1
+eap_server=3D1
+eap_user_file=3D/tmp/secrets/eap-user-peap-v0-mschapv2.text
+ca_cert=3D/tmp/certs/cert-ca.pem
+server_cert=3D/tmp/certs/cert-server.pem
+private_key=3D/tmp/certs/cert-server-key.pem
diff --git a/autotests/testEAP-PEAPv0-CryptoBinding/ssidEAP-PEAPv0-NoISK.80=
21x b/autotests/testEAP-PEAPv0-CryptoBinding/ssidEAP-PEAPv0-NoISK.8021x
new file mode 100644
index 00000000..382f86d0
--- /dev/null
+++ b/autotests/testEAP-PEAPv0-CryptoBinding/ssidEAP-PEAPv0-NoISK.8021x
@@ -0,0 +1,12 @@
+[Security]
+EAP-Method=3DPEAP
+EAP-Identity=3Dopen(a)identity.com
+EAP-PEAP-CACert=3D/tmp/certs/cert-ca.pem
+EAP-PEAP-ClientCert=3D/tmp/certs/cert-client.pem
+EAP-PEAP-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
+EAP-PEAP-Phase2-Method=3DMD5
+EAP-PEAP-Phase2-Identity=3Dsecure(a)identity.com
+EAP-PEAP-Phase2-Password=3Dtestpasswd
+
+[Settings]
+AutoConnect=3Dfalse
diff --git a/autotests/testEAP-PEAPv0-CryptoBinding/ssidEAP-PEAPv0-NoISK.co=
nf b/autotests/testEAP-PEAPv0-CryptoBinding/ssidEAP-PEAPv0-NoISK.conf
new file mode 100644
index 00000000..b92bb1ae
--- /dev/null
+++ b/autotests/testEAP-PEAPv0-CryptoBinding/ssidEAP-PEAPv0-NoISK.conf
@@ -0,0 +1,12 @@
+hw_mode=3Dg
+channel=3D1
+ssid=3DssidEAP-PEAPv0-NoISK
+
+wpa=3D3
+wpa_key_mgmt=3DWPA-EAP
+ieee8021x=3D1
+eap_server=3D1
+eap_user_file=3D/tmp/secrets/eap-user-peap-v0.text
+ca_cert=3D/tmp/certs/cert-ca.pem
+server_cert=3D/tmp/certs/cert-server.pem
+private_key=3D/tmp/certs/cert-server-key.pem
-- =

2.13.6

--===============2036829244954909853==--

