Content-Type: multipart/mixed; boundary="===============2797825636051786841=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] auto-t: remove unneeded BSSs in testEAP-MSCHAPv2
Date: Fri, 13 Aug 2021 12:55:07 -0700
Message-ID: <20210813195507.807892-2-prestwoj@gmail.com>
In-Reply-To: <20210813195507.807892-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2797825636051786841==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hostapd sometimes has trouble with specifying additional BSSs in
a single config file, at least in the test-runner environment.
Since all the BSS's specified were identical instead the test was
reworked to only have a single BSS and each subtest can connect
in its own unique way.
---
 autotests/testEAP-MSCHAPV2/connection_test.py | 21 ++++++++-------
 .../testEAP-MSCHAPV2/ssidEAP-MSCHAPV2.conf    | 26 +------------------
 2 files changed, 12 insertions(+), 35 deletions(-)

diff --git a/autotests/testEAP-MSCHAPV2/connection_test.py b/autotests/test=
EAP-MSCHAPV2/connection_test.py
index 33ce856f..faa77918 100644
--- a/autotests/testEAP-MSCHAPV2/connection_test.py
+++ b/autotests/testEAP-MSCHAPV2/connection_test.py
@@ -10,7 +10,7 @@ from iwd import NetworkType
 =

 class Test(unittest.TestCase):
 =

-    def run_connection_test(self, ssid, *secrets):
+    def run_connection_test(self, *secrets):
         wd =3D IWD()
 =

         psk_agent =3D iwd.PSKAgent(*secrets)
@@ -29,7 +29,7 @@ class Test(unittest.TestCase):
             condition =3D 'not obj.scanning'
             wd.wait_for_object_condition(device, condition)
 =

-        ordered_network =3D device.get_ordered_network(ssid)
+        ordered_network =3D device.get_ordered_network("ssidEAP-MSCHAPV2")
 =

         self.assertEqual(ordered_network.type, NetworkType.eap)
 =

@@ -49,23 +49,24 @@ class Test(unittest.TestCase):
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
 =

     def test_agent_none(self):
-        self.run_connection_test('ssidEAP-MSCHAPV2-1')
+        IWD.copy_to_storage('ssidEAP-MSCHAPV2-1.8021x', name=3D'ssidEAP-MS=
CHAPV2.8021x')
+        self.run_connection_test()
 =

     def test_agent_none_hash(self):
-        self.run_connection_test('ssidEAP-MSCHAPV2-2')
+        IWD.copy_to_storage('ssidEAP-MSCHAPV2-2.8021x', name=3D'ssidEAP-MS=
CHAPV2.8021x')
+        self.run_connection_test()
 =

     def test_agent_passwd(self):
-        self.run_connection_test('ssidEAP-MSCHAPV2-3', [], ('domain\\User'=
, 'Password'))
+        IWD.copy_to_storage('ssidEAP-MSCHAPV2-3.8021x', name=3D'ssidEAP-MS=
CHAPV2.8021x')
+        self.run_connection_test([], ('domain\\User', 'Password'))
 =

     def test_agent_username_and_passwd(self):
-        self.run_connection_test('ssidEAP-MSCHAPV2-4', [], ('domain\\User'=
, 'Password'))
+        IWD.copy_to_storage('ssidEAP-MSCHAPV2-4.8021x', name=3D'ssidEAP-MS=
CHAPV2.8021x')
+        self.run_connection_test([], ('domain\\User', 'Password'))
 =

     @classmethod
     def setUpClass(cls):
-        IWD.copy_to_storage('ssidEAP-MSCHAPV2-1.8021x')
-        IWD.copy_to_storage('ssidEAP-MSCHAPV2-2.8021x')
-        IWD.copy_to_storage('ssidEAP-MSCHAPV2-3.8021x')
-        IWD.copy_to_storage('ssidEAP-MSCHAPV2-4.8021x')
+        pass
 =

     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2.conf b/autotests/t=
estEAP-MSCHAPV2/ssidEAP-MSCHAPV2.conf
index 2a37a70c..3f33e99d 100644
--- a/autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2.conf
+++ b/autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2.conf
@@ -1,4 +1,4 @@
-ssid=3DssidEAP-MSCHAPV2-1
+ssid=3DssidEAP-MSCHAPV2
 interface=3Dwln0
 hw_mode=3Dg
 channel=3D1
@@ -7,27 +7,3 @@ wpa_key_mgmt=3DWPA-EAP
 ieee8021x=3D1
 eap_server=3D1
 eap_user_file=3D/tmp/secrets/eap-user-mschapv2.text
-
-bss=3Dwln0_1
-ssid=3DssidEAP-MSCHAPV2-2
-wpa=3D3
-wpa_key_mgmt=3DWPA-EAP
-ieee8021x=3D1
-eap_server=3D1
-eap_user_file=3D/tmp/secrets/eap-user-mschapv2.text
-
-bss=3Dwln0_2
-ssid=3DssidEAP-MSCHAPV2-3
-wpa=3D3
-wpa_key_mgmt=3DWPA-EAP
-ieee8021x=3D1
-eap_server=3D1
-eap_user_file=3D/tmp/secrets/eap-user-mschapv2.text
-
-bss=3Dwln0_3
-ssid=3DssidEAP-MSCHAPV2-4
-wpa=3D3
-wpa_key_mgmt=3DWPA-EAP
-ieee8021x=3D1
-eap_server=3D1
-eap_user_file=3D/tmp/secrets/eap-user-mschapv2.text
-- =

2.31.1

--===============2797825636051786841==--

