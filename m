Content-Type: multipart/mixed; boundary="===============5206301134058790593=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/8] auto-t: refactor get_instance from iwd.py
Date: Mon, 16 Nov 2020 14:25:08 -0800
Message-ID: <20201116222514.3486808-2-prestwoj@gmail.com>
In-Reply-To: <20201116222514.3486808-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5206301134058790593==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When network namespaces are introduced there may be multiple
IWD class instances. This makes IWD.get_instance ambiguous
when namespaces are involved. iwd.py has been refactored to
not use IWD.get_instance, but testutil still needs it since
its purely based off interface names. Rather than remove it
and modify every test to pass the IWD object we can just
maintain the existing behavior for only the root namespace.
---
 autotests/util/iwd.py | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index d7235f2d..af3ecd05 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -399,14 +399,12 @@ class Device(IWDDBusAbstract):
         elif not scan_if_needed:
             return None
 =

-        iwd =3D IWD.get_instance()
-
         self.scan()
 =

         condition =3D 'obj.scanning'
-        iwd.wait_for_object_condition(self, condition)
+        IWD._wait_for_object_condition(self, condition)
         condition =3D 'not obj.scanning'
-        iwd.wait_for_object_condition(self, condition)
+        IWD._wait_for_object_condition(self, condition)
 =

         for bus_obj in self._station.GetOrderedNetworks():
             ordered_network =3D OrderedNetwork(bus_obj)
@@ -940,7 +938,7 @@ class IWD(AsyncOpAbstract):
     _agent_manager_if =3D None
     _iwd_proc =3D None
     _devices =3D None
-    _instance =3D None
+    _default_instance =3D None
     psk_agent =3D None
 =

     def __init__(self, start_iwd_daemon =3D False, iwd_config_dir =3D '/tm=
p'):
@@ -964,8 +962,11 @@ class IWD(AsyncOpAbstract):
         self._devices =3D DeviceList(self)
 =

         # Weak to make sure the test's reference to @self is the only coun=
ted
-        # reference so that __del__ gets called when it's released
-        IWD._instance =3D weakref.ref(self)
+        # reference so that __del__ gets called when it's released. This i=
s only
+        # done for the root namespace in order to allow testutil to functi=
on
+        # correctly in non-namespace tests.
+        if self.namespace.name =3D=3D "root":
+            IWD._default_instance =3D weakref.ref(self)
 =

     def __del__(self):
         if self.psk_agent:
@@ -998,10 +999,11 @@ class IWD(AsyncOpAbstract):
                                IWD_AGENT_MANAGER_INTERFACE)
         return self._agent_manager_if
 =

-    def wait_for_object_condition(self, obj, condition_str, max_wait =3D 5=
0):
-        self._wait_timed_out =3D False
+    @staticmethod
+    def _wait_for_object_condition(obj, condition_str, max_wait =3D 50):
+        _wait_timed_out =3D False
         def wait_timeout_cb():
-            self._wait_timed_out =3D True
+            _wait_timed_out =3D True
             return False
 =

         try:
@@ -1009,14 +1011,17 @@ class IWD(AsyncOpAbstract):
             context =3D ctx.mainloop.get_context()
             while not eval(condition_str):
                 context.iteration(may_block=3DTrue)
-                if self._wait_timed_out and ctx.args.gdb =3D=3D None:
+                if _wait_timed_out and ctx.args.gdb =3D=3D None:
                     raise TimeoutError('[' + condition_str + ']'\
                                        ' condition was not met in '\
                                        + str(max_wait) + ' sec')
         finally:
-            if not self._wait_timed_out:
+            if not _wait_timed_out:
                 GLib.source_remove(timeout)
 =

+    def wait_for_object_condition(self, *args, **kwargs):
+        self._wait_for_object_condition(*args, **kwargs)
+
     def wait(self, time):
         self._wait_timed_out =3D False
         def wait_timeout_cb():
@@ -1129,4 +1134,4 @@ class IWD(AsyncOpAbstract):
 =

     @staticmethod
     def get_instance():
-        return IWD._instance()
+        return IWD._default_instance()
-- =

2.26.2

--===============5206301134058790593==--

