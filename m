Content-Type: multipart/mixed; boundary="===============5499847693770114872=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 10/13] auto-t: update AP tests with provisioning files
Date: Tue, 20 Oct 2020 11:02:53 -0700
Message-ID: <20201020180256.1630120-10-prestwoj@gmail.com>
In-Reply-To: <20201020180256.1630120-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5499847693770114872==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Also removed some unused config values which are no longer needed
after the test-runner re-write.
---
 autotests/testAP-no-support/TestAP2.ap         | 2 ++
 autotests/testAP-no-support/connection_test.py | 6 +++---
 autotests/testAP-no-support/hw.conf            | 2 +-
 autotests/testAP/TestAP2.ap                    | 2 ++
 autotests/testAP/connection_test.py            | 5 +++--
 autotests/testAP/failure_test.py               | 5 +++--
 autotests/testAP/hw.conf                       | 3 +--
 7 files changed, 15 insertions(+), 10 deletions(-)
 create mode 100644 autotests/testAP-no-support/TestAP2.ap
 create mode 100644 autotests/testAP/TestAP2.ap

diff --git a/autotests/testAP-no-support/TestAP2.ap b/autotests/testAP-no-s=
upport/TestAP2.ap
new file mode 100644
index 00000000..27f086cb
--- /dev/null
+++ b/autotests/testAP-no-support/TestAP2.ap
@@ -0,0 +1,2 @@
+[Security]
+Passphrase=3DPassword2
diff --git a/autotests/testAP-no-support/connection_test.py b/autotests/tes=
tAP-no-support/connection_test.py
index 1bbc0bde..ff6fdb25 100644
--- a/autotests/testAP-no-support/connection_test.py
+++ b/autotests/testAP-no-support/connection_test.py
@@ -9,16 +9,16 @@ from iwd import IWD
 =

 class Test(unittest.TestCase):
     def test_connection_success(self):
-        wd =3D IWD()
+        wd =3D IWD(True)
 =

         dev =3D wd.list_devices(1)[0]
 =

         with self.assertRaises(iwd.NotSupportedEx):
-            dev.start_ap('TestAP2', 'Password2')
+            dev.start_ap('TestAP2')
 =

     @classmethod
     def setUpClass(cls):
-        pass
+        IWD.copy_to_ap('TestAP2.ap')
 =

     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testAP-no-support/hw.conf b/autotests/testAP-no-supp=
ort/hw.conf
index 9df3b349..93177bb6 100644
--- a/autotests/testAP-no-support/hw.conf
+++ b/autotests/testAP-no-support/hw.conf
@@ -1,6 +1,6 @@
 [SETUP]
 num_radios=3D1
-radio_confs=3Drad0
+start_iwd=3D0
 =

 [rad0]
 iftype_disable=3Dap
diff --git a/autotests/testAP/TestAP2.ap b/autotests/testAP/TestAP2.ap
new file mode 100644
index 00000000..27f086cb
--- /dev/null
+++ b/autotests/testAP/TestAP2.ap
@@ -0,0 +1,2 @@
+[Security]
+Passphrase=3DPassword2
diff --git a/autotests/testAP/connection_test.py b/autotests/testAP/connect=
ion_test.py
index c3744c55..814ed070 100644
--- a/autotests/testAP/connection_test.py
+++ b/autotests/testAP/connection_test.py
@@ -38,13 +38,13 @@ class Test(unittest.TestCase):
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
 =

     def test_connection_success(self):
-        wd =3D IWD()
+        wd =3D IWD(True)
 =

         dev1, dev2 =3D wd.list_devices(2)
 =

         self.client_connect(wd, dev1)
 =

-        dev1.start_ap('TestAP2', 'Password2')
+        dev1.start_ap('TestAP2')
 =

         try:
             condition =3D 'not obj.scanning'
@@ -96,6 +96,7 @@ class Test(unittest.TestCase):
     @classmethod
     def setUpClass(cls):
         IWD.copy_to_storage('TestAP1.psk')
+        IWD.copy_to_ap('TestAP2.ap')
 =

     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testAP/failure_test.py b/autotests/testAP/failure_te=
st.py
index 4959802f..7c3290b0 100644
--- a/autotests/testAP/failure_test.py
+++ b/autotests/testAP/failure_test.py
@@ -39,13 +39,13 @@ class Test(unittest.TestCase):
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
 =

     def test_connection_failure(self):
-        wd =3D IWD()
+        wd =3D IWD(True)
 =

         dev1, dev2 =3D wd.list_devices(2)
 =

         self.client_connect(wd, dev1)
 =

-        dev1.start_ap('TestAP2', 'Password2')
+        dev1.start_ap('TestAP2')
 =

         try:
             condition =3D 'not obj.scanning'
@@ -77,6 +77,7 @@ class Test(unittest.TestCase):
     @classmethod
     def setUpClass(cls):
         IWD.copy_to_storage('TestAP1.psk')
+        IWD.copy_to_ap('TestAP2.ap')
 =

     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testAP/hw.conf b/autotests/testAP/hw.conf
index 96a2bbb1..6b8b2aeb 100644
--- a/autotests/testAP/hw.conf
+++ b/autotests/testAP/hw.conf
@@ -1,7 +1,6 @@
 [SETUP]
 num_radios=3D3
-max_test_exec_interval_sec=3D40
-tmpfs_extra_stuff=3Dmain.conf
+start_iwd=3D0
 =

 [HOSTAPD]
 rad0=3Dpsk-ccmp.conf
-- =

2.26.2

--===============5499847693770114872==--

