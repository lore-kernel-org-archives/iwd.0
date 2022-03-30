Content-Type: multipart/mixed; boundary="===============7080262758773742649=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/7] auto-t: remove direct scan() call when possible
Date: Wed, 30 Mar 2022 13:23:11 -0700
Message-ID: <20220330202315.1881335-3-prestwoj@gmail.com>
In-Reply-To: 20220330202315.1881335-1-prestwoj@gmail.com

--===============7080262758773742649==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

All tests which could avoid calling scan() directly have been
changed to use the 'full_scan' argument to get_ordered_network.

This was done because of unreliable scanning behavior on slower
systems, like VMs. If we get unlucky with the scheduler some beacons
are not received in time and in turn scan results are missing.
Using full_scan=3DTrue works around this issue by repeatedly scanning
until the SSID is found.
---
 autotests/testAP/connection_test.py           | 10 +------
 autotests/testAP/dhcp_config_test.py          |  8 ------
 autotests/testAP/dhcp_test.py                 |  8 ------
 autotests/testAP/failure_test.py              | 10 +------
 autotests/testBSSBlacklist/connection_test.py | 10 +------
 .../connect_command_test.py                   | 28 ++++++-------------
 .../disconnect_by_ap_test.py                  |  7 +----
 autotests/testFT-FILS/connection_test.py      | 13 +--------
 autotests/testHT-VHT/connection_test.py       | 15 ++--------
 autotests/testNetconfig/static_test.py        |  7 +----
 .../testOWE-transition/connection_test.py     | 10 -------
 autotests/testRSSIAgent/connection_test.py    | 13 +--------
 .../testSAE-AntiClogging/clogging_test.py     | 10 +------
 autotests/testSAE-roam/connection_test.py     | 13 ++-------
 14 files changed, 22 insertions(+), 140 deletions(-)

diff --git a/autotests/testAP/connection_test.py b/autotests/testAP/connect=
ion_test.py
index 4c784014..02213947 100644
--- a/autotests/testAP/connection_test.py
+++ b/autotests/testAP/connection_test.py
@@ -47,16 +47,8 @@ class Test(unittest.TestCase):
         dev1.start_ap('TestAP2', 'Password2')
 =

         try:
-            condition =3D 'not obj.scanning'
-            wd.wait_for_object_condition(dev2, condition)
-            dev2.scan()
-            condition =3D 'obj.scanning'
-            wd.wait_for_object_condition(dev2, condition)
-            condition =3D 'not obj.scanning'
-            wd.wait_for_object_condition(dev2, condition)
-
             networks =3D {}
-            networks['TestAP1'] =3D dev2.get_ordered_network('TestAP1')
+            networks['TestAP1'] =3D dev2.get_ordered_network('TestAP1', fu=
ll_scan=3DTrue)
             networks['TestAP2'] =3D dev2.get_ordered_network('TestAP2', fu=
ll_scan=3DTrue)
 =

             self.assertEqual(networks['TestAP1'].type, NetworkType.psk)
diff --git a/autotests/testAP/dhcp_config_test.py b/autotests/testAP/dhcp_c=
onfig_test.py
index afea5415..ac3a95ba 100644
--- a/autotests/testAP/dhcp_config_test.py
+++ b/autotests/testAP/dhcp_config_test.py
@@ -29,14 +29,6 @@ class Test(unittest.TestCase):
         dev1.start_ap('APConfig')
 =

         try:
-            condition =3D 'not obj.scanning'
-            wd.wait_for_object_condition(dev2, condition)
-            dev2.scan()
-            condition =3D 'obj.scanning'
-            wd.wait_for_object_condition(dev2, condition)
-            condition =3D 'not obj.scanning'
-            wd.wait_for_object_condition(dev2, condition)
-
             networks =3D {}
             networks['APConfig'] =3D dev2.get_ordered_network('APConfig', =
full_scan=3DTrue)
 =

diff --git a/autotests/testAP/dhcp_test.py b/autotests/testAP/dhcp_test.py
index 0118b17d..a8f89eb0 100644
--- a/autotests/testAP/dhcp_test.py
+++ b/autotests/testAP/dhcp_test.py
@@ -26,14 +26,6 @@ class Test(unittest.TestCase):
             dev4.start_ap('TestAP4', 'Password4')
 =

         try:
