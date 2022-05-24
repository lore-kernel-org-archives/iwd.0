Content-Type: multipart/mixed; boundary="===============8790882909913520229=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/2] auto-t: add EAP reauth to testEAP
Date: Tue, 24 May 2022 13:31:45 -0700
Message-ID: <20220524203145.3218063-2-prestwoj@gmail.com>
In-Reply-To: 20220524203145.3218063-1-prestwoj@gmail.com

--===============8790882909913520229==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testEAP/connection_test.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/autotests/testEAP/connection_test.py b/autotests/testEAP/conne=
ction_test.py
index f072845b..fe048b48 100644
--- a/autotests/testEAP/connection_test.py
+++ b/autotests/testEAP/connection_test.py
@@ -11,6 +11,8 @@ from iwd import PSKAgent
 from hlrauc import AuthCenter
 from ofono import Ofono
 from config import ctx
+from hostapd import HostapdCLI
+
 import testutil
 import traceback
 =

@@ -50,6 +52,8 @@ class Test(unittest.TestCase):
         testutil.test_iface_operstate()
         testutil.test_ifaces_connected()
 =

+        self.hostapd.eapol_reauth(device.address)
+
         if secrets:
             wd.unregister_psk_agent(psk_agent)
 =

@@ -251,6 +255,7 @@ class Test(unittest.TestCase):
     @classmethod
     def setUpClass(cls):
         cls.wd =3D IWD()
+        cls.hostapd =3D HostapdCLI()
 =

     @classmethod
     def tearDownClass(cls):
-- =

2.34.1

--===============8790882909913520229==--

