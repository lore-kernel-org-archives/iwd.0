Content-Type: multipart/mixed; boundary="===============8054143030998275186=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] auto-t: let testEAP-TTLS-MSCHAPv2 use HostapdCLI easier
Date: Thu, 14 Nov 2019 11:58:06 -0800
Message-ID: <20191114195806.27948-2-prestwoj@gmail.com>
In-Reply-To: <20191114195806.27948-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8054143030998275186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This test made it past the initial refactor to use HostapdCLI with the
'config' parameter. This avoids the need to iterate the hostapd map in
the actual test.
---
 autotests/testEAP-TTLS-MSCHAPv2/connection_test.py | 9 +--------
 autotests/testEAP-TTLS-MSCHAPv2/failure_test.py    | 9 +--------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/autotests/testEAP-TTLS-MSCHAPv2/connection_test.py b/autotests=
/testEAP-TTLS-MSCHAPv2/connection_test.py
index fb073dc9..66cc440b 100644
--- a/autotests/testEAP-TTLS-MSCHAPv2/connection_test.py
+++ b/autotests/testEAP-TTLS-MSCHAPv2/connection_test.py
@@ -11,18 +11,11 @@ from iwd import PSKAgent
 from iwd import NetworkType
 =

 from hostapd import HostapdCLI
-from hostapd import hostapd_map
 =

 class Test(unittest.TestCase):
 =

     def validate_connection(self, wd):
-        hostapd =3D None
-
-        for hostapd_if in list(hostapd_map.values()):
-            hpd =3D HostapdCLI(hostapd_if)
-            if hpd.get_config_value('ssid') =3D=3D 'ssidEAP-TTLS-MSCHAPv2':
-                hostapd =3D hpd
-                break
+        hostapd =3D HostapdCLI(config=3D'ssidEAP-TTLS-MSCHAPv2.conf')
 =

         self.assertIsNotNone(hostapd)
 =

diff --git a/autotests/testEAP-TTLS-MSCHAPv2/failure_test.py b/autotests/te=
stEAP-TTLS-MSCHAPv2/failure_test.py
index c91ce3c9..b4c3c003 100644
--- a/autotests/testEAP-TTLS-MSCHAPv2/failure_test.py
+++ b/autotests/testEAP-TTLS-MSCHAPv2/failure_test.py
@@ -11,18 +11,11 @@ from iwd import PSKAgent
 from iwd import NetworkType
 =

 from hostapd import HostapdCLI
-from hostapd import hostapd_map
 =

 class Test(unittest.TestCase):
 =

     def validate_connection(self, wd):
-        hostapd =3D None
-
-        for hostapd_if in list(hostapd_map.values()):
-            hpd =3D HostapdCLI(hostapd_if)
-            if hpd.get_config_value('ssid') =3D=3D 'ssidEAP-TTLS-MSCHAPv2':
-                hostapd =3D hpd
-                break
+        hostapd =3D HostapdCLI(config=3D'ssidEAP-TTLS-MSCHAPv2.conf')
 =

         self.assertIsNotNone(hostapd)
 =

-- =

2.17.1

--===============8054143030998275186==--

