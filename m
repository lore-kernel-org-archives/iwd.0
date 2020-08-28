Content-Type: multipart/mixed; boundary="===============6019228796461068065=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 06/15] auto-t: iwd.py: update to work with test-runner
 rewrite
Date: Fri, 28 Aug 2020 11:47:30 -0700
Message-ID: <20200828184739.8616-7-prestwoj@gmail.com>
In-Reply-To: <20200828184739.8616-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6019228796461068065==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The class initializer was changed to make starting IWD on by default.
This allows us to not have multiple places where IWD is started. You
can still pass False which will initialize the class but not start
IWD itself. The configuration director was also chaged to /tmp by
default. This was done by all tests requiring main.conf anyways, so
we might as well make it the default.
---
 autotests/util/iwd.py | 48 ++++++++++++++-----------------------------
 1 file changed, 15 insertions(+), 33 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index ef1ea80e..37daaeef 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -15,7 +15,7 @@ import weakref
 from abc import ABCMeta, abstractmethod
 from enum import Enum
 =

-import wiphy
+from config import ctx
 =

 IWD_STORAGE_DIR =3D               '/var/lib/iwd'
 IWD_CONFIG_DIR =3D                '/etc/iwd'
@@ -873,7 +873,10 @@ class DeviceList(collections.Mapping):
 =

 =

 class IWD(AsyncOpAbstract):
-    ''''''
+    '''
+        Start an IWD instance. By default IWD will be started and with the
+        config directory set to /tmp.
+    '''
     _bus =3D dbus.SystemBus()
 =

     _object_manager_if =3D None
@@ -882,40 +885,22 @@ class IWD(AsyncOpAbstract):
     _devices =3D None
     _instance =3D None
 =

-    def __init__(self, start_iwd_daemon =3D False,
-                                               iwd_config_dir =3D IWD_CONF=
IG_DIR):
+    def __init__(self, start_iwd_daemon =3D True, iwd_config_dir =3D '/tmp=
'):
         global mainloop
         mainloop =3D GLib.MainLoop()
 =

-        if start_iwd_daemon:
-            args =3D []
-            iwd_wiphys =3D [wname for wname, wiphy in wiphy.wiphy_map.item=
s()
-                          if wiphy.use =3D=3D 'iwd']
-            whitelist =3D ','.join(iwd_wiphys)
-
-            if os.environ.get('IWD_TEST_VALGRIND', None) =3D=3D 'on':
-                    args.append('valgrind')
-                    args.append('--leak-check=3Dfull')
-                    args.append('--log-file=3D/tmp/valgrind.log')
-
-            os.environ["CONFIGURATION_DIRECTORY"] =3D iwd_config_dir;
-
-            args.append('iwd')
-            args.append('-p')
-            args.append(whitelist)
-            args.append('-d')
-
-            import subprocess
-            iwd_proc =3D subprocess.Popen(args)
+        self._iwd_proc =3D None
 =

-            self._iwd_proc =3D iwd_proc
+        if start_iwd_daemon:
+            self._iwd_proc =3D ctx.start_iwd(iwd_config_dir)
 =

         tries =3D 0
         while not self._bus.name_has_owner(IWD_SERVICE):
-            if os.environ['IWD_TEST_TIMEOUTS'] =3D=3D 'on':
+            if ctx.args.gdb =3D=3D 'None':
                 if tries > 100:
                     if start_iwd_daemon:
-                        iwd_proc.terminate()
+                        self._iwd_proc.kill()
+                        self._iwd_proc =3D None
                     raise TimeoutError('IWD has failed to start')
                 tries +=3D 1
             time.sleep(0.1)
@@ -935,12 +920,9 @@ class IWD(AsyncOpAbstract):
         self._known_networks =3D None
         self._devices =3D None
 =

-        self._iwd_proc.terminate()
-        self._iwd_proc.wait()
-
-        self._iwd_proc =3D None
-
-        del os.environ["CONFIGURATION_DIRECTORY"]
+        if self._iwd_proc is not None:
+            self._iwd_proc.kill()
+            self._iwd_proc =3D None
 =

     @property
     def _object_manager(self):
-- =

2.21.1

--===============6019228796461068065==--

