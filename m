Content-Type: multipart/mixed; boundary="===============4344384648766919219=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/6] auto-t: cleanup dhcpd.leases[~] in testNetconfig
Date: Fri, 13 Aug 2021 13:26:09 -0700
Message-ID: <20210813202612.809470-3-prestwoj@gmail.com>
In-Reply-To: <20210813202612.809470-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4344384648766919219==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testNetconfig/connection_test.py | 10 ++++++++--
 autotests/testNetconfig/static_test.py     | 10 ++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/autotests/testNetconfig/connection_test.py b/autotests/testNet=
config/connection_test.py
index 43dab243..99fe734c 100644
--- a/autotests/testNetconfig/connection_test.py
+++ b/autotests/testNetconfig/connection_test.py
@@ -48,6 +48,13 @@ class Test(unittest.TestCase):
 =

     @classmethod
     def setUpClass(cls):
+        def remove_lease():
+            try:
+                os.remove('/tmp/dhcpd.leases')
+                os.remove('/tmp/dhcpd.leases~')
+            except:
+                pass
+
         hapd =3D HostapdCLI()
         # TODO: This could be moved into test-runner itself if other tests=
 ever
         #       require this functionality (p2p, FILS, etc.). Since its si=
mple
@@ -57,14 +64,13 @@ class Test(unittest.TestCase):
         ctx.start_process(['touch', '/tmp/dhcpd.leases'], wait=3DTrue)
         cls.dhcpd_pid =3D ctx.start_process(['dhcpd', '-f', '-cf', '/tmp/d=
hcpd.conf',
                                             '-lf', '/tmp/dhcpd.leases',
-                                            hapd.ifname])
+                                            hapd.ifname], cleanup=3Dremove=
_lease)
 =

     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
         ctx.stop_process(cls.dhcpd_pid)
         cls.dhcpd_pid =3D None
-        os.remove('/tmp/dhcpd.leases')
 =

 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
diff --git a/autotests/testNetconfig/static_test.py b/autotests/testNetconf=
ig/static_test.py
index 7d908423..21384a7b 100644
--- a/autotests/testNetconfig/static_test.py
+++ b/autotests/testNetconfig/static_test.py
@@ -75,6 +75,13 @@ class Test(unittest.TestCase):
 =

     @classmethod
     def setUpClass(cls):
+        def remove_lease():
+            try:
+                os.remove('/tmp/dhcpd.leases')
+                os.remove('/tmp/dhcpd.leases~')
+            except:
+                pass
+
         hapd =3D HostapdCLI()
         # TODO: This could be moved into test-runner itself if other tests=
 ever
         #       require this functionality (p2p, FILS, etc.). Since its si=
mple
@@ -84,14 +91,13 @@ class Test(unittest.TestCase):
         ctx.start_process(['touch', '/tmp/dhcpd.leases'], wait=3DTrue)
         cls.dhcpd_pid =3D ctx.start_process(['dhcpd', '-f', '-cf', '/tmp/d=
hcpd.conf',
                                             '-lf', '/tmp/dhcpd.leases',
-                                            hapd.ifname])
+                                            hapd.ifname], cleanup=3Dremove=
_lease)
         IWD.copy_to_storage('ssidTKIP.psk', '/tmp/storage')
 =

     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
         cls.dhcpd_pid.kill()
-        os.system('rm -rf /tmp/dhcpd.leases')
 =

 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
-- =

2.31.1

--===============4344384648766919219==--

