Content-Type: multipart/mixed; boundary="===============1351547228590535240=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/7] auto-t: update all tests to remove bad scanning logic
Date: Thu, 12 Aug 2021 13:38:11 -0700
Message-ID: <20210812203812.738060-6-prestwoj@gmail.com>
In-Reply-To: <20210812203812.738060-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1351547228590535240==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This changes all tests to use the default get_ordered_network behavior
rather than some custom or incorrect logic. Any use of
scan_if_needed=3DTrue has been removed since this is now the default.
Also any explicit scanning has been removed for tests which do not
require it (where the default behavior is good enough).
---
 autotests/testAP/connection_test.py            |  2 +-
 .../connection_test.py                         |  8 --------
 autotests/testAgent/agent_test.py              |  2 +-
 .../testBSSBlacklist/all_blacklisted_test.py   |  2 +-
 autotests/testBSSBlacklist/bad_pass_test.py    |  2 +-
 autotests/testBSSBlacklist/connection_test.py  |  2 +-
 .../testBSSBlacklist/temp_blacklist_test.py    | 18 +-----------------
 .../connect_command_test.py                    |  3 +++
 .../testDisconnectOnConnect/connection_test.py |  8 --------
 autotests/testEAP-AKA-ofono/connection_test.py |  8 --------
 .../testEAP-AKA-prime-ofono/connection_test.py |  8 --------
 .../testEAP-PEAP-GTC/peap_gtc_nosecret_test.py |  8 --------
 autotests/testEAP-PEAP-GTC/peap_gtc_test.py    |  8 --------
 .../testEAP-PEAP-MSCHAPv2/connection_test.py   |  8 --------
 autotests/testEAP-PEAP-SIM/connection_test.py  |  8 --------
 autotests/testEAP-PEAP/peap_frag_test.py       |  8 --------
 autotests/testEAP-PEAP/peap_v0_test.py         |  8 --------
 autotests/testEAP-PEAP/peap_v1_test.py         |  8 --------
 .../testEAP-PEAPv0-CryptoBinding/ISK_test.py   |  8 --------
 .../testEAP-PEAPv0-CryptoBinding/NoISK_test.py |  8 --------
 autotests/testEAP-PWD/connection_test.py       |  8 --------
 autotests/testEAP-PWD/frag_test.py             |  8 --------
 autotests/testEAP-SIM-ofono/connection_test.py |  8 --------
 autotests/testEAP-TLS-Frag/connection_test.py  |  8 --------
 .../connection_test.py                         | 10 ----------
 autotests/testEAP-TLS/connection_test.py       | 10 ----------
 .../testEAP-TLSwithMFPC/connection_test.py     |  8 --------
 .../testEAP-TLSwithMFPR/connection_test.py     |  8 --------
 autotests/testEAP-TTLS-CHAP/connection_test.py |  8 --------
 .../connection_test.py                         | 10 ----------
 autotests/testEAP-TTLS-Frag/connection_test.py |  8 --------
 .../testEAP-TTLS-MSCHAP/connection_test.py     |  8 --------
 .../testEAP-TTLS-MSCHAPv2/connection_test.py   | 11 +----------
 .../testEAP-TTLS-MSCHAPv2/failure_test.py      | 11 +----------
 autotests/testEAP-TTLS-PAP/connection_test.py  |  8 --------
 autotests/testEAP-TTLS/connection_test.py      |  8 --------
 autotests/testFILS/fils_256_test.py            |  8 --------
 autotests/testFILS/fils_384_test.py            |  8 --------
 autotests/testFT-8021x-roam/connection_test.py |  2 +-
 autotests/testHT-VHT/connection_test.py        |  6 +++++-
 .../connect_after_hidden_connect_test.py       |  3 +--
 autotests/testHotspot/anqp_delay_test.py       | 13 ++++++++++++-
 autotests/testHotspot/hessid_test.py           |  8 --------
 autotests/testHotspot/hotspot_test.py          |  8 --------
 autotests/testHotspot/roaming_test.py          |  8 --------
 autotests/testKnownNetworks/frequency_test.py  |  8 --------
 .../testKnownNetworks/known_network_test.py    |  8 --------
 autotests/testMFP-Options/connection_test.py   |  8 --------
 autotests/testNetconfig/connection_test.py     |  8 --------
 autotests/testNetconfig/static_test.py         |  8 --------
 autotests/testOWE/connection_test.py           |  4 ++--
 autotests/testOWE/timeout_test.py              | 11 -----------
 autotests/testOpen/connection_test.py          |  8 --------
 autotests/testPreauth-roam/connection_test.py  |  2 +-
 autotests/testRRM/connection_test.py           |  8 --------
 autotests/testRoamRetry/fast_retry_test.py     |  8 --------
 autotests/testRoamRetry/stop_retry_test.py     |  8 --------
 autotests/testSAE/connection_test.py           |  7 ++++++-
 autotests/testSAE/failure_test.py              |  8 --------
 autotests/testSAE/timeout_test.py              |  8 --------
 .../testSAQuery-spoofing/connection_test.py    |  5 +----
 autotests/testSAQuery/connection_test.py       |  8 --------
 autotests/testWPA/connection_test.py           |  8 --------
 autotests/testWPA2-SHA256/connection_test.py   |  8 --------
 autotests/testWPA2-no-CCMP/connection_test.py  |  8 --------
 autotests/testWPA2/connection_test.py          |  8 --------
 autotests/testWPA2/failure_test.py             |  8 --------
 autotests/testWPA2/password_test.py            | 10 ----------
 autotests/testWPA2withMFP/connection_test.py   |  8 --------
 69 files changed, 40 insertions(+), 482 deletions(-)

