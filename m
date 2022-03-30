Content-Type: multipart/mixed; boundary="===============2808615580176270198=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 6/7] auto-t: fix up a few issues in testNetconfig
Date: Wed, 30 Mar 2022 13:23:14 -0700
Message-ID: <20220330202315.1881335-6-prestwoj@gmail.com>
In-Reply-To: 20220330202315.1881335-1-prestwoj@gmail.com

--===============2808615580176270198==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 - Setting the IP address was resulting in an error:

   Error: any valid prefix is expected rather than "wln58".

   This is fixed by reordering the arguments with the IP address first

 - Remove the sleep, and use non_block_wait to wait for the IPv6 address
   to be set.
---
 autotests/testNetconfig/connection_test.py | 22 +++++++++++++++-------
 autotests/testNetconfig/static_test.py     |  3 ++-
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/autotests/testNetconfig/connection_test.py b/autotests/testNet=
config/connection_test.py
index 91c6eb6b..672efb72 100644
--- a/autotests/testNetconfig/connection_test.py
+++ b/autotests/testNetconfig/connection_test.py
@@ -17,6 +17,15 @@ import subprocess
 class Test(unittest.TestCase):
 =

     def test_connection_success(self):
+        def check_addr(device):
+            try:
+                subprocess.check_output('ip addr show ' + device.name + \
+                            ' | grep \'inet6 3ffe:501:ffff:100::\'', shell=
=3DTrue)
+            except:
+                return False
+
+            return True
+
         wd =3D IWD(True)
 =

         psk_agent =3D PSKAgent("secret123")
@@ -40,9 +49,8 @@ class Test(unittest.TestCase):
         testutil.test_iface_operstate()
         testutil.test_ifaces_connected()
 =

-        time.sleep(2)
-        subprocess.check_output('ip addr show ' + device.name + \
-                            ' | grep \'inet6 3ffe:501:ffff:100::\'', shell=
=3DTrue)
+        ctx.non_block_wait(check_addr, 10, device,
+                            exception=3DException("IPv6 address was not se=
t"))
 =

         device.disconnect()
 =

@@ -70,15 +78,15 @@ class Test(unittest.TestCase):
         # TODO: This could be moved into test-runner itself if other tests=
 ever
         #       require this functionality (p2p, FILS, etc.). Since its si=
mple
         #       enough it can stay here for now.
-        ctx.start_process(['ip', 'addr','add','dev',  hapd.ifname,
-                           '192.168.1.1/255.255.255.0']).wait()
+        ctx.start_process(['ip', 'addr','add', '192.168.1.1/255.255.255.0',
+                            'dev', hapd.ifname,]).wait()
         ctx.start_process(['touch', '/tmp/dhcpd.leases']).wait()
         cls.dhcpd_pid =3D ctx.start_process(['dhcpd', '-f', '-cf', '/tmp/d=
hcpd.conf',
                                             '-lf', '/tmp/dhcpd.leases',
                                             hapd.ifname], cleanup=3Dremove=
_lease4)
 =

-        ctx.start_process(['ip', 'addr', 'add', 'dev', hapd.ifname,
-                           '3ffe:501:ffff:100::1/64']).wait()
+        ctx.start_process(['ip', 'addr', 'add', '3ffe:501:ffff:100::1/64',
+                            'dev', hapd.ifname]).wait()
         ctx.start_process(['touch', '/tmp/dhcpd6.leases']).wait()
         cls.dhcpd6_pid =3D ctx.start_process(['dhcpd', '-6', '-f', '-cf', =
'/tmp/dhcpd-v6.conf',
                                             '-lf', '/tmp/dhcpd6.leases',
diff --git a/autotests/testNetconfig/static_test.py b/autotests/testNetconf=
ig/static_test.py
index 8e29d4eb..bba2c644 100644
--- a/autotests/testNetconfig/static_test.py
+++ b/autotests/testNetconfig/static_test.py
@@ -81,7 +81,8 @@ class Test(unittest.TestCase):
         # TODO: This could be moved into test-runner itself if other tests=
 ever
         #       require this functionality (p2p, FILS, etc.). Since its si=
mple
         #       enough it can stay here for now.
-        ctx.start_process(['ip', 'addr','add', hapd.ifname, '192.168.1.1/2=
55.255.255.0']).wait()
+        ctx.start_process(['ip', 'addr','add', '192.168.1.1/255.255.255.0',
+                            'dev', hapd.ifname]).wait()
         ctx.start_process(['touch', '/tmp/dhcpd.leases']).wait()
         cls.dhcpd_pid =3D ctx.start_process(['dhcpd', '-f', '-cf', '/tmp/d=
hcpd.conf',
                                             '-lf', '/tmp/dhcpd.leases',
-- =

2.34.1

--===============2808615580176270198==--

