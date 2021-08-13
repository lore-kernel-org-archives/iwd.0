Content-Type: multipart/mixed; boundary="===============3870533048275083752=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] auto-t: skip testEAP-PEAP-SIM if ofonod is not running
Date: Fri, 13 Aug 2021 14:49:26 -0700
Message-ID: <20210813214926.813767-2-prestwoj@gmail.com>
In-Reply-To: <20210813214926.813767-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3870533048275083752==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testEAP-PEAP-SIM/connection_test.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/autotests/testEAP-PEAP-SIM/connection_test.py b/autotests/test=
EAP-PEAP-SIM/connection_test.py
index ebf22a46..84b95c7a 100644
--- a/autotests/testEAP-PEAP-SIM/connection_test.py
+++ b/autotests/testEAP-PEAP-SIM/connection_test.py
@@ -10,6 +10,7 @@ from iwd import IWD
 from iwd import NetworkType
 from hlrauc import AuthCenter
 from ofono import Ofono
+from config import ctx
 =

 class Test(unittest.TestCase):
     def validate_connection(self, wd):
@@ -46,6 +47,9 @@ class Test(unittest.TestCase):
 =

     @classmethod
     def setUpClass(cls):
+        if not ctx.is_process_running('ofonod'):
+            cls.skipTest(cls, "ofono not running")
+
         cls.auth =3D AuthCenter('/tmp/hlrauc.sock', '/tmp/sim.db')
 =

         IWD.copy_to_storage('ssidEAP-PEAP-SIM.8021x')
-- =

2.31.1

--===============3870533048275083752==--

