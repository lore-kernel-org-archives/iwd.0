Content-Type: multipart/mixed; boundary="===============5721425669145157666=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] auto-t: fix blacklist test timing issues
Date: Thu, 11 Feb 2021 15:16:14 -0800
Message-ID: <20210211231614.910157-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5721425669145157666==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This test fails randomly, and it appears to be due to excessive
scanning. Historically most autotests start a dbus scan right
away. The problem is that most likely a periodic scan is already
ongoing, meaning the dbus scan gets queued. If a Connect() call
comes in (which it always does), the dbus scan gets delayed and will
trigger once connected, at a time the test is not expecting. This
can cause problems with any assumed timing as well as offchannel
frames.

This patch removes the explicit DBus scanning and instead uses
scan_if_needed with get_ordered_networks. The 'all_blacklisted_test'
was also modified to wait for scanning to complete after failing
to connect to all BSS's. This lets all the networks fully come
up (after being blocked by hwsim) and appear in scan results.
---
 .../testBSSBlacklist/all_blacklisted_test.py      | 15 ++++++---------
 autotests/testBSSBlacklist/bad_pass_test.py       | 10 +---------
 autotests/testBSSBlacklist/connection_test.py     | 10 +---------
 autotests/testBSSBlacklist/temp_blacklist_test.py | 10 +---------
 4 files changed, 9 insertions(+), 36 deletions(-)

diff --git a/autotests/testBSSBlacklist/all_blacklisted_test.py b/autotests=
/testBSSBlacklist/all_blacklisted_test.py
index d3ed7acc..b52d0900 100644
--- a/autotests/testBSSBlacklist/all_blacklisted_test.py
+++ b/autotests/testBSSBlacklist/all_blacklisted_test.py
@@ -47,15 +47,7 @@ class Test(unittest.TestCase):
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
-        ordered_network =3D device.get_ordered_network("TestBlacklist")
+        ordered_network =3D device.get_ordered_network("TestBlacklist", sc=
an_if_needed=3DTrue)
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
 =

@@ -74,6 +66,11 @@ class Test(unittest.TestCase):
         rule1.drop =3D False
         rule2.drop =3D False
 =

+        # Wait for scanning (likely a quick-scan) to finish, otherwise we =
will
+        # may not have all BSS's in the list.
+        condition =3D 'not obj.scanning'
+        wd.wait_for_object_condition(device, condition)
+
         # This connect should work
         ordered_network.network_object.connect()
 =

diff --git a/autotests/testBSSBlacklist/bad_pass_test.py b/autotests/testBS=
SBlacklist/bad_pass_test.py
index 0aff053a..b0a81991 100644
--- a/autotests/testBSSBlacklist/bad_pass_test.py
+++ b/autotests/testBSSBlacklist/bad_pass_test.py
@@ -47,15 +47,7 @@ class Test(unittest.TestCase):
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
-        ordered_network =3D device.get_ordered_network("TestBlacklist")
+        ordered_network =3D device.get_ordered_network("TestBlacklist", sc=
an_if_needed=3DTrue)
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
 =

diff --git a/autotests/testBSSBlacklist/connection_test.py b/autotests/test=
BSSBlacklist/connection_test.py
index 8d7d92e1..111ae582 100644
--- a/autotests/testBSSBlacklist/connection_test.py
+++ b/autotests/testBSSBlacklist/connection_test.py
@@ -51,15 +51,7 @@ class Test(unittest.TestCase):
 =

         devices[1].disconnect()
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        ordered_network =3D device.get_ordered_network("TestBlacklist")
+        ordered_network =3D device.get_ordered_network("TestBlacklist", sc=
an_if_needed=3DTrue)
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
 =

diff --git a/autotests/testBSSBlacklist/temp_blacklist_test.py b/autotests/=
testBSSBlacklist/temp_blacklist_test.py
index 2a9590b8..efb848e9 100644
--- a/autotests/testBSSBlacklist/temp_blacklist_test.py
+++ b/autotests/testBSSBlacklist/temp_blacklist_test.py
@@ -46,15 +46,7 @@ class Test(unittest.TestCase):
 =

         dev1, dev2 =3D wd.list_devices(2)
 =

-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(dev1, condition)
-
-        dev1.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(dev1, condition)
-
-        ordered_network =3D dev1.get_ordered_network("TestBlacklist")
+        ordered_network =3D dev1.get_ordered_network("TestBlacklist", scan=
_if_needed=3DTrue)
 =

         self.assertEqual(ordered_network.type, NetworkType.psk)
 =

-- =

2.26.2

--===============5721425669145157666==--

