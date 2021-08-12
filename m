Content-Type: multipart/mixed; boundary="===============1149330208037331796=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 18/18] auto-t: use connect_bssid in APRoam
Date: Thu, 12 Aug 2021 13:22:07 -0700
Message-ID: <20210812202207.737053-18-prestwoj@gmail.com>
In-Reply-To: <20210812202207.737053-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1149330208037331796==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In addition the send_bss_transition call was updated to only send a
single BSS. By sending two BSS's IWD is left to pick whichever one
it wants which makes the test behavior undefined.
---
 autotests/testAPRoam/TestAPRoam.psk     |  2 ++
 autotests/testAPRoam/connection_test.py | 47 ++-----------------------
 2 files changed, 5 insertions(+), 44 deletions(-)
 create mode 100644 autotests/testAPRoam/TestAPRoam.psk

diff --git a/autotests/testAPRoam/TestAPRoam.psk b/autotests/testAPRoam/Tes=
tAPRoam.psk
new file mode 100644
index 00000000..abafdb66
--- /dev/null
+++ b/autotests/testAPRoam/TestAPRoam.psk
@@ -0,0 +1,2 @@
+[Security]
+Passphrase=3Dsecret123
diff --git a/autotests/testAPRoam/connection_test.py b/autotests/testAPRoam=
/connection_test.py
index e1ca3e4b..c7037231 100644
--- a/autotests/testAPRoam/connection_test.py
+++ b/autotests/testAPRoam/connection_test.py
@@ -6,56 +6,22 @@ import sys
 sys.path.append('../util')
 import iwd
 from iwd import IWD
-from iwd import PSKAgent
 from iwd import NetworkType
 =

 from hostapd import HostapdCLI
-from hwsim import Hwsim
 =

 class Test(unittest.TestCase):
 =

     def test_connection_success(self):
-        hwsim =3D Hwsim()
-
         bss_hostapd =3D [ HostapdCLI(config=3D'ssid1.conf'),
                         HostapdCLI(config=3D'ssid2.conf'),
                         HostapdCLI(config=3D'ssid3.conf') ]
-        bss_radio =3D  [ hwsim.get_radio('rad0'),
-                       hwsim.get_radio('rad1'),
-                       hwsim.get_radio('rad2') ]
-
-        rule0 =3D hwsim.rules.create()
-        rule0.source =3D bss_radio[0].addresses[0]
-        rule0.bidirectional =3D True
-
-        rule1 =3D hwsim.rules.create()
-        rule1.source =3D bss_radio[1].addresses[0]
-        rule1.bidirectional =3D True
-
-        rule2 =3D hwsim.rules.create()
-        rule2.source =3D bss_radio[2].addresses[0]
-        rule2.bidirectional =3D True
-
-        rule0.signal =3D -6000
-        rule1.signal =3D -6900
-        rule2.signal =3D -8000
 =

         wd =3D IWD()
 =

-        psk_agent =3D PSKAgent("secret123")
-        wd.register_psk_agent(psk_agent)
-
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
         ordered_network =3D device.get_ordered_network('TestAPRoam')
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
@@ -63,7 +29,7 @@ class Test(unittest.TestCase):
         condition =3D 'not obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
 =

-        ordered_network.network_object.connect()
+        device.connect_bssid(bss_hostapd[0].bssid)
 =

         condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
@@ -74,8 +40,7 @@ class Test(unittest.TestCase):
         self.assertFalse(bss_hostapd[1].list_sta())
 =

         bss_hostapd[0].send_bss_transition(device.address,
-                [(bss_radio[1].addresses[0], '8f0000005102060603000000'),
-                 (bss_radio[2].addresses[0], '8f0000005103060603000000')])
+                [(bss_hostapd[1].bssid, '8f0000005102060603000000')])
 =

         condition =3D 'obj.state =3D=3D DeviceState.roaming'
         wd.wait_for_object_condition(device, condition)
@@ -93,15 +58,9 @@ class Test(unittest.TestCase):
         condition =3D 'not obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
 =

-        wd.unregister_psk_agent(psk_agent)
-
-        rule0.remove()
-        rule1.remove()
-        rule2.remove()
-
     @classmethod
     def setUpClass(cls):
-        pass
+        IWD.copy_to_storage('TestAPRoam.psk')
 =

     @classmethod
     def tearDownClass(cls):
-- =

2.31.1

--===============1149330208037331796==--

