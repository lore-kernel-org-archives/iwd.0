Content-Type: multipart/mixed; boundary="===============2682723430505844012=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 06/26] auto-t: iwd.py: update to work with test-runner
 rewrite
Date: Thu, 10 Sep 2020 11:58:35 -0700
Message-ID: <20200910185855.27833-6-prestwoj@gmail.com>
In-Reply-To: <20200910185855.27833-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2682723430505844012==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

iwd.py was updated to use the TestContext APIs to start/stop
IWD. This makes the process managment consistent between starting
IWD from test-runner or from the IWD() constructor.

The psk agent is now tracked, and destroyed upon __del__. This is
to fix issues where a test throws an exception and never
unregisters the agent, causing future tests to fail.

The configuration directory was also chaged to /tmp by
default. This was done since all tests which used this used /tmp
anyways.

The GLib mainloop was removed, and instead put into test-runner
itself. Now any mainloop operations can use ctx.mainloop instead
---
 autotests/util/iwd.py | 123 +++++++++++++++++++-----------------------
 1 file changed, 56 insertions(+), 67 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index ef1ea80e..2041e2d6 100755
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
@@ -39,10 +39,6 @@ IWD_STATION_INTERFACE =3D         'net.connman.iwd.Stati=
on'
 IWD_AGENT_MANAGER_PATH =3D        '/net/connman/iwd'
 IWD_TOP_LEVEL_PATH =3D            '/'
 =

-
-dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
-
-
 class UnknownDBusEx(Exception): pass
 class InProgressEx(dbus.DBusException): pass
 class FailedEx(dbus.DBusException): pass
@@ -108,7 +104,7 @@ class AsyncOpAbstract(object):
         self._exception =3D _convert_dbus_ex(ex)
 =

     def _wait_for_async_op(self):
-        context =3D mainloop.get_context()
+        context =3D ctx.mainloop.get_context()
         while not self._is_completed:
             context.iteration(may_block=3DTrue)
 =

@@ -533,8 +529,8 @@ class Device(IWDDBusAbstract):
             if addr not in props['ConnectedPeers']:
                 return
 =

-        GLib.timeout_add(int(30 * 1000), wait_timeout_cb)
-        context =3D mainloop.get_context()
+        GLib.timeout_add(int(50 * 1000), wait_timeout_cb)
+        context =3D ctx.mainloop.get_context()
         while not self._adhoc_prop_found:
             context.iteration(may_block=3DTrue)
             if self._adhoc_timed_out:
@@ -561,8 +557,8 @@ class Device(IWDDBusAbstract):
             if addr in props['ConnectedPeers']:
                 return
 =

-        GLib.timeout_add(int(15 * 1000), wait_timeout_cb)
-        context =3D mainloop.get_context()
+        GLib.timeout_add(int(50 * 1000), wait_timeout_cb)
+        context =3D ctx.mainloop.get_context()
         while not self._adhoc_prop_found:
             context.iteration(may_block=3DTrue)
             if self._adhoc_timed_out:
@@ -873,7 +869,11 @@ class DeviceList(collections.Mapping):
 =

 =

 class IWD(AsyncOpAbstract):
-    ''''''
+    '''
+        Start an IWD instance. By default IWD should already be running, b=
ut
+        some tests do require starting IWD using this constructor (by pass=
ing
+        start_iwd_daemon=3DTrue)
+    '''
     _bus =3D dbus.SystemBus()
 =

     _object_manager_if =3D None
@@ -881,41 +881,22 @@ class IWD(AsyncOpAbstract):
     _iwd_proc =3D None
     _devices =3D None
     _instance =3D None
+    psk_agent =3D None
 =

