Content-Type: multipart/mixed; boundary="===============1492072449813764016=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 07/15] auto-t: iwd.py: fix multiple timeout cleanup issues
Date: Fri, 28 Aug 2020 09:40:42 -0700
Message-ID: <20200828164050.1456-8-prestwoj@gmail.com>
In-Reply-To: <20200828164050.1456-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1492072449813764016==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There were a few more places where the GLib timeout was not being
removed which could cause the IWD object to hang around longer than
expected causing problems for subsequent tests.
---
 autotests/util/iwd.py | 51 +++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 37daaeef..113039b6 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -948,15 +948,18 @@ class IWD(AsyncOpAbstract):
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
+            context =3D mainloop.get_context()
+            while not eval(condition_str):
+                context.iteration(may_block=3DTrue)
+                if self._wait_timed_out and ctx.args.gdb =3D=3D 'None':
+                    raise TimeoutError('[' + condition_str + ']'\
+                                       ' condition was not met in '\
+                                       + str(max_wait) + ' sec')
+        finally:
+            if not self._wait_timed_out:
+                GLib.source_remove(timeout)
 =

     def wait(self, time):
         self._wait_timed_out =3D False
@@ -964,10 +967,14 @@ class IWD(AsyncOpAbstract):
             self._wait_timed_out =3D True
             return False
 =

-        GLib.timeout_add(int(time * 1000), wait_timeout_cb)
-        context =3D mainloop.get_context()
-        while not self._wait_timed_out:
-            context.iteration(may_block=3DTrue)
+        try:
+            timeout =3D GLib.timeout_add(int(time * 1000), wait_timeout_cb)
+            context =3D mainloop.get_context()
+            while not self._wait_timed_out:
+                context.iteration(may_block=3DTrue)
+        finally:
+            if not self._wait_timed_out:
+                GLib.source_remove(timeout)
 =

     @staticmethod
     def clear_storage():
@@ -1013,14 +1020,16 @@ class IWD(AsyncOpAbstract):
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
+            context =3D mainloop.get_context()
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

-- =

2.21.1

--===============1492072449813764016==--

