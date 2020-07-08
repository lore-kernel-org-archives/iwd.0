Content-Type: multipart/mixed; boundary="===============0266185631672835138=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] auto-t: remove busy wait for eapol reauth
Date: Wed, 08 Jul 2020 10:48:01 -0700
Message-ID: <20200708174801.14447-2-prestwoj@gmail.com>
In-Reply-To: <20200708174801.14447-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0266185631672835138==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Many tests force a reauth after the initial connection. When the tests
were written there was no way of ensuring the reauth completed except
waiting (IWD.wait()). Now we can wait for hostapd events in the tests,
which is faster and more reliable than busy waiting.
---
 autotests/testEAP-AKA/connection_test.py             | 11 +++--------
 autotests/testEAP-PEAPv0-CryptoBinding/NoISK_test.py | 11 +++--------
 autotests/testEAP-PWD/connection_test.py             | 12 +++---------
 autotests/testEAP-SIM/connection_test.py             | 11 +++--------
 autotests/testEAP-TTLS-CHAP/connection_test.py       | 11 +++--------
 autotests/testEAP-TTLS-MSCHAP/connection_test.py     | 11 +++--------
 autotests/testEAP-TTLS-MSCHAPv2/connection_test.py   |  3 ++-
 autotests/testEAP-TTLS-PAP/connection_test.py        | 11 +++--------
 8 files changed, 23 insertions(+), 58 deletions(-)

diff --git a/autotests/testEAP-AKA/connection_test.py b/autotests/testEAP-A=
KA/connection_test.py
index 734e0dbb..bcdb1d92 100644
--- a/autotests/testEAP-AKA/connection_test.py
+++ b/autotests/testEAP-AKA/connection_test.py
@@ -15,13 +15,7 @@ from hostapd import hostapd_map
 class Test(unittest.TestCase):
 =

     def test_connection_success(self):
-        hostapd =3D None
-
-        for hostapd_if in list(hostapd_map.values()):
-            hpd =3D HostapdCLI(hostapd_if)
-            if hpd.get_config_value('ssid') =3D=3D 'ssidEAP-AKA':
-                hostapd =3D hpd
-                break
+        hostapd =3D HostapdCLI(config=3D'ssidEAP-AKA.conf')
 =

         self.assertIsNotNone(hostapd)
 =

@@ -58,7 +52,8 @@ class Test(unittest.TestCase):
 =

         hostapd.eapol_reauth(device.address)
 =

-        wd.wait(10)
+        hostapd.wait_for_event('CTRL-EVENT-EAP-STARTED')
+        hostapd.wait_for_event('CTRL-EVENT-EAP-SUCCESS')
 =

         condition =3D 'obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
diff --git a/autotests/testEAP-PEAPv0-CryptoBinding/NoISK_test.py b/autotes=
ts/testEAP-PEAPv0-CryptoBinding/NoISK_test.py
index fde8bfc2..0f7d432c 100644
--- a/autotests/testEAP-PEAPv0-CryptoBinding/NoISK_test.py
+++ b/autotests/testEAP-PEAPv0-CryptoBinding/NoISK_test.py
@@ -16,13 +16,7 @@ from hostapd import hostapd_map
 class Test(unittest.TestCase):
 =

     def validate_connection(self, wd):
-        hostapd =3D None
-
-        for hostapd_if in list(hostapd_map.values()):
-            hpd =3D HostapdCLI(hostapd_if)
-            if hpd.get_config_value('ssid') =3D=3D 'ssidEAP-PEAPv0-NoISK':
-                hostapd =3D hpd
-                break
+        hostapd =3D HostapdCLI(config=3D'ssidEAP-PEAPv0-NoISK.conf')
 =

         self.assertIsNotNone(hostapd)
 =

@@ -52,7 +46,8 @@ class Test(unittest.TestCase):
 =

         hostapd.eapol_reauth(device.address)
 =

-        wd.wait(10)
+        hostapd.wait_for_event('CTRL-EVENT-EAP-STARTED')
+        hostapd.wait_for_event('CTRL-EVENT-EAP-SUCCESS')
 =

         condition =3D 'obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
diff --git a/autotests/testEAP-PWD/connection_test.py b/autotests/testEAP-P=
WD/connection_test.py
index e5d6e621..0c722c44 100644
--- a/autotests/testEAP-PWD/connection_test.py
+++ b/autotests/testEAP-PWD/connection_test.py
@@ -15,14 +15,7 @@ from hostapd import hostapd_map
 class Test(unittest.TestCase):
 =

     def validate_connection(self, wd):
-
-        hostapd =3D None
-
-        for hostapd_if in list(hostapd_map.values()):
-            hpd =3D HostapdCLI(hostapd_if)
-            if hpd.get_config_value('ssid') =3D=3D 'ssidEAP-PWD':
-                hostapd =3D hpd
-                break
+        hostapd =3D HostapdCLI(config=3D'ssidEAP-PWD.conf')
 =

         self.assertIsNotNone(hostapd)
 =

@@ -56,7 +49,8 @@ class Test(unittest.TestCase):
 =

         hostapd.eapol_reauth(device.address)
 =

-        wd.wait(10)
+        hostapd.wait_for_event('CTRL-EVENT-EAP-STARTED')
+        hostapd.wait_for_event('CTRL-EVENT-EAP-SUCCESS')
 =

         condition =3D 'obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
diff --git a/autotests/testEAP-SIM/connection_test.py b/autotests/testEAP-S=
IM/connection_test.py
index 0ac7da05..97956d0c 100644
--- a/autotests/testEAP-SIM/connection_test.py
+++ b/autotests/testEAP-SIM/connection_test.py
@@ -15,13 +15,7 @@ from hostapd import hostapd_map
 class Test(unittest.TestCase):
 =

     def test_connection_success(self):