-    def __init__(self, start_iwd_daemon =3D False,
-                                               iwd_config_dir =3D IWD_CONF=
IG_DIR):
-        global mainloop
-        mainloop =3D GLib.MainLoop()
+    def __init__(self, start_iwd_daemon =3D False, iwd_config_dir =3D '/tm=
p'):
+        if start_iwd_daemon and ctx.is_process_running('iwd'):
+            raise Exception("IWD requested to start but is already running=
")
 =

         if start_iwd_daemon:
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
-
-            self._iwd_proc =3D iwd_proc
+            self._iwd_proc =3D ctx.start_iwd(iwd_config_dir)
 =

         tries =3D 0
         while not self._bus.name_has_owner(IWD_SERVICE):
-            if os.environ['IWD_TEST_TIMEOUTS'] =3D=3D 'on':
+            if ctx.args.gdb =3D=3D 'None':
                 if tries > 100:
                     if start_iwd_daemon:
-                        iwd_proc.terminate()
+                        ctx.stop_process(self._iwd_proc)
+                        self._iwd_proc =3D None
                     raise TimeoutError('IWD has failed to start')
                 tries +=3D 1
             time.sleep(0.1)
@@ -927,20 +908,17 @@ class IWD(AsyncOpAbstract):
         IWD._instance =3D weakref.ref(self)
 =

     def __del__(self):
-        if self._iwd_proc is None:
-            return
+        if self.psk_agent:
+            self.unregister_psk_agent(self.psk_agent)
 =

         self._object_manager_if =3D None
         self._agent_manager_if =3D None
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
+            ctx.stop_process(self._iwd_proc)
+            self._iwd_proc =3D None
 =

     @property
     def _object_manager(self):
@@ -966,15 +944,18 @@ class IWD(AsyncOpAbstract):
             self._wait_timed_out =3D True
             return False
 =

-        timeout =3D GLib.timeout_add_seconds(max_wait, wait_timeout_cb)
-        context =3D mainloop.get_context()
-        while not eval(condition_str):
-            context.iteration(may_block=3DTrue)
-            if self._wait_timed_out and os.environ['IWD_TEST_TIMEOUTS'] =
=3D=3D 'on':
-                raise TimeoutError('[' + condition_str + ']'\
-                                   ' condition was not met in '\
-                                   + str(max_wait) + ' sec')
-        GLib.source_remove(timeout)
+        try:
+            timeout =3D GLib.timeout_add_seconds(max_wait, wait_timeout_cb)
+            context =3D ctx.mainloop.get_context()
+            while not eval(condition_str):
+                context.iteration(may_block=3DTrue)
+                if self._wait_timed_out and ctx.args.gdb =3D=3D None:
+                    raise TimeoutError('[' + condition_str + ']'\
+                                       ' condition was not met in '\
+                                       + str(max_wait) + ' sec')
+        finally:
+            if not self._wait_timed_out:
+                GLib.source_remove(timeout)
 =

     def wait(self, time):
         self._wait_timed_out =3D False
@@ -982,10 +963,14 @@ class IWD(AsyncOpAbstract):
             self._wait_timed_out =3D True
             return False
 =

-        GLib.timeout_add(int(time * 1000), wait_timeout_cb)
-        context =3D mainloop.get_context()
-        while not self._wait_timed_out:
-            context.iteration(may_block=3DTrue)
+        try:
+            timeout =3D GLib.timeout_add(int(time * 1000), wait_timeout_cb)
+            context =3D ctx.mainloop.get_context()
+            while not self._wait_timed_out:
+                context.iteration(may_block=3DTrue)
+        finally:
+            if not self._wait_timed_out:
+                GLib.source_remove(timeout)
 =

     @staticmethod
     def clear_storage():
@@ -1031,14 +1016,16 @@ class IWD(AsyncOpAbstract):
             self._wait_timed_out =3D True
             return False
 =

-        timeout =3D GLib.timeout_add_seconds(max_wait, wait_timeout_cb)
-        context =3D mainloop.get_context()
-        while len(self._devices) < wait_to_appear:
-            context.iteration(may_block=3DTrue)
-            if self._wait_timed_out:
-                raise TimeoutError('IWD has no associated devices')
-
-        GLib.source_remove(timeout)
+        try:
+            timeout =3D GLib.timeout_add_seconds(max_wait, wait_timeout_cb)
+            context =3D ctx.mainloop.get_context()
+            while len(self._devices) < wait_to_appear:
+                context.iteration(may_block=3DTrue)
+                if self._wait_timed_out:
+                    raise TimeoutError('IWD has no associated devices')
+        finally:
+            if not self._wait_timed_out:
+                GLib.source_remove(timeout)
 =

         return list(self._devices.values())
 =

@@ -1062,6 +1049,7 @@ class IWD(AsyncOpAbstract):
                                      reply_handler=3Dself._success,
                                      error_handler=3Dself._failure)
         self._wait_for_async_op()
+        self.psk_agent =3D psk_agent
 =

     def unregister_psk_agent(self, psk_agent):
         self._agent_manager.UnregisterAgent(
@@ -1070,6 +1058,7 @@ class IWD(AsyncOpAbstract):
                                      reply_handler=3Dself._success,
                                      error_handler=3Dself._failure)
         self._wait_for_async_op()
+        self.psk_agent =3D None
 =

     @staticmethod
     def get_instance():
-- =

2.21.3

--===============2682723430505844012==--

