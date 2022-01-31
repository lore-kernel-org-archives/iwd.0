Content-Type: multipart/mixed; boundary="===============3871415431990218282=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 5/5] auto-t: add test for encrypted profiles
Date: Mon, 31 Jan 2022 12:11:55 -0800
Message-ID: <20220131201155.3878756-5-prestwoj@gmail.com>
In-Reply-To: 20220131201155.3878756-1-prestwoj@gmail.com

--===============3871415431990218282==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 .../testEncryptedProfiles/connection_test.py  | 130 ++++++++++++++++++
 autotests/testEncryptedProfiles/hw.conf       |   6 +
 autotests/testEncryptedProfiles/iwd-secret    |   1 +
 autotests/testEncryptedProfiles/main.conf     |   2 +
 autotests/testEncryptedProfiles/ssidCCMP.conf |  10 ++
 autotests/testEncryptedProfiles/ssidCCMP.psk  |   2 +
 6 files changed, 151 insertions(+)
 create mode 100644 autotests/testEncryptedProfiles/connection_test.py
 create mode 100644 autotests/testEncryptedProfiles/hw.conf
 create mode 100644 autotests/testEncryptedProfiles/iwd-secret
 create mode 100644 autotests/testEncryptedProfiles/main.conf
 create mode 100644 autotests/testEncryptedProfiles/ssidCCMP.conf
 create mode 100644 autotests/testEncryptedProfiles/ssidCCMP.psk

