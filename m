Content-Type: multipart/mixed; boundary="===============7355631036440066070=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 04/17] auto-t: testNetconfig stop dhcpd correctly
Date: Thu, 25 Feb 2021 14:00:53 -0800
Message-ID: <20210225220106.1728411-4-prestwoj@gmail.com>
In-Reply-To: <20210225220106.1728411-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7355631036440066070==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use stop_process instead of kill as this removes the process
from the test context.
---
 autotests/testNetconfig/connection_test.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/autotests/testNetconfig/connection_test.py b/autotests/testNet=
config/connection_test.py
index caab090c..fad0e82b 100644
--- a/autotests/testNetconfig/connection_test.py
+++ b/autotests/testNetconfig/connection_test.py
@@ -70,8 +70,9 @@ class Test(unittest.TestCase):
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
-        cls.dhcpd_pid.kill()
-        os.system('rm -rf /tmp/dhcpd.leases')
+        ctx.stop_process(cls.dhcpd_pid)
+        cls.dhcpd_pid =3D None
+        os.remove('/tmp/dhcpd.leases')
 =

 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
-- =

2.26.2

--===============7355631036440066070==--

