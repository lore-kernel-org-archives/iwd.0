Content-Type: multipart/mixed; boundary="===============7051193743794319484=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH] autotests: p2p: Make waiting for dhclient more reliable
Date: Mon, 22 Nov 2021 15:42:37 +0100
Message-ID: <20211122144237.647864-1-andrew.zaborowski@intel.com>

--===============7051193743794319484==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make sure we wipe the leases file both for server and client, so that
dhclient doesn't try to re-use leases from previous tests (should really
happen) and waste time waiting for a reply.  Extend the timeout from 1s
to 5s, sometimes it takes dhclient 1s just to start.  Disable verbose
mode if not needed to avoid dhclient stalling if the pipe is not being
read.
---
 autotests/testP2P/connection_test.py | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/autotests/testP2P/connection_test.py b/autotests/testP2P/conne=
ction_test.py
index ddebc70a..d1681164 100644
--- a/autotests/testP2P/connection_test.py
+++ b/autotests/testP2P/connection_test.py
@@ -12,6 +12,8 @@ from config import ctx
 from wpas import Wpas
 =

 class Test(unittest.TestCase):
+    leases_path =3D '/tmp/dhcp.lease'
+
     def test_1_client_go_neg_responder(self):
         self.p2p_connect_test(preauthorize=3DFalse, go=3DFalse)
 =

@@ -92,10 +94,11 @@ class Test(unittest.TestCase):
         peer_ifname =3D wpas.p2p_group['ifname']
         self.assertEqual(wpas.p2p_group['role'], 'GO' if not go else 'clie=
nt')
 =

+        os.system('> ' + self.leases_path)
+
         if not go:
             ctx.start_process(['ip', 'addr', 'add','dev', peer_ifname, '19=
2.168.1.20/255.255.255.0']).wait()
-            os.system('> /tmp/dhcp.leases')
-            dhcp =3D ctx.start_process(['dhcpd', '-f', '-cf', '/tmp/dhcpd.=
conf', '-lf', '/tmp/dhcp.leases', peer_ifname])
+            dhcp =3D ctx.start_process(['dhcpd', '-f', '-cf', '/tmp/dhcpd.=
conf', '-lf', self.leases_path, peer_ifname])
             self.dhcp =3D dhcp
 =

             wd.wait_for_object_condition(wpas, 'len(obj.p2p_clients) =3D=
=3D 1', max_wait=3D3)
@@ -105,12 +108,17 @@ class Test(unittest.TestCase):
             self.assertEqual(wpas.p2p_group['ip_addr'], '192.168.1.2')
             self.assertEqual(wpas.p2p_group['ip_mask'], '255.255.255.240')
             self.assertEqual(wpas.p2p_group['go_ip_addr'], '192.168.1.1')
-            dhcp =3D ctx.start_process(['dhclient', '-v', '-d', '--no-pid'=
, '-cf', '/dev/null', '-lf', '/tmp/dhcp.leases',
-                '-sf', '/tmp/dhclient-script', peer_ifname])
+
+            extra_params =3D []
+            if ctx.is_verbose('dhclient'):
+                extra_params.append('-v')
+
+            dhcp =3D ctx.start_process(['dhclient', '-d', '--no-pid', '-cf=
', '/dev/null', '-lf', self.leases_path,
+                '-sf', '/tmp/dhclient-script'] + extra_params + [peer_ifna=
me])
             self.dhcp =3D dhcp
 =

         wd.wait_for_object_condition(peer, 'obj.connected', max_wait=3D15)
-        time.sleep(1) # Give the client time to set the IP
+        time.sleep(5) # Give the client time to set the IP
         testutil.test_ip_address_match(peer_ifname, peer.connected_ip)
 =

         if not go:
@@ -146,7 +154,7 @@ class Test(unittest.TestCase):
             self.wpas =3D None
         if self.dhcp is not None:
             ctx.stop_process(self.dhcp)
-        for path in ['/tmp/dhcp.leases']:
+        for path in [self.leases_path, self.leases_path + '~']:
             if os.path.exists(path):
                 os.remove(path)
 =

-- =

2.32.0

--===============7051193743794319484==--

