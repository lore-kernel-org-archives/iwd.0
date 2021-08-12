Content-Type: multipart/mixed; boundary="===============1234275136448872198=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 7/7] auto-t: set autoconnect=True for tests that need it
Date: Thu, 12 Aug 2021 13:38:12 -0700
Message-ID: <20210812203812.738060-7-prestwoj@gmail.com>
In-Reply-To: <20210812203812.738060-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1234275136448872198==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After the default behavior was changed to disable autoconnect there
were several tests which still needed it to be turned on.
---
 autotests/testBSSBlacklist/connection_test.py   | 6 ++----
 autotests/testConnectAutoconnect/validation.py  | 2 ++
 autotests/testHiddenNetworks/validation.py      | 2 ++
 autotests/testHotspot/anqp_delay_test.py        | 1 +
 autotests/testHotspot/autoconnect_test.py       | 1 +
 autotests/testSAE/autoconnect_test.py           | 1 +
 autotests/testScan/periodic_scan_test.py        | 1 +
 autotests/testScan/requested_scan_test.py       | 1 +
 autotests/testScanKnownFreqs/quick_scan_test.py | 1 +
 9 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/autotests/testBSSBlacklist/connection_test.py b/autotests/test=
BSSBlacklist/connection_test.py
index 23b56b57..407ee06a 100644
--- a/autotests/testBSSBlacklist/connection_test.py
+++ b/autotests/testBSSBlacklist/connection_test.py
@@ -81,10 +81,8 @@ class Test(unittest.TestCase):
 =

         rule0.drop =3D False
 =

-        # Next try autoconnecting to a network with a blacklisted BSS. Sin=
ce an
-        # explicit disconnect call would disable autoconnect we reset
-        # hostapd which will disconnect IWD.
-        bss_hostapd[1].reload()
+        device.disconnect()
+        device.autoconnect =3D True
 =

         condition =3D 'not obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
diff --git a/autotests/testConnectAutoconnect/validation.py b/autotests/tes=
tConnectAutoconnect/validation.py
index b240d25d..4e246712 100644
--- a/autotests/testConnectAutoconnect/validation.py
+++ b/autotests/testConnectAutoconnect/validation.py
@@ -28,6 +28,8 @@ class TestConnectAutoConnect(unittest.TestCase):
         wd.wait_for_object_condition(device, condition)
 =

     def check_autoconnect(self, wd, device, ssid, throws):
+        device.autoconnect =3D True
+
         if throws is None:
             condition =3D 'obj.state =3D=3D DeviceState.connected'
             wd.wait_for_object_condition(device, condition)
diff --git a/autotests/testHiddenNetworks/validation.py b/autotests/testHid=
denNetworks/validation.py
index 7ff7075a..793b459f 100644
--- a/autotests/testHiddenNetworks/validation.py
+++ b/autotests/testHiddenNetworks/validation.py
@@ -48,11 +48,13 @@ class TestConnectAutoConnect(unittest.TestCase):
         devices =3D wd.list_devices(1)
         self.assertIsNotNone(devices)
         device =3D devices[0]
+        device.autoconnect =3D autoconnect
 =

         if autoconnect:
             self.check_autoconnect_hidden_network(wd, device, ssid, throws)
         else:
             if wait_periodic_scan:
+                device.autoconnect =3D True
                 condition =3D 'obj.scanning'
                 wd.wait_for_object_condition(device, condition)
                 condition =3D 'not obj.scanning'
diff --git a/autotests/testHotspot/anqp_delay_test.py b/autotests/testHotsp=
ot/anqp_delay_test.py
index d86504dc..67c12025 100644
--- a/autotests/testHotspot/anqp_delay_test.py
+++ b/autotests/testHotspot/anqp_delay_test.py
@@ -33,6 +33,7 @@ class Test(unittest.TestCase):
 =

         devices =3D wd.list_devices(1)
         device =3D devices[0]
+        device.autoconnect =3D True
 =

         # We are dependent on a periodic scan here. We want to wait for th=
is
         # because this is the first opportunity IWD has to do ANQP. Once A=
NQP
diff --git a/autotests/testHotspot/autoconnect_test.py b/autotests/testHots=
pot/autoconnect_test.py
index b8caa7fb..354bf61b 100644
--- a/autotests/testHotspot/autoconnect_test.py
+++ b/autotests/testHotspot/autoconnect_test.py
@@ -23,6 +23,7 @@ class Test(unittest.TestCase):
 =

         devices =3D wd.list_devices(1)
         device =3D devices[0]
+        device.autoconnect =3D True
 =

         condition =3D 'obj.scanning'
         wd.wait_for_object_condition(device, condition)
diff --git a/autotests/testSAE/autoconnect_test.py b/autotests/testSAE/auto=
connect_test.py
index 16fcd1e0..9095b7e9 100644
--- a/autotests/testSAE/autoconnect_test.py
+++ b/autotests/testSAE/autoconnect_test.py
@@ -17,6 +17,7 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         self.assertIsNotNone(devices)
         device =3D devices[0]
+        device.autoconnect =3D True
 =

         condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
diff --git a/autotests/testScan/periodic_scan_test.py b/autotests/testScan/=
periodic_scan_test.py
index 439b844d..77dac373 100644
--- a/autotests/testScan/periodic_scan_test.py
+++ b/autotests/testScan/periodic_scan_test.py
@@ -28,6 +28,7 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         self.assertIsNotNone(devices)
         device =3D devices[0]
+        device.autoconnect =3D True
 =

         # Device initiates a passive periodic scan.
         condition =3D 'obj.scanning'
diff --git a/autotests/testScan/requested_scan_test.py b/autotests/testScan=
/requested_scan_test.py
index 69297f27..26e44ddd 100644
--- a/autotests/testScan/requested_scan_test.py
+++ b/autotests/testScan/requested_scan_test.py
@@ -30,6 +30,7 @@ class Test(unittest.TestCase):
         devices =3D wd.list_devices(1)
         self.assertIsNotNone(devices)
         device =3D devices[0]
+        device.autoconnect =3D True
 =

         condition =3D 'obj.scanning'
         wd.wait_for_object_condition(device, condition)
diff --git a/autotests/testScanKnownFreqs/quick_scan_test.py b/autotests/te=
stScanKnownFreqs/quick_scan_test.py
index 35f71457..5a37e6c3 100644
--- a/autotests/testScanKnownFreqs/quick_scan_test.py
+++ b/autotests/testScanKnownFreqs/quick_scan_test.py
@@ -24,6 +24,7 @@ class Test(unittest.TestCase):
     def validate_quick_scan(self, wd):
         devices =3D wd.list_devices(1)
         device =3D devices[0]
+        device.autoconnect =3D True
 =

         # Device initiates a passive quick scan and scans only for the kno=
wn
         # frequencies (listed in .known_network.freq file).
-- =

2.31.1

--===============1234275136448872198==--

