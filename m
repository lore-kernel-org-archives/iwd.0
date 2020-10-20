Content-Type: multipart/mixed; boundary="===============1095563989736752047=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 01/13] auto-t: no hostapd instance graceful failure
Date: Tue, 20 Oct 2020 11:02:44 -0700
Message-ID: <20201020180256.1630120-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1095563989736752047==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If a test does not need any hostapd instances but still loads
hostapd.py for some reason we want to gracefully throw an
exception rather than fail in some other manor.
---
 autotests/util/hostapd.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index 7c0d8385..cf82c010 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -32,6 +32,10 @@ class HostapdCLI:
     def _init_hostapd(self, config=3DNone):
         global ctrl_count
         interface =3D None
+        self.ctrl_sock =3D None
+
+        if not ctx.hostapd:
+            raise Exception("No hostapd instances are configured")
 =

         if not config and len(ctx.hostapd.instances) > 1:
             raise Exception('config must be provided if more than one host=
apd instance exists')
@@ -110,6 +114,9 @@ class HostapdCLI:
         raise Exception('timeout waiting for control response')
 =

     def _del_hostapd(self, force=3DFalse):
+        if not self.ctrl_sock:
+            return
+
         self.ctrl_sock.close()
         os.remove(self.local_ctrl)
 =

-- =

2.26.2

--===============1095563989736752047==--