diff --git a/autotests/testAP/connection_test.py b/autotests/testAP/connect=
ion_test.py
index 754ce952..1bba5f35 100644
--- a/autotests/testAP/connection_test.py
+++ b/autotests/testAP/connection_test.py
@@ -15,7 +15,7 @@ class Test(unittest.TestCase):
     def client_connect(self, wd, dev):
         hostapd =3D HostapdCLI(config=3D'psk-ccmp.conf')
 =

-        ordered_network =3D dev.get_ordered_network('TestAP1', True)
+        ordered_network =3D dev.get_ordered_network('TestAP1')
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
 =

diff --git a/autotests/testAddressRandomization/connection_test.py b/autote=
sts/testAddressRandomization/connection_test.py
index d9806f8a..32163e0f 100644
--- a/autotests/testAddressRandomization/connection_test.py
+++ b/autotests/testAddressRandomization/connection_test.py
@@ -45,14 +45,6 @@ class Test(unittest.TestCase):
 =

         perm_addr =3D device.address
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         # 1. Test per-network deterministic MAC generation
         os.system('cat pernetwork.psk > /tmp/iwd/ssidCCMP.psk')
         new_addr =3D self.try_connection(wd)
diff --git a/autotests/testAgent/agent_test.py b/autotests/testAgent/agent_=
test.py
index 60465d3f..7d3b6119 100644
--- a/autotests/testAgent/agent_test.py
+++ b/autotests/testAgent/agent_test.py
@@ -17,7 +17,7 @@ class Test(unittest.TestCase):
     def check_connection(self, wd, ssid):
 =

         device =3D wd.list_devices(1)[0]
-        ordered_network =3D device.get_ordered_network(ssid, scan_if_neede=
d=3DTrue)
+        ordered_network =3D device.get_ordered_network(ssid)
 =

         ordered_network.network_object.connect()
 =

diff --git a/autotests/testBSSBlacklist/all_blacklisted_test.py b/autotests=
/testBSSBlacklist/all_blacklisted_test.py
index b52d0900..4d8cca1e 100644
--- a/autotests/testBSSBlacklist/all_blacklisted_test.py
+++ b/autotests/testBSSBlacklist/all_blacklisted_test.py
@@ -47,7 +47,7 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        ordered_network =3D device.get_ordered_network("TestBlacklist", sc=
an_if_needed=3DTrue)
+        ordered_network =3D device.get_ordered_network("TestBlacklist")
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
 =

diff --git a/autotests/testBSSBlacklist/bad_pass_test.py b/autotests/testBS=
SBlacklist/bad_pass_test.py
index 1d41f390..5ea5df0c 100644
--- a/autotests/testBSSBlacklist/bad_pass_test.py
+++ b/autotests/testBSSBlacklist/bad_pass_test.py
@@ -47,7 +47,7 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        ordered_network =3D device.get_ordered_network("TestBlacklist", sc=
an_if_needed=3DTrue)
+        ordered_network =3D device.get_ordered_network("TestBlacklist")
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
 =

diff --git a/autotests/testBSSBlacklist/connection_test.py b/autotests/test=
BSSBlacklist/connection_test.py
index 58931d3e..23b56b57 100644
--- a/autotests/testBSSBlacklist/connection_test.py
+++ b/autotests/testBSSBlacklist/connection_test.py
@@ -51,7 +51,7 @@ class Test(unittest.TestCase):
 =

         devices[1].disconnect()
 =

-        ordered_network =3D device.get_ordered_network("TestBlacklist", sc=
an_if_needed=3DTrue)
+        ordered_network =3D device.get_ordered_network("TestBlacklist")
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
 =

diff --git a/autotests/testBSSBlacklist/temp_blacklist_test.py b/autotests/=
testBSSBlacklist/temp_blacklist_test.py
index 02438f89..cbd07ad2 100644
--- a/autotests/testBSSBlacklist/temp_blacklist_test.py
+++ b/autotests/testBSSBlacklist/temp_blacklist_test.py
@@ -46,7 +46,7 @@ class Test(unittest.TestCase):
 =

         dev1, dev2 =3D wd.list_devices(2)
 =

-        ordered_network =3D dev1.get_ordered_network("TestBlacklist", scan=
_if_needed=3DTrue)
+        ordered_network =3D dev1.get_ordered_network("TestBlacklist")
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
 =

@@ -63,14 +63,6 @@ class Test(unittest.TestCase):
         # dev1 now connected, this should max out the first AP, causing th=
e next
         # connection to fail to this AP.
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(dev2, condition)
-
-        dev2.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(dev2, condition)
-
         ordered_network =3D dev2.get_ordered_network("TestBlacklist")
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
@@ -92,14 +84,6 @@ class Test(unittest.TestCase):
         dev1.disconnect()
         dev2.disconnect()
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(dev2, condition)
-
-        dev2.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(dev2, condition)
-
         ordered_network =3D dev2.get_ordered_network("TestBlacklist")
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
diff --git a/autotests/testClientNonInteractive/connect_command_test.py b/a=
utotests/testClientNonInteractive/connect_command_test.py
index 247b40c7..8ca7ad42 100644
--- a/autotests/testClientNonInteractive/connect_command_test.py
+++ b/autotests/testClientNonInteractive/connect_command_test.py
@@ -98,6 +98,9 @@ class Test(unittest.TestCase):
 =

         device.scan()
 =

