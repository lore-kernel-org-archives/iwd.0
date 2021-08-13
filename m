Content-Type: multipart/mixed; boundary="===============0045638507400200369=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/6] auto-t: ead.py: remove wait_for_object_condition
Date: Fri, 13 Aug 2021 13:26:10 -0700
Message-ID: <20210813202612.809470-4-prestwoj@gmail.com>
In-Reply-To: <20210813202612.809470-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0045638507400200369==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead the class method IWD._wait_for_object_condition can
be used.
---
 autotests/testEAD/connection_test.py |  4 ++--
 autotests/util/ead.py                | 19 -------------------
 2 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/autotests/testEAD/connection_test.py b/autotests/testEAD/conne=
ction_test.py
index 7f23f0d6..a858831d 100644
--- a/autotests/testEAD/connection_test.py
+++ b/autotests/testEAD/connection_test.py
@@ -22,10 +22,10 @@ class Test(unittest.TestCase):
         adapter =3D ead.list_adapters(1)[0]
 =

         condition =3D 'obj.connected =3D=3D True'
-        ead.wait_for_object_condition(adapter, condition)
+        IWD._wait_for_object_condition(adapter, condition)
 =

         condition =3D 'obj.authenticated =3D=3D True'
-        ead.wait_for_object_condition(adapter, condition)
+        IWD._wait_for_object_condition(adapter, condition)
 =

         ctx.stop_process(p)
     @classmethod
diff --git a/autotests/util/ead.py b/autotests/util/ead.py
index 8f333a8a..06716914 100644
--- a/autotests/util/ead.py
+++ b/autotests/util/ead.py
@@ -103,22 +103,3 @@ class EAD(iwd.AsyncOpAbstract):
                             exception=3DTimeoutError('EAD has no associate=
d devices'))
 =

         return list(self._adapters.values())
-
-    def wait_for_object_condition(self, obj, condition_str, max_wait =3D 5=
0):
-        self._wait_timed_out =3D False
-        def wait_timeout_cb():
-            self._wait_timed_out =3D True
-            return False
-
-        try:
-            timeout =3D GLib.timeout_add_seconds(max_wait, wait_timeout_cb)
-            context =3D ctx.mainloop.get_context()
-            while not eval(condition_str):
-                context.iteration(may_block=3DTrue)
-                if self._wait_timed_out and ctx.args.gdb =3D=3D None:
-                    raise TimeoutError('[' + condition_str + ']'\
-                                       ' condition was not met in '\
-                                       + str(max_wait) + ' sec')
-        finally:
-            if not self._wait_timed_out:
-                GLib.source_remove(timeout)
-- =

2.31.1

--===============0045638507400200369==--

