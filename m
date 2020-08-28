Content-Type: multipart/mixed; boundary="===============3080624586530887618=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 11/15] auto-t: skip ofono tests if ofonod isn't running
Date: Fri, 28 Aug 2020 09:40:46 -0700
Message-ID: <20200828164050.1456-12-prestwoj@gmail.com>
In-Reply-To: <20200828164050.1456-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3080624586530887618==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testEAP-AKA-ofono/connection_test.py       | 4 ++++
 autotests/testEAP-AKA-prime-ofono/connection_test.py | 4 ++++
 autotests/testEAP-SIM-ofono/connection_test.py       | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/autotests/testEAP-AKA-ofono/connection_test.py b/autotests/tes=
tEAP-AKA-ofono/connection_test.py
index 94066f76..27f736f6 100644
--- a/autotests/testEAP-AKA-ofono/connection_test.py
+++ b/autotests/testEAP-AKA-ofono/connection_test.py
@@ -9,6 +9,7 @@ from iwd import IWD
 from iwd import NetworkType
 from hlrauc import AuthCenter
 from ofono import Ofono
+from config import ctx
 =

 class Test(unittest.TestCase):
 =

@@ -56,6 +57,9 @@ class Test(unittest.TestCase):
         auth.stop()
     @classmethod
     def setUpClass(cls):
+        if not ctx.is_process_running('ofonod'):
+            cls.skipTest(cls, "ofono not running")
+
         IWD.copy_to_storage('ssidEAP-AKA.8021x')
 =

     @classmethod
diff --git a/autotests/testEAP-AKA-prime-ofono/connection_test.py b/autotes=
ts/testEAP-AKA-prime-ofono/connection_test.py
index 2ff99894..967ba352 100644
--- a/autotests/testEAP-AKA-prime-ofono/connection_test.py
+++ b/autotests/testEAP-AKA-prime-ofono/connection_test.py
@@ -9,6 +9,7 @@ from iwd import IWD
 from iwd import NetworkType
 from hlrauc import AuthCenter
 from ofono import Ofono
+from config import ctx
 =

 class Test(unittest.TestCase):
 =

@@ -57,6 +58,9 @@ class Test(unittest.TestCase):
 =

     @classmethod
     def setUpClass(cls):
+        if not ctx.is_process_running('ofonod'):
+            cls.skipTest(cls, "ofono not running")
+
         IWD.copy_to_storage('ssidEAP-AKA.8021x')
 =

     @classmethod
diff --git a/autotests/testEAP-SIM-ofono/connection_test.py b/autotests/tes=
tEAP-SIM-ofono/connection_test.py
index 95242943..de7c4b48 100644
--- a/autotests/testEAP-SIM-ofono/connection_test.py
+++ b/autotests/testEAP-SIM-ofono/connection_test.py
@@ -9,6 +9,7 @@ from iwd import IWD
 from iwd import NetworkType
 from hlrauc import AuthCenter
 from ofono import Ofono
+from config import ctx
 =

 class Test(unittest.TestCase):
 =

@@ -57,6 +58,9 @@ class Test(unittest.TestCase):
 =

     @classmethod
     def setUpClass(cls):
+        if not ctx.is_process_running('ofonod'):
+            cls.skipTest(cls, "ofono not running")
+
         IWD.copy_to_storage('ssidEAP-SIM.8021x')
 =

     @classmethod
-- =

2.21.1

--===============3080624586530887618==--

