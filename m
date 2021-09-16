Content-Type: multipart/mixed; boundary="===============6930173377436338447=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v4 3/3] auto-t: add testOWE-transition
Date: Thu, 16 Sep 2021 13:49:27 -0700
Message-ID: <20210916204927.46007-3-prestwoj@gmail.com>
In-Reply-To: 20210916204927.46007-1-prestwoj@gmail.com

--===============6930173377436338447==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds several tests for OWE transition networks. Hostapd
does have special options for these networks but currently their
implementation is incorrect as the IE is not ever added to the
OWE BSS. Besides that using vendor_elements provides a much easier
way to create invalid IEs to test.
---
 .../testOWE-transition/connection_test.py     | 222 ++++++++++++++++++
 autotests/testOWE-transition/hw.conf          |  10 +
 autotests/testOWE-transition/main.conf        |   2 +
 autotests/testOWE-transition/ssidOWE.conf     |  14 ++
 autotests/testOWE-transition/ssidOpen.conf    |   8 +
 autotests/testOWE-transition/transition.open  |   0
 6 files changed, 256 insertions(+)
 create mode 100644 autotests/testOWE-transition/connection_test.py
 create mode 100644 autotests/testOWE-transition/hw.conf
 create mode 100644 autotests/testOWE-transition/main.conf
 create mode 100644 autotests/testOWE-transition/ssidOWE.conf
 create mode 100644 autotests/testOWE-transition/ssidOpen.conf
 create mode 100644 autotests/testOWE-transition/transition.open

