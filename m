Content-Type: multipart/mixed; boundary="===============8401905718380377499=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/2] autotests: Don't use the netifaces module
Date: Fri, 03 Sep 2021 21:06:43 +0200
Message-ID: <20210903190643.252321-2-andrew.zaborowski@intel.com>
In-Reply-To: <20210903190643.252321-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8401905718380377499==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Get rid of a dependency on a package that needed to be manually
installed.
---
 autotests/testP2P/connection_test.py | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/autotests/testP2P/connection_test.py b/autotests/testP2P/conne=
ction_test.py
index 76613fa6..04f63fdf 100644
--- a/autotests/testP2P/connection_test.py
+++ b/autotests/testP2P/connection_test.py
@@ -2,7 +2,6 @@
 =

 import unittest
 import sys
-import netifaces
 import os
 import time
 =

@@ -112,16 +111,14 @@ class Test(unittest.TestCase):
 =

         wd.wait_for_object_condition(peer, 'obj.connected', max_wait=3D15)
         time.sleep(1) # Give the client time to set the IP
-        our_ip =3D netifaces.ifaddresses(peer.connected_interface)[netifac=
es.AF_INET][0]['addr']
-        peer_ip =3D netifaces.ifaddresses(peer_ifname)[netifaces.AF_INET][=
0]['addr']
-        self.assertEqual(peer.connected_ip, peer_ip)
+        testutil.test_ip_address_match(peer_ifname, peer.connected_ip)
 =

         if not go:
-            self.assertEqual(our_ip, '192.168.1.30')
-            self.assertEqual(peer_ip, '192.168.1.20')
+            testutil.test_ip_address_match(peer.connected_interface, '192.=
168.1.30')
+            self.assertEqual(peer.connected_ip, '192.168.1.20')
         else:
-            self.assertEqual(our_ip, '192.168.1.1')
-            self.assertEqual(peer_ip, '192.168.1.2')
+            testutil.test_ip_address_match(peer.connected_interface, '192.=
168.1.1')
+            self.assertEqual(peer.connected_ip, '192.168.1.2')
 =

         testutil.test_iface_operstate(peer.connected_interface)
         testutil.test_ifaces_connected(peer.connected_interface, peer_ifna=
me)
-- =

2.30.2

--===============8401905718380377499==--

