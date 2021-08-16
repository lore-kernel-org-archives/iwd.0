Content-Type: multipart/mixed; boundary="===============2998029829581243330=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/5] auto-t: Add universal testEAP test
Date: Mon, 16 Aug 2021 16:58:21 -0700
Message-ID: <20210816235823.146856-3-prestwoj@gmail.com>
In-Reply-To: <20210816235823.146856-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2998029829581243330==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This tests all EAP methods in their standard configuration. Any
corner cases requiring changes to main.conf or other hostapd
options are not included and will be left as stand alone tests.

This was done because nearly all EAP tests are identical except
the IWD provisioning file and hostapd EAP users fine. The IWD
provisioning file can be swapped out as needed for each individual
test without actually restarting IWD. And the EAP users file can
simply be written to include every possible EAP method that
is supported.
---
 autotests/misc/secrets/eap-user.text          |  22 ++
 autotests/testEAP/connection_test.py          | 226 ++++++++++++++++++
 autotests/testEAP/hw.conf                     |   6 +
 .../mschapv2/ssidEAP-MSCHAPV2-hash.8021x      |   7 +
 .../mschapv2/ssidEAP-MSCHAPV2-nopass.8021x    |   6 +
 .../ssidEAP-MSCHAPV2-nouserpass.8021x         |   5 +
 .../testEAP/mschapv2/ssidEAP-MSCHAPV2.8021x   |   7 +
 autotests/testEAP/peap/ssidEAP-PEAP-GTC.8021x |  12 +
 autotests/testEAP/peap/ssidEAP-PEAP-MD5.8021x |  14 ++
 .../testEAP/peap/ssidEAP-PEAP-MSCHAPv2.8021x  |  12 +
 autotests/testEAP/peap/ssidEAP-PEAP-SIM.8021x |  10 +
 .../testEAP/peap/ssidEAP-PEAPv0-GTC.8021x     |  12 +
 .../testEAP/peap/ssidEAP-PEAPv0-MD5.8021x     |  12 +
 .../peap/ssidEAP-PEAPv0-MSCHAPv2.8021x        |  12 +
 .../testEAP/peap/ssidEAP-PEAPv0-SIM.8021x     |  10 +
 .../testEAP/peap/ssidEAP-PEAPv1-GTC.8021x     |  12 +
 .../testEAP/peap/ssidEAP-PEAPv1-MD5.8021x     |  12 +
 .../peap/ssidEAP-PEAPv1-MSCHAPv2.8021x        |  12 +
 .../testEAP/peap/ssidEAP-PEAPv1-SIM.8021x     |  10 +
 autotests/testEAP/sim/aka.db                  |   3 +
 autotests/testEAP/sim/sim.db                  |   1 +
 autotests/testEAP/sim/ssidEAP-AKA-prime.8021x |   5 +
 autotests/testEAP/sim/ssidEAP-AKA.8021x       |   2 +
 autotests/testEAP/sim/ssidEAP-SIM.8021x       |   5 +
 autotests/testEAP/ssidEAP-PWD.8021x           |   7 +
 autotests/testEAP/ssidEAP.conf                |  14 ++
 .../testEAP/tls/ssidEAP-TLS-des-ede3.8021x    |   9 +
 .../testEAP/tls/ssidEAP-TLS-embedded.8021x    |  94 ++++++++
 .../testEAP/tls/ssidEAP-TLS-keybundle.8021x   |   9 +
 .../testEAP/tls/ssidEAP-TLS-keypass.8021x     |  10 +
 .../testEAP/tls/ssidEAP-TLS-nokeypass.8021x   |   9 +
 .../testEAP/ttls/ssidEAP-TTLS-CHAP.8021x      |  12 +
 autotests/testEAP/ttls/ssidEAP-TTLS-MD5.8021x |  12 +
 .../testEAP/ttls/ssidEAP-TTLS-MSCHAPV2.8021x  |   8 +
 .../ttls/ssidEAP-TTLS-Tunneled-MSCHAP.8021x   |  12 +
 .../ttls/ssidEAP-TTLS-Tunneled-MSCHAPV2.8021x |  12 +
 .../ttls/ssidEAP-TTLS-Tunneled-PAP.8021x      |  12 +
 37 files changed, 655 insertions(+)
 create mode 100644 autotests/misc/secrets/eap-user.text
 create mode 100644 autotests/testEAP/connection_test.py
 create mode 100644 autotests/testEAP/hw.conf
 create mode 100644 autotests/testEAP/mschapv2/ssidEAP-MSCHAPV2-hash.8021x
 create mode 100644 autotests/testEAP/mschapv2/ssidEAP-MSCHAPV2-nopass.8021x
 create mode 100644 autotests/testEAP/mschapv2/ssidEAP-MSCHAPV2-nouserpass.=
8021x
 create mode 100644 autotests/testEAP/mschapv2/ssidEAP-MSCHAPV2.8021x
 create mode 100644 autotests/testEAP/peap/ssidEAP-PEAP-GTC.8021x
 create mode 100644 autotests/testEAP/peap/ssidEAP-PEAP-MD5.8021x
 create mode 100644 autotests/testEAP/peap/ssidEAP-PEAP-MSCHAPv2.8021x
 create mode 100644 autotests/testEAP/peap/ssidEAP-PEAP-SIM.8021x
 create mode 100644 autotests/testEAP/peap/ssidEAP-PEAPv0-GTC.8021x
 create mode 100644 autotests/testEAP/peap/ssidEAP-PEAPv0-MD5.8021x
 create mode 100644 autotests/testEAP/peap/ssidEAP-PEAPv0-MSCHAPv2.8021x
 create mode 100644 autotests/testEAP/peap/ssidEAP-PEAPv0-SIM.8021x
 create mode 100644 autotests/testEAP/peap/ssidEAP-PEAPv1-GTC.8021x
 create mode 100644 autotests/testEAP/peap/ssidEAP-PEAPv1-MD5.8021x
 create mode 100644 autotests/testEAP/peap/ssidEAP-PEAPv1-MSCHAPv2.8021x
 create mode 100644 autotests/testEAP/peap/ssidEAP-PEAPv1-SIM.8021x
 create mode 100644 autotests/testEAP/sim/aka.db
 create mode 100644 autotests/testEAP/sim/sim.db
 create mode 100644 autotests/testEAP/sim/ssidEAP-AKA-prime.8021x
 create mode 100644 autotests/testEAP/sim/ssidEAP-AKA.8021x
 create mode 100644 autotests/testEAP/sim/ssidEAP-SIM.8021x
 create mode 100644 autotests/testEAP/ssidEAP-PWD.8021x
 create mode 100644 autotests/testEAP/ssidEAP.conf
 create mode 100644 autotests/testEAP/tls/ssidEAP-TLS-des-ede3.8021x
 create mode 100644 autotests/testEAP/tls/ssidEAP-TLS-embedded.8021x
 create mode 100644 autotests/testEAP/tls/ssidEAP-TLS-keybundle.8021x
 create mode 100644 autotests/testEAP/tls/ssidEAP-TLS-keypass.8021x
 create mode 100644 autotests/testEAP/tls/ssidEAP-TLS-nokeypass.8021x
 create mode 100644 autotests/testEAP/ttls/ssidEAP-TTLS-CHAP.8021x
 create mode 100644 autotests/testEAP/ttls/ssidEAP-TTLS-MD5.8021x
 create mode 100644 autotests/testEAP/ttls/ssidEAP-TTLS-MSCHAPV2.8021x
 create mode 100644 autotests/testEAP/ttls/ssidEAP-TTLS-Tunneled-MSCHAP.802=
