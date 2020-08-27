Content-Type: multipart/mixed; boundary="===============8940971242347618620=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 10/16] auto-t: fix hidden network test
Date: Thu, 27 Aug 2020 10:32:23 -0700
Message-ID: <20200827173229.26466-10-prestwoj@gmail.com>
In-Reply-To: <20200827173229.26466-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8940971242347618620==
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
 autotests/testHiddenNetworks/validation.py | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/autotests/testHiddenNetworks/validation.py b/autotests/testHid=
denNetworks/validation.py
index 9c433623..991a5b32 100644
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
+        wd =3D IWD()
         self.validate_connection(wd, ssid, autoconnect, throws, use_agent,
                                                         wait_periodic_scan)
-- =

2.21.1

--===============8940971242347618620==--