+        condition =3D 'obj.scanning'
+        cls.wd.wait_for_object_condition(device, condition)
+
         condition =3D 'not obj.scanning'
         cls.wd.wait_for_object_condition(device, condition)
 =

diff --git a/autotests/testDisconnectOnConnect/connection_test.py b/autotes=
ts/testDisconnectOnConnect/connection_test.py
index 7e36d4aa..2fc6fb89 100644
--- a/autotests/testDisconnectOnConnect/connection_test.py
+++ b/autotests/testDisconnectOnConnect/connection_test.py
@@ -20,14 +20,6 @@ class Test(unittest.TestCase):
 =

         device =3D wd.list_devices(1)[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         wpa_net =3D device.get_ordered_network('ssidTKIP')
         self.assertEqual(wpa_net.type, NetworkType.psk)
 =

diff --git a/autotests/testEAP-AKA-ofono/connection_test.py b/autotests/tes=
tEAP-AKA-ofono/connection_test.py
index 7b1a8c37..1b250da2 100644
--- a/autotests/testEAP-AKA-ofono/connection_test.py
+++ b/autotests/testEAP-AKA-ofono/connection_test.py
@@ -22,14 +22,6 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidEAP-AKA')
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
diff --git a/autotests/testEAP-AKA-prime-ofono/connection_test.py b/autotes=
ts/testEAP-AKA-prime-ofono/connection_test.py
index dc8f04bf..5edf4965 100644
--- a/autotests/testEAP-AKA-prime-ofono/connection_test.py
+++ b/autotests/testEAP-AKA-prime-ofono/connection_test.py
@@ -22,14 +22,6 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidEAP-AKA')
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
diff --git a/autotests/testEAP-PEAP-GTC/peap_gtc_nosecret_test.py b/autotes=
ts/testEAP-PEAP-GTC/peap_gtc_nosecret_test.py
index 16203c68..a4903dbd 100644
--- a/autotests/testEAP-PEAP-GTC/peap_gtc_nosecret_test.py
+++ b/autotests/testEAP-PEAP-GTC/peap_gtc_nosecret_test.py
@@ -18,14 +18,6 @@ class Test(unittest.TestCase):
         self.assertIsNotNone(devices)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidEAP-PEAPv1-GTC=
-nosecret')
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
diff --git a/autotests/testEAP-PEAP-GTC/peap_gtc_test.py b/autotests/testEA=
P-PEAP-GTC/peap_gtc_test.py
index f3bea378..c5ccb50f 100644
--- a/autotests/testEAP-PEAP-GTC/peap_gtc_test.py
+++ b/autotests/testEAP-PEAP-GTC/peap_gtc_test.py
@@ -17,14 +17,6 @@ class Test(unittest.TestCase):
         self.assertIsNotNone(devices)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidEAP-PEAPv1-GTC=
')
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
diff --git a/autotests/testEAP-PEAP-MSCHAPv2/connection_test.py b/autotests=
/testEAP-PEAP-MSCHAPv2/connection_test.py
index 7998fa07..017729cf 100644
--- a/autotests/testEAP-PEAP-MSCHAPv2/connection_test.py
+++ b/autotests/testEAP-PEAP-MSCHAPv2/connection_test.py
@@ -17,14 +17,6 @@ class Test(unittest.TestCase):
         self.assertIsNotNone(devices)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidEAP-PEAP-MSCHA=
Pv2')
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
diff --git a/autotests/testEAP-PEAP-SIM/connection_test.py b/autotests/test=
EAP-PEAP-SIM/connection_test.py
index 4183e65e..ebf22a46 100644
--- a/autotests/testEAP-PEAP-SIM/connection_test.py
+++ b/autotests/testEAP-PEAP-SIM/connection_test.py
@@ -17,14 +17,6 @@ class Test(unittest.TestCase):
         self.assertIsNotNone(devices)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidEAP-PEAP-SIM')
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
diff --git a/autotests/testEAP-PEAP/peap_frag_test.py b/autotests/testEAP-P=
EAP/peap_frag_test.py
index 8bae8bd9..c5a7ccff 100644
--- a/autotests/testEAP-PEAP/peap_frag_test.py
+++ b/autotests/testEAP-PEAP/peap_frag_test.py
@@ -16,14 +16,6 @@ class Test(unittest.TestCase):
         self.assertIsNotNone(devices)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidEAP-PEAP-frag')
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
diff --git a/autotests/testEAP-PEAP/peap_v0_test.py b/autotests/testEAP-PEA=
P/peap_v0_test.py
index 4ad73c20..ea93ff6f 100644
--- a/autotests/testEAP-PEAP/peap_v0_test.py
+++ b/autotests/testEAP-PEAP/peap_v0_test.py
@@ -16,14 +16,6 @@ class Test(unittest.TestCase):
         self.assertIsNotNone(devices)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidEAP-PEAPv0')
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
diff --git a/autotests/testEAP-PEAP/peap_v1_test.py b/autotests/testEAP-PEA=
P/peap_v1_test.py
index efd55337..16f38d92 100644
--- a/autotests/testEAP-PEAP/peap_v1_test.py
+++ b/autotests/testEAP-PEAP/peap_v1_test.py
@@ -16,14 +16,6 @@ class Test(unittest.TestCase):
         self.assertIsNotNone(devices)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidEAP-PEAPv1')
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
diff --git a/autotests/testEAP-PEAPv0-CryptoBinding/ISK_test.py b/autotests=
/testEAP-PEAPv0-CryptoBinding/ISK_test.py
index 5febc8db..07382623 100644
--- a/autotests/testEAP-PEAPv0-CryptoBinding/ISK_test.py
+++ b/autotests/testEAP-PEAPv0-CryptoBinding/ISK_test.py
@@ -19,14 +19,6 @@ class Test(unittest.TestCase):
         self.assertIsNotNone(devices)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidEAP-PEAPv0-ISK=
')
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
diff --git a/autotests/testEAP-PEAPv0-CryptoBinding/NoISK_test.py b/autotes=
ts/testEAP-PEAPv0-CryptoBinding/NoISK_test.py
index 638ad4b3..9a1fa52c 100644
--- a/autotests/testEAP-PEAPv0-CryptoBinding/NoISK_test.py
+++ b/autotests/testEAP-PEAPv0-CryptoBinding/NoISK_test.py
@@ -23,14 +23,6 @@ class Test(unittest.TestCase):
         self.assertIsNotNone(devices)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidEAP-PEAPv0-NoI=
SK')
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
diff --git a/autotests/testEAP-PWD/connection_test.py b/autotests/testEAP-P=
WD/connection_test.py
index de3c6122..c7ca89af 100644
--- a/autotests/testEAP-PWD/connection_test.py
+++ b/autotests/testEAP-PWD/connection_test.py
@@ -26,14 +26,6 @@ class Test(unittest.TestCase):
         self.assertIsNotNone(devices)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidEAP-PWD')
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
diff --git a/autotests/testEAP-PWD/frag_test.py b/autotests/testEAP-PWD/fra=
g_test.py
index bb6103bd..668beb4b 100644
--- a/autotests/testEAP-PWD/frag_test.py
+++ b/autotests/testEAP-PWD/frag_test.py
@@ -15,14 +15,6 @@ class Test(unittest.TestCase):
         self.assertIsNotNone(devices)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidEAP-PWD-frag')
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
diff --git a/autotests/testEAP-SIM-ofono/connection_test.py b/autotests/tes=
tEAP-SIM-ofono/connection_test.py
index 9f5f2734..b66bc9c7 100644
--- a/autotests/testEAP-SIM-ofono/connection_test.py
+++ b/autotests/testEAP-SIM-ofono/connection_test.py
@@ -23,14 +23,6 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidEAP-SIM')
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
diff --git a/autotests/testEAP-TLS-Frag/connection_test.py b/autotests/test=
EAP-TLS-Frag/connection_test.py
index 3e155eea..d5a5a076 100644
--- a/autotests/testEAP-TLS-Frag/connection_test.py
+++ b/autotests/testEAP-TLS-Frag/connection_test.py
@@ -16,14 +16,6 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidEAP-TLS')
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
diff --git a/autotests/testEAP-TLS-embedded-pems/connection_test.py b/autot=
ests/testEAP-TLS-embedded-pems/connection_test.py
index 5d3c0c40..1ca2bed4 100644
--- a/autotests/testEAP-TLS-embedded-pems/connection_test.py
+++ b/autotests/testEAP-TLS-embedded-pems/connection_test.py
@@ -24,16 +24,6 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        if not device.get_ordered_networks():
-            device.scan()
-            condition =3D 'obj.scanning'
-            wd.wait_for_object_condition(device, condition)
-            condition =3D 'not obj.scanning'
-            wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network(ssid)
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
diff --git a/autotests/testEAP-TLS/connection_test.py b/autotests/testEAP-T=
LS/connection_test.py
index c90b0ceb..ab096e72 100644
--- a/autotests/testEAP-TLS/connection_test.py
+++ b/autotests/testEAP-TLS/connection_test.py
@@ -24,16 +24,6 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        if not device.get_ordered_networks():
-            device.scan()
-            condition =3D 'obj.scanning'
-            wd.wait_for_object_condition(device, condition)
-            condition =3D 'not obj.scanning'
-            wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network(ssid)
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
diff --git a/autotests/testEAP-TLSwithMFPC/connection_test.py b/autotests/t=
estEAP-TLSwithMFPC/connection_test.py
index 3e155eea..d5a5a076 100644
--- a/autotests/testEAP-TLSwithMFPC/connection_test.py
+++ b/autotests/testEAP-TLSwithMFPC/connection_test.py
@@ -16,14 +16,6 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidEAP-TLS')
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
diff --git a/autotests/testEAP-TLSwithMFPR/connection_test.py b/autotests/t=
estEAP-TLSwithMFPR/connection_test.py
index 3e155eea..d5a5a076 100644
--- a/autotests/testEAP-TLSwithMFPR/connection_test.py
+++ b/autotests/testEAP-TLSwithMFPR/connection_test.py
@@ -16,14 +16,6 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidEAP-TLS')
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
diff --git a/autotests/testEAP-TTLS-CHAP/connection_test.py b/autotests/tes=
tEAP-TTLS-CHAP/connection_test.py
index 0d7d87ab..0cbe251f 100644
--- a/autotests/testEAP-TTLS-CHAP/connection_test.py
+++ b/autotests/testEAP-TTLS-CHAP/connection_test.py
@@ -26,14 +26,6 @@ class Test(unittest.TestCase):
 =

         device =3D wd.list_devices(1)[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidEAP-TTLS-CHAP')
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
diff --git a/autotests/testEAP-TTLS-EAP-MSCHAPV2/connection_test.py b/autot=
ests/testEAP-TTLS-EAP-MSCHAPV2/connection_test.py
index a9832674..fcfdcb86 100644
--- a/autotests/testEAP-TTLS-EAP-MSCHAPV2/connection_test.py
+++ b/autotests/testEAP-TTLS-EAP-MSCHAPV2/connection_test.py
@@ -21,16 +21,6 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        if not device.get_ordered_networks():
-            device.scan()
-            condition =3D 'obj.scanning'
-            wd.wait_for_object_condition(device, condition)
-            condition =3D 'not obj.scanning'
-            wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidEAP-TTLS')
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
diff --git a/autotests/testEAP-TTLS-Frag/connection_test.py b/autotests/tes=
tEAP-TTLS-Frag/connection_test.py
index ef29425d..226e7af5 100644
--- a/autotests/testEAP-TTLS-Frag/connection_test.py
+++ b/autotests/testEAP-TTLS-Frag/connection_test.py
@@ -16,14 +16,6 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidEAP-TTLS')
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
diff --git a/autotests/testEAP-TTLS-MSCHAP/connection_test.py b/autotests/t=
estEAP-TTLS-MSCHAP/connection_test.py
index 1e60fd3e..4832eaae 100644
--- a/autotests/testEAP-TTLS-MSCHAP/connection_test.py
+++ b/autotests/testEAP-TTLS-MSCHAP/connection_test.py
@@ -26,14 +26,6 @@ class Test(unittest.TestCase):
 =

         device =3D wd.list_devices(1)[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidEAP-TTLS-MSCHA=
P')
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
diff --git a/autotests/testEAP-TTLS-MSCHAPv2/connection_test.py b/autotests=
/testEAP-TTLS-MSCHAPv2/connection_test.py
index 78a11087..05f6a604 100644
--- a/autotests/testEAP-TTLS-MSCHAPv2/connection_test.py
+++ b/autotests/testEAP-TTLS-MSCHAPv2/connection_test.py
@@ -24,16 +24,7 @@ class Test(unittest.TestCase):
 =

         device =3D wd.list_devices(1)[0];
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        ordered_networks =3D device.get_ordered_networks()
-        ordered_network =3D ordered_networks[0]
+        ordered_network =3D device.get_ordered_network('ssidEAP-TTLS-MSCHA=
Pv2')
 =

         self.assertEqual(ordered_network.name, "ssidEAP-TTLS-MSCHAPv2")
         self.assertEqual(ordered_network.type, NetworkType.eap)
diff --git a/autotests/testEAP-TTLS-MSCHAPv2/failure_test.py b/autotests/te=
stEAP-TTLS-MSCHAPv2/failure_test.py
index b4c3c003..5fc4e5b9 100644
--- a/autotests/testEAP-TTLS-MSCHAPv2/failure_test.py
+++ b/autotests/testEAP-TTLS-MSCHAPv2/failure_test.py
@@ -24,16 +24,7 @@ class Test(unittest.TestCase):
 =

         device =3D wd.list_devices(1)[0];
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        ordered_networks =3D device.get_ordered_networks()
-        ordered_network =3D ordered_networks[0]
+        ordered_network =3D device.get_ordered_network("ssidEAP-TTLS-MSCHA=
Pv2")
 =

         self.assertEqual(ordered_network.name, "ssidEAP-TTLS-MSCHAPv2")
         self.assertEqual(ordered_network.type, NetworkType.eap)
diff --git a/autotests/testEAP-TTLS-PAP/connection_test.py b/autotests/test=
EAP-TTLS-PAP/connection_test.py
index 3e4a238a..91835642 100644
--- a/autotests/testEAP-TTLS-PAP/connection_test.py
+++ b/autotests/testEAP-TTLS-PAP/connection_test.py
@@ -26,14 +26,6 @@ class Test(unittest.TestCase):
 =

         device =3D wd.list_devices(1)[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidEAP-TTLS-PAP')
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
diff --git a/autotests/testEAP-TTLS/connection_test.py b/autotests/testEAP-=
TTLS/connection_test.py
index 81bcdc3f..c9fff4e1 100644
--- a/autotests/testEAP-TTLS/connection_test.py
+++ b/autotests/testEAP-TTLS/connection_test.py
@@ -17,14 +17,6 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidEAP-TTLS')
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
diff --git a/autotests/testFILS/fils_256_test.py b/autotests/testFILS/fils_=
256_test.py
index 1bf4dca3..a9ef3663 100644
--- a/autotests/testFILS/fils_256_test.py
+++ b/autotests/testFILS/fils_256_test.py
@@ -25,14 +25,6 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidFILS-256')
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
diff --git a/autotests/testFILS/fils_384_test.py b/autotests/testFILS/fils_=
384_test.py
index 9a5cddfd..b1f0e1c5 100644
--- a/autotests/testFILS/fils_384_test.py
+++ b/autotests/testFILS/fils_384_test.py
@@ -25,14 +25,6 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidFILS-384')
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
diff --git a/autotests/testFT-8021x-roam/connection_test.py b/autotests/tes=
tFT-8021x-roam/connection_test.py
index cd6ebbab..e65e4675 100644
--- a/autotests/testFT-8021x-roam/connection_test.py
+++ b/autotests/testFT-8021x-roam/connection_test.py
@@ -15,7 +15,7 @@ class Test(unittest.TestCase):
 =

         device =3D wd.list_devices(1)[0]
 =

-        ordered_network =3D device.get_ordered_network('TestFT', scan_if_n=
eeded=3DTrue)
+        ordered_network =3D device.get_ordered_network('TestFT')
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
 =

diff --git a/autotests/testHT-VHT/connection_test.py b/autotests/testHT-VHT=
/connection_test.py
index 3ae2942c..3d190509 100644
--- a/autotests/testHT-VHT/connection_test.py
+++ b/autotests/testHT-VHT/connection_test.py
@@ -25,7 +25,11 @@ class Test(unittest.TestCase):
         condition =3D 'not obj.scanning'
         wd.wait_for_object_condition(device, condition)
 =

-        ordered_network =3D device.get_ordered_network('testSSID')
+        #
+        # Scanning must be explicitly done to get updated RSSI values. The=
refore
+        # scan_if_needed is set false because of the previous scan.
+        #
+        ordered_network =3D device.get_ordered_network('testSSID', scan_if=
_needed=3DFalse)
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
 =

diff --git a/autotests/testHiddenNetworks/connect_after_hidden_connect_test=
.py b/autotests/testHiddenNetworks/connect_after_hidden_connect_test.py
index d9851c6a..cc36771c 100644
--- a/autotests/testHiddenNetworks/connect_after_hidden_connect_test.py
+++ b/autotests/testHiddenNetworks/connect_after_hidden_connect_test.py
@@ -33,8 +33,7 @@ class TestConnectionAfterHiddenNetwork(unittest.TestCase):
         wd.register_psk_agent(psk_agent)
 =

         device =3D wd.list_devices(1)[0]
-        ordered_network =3D device.get_ordered_network('ssidOpen',
-                                                     scan_if_needed=3DTrue)
+        ordered_network =3D device.get_ordered_network('ssidOpen')
 =

         device.connect_hidden_network_async(name=3D'ssidSomeHidden',
                                                   reply_handler =3D self._=
success,
diff --git a/autotests/testHotspot/anqp_delay_test.py b/autotests/testHotsp=
ot/anqp_delay_test.py
index adfa57fc..d86504dc 100644
--- a/autotests/testHotspot/anqp_delay_test.py
+++ b/autotests/testHotspot/anqp_delay_test.py
@@ -44,7 +44,18 @@ class Test(unittest.TestCase):
         condition =3D 'not obj.scanning'
         wd.wait_for_object_condition(device, condition)
 =

-        ordered_network =3D device.get_ordered_network('Hotspot')
+        # If no networks were found we likely had a quick scan. Try again =
to
+        # allow the full autoconnect scan to happen.
+        try:
+            ordered_network =3D device.get_ordered_network('Hotspot')
+        except:
+            condition =3D 'obj.scanning'
+            wd.wait_for_object_condition(device, condition)
+
+            condition =3D 'not obj.scanning'
+            wd.wait_for_object_condition(device, condition)
+
+            ordered_network =3D device.get_ordered_network('Hotspot')
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
 =

diff --git a/autotests/testHotspot/hessid_test.py b/autotests/testHotspot/h=
essid_test.py
index d22c5d61..5d3954b9 100644
--- a/autotests/testHotspot/hessid_test.py
+++ b/autotests/testHotspot/hessid_test.py
@@ -25,14 +25,6 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('Hotspot')
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
diff --git a/autotests/testHotspot/hotspot_test.py b/autotests/testHotspot/=
hotspot_test.py
index 4fb6b071..460ff89f 100644
--- a/autotests/testHotspot/hotspot_test.py
+++ b/autotests/testHotspot/hotspot_test.py
@@ -25,14 +25,6 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('Hotspot')
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
diff --git a/autotests/testHotspot/roaming_test.py b/autotests/testHotspot/=
roaming_test.py
index 52d89f84..d18864e0 100644
--- a/autotests/testHotspot/roaming_test.py
+++ b/autotests/testHotspot/roaming_test.py
@@ -25,14 +25,6 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('Hotspot')
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
diff --git a/autotests/testKnownNetworks/frequency_test.py b/autotests/test=
KnownNetworks/frequency_test.py
index 9c523bb2..83e51c06 100644
--- a/autotests/testKnownNetworks/frequency_test.py
+++ b/autotests/testKnownNetworks/frequency_test.py
@@ -38,14 +38,6 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         #
         # Connect to the PSK network, then Hotspot so IWD creates 2 entrie=
s in
         # the known frequency file.
diff --git a/autotests/testKnownNetworks/known_network_test.py b/autotests/=
testKnownNetworks/known_network_test.py
index 6ac19bc6..2bdcc955 100644
--- a/autotests/testKnownNetworks/known_network_test.py
+++ b/autotests/testKnownNetworks/known_network_test.py
@@ -14,14 +14,6 @@ class Test(unittest.TestCase):
         self.assertIsNotNone(devices)
         device =3D devices[0]
 =

-        device.scan()
-
-        condition =3D 'obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidNew')
 =

         condition =3D 'not obj.connected'
diff --git a/autotests/testMFP-Options/connection_test.py b/autotests/testM=
FP-Options/connection_test.py
index 0f1ef830..21cd8058 100644
--- a/autotests/testMFP-Options/connection_test.py
+++ b/autotests/testMFP-Options/connection_test.py
@@ -61,14 +61,6 @@ class TestMFP(unittest.TestCase):
         self.assertIsNotNone(devices)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         if config_dir =3D=3D '/tmp/IWD-MFP2':
             self.check_mfp_connection(wd, device, 'ssidMFP0', True)
         else:
diff --git a/autotests/testNetconfig/connection_test.py b/autotests/testNet=
config/connection_test.py
index fad0e82b..43dab243 100644
--- a/autotests/testNetconfig/connection_test.py
+++ b/autotests/testNetconfig/connection_test.py
@@ -24,14 +24,6 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidTKIP')
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
diff --git a/autotests/testNetconfig/static_test.py b/autotests/testNetconf=
ig/static_test.py
index b304f06d..7d908423 100644
--- a/autotests/testNetconfig/static_test.py
+++ b/autotests/testNetconfig/static_test.py
@@ -30,14 +30,6 @@ class Test(unittest.TestCase):
         dev1 =3D wd.list_devices(1)[0]
         dev2 =3D wd_ns0.list_devices(1)[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(dev1, condition)
-
-        dev1.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(dev1, condition)
-
         ordered_network =3D dev1.get_ordered_network('ssidTKIP')
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
diff --git a/autotests/testOWE/connection_test.py b/autotests/testOWE/conne=
ction_test.py
index 0be09263..baef4d49 100644
--- a/autotests/testOWE/connection_test.py
+++ b/autotests/testOWE/connection_test.py
@@ -20,7 +20,7 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        device.get_ordered_network('ssidOWE', scan_if_needed=3DTrue)
+        device.get_ordered_network('ssidOWE')
 =

         device.connect_bssid(hapd.bssid)
 =

@@ -41,7 +41,7 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        device.get_ordered_network('ssidOWE', scan_if_needed=3DTrue)
+        device.get_ordered_network('ssidOWE')
 =

         device.connect_bssid(hapd0.bssid)
 =

diff --git a/autotests/testOWE/timeout_test.py b/autotests/testOWE/timeout_=
test.py
index d75bc8b9..fbf79f4c 100644
--- a/autotests/testOWE/timeout_test.py
+++ b/autotests/testOWE/timeout_test.py
@@ -27,17 +27,6 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
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
         ordered_network =3D device.get_ordered_network('ssidOWE')
 =

         self.assertEqual(ordered_network.type, NetworkType.open)
diff --git a/autotests/testOpen/connection_test.py b/autotests/testOpen/con=
nection_test.py
index 48417ef3..7289ae80 100644
--- a/autotests/testOpen/connection_test.py
+++ b/autotests/testOpen/connection_test.py
@@ -17,14 +17,6 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidOpen')
 =

         self.assertEqual(ordered_network.type, NetworkType.open)
diff --git a/autotests/testPreauth-roam/connection_test.py b/autotests/test=
Preauth-roam/connection_test.py
index 545d4cba..63b73b54 100644
--- a/autotests/testPreauth-roam/connection_test.py
+++ b/autotests/testPreauth-roam/connection_test.py
@@ -34,7 +34,7 @@ class Test(unittest.TestCase):
 =

         device =3D wd.list_devices(1)[0]
 =

-        ordered_network =3D device.get_ordered_network('TestPreauth', scan=
_if_needed=3DTrue)
+        ordered_network =3D device.get_ordered_network('TestPreauth')
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
 =

diff --git a/autotests/testRRM/connection_test.py b/autotests/testRRM/conne=
ction_test.py
index e1c077c9..278c69ce 100644
--- a/autotests/testRRM/connection_test.py
+++ b/autotests/testRRM/connection_test.py
@@ -36,14 +36,6 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidRRM')
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
diff --git a/autotests/testRoamRetry/fast_retry_test.py b/autotests/testRoa=
mRetry/fast_retry_test.py
index ce2c5603..d6324c31 100644
--- a/autotests/testRoamRetry/fast_retry_test.py
+++ b/autotests/testRoamRetry/fast_retry_test.py
@@ -61,14 +61,6 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('TestRoamRetry')
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
diff --git a/autotests/testRoamRetry/stop_retry_test.py b/autotests/testRoa=
mRetry/stop_retry_test.py
index 38f58398..be9776a5 100644
--- a/autotests/testRoamRetry/stop_retry_test.py
+++ b/autotests/testRoamRetry/stop_retry_test.py
@@ -60,14 +60,6 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('TestRoamRetry')
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
diff --git a/autotests/testSAE/connection_test.py b/autotests/testSAE/conne=
ction_test.py
index 64c53001..f3e865e1 100644
--- a/autotests/testSAE/connection_test.py
+++ b/autotests/testSAE/connection_test.py
@@ -30,7 +30,12 @@ class Test(unittest.TestCase):
         wd.wait_for_object_condition(device, 'obj.scanning')
         wd.wait_for_object_condition(device, 'not obj.scanning')
 =

-        network =3D device.get_ordered_network('ssidSAE')
+        #
+        # An explicit scan was done prior due to hostapd options changing.
+        # Because of this scan_if_needed is set to False to avoid a redund=
ant
+        # scan
+        #
+        network =3D device.get_ordered_network('ssidSAE', scan_if_needed=
=3DFalse)
 =

         self.assertEqual(network.type, NetworkType.psk)
 =

diff --git a/autotests/testSAE/failure_test.py b/autotests/testSAE/failure_=
test.py
index 18c0e747..95872413 100644
--- a/autotests/testSAE/failure_test.py
+++ b/autotests/testSAE/failure_test.py
@@ -19,14 +19,6 @@ class Test(unittest.TestCase):
         self.assertIsNotNone(devices)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         network =3D device.get_ordered_network('ssidSAE')
 =

         self.assertEqual(network.type, NetworkType.psk)
diff --git a/autotests/testSAE/timeout_test.py b/autotests/testSAE/timeout_=
test.py
index 534e1ae8..28ff288c 100644
--- a/autotests/testSAE/timeout_test.py
+++ b/autotests/testSAE/timeout_test.py
@@ -23,14 +23,6 @@ class Test(unittest.TestCase):
         self.assertIsNotNone(devices)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         network =3D device.get_ordered_network('ssidSAE')
 =

         self.assertEqual(network.type, NetworkType.psk)
diff --git a/autotests/testSAQuery-spoofing/connection_test.py b/autotests/=
testSAQuery-spoofing/connection_test.py
index a1e84de6..c4c4e923 100644
--- a/autotests/testSAQuery-spoofing/connection_test.py
+++ b/autotests/testSAQuery-spoofing/connection_test.py
@@ -29,10 +29,7 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        ordered_network =3D device.get_ordered_network('ssidCCMP', scan_if=
_needed=3DTrue)
+        ordered_network =3D device.get_ordered_network('ssidCCMP')
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
 =

diff --git a/autotests/testSAQuery/connection_test.py b/autotests/testSAQue=
ry/connection_test.py
index 571e6e9f..3a66d118 100644
--- a/autotests/testSAQuery/connection_test.py
+++ b/autotests/testSAQuery/connection_test.py
@@ -23,14 +23,6 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidCCMP')
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
diff --git a/autotests/testWPA/connection_test.py b/autotests/testWPA/conne=
ction_test.py
index 3962c807..7c1a03bd 100644
--- a/autotests/testWPA/connection_test.py
+++ b/autotests/testWPA/connection_test.py
@@ -21,14 +21,6 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidTKIP')
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
diff --git a/autotests/testWPA2-SHA256/connection_test.py b/autotests/testW=
PA2-SHA256/connection_test.py
index 70c708da..982b69e2 100644
--- a/autotests/testWPA2-SHA256/connection_test.py
+++ b/autotests/testWPA2-SHA256/connection_test.py
@@ -20,14 +20,6 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidCCMP')
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
diff --git a/autotests/testWPA2-no-CCMP/connection_test.py b/autotests/test=
WPA2-no-CCMP/connection_test.py
index c2923dd5..31b1c60f 100644
--- a/autotests/testWPA2-no-CCMP/connection_test.py
+++ b/autotests/testWPA2-no-CCMP/connection_test.py
@@ -21,14 +21,6 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidCCMP')
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
diff --git a/autotests/testWPA2/connection_test.py b/autotests/testWPA2/con=
nection_test.py
index 3ff9b50f..bf8831ea 100644
--- a/autotests/testWPA2/connection_test.py
+++ b/autotests/testWPA2/connection_test.py
@@ -21,14 +21,6 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidCCMP')
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
diff --git a/autotests/testWPA2/failure_test.py b/autotests/testWPA2/failur=
e_test.py
index 55016a92..605ee5dd 100644
--- a/autotests/testWPA2/failure_test.py
+++ b/autotests/testWPA2/failure_test.py
@@ -22,14 +22,6 @@ class Test(unittest.TestCase):
         self.assertIsNotNone(devices)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidCCMP')
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
diff --git a/autotests/testWPA2/password_test.py b/autotests/testWPA2/passw=
ord_test.py
index 3c6ed407..d937d5c0 100644
--- a/autotests/testWPA2/password_test.py
+++ b/autotests/testWPA2/password_test.py
@@ -22,16 +22,6 @@ class Test(unittest.TestCase):
         condition =3D 'obj.state =3D=3D DeviceState.disconnected'
         wd.wait_for_object_condition(device, condition)
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        if not device.get_ordered_networks():
-            device.scan()
-            condition =3D 'obj.scanning'
-            wd.wait_for_object_condition(device, condition)
-            condition =3D 'not obj.scanning'
-            wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network("ssidCCMP")
         self.assertEqual(ordered_network.type, NetworkType.psk)
         network =3D ordered_network.network_object
diff --git a/autotests/testWPA2withMFP/connection_test.py b/autotests/testW=
PA2withMFP/connection_test.py
index 70c708da..982b69e2 100644
--- a/autotests/testWPA2withMFP/connection_test.py
+++ b/autotests/testWPA2withMFP/connection_test.py
@@ -20,14 +20,6 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         ordered_network =3D device.get_ordered_network('ssidCCMP')
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
-- =

2.31.1

--===============1351547228590535240==--

