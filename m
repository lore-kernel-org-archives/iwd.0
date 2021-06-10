Content-Type: multipart/mixed; boundary="===============2109250838497621669=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] autotest: Improve cleanup in testP2P
Date: Thu, 10 Jun 2021 23:03:52 +0200
Message-ID: <20210610210352.329398-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2109250838497621669==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make sure some of the processes and files created are also cleaned up on
failure so that the next chance has a chance to succeed anyway.
---
 autotests/testP2P/connection_test.py | 31 +++++++++++++++++++++-------
 autotests/util/wpas.py               | 11 ++++------
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/autotests/testP2P/connection_test.py b/autotests/testP2P/conne=
ction_test.py
index 9bb0e34e..22871547 100644
--- a/autotests/testP2P/connection_test.py
+++ b/autotests/testP2P/connection_test.py
@@ -27,7 +27,7 @@ class Test(unittest.TestCase):
 =

     def p2p_connect_test(self, preauthorize, go):
         wd =3D IWD()
-        wpas =3D Wpas(p2p=3DTrue)
+        wpas =3D self.wpas =3D Wpas(p2p=3DTrue)
         wpas_go_intent =3D 10 if not go else 1
 =

         # Not strictly necessary but prevents the station interface from q=
ueuing its scans
@@ -35,7 +35,7 @@ class Test(unittest.TestCase):
         wd.list_devices(1)[0].disconnect()
 =

         devices =3D wd.list_p2p_devices(1)
-        p2p =3D devices[0]
+        p2p =3D self.p2p =3D devices[0]
         p2p.enabled =3D True
         p2p.name =3D 'testdev1'
 =

@@ -94,15 +94,17 @@ class Test(unittest.TestCase):
 =

         if not go:
             ctx.start_process(['ifconfig', peer_ifname, '192.168.1.20', 'n=
etmask', '255.255.255.0'], wait=3DTrue)
-            os.system('> /tmp/dhcpd.leases')
-            dhcp =3D ctx.start_process(['dhcpd', '-f', '-cf', '/tmp/dhcpd.=
conf', '-lf', '/tmp/dhcpd.leases', peer_ifname])
+            os.system('> /tmp/dhcp.leases')
+            dhcp =3D ctx.start_process(['dhcpd', '-f', '-cf', '/tmp/dhcpd.=
conf', '-lf', '/tmp/dhcp.leases', peer_ifname])
+            self.dhcp =3D dhcp
 =

             wd.wait_for_object_condition(wpas, 'len(obj.p2p_clients) =3D=
=3D 1', max_wait=3D3)
             client =3D wpas.p2p_clients[request['peer_iface']]
             self.assertEqual(client['p2p_dev_addr'], wpas_peer['p2p_dev_ad=
dr'])
         else:
-            dhcp =3D ctx.start_process(['dhclient', '-v', '-d', '--no-pid'=
, '-cf', '/dev/null', '-lf', '/tmp/dhcpd.leases',
+            dhcp =3D ctx.start_process(['dhclient', '-v', '-d', '--no-pid'=
, '-cf', '/dev/null', '-lf', '/tmp/dhcp.leases',
                 '-sf', '/tmp/dhclient-script', peer_ifname])
+            self.dhcp =3D dhcp
 =

         wd.wait_for_object_condition(peer, 'obj.connected', max_wait=3D15)
         time.sleep(1) # Give the client time to set the IP
@@ -127,9 +129,22 @@ class Test(unittest.TestCase):
             wd.wait_for_object_condition(wpas, 'obj.p2p_group is None', ma=
x_wait=3D3)
         self.assertEqual(peer.connected, False)
 =

-        p2p.enabled =3D False
-        ctx.stop_process(dhcp)
-        wpas.clean_up()
+    def setUp(self):
+        self.p2p =3D None
+        self.wpas =3D None
+        self.dhcp =3D None
+
+    def tearDown(self):
+        if self.p2p is not None:
+            self.p2p.enabled =3D False
+        if self.wpas is not None:
+            self.wpas.clean_up()
+            self.wpas =3D None
+        if self.dhcp is not None:
+            ctx.stop_process(self.dhcp)
+        for path in ['/tmp/dhcp.leases']:
+            if os.path.exists(path):
+                os.remove(path)
 =

     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/util/wpas.py b/autotests/util/wpas.py
index 7072272a..1758eede 100644
--- a/autotests/util/wpas.py
+++ b/autotests/util/wpas.py
@@ -245,6 +245,9 @@ class Wpas:
         if self.io_watch is not None:
             GLib.source_remove(self.io_watch)
             self.io_watch =3D None
+        for ifname in self.sockets:
+            self.sockets[ifname].close()
+        self.sockets =3D {}
         if self.wpa_supplicant is not None:
             ctx.stop_process(self.wpa_supplicant)
             self.wpa_supplicant =3D None
@@ -253,11 +256,5 @@ class Wpas:
                 os.remove(path)
         self.cleanup_paths =3D []
 =

-    def _stop_wpas(self):
-        self.clean_up()
-        for ifname in self.sockets:
-            self.sockets[ifname].close()
-        self.sockets =3D {}
-
     def __del__(self):
-        self._stop_wpas()
+        self.clean_up()
-- =

2.30.2

--===============2109250838497621669==--

