Content-Type: multipart/mixed; boundary="===============4031875632931560624=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/2] autotests: Test GO-side IP Allocation in testP2P
Date: Fri, 09 Jul 2021 13:49:31 +0200
Message-ID: <20210709114931.378607-2-andrew.zaborowski@intel.com>
In-Reply-To: <20210709114931.378607-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4031875632931560624==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Check if our wpa_supplicant P2P Client has received the allocated
Clieant IP/netmask/GO IP values we sent in the 4-Way Handshake.
---
 autotests/testP2P/connection_test.py | 4 ++++
 autotests/util/wpas.py               | 1 +
 2 files changed, 5 insertions(+)

diff --git a/autotests/testP2P/connection_test.py b/autotests/testP2P/conne=
ction_test.py
index 22871547..e145a295 100644
--- a/autotests/testP2P/connection_test.py
+++ b/autotests/testP2P/connection_test.py
@@ -91,6 +91,7 @@ class Test(unittest.TestCase):
 =

         wd.wait_for_object_condition(wpas, 'obj.p2p_group is not None', ma=
x_wait=3D3)
         peer_ifname =3D wpas.p2p_group['ifname']
+        self.assertEqual(wpas.p2p_group['role'], 'GO' if not go else 'clie=
nt')
 =

         if not go:
             ctx.start_process(['ifconfig', peer_ifname, '192.168.1.20', 'n=
etmask', '255.255.255.0'], wait=3DTrue)
@@ -102,6 +103,9 @@ class Test(unittest.TestCase):
             client =3D wpas.p2p_clients[request['peer_iface']]
             self.assertEqual(client['p2p_dev_addr'], wpas_peer['p2p_dev_ad=
dr'])
         else:
+            self.assertEqual(wpas.p2p_group['ip_addr'], '192.168.1.2')
+            self.assertEqual(wpas.p2p_group['ip_mask'], '255.255.255.240')
+            self.assertEqual(wpas.p2p_group['go_ip_addr'], '192.168.1.1')
             dhcp =3D ctx.start_process(['dhclient', '-v', '-d', '--no-pid'=
, '-cf', '/dev/null', '-lf', '/tmp/dhcp.leases',
                 '-sf', '/tmp/dhclient-script', peer_ifname])
             self.dhcp =3D dhcp
diff --git a/autotests/util/wpas.py b/autotests/util/wpas.py
index 1758eede..8fb725f8 100644
--- a/autotests/util/wpas.py
+++ b/autotests/util/wpas.py
@@ -159,6 +159,7 @@ class Wpas:
         elif event['event'] =3D=3D 'P2P-GROUP-STARTED':
             event.pop('event')
             event['ifname'] =3D event.pop('arg1')
+            event['role'] =3D event.pop('arg2')
             self.p2p_group =3D event
         elif event['event'] =3D=3D 'P2P-GROUP-REMOVED':
             self.p2p_group =3D None
-- =

2.30.2

--===============4031875632931560624==--

