Content-Type: multipart/mixed; boundary="===============1140264487899919269=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 10/10] auto-t: add a few more DPP tests
Date: Tue, 11 Jan 2022 16:55:58 -0800
Message-ID: <20220112005558.1158405-10-prestwoj@gmail.com>
In-Reply-To: 20220112005558.1158405-1-prestwoj@gmail.com

--===============1140264487899919269==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds 3 more tests:
 - Channel switch during authentication
 - Scan after configuring
 - Retransmit auth frames
---
 autotests/testDPP/connection_test.py | 103 +++++++++++++++++++--------
 autotests/testDPP/hw.conf            |   1 +
 2 files changed, 76 insertions(+), 28 deletions(-)

diff --git a/autotests/testDPP/connection_test.py b/autotests/testDPP/conne=
ction_test.py
index 43822c55..3c3705e4 100644
--- a/autotests/testDPP/connection_test.py
+++ b/autotests/testDPP/connection_test.py
@@ -7,58 +7,105 @@ sys.path.append('../util')
 from iwd import IWD
 from wpas import Wpas
 from hostapd import HostapdCLI
+from hwsim import Hwsim
 =

 class Test(unittest.TestCase):
-
     def test_iwd_as_enrollee(self):
-        wpas =3D Wpas('wpas.conf')
+        self.device.autoconnect =3D True
+        self.hapd.reload()
+
+        uri =3D self.device.dpp_start_enrollee()
 =

-        wd =3D IWD(True)
+        self.wpas.dpp_configurator_create(uri)
+        self.wpas.dpp_configurator_start('ssidCCMP', 'secret123')
 =

-        devices =3D wd.list_devices(1)
-        device =3D devices[0]
-        device.autoconnect =3D True
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        self.wd.wait_for_object_condition(self.device, condition)
 =

-        uri =3D device.dpp_start_enrollee()
+    def test_iwd_as_enrollee_channel_switch(self):
+        self.device.autoconnect =3D True
+        self.hapd.reload()
 =

-        wpas.dpp_configurator_create(uri)
-        wpas.dpp_configurator_start('ssidCCMP', 'secret123')
+        uri =3D self.device.dpp_start_enrollee()
+
+        self.wpas.dpp_configurator_create(uri)
+        self.wpas.dpp_configurator_start('ssidCCMP', 'secret123', freq=3D2=
462)
 =

         condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
+        self.wd.wait_for_object_condition(self.device, condition)
 =

-        device.disconnect()
-        device.dpp_stop()
+    def test_iwd_as_enrollee_scan_after(self):
+        uri =3D self.device.dpp_start_enrollee()
 =

-        del wpas
+        self.wpas.dpp_configurator_create(uri)
+        self.wpas.dpp_configurator_start('ssidCCMP', 'secret123')
 =

-    def test_iwd_as_configurator(self):
-        IWD.copy_to_storage('ssidCCMP.psk')
+        self.hapd.reload()
+
+        with self.assertRaises(Exception):
+            self.device.get_ordered_network('ssidCCMP', scan_if_needed=3DF=
alse)
 =

-        wpas =3D Wpas('wpas.conf')
-        hapd =3D HostapdCLI('hostapd.conf')
+        self.hapd.wait_for_event('AP-ENABLED')
 =

-        wd =3D IWD(True)
+        self.device.autoconnect =3D True
+
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        self.wd.wait_for_object_condition(self.device, condition)
+
+    def test_iwd_as_enrollee_no_ack(self):
+        self.rule0.enabled =3D True
+        self.device.autoconnect =3D True
+        self.hapd.reload()
+
+        uri =3D self.device.dpp_start_enrollee()
+
+        self.wpas.dpp_configurator_create(uri)
+        self.wpas.dpp_configurator_start('ssidCCMP', 'secret123')
+
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        self.wd.wait_for_object_condition(self.device, condition)
+
+    def test_iwd_as_configurator(self):
+        self.device.autoconnect =3D True
+        IWD.copy_to_storage('ssidCCMP.psk')
 =

-        devices =3D wd.list_devices(1)
-        device =3D devices[0]
-        device.autoconnect =3D True
+        self.hapd.reload()
 =

         condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
+        self.wd.wait_for_object_condition(self.device, condition)
 =

-        uri =3D device.dpp_start_configurator()
+        uri =3D self.device.dpp_start_configurator()
 =

-        wpas.dpp_enrollee_start(uri)
+        self.wpas.dpp_enrollee_start(uri)
 =

-        hapd.wait_for_event('AP-STA-CONNECTED 42:00:00:00:00:00')
+        self.hapd.wait_for_event('AP-STA-CONNECTED 42:00:00:00:00:00')
 =

-        device.disconnect()
-        device.dpp_stop()
+    def setUp(self):
+        self.wd =3D IWD(True)
+        self.device =3D self.wd.list_devices(1)[0]
+        self.wpas =3D Wpas('wpas.conf')
+        self.hapd =3D HostapdCLI('hostapd.conf')
+        self.hapd.disable()
+        self.hwsim =3D Hwsim()
 =

-        del wpas
+        self.rule0 =3D self.hwsim.rules.create()
+        self.rule0.prefix =3D 'd0'
+        self.rule0.match_offset =3D 24
+        self.rule0.match =3D '04 09 50 6f 9a 1a 01 01'
+        self.rule0.match_times =3D 1
+        self.rule0.drop =3D True
 =

     def tearDown(self):
+        print("calling Disconnect()")
+        self.device.disconnect()
+        self.device.dpp_stop()
+        self.wpas.dpp_configurator_remove()
+
+        self.wd =3D None
+        self.device =3D None
+        self.wpas =3D None
+        self.hapd =3D None
+        self.rule0 =3D None
         IWD.clear_storage()
 =

     @classmethod
diff --git a/autotests/testDPP/hw.conf b/autotests/testDPP/hw.conf
index 478f0633..923595ea 100644
--- a/autotests/testDPP/hw.conf
+++ b/autotests/testDPP/hw.conf
@@ -1,6 +1,7 @@
 [SETUP]
 num_radios=3D3
 start_iwd=3D0
+hwsim_medium=3Dyes
 =

 [WPA_SUPPLICANT]
 rad0=3Dwpas.conf
-- =

2.31.1

--===============1140264487899919269==--