1x
 create mode 100644 autotests/testEAP/ttls/ssidEAP-TTLS-Tunneled-MSCHAPV2.8=
021x
 create mode 100644 autotests/testEAP/ttls/ssidEAP-TTLS-Tunneled-PAP.8021x

diff --git a/autotests/misc/secrets/eap-user.text b/autotests/misc/secrets/=
eap-user.text
new file mode 100644
index 00000000..6f64b2f8
--- /dev/null
+++ b/autotests/misc/secrets/eap-user.text
@@ -0,0 +1,22 @@
+"112345678(a)phonesim.org"		SIM
+"012345678(a)phonesim.org"		AKA
+"612345678(a)phonesim.org"		AKA'
+"mschapv2(a)example.com"			MSCHAPV2	"Password"
+"pwd(a)example.com"			PWD		"Password"
+
+# Phase 1 users
+"tls(a)example.com"			TLS
+"ttls(a)example.com"			TTLS
+"peap(a)example.com"			PEAP
+"peapv0(a)example.com"			PEAP [ver=3D0]
+"peapv1(a)example.com"			PEAP [ver=3D1]
+
+# Phase 2
+"md5-phase2(a)example.com"		MD5		"Password" [2]
+"gtc-phase2(a)example.com"		GTC		"Password" [2]
+"mschapv2-phase2(a)example.com"		MSCHAPV2	"Password" [2]
+"ttls-chap-phase2(a)example.com"		TTLS-CHAP	"Password" [2]
+"ttls-mschap-phase2(a)example.com"	TTLS-MSCHAP	"Password" [2]
+"ttls-mschapv2-phase2(a)example.com"	TTLS-MSCHAPV2	"Password" [2]
+"ttls-pap-phase2(a)example.com"		TTLS-PAP	"Password" [2]
+"112345678(a)phonesim.org"		SIM [2]
diff --git a/autotests/testEAP/connection_test.py b/autotests/testEAP/conne=
ction_test.py
new file mode 100644
index 00000000..db50274d
--- /dev/null
+++ b/autotests/testEAP/connection_test.py
@@ -0,0 +1,226 @@
+#!/usr/bin/python3
+
+from typing import Iterable
+import unittest
+import sys
+
+sys.path.append('../util')
+from iwd import IWD
+from iwd import NetworkType
+from iwd import PSKAgent
+from hlrauc import AuthCenter
+from ofono import Ofono
+from config import ctx
+import testutil
+import traceback
+
+class Test(unittest.TestCase):
+
+    def validate_connection(self, wd, *secrets):
+        if secrets:
+            psk_agent =3D PSKAgent(*secrets)
+            wd.register_psk_agent(psk_agent)
+
+        devices =3D wd.list_devices(1)
+        self.assertIsNotNone(devices)
+        device =3D devices[0]
+
+        ordered_network =3D device.get_ordered_network('ssidEAP')
+
+        self.assertEqual(ordered_network.type, NetworkType.eap)
+
+        condition =3D 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+
+        ordered_network.network_object.connect()
+
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
+        testutil.test_iface_operstate()
+        testutil.test_ifaces_connected()
+
+        if secrets:
+            wd.unregister_psk_agent(psk_agent)
+
+        device.disconnect()
+
+        condition =3D 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+
+    #
+    # EAP-AKA
+    #
+    def test_eap_aka(self):
+        if not ctx.is_process_running('ofonod'):
+            self.skipTest("ofono not running")
+
+        ofono =3D Ofono()
+        ofono.enable_modem('/phonesim')
+        ofono.wait_for_sim_auth()
+
+        auth =3D AuthCenter('/tmp/hlrauc.sock', '/tmp/sim/aka.db')
+
+        IWD.copy_to_storage('sim/ssidEAP-AKA.8021x', name=3D'ssidEAP.8021x=
')
+
+        try:
+            self.validate_connection(self.wd)
+        finally:
+            auth.stop()
+
+    #
+    # EAP-AKA'
+    #
+    def test_eap_aka_prime(self):
+        if not ctx.is_process_running('ofonod'):
+            self.skipTest("ofono not running")
+
+        ofono =3D Ofono()
+        ofono.enable_modem('/phonesim')
+        ofono.wait_for_sim_auth()
+
+        auth =3D AuthCenter('/tmp/hlrauc.sock', '/tmp/sim/aka.db')
+
+        IWD.copy_to_storage('sim/ssidEAP-AKA-prime.8021x', name=3D'ssidEAP=
.8021x')
+
+        try:
+            self.validate_connection(self.wd)
+        finally:
+            auth.stop()
+
+    #
+    # EAP-SIM
+    #
+    def test_eap_sim(self):
+        if not ctx.is_process_running('ofonod'):
+            self.skipTest("ofono not running")
+
+        ofono =3D Ofono()
+        ofono.enable_modem('/phonesim')
+        ofono.wait_for_sim_auth()
+
+        auth =3D AuthCenter('/tmp/hlrauc.sock', '/tmp/sim/sim.db')
+
+        IWD.copy_to_storage('sim/ssidEAP-SIM.8021x', name=3D'ssidEAP.8021x=
')
+
+        try:
+            self.validate_connection(self.wd)
+        finally:
+            auth.stop()
+
+    #
+    # EAP-MSCHAPv2
+    #
+    # * Credentials in 8021x file
+    # * Password-Hash in 8021x file
+    # * Agent request for password
+    # * Agent request for user + password
+    #
+    def test_eap_mschapv2(self):
+        IWD.copy_to_storage('mschapv2/ssidEAP-MSCHAPV2.8021x', name=3D'ssi=
dEAP.8021x')
+        self.validate_connection(self.wd)
+
+        IWD.copy_to_storage('mschapv2/ssidEAP-MSCHAPV2-hash.8021x', name=
=3D'ssidEAP.8021x')
+        self.validate_connection(self.wd)
+
+        IWD.copy_to_storage('mschapv2/ssidEAP-MSCHAPV2-nopass.8021x', name=
=3D'ssidEAP.8021x')
+        self.validate_connection(self.wd, [], ('mschapv2(a)example.com', '=
Password'))
+
+        IWD.copy_to_storage('mschapv2/ssidEAP-MSCHAPV2-nouserpass.8021x', =
name=3D'ssidEAP.8021x')
+        self.validate_connection(self.wd, [], ('mschapv2(a)example.com', '=
Password'))
+
+    #
+    # EAP-PEAP
+    #
+    # * Test all combinations of PEAP, PEAPv0, PEAPv1 with MD5, GTC, SIM, =
MSCHAPv2
+    #
+    def test_eap_peap(self):
+        ofono =3D Ofono()
+        ofono.enable_modem('/phonesim')
+        ofono.wait_for_sim_auth()
+
+        auth =3D AuthCenter('/tmp/hlrauc.sock', '/tmp/sim/sim.db')
+
+        for ver in ['PEAP', 'PEAPv0', 'PEAPv1']:
+            for inner in ['MD5', 'GTC', 'SIM', 'MSCHAPv2']:
+                IWD.copy_to_storage('peap/ssidEAP-%s-%s.8021x' % (ver, inn=
er), name=3D'ssidEAP.8021x')
+
+                try:
+                    self.validate_connection(self.wd)
+                except Exception as e:
+                    # Catch an error here and print the actual PEAP combo =
that failed
+                    traceback.print_exc()
+                    auth.stop()
+                    raise Exception("%s-%s test failed" % (ver, inner))
+
+        auth.stop()
+
+    #
+    # EAP-PWD
+    #
+    def test_eap_pwd(self):
+        IWD.copy_to_storage('ssidEAP-PWD.8021x', name=3D'ssidEAP.8021x')
+
+        self.validate_connection(self.wd)
+
+    #
+    # EAP-TLS
+    #
+    # * Encrypted private key, passphrase in 8021x file
+    # * Unencrypted private key
+    # * Encrypted private key, passphrase provided by agent
+    # * Embedded PEM inside 8021x file
+    # * KeyBundle
+    #
+    def test_eap_tls(self):
+        for name, secrets in [('keypass', None), ('nokeypass', None),
+                        ('des-ede3', 'abc'), ('embedded', None), ('keybund=
le', None)]:
+            IWD.copy_to_storage('tls/ssidEAP-TLS-%s.8021x' % name, name=3D=
'ssidEAP.8021x')
+            try:
+                self.validate_connection(self.wd, secrets)
+            except Exception as e:
+                traceback.print_exc()
+                raise Exception('EAP-TLS (%s) failed' % name)
+
+    #
+    # EAP-TTLS
+    #
+    # * CHAP, MD5, MSCHAPV2 as phase 2
+    # * Tunneled-MSCHAP, Tunneled-MSCHAPV2, Tunneled-PAP as phase 2
+    #
+    def test_eap_ttls(self):
+        for name, secrets in [('CHAP', ('ttls(a)example.com', ('ttls-chap-=
phase2(a)example.com', 'Password'))),
+                              ('MD5', None),
+                              ('MSCHAPV2', ('ttls(a)example.com', ('mschap=
v2-phase2(a)example.com', 'Password'))),
+                              ('Tunneled-MSCHAP', ('ttls(a)example.com', (=
'ttls-mschap-phase2(a)example.com', 'Password'))),
+                              ('Tunneled-MSCHAPV2', ('ttls(a)example.com',=
 ('ttls-mschapv2-phase2(a)example.com', 'Password'))),
+                              ('Tunneled-PAP', ('ttls(a)example.com', ('tt=
ls-pap-phase2(a)example.com', 'Password')))]:
+            IWD.copy_to_storage('ttls/ssidEAP-TTLS-%s.8021x' % name, name=
=3D'ssidEAP.8021x')
+            try:
+                if isinstance(secrets, Iterable):
+                    self.validate_connection(self.wd, *secrets)
+                else:
+                    self.validate_connection(self.wd, None)
+            except Exception as e:
+                    traceback.print_exc()
+                    raise Exception('EAP-TTLS (%s) failed' % name)
+
+    def setUp(self):
+        IWD.clear_storage()
+
+    def tearDown(self):
+        networks =3D self.wd.list_known_networks()
+        for n in networks:
+            n.forget()
+
+    @classmethod
+    def setUpClass(cls):
+        cls.wd =3D IWD()
+
+    @classmethod
+    def tearDownClass(cls):
+        cls.wd =3D None
+        IWD.clear_storage()
+
+if __name__ =3D=3D '__main__':
+    unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP/hw.conf b/autotests/testEAP/hw.conf
new file mode 100644
index 00000000..8a84c611
--- /dev/null
+++ b/autotests/testEAP/hw.conf
@@ -0,0 +1,6 @@
+[SETUP]
+num_radios=3D2
+sim_keys=3Dofono
+
+[HOSTAPD]
+rad0=3DssidEAP.conf
diff --git a/autotests/testEAP/mschapv2/ssidEAP-MSCHAPV2-hash.8021x b/autot=
ests/testEAP/mschapv2/ssidEAP-MSCHAPV2-hash.8021x
new file mode 100644
index 00000000..2bb134d1
--- /dev/null
+++ b/autotests/testEAP/mschapv2/ssidEAP-MSCHAPV2-hash.8021x
@@ -0,0 +1,7 @@
+[Security]
+EAP-Method=3DMSCHAPV2
+EAP-Identity=3Dmschapv2(a)example.com
+EAP-Password-Hash=3Da4f49c406510bdcab6824ee7c30fd852
+
+[Settings]
+AutoConnect=3Dfalse
diff --git a/autotests/testEAP/mschapv2/ssidEAP-MSCHAPV2-nopass.8021x b/aut=
otests/testEAP/mschapv2/ssidEAP-MSCHAPV2-nopass.8021x
new file mode 100644
index 00000000..e682cf5b
--- /dev/null
+++ b/autotests/testEAP/mschapv2/ssidEAP-MSCHAPV2-nopass.8021x
@@ -0,0 +1,6 @@
+[Security]
+EAP-Method=3DMSCHAPV2
+EAP-Identity=3Dmschapv2(a)example.com
+
+[Settings]
+AutoConnect=3Dfalse
diff --git a/autotests/testEAP/mschapv2/ssidEAP-MSCHAPV2-nouserpass.8021x b=
/autotests/testEAP/mschapv2/ssidEAP-MSCHAPV2-nouserpass.8021x
new file mode 100644
index 00000000..d7528b38
--- /dev/null
+++ b/autotests/testEAP/mschapv2/ssidEAP-MSCHAPV2-nouserpass.8021x
@@ -0,0 +1,5 @@
+[Security]
+EAP-Method=3DMSCHAPV2
+
+[Settings]
+AutoConnect=3Dfalse
diff --git a/autotests/testEAP/mschapv2/ssidEAP-MSCHAPV2.8021x b/autotests/=
testEAP/mschapv2/ssidEAP-MSCHAPV2.8021x
new file mode 100644
index 00000000..3aba560c
--- /dev/null
+++ b/autotests/testEAP/mschapv2/ssidEAP-MSCHAPV2.8021x
@@ -0,0 +1,7 @@
+[Security]
+EAP-Method=3DMSCHAPV2
+EAP-Identity=3Dmschapv2(a)example.com
+EAP-Password=3DPassword
+
+[Settings]
+AutoConnect=3Dfalse
diff --git a/autotests/testEAP/peap/ssidEAP-PEAP-GTC.8021x b/autotests/test=
EAP/peap/ssidEAP-PEAP-GTC.8021x
new file mode 100644
index 00000000..2a1ad713
--- /dev/null
+++ b/autotests/testEAP/peap/ssidEAP-PEAP-GTC.8021x
@@ -0,0 +1,12 @@
+[Security]
+EAP-Method=3DPEAP
+EAP-Identity=3Dpeap(a)example.com
+EAP-PEAP-CACert=3D/tmp/certs/cert-ca.pem
+EAP-PEAP-ClientCert=3D/tmp/certs/cert-client.pem
+EAP-PEAP-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
+EAP-PEAP-Phase2-Method=3DGTC
+EAP-PEAP-Phase2-Identity=3Dgtc-phase2(a)example.com
+EAP-PEAP-Phase2-Password=3DPassword
+
+[Settings]
+AutoConnect=3Dfalse
diff --git a/autotests/testEAP/peap/ssidEAP-PEAP-MD5.8021x b/autotests/test=
EAP/peap/ssidEAP-PEAP-MD5.8021x
new file mode 100644
index 00000000..a13bbaaa
--- /dev/null
+++ b/autotests/testEAP/peap/ssidEAP-PEAP-MD5.8021x
@@ -0,0 +1,14 @@
+[Security]
+EAP-Method=3DPEAP
+
+EAP-Identity=3Dpeap(a)example.com
+
+EAP-PEAP-CACert=3D/tmp/certs/cert-ca.pem
+EAP-PEAP-ClientCert=3D/tmp/certs/cert-client.pem
+EAP-PEAP-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
+EAP-PEAP-Phase2-Method=3DMD5
+EAP-PEAP-Phase2-Identity=3Dmd5-phase2(a)example.com
+EAP-PEAP-Phase2-Password=3DPassword
+
+[Settings]
+AutoConnect=3Dfalse
diff --git a/autotests/testEAP/peap/ssidEAP-PEAP-MSCHAPv2.8021x b/autotests=
/testEAP/peap/ssidEAP-PEAP-MSCHAPv2.8021x
new file mode 100644
index 00000000..3cacdfbe
--- /dev/null
+++ b/autotests/testEAP/peap/ssidEAP-PEAP-MSCHAPv2.8021x
@@ -0,0 +1,12 @@
+[Security]
+EAP-Method=3DPEAP
+EAP-Identity=3Dpeap(a)example.com
+EAP-PEAP-CACert=3D/tmp/certs/cert-ca.pem
+EAP-PEAP-ClientCert=3D/tmp/certs/cert-client.pem
+EAP-PEAP-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
+EAP-PEAP-Phase2-Method=3DMSCHAPV2
+EAP-PEAP-Phase2-Identity=3Dmschapv2-phase2(a)example.com
+EAP-PEAP-Phase2-Password=3DPassword
+
+[Settings]
+AutoConnect=3Dfalse
diff --git a/autotests/testEAP/peap/ssidEAP-PEAP-SIM.8021x b/autotests/test=
EAP/peap/ssidEAP-PEAP-SIM.8021x
new file mode 100644
index 00000000..54311990
--- /dev/null
+++ b/autotests/testEAP/peap/ssidEAP-PEAP-SIM.8021x
@@ -0,0 +1,10 @@
+[Security]
+EAP-Method=3DPEAP
+EAP-Identity=3Dpeap(a)example.com
+EAP-PEAP-CACert=3D/tmp/certs/cert-ca.pem
+EAP-PEAP-ClientCert=3D/tmp/certs/cert-client.pem
+EAP-PEAP-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
+EAP-PEAP-Phase2-Method=3DSIM
+
+[Settings]
+AutoConnect=3Dfalse
diff --git a/autotests/testEAP/peap/ssidEAP-PEAPv0-GTC.8021x b/autotests/te=
stEAP/peap/ssidEAP-PEAPv0-GTC.8021x
new file mode 100644
index 00000000..b0c02d6b
--- /dev/null
+++ b/autotests/testEAP/peap/ssidEAP-PEAPv0-GTC.8021x
@@ -0,0 +1,12 @@
+[Security]
+EAP-Method=3DPEAP
+EAP-Identity=3Dpeapv0(a)example.com
+EAP-PEAP-CACert=3D/tmp/certs/cert-ca.pem
+EAP-PEAP-ClientCert=3D/tmp/certs/cert-client.pem
+EAP-PEAP-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
+EAP-PEAP-Phase2-Method=3DGTC
+EAP-PEAP-Phase2-Identity=3Dgtc-phase2(a)example.com
+EAP-PEAP-Phase2-Password=3DPassword
+
+[Settings]
+AutoConnect=3Dfalse
diff --git a/autotests/testEAP/peap/ssidEAP-PEAPv0-MD5.8021x b/autotests/te=
stEAP/peap/ssidEAP-PEAPv0-MD5.8021x
new file mode 100644
index 00000000..a34faca6
--- /dev/null
+++ b/autotests/testEAP/peap/ssidEAP-PEAPv0-MD5.8021x
@@ -0,0 +1,12 @@
+[Security]
+EAP-Method=3DPEAP
+EAP-Identity=3Dpeapv0(a)example.com
+EAP-PEAP-CACert=3D/tmp/certs/cert-ca.pem
+EAP-PEAP-ClientCert=3D/tmp/certs/cert-client.pem
+EAP-PEAP-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
+EAP-PEAP-Phase2-Method=3DMD5
+EAP-PEAP-Phase2-Identity=3Dmd5-phase2(a)example.com
+EAP-PEAP-Phase2-Password=3DPassword
+
+[Settings]
+AutoConnect=3Dfalse
diff --git a/autotests/testEAP/peap/ssidEAP-PEAPv0-MSCHAPv2.8021x b/autotes=
ts/testEAP/peap/ssidEAP-PEAPv0-MSCHAPv2.8021x
new file mode 100644
index 00000000..988661c7
--- /dev/null
+++ b/autotests/testEAP/peap/ssidEAP-PEAPv0-MSCHAPv2.8021x
@@ -0,0 +1,12 @@
+[Security]
+EAP-Method=3DPEAP
+EAP-Identity=3Dpeapv0(a)example.com
+EAP-PEAP-CACert=3D/tmp/certs/cert-ca.pem
+EAP-PEAP-ClientCert=3D/tmp/certs/cert-client.pem
+EAP-PEAP-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
+EAP-PEAP-Phase2-Method=3DMSCHAPV2
+EAP-PEAP-Phase2-Identity=3Dmschapv2-phase2(a)example.com
+EAP-PEAP-Phase2-Password=3DPassword
+
+[Settings]
+AutoConnect=3Dfalse
diff --git a/autotests/testEAP/peap/ssidEAP-PEAPv0-SIM.8021x b/autotests/te=
stEAP/peap/ssidEAP-PEAPv0-SIM.8021x
new file mode 100644
index 00000000..612bc9e9
--- /dev/null
+++ b/autotests/testEAP/peap/ssidEAP-PEAPv0-SIM.8021x
@@ -0,0 +1,10 @@
+[Security]
+EAP-Method=3DPEAP
+EAP-Identity=3Dpeapv0(a)example.com
+EAP-PEAP-CACert=3D/tmp/certs/cert-ca.pem
+EAP-PEAP-ClientCert=3D/tmp/certs/cert-client.pem
+EAP-PEAP-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
+EAP-PEAP-Phase2-Method=3DSIM
+
+[Settings]
+AutoConnect=3Dfalse
diff --git a/autotests/testEAP/peap/ssidEAP-PEAPv1-GTC.8021x b/autotests/te=
stEAP/peap/ssidEAP-PEAPv1-GTC.8021x
new file mode 100644
index 00000000..775f547c
--- /dev/null
+++ b/autotests/testEAP/peap/ssidEAP-PEAPv1-GTC.8021x
@@ -0,0 +1,12 @@
+[Security]
+EAP-Method=3DPEAP
+EAP-Identity=3Dpeapv1(a)example.com
+EAP-PEAP-CACert=3D/tmp/certs/cert-ca.pem
+EAP-PEAP-ClientCert=3D/tmp/certs/cert-client.pem
+EAP-PEAP-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
+EAP-PEAP-Phase2-Method=3DGTC
+EAP-PEAP-Phase2-Identity=3Dgtc-phase2(a)example.com
+EAP-PEAP-Phase2-Password=3DPassword
+
+[Settings]
+AutoConnect=3Dfalse
diff --git a/autotests/testEAP/peap/ssidEAP-PEAPv1-MD5.8021x b/autotests/te=
stEAP/peap/ssidEAP-PEAPv1-MD5.8021x
new file mode 100644
index 00000000..35a1329a
--- /dev/null
+++ b/autotests/testEAP/peap/ssidEAP-PEAPv1-MD5.8021x
@@ -0,0 +1,12 @@
+[Security]
+EAP-Method=3DPEAP
+EAP-Identity=3Dpeapv1(a)example.com
+EAP-PEAP-CACert=3D/tmp/certs/cert-ca.pem
+EAP-PEAP-ClientCert=3D/tmp/certs/cert-client.pem
+EAP-PEAP-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
+EAP-PEAP-Phase2-Method=3DMD5
+EAP-PEAP-Phase2-Identity=3Dmd5-phase2(a)example.com
+EAP-PEAP-Phase2-Password=3DPassword
+
+[Settings]
+AutoConnect=3Dfalse
diff --git a/autotests/testEAP/peap/ssidEAP-PEAPv1-MSCHAPv2.8021x b/autotes=
ts/testEAP/peap/ssidEAP-PEAPv1-MSCHAPv2.8021x
new file mode 100644
index 00000000..02290920
--- /dev/null
+++ b/autotests/testEAP/peap/ssidEAP-PEAPv1-MSCHAPv2.8021x
@@ -0,0 +1,12 @@
+[Security]
+EAP-Method=3DPEAP
+EAP-Identity=3Dpeapv1(a)example.com
+EAP-PEAP-CACert=3D/tmp/certs/cert-ca.pem
+EAP-PEAP-ClientCert=3D/tmp/certs/cert-client.pem
+EAP-PEAP-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
+EAP-PEAP-Phase2-Method=3DMSCHAPV2
+EAP-PEAP-Phase2-Identity=3Dmschapv2-phase2(a)example.com
+EAP-PEAP-Phase2-Password=3DPassword
+
+[Settings]
+AutoConnect=3Dfalse
diff --git a/autotests/testEAP/peap/ssidEAP-PEAPv1-SIM.8021x b/autotests/te=
stEAP/peap/ssidEAP-PEAPv1-SIM.8021x
new file mode 100644
index 00000000..2f0f6688
--- /dev/null
+++ b/autotests/testEAP/peap/ssidEAP-PEAPv1-SIM.8021x
@@ -0,0 +1,10 @@
+[Security]
+EAP-Method=3DPEAP
+EAP-Identity=3Dpeapv1(a)example.com
+EAP-PEAP-CACert=3D/tmp/certs/cert-ca.pem
+EAP-PEAP-ClientCert=3D/tmp/certs/cert-client.pem
+EAP-PEAP-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
+EAP-PEAP-Phase2-Method=3DSIM
+
+[Settings]
+AutoConnect=3Dfalse
diff --git a/autotests/testEAP/sim/aka.db b/autotests/testEAP/sim/aka.db
new file mode 100644
index 00000000..c4461ae1
--- /dev/null
+++ b/autotests/testEAP/sim/aka.db
@@ -0,0 +1,3 @@
+# IMSI K OPC AMF SQN
+
+12345678:90dca4eda45b53cf0f12d7c9c3bc6a89:cb9cccc4b9258e6dca4760379fb82581=
:61df:000000000021
\ No newline at end of file
diff --git a/autotests/testEAP/sim/sim.db b/autotests/testEAP/sim/sim.db
new file mode 100644
index 00000000..fbf79786
--- /dev/null
+++ b/autotests/testEAP/sim/sim.db
@@ -0,0 +1 @@
+12345678:673fb8cd35f98800:1fb1e3b5:DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
diff --git a/autotests/testEAP/sim/ssidEAP-AKA-prime.8021x b/autotests/test=
EAP/sim/ssidEAP-AKA-prime.8021x
new file mode 100644
index 00000000..6e88da6b
--- /dev/null
+++ b/autotests/testEAP/sim/ssidEAP-AKA-prime.8021x
@@ -0,0 +1,5 @@
+[Security]
+EAP-Method=3DAKA'
+
+[Settings]
+AutoConnect=3Dfalse
diff --git a/autotests/testEAP/sim/ssidEAP-AKA.8021x b/autotests/testEAP/si=
m/ssidEAP-AKA.8021x
new file mode 100644
index 00000000..1d55e17c
--- /dev/null
+++ b/autotests/testEAP/sim/ssidEAP-AKA.8021x
@@ -0,0 +1,2 @@
+[Security]
+EAP-Method=3DAKA
diff --git a/autotests/testEAP/sim/ssidEAP-SIM.8021x b/autotests/testEAP/si=
m/ssidEAP-SIM.8021x
new file mode 100644
index 00000000..1dcdbcb6
--- /dev/null
+++ b/autotests/testEAP/sim/ssidEAP-SIM.8021x
@@ -0,0 +1,5 @@
+[Security]
+EAP-Method=3DSIM
+
+[Settings]
+AutoConnect=3Dfalse
diff --git a/autotests/testEAP/ssidEAP-PWD.8021x b/autotests/testEAP/ssidEA=
P-PWD.8021x
new file mode 100644
index 00000000..03fd9926
--- /dev/null
+++ b/autotests/testEAP/ssidEAP-PWD.8021x
@@ -0,0 +1,7 @@
+[Security]
+EAP-Method=3DPWD
+EAP-Identity=3Dpwd(a)example.com
+EAP-Password=3DPassword
+
+[Settings]
+AutoConnect=3Dfalse
diff --git a/autotests/testEAP/ssidEAP.conf b/autotests/testEAP/ssidEAP.conf
new file mode 100644
index 00000000..d2536a4d
--- /dev/null
+++ b/autotests/testEAP/ssidEAP.conf
@@ -0,0 +1,14 @@
+hw_mode=3Dg
+channel=3D1
+ssid=3DssidEAP
+wpa=3D3
+wpa_key_mgmt=3DWPA-EAP
+ieee8021x=3D1
+eap_server=3D1
+eap_user_file=3D/tmp/secrets/eap-user.text
+ca_cert=3D/tmp/certs/cert-ca.pem
+server_cert=3D/tmp/certs/cert-server.pem
+private_key=3D/tmp/certs/cert-server-key.pem
+
+eap_sim_db=3Dunix:/tmp/hlrauc.sock
+eap_sim_aka_result_ind=3D1
diff --git a/autotests/testEAP/tls/ssidEAP-TLS-des-ede3.8021x b/autotests/t=
estEAP/tls/ssidEAP-TLS-des-ede3.8021x
new file mode 100644
index 00000000..5b4a7df8
--- /dev/null
+++ b/autotests/testEAP/tls/ssidEAP-TLS-des-ede3.8021x
@@ -0,0 +1,9 @@
+[Security]
+EAP-Method=3DTLS
+EAP-TLS-CACert=3D/tmp/certs/cert-ca.pem
+EAP-TLS-ClientCert=3D/tmp/certs/cert-client.crt
+EAP-TLS-ClientKey=3D/tmp/certs/cert-client-key-v2-des-ede3.pem
+EAP-Identity=3Dtls(a)example.com
+
+[Settings]
+AutoConnect=3DFalse
diff --git a/autotests/testEAP/tls/ssidEAP-TLS-embedded.8021x b/autotests/t=
estEAP/tls/ssidEAP-TLS-embedded.8021x
new file mode 100644
index 00000000..068d661c
--- /dev/null
+++ b/autotests/testEAP/tls/ssidEAP-TLS-embedded.8021x
@@ -0,0 +1,94 @@
+[Security]
+EAP-Method=3DTLS
+EAP-TLS-CACert=3Dembed:cert_ca
+EAP-TLS-ClientCert=3Dembed:cert_client
+EAP-TLS-ClientKey=3Dembed:cert_client_key
+EAP-Identity=3Dtls(a)example.com
+
+[@pem(a)cert_ca]
+-----BEGIN CERTIFICATE-----
+MIIEVDCCAzygAwIBAgIJAJmt2W7CutHvMA0GCSqGSIb3DQEBCwUAMHgxNTAzBgNV
+BAoMLEludGVybmF0aW9uYWwgVW5pb24gb2YgRXhhbXBsZSBPcmdhbml6YXRpb25z
+MR8wHQYDVQQDDBZDZXJ0aWZpY2F0ZSBpc3N1ZXIgZ3V5MR4wHAYJKoZIhvcNAQkB
+Fg9jYUBtYWlsLmV4YW1wbGUwHhcNMTYwNTE3MjEyMDQ2WhcNNDMxMDAzMjEyMDQ2
+WjB4MTUwMwYDVQQKDCxJbnRlcm5hdGlvbmFsIFVuaW9uIG9mIEV4YW1wbGUgT3Jn
+YW5pemF0aW9uczEfMB0GA1UEAwwWQ2VydGlmaWNhdGUgaXNzdWVyIGd1eTEeMBwG
+CSqGSIb3DQEJARYPY2FAbWFpbC5leGFtcGxlMIIBIjANBgkqhkiG9w0BAQEFAAOC
+AQ8AMIIBCgKCAQEAo3GrGqW49h8kY2Wx/1kd5dIkYGazuWrX93ma9904hHBJNsvu
+V34QfHVln6wDpMZMwuvkfct09kl0rQpztJzA9YL4GMdmV6+6J6LiX1kMqLkNaJa+
+Ov+ECG5ypBRbSTYKpqFsc5wPOQf/N8brBiZS1v67va3fCwO6dgLeAf7dZ3Q70oUr
+mghbK8UnlC+wLShxCBAW8TUKg7B7M5Gea794CO9wH7NsFyAr963WVcLxrdL3xMHZ
+9hcscrljh35nCAc6sum1cTtWI651OGehr0Bhp2o2Exgr2mbo5TobqEW+fe4gc4ik
+0nzHGWiOVaszUcvpeeduGV3y6om93atffeKuxQIDAQABo4HgMIHdMA8GA1UdEwQI
+MAYBAf8CAQAwHQYDVR0OBBYEFO+M3tJAELTnseUqZyP4vl5X7SmUMIGqBgNVHSME
+gaIwgZ+AFO+M3tJAELTnseUqZyP4vl5X7SmUoXykejB4MTUwMwYDVQQKDCxJbnRl
+cm5hdGlvbmFsIFVuaW9uIG9mIEV4YW1wbGUgT3JnYW5pemF0aW9uczEfMB0GA1UE
+AwwWQ2VydGlmaWNhdGUgaXNzdWVyIGd1eTEeMBwGCSqGSIb3DQEJARYPY2FAbWFp
+bC5leGFtcGxlggkAma3ZbsK60e8wDQYJKoZIhvcNAQELBQADggEBAA/Yb9jB94OF
+swbyCrA6Qe53YGC4dfqrKGRThtGKTrH0XcM2x2qLIIbiNDogwhRqlUW8iNY6Dm2k
+43mJzNsYhy7Nt3IJFCguTJFilfGzQnBtK8wCr/C9qsj//BESOIlo/TDZ2Ho4ixcJ
+n+FTnN34F6JJ0DIvA6tNBe1kUFSrbubL8ygNWJ9BKMebEzokGNGCGFNr70DlQj2o
+1EOMMOkj0gWO0WegAYFLojzag3l+uvU59YE+/fbZ2iclyvbF7IutQ5M9g5TnQE6F
+f+qFKR5+bhlJwry6vLl/6ulihkvF3y1bm7zae62zbFaZRU6PJUl1DtXiA23ZTm9T
+VDivqs07R84=3D
+-----END CERTIFICATE-----
+
+[@pem(a)cert_client]
+-----BEGIN CERTIFICATE-----
+MIIEPTCCAyWgAwIBAgIJAPk7rut4SWQCMA0GCSqGSIb3DQEBCwUAMHgxNTAzBgNV
+BAoMLEludGVybmF0aW9uYWwgVW5pb24gb2YgRXhhbXBsZSBPcmdhbml6YXRpb25z
+MR8wHQYDVQQDDBZDZXJ0aWZpY2F0ZSBpc3N1ZXIgZ3V5MR4wHAYJKoZIhvcNAQkB
+Fg9jYUBtYWlsLmV4YW1wbGUwHhcNMTYwNTE3MjEyMDQ3WhcNNDMxMDAzMjEyMDQ3
+WjBnMSEwHwYDVQQKDBhCYXIgRXhhbXBsZSBPcmdhbml6YXRpb24xITAfBgNVBAMM
+GEJhciBFeGFtcGxlIE9yZ2FuaXphdGlvbjEfMB0GCSqGSIb3DQEJARYQYmFyQG1h
+aWwuZXhhbXBsZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOE5D/lU
+haTC3xL281ttZPRURXlKJqLwcHGXQSuQm6wwYWtAhLyMLEHrryE0oChKdw3eV7Nn
+/IODxvk1S8uIuKfHWuNd5qX/yu7CjCWvyim2CSJHF24rQFmb9ePoddOZnDMMAIz7
+PC325JVhbr/LSBLbqhZ0smHy1HKyrzzHHzKU4YcTH/3+3H4MHZwnNZfbfG5qhRZG
+Nuu/8t+AWVcEocPRGYZpzWJNq6AAzojAHSSOxxiscBMiuQ+BdofPw9XhwpS+Fstk
+rvF8J9FfZj5U3FOm/EgOQn8efnrUL231PqB1R9PIKYv/938p3iDMIi0ETiKi5ced
+WV8m2PcykPdNOKMCAwEAAaOB2jCB1zAJBgNVHRMEAjAAMB0GA1UdDgQWBBTs9eey
+OkMw3uiPpDOa3b9KErbEfzCBqgYDVR0jBIGiMIGfgBTvjN7SQBC057HlKmcj+L5e
+V+0plKF8pHoweDE1MDMGA1UECgwsSW50ZXJuYXRpb25hbCBVbmlvbiBvZiBFeGFt
+cGxlIE9yZ2FuaXphdGlvbnMxHzAdBgNVBAMMFkNlcnRpZmljYXRlIGlzc3VlciBn
+dXkxHjAcBgkqhkiG9w0BCQEWD2NhQG1haWwuZXhhbXBsZYIJAJmt2W7CutHvMA0G
+CSqGSIb3DQEBCwUAA4IBAQA8MxPjU2h5gwntQeSs8eeaEUILMkoU6JSDS4s5Hex5
+xYMLfcSoPPI0E6ahvKtWkSM0UZThyWsulSDTI1EgAiebjms06m1Ogh9V+0VbcOlQ
+D/k3+fSRIiyY+v3J/h8ArUby+m5O2g1TgECr/nZl4avoAI0RpBi3lH6tC8GQYdbc
+SA6hpNCM/dY3LWtAo2W6mdE8+RlCuTj4VZiQ1g6GE77t6XwDFL6vQBzLLXrinvXK
+Ha+IssV5sGdpH9bVFWIJV2q3OZuv3HLhQfGmeUrGyWVcokQQ8d6kRwg65Zb1+KT2
+bNlVKhPAMBk4ayEocpqFIfqfCKDjGdPUruIh8IVDc684
+-----END CERTIFICATE-----
+
+[@pem(a)cert_client_key]
+-----BEGIN PRIVATE KEY-----
+MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDhOQ/5VIWkwt8S
+9vNbbWT0VEV5Siai8HBxl0ErkJusMGFrQIS8jCxB668hNKAoSncN3lezZ/yDg8b5
+NUvLiLinx1rjXeal/8ruwowlr8optgkiRxduK0BZm/Xj6HXTmZwzDACM+zwt9uSV
+YW6/y0gS26oWdLJh8tRysq88xx8ylOGHEx/9/tx+DB2cJzWX23xuaoUWRjbrv/Lf
+gFlXBKHD0RmGac1iTaugAM6IwB0kjscYrHATIrkPgXaHz8PV4cKUvhbLZK7xfCfR
+X2Y+VNxTpvxIDkJ/Hn561C9t9T6gdUfTyCmL//d/Kd4gzCItBE4iouXHnVlfJtj3
+MpD3TTijAgMBAAECggEBAIbg9YAL7j1NtupUmkkWqm7oSPLqRVkvRSfBvXWplJD6
+KF1itht0lsyjqK3qJj/62HGlxj/a9o6MTIzSLiImLu/Lo9KmWYrwNUfnmqa3MArq
+yW2NxapknJUNoaRrgqTGSZUIiwvjKZcdVKdhQkH6K5+fja0FFg8yrahC+k8bsMNI
+5mw8NwRdR3SvHJWHCLfKCQ31tju7On/4C6jr0siUCc2//W+SO5c+FHDY1bma02cp
+jXTEiFpw91YcyKxiADIaH9/qfxWdefxqYg1WlUeXF3jYt5xYnYr34qKW1gOZ3jy1
+QJ3esn382ZTml3TFZWy+g9tkYyOSgmDwQZbLk/ppBAECgYEA8RzLBFwP018ieMBv
+khDtwcKk6ZihkWZxEPQPuUljWzzAHn/f3dXOcrfmflAKeoDEeYDimDYDizTLDPC4
+zmWkMJHNadcM5H065BbGVFQWXo47ltccfIlB/1vzG8aywfJ/yNfHvH87wbH2eg6N
+yOr+96ZjLJszQ+Rv189BbXDzTcMCgYEA7yEbUL/A1J0l2kLoYyS0vfVa7AyBVOFW
+vPgfkF7HdNpIiFWlukMr+DWOolaoZp5iHqQXFwJsL8qCcrbZuHbaNHAI/5vDE9xG
+fh8KzrfBrjIPIyNm6EWpsBo5unXK+wTeqIAGKdzDo5Q3zEE6G5DkkHItKA7yjPOM
+gz/b/MR3W6ECgYBBv3dA3hXWrreIs/j4nLMoxfoQVPWh34xvcg4jmXaFd6Bv8LDM
+HjRopestgIgK9bgd5d5kYT5AJIpGIhJS/fZy5B9egCzc1aVMc0Vr024yJJjtPgVf
+lFIx3xIA/gLazlS4INcveIaEABJVIEjbg/E4+N9MV5n4Jn+1GqgdvtIp3wKBgQC0
+C3lFkxrc+nVFoJrYCwsK+3E5yTCXeBKWtTsOuE307WUvQU1GsMyqVajPEfA5U4cN
+Cv9Xk7thQFh3hrTm7pXcZX5g9iYrDe8FhtncSv7I6Wf8TOtudwUMUrKkcYwi88ex
+lrMNUer7ft2ELJhTqQRuvYjCYH6/IaDqMWqxJju4AQKBgQDPjOh75ykQc93SsYpt
+Tb4gQKLeqOb57pofT8D44DccatfEgk31D4fBIIQu6XKopQmCtQyX9DUDjOWFTxuo
+IMPysN6Fh1quCbC6Xt5xfKoaJG5yQYKeKtLhknwEW9SUifU2xVrOcPikLs7Iwmmp
+BkDLsu/YKwRFSfrbYZXbTlU8tQ=3D=3D
+-----END PRIVATE KEY-----
+
+[Settings]
+AutoConnect=3DFalse
diff --git a/autotests/testEAP/tls/ssidEAP-TLS-keybundle.8021x b/autotests/=
testEAP/tls/ssidEAP-TLS-keybundle.8021x
new file mode 100644
index 00000000..30470388
--- /dev/null
+++ b/autotests/testEAP/tls/ssidEAP-TLS-keybundle.8021x
@@ -0,0 +1,9 @@
+[Security]
+EAP-Method=3DTLS
+EAP-TLS-CACert=3D/tmp/certs/cert-ca.pem
+EAP-TLS-ClientKeyBundle=3D/tmp/certs/cert-client.p12
+EAP-TLS-ClientKeyPassphrase=3Dabc
+EAP-Identity=3Dtls(a)example.com
+
+[Settings]
+AutoConnect=3DFalse
diff --git a/autotests/testEAP/tls/ssidEAP-TLS-keypass.8021x b/autotests/te=
stEAP/tls/ssidEAP-TLS-keypass.8021x
new file mode 100644
index 00000000..538d2dda
--- /dev/null
+++ b/autotests/testEAP/tls/ssidEAP-TLS-keypass.8021x
@@ -0,0 +1,10 @@
+[Security]
+EAP-Method=3DTLS
+EAP-TLS-CACert=3D/tmp/certs/cert-ca.pem
+EAP-TLS-ClientCert=3D/tmp/certs/cert-client.pem
+EAP-TLS-ClientKey=3D/tmp/certs/cert-client-key-md5-des.pem
+EAP-TLS-ClientKeyPassphrase=3Dabc
+EAP-Identity=3Dtls(a)example.com
+
+[Settings]
+AutoConnect=3DFalse
diff --git a/autotests/testEAP/tls/ssidEAP-TLS-nokeypass.8021x b/autotests/=
testEAP/tls/ssidEAP-TLS-nokeypass.8021x
new file mode 100644
index 00000000..88c622ad
--- /dev/null
+++ b/autotests/testEAP/tls/ssidEAP-TLS-nokeypass.8021x
@@ -0,0 +1,9 @@
+[Security]
+EAP-Method=3DTLS
+EAP-TLS-CACert=3D/tmp/certs/cert-ca.pem
+EAP-TLS-ClientCert=3D/tmp/certs/cert-client.pem
+EAP-TLS-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
+EAP-Identity=3Dtls(a)example.com
+
+[Settings]
+AutoConnect=3DFalse
diff --git a/autotests/testEAP/ttls/ssidEAP-TTLS-CHAP.8021x b/autotests/tes=
tEAP/ttls/ssidEAP-TTLS-CHAP.8021x
new file mode 100644
index 00000000..4f67f540
--- /dev/null
+++ b/autotests/testEAP/ttls/ssidEAP-TTLS-CHAP.8021x
@@ -0,0 +1,12 @@
+[Security]
+EAP-Method=3DTTLS
+EAP-Identity=3Dttls(a)example.com
+EAP-TTLS-Phase2-Method=3DTunneled-CHAP
+
+# If CHAP Identity and Password are left out, they will be requested throu=
gh
+# the agent.
+#EAP-TTLS-Phase2-Identity=3Dttls-chap-phase2(a)example.com
+#EAP-TTLS-Phase2-Password=3DPassword
+
+[Settings]
+AutoConnect=3DFalse
diff --git a/autotests/testEAP/ttls/ssidEAP-TTLS-MD5.8021x b/autotests/test=
EAP/ttls/ssidEAP-TTLS-MD5.8021x
new file mode 100644
index 00000000..f789fe42
--- /dev/null
+++ b/autotests/testEAP/ttls/ssidEAP-TTLS-MD5.8021x
@@ -0,0 +1,12 @@
+[Security]
+EAP-Method=3DTTLS
+EAP-Identity=3Dttls(a)example.com
+EAP-TTLS-CACert=3D/tmp/certs/cert-ca.pem
+EAP-TTLS-ClientCert=3D/tmp/certs/cert-client.pem
+EAP-TTLS-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
+EAP-TTLS-Phase2-Method=3DMD5
+EAP-TTLS-Phase2-Identity=3Dmd5-phase2(a)example.com
+EAP-TTLS-Phase2-Password=3DPassword
+
+[Settings]
+AutoConnect=3DFalse
diff --git a/autotests/testEAP/ttls/ssidEAP-TTLS-MSCHAPV2.8021x b/autotests=
/testEAP/ttls/ssidEAP-TTLS-MSCHAPV2.8021x
new file mode 100644
index 00000000..a3733635
--- /dev/null
+++ b/autotests/testEAP/ttls/ssidEAP-TTLS-MSCHAPV2.8021x
@@ -0,0 +1,8 @@
+[Security]
+EAP-Method=3DTTLS
+EAP-Identity=3Dttls(a)example.com
+EAP-TTLS-CACert=3D/tmp/certs/cert-ca.pem
+EAP-TTLS-ClientCert=3D/tmp/certs/cert-client.pem
+EAP-TTLS-ClientKey=3D/tmp/certs/cert-client-key-v2-des-ede3.pem
+EAP-TTLS-Phase2-Method=3DMSCHAPV2
+EAP-TTLS-Phase2-Identity=3Dmschapv2-phase2(a)example.com
diff --git a/autotests/testEAP/ttls/ssidEAP-TTLS-Tunneled-MSCHAP.8021x b/au=
totests/testEAP/ttls/ssidEAP-TTLS-Tunneled-MSCHAP.8021x
new file mode 100644
index 00000000..3d9e523b
--- /dev/null
+++ b/autotests/testEAP/ttls/ssidEAP-TTLS-Tunneled-MSCHAP.8021x
@@ -0,0 +1,12 @@
+[Security]
+EAP-Method=3DTTLS
+EAP-Identity=3Dttls(a)example.com
+EAP-TTLS-Phase2-Method=3DTunneled-MSCHAP
+
+# If MSCHAP Identity and Password are left out, they will be requested thr=
ough
+# the agent.
+#EAP-TTLS-Phase2-Identity=3Dttls-mschap-phase2(a)example.com
+#EAP-TTLS-Phase2-Password=3DPassword
+
+[Settings]
+AutoConnect=3DFalse
diff --git a/autotests/testEAP/ttls/ssidEAP-TTLS-Tunneled-MSCHAPV2.8021x b/=
autotests/testEAP/ttls/ssidEAP-TTLS-Tunneled-MSCHAPV2.8021x
new file mode 100644
index 00000000..2a33d0d0
--- /dev/null
+++ b/autotests/testEAP/ttls/ssidEAP-TTLS-Tunneled-MSCHAPV2.8021x
@@ -0,0 +1,12 @@
+[Security]
+EAP-Method=3DTTLS
+EAP-Identity=3Dttls(a)example.com
+EAP-TTLS-Phase2-Method=3DTunneled-MSCHAPv2
+
+# If MSCHAP Identity and Password are left out, they will be requested thr=
ough
+# the agent.
+#EAP-TTLS-Phase2-Identity=3Dttls-mschapv2-phase2(a)example.com
+#EAP-TTLS-Phase2-Password=3DPassword
+
+[Settings]
+AutoConnect=3DFalse
diff --git a/autotests/testEAP/ttls/ssidEAP-TTLS-Tunneled-PAP.8021x b/autot=
ests/testEAP/ttls/ssidEAP-TTLS-Tunneled-PAP.8021x
new file mode 100644
index 00000000..eecb4a23
--- /dev/null
+++ b/autotests/testEAP/ttls/ssidEAP-TTLS-Tunneled-PAP.8021x
@@ -0,0 +1,12 @@
+[Security]
+EAP-Method=3DTTLS
+EAP-Identity=3Dttls(a)example.com
+EAP-TTLS-Phase2-Method=3DTunneled-PAP
+
+# If PAP Identity and Password are left out, they will be requested through
+# the agent.
+#EAP-TTLS-Phase2-Identity=3Dttls-pap(a)example.com
+#EAP-TTLS-Phase2-Password=3DPassword
+
+[Settings]
+AutoConnect=3DFalse
-- =

2.31.1

--===============2998029829581243330==--