-        hostapd =3D None
-
-        for hostapd_if in list(hostapd_map.values()):
-            hpd =3D HostapdCLI(hostapd_if)
-            if hpd.get_config_value('ssid') =3D=3D 'ssidEAP-SIM':
-                hostapd =3D hpd
-                break
+        hostapd =3D HostapdCLI(config=3D'ssidEAP-SIM.conf')
 =

         auth =3D AuthCenter('/tmp/hlrauc.sock', '/tmp/sim.db')
 =

@@ -56,7 +50,8 @@ class Test(unittest.TestCase):
 =

         hostapd.eapol_reauth(device.address)
 =

-        wd.wait(10)
+        hostapd.wait_for_event('CTRL-EVENT-EAP-STARTED')
+        hostapd.wait_for_event('CTRL-EVENT-EAP-SUCCESS')
 =

         condition =3D 'obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
diff --git a/autotests/testEAP-TTLS-CHAP/connection_test.py b/autotests/tes=
tEAP-TTLS-CHAP/connection_test.py
index f9633b28..e3719669 100644
--- a/autotests/testEAP-TTLS-CHAP/connection_test.py
+++ b/autotests/testEAP-TTLS-CHAP/connection_test.py
@@ -16,13 +16,7 @@ from hostapd import hostapd_map
 class Test(unittest.TestCase):
 =

     def test_connection_success(self):
-        hostapd =3D None
-
-        for hostapd_if in list(hostapd_map.values()):
-            hpd =3D HostapdCLI(hostapd_if)
-            if hpd.get_config_value('ssid') =3D=3D 'ssidEAP-TTLS-CHAP':
-                hostapd =3D hpd
-                break
+        hostapd =3D HostapdCLI(config=3D'ssidEAP-TTLS-CHAP.conf')
 =

         self.assertIsNotNone(hostapd)
 =

@@ -55,7 +49,8 @@ class Test(unittest.TestCase):
 =

         hostapd.eapol_reauth(device.address)
 =

-        wd.wait(10)
+        hostapd.wait_for_event('CTRL-EVENT-EAP-STARTED')
+        hostapd.wait_for_event('CTRL-EVENT-EAP-SUCCESS')
 =

         condition =3D 'obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
diff --git a/autotests/testEAP-TTLS-MSCHAP/connection_test.py b/autotests/t=
estEAP-TTLS-MSCHAP/connection_test.py
index 269f6131..ea245a38 100644
--- a/autotests/testEAP-TTLS-MSCHAP/connection_test.py
+++ b/autotests/testEAP-TTLS-MSCHAP/connection_test.py
@@ -16,13 +16,7 @@ from hostapd import hostapd_map
 class Test(unittest.TestCase):
 =

     def test_connection_success(self):
-        hostapd =3D None
-
-        for hostapd_if in hostapd_map.values():
-            hpd =3D HostapdCLI(hostapd_if)
-            if hpd.get_config_value('ssid') =3D=3D 'ssidEAP-TTLS-MSCHAP':
-                hostapd =3D hpd
-                break
+        hostapd =3D HostapdCLI(config=3D'ssidEAP-TTLS-MSCHAP.conf')
 =

         self.assertIsNotNone(hostapd)
 =

@@ -55,7 +49,8 @@ class Test(unittest.TestCase):
 =

         hostapd.eapol_reauth(device.address)
 =

-        wd.wait(10)
+        hostapd.wait_for_event('CTRL-EVENT-EAP-STARTED')
+        hostapd.wait_for_event('CTRL-EVENT-EAP-SUCCESS')
 =

         condition =3D 'obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
diff --git a/autotests/testEAP-TTLS-MSCHAPv2/connection_test.py b/autotests=
/testEAP-TTLS-MSCHAPv2/connection_test.py
index 66cc440b..918e8d1f 100644
--- a/autotests/testEAP-TTLS-MSCHAPv2/connection_test.py
+++ b/autotests/testEAP-TTLS-MSCHAPv2/connection_test.py
@@ -48,7 +48,8 @@ class Test(unittest.TestCase):
 =

         hostapd.eapol_reauth(device.address)
 =

-        wd.wait(10)
+        hostapd.wait_for_event('CTRL-EVENT-EAP-STARTED')
+        hostapd.wait_for_event('CTRL-EVENT-EAP-SUCCESS')
 =

         condition =3D 'obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
diff --git a/autotests/testEAP-TTLS-PAP/connection_test.py b/autotests/test=
EAP-TTLS-PAP/connection_test.py
index 07b14aa9..ce787b01 100644
--- a/autotests/testEAP-TTLS-PAP/connection_test.py
+++ b/autotests/testEAP-TTLS-PAP/connection_test.py
@@ -16,13 +16,7 @@ from hostapd import hostapd_map
 class Test(unittest.TestCase):
 =

     def test_connection_success(self):
-        hostapd =3D None
-
-        for hostapd_if in list(hostapd_map.values()):
-            hpd =3D HostapdCLI(hostapd_if)
-            if hpd.get_config_value('ssid') =3D=3D 'ssidEAP-TTLS-PAP':
-                hostapd =3D hpd
-                break
+        hostapd =3D HostapdCLI(config=3D'ssidEAP-TTLS-PAP.conf')
 =

         self.assertIsNotNone(hostapd)
 =

@@ -55,7 +49,8 @@ class Test(unittest.TestCase):
 =

         hostapd.eapol_reauth(device.address)
 =

-        wd.wait(10)
+        hostapd.wait_for_event('CTRL-EVENT-EAP-STARTED')
+        hostapd.wait_for_event('CTRL-EVENT-EAP-SUCCESS')
 =

         condition =3D 'obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-- =

2.21.1

--===============0266185631672835138==--