-            condition =3D 'not obj.scanning'
-            wd.wait_for_object_condition(dev2, condition)
-            dev2.scan()
-            condition =3D 'obj.scanning'
-            wd.wait_for_object_condition(dev2, condition)
-            condition =3D 'not obj.scanning'
-            wd.wait_for_object_condition(dev2, condition)
-
             networks =3D {}
             networks['TestAP2'] =3D dev2.get_ordered_network('TestAP2', fu=
ll_scan=3DTrue)
 =

diff --git a/autotests/testAP/failure_test.py b/autotests/testAP/failure_te=
st.py
index 05b5a7fb..4bd4a2aa 100644
--- a/autotests/testAP/failure_test.py
+++ b/autotests/testAP/failure_test.py
@@ -48,16 +48,8 @@ class Test(unittest.TestCase):
         dev1.start_ap('TestAP2', 'Password2')
 =

         try:
-            condition =3D 'not obj.scanning'
-            wd.wait_for_object_condition(dev2, condition)
-            dev2.scan()
-            condition =3D 'obj.scanning'
-            wd.wait_for_object_condition(dev2, condition)
-            condition =3D 'not obj.scanning'
-            wd.wait_for_object_condition(dev2, condition)
-
             networks =3D {}
-            networks['TestAP1'] =3D dev2.get_ordered_network('TestAP1')
+            networks['TestAP1'] =3D dev2.get_ordered_network('TestAP1', fu=
ll_scan=3DTrue)
             networks['TestAP2'] =3D dev2.get_ordered_network('TestAP2', fu=
ll_scan=3DTrue)
 =

             self.assertEqual(networks['TestAP1'].type, NetworkType.psk)
diff --git a/autotests/testBSSBlacklist/connection_test.py b/autotests/test=
BSSBlacklist/connection_test.py
index df3bd507..1bc9e604 100644
--- a/autotests/testBSSBlacklist/connection_test.py
+++ b/autotests/testBSSBlacklist/connection_test.py
@@ -244,15 +244,7 @@ class Test(unittest.TestCase):
 =

         device.disconnect()
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        ordered_network =3D device.get_ordered_network("TestBlacklist")
+        ordered_network =3D device.get_ordered_network("TestBlacklist", fu=
ll_scan=3DTrue)
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
 =

diff --git a/autotests/testClientNonInteractive/connect_command_test.py b/a=
utotests/testClientNonInteractive/connect_command_test.py
index 8ca7ad42..c31b9b43 100644
--- a/autotests/testClientNonInteractive/connect_command_test.py
+++ b/autotests/testClientNonInteractive/connect_command_test.py
@@ -11,13 +11,9 @@ import subprocess
 from config import ctx
 =

 class Test(unittest.TestCase):
-
     def check_connection_success(self, ssid):
         device =3D self.wd.list_devices(1)[0]
 =

-        condition =3D 'not obj.scanning'
-        self.wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network(ssid)
 =

         condition =3D 'obj.state =3D=3D DeviceState.connected'
@@ -28,9 +24,14 @@ class Test(unittest.TestCase):
         condition =3D 'not obj.connected'
         self.wd.wait_for_object_condition(ordered_network.network_object, =
condition)
 =

+    def establish_network(self, ssid):
+        device =3D self.wd.list_devices(1)[0]
+        device.get_ordered_network(ssid)
+
     def test_connection_with_passphrase(self):
         ssid =3D 'ssidPassphrase'
 =

+        self.establish_network(ssid)
         device =3D self.wd.list_devices(1)[0]
 =

         # Use --dontaks cmd-line option
@@ -45,6 +46,7 @@ class Test(unittest.TestCase):
     def test_connection_with_username_and_password(self):
         ssid =3D 'ssidUNameAndPWord'
 =

