Content-Type: multipart/mixed; boundary="===============2074864721050482174=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] auto-t: remove OWE renegotiate test
Date: Wed, 08 Sep 2021 16:15:16 -0700
Message-ID: <20210908231516.103337-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2074864721050482174==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since IWD tries group 20 first all other OWE tests are actually
triggering group negotiation where this test is not. Since this
code is exercised this test can be removed completely, as well
as the additional radio/network.
---
 autotests/testOWE/hw.conf             |  3 +-
 autotests/testOWE/renegotiate_test.py | 60 ---------------------------
 autotests/testOWE/ssidGroup20.conf    |  8 ----
 3 files changed, 1 insertion(+), 70 deletions(-)
 delete mode 100644 autotests/testOWE/renegotiate_test.py
 delete mode 100644 autotests/testOWE/ssidGroup20.conf

diff --git a/autotests/testOWE/hw.conf b/autotests/testOWE/hw.conf
index 1421b69c..dc2aaaf9 100644
--- a/autotests/testOWE/hw.conf
+++ b/autotests/testOWE/hw.conf
@@ -1,8 +1,7 @@
 [SETUP]
-num_radios=3D4
+num_radios=3D3
 hwsim_medium=3Dyes
 =

 [HOSTAPD]
 rad0=3DssidOWE-1.conf
 rad1=3DssidOWE-2.conf
-rad2=3DssidGroup20.conf
diff --git a/autotests/testOWE/renegotiate_test.py b/autotests/testOWE/rene=
gotiate_test.py
deleted file mode 100644
index e3fd911b..00000000
--- a/autotests/testOWE/renegotiate_test.py
+++ /dev/null
@@ -1,60 +0,0 @@
-#!/usr/bin/python3
-
-import unittest
-import sys
-
-sys.path.append('../util')
-import iwd
-from iwd import IWD
-from iwd import NetworkType
-from hostapd import HostapdCLI
-import testutil
-
-class Test(unittest.TestCase):
-
-    def test_connection_success(self):
-        hapd =3D HostapdCLI(config=3D'ssidGroup20.conf')
-
-        wd =3D IWD()
-
-        devices =3D wd.list_devices(1)
-        device =3D devices[0]
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        ordered_network =3D device.get_ordered_network('ssidGroup20')
-
-        self.assertEqual(ordered_network.type, NetworkType.open)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        ordered_network.network_object.connect()
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        testutil.test_iface_operstate()
-        testutil.test_ifaces_connected(device.name, hapd.ifname)
-
-        device.disconnect()
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-    @classmethod
-    def setUpClass(cls):
-        pass
-
-    @classmethod
-    def tearDownClass(cls):
-        IWD.clear_storage()
-
-if __name__ =3D=3D '__main__':
-    unittest.main(exit=3DTrue)
diff --git a/autotests/testOWE/ssidGroup20.conf b/autotests/testOWE/ssidGro=
up20.conf
deleted file mode 100644
index afd5c0a4..00000000
--- a/autotests/testOWE/ssidGroup20.conf
+++ /dev/null
@@ -1,8 +0,0 @@
-ctrl_interface=3D/var/run/hostapd
-hw_mode=3Dg
-channel=3D1
-ssid=3DssidGroup20
-wpa=3D2
-wpa_key_mgmt=3DOWE
-rsn_pairwise=3DCCMP
-owe_groups=3D20
-- =

2.31.1

--===============2074864721050482174==--

