Content-Type: multipart/mixed; boundary="===============3535358778944879091=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/9] auto-t: add storage dir to IWD() constructor
Date: Thu, 10 Dec 2020 09:45:20 -0800
Message-ID: <20201210174525.874021-4-prestwoj@gmail.com>
In-Reply-To: <20201210174525.874021-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3535358778944879091==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add support for setting a custom storage directory.
---
 autotests/util/iwd.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index bb4ecefa..844bb0db 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -943,7 +943,8 @@ class IWD(AsyncOpAbstract):
     _default_instance =3D None
     psk_agent =3D None
 =

-    def __init__(self, start_iwd_daemon =3D False, iwd_config_dir =3D '/tm=
p', namespace=3Dctx):
+    def __init__(self, start_iwd_daemon =3D False, iwd_config_dir =3D '/tm=
p',
+                            iwd_storage_dir =3D '/tmp/iwd', namespace=3Dct=
x):
         self.namespace =3D namespace
         self._bus =3D namespace.get_bus()
 =

@@ -951,7 +952,8 @@ class IWD(AsyncOpAbstract):
             if self.namespace.is_process_running('iwd'):
                 raise Exception("IWD requested to start but is already run=
ning")
 =

-            self._iwd_proc =3D self.namespace.start_iwd(iwd_config_dir)
+            self._iwd_proc =3D self.namespace.start_iwd(iwd_config_dir,
+                                                        iwd_storage_dir)
 =

         tries =3D 0
         while not self._bus.name_has_owner(IWD_SERVICE):
-- =

2.26.2

--===============3535358778944879091==--

