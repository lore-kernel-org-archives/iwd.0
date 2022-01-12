Content-Type: multipart/mixed; boundary="===============0889920903672421761=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 7/7] auto-t: improve testDPP reliablity
Date: Wed, 12 Jan 2022 10:08:45 -0800
Message-ID: <20220112180845.1240661-7-prestwoj@gmail.com>
In-Reply-To: 20220112180845.1240661-1-prestwoj@gmail.com

--===============0889920903672421761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

First disconnect wpa_supplicant to make sure it wont miss frames if
it decides to connect. Also alter the order of things for the
configurator test so autoconnect doesn't start until after hostapd
is up (avoids additional scanning and delays)
---
 autotests/testDPP/connection_test.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/autotests/testDPP/connection_test.py b/autotests/testDPP/conne=
ction_test.py
index 3c3705e4..38d44b25 100644
--- a/autotests/testDPP/connection_test.py
+++ b/autotests/testDPP/connection_test.py
@@ -35,6 +35,7 @@ class Test(unittest.TestCase):
         self.wd.wait_for_object_condition(self.device, condition)
 =

     def test_iwd_as_enrollee_scan_after(self):
+        self.wpas.disconnect()
         uri =3D self.device.dpp_start_enrollee()
 =

         self.wpas.dpp_configurator_create(uri)
@@ -66,10 +67,11 @@ class Test(unittest.TestCase):
         self.wd.wait_for_object_condition(self.device, condition)
 =

     def test_iwd_as_configurator(self):
-        self.device.autoconnect =3D True
-        IWD.copy_to_storage('ssidCCMP.psk')
-
         self.hapd.reload()
+        self.hapd.wait_for_event('AP-ENABLED')
+
+        IWD.copy_to_storage('ssidCCMP.psk')
+        self.device.autoconnect =3D True
 =

         condition =3D 'obj.state =3D=3D DeviceState.connected'
         self.wd.wait_for_object_condition(self.device, condition)
-- =

2.31.1

--===============0889920903672421761==--

