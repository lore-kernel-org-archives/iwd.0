Content-Type: multipart/mixed; boundary="===============6796677294512561484=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 01/15] auto-t: prepare autotests for test-runner re-write
Date: Fri, 28 Aug 2020 11:47:25 -0700
Message-ID: <20200828184739.8616-2-prestwoj@gmail.com>
In-Reply-To: <20200828184739.8616-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6796677294512561484==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The tests basically remained the same with a few minor changes.
The wiphy_map and in turn hostapd_map are no longer used. This
was already partially converted a long time ago when the 'config'
parameter was added to HostapdCLI. This patch fully converts all
autotests to use 'config' rather than looking up by interface.

Some test scripts were named 'test.py' which was fine before but
the new rewrite actually loads each python test as a module. The
name 'test' is too ambiguous and causes issues due to a native
python module with the same name. All of these files were
renamed to 'connection_test.py'.
---
 .../{test.py =3D> connection_test.py}           |  0
 .../testAP/{test.py =3D> connection_test.py}    |  9 ++--
 autotests/testAP/failure_test.py              |  6 +--
 autotests/testAPRoam/connection_test.py       |  2 -
 .../testBSSBlacklist/all_blacklisted_test.py  |  4 --
 autotests/testBSSBlacklist/bad_pass_test.py   |  4 --
 autotests/testBSSBlacklist/connection_test.py |  1 -
 .../testBSSBlacklist/temp_blacklist_test.py   |  4 --
 .../connect_command_test.py                   | 42 +++++++------------
 .../disconnect_by_ap_test.py                  |  4 +-
 autotests/testEAP-AKA/connection_test.py      |  1 -
 .../testEAP-PEAPv0-CryptoBinding/ISK_test.py  |  1 -
 .../NoISK_test.py                             |  1 -
 .../testEAP-PEAPv0-CryptoBinding/main.conf    |  2 -
 autotests/testEAP-PWD/connection_test.py      |  1 -
 autotests/testEAP-SIM/connection_test.py      |  1 -
 .../connection_test.py                        | 11 ++---
 .../testEAP-TTLS-CHAP/connection_test.py      |  1 -
 .../testEAP-TTLS-MSCHAP/connection_test.py    |  1 -
 autotests/testEAP-TTLS-PAP/connection_test.py |  1 -
 autotests/testEAP-WPS-Frag/wps_frag_test.py   |  4 +-
 autotests/testEAP-WPS/four_digit_pin_test.py  |  4 +-
 autotests/testEAP-WPS/pin_test.py             |  4 +-
 autotests/testEAP-WPS/push_button_test.py     |  5 +--
 autotests/testFILS/fils_256_test.py           |  1 -
 autotests/testFILS/fils_384_test.py           |  1 -
 .../{test.py =3D> connection_test.py}           |  2 +-
 .../{test.py =3D> connection_test.py}           |  2 +-
 .../{test.py =3D> connection_test.py}           |  2 +-
 .../{test.py =3D> connection_test.py}           |  2 +-
 .../{test.py =3D> connection_test.py}           | 18 +++++---
 .../{test.py =3D> connection_test.py}           |  2 +-
 .../{test.py =3D> connection_test.py}           |  2 +-
 autotests/testOWE/connection_test.py          |  1 -
 autotests/testOWE/renegotiate_test.py         |  1 -
 .../{test.py =3D> connection_test.py}           |  2 +-
 .../{test.py =3D> connection_test.py}           |  0
 autotests/testSAE/connection_test.py          | 10 ++---
 autotests/testSAE/group_20_connection_test.py | 10 ++---
 .../testSAQuery-spoofing/connection_test.py   |  2 +-
 autotests/testSAQuery/connection_test.py      |  2 +-
 41 files changed, 57 insertions(+), 117 deletions(-)
 rename autotests/testAP-no-support/{test.py =3D> connection_test.py} (100%)
 rename autotests/testAP/{test.py =3D> connection_test.py} (94%)
 delete mode 100644 autotests/testEAP-PEAPv0-CryptoBinding/main.conf
 rename autotests/testFT-8021x-roam/{test.py =3D> connection_test.py} (99%)
 rename autotests/testFT-FILS-SHA256/{test.py =3D> connection_test.py} (99%)
 rename autotests/testFT-FILS-SHA384/{test.py =3D> connection_test.py} (99%)
 rename autotests/testFT-PSK-over-DS/{test.py =3D> connection_test.py} (99%)
 rename autotests/testFT-PSK-roam/{test.py =3D> connection_test.py} (95%)
 rename autotests/testFT-SAE-roam/{test.py =3D> connection_test.py} (99%)
 rename autotests/testHT-VHT/{test.py =3D> connection_test.py} (98%)
 rename autotests/testPreauth-roam/{test.py =3D> connection_test.py} (98%)
 rename autotests/testRSSIAgent/{test.py =3D> connection_test.py} (100%)

