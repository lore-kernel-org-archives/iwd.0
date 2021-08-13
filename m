Content-Type: multipart/mixed; boundary="===============2071054071544238889=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/6] auto-t: iwd.py: use non_block_wait
Date: Fri, 13 Aug 2021 09:24:38 -0700
Message-ID: <20210813162440.793847-4-prestwoj@gmail.com>
In-Reply-To: <20210813162440.793847-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2071054071544238889==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/iwd.py | 111 ++++++++++--------------------------------
 1 file changed, 25 insertions(+), 86 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 18840cd6..11c37039 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -109,9 +109,7 @@ class AsyncOpAbstract(object):
         self._exception =3D _convert_dbus_ex(ex)
 =

     def _wait_for_async_op(self):
-        context =3D ctx.mainloop.get_context()
-        while not self._is_completed:
-            context.iteration(may_block=3DTrue)
+        ctx.non_block_wait(lambda s: s._is_completed, 30, self, exception=
=3DNone)
 =

         self._is_completed =3D False
         if self._exception is not None:
@@ -1030,16 +1028,8 @@ class IWD(AsyncOpAbstract):
             self._iwd_proc =3D self.namespace.start_iwd(iwd_config_dir,
                                                         iwd_storage_dir)
 =

-        tries =3D 0
-        while not self._bus.name_has_owner(IWD_SERVICE):
-            if not ctx.args.gdb:
-                if tries > 200:
-                    if start_iwd_daemon:
-                        self.namespace.stop_process(self._iwd_proc)
-                        self._iwd_proc =3D None
-                    raise TimeoutError('IWD has failed to start')
-                tries +=3D 1
-            time.sleep(0.1)
+        ctx.non_block_wait(self._bus.name_has_owner, 20, IWD_SERVICE,
+                                exception=3DTimeoutError('IWD has failed t=
o start'))
 =

         self._devices =3D DeviceList(self)
 =

@@ -1085,27 +1075,13 @@ class IWD(AsyncOpAbstract):
 =

     @staticmethod
     def _wait_for_object_condition(obj, condition_str, max_wait =3D 50):
-        class TimeoutData:
-            _wait_timed_out =3D False
+        def _eval_wrap(obj, condition_str):
+            return eval(condition_str)
 =

-        data =3D TimeoutData()
-
-        def wait_timeout_cb(data):
-            data._wait_timed_out =3D True
-            return False
-
-        try:
-            timeout =3D GLib.timeout_add_seconds(max_wait, wait_timeout_cb=
, data)
-            context =3D ctx.mainloop.get_context()
-            while not eval(condition_str):
-                context.iteration(may_block=3DTrue)
-                if data._wait_timed_out and ctx.args.gdb =3D=3D None:
-                    raise TimeoutError('[' + condition_str + ']'\
-                                       ' condition was not met in '\
-                                       + str(max_wait) + ' sec')
-        finally:
-            if not data._wait_timed_out:
-                GLib.source_remove(timeout)
+        ctx.non_block_wait(_eval_wrap, max_wait, obj, condition_str,
+                            exception=3DTimeoutError('[' + condition_str +=
 ']'\
+                                                   ' condition was not met=
 in '\
+                                                   + str(max_wait) + ' sec=
'))
 =

     def wait_for_object_condition(self, *args, **kwargs):
         self._wait_for_object_condition(*args, **kwargs)
@@ -1119,54 +1095,30 @@ class IWD(AsyncOpAbstract):
             This allows an object to be checked for a state transition wit=
hout any
             intermediate state changes.
         '''
-        self._wait_timed_out =3D False
+        def _eval_from_to(obj, from_str, to_str):
+            # If neither the initial or expected condition evaluate the
+            # object must be in another unexpected state.
+            if not eval(from_str) and not eval(to_str):
+                raise Exception('unexpected condition between [%s] and [%s=
]' %
+                                        (from_str, to_str))
+
+            # Initial condition does not evaluate but expected does, pass
+            if not eval(from_str) and eval(to_str):
+                return True
 =

-        def wait_timeout_cb():
-            self._wait_timed_out =3D True
             return False
 =

         # Does initial condition pass?
         if not eval(from_str):
             raise Exception("initial condition [%s] not met" % from_str)
 =

-        try:
-            timeout =3D GLib.timeout_add_seconds(max_wait, wait_timeout_cb)
-            context =3D ctx.mainloop.get_context()
-            while True:
-                context.iteration(may_block=3DTrue)
-
-                # If neither the initial or expected condition evaluate the
-                # object must be in another unexpected state.
-                if not eval(from_str) and not eval(to_str):
-                    raise Exception('unexpected condition between [%s] and=
 [%s]' %
-                                        (from_str, to_str))
-
-                # Initial condition does not evaluate but expected does, p=
ass
-                if not eval(from_str) and eval(to_str):
-                    break
-
-                if self._wait_timed_out and ctx.args.gdb =3D=3D None:
-                    raise TimeoutError('[' + to_str + ']'\
+        ctx.non_block_wait(_eval_from_to, max_wait, obj, from_str, to_str,
+                            exception=3DTimeoutError('[' + to_str + ']'\
                                        ' condition was not met in '\
-                                       + str(max_wait) + ' sec')
-        finally:
-            if not self._wait_timed_out:
-                GLib.source_remove(timeout)
+                                       + str(max_wait) + ' sec'))
 =

     def wait(self, time):
-        self._wait_timed_out =3D False
-        def wait_timeout_cb():
-            self._wait_timed_out =3D True
-            return False
-
-        try:
-            timeout =3D GLib.timeout_add(int(time * 1000), wait_timeout_cb)
-            context =3D ctx.mainloop.get_context()
-            while not self._wait_timed_out:
-                context.iteration(may_block=3DTrue)
-        finally:
-            if not self._wait_timed_out:
-                GLib.source_remove(timeout)
+        ctx.non_block_wait(lambda : False, time, exception=3DFalse)
 =

     @staticmethod
     def clear_storage(storage_dir=3DIWD_STORAGE_DIR):
@@ -1211,21 +1163,8 @@ class IWD(AsyncOpAbstract):
         if not wait_to_appear:
             return list(self._devices.values() if not p2p else self._devic=
es.p2p_dict.values())
 =

-        self._wait_timed_out =3D False
-        def wait_timeout_cb():
-            self._wait_timed_out =3D True
-            return False
-
-        try:
-            timeout =3D GLib.timeout_add_seconds(max_wait, wait_timeout_cb)
-            context =3D ctx.mainloop.get_context()
-            while len(self._devices) < wait_to_appear:
-                context.iteration(may_block=3DTrue)
-                if self._wait_timed_out:
-                    raise TimeoutError('IWD has no associated devices')
-        finally:
-            if not self._wait_timed_out:
-                GLib.source_remove(timeout)
+        ctx.non_block_wait(lambda s, n: len(s._devices) >=3D n, max_wait, =
self, wait_to_appear,
+                            exception=3DTimeoutError('IWD has no associate=
d devices'))
 =

         return list(self._devices.values() if not p2p else self._devices.p=
2p_dict.values())[:wait_to_appear]
 =

-- =

2.31.1

--===============2071054071544238889==--

