Content-Type: multipart/mixed; boundary="===============7684226261546012428=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 10/18] auto-t: add reassociation test for OWE
Date: Thu, 12 Aug 2021 13:21:59 -0700
Message-ID: <20210812202207.737053-10-prestwoj@gmail.com>
In-Reply-To: <20210812202207.737053-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7684226261546012428==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The timeout test was also modified to handle the additional
radio.
---
 autotests/testOWE/connection_test.py          | 47 +++++++++++++------
 autotests/testOWE/hw.conf                     |  7 +--
 autotests/testOWE/main.conf                   |  2 +
 .../testOWE/{ssidOWE.conf =3D> ssidOWE-1.conf}  |  0
 autotests/testOWE/ssidOWE-2.conf              |  8 ++++
 autotests/testOWE/timeout_test.py             | 22 +++++++--
 6 files changed, 66 insertions(+), 20 deletions(-)
 create mode 100644 autotests/testOWE/main.conf
 rename autotests/testOWE/{ssidOWE.conf =3D> ssidOWE-1.conf} (100%)
 create mode 100644 autotests/testOWE/ssidOWE-2.conf

diff --git a/autotests/testOWE/connection_test.py b/autotests/testOWE/conne=
ction_test.py
index ee1036c8..0be09263 100644
--- a/autotests/testOWE/connection_test.py
+++ b/autotests/testOWE/connection_test.py
@@ -13,40 +13,59 @@ import testutil
 class Test(unittest.TestCase):
 =

     def test_connection_success(self):
-        hapd =3D HostapdCLI(config=3D'ssidOWE.conf')
+        hapd =3D HostapdCLI(config=3D'ssidOWE-1.conf')
 =

         wd =3D IWD()
 =

         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
+        device.get_ordered_network('ssidOWE', scan_if_needed=3DTrue)
 =

-        device.scan()
+        device.connect_bssid(hapd.bssid)
 =

-        condition =3D 'not obj.scanning'
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
 =

-        ordered_network =3D device.get_ordered_network('ssidOWE')
+        testutil.test_iface_operstate()
+        testutil.test_ifaces_connected(device.name, hapd.ifname)
 =

-        self.assertEqual(ordered_network.type, NetworkType.open)
+        device.disconnect()
 =

-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+    def test_reassociate(self):
+        hapd0 =3D HostapdCLI(config=3D'ssidOWE-1.conf')
+        hapd1 =3D HostapdCLI(config=3D'ssidOWE-2.conf')
 =

-        ordered_network.network_object.connect()
+        wd =3D IWD()
+
+        devices =3D wd.list_devices(1)
+        device =3D devices[0]
+
+        device.get_ordered_network('ssidOWE', scan_if_needed=3DTrue)
+
+        device.connect_bssid(hapd0.bssid)
 =

         condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
 =

         testutil.test_iface_operstate()
-        testutil.test_ifaces_connected(device.name, hapd.ifname)
+        testutil.test_ifaces_connected(device.name, hapd0.ifname)
 =

-        device.disconnect()
+        device.roam(hapd1.bssid)
+
+        condition =3D 'obj.state =3D=3D DeviceState.roaming'
+        wd.wait_for_object_condition(device, condition)
+
+        from_condition =3D 'obj.state =3D=3D DeviceState.roaming'
+        to_condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_change(device, from_condition, to_condition)
+
+        self.assertTrue(hapd1.list_sta())
 =

-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        testutil.test_iface_operstate(device.name)
+        testutil.test_ifaces_connected(hapd1.ifname, device.name)
+        self.assertRaises(Exception, testutil.test_ifaces_connected,
+                          (hapd0.ifname, device.name, True, True))
 =

     @classmethod
     def setUpClass(cls):
diff --git a/autotests/testOWE/hw.conf b/autotests/testOWE/hw.conf
index 7f6d938d..fe59f389 100644
--- a/autotests/testOWE/hw.conf
+++ b/autotests/testOWE/hw.conf
@@ -1,6 +1,7 @@
 [SETUP]
