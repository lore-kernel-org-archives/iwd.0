Content-Type: multipart/mixed; boundary="===============2610023955464886409=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 01/10] auto-t: update wpas.py to use non_block_wait
Date: Tue, 11 Jan 2022 16:55:49 -0800
Message-ID: <20220112005558.1158405-1-prestwoj@gmail.com>

--===============2610023955464886409==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This should be used as a replacement for the common GLib
wait loop (internally this is all it does).
---
 autotests/util/wpas.py | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/autotests/util/wpas.py b/autotests/util/wpas.py
index c26f116c..0caa947f 100644
--- a/autotests/util/wpas.py
+++ b/autotests/util/wpas.py
@@ -58,29 +58,20 @@ class Wpas:
         f.close()
         return dict([[v.strip() for v in kv] for kv in [l.split('#', 1)[0]=
.split('=3D', 1) for l in lines] if len(kv) =3D=3D 2])
 =

-    def wait_for_event(self, event, timeout=3D10):
-        self._wait_timed_out =3D False
-
-        def wait_timeout_cb():
-            self._wait_timed_out =3D True
-            return False
-
-        timeout =3D GLib.timeout_add_seconds(timeout, wait_timeout_cb)
-        context =3D ctx.mainloop.get_context()
+    def _check_event(self, event):
+        if not event and len(self._rx_data) >=3D 1:
+            print("returning %s" % self._rx_data[0])
+            return self._rx_data[0]
 =

-        while True:
-            context.iteration(may_block=3DTrue)
+        for e in self._rx_data:
+            if event in e:
+                return self._rx_data
 =

-            if not event and len(self._rx_data) >=3D 1:
-                return self._rx_data[0]
+        return False
 =

-            for e in self._rx_data:
-                if event in e:
-                    GLib.source_remove(timeout)
-                    return self._rx_data
-
-            if self._wait_timed_out:
-                raise TimeoutError('waiting for wpas event timed out')
+    def wait_for_event(self, event, timeout=3D10):
+        self._rx_data =3D []
+        return ctx.non_block_wait(self._check_event, timeout, event)
 =

     def wait_for_result(self, timeout=3D10):
         self._rx_data =3D []
-- =

2.31.1

--===============2610023955464886409==--

