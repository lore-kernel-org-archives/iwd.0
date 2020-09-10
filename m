Content-Type: multipart/mixed; boundary="===============7242674272949961733=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 21/26] auto-t: fix testAP
Date: Thu, 10 Sep 2020 16:12:42 -0700
Message-ID: <20200910231248.4995-21-prestwoj@gmail.com>
In-Reply-To: <20200910231248.4995-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7242674272949961733==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As with other tests, wait on device state instead of the network
object. The connectivity test was also changed to not check for
group traffic since AP does not negotiate the IGTK at this time.
---
 autotests/testAP/connection_test.py | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/autotests/testAP/connection_test.py b/autotests/testAP/connect=
ion_test.py
index 36302da1..c3744c55 100644
--- a/autotests/testAP/connection_test.py
+++ b/autotests/testAP/connection_test.py
@@ -24,8 +24,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(dev, condition)
 =

         wd.unregister_psk_agent(psk_agent)
 =

@@ -74,12 +74,11 @@ class Test(unittest.TestCase):
 =

             networks['TestAP2'].network_object.connect()
 =

-            condition =3D 'obj.connected'
-            wd.wait_for_object_condition(networks['TestAP2'].network_objec=
t,
-                                         condition)
+            condition =3D 'obj.state =3D=3D DeviceState.connected'
+            wd.wait_for_object_condition(dev2, condition)
 =

             testutil.test_iface_operstate(dev2.name)
-            testutil.test_ifaces_connected(dev1.name, dev2.name)
+            testutil.test_ifaces_connected(dev1.name, dev2.name, group=3DF=
alse)
 =

             wd.unregister_psk_agent(psk_agent)
 =

-- =

2.26.2

--===============7242674272949961733==--

