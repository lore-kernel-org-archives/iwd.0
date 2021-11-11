Content-Type: multipart/mixed; boundary="===============1238182370310463763=="
MIME-Version: 1.0
From: Torsten Schmitz <noreply.torsten at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2] auto-t: replace ifconfig with ip commands
Date: Thu, 11 Nov 2021 03:12:02 +0100
Message-ID: <20211111021202.26369-1-noreply.torsten@gmail.com>
In-Reply-To: 20211110125552.20102-1-noreply.torsten@gmail.com

--===============1238182370310463763==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ifconfig has long been deprecated in favor of ip from iproute2.
It is usually no longer installed by default.
---
changes from v1:
    remove ifconfig introduced in commmit d30fc978
    fix typo adrr
    changed commit message
---
 autotests/testFILS/fils_256_test.py           |  2 +-
 autotests/testFILS/fils_384_test.py           |  2 +-
 .../testFT-8021x-roam/connection_test.py      | 18 +++++++------
 autotests/testFT-FILS/connection_test.py      | 18 ++++++-------
 autotests/testNetconfig/connection_test.py    |  8 +++---
 autotests/testNetconfig/static_test.py        |  3 +--
 autotests/testP2P/connection_test.py          |  2 +-
 autotests/testPSK-roam/connection_test.py     | 16 +++++------
 autotests/testPreauth-roam/connection_test.py |  2 +-
 autotests/testSAE-roam/connection_test.py     | 27 ++++++++++---------
 doc/test-runner.txt                           |  2 +-
 tools/test-runner                             |  6 ++---
 12 files changed, 55 insertions(+), 51 deletions(-)

diff --git a/autotests/testFILS/fils_256_test.py b/autotests/testFILS/fils_=
256_test.py
index a4e58715..5fa371e1 100644
--- a/autotests/testFILS/fils_256_test.py
+++ b/autotests/testFILS/fils_256_test.py
@@ -62,7 +62,7 @@ class Test(unittest.TestCase):
     @classmethod
     def setUpClass(cls):
         IWD.copy_to_storage('ssidFILS-256.8021x')
-        os.system('ifconfig lo up')
+        os.system('ip link set lo up')
         pass
 =

     @classmethod
diff --git a/autotests/testFILS/fils_384_test.py b/autotests/testFILS/fils_=
384_test.py
index e6550a17..b7174418 100644
--- a/autotests/testFILS/fils_384_test.py
+++ b/autotests/testFILS/fils_384_test.py
@@ -62,7 +62,7 @@ class Test(unittest.TestCase):
     @classmethod
     def setUpClass(cls):
         IWD.copy_to_storage('ssidFILS-384.8021x')
-        os.system('ifconfig lo up')
+        os.system('ip link set lo up')
         pass
 =

     @classmethod
diff --git a/autotests/testFT-8021x-roam/connection_test.py b/autotests/tes=
tFT-8021x-roam/connection_test.py
index e65e4675..652677a9 100644
--- a/autotests/testFT-8021x-roam/connection_test.py
+++ b/autotests/testFT-8021x-roam/connection_test.py
@@ -54,10 +54,10 @@ class Test(unittest.TestCase):
                           (self.bss_hostapd[0].ifname, device.name, True, =
True))
 =

     def tearDown(self):
-        os.system('ifconfig "' + self.bss_hostapd[0].ifname + '" down')
-        os.system('ifconfig "' + self.bss_hostapd[1].ifname + '" down')
-        os.system('ifconfig "' + self.bss_hostapd[0].ifname + '" up')
-        os.system('ifconfig "' + self.bss_hostapd[1].ifname + '" up')
+        os.system('ip link set "' + self.bss_hostapd[0].ifname + '" down')
+        os.system('ip link set "' + self.bss_hostapd[1].ifname + '" down')
+        os.system('ip link set "' + self.bss_hostapd[0].ifname + '" up')
+        os.system('ip link set "' + self.bss_hostapd[1].ifname + '" up')
 =

     @classmethod
     def setUpClass(cls):
