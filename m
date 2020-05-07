Content-Type: multipart/mixed; boundary="===============3357989189994513366=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 1/5] auto-t: Remove unnecessary disconnect calls
Date: Thu, 07 May 2020 12:20:19 -0700
Message-ID: <20200507192023.11498-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3357989189994513366==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With the introduction of AutoConnect=3DFalse network setting the
initial disconnect calls are no longer needed
---
 autotests/testAP/failure_test.py | 2 --
 autotests/testAP/test.py         | 2 --
 2 files changed, 4 deletions(-)

diff --git a/autotests/testAP/failure_test.py b/autotests/testAP/failure_te=
st.py
index cad7bf6e..d419c05b 100644
--- a/autotests/testAP/failure_test.py
+++ b/autotests/testAP/failure_test.py
@@ -58,8 +58,6 @@ class Test(unittest.TestCase):
         wd =3D IWD()
 =

         dev1, dev2 =3D wd.list_devices(2)
-        dev1.disconnect()
-        dev2.disconnect()
 =

         self.client_connect(wd, dev1)
 =

diff --git a/autotests/testAP/test.py b/autotests/testAP/test.py
index 39161981..455c9916 100644
--- a/autotests/testAP/test.py
+++ b/autotests/testAP/test.py
@@ -51,8 +51,6 @@ class Test(unittest.TestCase):
         wd =3D IWD()
 =

         dev1, dev2 =3D wd.list_devices(2)
-        dev1.disconnect()
-        dev2.disconnect()
 =

         self.client_connect(wd, dev1)
 =

-- =

2.13.6

--===============3357989189994513366==--

