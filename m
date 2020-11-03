Content-Type: multipart/mixed; boundary="===============8909710243663883751=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] auto-t: remove more /var/lib/iwd references
Date: Tue, 03 Nov 2020 12:51:14 -0800
Message-ID: <20201103205114.2744828-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8909710243663883751==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The address randomization test was using a /var/lib/iwd which
is no longer specially mounted or used for IWD storage. Instead
use /tmp/iwd.
---
 autotests/testAddressRandomization/connection_test.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/autotests/testAddressRandomization/connection_test.py b/autote=
sts/testAddressRandomization/connection_test.py
index 10d1b35b..d9806f8a 100644
--- a/autotests/testAddressRandomization/connection_test.py
+++ b/autotests/testAddressRandomization/connection_test.py
@@ -54,7 +54,7 @@ class Test(unittest.TestCase):
         wd.wait_for_object_condition(device, condition)
 =

         # 1. Test per-network deterministic MAC generation
-        os.system('cat pernetwork.psk > /var/lib/iwd/ssidCCMP.psk')
+        os.system('cat pernetwork.psk > /tmp/iwd/ssidCCMP.psk')
         new_addr =3D self.try_connection(wd)
         self.assertNotEqual(perm_addr, new_addr)
         # try again to ensure the generation was deterministic
@@ -62,7 +62,7 @@ class Test(unittest.TestCase):
         self.assertEqual(new_addr, new_addr2)
 =

         # 2. Test FullAddressRandomization
-        os.system('cat full_random.psk > /var/lib/iwd/ssidCCMP.psk')
+        os.system('cat full_random.psk > /tmp/iwd/ssidCCMP.psk')
         new_addr =3D self.try_connection(wd)
         self.assertNotEqual(perm_addr, new_addr)
         # try again to make sure the generation was random
@@ -70,7 +70,7 @@ class Test(unittest.TestCase):
         self.assertNotEqual(new_addr, new_addr2)
 =

         # 3. Test AddressOverride
-        os.system('cat override.psk > /var/lib/iwd/ssidCCMP.psk')
+        os.system('cat override.psk > /tmp/iwd/ssidCCMP.psk')
         new_addr =3D self.try_connection(wd)
         self.assertEqual(new_addr, 'e6:f6:38:a9:02:02')
 =

-- =

2.26.2

--===============8909710243663883751==--

