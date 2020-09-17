Content-Type: multipart/mixed; boundary="===============3568499834527772573=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/6] auto-t: add EAD autotest
Date: Thu, 17 Sep 2020 14:32:47 -0700
Message-ID: <20200917213247.788181-6-prestwoj@gmail.com>
In-Reply-To: <20200917213247.788181-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3568499834527772573==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testEAD/connection_test.py | 35 ++++++++++++++++++++++++++++
 autotests/testEAD/default.8021x      |  7 ++++++
 autotests/testEAD/hw.conf            |  6 +++++
 autotests/testEAD/wired.conf         | 17 ++++++++++++++
 4 files changed, 65 insertions(+)
 create mode 100644 autotests/testEAD/connection_test.py
 create mode 100644 autotests/testEAD/default.8021x
 create mode 100644 autotests/testEAD/hw.conf
 create mode 100644 autotests/testEAD/wired.conf

diff --git a/autotests/testEAD/connection_test.py b/autotests/testEAD/conne=
ction_test.py
new file mode 100644
index 00000000..c51d7237
--- /dev/null
+++ b/autotests/testEAD/connection_test.py
@@ -0,0 +1,35 @@
+#!/usr/bin/python3
+
+import unittest
+import sys
+
+sys.path.append('../util')
+from iwd import IWD
+from config import ctx
+
+from ead import EAD
+
+class Test(unittest.TestCase):
+    def test_connection_success(self):
+        ctx.start_process(['ead', '-i', 'eth1', '-d'])
+
+        ead =3D EAD()
+
+        adapter =3D ead.list_adapters(1)[0]
+
+        condition =3D 'obj.connected =3D=3D True'
+        ead.wait_for_object_condition(adapter, condition)
+
+        condition =3D 'obj.authenticated =3D=3D True'
+        ead.wait_for_object_condition(adapter, condition)
+
+    @classmethod
+    def setUpClass(cls):
+        IWD.copy_to_storage('default.8021x', storage_dir=3D'/var/lib/ead')
+
+    @classmethod
+    def tearDownClass(cls):
+        IWD.clear_storage()
+
+if __name__ =3D=3D '__main__':
+    unittest.main(exit=3DTrue)
diff --git a/autotests/testEAD/default.8021x b/autotests/testEAD/default.80=
21x
new file mode 100644
index 00000000..55eb431d
--- /dev/null
+++ b/autotests/testEAD/default.8021x
@@ -0,0 +1,7 @@
+[Security]
+EAP-Method=3DMSCHAPV2
+EAP-Identity=3Ddomain\\User
+EAP-Password=3DPassword
+
+[Settings]
+AutoConnect=3Dfalse
diff --git a/autotests/testEAD/hw.conf b/autotests/testEAD/hw.conf
new file mode 100644
index 00000000..dee31f9e
--- /dev/null
+++ b/autotests/testEAD/hw.conf
@@ -0,0 +1,6 @@
+[SETUP]
+num_radios=3D0
+start_iwd=3D0
+
+[HOSTAPD]
+radius_server=3Dwired.conf
diff --git a/autotests/testEAD/wired.conf b/autotests/testEAD/wired.conf
new file mode 100644
index 00000000..9e6ef638
--- /dev/null
+++ b/autotests/testEAD/wired.conf
@@ -0,0 +1,17 @@
+interface=3Deth0
+driver=3Dwired
+logger_stdout=3D-1
+logger_stdout_level=3D1
+
+ieee8021x=3D1
+eap_reauth_period=3D3600
+
+use_pae_group_addr=3D1
+
+nas_identifier=3Dap.example.com
+
+radius_server_clients=3D/tmp/certs/radius-clients.text
+radius_server_auth_port=3D1812
+
+eap_user_file=3D/tmp/secrets/eap-user-mschapv2.text
+eap_server=3D1
-- =

2.26.2

--===============3568499834527772573==--