diff --git a/autotests/testAP-no-support/test.py b/autotests/testAP-no-supp=
ort/connection_test.py
similarity index 100%
rename from autotests/testAP-no-support/test.py
rename to autotests/testAP-no-support/connection_test.py
diff --git a/autotests/testAP/test.py b/autotests/testAP/connection_test.py
similarity index 94%
rename from autotests/testAP/test.py
rename to autotests/testAP/connection_test.py
index 4cacf9ad..36302da1 100644
--- a/autotests/testAP/test.py
+++ b/autotests/testAP/connection_test.py
@@ -3,17 +3,17 @@
 import unittest
 import sys, os
 =

-sys.path.append('../util')
 import iwd
 from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
-import hostapd
+from hostapd import HostapdCLI
 import testutil
 =

 class Test(unittest.TestCase):
 =

     def client_connect(self, wd, dev):
+        hostapd =3D HostapdCLI(config=3D'psk-ccmp.conf')
 =

         ordered_network =3D dev.get_ordered_network('TestAP1', True)
 =

@@ -30,8 +30,7 @@ class Test(unittest.TestCase):
         wd.unregister_psk_agent(psk_agent)
 =

         testutil.test_iface_operstate(dev.name)
-        testutil.test_ifaces_connected(list(hostapd.hostapd_map.keys())[0],
-                                       dev.name)
+        testutil.test_ifaces_connected(hostapd.ifname, dev.name)
 =

         dev.disconnect()
 =

@@ -57,6 +56,7 @@ class Test(unittest.TestCase):
             wd.wait_for_object_condition(dev2, condition)
 =

             ordered_networks =3D dev2.get_ordered_networks()
+
             networks =3D { n.name: n for n in ordered_networks }
             self.assertEqual(networks['TestAP1'].type, NetworkType.psk)
             self.assertEqual(networks['TestAP2'].type, NetworkType.psk)
@@ -66,6 +66,7 @@ class Test(unittest.TestCase):
 =

             try:
                 dev2.disconnect()
+
                 condition =3D 'not obj.connected'
                 wd.wait_for_object_condition(dev2, condition)
             except:
diff --git a/autotests/testAP/failure_test.py b/autotests/testAP/failure_te=
st.py
index d30bccb4..a2622f45 100644
--- a/autotests/testAP/failure_test.py
+++ b/autotests/testAP/failure_test.py
@@ -8,12 +8,13 @@ import iwd
 from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
-import hostapd
+from hostapd import HostapdCLI
 import testutil
 =

 class Test(unittest.TestCase):
 =

     def client_connect(self, wd, dev):
+        hostapd =3D HostapdCLI(config=3D'psk-ccmp.conf')
 =

         ordered_network =3D dev.get_ordered_network('TestAP1', True)
 =

@@ -30,8 +31,7 @@ class Test(unittest.TestCase):
         wd.unregister_psk_agent(psk_agent)
 =

         testutil.test_iface_operstate(dev.name)
-        testutil.test_ifaces_connected(list(hostapd.hostapd_map.keys())[0],
-                                       dev.name)
+        testutil.test_ifaces_connected(hostapd.ifname, dev.name)
 =

         dev.disconnect()
 =

diff --git a/autotests/testAPRoam/connection_test.py b/autotests/testAPRoam=
/connection_test.py
index 292754c9..c8c2ca9f 100644
--- a/autotests/testAPRoam/connection_test.py
+++ b/autotests/testAPRoam/connection_test.py
@@ -10,8 +10,6 @@ from iwd import PSKAgent
 from iwd import NetworkType
 =

 from hostapd import HostapdCLI
-from hostapd import hostapd_map
-
 from hwsim import Hwsim
 =

 class Test(unittest.TestCase):
diff --git a/autotests/testBSSBlacklist/all_blacklisted_test.py b/autotests=
/testBSSBlacklist/all_blacklisted_test.py
index 78239309..099804a8 100644
--- a/autotests/testBSSBlacklist/all_blacklisted_test.py
+++ b/autotests/testBSSBlacklist/all_blacklisted_test.py
@@ -10,12 +10,8 @@ from iwd import PSKAgent
 from iwd import NetworkType
 =

 from hostapd import HostapdCLI
-from hostapd import hostapd_map
-
 from hwsim import Hwsim
 =

-import time
-
 class Test(unittest.TestCase):
 =

     def test_connection_success(self):
diff --git a/autotests/testBSSBlacklist/bad_pass_test.py b/autotests/testBS=
SBlacklist/bad_pass_test.py
index 3516f3be..220ffcc8 100644
--- a/autotests/testBSSBlacklist/bad_pass_test.py
+++ b/autotests/testBSSBlacklist/bad_pass_test.py
@@ -10,12 +10,8 @@ from iwd import PSKAgent
 from iwd import NetworkType
 =

 from hostapd import HostapdCLI
-from hostapd import hostapd_map
-
 from hwsim import Hwsim
 =

-import time
-
 class Test(unittest.TestCase):
 =

     def test_connection_success(self):
