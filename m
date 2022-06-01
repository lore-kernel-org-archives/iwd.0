Content-Type: multipart/mixed; boundary="===============1487692310487138118=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] auto-t: allow skipping tests is wpa_supplicant is not found
Date: Wed, 01 Jun 2022 13:00:54 -0700
Message-ID: <20220601200054.453084-1-prestwoj@gmail.com>

--===============1487692310487138118==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Similarly to ofono/phonesim allow tests to be skipped if wpa_supplicant
is not found on the system.

This required some changes to DPP/P2P where Wpas() should be called first
since this can now throw a SkipTest exception.

The Wpas class was also made to allow __del__ to be called without
throwing additional exceptions in case wpa_supplicant was not found.
---
 autotests/testDPP/connection_test.py |  3 +--
 autotests/testP2P/connection_test.py |  2 +-
 autotests/util/wpas.py               | 13 ++++++++++---
 tools/run-tests                      |  5 ++++-
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/autotests/testDPP/connection_test.py b/autotests/testDPP/conne=
ction_test.py
index ab3cbf95..0f9b8f1c 100644
--- a/autotests/testDPP/connection_test.py
+++ b/autotests/testDPP/connection_test.py
@@ -99,9 +99,9 @@ class Test(unittest.TestCase):
         self.wpas.wait_for_event('DPP-CONF-RECEIVED', timeout=3D30)
 =

     def setUp(self):
+        self.wpas =3D Wpas('wpas.conf')
         self.wd =3D IWD(True)
         self.device =3D self.wd.list_devices(1)[0]
-        self.wpas =3D Wpas('wpas.conf')
         self.hapd =3D HostapdCLI('hostapd.conf')
         self.hapd.disable()
         self.hwsim =3D Hwsim()
@@ -114,7 +114,6 @@ class Test(unittest.TestCase):
         self.rule0.drop =3D True
 =

     def tearDown(self):
-        print("calling Disconnect()")
         self.device.disconnect()
         self.device.dpp_stop()
         self.wpas.dpp_configurator_remove()
diff --git a/autotests/testP2P/connection_test.py b/autotests/testP2P/conne=
ction_test.py
index f22f0682..383e0cef 100644
--- a/autotests/testP2P/connection_test.py
+++ b/autotests/testP2P/connection_test.py
@@ -29,8 +29,8 @@ class Test(unittest.TestCase):
         self.p2p_connect_test(preauthorize=3DTrue, go=3DTrue)
 =

     def p2p_connect_test(self, preauthorize, go):
-        wd =3D IWD()
         wpas =3D self.wpas =3D Wpas(p2p=3DTrue)
+        wd =3D IWD()
         wpas_go_intent =3D 10 if not go else 1
 =

         # Not strictly necessary but prevents the station interface from q=
ueuing its scans
diff --git a/autotests/util/wpas.py b/autotests/util/wpas.py
index 67b32d5f..4db0dc68 100644
--- a/autotests/util/wpas.py
+++ b/autotests/util/wpas.py
@@ -3,6 +3,7 @@ import os
 import socket
 from gi.repository import GLib
 from config import ctx
+from unittest import SkipTest
 =

 import binascii
 =

@@ -11,7 +12,16 @@ from utils import Process
 ctrl_count =3D 0
 =

 class Wpas:
+    io_watch =3D None
+    sockets =3D {}
+    wpa_supplicant =3D None
+    cleanup_paths =3D []
+
     def _start_wpas(self, config_name=3DNone, p2p=3DFalse):
+        if not ctx.is_process_running('wpa_supplicant'):
+            print('wpa_supplicant not running, skipping test')
+            raise SkipTest
+
         main_interface =3D None
         for interface in ctx.wpas_interfaces:
             if config_name is None or interface.config =3D=3D config_name:
@@ -31,7 +41,6 @@ class Wpas:
         self.config_path =3D '/tmp/' + self.interface.config
         self.config =3D self._get_config()
         self.socket_path =3D self.config['ctrl_interface']
-        self.io_watch =3D None
 =

         cmd =3D ['wpa_supplicant', '-i', self.interface.name, '-c', self.c=
onfig_path]
         if Process.is_verbose('wpa_supplicant-dbg'):
@@ -39,8 +48,6 @@ class Wpas:
 =

         self.wpa_supplicant =3D ctx.start_process(cmd)
 =

-        self.sockets =3D {}
-        self.cleanup_paths =3D []
         self.io_watch =3D GLib.io_add_watch(self._get_socket(), GLib.IO_IN=
, self._handle_data_in)
 =

         self.p2p_peers =3D {}
diff --git a/tools/run-tests b/tools/run-tests
index a3644ce1..f65daf67 100755
--- a/tools/run-tests
+++ b/tools/run-tests
@@ -425,10 +425,13 @@ class TestContext(Namespace):
 		return frequencies
 =

 	def start_wpas_interfaces(self):
-
 		if 'WPA_SUPPLICANT' not in self.hw_config:
 			return
 =

+		if not shutil.which('wpa_supplicant'):
+			print('wpa_supplicant not found, dependent tests will be skipped')
+			return
+
 		settings =3D self.hw_config['WPA_SUPPLICANT']
 =

 		if self.args.hw:
-- =

2.34.1

--===============1487692310487138118==--

