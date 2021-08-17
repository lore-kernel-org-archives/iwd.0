Content-Type: multipart/mixed; boundary="===============4977622136335951669=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] auto-t: separate PEAP + SIM test
Date: Tue, 17 Aug 2021 14:50:02 -0700
Message-ID: <20210817215002.212694-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4977622136335951669==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Remove EAP-SIM from the generic PEAP test case since skipping
(if ofono is not on system) would skip the entire test rather
than just the EAP-SIM portion.
---
 autotests/testEAP/connection_test.py | 29 ++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/autotests/testEAP/connection_test.py b/autotests/testEAP/conne=
ction_test.py
index 9a51bb8a..f072845b 100644
--- a/autotests/testEAP/connection_test.py
+++ b/autotests/testEAP/connection_test.py
@@ -142,9 +142,31 @@ class Test(unittest.TestCase):
     #
     # EAP-PEAP
     #
-    # * Test all combinations of PEAP, PEAPv0, PEAPv1 with MD5, GTC, SIM, =
MSCHAPv2
+    # * Test all combinations of PEAP, PEAPv0, PEAPv1 with MD5, GTC, MSCHA=
Pv2
     #
     def test_eap_peap(self):
+        for ver in ['PEAP', 'PEAPv0', 'PEAPv1']:
+            for inner in ['MD5', 'GTC', 'MSCHAPv2']:
+                self.copy_network('peap/ssidEAP-%s-%s.8021x' % (ver, inner=
))
+
+                try:
+                    self.validate_connection(self.wd)
+                except Exception as e:
+                    # Catch an error here and print the actual PEAP combo =
that failed
+                    traceback.print_exc()
+                    raise Exception("%s-%s test failed" % (ver, inner))
+
+                self.remove_network()
+
+    #
+    # EAP-PEAP + SIM
+    #
+    # * Tests EAP-PEAP + SIM separately to allow skipping if ofono is not =
found
+    #
+    def test_eap_peap_sim(self):
+        if not ctx.is_process_running('ofonod'):
+            self.skipTest("ofono not running")
+
         ofono =3D Ofono()
         ofono.enable_modem('/phonesim')
         ofono.wait_for_sim_auth()
@@ -152,8 +174,7 @@ class Test(unittest.TestCase):
         auth =3D AuthCenter('/tmp/hlrauc.sock', '/tmp/sim/sim.db')
 =

         for ver in ['PEAP', 'PEAPv0', 'PEAPv1']:
-            for inner in ['MD5', 'GTC', 'SIM', 'MSCHAPv2']:
-                self.copy_network('peap/ssidEAP-%s-%s.8021x' % (ver, inner=
))
+                self.copy_network('peap/ssidEAP-%s-SIM.8021x' % ver)
 =

                 try:
                     self.validate_connection(self.wd)
@@ -161,7 +182,7 @@ class Test(unittest.TestCase):
                     # Catch an error here and print the actual PEAP combo =
that failed
                     traceback.print_exc()
                     auth.stop()
-                    raise Exception("%s-%s test failed" % (ver, inner))
+                    raise Exception("%s-SIM test failed" % ver)
 =

                 self.remove_network()
 =

-- =

2.31.1

--===============4977622136335951669==--

