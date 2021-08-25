Content-Type: multipart/mixed; boundary="===============5370073411209100661=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] auto-t: Update Process changes in a few autotests
Date: Wed, 25 Aug 2021 15:17:26 -0700
Message-ID: <20210825221726.784086-4-prestwoj@gmail.com>
In-Reply-To: <20210825221726.784086-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5370073411209100661==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testNetconfig/connection_test.py | 6 +++---
 autotests/testNetconfig/static_test.py     | 6 +++---
 autotests/testP2P/connection_test.py       | 2 +-
 autotests/testSAE-roam/connection_test.py  | 6 +++---
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/autotests/testNetconfig/connection_test.py b/autotests/testNet=
config/connection_test.py
index 99fe734c..b1d4afef 100644
--- a/autotests/testNetconfig/connection_test.py
+++ b/autotests/testNetconfig/connection_test.py
@@ -59,9 +59,9 @@ class Test(unittest.TestCase):
         # TODO: This could be moved into test-runner itself if other tests=
 ever
         #       require this functionality (p2p, FILS, etc.). Since its si=
mple
         #       enough it can stay here for now.
-        ctx.start_process(['ifconfig', hapd.ifname, '192.168.1.1', 'netmas=
k', '255.255.255.0'],
-                                wait=3DTrue)
-        ctx.start_process(['touch', '/tmp/dhcpd.leases'], wait=3DTrue)
+        ctx.start_process(['ifconfig', hapd.ifname, '192.168.1.1',
+                            'netmask', '255.255.255.0']).wait()
+        ctx.start_process(['touch', '/tmp/dhcpd.leases']).wait()
         cls.dhcpd_pid =3D ctx.start_process(['dhcpd', '-f', '-cf', '/tmp/d=
hcpd.conf',
                                             '-lf', '/tmp/dhcpd.leases',
                                             hapd.ifname], cleanup=3Dremove=
_lease)
diff --git a/autotests/testNetconfig/static_test.py b/autotests/testNetconf=
ig/static_test.py
index 21384a7b..eb918e92 100644
--- a/autotests/testNetconfig/static_test.py
+++ b/autotests/testNetconfig/static_test.py
@@ -86,9 +86,9 @@ class Test(unittest.TestCase):
         # TODO: This could be moved into test-runner itself if other tests=
 ever
         #       require this functionality (p2p, FILS, etc.). Since its si=
mple
         #       enough it can stay here for now.
-        ctx.start_process(['ifconfig', hapd.ifname, '192.168.1.1', 'netmas=
k', '255.255.255.0'],
-                                wait=3DTrue)
-        ctx.start_process(['touch', '/tmp/dhcpd.leases'], wait=3DTrue)
+        ctx.start_process(['ifconfig', hapd.ifname, '192.168.1.1',
+                            'netmask', '255.255.255.0']).wait()
+        ctx.start_process(['touch', '/tmp/dhcpd.leases']).wait()
         cls.dhcpd_pid =3D ctx.start_process(['dhcpd', '-f', '-cf', '/tmp/d=
hcpd.conf',
                                             '-lf', '/tmp/dhcpd.leases',
                                             hapd.ifname], cleanup=3Dremove=
_lease)
diff --git a/autotests/testP2P/connection_test.py b/autotests/testP2P/conne=
ction_test.py
index 52da0edc..46440053 100644
--- a/autotests/testP2P/connection_test.py
+++ b/autotests/testP2P/connection_test.py
@@ -94,7 +94,7 @@ class Test(unittest.TestCase):
         self.assertEqual(wpas.p2p_group['role'], 'GO' if not go else 'clie=
nt')
 =

         if not go:
-            ctx.start_process(['ifconfig', peer_ifname, '192.168.1.20', 'n=
etmask', '255.255.255.0'], wait=3DTrue)
+            ctx.start_process(['ifconfig', peer_ifname, '192.168.1.20', 'n=
etmask', '255.255.255.0']).wait()
             os.system('> /tmp/dhcp.leases')
             dhcp =3D ctx.start_process(['dhcpd', '-f', '-cf', '/tmp/dhcpd.=
conf', '-lf', '/tmp/dhcp.leases', peer_ifname])
             self.dhcp =3D dhcp
diff --git a/autotests/testSAE-roam/connection_test.py b/autotests/testSAE-=
roam/connection_test.py
index da7413f9..20d94c8f 100644
--- a/autotests/testSAE-roam/connection_test.py
+++ b/autotests/testSAE-roam/connection_test.py
@@ -125,11 +125,11 @@ class Test(unittest.TestCase):
                             HostapdCLI(config=3D'ft-psk-3.conf') ]
 =

         ctx.start_process(['ifconfig', cls.bss_hostapd[0].ifname, 'down', =
'hw', \
-                                'ether', '12:00:00:00:00:01', 'up'], wait=
=3DTrue)
+                                'ether', '12:00:00:00:00:01', 'up']).wait()
         ctx.start_process(['ifconfig', cls.bss_hostapd[1].ifname, 'down', =
'hw', \
-                                'ether', '12:00:00:00:00:02', 'up'], wait=
=3DTrue)
+                                'ether', '12:00:00:00:00:02', 'up']).wait()
         ctx.start_process(['ifconfig', cls.bss_hostapd[2].ifname, 'down', =
'hw', \
-                                'ether', '12:00:00:00:00:03', 'up'], wait=
=3DTrue)
+                                'ether', '12:00:00:00:00:03', 'up']).wait()
 =

         # Set interface addresses to those expected by hostapd config files
         cls.bss_hostapd[0].reload()
-- =

2.31.1

--===============5370073411209100661==--

