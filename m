Content-Type: multipart/mixed; boundary="===============3017390756121017592=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] auto-t: fix FT over DS test to wait for connected
Date: Tue, 24 Nov 2020 09:03:57 -0800
Message-ID: <20201124170357.4193712-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3017390756121017592==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Due to timing this test sometimes does not pass because it was
just asserting on the device state rather than waiting for a
change. This generally worked but not always.
---
 autotests/testFT-PSK-over-DS/connection_test.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/autotests/testFT-PSK-over-DS/connection_test.py b/autotests/te=
stFT-PSK-over-DS/connection_test.py
index 28a045ef..b6cad5a4 100644
--- a/autotests/testFT-PSK-over-DS/connection_test.py
+++ b/autotests/testFT-PSK-over-DS/connection_test.py
@@ -88,7 +88,9 @@ class Test(unittest.TestCase):
         condition =3D 'obj.state !=3D DeviceState.roaming'
         wd.wait_for_object_condition(device, condition)
 =

-        self.assertEqual(device.state, iwd.DeviceState.connected)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
         self.assertTrue(self.bss_hostapd[1].list_sta())
 =

         testutil.test_iface_operstate(device.name)
-- =

2.26.2

--===============3017390756121017592==--