+        self.establish_network(ssid)
         device =3D self.wd.list_devices(1)[0]
 =

         ctx.start_process(['iwctl', '-u', 'user', '-p', 'password', 'stati=
on', \
@@ -54,6 +56,7 @@ class Test(unittest.TestCase):
     def test_connection_with_password(self):
         ssid =3D 'ssidPWord'
 =

+        self.establish_network(ssid)
         device =3D self.wd.list_devices(1)[0]
 =

         ctx.start_process(['iwctl', '-p', 'password', 'station', device.na=
me, 'connect', ssid],
@@ -64,6 +67,7 @@ class Test(unittest.TestCase):
     def test_connection_failure(self):
         ssid =3D 'ssidPassphrase'
 =

+        self.establish_network(ssid)
         device =3D self.wd.list_devices(1)[0]
 =

         with self.assertRaises(subprocess.CalledProcessError):
@@ -73,14 +77,13 @@ class Test(unittest.TestCase):
     def test_invalid_command_line_option(self):
         ssid =3D 'ssidPassphrase'
 =

+        self.establish_network(ssid)
         device =3D self.wd.list_devices(1)[0]
 =

         with self.assertRaises(subprocess.CalledProcessError):
             ctx.start_process(['iwctl', '-z', 'station', device.name, 'con=
nect', ssid], check=3DTrue)
 =

     def test_invalid_command(self):
-        device =3D self.wd.list_devices(1)[0]
-
         with self.assertRaises(subprocess.CalledProcessError):
             ctx.start_process(['iwctl', 'inexistent', 'command'], check=3D=
True)
 =

@@ -91,19 +94,6 @@ class Test(unittest.TestCase):
 =

         cls.wd =3D IWD()
 =

-        device =3D cls.wd.list_devices(1)[0]
-
-        condition =3D 'not obj.scanning'
-        cls.wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'obj.scanning'
-        cls.wd.wait_for_object_condition(device, condition)
-
-        condition =3D 'not obj.scanning'
-        cls.wd.wait_for_object_condition(device, condition)
-
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
diff --git a/autotests/testDisconnectByAP/disconnect_by_ap_test.py b/autote=
sts/testDisconnectByAP/disconnect_by_ap_test.py
index f003ec0c..f3c71358 100644
--- a/autotests/testDisconnectByAP/disconnect_by_ap_test.py
+++ b/autotests/testDisconnectByAP/disconnect_by_ap_test.py
@@ -21,12 +21,7 @@ class Test(unittest.TestCase):
 =

         hostapd =3D HostapdCLI(config=3D'ssidOpen.conf')
 =

-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        ordered_network =3D device.get_ordered_network('ssidOpen')
+        ordered_network =3D device.get_ordered_network('ssidOpen', full_sc=
an=3DTrue)
 =

         ordered_network.network_object.connect()
 =

diff --git a/autotests/testFT-FILS/connection_test.py b/autotests/testFT-FI=
LS/connection_test.py
index 1fd4633b..4aef8db6 100644
--- a/autotests/testFT-FILS/connection_test.py
+++ b/autotests/testFT-FILS/connection_test.py
@@ -13,21 +13,10 @@ class Test(unittest.TestCase):
     def validate_connection(self, wd):
         device =3D wd.list_devices(1)[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         # Scanning is unavoidable in this case since both FILS-SHA256 and
         # FILS-SHA384 are tested. Without a new scan the cached scan resul=
ts
         # would cause IWD to choose an incorrect AKM for the second test.
-        device.scan()
-
-        condition =3D 'obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        ordered_network =3D device.get_ordered_network('TestFT')
+        ordered_network =3D device.get_ordered_network('TestFT', full_scan=
=3DTrue)
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
 =

diff --git a/autotests/testHT-VHT/connection_test.py b/autotests/testHT-VHT=
/connection_test.py
index 051822c2..0297cb9b 100644
--- a/autotests/testHT-VHT/connection_test.py
+++ b/autotests/testHT-VHT/connection_test.py
@@ -14,22 +14,11 @@ from hostapd import HostapdCLI
 =

 class Test(unittest.TestCase):
     def do_connect(self, wd, device, hostapd):
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         #
         # Scanning must be explicitly done to get updated RSSI values. The=
refore
-        # scan_if_needed is set false because of the previous scan.
+        # full_scan is set.
         #
-        ordered_network =3D device.get_ordered_network('testSSID', scan_if=
_needed=3DFalse)
+        ordered_network =3D device.get_ordered_network('testSSID', full_sc=
an=3DTrue)
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
 =

diff --git a/autotests/testNetconfig/static_test.py b/autotests/testNetconf=
ig/static_test.py
index 4aae4a20..8e29d4eb 100644
--- a/autotests/testNetconfig/static_test.py
+++ b/autotests/testNetconfig/static_test.py
@@ -47,12 +47,7 @@ class Test(unittest.TestCase):
 =

         testutil.test_ip_address_match(dev1.name, '192.168.1.10')
 =

-        dev2.scan()
-
-        condition =3D 'not obj.scanning'
-        wd_ns0.wait_for_object_condition(dev2, condition)
-
-        ordered_network =3D dev2.get_ordered_network('ssidTKIP', scan_if_n=
eeded=3DTrue)
+        ordered_network =3D dev2.get_ordered_network('ssidTKIP')
 =

         condition =3D 'not obj.connected'
         wd_ns0.wait_for_object_condition(ordered_network.network_object, c=
ondition)
diff --git a/autotests/testOWE-transition/connection_test.py b/autotests/te=
stOWE-transition/connection_test.py
index ff5ea811..89f97338 100644
--- a/autotests/testOWE-transition/connection_test.py
+++ b/autotests/testOWE-transition/connection_test.py
@@ -230,16 +230,6 @@ class Test(unittest.TestCase):
         self.rule0.signal =3D -4000
         self.rule0.enabled =3D True
 =

-        devices =3D self.wd.list_devices(1)
-        device =3D devices[0]
-
-        device.scan()
-        condition =3D 'obj.scanning'
-        self.wd.wait_for_object_condition(device, condition)
-        condition =3D 'not obj.scanning'
-        self.wd.wait_for_object_condition(device, condition)
-
-
         self.validate(self.wd, self.hapd_owe)
 =

     def setUp(self):
diff --git a/autotests/testRSSIAgent/connection_test.py b/autotests/testRSS=
IAgent/connection_test.py
index ded09f6c..160a17b3 100644
--- a/autotests/testRSSIAgent/connection_test.py
+++ b/autotests/testRSSIAgent/connection_test.py
@@ -31,18 +31,7 @@ class Test(unittest.TestCase):
         agent.calls =3D 0
         device.register_signal_agent(agent, [-20, -40, -60, -80])
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        ordered_network =3D device.get_ordered_network('TestOpen')
+        ordered_network =3D device.get_ordered_network('TestOpen', full_sc=
an=3DTrue)
 =

         self.assertEqual(ordered_network.type, NetworkType.open)
         self.assertEqual(ordered_network.signal_strength, -4000)
diff --git a/autotests/testSAE-AntiClogging/clogging_test.py b/autotests/te=
stSAE-AntiClogging/clogging_test.py
index ddd1c7ab..172dfecf 100644
--- a/autotests/testSAE-AntiClogging/clogging_test.py
+++ b/autotests/testSAE-AntiClogging/clogging_test.py
@@ -21,16 +21,8 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(4)
         self.assertIsNotNone(devices)
 =

-        for d in devices:
-            d.disconnect()
-            d.scan()
-            wd.wait_for_object_condition(d, 'obj.scanning')
-
-        for d in devices:
-            wd.wait_for_object_condition(d, 'not obj.scanning')
-
         for i in range(len(devices)):
-            network =3D devices[i].get_ordered_network('ssidSAE-Clogging')
+            network =3D devices[i].get_ordered_network('ssidSAE-Clogging',=
 full_scan=3DTrue)
             self.assertEqual(network.type, NetworkType.psk)
             networks.append(network)
 =

diff --git a/autotests/testSAE-roam/connection_test.py b/autotests/testSAE-=
roam/connection_test.py
index 4c49eaf8..a276232e 100644
--- a/autotests/testSAE-roam/connection_test.py
+++ b/autotests/testSAE-roam/connection_test.py
@@ -16,16 +16,9 @@ class Test(unittest.TestCase):
     def validate_connection(self, wd, ft=3DTrue):
         device =3D wd.list_devices(1)[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
+        # This won't guarantee all BSS's are found, but at least ensures t=
hat
+        # at least one will be.
+        device.get_ordered_network('TestFT', full_scan=3DTrue)
 =

         self.assertFalse(self.bss_hostapd[0].list_sta())
         self.assertFalse(self.bss_hostapd[1].list_sta())
-- =

2.34.1

--===============7080262758773742649==--