diff --git a/autotests/testBSSBlacklist/connection_test.py b/autotests/test=
BSSBlacklist/connection_test.py
index 7433d5f3..825439d4 100644
--- a/autotests/testBSSBlacklist/connection_test.py
+++ b/autotests/testBSSBlacklist/connection_test.py
@@ -10,7 +10,6 @@ from iwd import PSKAgent
 from iwd import NetworkType
 =

 from hostapd import HostapdCLI
-from hostapd import hostapd_map
 =

 from hwsim import Hwsim
 =

diff --git a/autotests/testBSSBlacklist/temp_blacklist_test.py b/autotests/=
testBSSBlacklist/temp_blacklist_test.py
index f43f807c..b2b57035 100644
--- a/autotests/testBSSBlacklist/temp_blacklist_test.py
+++ b/autotests/testBSSBlacklist/temp_blacklist_test.py
@@ -10,12 +10,8 @@ from iwd import PSKAgent
 from iwd import NetworkType
 =

 from hostapd import HostapdCLI
-from hostapd import hostapd_map
-
 from hwsim import Hwsim
 =

-import time
-
 class Test(unittest.TestCase):
 =

     def test_connection_success(self):
diff --git a/autotests/testClientNonInteractive/connect_command_test.py b/a=
utotests/testClientNonInteractive/connect_command_test.py
index 494f05d2..886d7a76 100644
--- a/autotests/testClientNonInteractive/connect_command_test.py
+++ b/autotests/testClientNonInteractive/connect_command_test.py
@@ -12,29 +12,25 @@ import subprocess
 class Test(unittest.TestCase):
 =

     def check_connection_success(self, ssid):
-        wd =3D IWD()
-
-        device =3D wd.list_devices(1)[0]
+        device =3D self.wd.list_devices(1)[0]
 =

         condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
+        self.wd.wait_for_object_condition(device, condition)
 =

         ordered_network =3D device.get_ordered_network(ssid)
 =

         condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        self.wd.wait_for_object_condition(ordered_network.network_object, =
condition)
 =

         device.disconnect()
 =

         condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        self.wd.wait_for_object_condition(ordered_network.network_object, =
condition)
 =

     def test_connection_with_passphrase(self):
         ssid =3D 'ssidPassphrase'
 =

-        wd =3D IWD()
-
-        device =3D wd.list_devices(1)[0]
+        device =3D self.wd.list_devices(1)[0]
 =

         # Use --dontaks cmd-line option
         with self.assertRaises(subprocess.CalledProcessError):
@@ -49,9 +45,7 @@ class Test(unittest.TestCase):
     def test_connection_with_username_and_password(self):
         ssid =3D 'ssidUNameAndPWord'
 =

-        wd =3D IWD()
-
-        device =3D wd.list_devices(1)[0]
+        device =3D self.wd.list_devices(1)[0]
 =

         subprocess.check_call(['iwctl', '-u', 'user', '-p', 'password',
                                 'station', device.name, 'connect', ssid])
@@ -61,9 +55,7 @@ class Test(unittest.TestCase):
     def test_connection_with_password(self):
         ssid =3D 'ssidPWord'
 =

-        wd =3D IWD()
-
-        device =3D wd.list_devices(1)[0]
+        device =3D self.wd.list_devices(1)[0]
 =

         subprocess.check_call(['iwctl', '-p', 'password',
                                 'station', device.name, 'connect', ssid])
@@ -73,9 +65,7 @@ class Test(unittest.TestCase):
     def test_connection_failure(self):
         ssid =3D 'ssidPassphrase'
 =

