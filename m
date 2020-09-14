Content-Type: multipart/mixed; boundary="===============6057507685173273288=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/6] auto-t: update AdHoc tests to use AdHocDevice
Date: Mon, 14 Sep 2020 14:04:06 -0700
Message-ID: <20200914210407.428918-6-prestwoj@gmail.com>
In-Reply-To: <20200914210407.428918-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6057507685173273288==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testAdHoc/adhoc_test.py | 18 ++++++++++++++----
 autotests/testAdHoc/open_test.py  | 19 ++++++++++++++-----
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/autotests/testAdHoc/adhoc_test.py b/autotests/testAdHoc/adhoc_=
test.py
index 119c6c7e..13c0c016 100644
--- a/autotests/testAdHoc/adhoc_test.py
+++ b/autotests/testAdHoc/adhoc_test.py
@@ -17,11 +17,21 @@ class Test(unittest.TestCase):
         self.assertIsNotNone(dev1)
         self.assertIsNotNone(dev2)
 =

-        dev1.start_adhoc("AdHocNetwork", "secret123")
-        dev2.start_adhoc("AdHocNetwork", "secret123")
+        adhoc1 =3D dev1.start_adhoc("AdHocNetwork", "secret123")
 =

-        dev1.adhoc_wait_for_connected(dev2.address)
-        dev2.adhoc_wait_for_connected(dev1.address)
+        condition =3D 'obj.started =3D=3D True'
+        wd.wait_for_object_condition(adhoc1, condition)
+
+        adhoc2 =3D dev2.start_adhoc("AdHocNetwork", "secret123")
+
+        condition =3D 'obj.started =3D=3D True'
+        wd.wait_for_object_condition(adhoc1, condition)
+
+        condition =3D '"%s" in obj.connected_peers' % dev2.address
+        wd.wait_for_object_condition(adhoc1, condition)
+
+        condition =3D '"%s" in obj.connected_peers' % dev1.address
+        wd.wait_for_object_condition(adhoc2, condition)
 =

         testutil.test_iface_operstate(dev1.name)
         testutil.test_iface_operstate(dev2.name)
diff --git a/autotests/testAdHoc/open_test.py b/autotests/testAdHoc/open_te=
st.py
index a3882a50..4e0ae27f 100644
--- a/autotests/testAdHoc/open_test.py
+++ b/autotests/testAdHoc/open_test.py
@@ -18,12 +18,21 @@ class Test(unittest.TestCase):
         self.assertIsNotNone(dev1)
         self.assertIsNotNone(dev2)
 =

-        dev1.start_adhoc("AdHocNetwork")
-        sleep(1)
-        dev2.start_adhoc("AdHocNetwork")
+        adhoc1 =3D dev1.start_adhoc("AdHocNetwork")
 =

-        dev1.adhoc_wait_for_connected(dev2.address)
-        dev2.adhoc_wait_for_connected(dev1.address)
+        condition =3D 'obj.started =3D=3D True'
+        wd.wait_for_object_condition(adhoc1, condition)
+
+        adhoc2 =3D dev2.start_adhoc("AdHocNetwork")
+
+        condition =3D 'obj.started =3D=3D True'
+        wd.wait_for_object_condition(adhoc1, condition)
+
+        condition =3D '"%s" in obj.connected_peers' % dev2.address
+        wd.wait_for_object_condition(adhoc1, condition)
+
+        condition =3D '"%s" in obj.connected_peers' % dev1.address
+        wd.wait_for_object_condition(adhoc2, condition)
 =

         testutil.test_iface_operstate(dev1.name)
         testutil.test_iface_operstate(dev2.name)
-- =

2.26.2

--===============6057507685173273288==--

