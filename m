Content-Type: multipart/mixed; boundary="===============4473062304897260974=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/5] auto-t: add SAE test for no supported groups
Date: Wed, 08 Sep 2021 15:47:44 -0700
Message-ID: <20210908224744.102156-5-prestwoj@gmail.com>
In-Reply-To: <20210908224744.102156-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4473062304897260974==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testSAE/failure_test.py | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/autotests/testSAE/failure_test.py b/autotests/testSAE/failure_=
test.py
index 95872413..e61bf585 100644
--- a/autotests/testSAE/failure_test.py
+++ b/autotests/testSAE/failure_test.py
@@ -8,11 +8,12 @@ import iwd
 from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
+from hostapd import HostapdCLI
 =

 class Test(unittest.TestCase):
 =

-    def validate_connection(self, wd):
-        psk_agent =3D PSKAgent("InvalidSecret")
+    def validate_connection(self, wd, passphrase):
+        psk_agent =3D PSKAgent(passphrase)
         wd.register_psk_agent(psk_agent)
 =

         devices =3D wd.list_devices(1)
@@ -33,7 +34,15 @@ class Test(unittest.TestCase):
 =

     def test_connection_success(self):
         wd =3D IWD(True)
-        self.validate_connection(wd)
+        self.validate_connection(wd, 'InvalidSecret')
+
+    def test_no_supported_groups(self):
+        hostapd =3D HostapdCLI(config=3D'ssidSAE.conf')
+        hostapd.set_value('sae_groups', '1')
+        hostapd.reload()
+
+        wd =3D IWD(True)
+        self.validate_connection(wd, 'secret123')
 =

     @classmethod
     def setUpClass(cls):
-- =

2.31.1

--===============4473062304897260974==--

