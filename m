Content-Type: multipart/mixed; boundary="===============8428378144534603827=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 4/5] auto-t: Use changed get_ordered_network API
Date: Thu, 07 May 2020 12:20:22 -0700
Message-ID: <20200507192023.11498-4-tim.a.kourt@linux.intel.com>
In-Reply-To: <20200507192023.11498-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8428378144534603827==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Rely on internal scan and wait implementation of get_ordered_network
to obtain the known networks
---
 autotests/testAP/failure_test.py | 11 +----------
 autotests/testAP/test.py         | 11 +----------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/autotests/testAP/failure_test.py b/autotests/testAP/failure_te=
st.py
index 2c1e14b3..9944abaa 100644
--- a/autotests/testAP/failure_test.py
+++ b/autotests/testAP/failure_test.py
@@ -14,17 +14,8 @@ import testutil
 class Test(unittest.TestCase):
 =

     def client_connect(self, wd, dev):
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(dev, condition)
 =

-        if not dev.get_ordered_networks():
-            dev.scan()
-            condition =3D 'obj.scanning'
-            wd.wait_for_object_condition(dev, condition)
-            condition =3D 'not obj.scanning'
-            wd.wait_for_object_condition(dev, condition)
-
-        ordered_network =3D dev.get_ordered_network('TestAP1')
+        ordered_network =3D dev.get_ordered_network('TestAP1', True)
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
 =

diff --git a/autotests/testAP/test.py b/autotests/testAP/test.py
index 455c9916..4cacf9ad 100644
--- a/autotests/testAP/test.py
+++ b/autotests/testAP/test.py
@@ -14,17 +14,8 @@ import testutil
 class Test(unittest.TestCase):
 =

     def client_connect(self, wd, dev):
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(dev, condition)
 =

-        if not dev.get_ordered_networks():
-            dev.scan()
-            condition =3D 'obj.scanning'
-            wd.wait_for_object_condition(dev, condition)
-            condition =3D 'not obj.scanning'
-            wd.wait_for_object_condition(dev, condition)
-
-        ordered_network =3D dev.get_ordered_network('TestAP1')
+        ordered_network =3D dev.get_ordered_network('TestAP1', True)
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
 =

-- =

2.13.6

--===============8428378144534603827==--

