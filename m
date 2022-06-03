Content-Type: multipart/mixed; boundary="===============6335233071700245900=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/2] auto-t: remove ifconfig call from testScan
Date: Fri, 03 Jun 2022 10:05:53 -0700
Message-ID: <20220603170554.183478-1-prestwoj@gmail.com>

--===============6335233071700245900==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ifconfig isn't available by default in several linux distros
so instead use 'ip' which seems to be much more widespread.
---
 autotests/testScan/remove_iface_test.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/autotests/testScan/remove_iface_test.py b/autotests/testScan/r=
emove_iface_test.py
index af36c1e8..4f9eef93 100644
--- a/autotests/testScan/remove_iface_test.py
+++ b/autotests/testScan/remove_iface_test.py
@@ -18,7 +18,7 @@ class Test(unittest.TestCase):
         device.autoconnect =3D True
         device.scan(wait=3DFalse)
 =

-        os.system('ifconfig %s down' % device.name)
+        os.system('ip link set dev %s down' % device.name)
 =

     @classmethod
     def setUpClass(cls):
-- =

2.34.1

--===============6335233071700245900==--

