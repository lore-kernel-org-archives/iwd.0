Content-Type: multipart/mixed; boundary="===============4360273796686209194=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 08/26] auto-t: fix hidden network test
Date: Thu, 10 Sep 2020 11:58:37 -0700
Message-ID: <20200910185855.27833-8-prestwoj@gmail.com>
In-Reply-To: <20200910185855.27833-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4360273796686209194==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This test was never 100% reliable, and after the test-runner re-write
it became extremely unreliable. The issue came down to the very common
block of code thats present in many tests where we wait for obj.scanning
then not obj.scanning. This is fine when a dbus scan() is explicitly
done before, otherwise it could lead to problems. Without a dbus scan
explicitly called we are assuming a periodic scan will happen. If it
already happen the initial wait for obj.scanning will never return and
time out.

This probably needs to be changed in several tests, but for this specific
case we can remove the waits completely. Since
check_autoconnect_hidden_network has a 30 second wait on
DeviceState.connected this will ultimately time out if anything goes
wrong. There isn't any great reason to wait for scanning (for this test
specifically).

A minor style change was also made when initializing IWD. The values
passed in this test are now the default, so no arguments need to be
passed.
---
 .../connect_after_hidden_connect_test.py                  | 2 +-
 autotests/testHiddenNetworks/validation.py                | 8 +-------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/autotests/testHiddenNetworks/connect_after_hidden_connect_test=
.py b/autotests/testHiddenNetworks/connect_after_hidden_connect_test.py
index 478f1505..d9851c6a 100644
--- a/autotests/testHiddenNetworks/connect_after_hidden_connect_test.py
+++ b/autotests/testHiddenNetworks/connect_after_hidden_connect_test.py
@@ -27,7 +27,7 @@ class TestConnectionAfterHiddenNetwork(unittest.TestCase):
         self._ex =3D ex
 =

     def test_connection(self):
-        wd =3D IWD(True, '/tmp')
+        wd =3D IWD(True)
 =

         psk_agent =3D PSKAgent("secret123")
         wd.register_psk_agent(psk_agent)
diff --git a/autotests/testHiddenNetworks/validation.py b/autotests/testHid=
denNetworks/validation.py
index 9c433623..780af8b3 100644
--- a/autotests/testHiddenNetworks/validation.py
+++ b/autotests/testHiddenNetworks/validation.py
@@ -50,11 +50,6 @@ class TestConnectAutoConnect(unittest.TestCase):
         device =3D devices[0]
 =

         if autoconnect:
-            condition =3D 'obj.scanning'
-            wd.wait_for_object_condition(device, condition)
-            condition =3D 'not obj.scanning'
-            wd.wait_for_object_condition(device, condition)
-
             self.check_autoconnect_hidden_network(wd, device, ssid, throws)
         else:
             if wait_periodic_scan:
@@ -71,7 +66,6 @@ class TestConnectAutoConnect(unittest.TestCase):
 =

     def validate(self, ssid, autoconnect, throws =3D None, use_agent =3D F=
alse,
                                                     wait_periodic_scan =3D=
 False):
-        wd =3D IWD(True, '/tmp')
-
+        wd =3D IWD(True)
         self.validate_connection(wd, ssid, autoconnect, throws, use_agent,
                                                         wait_periodic_scan)
-- =

2.21.3

--===============4360273796686209194==--

