Content-Type: multipart/mixed; boundary="===============0890148716876203040=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] auto-t: add API wait_for_object_change
Date: Fri, 05 Feb 2021 11:06:36 -0800
Message-ID: <20210205190637.325992-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0890148716876203040==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is similar to wait_for_object_condition, but will not allow
any intermediate state changes between the initial and expected
conditions. This is useful for roaming tests when the expected
state change is 'connected' --> 'roaming' with no changes in
between.
---
 autotests/util/iwd.py | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 6b153ea7..8ea1dfb9 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -1034,6 +1034,48 @@ class IWD(AsyncOpAbstract):
     def wait_for_object_condition(self, *args, **kwargs):
         self._wait_for_object_condition(*args, **kwargs)
 =

+    def wait_for_object_change(self, obj, from_str, to_str, max_wait =3D 5=
0):
+        '''
+            Expects condition 'from_str' to evaluate true while waiting fo=
r 'to_str'. If
+            at any point during the wait 'from_str' evaluates false, an ex=
ception is
+            raised.
+
+            This allows an object to be checked for a state transition wit=
hout any
+            intermediate state changes.
+        '''
+        self._wait_timed_out =3D False
+
+        def wait_timeout_cb():
+            self._wait_timed_out =3D True
+            return False
+
+        # Does initial condition pass?
+        if not eval(from_str):
+            raise Exception("initial condition [%s] not met" % from_str)
+
+        try:
+            timeout =3D GLib.timeout_add_seconds(max_wait, wait_timeout_cb)
+            context =3D ctx.mainloop.get_context()
+            while True:
+                context.iteration(may_block=3DTrue)
+
+                # If neither the initial or expected condition evaluate the
+                # object must be in another unexpected state.
+                if not eval(from_str) and not eval(to_str):
+                    raise Exception('unexpected condition between [%s] and=
 [%s]' % from_str, to_str)
+
+                # Initial condition does not evaluate but expected does, p=
ass
+                if not eval(from_str) and eval(to_str):
+                    break
+
+                if self._wait_timed_out and ctx.args.gdb =3D=3D None:
+                    raise TimeoutError('[' + to_str + ']'\
+                                       ' condition was not met in '\
+                                       + str(max_wait) + ' sec')
+        finally:
+            if not self._wait_timed_out:
+                GLib.source_remove(timeout)
+
     def wait(self, time):
         self._wait_timed_out =3D False
         def wait_timeout_cb():
-- =

2.26.2

--===============0890148716876203040==--

