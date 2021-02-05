Content-Type: multipart/mixed; boundary="===============5018943039069503914=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/2] auto-t: fix wait_for_object_condition to work with any
 object
Date: Thu, 04 Feb 2021 16:06:03 -0800
Message-ID: <20210205000603.241826-2-prestwoj@gmail.com>
In-Reply-To: <20210205000603.241826-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5018943039069503914==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After recent changes fixing wait_for_object_condition it was accidentally
made to only work with classes, not other types of objects. Instead
create a minimal class to hold _wait_timed_out so it doesnt rely on
'obj' holding the boolean.
---
 autotests/util/iwd.py | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 4fa26517..6b153ea7 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -1009,23 +1009,26 @@ class IWD(AsyncOpAbstract):
 =

     @staticmethod
     def _wait_for_object_condition(obj, condition_str, max_wait =3D 50):
-        obj._wait_timed_out =3D False
+        class TimeoutData:
+            _wait_timed_out =3D False
 =

-        def wait_timeout_cb():
-            obj._wait_timed_out =3D True
+        data =3D TimeoutData()
+
+        def wait_timeout_cb(data):
+            data._wait_timed_out =3D True
             return False
 =

         try:
-            timeout =3D GLib.timeout_add_seconds(max_wait, wait_timeout_cb)
+            timeout =3D GLib.timeout_add_seconds(max_wait, wait_timeout_cb=
, data)
             context =3D ctx.mainloop.get_context()
             while not eval(condition_str):
                 context.iteration(may_block=3DTrue)
-                if obj._wait_timed_out and ctx.args.gdb =3D=3D None:
+                if data._wait_timed_out and ctx.args.gdb =3D=3D None:
                     raise TimeoutError('[' + condition_str + ']'\
                                        ' condition was not met in '\
                                        + str(max_wait) + ' sec')
         finally:
-            if not obj._wait_timed_out:
+            if not data._wait_timed_out:
                 GLib.source_remove(timeout)
 =

     def wait_for_object_condition(self, *args, **kwargs):
-- =

2.26.2

--===============5018943039069503914==--

