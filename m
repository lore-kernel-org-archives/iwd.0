Content-Type: multipart/mixed; boundary="===============0772808404834931919=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH 8/9] autotests: Test DHCPv6 client in testNetconfig
Date: Mon, 08 Nov 2021 12:28:37 +0100
Message-ID: <20211108112838.372416-8-andrew.zaborowski@intel.com>
In-Reply-To: 20211108112838.372416-1-andrew.zaborowski@intel.com

--===============0772808404834931919==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testNetconfig/connection_test.py | 34 ++++++++++++++++++++--
 autotests/testNetconfig/dhcpd-v6.conf      |  6 ++++
 autotests/testNetconfig/main.conf          |  3 ++
 3 files changed, 40 insertions(+), 3 deletions(-)
 create mode 100644 autotests/testNetconfig/dhcpd-v6.conf

diff --git a/autotests/testNetconfig/connection_test.py b/autotests/testNet=
config/connection_test.py
index b1d4afef..94aa4ee4 100644
--- a/autotests/testNetconfig/connection_test.py
+++ b/autotests/testNetconfig/connection_test.py
@@ -11,7 +11,7 @@ from iwd import NetworkType
 from hostapd import HostapdCLI
 import testutil
 from config import ctx
-import os
+import os, time
 =

 class Test(unittest.TestCase):
 =

@@ -39,6 +39,10 @@ class Test(unittest.TestCase):
         testutil.test_iface_operstate()
         testutil.test_ifaces_connected()
 =

+        time.sleep(2)
+        ret =3D os.system('ip addr show ' + device.name + ' | grep \'inet6=
 3ffe:501:ffff:100::\'')
+        self.assertEqual(os.waitstatus_to_exitcode(ret), 0)
+
         device.disconnect()
 =

         condition =3D 'not obj.connected'
@@ -48,12 +52,18 @@ class Test(unittest.TestCase):
 =

     @classmethod
     def setUpClass(cls):
-        def remove_lease():
+        def remove_lease4():
             try:
                 os.remove('/tmp/dhcpd.leases')
                 os.remove('/tmp/dhcpd.leases~')
             except:
                 pass
+        def remove_lease6():
+            try:
+                os.remove('/tmp/dhcpd6.leases')
+                os.remove('/tmp/dhcpd6.leases~')
+            except:
+                pass
 =

         hapd =3D HostapdCLI()
         # TODO: This could be moved into test-runner itself if other tests=
 ever
@@ -64,13 +74,31 @@ class Test(unittest.TestCase):
         ctx.start_process(['touch', '/tmp/dhcpd.leases']).wait()
         cls.dhcpd_pid =3D ctx.start_process(['dhcpd', '-f', '-cf', '/tmp/d=
hcpd.conf',
                                             '-lf', '/tmp/dhcpd.leases',
-                                            hapd.ifname], cleanup=3Dremove=
_lease)
+                                            hapd.ifname], cleanup=3Dremove=
_lease4)
+
+        ctx.start_process(['ifconfig', hapd.ifname, 'inet6',
+                            'add', '3ffe:501:ffff:100::1/64']).wait()
+        ctx.start_process(['touch', '/tmp/dhcpd6.leases']).wait()
+        cls.dhcpd6_pid =3D ctx.start_process(['dhcpd', '-6', '-f', '-cf', =
'/tmp/dhcpd-v6.conf',
+                                            '-lf', '/tmp/dhcpd6.leases',
+                                            hapd.ifname], cleanup=3Dremove=
_lease6)
+        ctx.start_process(['sysctl', 'net.ipv6.conf.' + hapd.ifname + '.fo=
rwarding=3D1']).wait()
+        # Tell clients to use DHCPv6
+        config =3D open('/tmp/radvd.conf', 'w')
+        config.write('interface ' + hapd.ifname + ' { AdvSendAdvert on; Ad=
vManagedFlag on; };')
+        config.close()
+        cls.radvd_pid =3D ctx.start_process(['radvd', '-n', '-C', '/tmp/ra=
dvd.conf'])
 =

     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
         ctx.stop_process(cls.dhcpd_pid)
         cls.dhcpd_pid =3D None
+        ctx.stop_process(cls.dhcpd6_pid)
+        cls.dhcpd6_pid =3D None
+        ctx.stop_process(cls.radvd_pid)
+        cls.radvd_pid =3D None
+        os.remove('/tmp/radvd.conf')
 =

 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
diff --git a/autotests/testNetconfig/dhcpd-v6.conf b/autotests/testNetconfi=
g/dhcpd-v6.conf
new file mode 100644
index 00000000..7a22cc65
--- /dev/null
+++ b/autotests/testNetconfig/dhcpd-v6.conf
@@ -0,0 +1,6 @@
+subnet6 3ffe:501:ffff:100::/64
+ {
+  option dhcp6.name-servers 3ffe:501:ffff:100::1;
+  range6 3ffe:501:ffff:100::10 3ffe:501:ffff:100::20;
+  range6 3ffe:501:ffff:100::100 3ffe:501:ffff:100::200;
+ }
diff --git a/autotests/testNetconfig/main.conf b/autotests/testNetconfig/ma=
in.conf
index 982e5445..b05962e6 100644
--- a/autotests/testNetconfig/main.conf
+++ b/autotests/testNetconfig/main.conf
@@ -1,2 +1,5 @@
 [General]
 EnableNetworkConfiguration=3Dtrue
+
+[Network]
+EnableIPv6=3Dtrue
-- =

2.32.0

--===============0772808404834931919==--