@@ -67,10 +67,12 @@ class Test(unittest.TestCase):
                             HostapdCLI(config=3D'ft-eap-ccmp-2.conf') ]
 =

         # Set interface addresses to those expected by hostapd config files
-        os.system('ifconfig "' + cls.bss_hostapd[0].ifname +
-                '" down hw ether 12:00:00:00:00:01 up')
-        os.system('ifconfig "' + cls.bss_hostapd[1].ifname +
-                '" down hw ether 12:00:00:00:00:02 up')
+        os.system('ip link set dev "' + cls.bss_hostapd[0].ifname + '" dow=
n')
+        os.system('ip link set dev "' + cls.bss_hostapd[0].ifname + \
+                  '" address 12:00:00:00:00:01 up')
+        os.system('ip link set dev "' + cls.bss_hostapd[1].ifname + '" dow=
n')
+        os.system('ip link set dev "' + cls.bss_hostapd[1].ifname + \
+                  '" address 12:00:00:00:00:02 up')
 =

         cls.bss_hostapd[0].reload()
         cls.bss_hostapd[0].wait_for_event("AP-ENABLED")
diff --git a/autotests/testFT-FILS/connection_test.py b/autotests/testFT-FI=
LS/connection_test.py
index 14025a3b..1fd4633b 100644
--- a/autotests/testFT-FILS/connection_test.py
+++ b/autotests/testFT-FILS/connection_test.py
@@ -124,24 +124,24 @@ class Test(unittest.TestCase):
         self.validate_connection(wd)
 =

     def tearDown(self):
-        os.system('ifconfig "' + self.bss_hostapd[0].ifname + '" down')
-        os.system('ifconfig "' + self.bss_hostapd[1].ifname + '" down')
-        os.system('ifconfig "' + self.bss_hostapd[0].ifname + '" up')
-        os.system('ifconfig "' + self.bss_hostapd[1].ifname + '" up')
+        os.system('ip link set "' + self.bss_hostapd[0].ifname + '" down')
+        os.system('ip link set "' + self.bss_hostapd[1].ifname + '" down')
+        os.system('ip link set "' + self.bss_hostapd[0].ifname + '" up')
+        os.system('ip link set "' + self.bss_hostapd[1].ifname + '" up')
 =

     @classmethod
     def setUpClass(cls):
-        os.system('ifconfig lo up')
+        os.system('ip link set lo up')
         IWD.copy_to_storage('TestFT.8021x')
 =

         cls.bss_hostapd =3D [ HostapdCLI(config=3D'ft-eap-ccmp-1.conf'),
                             HostapdCLI(config=3D'ft-eap-ccmp-2.conf') ]
 =

         # Set interface addresses to those expected by hostapd config files
-        os.system('ifconfig "' + cls.bss_hostapd[0].ifname +
-                '" down hw ether 12:00:00:00:00:01 up')
-        os.system('ifconfig "' + cls.bss_hostapd[1].ifname +
-                '" down hw ether 12:00:00:00:00:02 up')
+        os.system('ip link set dev "' + cls.bss_hostapd[0].ifname + '" dow=
n')
+        os.system('ip link set dev "' + cls.bss_hostapd[0].ifname + '" add=
r 12:00:00:00:00:01 up')
+        os.system('ip link set dev "' + cls.bss_hostapd[1].ifname + '" dow=
n')
+        os.system('ip link set dev "' + cls.bss_hostapd[1].ifname + '" add=
r 12:00:00:00:00:02 up')
 =

         cls.bss_hostapd[0].reload()
         cls.bss_hostapd[0].wait_for_event("AP-ENABLED")
diff --git a/autotests/testNetconfig/connection_test.py b/autotests/testNet=
config/connection_test.py
index 9cf1d956..8eeffbbd 100644
--- a/autotests/testNetconfig/connection_test.py
+++ b/autotests/testNetconfig/connection_test.py
@@ -69,15 +69,15 @@ class Test(unittest.TestCase):
         # TODO: This could be moved into test-runner itself if other tests=
 ever
         #       require this functionality (p2p, FILS, etc.). Since its si=
mple
         #       enough it can stay here for now.
-        ctx.start_process(['ifconfig', hapd.ifname, '192.168.1.1',
-                            'netmask', '255.255.255.0']).wait()
+        ctx.start_process(['ip', 'addr','add','dev',  hapd.ifname,
+                           '192.168.1.1/255.255.255.0']).wait()
         ctx.start_process(['touch', '/tmp/dhcpd.leases']).wait()
         cls.dhcpd_pid =3D ctx.start_process(['dhcpd', '-f', '-cf', '/tmp/d=
hcpd.conf',
                                             '-lf', '/tmp/dhcpd.leases',
                                             hapd.ifname], cleanup=3Dremove=
_lease4)
 =

-        ctx.start_process(['ifconfig', hapd.ifname, 'inet6',
-                            'add', '3ffe:501:ffff:100::1/64']).wait()
+        ctx.start_process(['ip', 'addr', 'add', 'dev', hapd.ifname,
+                           '3ffe:501:ffff:100::1/64']).wait()
         ctx.start_process(['touch', '/tmp/dhcpd6.leases']).wait()
         cls.dhcpd6_pid =3D ctx.start_process(['dhcpd', '-6', '-f', '-cf', =
'/tmp/dhcpd-v6.conf',
                                             '-lf', '/tmp/dhcpd6.leases',
diff --git a/autotests/testNetconfig/static_test.py b/autotests/testNetconf=
ig/static_test.py
index eb918e92..4aae4a20 100644
--- a/autotests/testNetconfig/static_test.py
+++ b/autotests/testNetconfig/static_test.py
@@ -86,8 +86,7 @@ class Test(unittest.TestCase):
         # TODO: This could be moved into test-runner itself if other tests=
 ever
         #       require this functionality (p2p, FILS, etc.). Since its si=
mple
         #       enough it can stay here for now.
-        ctx.start_process(['ifconfig', hapd.ifname, '192.168.1.1',
-                            'netmask', '255.255.255.0']).wait()
+        ctx.start_process(['ip', 'addr','add', hapd.ifname, '192.168.1.1/2=
55.255.255.0']).wait()
         ctx.start_process(['touch', '/tmp/dhcpd.leases']).wait()
         cls.dhcpd_pid =3D ctx.start_process(['dhcpd', '-f', '-cf', '/tmp/d=
hcpd.conf',
                                             '-lf', '/tmp/dhcpd.leases',
diff --git a/autotests/testP2P/connection_test.py b/autotests/testP2P/conne=
ction_test.py
index 04f63fdf..ddebc70a 100644
--- a/autotests/testP2P/connection_test.py
+++ b/autotests/testP2P/connection_test.py
@@ -93,7 +93,7 @@ class Test(unittest.TestCase):
         self.assertEqual(wpas.p2p_group['role'], 'GO' if not go else 'clie=
nt')
 =

         if not go:
-            ctx.start_process(['ifconfig', peer_ifname, '192.168.1.20', 'n=
etmask', '255.255.255.0']).wait()
+            ctx.start_process(['ip', 'addr', 'add','dev', peer_ifname, '19=
2.168.1.20/255.255.255.0']).wait()
             os.system('> /tmp/dhcp.leases')
             dhcp =3D ctx.start_process(['dhcpd', '-f', '-cf', '/tmp/dhcpd.=
conf', '-lf', '/tmp/dhcp.leases', peer_ifname])
             self.dhcp =3D dhcp
diff --git a/autotests/testPSK-roam/connection_test.py b/autotests/testPSK-=
roam/connection_test.py
index ee50e4a7..437e52fc 100644
--- a/autotests/testPSK-roam/connection_test.py
+++ b/autotests/testPSK-roam/connection_test.py
@@ -150,10 +150,10 @@ class Test(unittest.TestCase):
         self.validate_connection(wd)
 =

     def tearDown(self):
-        os.system('ifconfig "' + self.bss_hostapd[0].ifname + '" down')
-        os.system('ifconfig "' + self.bss_hostapd[1].ifname + '" down')
-        os.system('ifconfig "' + self.bss_hostapd[0].ifname + '" up')
-        os.system('ifconfig "' + self.bss_hostapd[1].ifname + '" up')
+        os.system('ip link set "' + self.bss_hostapd[0].ifname + '" down')
+        os.system('ip link set "' + self.bss_hostapd[1].ifname + '" down')
+        os.system('ip link set "' + self.bss_hostapd[0].ifname + '" up')
+        os.system('ip link set "' + self.bss_hostapd[1].ifname + '" up')
 =

         self.rule0.enabled =3D False
 =

@@ -175,10 +175,10 @@ class Test(unittest.TestCase):
         cls.rule0.drop =3D True
 =

         # Set interface addresses to those expected by hostapd config files
-        os.system('ifconfig "' + cls.bss_hostapd[0].ifname +
-                '" down hw ether 12:00:00:00:00:01 up')
-        os.system('ifconfig "' + cls.bss_hostapd[1].ifname +
-                '" down hw ether 12:00:00:00:00:02 up')
+        os.system('ip link set dev "' + cls.bss_hostapd[0].ifname + '" dow=
n')
+        os.system('ip link set dev "' + cls.bss_hostapd[0].ifname + '" add=
r 12:00:00:00:00:01 up')
+        os.system('ip link set dev "' + cls.bss_hostapd[1].ifname + '" dow=
n')
+        os.system('ip link set dev "' + cls.bss_hostapd[1].ifname + '" add=
r 12:00:00:00:00:02 up')
 =

         cls.bss_hostapd[0].reload()
         cls.bss_hostapd[0].wait_for_event("AP-ENABLED")
diff --git a/autotests/testPreauth-roam/connection_test.py b/autotests/test=
Preauth-roam/connection_test.py
index 63b73b54..61f095d3 100644
--- a/autotests/testPreauth-roam/connection_test.py
+++ b/autotests/testPreauth-roam/connection_test.py
@@ -86,7 +86,7 @@ class Test(unittest.TestCase):
     def setUpClass(cls):
         IWD.copy_to_storage('TestPreauth.8021x')
 =

-        os.system('ifconfig lo up')
+        os.system('ip link set lo up')
 =

     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testSAE-roam/connection_test.py b/autotests/testSAE-=
roam/connection_test.py
index 20d94c8f..2409e0d1 100644
--- a/autotests/testSAE-roam/connection_test.py
+++ b/autotests/testSAE-roam/connection_test.py
@@ -111,12 +111,12 @@ class Test(unittest.TestCase):
         self.validate_connection(wd, False)
 =

     def tearDown(self):
-        os.system('ifconfig "' + self.bss_hostapd[0].ifname + '" down')
-        os.system('ifconfig "' + self.bss_hostapd[1].ifname + '" down')
-        os.system('ifconfig "' + self.bss_hostapd[2].ifname + '" down')
-        os.system('ifconfig "' + self.bss_hostapd[0].ifname + '" up')
-        os.system('ifconfig "' + self.bss_hostapd[1].ifname + '" up')
-        os.system('ifconfig "' + self.bss_hostapd[2].ifname + '" up')
+        os.system('ip link set "' + self.bss_hostapd[0].ifname + '" down')
+        os.system('ip link set "' + self.bss_hostapd[1].ifname + '" down')
+        os.system('ip link set "' + self.bss_hostapd[2].ifname + '" down')
+        os.system('ip link set "' + self.bss_hostapd[0].ifname + '" up')
+        os.system('ip link set "' + self.bss_hostapd[1].ifname + '" up')
+        os.system('ip link set "' + self.bss_hostapd[2].ifname + '" up')
 =

     @classmethod
     def setUpClass(cls):
@@ -124,12 +124,15 @@ class Test(unittest.TestCase):
                             HostapdCLI(config=3D'ft-sae-2.conf'),
                             HostapdCLI(config=3D'ft-psk-3.conf') ]
 =

-        ctx.start_process(['ifconfig', cls.bss_hostapd[0].ifname, 'down', =
'hw', \
-                                'ether', '12:00:00:00:00:01', 'up']).wait()
-        ctx.start_process(['ifconfig', cls.bss_hostapd[1].ifname, 'down', =
'hw', \
-                                'ether', '12:00:00:00:00:02', 'up']).wait()
-        ctx.start_process(['ifconfig', cls.bss_hostapd[2].ifname, 'down', =
'hw', \
-                                'ether', '12:00:00:00:00:03', 'up']).wait()
+        ctx.start_process(['ip', 'link', 'set', 'dev', cls.bss_hostapd[0].=
ifname, 'down'])
+        ctx.start_process(['ip', 'link', 'set', 'dev', cls.bss_hostapd[0].=
ifname, \
+                           'addr', '12:00:00:00:00:01', 'up']).wait()
+        ctx.start_process(['ip', 'link', 'set', 'dev', cls.bss_hostapd[1].=
ifname, 'down'])
+        ctx.start_process(['ip', 'link', 'set', 'dev', cls.bss_hostapd[1].=
ifname, \
+                           'addr', '12:00:00:00:00:02', 'up']).wait()
+        ctx.start_process(['ip', 'link', 'set', 'dev', cls.bss_hostapd[2].=
ifname, 'down'])
+        ctx.start_process(['ip', 'link', 'set', 'dev', cls.bss_hostapd[2].=
ifname, \
+                           'addr', '12:00:00:00:00:03', 'up']).wait()
 =

         # Set interface addresses to those expected by hostapd config files
         cls.bss_hostapd[0].reload()
diff --git a/doc/test-runner.txt b/doc/test-runner.txt
index 89ba87ff..081a056f 100644
--- a/doc/test-runner.txt
+++ b/doc/test-runner.txt
@@ -19,7 +19,7 @@ OS:
 	 1. qemu		2.4.1
 	 2. Linux kernel	4.20+
 	 3. dbus-daemon		1.11.18
-	 4. ifconfig		2.10-alpha
+	 4. iproute2
 	 5. iw			3.17
 	 6. python		3.9
 	 7. haveged		no ver. avail.
diff --git a/tools/test-runner b/tools/test-runner
index 5fc4285d..7fa8b840 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -361,7 +361,7 @@ class Interface:
 		Process(['iw', 'dev', self.name, 'del']).wait()
 =

 	def set_interface_state(self, state):
-		Process(['ifconfig', self.name, state]).wait()
+		Process(['ip', 'link', 'set', self.name, state]).wait()
 =

 class Radio:
 	def __init__(self, name):
@@ -971,7 +971,7 @@ class TestContext(Namespace):
 			print("Ofono or Phonesim not found, skipping test")
 			return
 =

-		Process(['ifconfig', 'lo', 'up']).wait()
+		Process(['ip', 'link', 'set', 'lo', 'up']).wait()
 =

 		os.environ['OFONO_PHONESIM_CONFIG'] =3D '/tmp/phonesim.conf'
 =

@@ -1358,7 +1358,7 @@ def post_test(ctx, to_copy):
 			else:
 				os.remove('/tmp/' + f)
 =

-		Process(['ifconfig', 'lo', 'down']).wait()
+		Process(['ip', 'link', 'set', 'lo', 'down']).wait()
 	except Exception as e:
 		print("Exception thrown in post_test")
 	finally:
-- =

2.33.1

--===============1238182370310463763==--

