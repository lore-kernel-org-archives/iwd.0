Content-Type: multipart/mixed; boundary="===============2174045428993200111=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] auto-t: fix wait_for_object_condition
Date: Mon, 25 Jan 2021 10:05:28 -0800
Message-ID: <20210125180528.803024-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2174045428993200111==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After the re-write this was broken and not noticed until
recently. The issue appeared to be that the GLib timeout
callback retained no context of local variables. Previously
_wait_timed_out was set as a class variable, but this was
removed so multiple IWD instances could work. Without
_wait_timed_out being a class variable the GLib timeout
setting it had no effect on the wait loop.

To fix this we can set _wait_timed_out on the object being
passed in. This is preserved in the GLib timeout callback
and setting it gets honored in the wait loop.
---
 autotests/util/iwd.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 9e653575..4fa26517 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -1009,9 +1009,10 @@ class IWD(AsyncOpAbstract):
 =

     @staticmethod
     def _wait_for_object_condition(obj, condition_str, max_wait =3D 50):
-        _wait_timed_out =3D False
+        obj._wait_timed_out =3D False
+
         def wait_timeout_cb():
-            _wait_timed_out =3D True
+            obj._wait_timed_out =3D True
             return False
 =

         try:
@@ -1019,12 +1020,12 @@ class IWD(AsyncOpAbstract):
             context =3D ctx.mainloop.get_context()
             while not eval(condition_str):
                 context.iteration(may_block=3DTrue)
-                if _wait_timed_out and ctx.args.gdb =3D=3D None:
+                if obj._wait_timed_out and ctx.args.gdb =3D=3D None:
                     raise TimeoutError('[' + condition_str + ']'\
                                        ' condition was not met in '\
                                        + str(max_wait) + ' sec')
         finally:
-            if not _wait_timed_out:
+            if not obj._wait_timed_out:
                 GLib.source_remove(timeout)
 =

     def wait_for_object_condition(self, *args, **kwargs):
-- =

2.26.2

--===============2174045428993200111==--

