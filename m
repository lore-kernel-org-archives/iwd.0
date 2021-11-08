Content-Type: multipart/mixed; boundary="===============7964891368033166610=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/2] auto-t: add OWE transition test with extra open network
Date: Mon, 08 Nov 2021 11:39:30 -0800
Message-ID: <20211108193930.1013040-2-prestwoj@gmail.com>
In-Reply-To: 20211108193930.1013040-1-prestwoj@gmail.com

--===============7964891368033166610==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A user reported a crash in situations where there was an OWE transition
pair, with an extra open network using the same SSID but not advertising
the OWE transition IE:

++++++++ backtrace ++++++++
 0x7f199cadf320 in /lib64/libc.so.6
 0x418c08 in network_has_open_pair() at /home/jprestwo/iwd/src/station.c:712
 0x4262ce in scan_finished() at /home/jprestwo/iwd/src/scan.c:1718
 0x4273cd in get_scan_done() at /home/jprestwo/iwd/src/scan.c:1733
 0x47cf7a in destroy_request() at /home/jprestwo/iwd/ell/genl.c:674
 0x479f1c in io_callback() at /home/jprestwo/iwd/ell/io.c:120
 0x47922d in l_main_iterate() at /home/jprestwo/iwd/ell/main.c:472 (discrim=
inator 2)
 0x4792dc in l_main_run() at /home/jprestwo/iwd/ell/main.c:521
 0x47950c in l_main_run_with_signal() at /home/jprestwo/iwd/ell/main.c:649
 0x403e97 in main() at /home/jprestwo/iwd/src/main.c:532
 0x7f199cac9b75 in /lib64/libc.so.6
+++++++++++++++++++++++++++
---
 .../testOWE-transition/connection_test.py     | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/autotests/testOWE-transition/connection_test.py b/autotests/te=
stOWE-transition/connection_test.py
index 9555766e..aeaea70a 100644
--- a/autotests/testOWE-transition/connection_test.py
+++ b/autotests/testOWE-transition/connection_test.py
@@ -8,6 +8,7 @@ import iwd
 from iwd import IWD
 from iwd import NetworkType
 from hostapd import HostapdCLI
+from hwsim import Hwsim
 import testutil
 =

 class Test(unittest.TestCase):
@@ -220,6 +221,38 @@ class Test(unittest.TestCase):
 =

         self.validate(self.wd, self.hapd_open)
 =

+    # OWE Transition pair + additional open network with the same SSID
+    def test_owe_transition_extra_open(self):
+        self.hapd_open.set_value('vendor_elements', 'dd15506f9a1c02000000f=
1000a6f77652d68696464656e')
+        self.hapd_open.reload()
+        self.hapd_owe.set_value('vendor_elements', 'dd15506f9a1c02000000f0=
000a7472616e736974696f6e')
+        self.hapd_owe.reload()
+
+        self.hapd_open2.set_value('ssid', 'transition')
+        self.hapd_open2.reload()
+
+        self.hapd_owe2.disable()
+
+        # Set the open network signal strength very low so it gets put las=
t on
+        # the network bss_list, forcing the additional open network to be
+        # checked first.
+        self.rule0 =3D self.hwsim.rules.create()
+        self.rule0.source =3D self.hwsim.get_radio('rad0').addresses[0]
+        self.rule0.signal =3D -4000
+        self.rule0.enabled =3D True
+
+        devices =3D self.wd.list_devices(1)
+        device =3D devices[0]
+
+        device.scan()
+        condition =3D 'obj.scanning'
+        self.wd.wait_for_object_condition(device, condition)
+        condition =3D 'not obj.scanning'
+        self.wd.wait_for_object_condition(device, condition)
+
+
+        self.validate(self.wd, self.hapd_owe)
+
     def setUp(self):
         self.wd =3D IWD(True)
         self.hapd_owe =3D HostapdCLI(config=3D'ssidOWE.conf')
@@ -227,6 +260,8 @@ class Test(unittest.TestCase):
         self.hapd_owe2 =3D HostapdCLI(config=3D'ssidOWE-2.conf')
         self.hapd_open2 =3D HostapdCLI(config=3D'ssidOpen-2.conf')
 =

+        self.hwsim =3D Hwsim()
+
     def tearDown(self):
         IWD.clear_storage()
 =

@@ -235,6 +270,7 @@ class Test(unittest.TestCase):
         self.wd =3D None
         self.hapd_open =3D None
         self.hapd_owe =3D None
+        self.hwsim =3D None
 =

     @classmethod
     def setUpClass(cls):
-- =

2.31.1

--===============7964891368033166610==--

