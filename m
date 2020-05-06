Content-Type: multipart/mixed; boundary="===============7671084991457236937=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] auto-t: remove scanning wait from testConnectAutoconnect
Date: Wed, 06 May 2020 08:58:06 -0700
Message-ID: <20200506155807.4434-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7671084991457236937==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In certain cases the test was reaching this point once already finished
with a scan. This caused the wait for 'scanning' to time out. At this point
in the test we don't need to wait for scanning and only need to wait for
scanning to finish. If scanning is already finished before validation we
can simply validate at that time.
---
 autotests/testConnectAutoconnect/validation.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/autotests/testConnectAutoconnect/validation.py b/autotests/tes=
tConnectAutoconnect/validation.py
index 43cbaf02..b1e3accc 100644
--- a/autotests/testConnectAutoconnect/validation.py
+++ b/autotests/testConnectAutoconnect/validation.py
@@ -54,9 +54,6 @@ class TestConnectAutoConnect(unittest.TestCase):
         self.assertIsNotNone(devices)
         device =3D devices[0]
 =

-        condition =3D 'obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
         condition =3D 'not obj.scanning'
         wd.wait_for_object_condition(device, condition)
 =

-- =

2.21.1

--===============7671084991457236937==--