diff --git a/autotests/testEncryptedProfiles/connection_test.py b/autotests=
/testEncryptedProfiles/connection_test.py
new file mode 100644
index 00000000..f885fe49
--- /dev/null
+++ b/autotests/testEncryptedProfiles/connection_test.py
@@ -0,0 +1,130 @@
+#!/usr/bin/python3
+
+import unittest
+import sys
+
+sys.path.append('../util')
+import iwd
+import os
+from iwd import IWD
+from iwd import NetworkType
+from iwd import PSKAgent
+
+class Test(unittest.TestCase):
+    def profile_is_encrypted(self, profile):
+        with open('/tmp/iwd/' + profile) as f:
+            contents =3D f.read()
+
+        if 'Passphrase' in contents:
+            return False
+
+        return True
+
+    def validate(self, wd):
+        devices =3D wd.list_devices(1)
+        device =3D devices[0]
+
+        ordered_network =3D device.get_ordered_network('ssidCCMP')
+
+        self.assertEqual(ordered_network.type, NetworkType.psk)
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
+        device.disconnect()
+
+        condition =3D 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+
+    # Tests that an existing plaintext profile gets encrypted
+    def test_new_profile(self):
+        IWD.copy_to_storage('ssidCCMP.psk')
+
+        mtime =3D os.path.getmtime('/tmp/iwd/' + 'ssidCCMP.psk')
+        self.assertFalse(self.profile_is_encrypted('ssidCCMP.psk'))
+
+        wd =3D IWD(True)
+
+        # Make sure profile was accepted
+        condition =3D 'len(obj.list_known_networks()) =3D=3D 1'
+        wd.wait_for_object_condition(wd, condition)
+
+        # Check the file was modified (should be encrypted now)
+        self.assertNotEqual(mtime, os.path.getmtime('/tmp/iwd/' + 'ssidCCM=
P.psk'))
+
+        self.validate(wd)
+
+        self.assertTrue(self.profile_is_encrypted('ssidCCMP.psk'))
+
+    # Tests that a new connection with agent gets written to an encrypted =
profile
+    def test_agent_profile(self):
+        wd =3D IWD(True)
+
+        psk_agent =3D PSKAgent("secret123")
+        wd.register_psk_agent(psk_agent)
+
+        with self.assertRaises(FileNotFoundError):
+            self.profile_is_encrypted('ssidCCMP.psk')
+
+        self.validate(wd)
+
+        self.assertTrue(self.profile_is_encrypted('ssidCCMP.psk'))
+
+        wd.unregister_psk_agent(psk_agent)
+
+    # Tests that an invalid profile gets re-written after an agent request
+    def test_invalid_profile_rewritten(self):
+        bad_config =3D '[Security]\nPassphrase=3Dincorrect\n'
+        os.system('echo "%s" > /tmp/iwd/ssidCCMP.psk' % bad_config)
+
+        wd =3D IWD(True)
+
+        condition =3D 'len(obj.list_known_networks()) =3D=3D 1'
+        wd.wait_for_object_condition(wd, condition)
+
+        # IWD should still encrypt the profile automatically
+        self.assertTrue(self.profile_is_encrypted('ssidCCMP.psk'))
+
+        # This should fail
+        with self.assertRaises(iwd.FailedEx):
+            self.validate(wd)
+
+        psk_agent =3D PSKAgent("secret123")
+        wd.register_psk_agent(psk_agent)
+
+        self.validate(wd)
+
+        self.assertTrue(self.profile_is_encrypted('ssidCCMP.psk'))
+
+    # Tests that a profile that doesn't decrypt wont become a known network
+    def test_decryption_failure(self):
+        bad_config =3D \
+'''
+[Security]
+EncryptedSalt=3D000102030405060708090a0b0c0d0e0f
+EncryptedSecurity=3Daabbccddeeff00112233445566778899
+'''
+        os.system('echo "%s" > /tmp/iwd/ssidCCMP.psk' % bad_config)
+
+        wd =3D IWD(True)
+
+        self.assertEqual(wd.list_known_networks(), [])
+
+    def tearDown(self):
+        IWD.clear_storage()
+
+    @classmethod
+    def setUpClass(cls):
+        os.environ['CREDENTIALS_DIRECTORY'] =3D '/tmp'
+
+    @classmethod
+    def tearDownClass(cls):
+        IWD.clear_storage()
+
+if __name__ =3D=3D '__main__':
+    unittest.main(exit=3DTrue)
diff --git a/autotests/testEncryptedProfiles/hw.conf b/autotests/testEncryp=
tedProfiles/hw.conf
new file mode 100644
index 00000000..de81e1e2
--- /dev/null
+++ b/autotests/testEncryptedProfiles/hw.conf
@@ -0,0 +1,6 @@
+[SETUP]
+num_radios=3D2
+start_iwd=3D0
+
+[HOSTAPD]
+rad0=3DssidCCMP.conf
diff --git a/autotests/testEncryptedProfiles/iwd-secret b/autotests/testEnc=
ryptedProfiles/iwd-secret
new file mode 100644
index 00000000..c2afca48
--- /dev/null
+++ b/autotests/testEncryptedProfiles/iwd-secret
@@ -0,0 +1 @@
+secret123
diff --git a/autotests/testEncryptedProfiles/main.conf b/autotests/testEncr=
yptedProfiles/main.conf
new file mode 100644
index 00000000..35d40c5e
--- /dev/null
+++ b/autotests/testEncryptedProfiles/main.conf
@@ -0,0 +1,2 @@
+[General]
+SystemdEncrypt=3Diwd-secret
diff --git a/autotests/testEncryptedProfiles/ssidCCMP.conf b/autotests/test=
EncryptedProfiles/ssidCCMP.conf
new file mode 100644
index 00000000..c79f5e55
--- /dev/null
+++ b/autotests/testEncryptedProfiles/ssidCCMP.conf
@@ -0,0 +1,10 @@
+hw_mode=3Dg
+channel=3D1
+ssid=3DssidCCMP
+
+wpa=3D2
+wpa_pairwise=3DCCMP
+wpa_passphrase=3Dsecret123
+
+ieee80211w=3D2
+wpa_key_mgmt=3DWPA-PSK-SHA256
diff --git a/autotests/testEncryptedProfiles/ssidCCMP.psk b/autotests/testE=
ncryptedProfiles/ssidCCMP.psk
new file mode 100644
index 00000000..abafdb66
--- /dev/null
+++ b/autotests/testEncryptedProfiles/ssidCCMP.psk
@@ -0,0 +1,2 @@
+[Security]
+Passphrase=3Dsecret123
-- =

2.31.1

--===============3871415431990218282==--

