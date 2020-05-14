Content-Type: multipart/mixed; boundary="===============8629142994378385008=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v2] auto-t: Test Agent ops
Date: Thu, 14 May 2020 09:20:24 -0700
Message-ID: <20200514162024.14850-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8629142994378385008==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testAgent/agent_test.py | 100 ++++++++++++++++++++++++++++++++++=
++++
 autotests/testAgent/hw.conf       |   7 +++
 autotests/testAgent/ssid1.conf    |   7 +++
 autotests/testAgent/ssid2.conf    |   7 +++
 4 files changed, 121 insertions(+)
 create mode 100644 autotests/testAgent/agent_test.py
 create mode 100644 autotests/testAgent/hw.conf
 create mode 100644 autotests/testAgent/ssid1.conf
 create mode 100644 autotests/testAgent/ssid2.conf

diff --git a/autotests/testAgent/agent_test.py b/autotests/testAgent/agent_=
test.py
new file mode 100644
index 00000000..80d2ce83
--- /dev/null
+++ b/autotests/testAgent/agent_test.py
@@ -0,0 +1,100 @@
+#!/usr/bin/python3
+
+import unittest
+import sys
+
+sys.path.append('../util')
+import iwd
+from iwd import IWD
+from iwd import PSKAgent
+from iwd import NetworkType
+import testutil
+import subprocess
+
+class Test(unittest.TestCase):
+
+    def check_connection(self, wd, ssid):
+
+        device =3D wd.list_devices(1)[0]
+        ordered_network =3D device.get_ordered_network(ssid, scan_if_neede=
d=3DTrue)
+
+        ordered_network.network_object.connect()
+
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
+        condition =3D 'obj.connected_network is not None'
+        wd.wait_for_object_condition(device, condition)
+
+        testutil.test_iface_operstate(device.name)
+        device.disconnect()
+
+        condition =3D 'obj.state =3D=3D DeviceState.disconnected'
+        wd.wait_for_object_condition(device, condition)
+
+    def test_connection_with_no_agent(self):
+
+        wd =3D IWD()
+
+        with self.assertRaises(iwd.NoAgentEx):
+            self.check_connection(wd, 'ssid1')
+
+        IWD.clear_storage()
+
+    def test_connection_with_own_agent(self):
+
+        wd =3D IWD()
+
+        psk_agent =3D PSKAgent("secret_ssid1")
+        wd.register_psk_agent(psk_agent)
+
+        self.check_connection(wd, 'ssid1')
+
+        wd.unregister_psk_agent(psk_agent)
+
+        IWD.clear_storage()
+
+    def test_connection_with_other_agent(self):
+        wd =3D IWD()
+
+        iwctl =3D subprocess.Popen(['iwctl', '-P', 'secret_ssid2'])
+        # Let iwctl to start and register its agent.
+        wd.wait(2)
+
+        self.check_connection(wd, 'ssid2')
+
+        iwctl.terminate()
+        iwctl.communicate()
+
+        IWD.clear_storage()
+
+    def test_connection_use_own_agent_from_multiple_registered(self):
+
+        wd =3D IWD()
+
+        iwctl =3D subprocess.Popen(['iwctl', '-P', 'secret_ssid2'])
+        # Let iwctl to start and register its agent.
+        wd.wait(2)
+
+        psk_agent =3D PSKAgent("secret_ssid1")
+        wd.register_psk_agent(psk_agent)
+
+        self.check_connection(wd, 'ssid1')
+
+        wd.unregister_psk_agent(psk_agent)
+
+        iwctl.terminate()
+        iwctl.communicate()
+
+        IWD.clear_storage()
+
+    @classmethod
+    def setUpClass(cls):
+        pass
+
+    @classmethod
+    def tearDownClass(cls):
+        IWD.clear_storage()
+
+if __name__ =3D=3D '__main__':
+    unittest.main(exit=3DTrue)
diff --git a/autotests/testAgent/hw.conf b/autotests/testAgent/hw.conf
new file mode 100644
index 00000000..53249c9c
--- /dev/null
+++ b/autotests/testAgent/hw.conf
@@ -0,0 +1,7 @@
+[SETUP]
+num_radios=3D3
+max_test_exec_interval_sec=3D40
+
+[HOSTAPD]
+rad0=3Dssid1.conf
+rad1=3Dssid2.conf
diff --git a/autotests/testAgent/ssid1.conf b/autotests/testAgent/ssid1.conf
new file mode 100644
index 00000000..2416d53a
--- /dev/null
+++ b/autotests/testAgent/ssid1.conf
@@ -0,0 +1,7 @@
+hw_mode=3Dg
+channel=3D1
+ssid=3Dssid1
+
+wpa=3D1
+wpa_pairwise=3DTKIP
+wpa_passphrase=3Dsecret_ssid1
diff --git a/autotests/testAgent/ssid2.conf b/autotests/testAgent/ssid2.conf
new file mode 100644
index 00000000..69b4f000
--- /dev/null
+++ b/autotests/testAgent/ssid2.conf
@@ -0,0 +1,7 @@
+hw_mode=3Dg
+channel=3D1
+ssid=3Dssid2
+
+wpa=3D1
+wpa_pairwise=3DTKIP
+wpa_passphrase=3Dsecret_ssid2
-- =

2.13.6

--===============8629142994378385008==--

