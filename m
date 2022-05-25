Content-Type: multipart/mixed; boundary="===============7049785003868578532=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 4/5] auto-t: use copy_to_storage in address randomization test
Date: Wed, 25 May 2022 12:23:27 -0700
Message-ID: <20220525192328.335557-4-prestwoj@gmail.com>
In-Reply-To: 20220525192328.335557-1-prestwoj@gmail.com

--===============7049785003868578532==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This test was just piping the PSK files into /tmp/iwd/ssidCCMP.psk
which is a bit fragile if the storage dir was ever to change. Instead
use copy_to_storage and the 'name' keyword to copy the file.
---
 autotests/testAddressRandomization/connection_test.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/autotests/testAddressRandomization/connection_test.py b/autote=
sts/testAddressRandomization/connection_test.py
index 32163e0f..f9f62f7a 100644
--- a/autotests/testAddressRandomization/connection_test.py
+++ b/autotests/testAddressRandomization/connection_test.py
@@ -46,7 +46,7 @@ class Test(unittest.TestCase):
         perm_addr =3D device.address
 =

         # 1. Test per-network deterministic MAC generation
-        os.system('cat pernetwork.psk > /tmp/iwd/ssidCCMP.psk')
+        IWD.copy_to_storage('pernetwork.psk', name=3D'ssidCCMP.psk')
         new_addr =3D self.try_connection(wd)
         self.assertNotEqual(perm_addr, new_addr)
         # try again to ensure the generation was deterministic
@@ -54,7 +54,7 @@ class Test(unittest.TestCase):
         self.assertEqual(new_addr, new_addr2)
 =

         # 2. Test FullAddressRandomization
-        os.system('cat full_random.psk > /tmp/iwd/ssidCCMP.psk')
+        IWD.copy_to_storage('full_random.psk', name=3D'ssidCCMP.psk')
         new_addr =3D self.try_connection(wd)
         self.assertNotEqual(perm_addr, new_addr)
         # try again to make sure the generation was random
@@ -62,7 +62,7 @@ class Test(unittest.TestCase):
         self.assertNotEqual(new_addr, new_addr2)
 =

         # 3. Test AddressOverride
-        os.system('cat override.psk > /tmp/iwd/ssidCCMP.psk')
+        IWD.copy_to_storage('override.psk', name=3D'ssidCCMP.psk')
         new_addr =3D self.try_connection(wd)
         self.assertEqual(new_addr, 'e6:f6:38:a9:02:02')
 =

-- =

2.34.1

--===============7049785003868578532==--