-num_radios=3D3
+num_radios=3D4
 =

 [HOSTAPD]
-rad0=3DssidOWE.conf
-rad1=3DssidGroup20.conf
+rad0=3DssidOWE-1.conf
+rad1=3DssidOWE-2.conf
+rad2=3DssidGroup20.conf
diff --git a/autotests/testOWE/main.conf b/autotests/testOWE/main.conf
new file mode 100644
index 00000000..9452fb6b
--- /dev/null
+++ b/autotests/testOWE/main.conf
@@ -0,0 +1,2 @@
+[Scan]
+DisableMacAddressRandomization=3Dtrue
diff --git a/autotests/testOWE/ssidOWE.conf b/autotests/testOWE/ssidOWE-1.c=
onf
similarity index 100%
rename from autotests/testOWE/ssidOWE.conf
rename to autotests/testOWE/ssidOWE-1.conf
diff --git a/autotests/testOWE/ssidOWE-2.conf b/autotests/testOWE/ssidOWE-2=
.conf
new file mode 100644
index 00000000..d9528a36
--- /dev/null
+++ b/autotests/testOWE/ssidOWE-2.conf
@@ -0,0 +1,8 @@
+ctrl_interface=3D/var/run/hostapd
+hw_mode=3Dg
+channel=3D2
+ssid=3DssidOWE
+wpa=3D2
+wpa_key_mgmt=3DOWE
+rsn_pairwise=3DCCMP
+owe_groups=3D19
diff --git a/autotests/testOWE/timeout_test.py b/autotests/testOWE/timeout_=
test.py
index 39c2d429..d75bc8b9 100644
--- a/autotests/testOWE/timeout_test.py
+++ b/autotests/testOWE/timeout_test.py
@@ -17,9 +17,10 @@ class Test(unittest.TestCase):
     def test_connection_success(self):
         hwsim =3D Hwsim()
 =

-        bss_radio =3D hwsim.get_radio('rad0')
+        bss_radio0 =3D hwsim.get_radio('rad0')
+        bss_radio1 =3D hwsim.get_radio('rad1')
 =

-        self.assertIsNotNone(bss_radio)
+        self.assertIsNotNone(bss_radio0)
 =

         wd =3D IWD()
 =

@@ -31,6 +32,9 @@ class Test(unittest.TestCase):
 =

         device.scan()
 =

+        condition =3D 'obj.scanning'
+        wd.wait_for_object_condition(device, condition)
+
         condition =3D 'not obj.scanning'
         wd.wait_for_object_condition(device, condition)
 =

@@ -42,21 +46,33 @@ class Test(unittest.TestCase):
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
 =

         rule0 =3D hwsim.rules.create()
-        rule0.source =3D bss_radio.addresses[0]
+        rule0.source =3D bss_radio0.addresses[0]
         rule0.bidirectional =3D True
         rule0.drop =3D True
         rule0.prefix =3D 'b0'
 =

+        rule1 =3D hwsim.rules.create()
+        rule1.source =3D bss_radio1.addresses[0]
+        rule1.bidirectional =3D True
+        rule1.drop =3D True
+        rule1.prefix =3D 'b0'
+
         # Test Authenticate (b0) and Association (00) timeouts
 =

         with self.assertRaises(iwd.FailedEx):
             ordered_network.network_object.connect()
 =

         rule0.prefix =3D '00'
+        rule1.prefix =3D '00'
 =

         with self.assertRaises(iwd.FailedEx):
             ordered_network.network_object.connect()
 =

+    def tearDown(self):
+        hwsim =3D Hwsim()
+        for rule in list(hwsim.rules.keys()):
+            del hwsim.rules[rule]
+
     @classmethod
     def setUpClass(cls):
         pass
-- =

2.31.1

--===============7684226261546012428==--

