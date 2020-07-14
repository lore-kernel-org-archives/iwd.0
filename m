Content-Type: multipart/mixed; boundary="===============5588699838973019412=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] auto-t: make testSAQuery more reliable
Date: Tue, 14 Jul 2020 11:49:08 -0700
Message-ID: <20200714184908.2776-2-prestwoj@gmail.com>
In-Reply-To: <20200714184908.2776-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5588699838973019412==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

First, looking for DeviceState.connected gives a much better indication
if we are actually connected vs the connected property on the network
object. Second, its good practice to also check that hostapd sees that
the station is connected.
---
 autotests/testSAQuery/connection_test.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/autotests/testSAQuery/connection_test.py b/autotests/testSAQue=
ry/connection_test.py
index 13c45ee9..de0fe2cd 100644
--- a/autotests/testSAQuery/connection_test.py
+++ b/autotests/testSAQuery/connection_test.py
@@ -13,7 +13,7 @@ from hostapd import HostapdCLI, hostapd_map
 class Test(unittest.TestCase):
 =

     def test_connection_success(self):
-        hostapd =3D HostapdCLI(list(hostapd_map.values())[0])
+        hostapd =3D HostapdCLI(config=3D'ssidCCMP.conf')
 =

         wd =3D IWD()
 =

@@ -53,8 +53,10 @@ class Test(unittest.TestCase):
 =

         # IWD should now try and re-connect to the AP
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
+        hostapd.wait_for_event('AP-STA-CONNECTED')
 =

         device.disconnect()
 =

-- =

2.21.1

--===============5588699838973019412==--

