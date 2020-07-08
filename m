Content-Type: multipart/mixed; boundary="===============2048321252962863017=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] auto-t: increase wait time for blacklist test
Date: Wed, 08 Jul 2020 10:48:00 -0700
Message-ID: <20200708174801.14447-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2048321252962863017==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This test was not reliably passing. Busy waiting is not really reliable,
but in this specific case its really the only option as the blacklist
must expire based on time.
---
 autotests/testBSSBlacklist/connection_test.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/autotests/testBSSBlacklist/connection_test.py b/autotests/test=
BSSBlacklist/connection_test.py
index 917f3192..7433d5f3 100644
--- a/autotests/testBSSBlacklist/connection_test.py
+++ b/autotests/testBSSBlacklist/connection_test.py
@@ -48,9 +48,11 @@ class Test(unittest.TestCase):
         psk_agent =3D PSKAgent("secret123")
         wd.register_psk_agent(psk_agent)
 =

-        devices =3D wd.list_devices(1)
+        devices =3D wd.list_devices(2)
         device =3D devices[0]
 =

+        devices[1].disconnect()
+
         condition =3D 'not obj.scanning'
         wd.wait_for_object_condition(device, condition)
 =

@@ -110,8 +112,8 @@ class Test(unittest.TestCase):
         # Wait for the blacklist to expire (10 seconds)
         elapsed =3D time.time() - start
 =

-        if elapsed < 11:
-            time.sleep(11 - elapsed)
+        if elapsed < 15:
+            wd.wait(15 - elapsed)
 =

         device.disconnect()
 =

-- =

2.21.1

--===============2048321252962863017==--

