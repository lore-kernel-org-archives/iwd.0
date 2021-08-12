Content-Type: multipart/mixed; boundary="===============8618667566910546546=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 05/18] auto-t: testutil.py: add expect_fail flag
Date: Thu, 12 Aug 2021 13:21:54 -0700
Message-ID: <20210812202207.737053-5-prestwoj@gmail.com>
In-Reply-To: <20210812202207.737053-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8618667566910546546==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Several tests tests for connectivity with the expectation that it
will fail. This ends up taking 30+ seconds because testutil retries
3 times, each with a 10 second timeout. By passing expect_fail=3DTrue
this lowers the timeout to zero, and skips any retries.
---
 autotests/util/testutil.py | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/autotests/util/testutil.py b/autotests/util/testutil.py
index c649b387..ea705bad 100644
--- a/autotests/util/testutil.py
+++ b/autotests/util/testutil.py
@@ -51,7 +51,12 @@ def tx(fromsock, tosock, src, dst):
 =

     return (frame, fromsock, tosock, src, dst)
 =

-def test_connected(if0=3DNone, if1=3DNone, group=3DTrue):
+def test_connected(if0=3DNone, if1=3DNone, group=3DTrue, expect_fail=3DFal=
se):
+    if expect_fail:
+        timeout =3D 0
+    else:
+        timeout =3D 10
+
     if if0 is None or if1 is None:
         iwd_list =3D [dev.name for dev in iwd.IWD.get_instance().list_devi=
ces()]
 =

@@ -82,7 +87,7 @@ def test_connected(if0=3DNone, if1=3DNone, group=3DTrue):
             rec.append(False)
 =

         while not all(rec):
-            r, w, x =3D select.select([sock0, sock1], [], [], 10)
+            r, w, x =3D select.select([sock0, sock1], [], [], timeout)
             if not r:
                 raise Exception('timeout waiting for packets: ' + repr(rec=
))
 =

@@ -110,15 +115,15 @@ def test_connected(if0=3DNone, if1=3DNone, group=3DTr=
ue):
         sock0.close()
         sock1.close()
 =

-def test_ifaces_connected(if0=3DNone, if1=3DNone, group=3DTrue):
+def test_ifaces_connected(if0=3DNone, if1=3DNone, group=3DTrue, expect_fai=
l=3DFalse):
     retry =3D 0
     while True:
         try:
-            test_connected(if0, if1, group)
+            test_connected(if0, if1, group, expect_fail)
             break
 =

         except Exception as e:
-            if retry < 3:
+            if retry < 3 and not expect_fail:
                 print('retrying connection test: %i' % retry)
                 retry +=3D 1
                 continue
-- =

2.31.1

--===============8618667566910546546==--