diff --git a/autotests/testOWE-transition/connection_test.py b/autotests/te=
stOWE-transition/connection_test.py
new file mode 100644
index 00000000..7240e3a8
--- /dev/null
+++ b/autotests/testOWE-transition/connection_test.py
@@ -0,0 +1,222 @@
+#!/usr/bin/python3
+
+import unittest
+import sys
+
+sys.path.append('../util')
+import iwd
+from iwd import IWD
+from iwd import NetworkType
+from hostapd import HostapdCLI
+import testutil
+
+class Test(unittest.TestCase):
+
+    def validate(self, wd, target, autoconnect=3DFalse, connect_hidden=3DF=
alse):
+        devices =3D wd.list_devices(1)
+        device =3D devices[0]
+        device.autoconnect =3D autoconnect
+
+        if not autoconnect:
+            if not connect_hidden:
+                condition =3D 'not obj.scanning'
+                wd.wait_for_object_condition(device, condition)
+
+                device.scan()
+
+                condition =3D 'obj.scanning'
+                wd.wait_for_object_condition(device, condition)
+
+                condition =3D 'not obj.scanning'
+                wd.wait_for_object_condition(device, condition)
+
+                network =3D device.get_ordered_network('transition', scan_=
if_needed=3DFalse)
+
+                network.network_object.connect()
+            else:
+                device.connect_hidden_network('owe-hidden')
+
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
+        testutil.test_iface_operstate()
+
+        if type(target) !=3D list:
+            testutil.test_ifaces_connected(device.name, target.ifname)
+            self.assertIn(device.address, target.list_sta())
+        else:
+            found =3D False
+            for t in target:
+                if device.address in t.list_sta():
+                    testutil.test_ifaces_connected(device.name, t.ifname)
+                    found =3D True
+
+            self.assertTrue(found)
+
+        device.disconnect()
+
+    # Normal success case
+    def test_owe_transition(self):
+        self.hapd_open.set_value('vendor_elements', 'dd15506f9a1c02000000f=
1000a6f77652d68696464656e')
+        self.hapd_open.reload()
+        self.hapd_owe.set_value('vendor_elements', 'dd15506f9a1c02000000f0=
000a7472616e736974696f6e')
+        self.hapd_owe.reload()
+
+        self.hapd_owe2.disable()
+        self.hapd_open2.disable()
+
+        self.validate(self.wd, self.hapd_owe)
+
+    # Normal success case
+    def test_owe_transition_multi_network(self):
+        self.hapd_open.set_value('vendor_elements', 'dd15506f9a1c02000000f=
1000a6f77652d68696464656e')
+        self.hapd_open.reload()
+        self.hapd_owe.set_value('vendor_elements', 'dd15506f9a1c02000000f0=
000a7472616e736974696f6e')
+        self.hapd_owe.reload()
+
+        self.hapd_open2.set_value('vendor_elements', 'dd17506f9a1c02000000=
f1000c6f77652d68696464656e2d32')
+        self.hapd_open2.set_value('ssid', 'transition-2')
+        self.hapd_open2.reload()
+        self.hapd_owe2.set_value('vendor_elements', 'dd17506f9a1c02000000f=
0000c7472616e736974696f6e2d32')
+        self.hapd_owe2.set_value('ssid', 'owe-hidden-2')
+        self.hapd_owe2.reload()
+
+        self.validate(self.wd, self.hapd_owe)
+
+    # Two pairs of open/OWE BSS's (OWE BSS's have different SSIDs) */
+    def test_owe_transition_multi_bss(self):
+        self.hapd_open.set_value('vendor_elements', 'dd15506f9a1c02000000f=
1000a6f77652d68696464656e')
+        self.hapd_open.reload()
+        self.hapd_owe.set_value('vendor_elements', 'dd15506f9a1c02000000f0=
000a7472616e736974696f6e')
+        self.hapd_owe.reload()
+
+        self.hapd_open2.set_value('vendor_elements', 'dd17506f9a1c02000000=
f3000c6f77652d68696464656e2d32')
+        self.hapd_open2.set_value('ssid', 'transition')
+        self.hapd_open2.reload()
+        self.hapd_owe2.set_value('vendor_elements', 'dd15506f9a1c02000000f=
2000a7472616e736974696f6e')
+        self.hapd_owe2.set_value('ssid', 'owe-hidden-2')
+        self.hapd_owe2.reload()
+
+        self.validate(self.wd, [self.hapd_owe, self.hapd_owe2])
+
+    # Two pairs of open/OWE BSS's (OWE BSS's have same SSID) */
+    def test_owe_transition_multi_bss_same_ssid(self):
+        self.hapd_open.set_value('vendor_elements', 'dd15506f9a1c02000000f=
1000a6f77652d68696464656e')
+        self.hapd_open.reload()
+        self.hapd_owe.set_value('vendor_elements', 'dd15506f9a1c02000000f0=
000a7472616e736974696f6e')
+        self.hapd_owe.reload()
+
+        self.hapd_open2.set_value('vendor_elements', 'dd15506f9a1c02000000=
f3000a6f77652d68696464656e')
+        self.hapd_open2.set_value('ssid', 'transition')
+        self.hapd_open2.reload()
+        self.hapd_owe2.set_value('vendor_elements', 'dd15506f9a1c02000000f=
2000a7472616e736974696f6e')
+        self.hapd_owe2.set_value('ssid', 'owe-hidden')
+        self.hapd_owe2.reload()
+
+        self.validate(self.wd, [self.hapd_owe, self.hapd_owe2])
+
+    # Normal success autoconnect case
+    def test_owe_transition_autoconnect(self):
+        self.hapd_open.set_value('vendor_elements', 'dd15506f9a1c02000000f=
1000a6f77652d68696464656e')
+        self.hapd_open.reload()
+        self.hapd_owe.set_value('vendor_elements', 'dd15506f9a1c02000000f0=
000a7472616e736974696f6e')
+        self.hapd_owe.reload()
+
+        self.hapd_owe2.disable()
+        self.hapd_open2.disable()
+
+        IWD.copy_to_storage('transition.open')
+
+        self.validate(self.wd, self.hapd_owe, autoconnect=3DTrue)
+
+    # Open BSS has invalid BSSID in OWE transition element
+    # Expected connection to Open BSS
+    def test_owe_transition_invalid_open_bssid(self):
+        self.hapd_open.set_value('vendor_elements', 'dd15506f9a1c02000000f=
f000a6f77652d68696464656e')
+        self.hapd_open.reload()
+        self.hapd_owe.set_value('vendor_elements', 'dd15506f9a1c02000000f0=
000a7472616e736974696f6e')
+        self.hapd_owe.reload()
+
+        self.hapd_owe2.disable()
+        self.hapd_open2.disable()
+
+        self.validate(self.wd, self.hapd_open)
+
+    # OWE BSS has invalid BSSID in OWE transition element
+    # Expected connection to Open BSS
+    def test_owe_transition_invalid_owe_bssid(self):
+        self.hapd_open.set_value('vendor_elements', 'dd15506f9a1c02000000f=
1000a6f77652d68696464656e')
+        self.hapd_open.reload()
+        self.hapd_owe.set_value('vendor_elements', 'dd15506f9a1c02000000ff=
000a7472616e736974696f6e')
+        self.hapd_owe.reload()
+
+        self.hapd_owe2.disable()
+        self.hapd_open2.disable()
+
+        self.validate(self.wd, self.hapd_open)
+
+    # No OWE hidden network exists
+    # Expected connection to Open BSS
+    def test_owe_transition_no_hidden_found(self):
+        self.hapd_open.set_value('vendor_elements', 'dd15506f9a1c02000000f=
1000a6f77652d68696464656e')
+        self.hapd_open.reload()
+        self.hapd_owe.disable()
+
+        self.hapd_owe2.disable()
+        self.hapd_open2.disable()
+
+        self.validate(self.wd, self.hapd_open)
+
+    # Directly connect to valid OWE hidden network
+    # Expected connection failure
+    def test_owe_transition_connect_hidden_valid(self):
+        self.hapd_open.set_value('vendor_elements', 'dd15506f9a1c02000000f=
1000a6f77652d68696464656e')
+        self.hapd_open.reload()
+        self.hapd_owe.set_value('vendor_elements', 'dd15506f9a1c02000000f0=
000a7472616e736974696f6e')
+        self.hapd_owe.reload()
+
+        self.hapd_owe2.disable()
+        self.hapd_open2.disable()
+
+        with self.assertRaises(iwd.NotFoundEx):
+            self.validate(self.wd, self.hapd_owe, connect_hidden=3DTrue)
+
+    # Directly connect to invalid OWE hidden network. The SSID in the OWE =
BSS
+    # IE points to itself. And the Open BSS IE points to a non-existent SS=
ID.
+    # Expected connection failure
+    def test_owe_transition_connect_hidden_invalid(self):
+        self.hapd_open.set_value('vendor_elements', 'dd18506f9a1c02000000f=
1000d6e6f2d6f77652d68696464656e')
+        self.hapd_open.reload()
+        self.hapd_owe.set_value('vendor_elements', 'dd15506f9a1c02000000f0=
000a6f77652d68696464656e')
+        self.hapd_owe.reload()
+
+        self.hapd_owe2.disable()
+        self.hapd_open2.disable()
+
+        with self.assertRaises(iwd.NotFoundEx):
+            self.validate(self.wd, self.hapd_owe, connect_hidden=3DTrue)
+
+    def setUp(self):
+        self.wd =3D IWD(True)
+        self.hapd_owe =3D HostapdCLI(config=3D'ssidOWE.conf')
+        self.hapd_open =3D HostapdCLI(config=3D'ssidOpen.conf')
+        self.hapd_owe2 =3D HostapdCLI(config=3D'ssidOWE-2.conf')
+        self.hapd_open2 =3D HostapdCLI(config=3D'ssidOpen-2.conf')
+
+    def tearDown(self):
+        IWD.clear_storage()
+
+        self.wd =3D None
+        self.hapd_open =3D None
+        self.hapd_owe =3D None
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
diff --git a/autotests/testOWE-transition/hw.conf b/autotests/testOWE-trans=
ition/hw.conf
new file mode 100644
index 00000000..dbd70597
--- /dev/null
+++ b/autotests/testOWE-transition/hw.conf
@@ -0,0 +1,10 @@
+[SETUP]
+num_radios=3D5
+hwsim_medium=3Dyes
+start_iwd=3D0
+
+[HOSTAPD]
+rad0=3DssidOpen.conf
+rad1=3DssidOWE.conf
+rad2=3DssidOpen-2.conf
+rad3=3DssidOWE-2.conf
diff --git a/autotests/testOWE-transition/main.conf b/autotests/testOWE-tra=
nsition/main.conf
new file mode 100644
index 00000000..9452fb6b
--- /dev/null
+++ b/autotests/testOWE-transition/main.conf
@@ -0,0 +1,2 @@
+[Scan]
+DisableMacAddressRandomization=3Dtrue
diff --git a/autotests/testOWE-transition/ssidOWE.conf b/autotests/testOWE-=
transition/ssidOWE.conf
new file mode 100644
index 00000000..c54309ae
--- /dev/null
+++ b/autotests/testOWE-transition/ssidOWE.conf
@@ -0,0 +1,14 @@
+ssid=3Dowe-hidden
+bssid=3D02:00:00:00:f1:00
+channel=3D1
+ignore_broadcast_ssid=3D1
+ieee80211w=3D1
+
+wpa=3D2
+wpa_key_mgmt=3DOWE
+rsn_pairwise=3DCCMP
+
+# You would conventionally use these options but hostapd does not include =
an
+# IE for the OWE network, hence vendor_elements must be used directly
+#owe_transition_ssid=3D"transition"
+#owe_transition_bssid=3D02:00:00:00:f0:00
diff --git a/autotests/testOWE-transition/ssidOpen.conf b/autotests/testOWE=
-transition/ssidOpen.conf
new file mode 100644
index 00000000..4fc68430
--- /dev/null
+++ b/autotests/testOWE-transition/ssidOpen.conf
@@ -0,0 +1,8 @@
+channel=3D1
+ssid=3Dtransition
+bssid=3D02:00:00:00:f0:00
+
+# You would conventionally use these options but hostapd does not include =
an
+# IE for the OWE network, hence vendor_elements must be used directly
+#owe_transition_ssid=3D"owe-hidden"
+#owe_transition_bssid=3D02:00:00:00:f1:00
diff --git a/autotests/testOWE-transition/transition.open b/autotests/testO=
WE-transition/transition.open
new file mode 100644
index 00000000..e69de29b
-- =

2.31.1

--===============6930173377436338447==--

