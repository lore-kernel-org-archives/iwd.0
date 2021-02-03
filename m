Content-Type: multipart/mixed; boundary="===============4436982083645813501=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] auto-t: testFT-PSK-roam wait for connected
Date: Wed, 03 Feb 2021 13:00:58 -0800
Message-ID: <20210203210058.188314-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4436982083645813501==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Rather than assert its better to wait for a connected
state.
---
 autotests/testFT-PSK-roam/connection_test.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/autotests/testFT-PSK-roam/connection_test.py b/autotests/testF=
T-PSK-roam/connection_test.py
index 8e69fcd5..a7acf495 100644
--- a/autotests/testFT-PSK-roam/connection_test.py
+++ b/autotests/testFT-PSK-roam/connection_test.py
@@ -90,7 +90,8 @@ class Test(unittest.TestCase):
         condition =3D 'obj.state !=3D DeviceState.roaming'
         wd.wait_for_object_condition(device, condition)
 =

-        self.assertEqual(device.state, iwd.DeviceState.connected)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
         self.assertTrue(self.bss_hostapd[1].list_sta())
 =

         testutil.test_iface_operstate(device.name)
-- =

2.26.2

--===============4436982083645813501==--