-        wd =3D IWD()
-
-        device =3D wd.list_devices(1)[0]
+        device =3D self.wd.list_devices(1)[0]
 =

         with self.assertRaises(subprocess.CalledProcessError):
                 subprocess.check_call(['iwctl', '-P', 'incorrect_passphras=
e',
@@ -84,18 +74,14 @@ class Test(unittest.TestCase):
     def test_invalid_command_line_option(self):
         ssid =3D 'ssidPassphrase'
 =

-        wd =3D IWD()
-
-        device =3D wd.list_devices(1)[0]
+        device =3D self.wd.list_devices(1)[0]
 =

         with self.assertRaises(subprocess.CalledProcessError):
                 subprocess.check_call(['iwctl', '-z',
                                 'station', device.name, 'connect', ssid])
 =

     def test_invalid_command(self):
-        wd =3D IWD()
-
-        device =3D wd.list_devices(1)[0]
+        device =3D self.wd.list_devices(1)[0]
 =

         with self.assertRaises(subprocess.CalledProcessError):
                 subprocess.check_call(['iwctl', 'inexistent', 'command'])
@@ -105,17 +91,17 @@ class Test(unittest.TestCase):
         IWD.copy_to_storage('ssidUNameAndPWord.8021x')
         IWD.copy_to_storage('ssidPWord.8021x')
 =

-        wd =3D IWD()
+        cls.wd =3D IWD()
 =

-        device =3D wd.list_devices(1)[0]
+        device =3D cls.wd.list_devices(1)[0]
 =

         condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
+        cls.wd.wait_for_object_condition(device, condition)
 =

         device.scan()
 =

         condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
+        cls.wd.wait_for_object_condition(device, condition)
 =

     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testDisconnectByAP/disconnect_by_ap_test.py b/autote=
sts/testDisconnectByAP/disconnect_by_ap_test.py
index 298d75c4..f003ec0c 100644
--- a/autotests/testDisconnectByAP/disconnect_by_ap_test.py
+++ b/autotests/testDisconnectByAP/disconnect_by_ap_test.py
@@ -10,7 +10,6 @@ from iwd import DeviceState
 from iwd import NetworkType
 =

 from hostapd import HostapdCLI
-from hostapd import hostapd_map
 =

 class Test(unittest.TestCase):
 =

@@ -20,8 +19,7 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        hostapd_if =3D list(hostapd_map.values())[0]
-        hostapd =3D HostapdCLI(hostapd_if)
+        hostapd =3D HostapdCLI(config=3D'ssidOpen.conf')
 =

         device.scan()
 =

diff --git a/autotests/testEAP-AKA/connection_test.py b/autotests/testEAP-A=
KA/connection_test.py
index bcdb1d92..c4b7c2f9 100644
--- a/autotests/testEAP-AKA/connection_test.py
+++ b/autotests/testEAP-AKA/connection_test.py
@@ -10,7 +10,6 @@ from iwd import NetworkType
 from hlrauc import AuthCenter
 =

 from hostapd import HostapdCLI
-from hostapd import hostapd_map
 =

 class Test(unittest.TestCase):
 =

diff --git a/autotests/testEAP-PEAPv0-CryptoBinding/ISK_test.py b/autotests=
/testEAP-PEAPv0-CryptoBinding/ISK_test.py
index 7ba49384..a25f99ef 100644
--- a/autotests/testEAP-PEAPv0-CryptoBinding/ISK_test.py
+++ b/autotests/testEAP-PEAPv0-CryptoBinding/ISK_test.py
@@ -11,7 +11,6 @@ from iwd import NetworkType
 import testutil
 =

 from hostapd import HostapdCLI
-from hostapd import hostapd_map
 =

 class Test(unittest.TestCase):
 =

diff --git a/autotests/testEAP-PEAPv0-CryptoBinding/NoISK_test.py b/autotes=
ts/testEAP-PEAPv0-CryptoBinding/NoISK_test.py
index 0f7d432c..33ff0285 100644
--- a/autotests/testEAP-PEAPv0-CryptoBinding/NoISK_test.py
+++ b/autotests/testEAP-PEAPv0-CryptoBinding/NoISK_test.py
@@ -11,7 +11,6 @@ from iwd import NetworkType
 import testutil
 =

 from hostapd import HostapdCLI
-from hostapd import hostapd_map
 =

 class Test(unittest.TestCase):
 =

diff --git a/autotests/testEAP-PEAPv0-CryptoBinding/main.conf b/autotests/t=
estEAP-PEAPv0-CryptoBinding/main.conf
deleted file mode 100644
index 55a5543e..00000000
--- a/autotests/testEAP-PEAPv0-CryptoBinding/main.conf
+++ /dev/null
@@ -1,2 +0,0 @@
-[General]
-UseDefaultInterface=3Dtrue
diff --git a/autotests/testEAP-PWD/connection_test.py b/autotests/testEAP-P=
WD/connection_test.py
index 0c722c44..2edc45b8 100644
--- a/autotests/testEAP-PWD/connection_test.py
+++ b/autotests/testEAP-PWD/connection_test.py
@@ -10,7 +10,6 @@ from iwd import PSKAgent
 from iwd import NetworkType
 =

 from hostapd import HostapdCLI
-from hostapd import hostapd_map
 =

 class Test(unittest.TestCase):
 =

diff --git a/autotests/testEAP-SIM/connection_test.py b/autotests/testEAP-S=
IM/connection_test.py
index 97956d0c..617d833b 100644
--- a/autotests/testEAP-SIM/connection_test.py
+++ b/autotests/testEAP-SIM/connection_test.py
@@ -10,7 +10,6 @@ from iwd import NetworkType
 from hlrauc import AuthCenter
 =

 from hostapd import HostapdCLI
-from hostapd import hostapd_map
 =

 class Test(unittest.TestCase):
 =

diff --git a/autotests/testEAP-TLS-embedded-pems/connection_test.py b/autot=
ests/testEAP-TLS-embedded-pems/connection_test.py
index 1102b810..5d46868d 100644
--- a/autotests/testEAP-TLS-embedded-pems/connection_test.py
+++ b/autotests/testEAP-TLS-embedded-pems/connection_test.py
@@ -9,23 +9,18 @@ from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
 import testutil
-import hostapd
+from hostapd import HostapdCLI
 =

 class Test(unittest.TestCase):
 =

     def do_test_connection_success(self, ssid, passphrase=3DNone):
+        hostapd =3D HostapdCLI(config=3Dssid + '.conf')
         wd =3D IWD()
 =

         if passphrase:
             psk_agent =3D PSKAgent(passphrase)
             wd.register_psk_agent(psk_agent)
 =

-        hostapd_ifname =3D None
-        for ifname in hostapd.hostapd_map:
-            if ssid + '.conf' in hostapd.hostapd_map[ifname].config:
-                hostapd_ifname =3D ifname
-                break
-
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

@@ -52,7 +47,7 @@ class Test(unittest.TestCase):
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
 =

         testutil.test_iface_operstate()
-        testutil.test_ifaces_connected(hostapd_ifname, device.name)
+        testutil.test_ifaces_connected(hostapd.ifname, device.name)
 =

         device.disconnect()
 =

diff --git a/autotests/testEAP-TTLS-CHAP/connection_test.py b/autotests/tes=
tEAP-TTLS-CHAP/connection_test.py
index e3719669..331e799f 100644
--- a/autotests/testEAP-TTLS-CHAP/connection_test.py
+++ b/autotests/testEAP-TTLS-CHAP/connection_test.py
@@ -11,7 +11,6 @@ from iwd import PSKAgent
 from iwd import NetworkType
 =

 from hostapd import HostapdCLI
-from hostapd import hostapd_map
 =

 class Test(unittest.TestCase):
 =

diff --git a/autotests/testEAP-TTLS-MSCHAP/connection_test.py b/autotests/t=
estEAP-TTLS-MSCHAP/connection_test.py
index ea245a38..973370a8 100644
--- a/autotests/testEAP-TTLS-MSCHAP/connection_test.py
+++ b/autotests/testEAP-TTLS-MSCHAP/connection_test.py
@@ -11,7 +11,6 @@ from iwd import PSKAgent
 from iwd import NetworkType
 =

 from hostapd import HostapdCLI
-from hostapd import hostapd_map
 =

 class Test(unittest.TestCase):
 =

diff --git a/autotests/testEAP-TTLS-PAP/connection_test.py b/autotests/test=
EAP-TTLS-PAP/connection_test.py
index ce787b01..a8f6fde7 100644
--- a/autotests/testEAP-TTLS-PAP/connection_test.py
+++ b/autotests/testEAP-TTLS-PAP/connection_test.py
@@ -11,7 +11,6 @@ from iwd import PSKAgent
 from iwd import NetworkType
 =

 from hostapd import HostapdCLI
-from hostapd import hostapd_map
 =

 class Test(unittest.TestCase):
 =

diff --git a/autotests/testEAP-WPS-Frag/wps_frag_test.py b/autotests/testEA=
P-WPS-Frag/wps_frag_test.py
index 9d106a75..b9be0159 100644
--- a/autotests/testEAP-WPS-Frag/wps_frag_test.py
+++ b/autotests/testEAP-WPS-Frag/wps_frag_test.py
@@ -9,7 +9,6 @@ from iwd import IWD
 from iwd import DeviceState
 =

 from hostapd import HostapdCLI
-from hostapd import hostapd_map
 =

 class Test(unittest.TestCase):
 =

@@ -32,8 +31,7 @@ class Test(unittest.TestCase):
 =

     @classmethod
     def setUpClass(cls):
-        cls.hostapd_if =3D list(hostapd_map.values())[0]
-        cls.hostapd =3D HostapdCLI(cls.hostapd_if)
+        cls.hostapd =3D HostapdCLI(config=3D'ssid-wps-small-mtu.conf')
 =

         cls.hostapd.wps_push_button()
 =

diff --git a/autotests/testEAP-WPS/four_digit_pin_test.py b/autotests/testE=
AP-WPS/four_digit_pin_test.py
index feb4222d..10afaa5d 100644
--- a/autotests/testEAP-WPS/four_digit_pin_test.py
+++ b/autotests/testEAP-WPS/four_digit_pin_test.py
@@ -9,7 +9,6 @@ from iwd import IWD
 from iwd import DeviceState
 =

 from hostapd import HostapdCLI
-from hostapd import hostapd_map
 =

 class Test(unittest.TestCase):
 =

@@ -39,8 +38,7 @@ class Test(unittest.TestCase):
 =

     @classmethod
     def setUpClass(cls):
-        cls.hostapd_if =3D list(hostapd_map.values())[0]
-        cls.hostapd =3D HostapdCLI(cls.hostapd_if)
+        cls.hostapd =3D HostapdCLI(config=3D'ssidWPS.conf')
 =

     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testEAP-WPS/pin_test.py b/autotests/testEAP-WPS/pin_=
test.py
index 080a91e1..706dc20b 100644
--- a/autotests/testEAP-WPS/pin_test.py
+++ b/autotests/testEAP-WPS/pin_test.py
@@ -9,7 +9,6 @@ from iwd import IWD
 from iwd import DeviceState
 =

 from hostapd import HostapdCLI
-from hostapd import hostapd_map
 =

 class Test(unittest.TestCase):
 =

@@ -42,8 +41,7 @@ class Test(unittest.TestCase):
 =

     @classmethod
     def setUpClass(cls):
-        cls.hostapd_if =3D list(hostapd_map.values())[0]
-        cls.hostapd =3D HostapdCLI(cls.hostapd_if)
+        cls.hostapd =3D HostapdCLI(config=3D'ssidWPS.conf')
 =

     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testEAP-WPS/push_button_test.py b/autotests/testEAP-=
WPS/push_button_test.py
index bbf09dcb..f82a56b5 100644
--- a/autotests/testEAP-WPS/push_button_test.py
+++ b/autotests/testEAP-WPS/push_button_test.py
@@ -9,8 +9,6 @@ from iwd import IWD
 from iwd import DeviceState
 =

 from hostapd import HostapdCLI
-from hostapd import hostapd_map
-
 class Test(unittest.TestCase):
 =

     def push_button_success(self, wd):
@@ -38,8 +36,7 @@ class Test(unittest.TestCase):
 =

     @classmethod
     def setUpClass(cls):
-        cls.hostapd_if =3D list(hostapd_map.values())[0]
-        cls.hostapd =3D HostapdCLI(cls.hostapd_if)
+        cls.hostapd =3D HostapdCLI(config=3D'ssidWPS.conf')
 =

     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testFILS/fils_256_test.py b/autotests/testFILS/fils_=
256_test.py
index aa9e441d..af033d4a 100644
--- a/autotests/testFILS/fils_256_test.py
+++ b/autotests/testFILS/fils_256_test.py
@@ -9,7 +9,6 @@ import iwd
 from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
-from hostapd import hostapd_map
 from hostapd import HostapdCLI
 import testutil
 =

diff --git a/autotests/testFILS/fils_384_test.py b/autotests/testFILS/fils_=
384_test.py
index ed5cc3b0..70e3bc87 100644
--- a/autotests/testFILS/fils_384_test.py
+++ b/autotests/testFILS/fils_384_test.py
@@ -9,7 +9,6 @@ import iwd
 from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
-from hostapd import hostapd_map
 from hostapd import HostapdCLI
 import testutil
 =

diff --git a/autotests/testFT-8021x-roam/test.py b/autotests/testFT-8021x-r=
oam/connection_test.py
similarity index 99%
rename from autotests/testFT-8021x-roam/test.py
rename to autotests/testFT-8021x-roam/connection_test.py
index 0e6f733e..65c73492 100644
--- a/autotests/testFT-8021x-roam/test.py
+++ b/autotests/testFT-8021x-roam/connection_test.py
@@ -8,7 +8,7 @@ import iwd
 from iwd import IWD
 from iwd import NetworkType
 from hwsim import Hwsim
-from hostapd import HostapdCLI, hostapd_map
+from hostapd import HostapdCLI
 import testutil
 =

 class Test(unittest.TestCase):
diff --git a/autotests/testFT-FILS-SHA256/test.py b/autotests/testFT-FILS-S=
HA256/connection_test.py
similarity index 99%
rename from autotests/testFT-FILS-SHA256/test.py
rename to autotests/testFT-FILS-SHA256/connection_test.py
index 7b800f1c..16f46210 100644
--- a/autotests/testFT-FILS-SHA256/test.py
+++ b/autotests/testFT-FILS-SHA256/connection_test.py
@@ -9,7 +9,7 @@ from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
 from hwsim import Hwsim
-from hostapd import HostapdCLI, hostapd_map
+from hostapd import HostapdCLI
 import testutil
 =

 class Test(unittest.TestCase):
diff --git a/autotests/testFT-FILS-SHA384/test.py b/autotests/testFT-FILS-S=
HA384/connection_test.py
similarity index 99%
rename from autotests/testFT-FILS-SHA384/test.py
rename to autotests/testFT-FILS-SHA384/connection_test.py
index 7b800f1c..16f46210 100644
--- a/autotests/testFT-FILS-SHA384/test.py
+++ b/autotests/testFT-FILS-SHA384/connection_test.py
@@ -9,7 +9,7 @@ from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
 from hwsim import Hwsim
-from hostapd import HostapdCLI, hostapd_map
+from hostapd import HostapdCLI
 import testutil
 =

 class Test(unittest.TestCase):
diff --git a/autotests/testFT-PSK-over-DS/test.py b/autotests/testFT-PSK-ov=
er-DS/connection_test.py
similarity index 99%
rename from autotests/testFT-PSK-over-DS/test.py
rename to autotests/testFT-PSK-over-DS/connection_test.py
index f3dd088c..2cfdf245 100644
--- a/autotests/testFT-PSK-over-DS/test.py
+++ b/autotests/testFT-PSK-over-DS/connection_test.py
@@ -9,7 +9,7 @@ from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
 from hwsim import Hwsim
-from hostapd import HostapdCLI, hostapd_map
+from hostapd import HostapdCLI
 import testutil
 =

 class Test(unittest.TestCase):
diff --git a/autotests/testFT-PSK-roam/test.py b/autotests/testFT-PSK-roam/=
connection_test.py
similarity index 95%
rename from autotests/testFT-PSK-roam/test.py
rename to autotests/testFT-PSK-roam/connection_test.py
index 2443593d..1b32cc0b 100644
--- a/autotests/testFT-PSK-roam/test.py
+++ b/autotests/testFT-PSK-roam/connection_test.py
@@ -9,7 +9,7 @@ from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
 from hwsim import Hwsim
-from hostapd import HostapdCLI, hostapd_map
+from hostapd import HostapdCLI
 import testutil
 =

 class Test(unittest.TestCase):
@@ -24,12 +24,14 @@ class Test(unittest.TestCase):
         rule1.source =3D self.bss_radio[1].addresses[0]
         rule1.bidirectional =3D True
 =

-        wd =3D IWD()
+        wd =3D self.wd
 =

         psk_agent =3D PSKAgent("EasilyGuessedPassword")
         wd.register_psk_agent(psk_agent)
 =

         device =3D wd.list_devices(1)[0]
+        # prevent autoconnect
+        device.disconnect()
 =

         # Check that iwd selects BSS 0 first
         rule0.signal =3D -2000
@@ -97,6 +99,7 @@ class Test(unittest.TestCase):
                           (self.bss_hostapd[0].ifname, device.name))
 =

     def test_roam_on_beacon_loss(self):
+        print("Starting test_roam_on_beacon_loss")
         hwsim =3D Hwsim()
 =

         rule0 =3D hwsim.rules.create()
@@ -107,12 +110,14 @@ class Test(unittest.TestCase):
         rule1.source =3D self.bss_radio[1].addresses[0]
         rule1.bidirectional =3D True
 =

-        wd =3D IWD()
+        wd =3D self.wd
 =

         psk_agent =3D PSKAgent("EasilyGuessedPassword")
         wd.register_psk_agent(psk_agent)
 =

         device =3D wd.list_devices(1)[0]
+        # prevent autoconnect
+        device.disconnect()
 =

         # Check that iwd selects BSS 0 first
         rule0.signal =3D -2000
@@ -176,6 +181,8 @@ class Test(unittest.TestCase):
         testutil.test_ifaces_connected(self.bss_hostapd[1].ifname, device.=
name)
         self.assertRaises(Exception, testutil.test_ifaces_connected,
                           (self.bss_hostapd[0].ifname, device.name))
+    def setUp(self):
+        self.wd =3D IWD()
 =

     def tearDown(self):
         os.system('ifconfig "' + self.bss_hostapd[0].ifname + '" down')
@@ -184,15 +191,14 @@ class Test(unittest.TestCase):
         os.system('ifconfig "' + self.bss_hostapd[1].ifname + '" up')
 =

         hwsim =3D Hwsim()
-        wd =3D IWD()
-        device =3D wd.list_devices(1)[0]
+        device =3D self.wd.list_devices(1)[0]
         try:
             device.disconnect()
         except:
             pass
 =

         condition =3D 'obj.state =3D=3D DeviceState.disconnected'
-        wd.wait_for_object_condition(device, condition)
+        self.wd.wait_for_object_condition(device, condition)
 =

         for rule in list(hwsim.rules.keys()):
             del hwsim.rules[rule]
diff --git a/autotests/testFT-SAE-roam/test.py b/autotests/testFT-SAE-roam/=
connection_test.py
similarity index 99%
rename from autotests/testFT-SAE-roam/test.py
rename to autotests/testFT-SAE-roam/connection_test.py
index 9c2b3ee1..3e209560 100644
--- a/autotests/testFT-SAE-roam/test.py
+++ b/autotests/testFT-SAE-roam/connection_test.py
@@ -9,7 +9,7 @@ from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
 from hwsim import Hwsim
-from hostapd import HostapdCLI, hostapd_map
+from hostapd import HostapdCLI
 import testutil
 =

 class Test(unittest.TestCase):
diff --git a/autotests/testHT-VHT/test.py b/autotests/testHT-VHT/connection=
_test.py
similarity index 98%
rename from autotests/testHT-VHT/test.py
rename to autotests/testHT-VHT/connection_test.py
index 0129d8a0..e4781ea0 100644
--- a/autotests/testHT-VHT/test.py
+++ b/autotests/testHT-VHT/connection_test.py
@@ -9,9 +9,9 @@ from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
 from hwsim import Hwsim
-from hostapd import HostapdCLI, hostapd_map
 import testutil
 from time import sleep
+from hostapd import HostapdCLI
 =

 class Test(unittest.TestCase):
     def do_connect(self, wd, device, hostapd):
diff --git a/autotests/testOWE/connection_test.py b/autotests/testOWE/conne=
ction_test.py
index e4482bc0..539b06d0 100644
--- a/autotests/testOWE/connection_test.py
+++ b/autotests/testOWE/connection_test.py
@@ -7,7 +7,6 @@ sys.path.append('../util')
 import iwd
 from iwd import IWD
 from iwd import NetworkType
-from hostapd import hostapd_map
 from hostapd import HostapdCLI
 import testutil
 =

diff --git a/autotests/testOWE/renegotiate_test.py b/autotests/testOWE/rene=
gotiate_test.py
index 57705a59..7c736acd 100644
--- a/autotests/testOWE/renegotiate_test.py
+++ b/autotests/testOWE/renegotiate_test.py
@@ -7,7 +7,6 @@ sys.path.append('../util')
 import iwd
 from iwd import IWD
 from iwd import NetworkType
-from hostapd import hostapd_map
 from hostapd import HostapdCLI
 import testutil
 =

diff --git a/autotests/testPreauth-roam/test.py b/autotests/testPreauth-roa=
m/connection_test.py
similarity index 98%
rename from autotests/testPreauth-roam/test.py
rename to autotests/testPreauth-roam/connection_test.py
index 06babcea..ed043c3f 100644
--- a/autotests/testPreauth-roam/test.py
+++ b/autotests/testPreauth-roam/connection_test.py
@@ -9,7 +9,7 @@ from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
 from hwsim import Hwsim
-from hostapd import HostapdCLI, hostapd_map
+from hostapd import HostapdCLI
 import testutil
 =

 class Test(unittest.TestCase):
diff --git a/autotests/testRSSIAgent/test.py b/autotests/testRSSIAgent/conn=
ection_test.py
similarity index 100%
rename from autotests/testRSSIAgent/test.py
rename to autotests/testRSSIAgent/connection_test.py
diff --git a/autotests/testSAE/connection_test.py b/autotests/testSAE/conne=
ction_test.py
index 874eb833..56bb1f6d 100644
--- a/autotests/testSAE/connection_test.py
+++ b/autotests/testSAE/connection_test.py
@@ -8,17 +8,13 @@ import iwd
 from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
-from hostapd import hostapd_map
+from hostapd import HostapdCLI
 import testutil
 =

 class Test(unittest.TestCase):
 =

     def validate_connection(self, wd):
-        hostapd_if =3D None
-
-        for hostapd in hostapd_map.values():
-            if hostapd.config =3D=3D 'ssidSAE.conf':
-                hostapd_if =3D hostapd.name
+        hostapd =3D HostapdCLI(config=3D'ssidSAE.conf')
 =

         psk_agent =3D PSKAgent("secret123")
         wd.register_psk_agent(psk_agent)
@@ -56,7 +52,7 @@ class Test(unittest.TestCase):
         wd.wait(2)
 =

         testutil.test_iface_operstate(intf=3Ddevice.name)
-        testutil.test_ifaces_connected(if0=3Ddevice.name, if1=3Dhostapd_if)
+        testutil.test_ifaces_connected(if0=3Ddevice.name, if1=3Dhostapd.if=
name)
 =

         device.disconnect()
 =

diff --git a/autotests/testSAE/group_20_connection_test.py b/autotests/test=
SAE/group_20_connection_test.py
index 033c8850..5631878a 100644
--- a/autotests/testSAE/group_20_connection_test.py
+++ b/autotests/testSAE/group_20_connection_test.py
@@ -8,17 +8,13 @@ import iwd
 from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
-from hostapd import hostapd_map
+from hostapd import HostapdCLI
 import testutil
 =

 class Test(unittest.TestCase):
 =

     def validate_connection(self, wd):
-        hostapd_if =3D None
-
-        for hostapd in hostapd_map.values():
-            if hostapd.config =3D=3D 'ssidSAE-20.conf':
-                hostapd_if =3D hostapd.name
+        hostapd =3D HostapdCLI(config=3D'ssidSAE-20.conf')
 =

         psk_agent =3D PSKAgent("secret123")
         wd.register_psk_agent(psk_agent)
@@ -56,7 +52,7 @@ class Test(unittest.TestCase):
         wd.wait(2)
 =

         testutil.test_iface_operstate(intf=3Ddevice.name)
-        testutil.test_ifaces_connected(if0=3Ddevice.name, if1=3Dhostapd_if)
+        testutil.test_ifaces_connected(if0=3Ddevice.name, if1=3Dhostapd.if=
name)
 =

         device.disconnect()
 =

diff --git a/autotests/testSAQuery-spoofing/connection_test.py b/autotests/=
testSAQuery-spoofing/connection_test.py
index e9d31c15..4887b172 100644
--- a/autotests/testSAQuery-spoofing/connection_test.py
+++ b/autotests/testSAQuery-spoofing/connection_test.py
@@ -9,7 +9,7 @@ from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
 from hwsim import Hwsim
-from hostapd import HostapdCLI, hostapd_map
+from hostapd import HostapdCLI
 =

 from time import sleep
 =

diff --git a/autotests/testSAQuery/connection_test.py b/autotests/testSAQue=
ry/connection_test.py
index de0fe2cd..9ea95e2b 100644
--- a/autotests/testSAQuery/connection_test.py
+++ b/autotests/testSAQuery/connection_test.py
@@ -8,7 +8,7 @@ import iwd
 from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
-from hostapd import HostapdCLI, hostapd_map
+from hostapd import HostapdCLI
 =

 class Test(unittest.TestCase):
 =

-- =

2.21.1

--===============6796677294512561484==--

