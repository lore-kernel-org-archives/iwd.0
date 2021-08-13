Content-Type: multipart/mixed; boundary="===============2851495185258939531=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/6] auto-t: hostapd.py: use non_block_wait
Date: Fri, 13 Aug 2021 09:24:39 -0700
Message-ID: <20210813162440.793847-5-prestwoj@gmail.com>
In-Reply-To: <20210813162440.793847-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2851495185258939531==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/hostapd.py | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index be6e1143..a61b2d39 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -86,30 +86,19 @@ class HostapdCLI:
     def __init__(self, config=3DNone):
         self._init_hostapd(config)
 =

-    def wait_for_event(self, event, timeout=3D10):
-        global mainloop
-        self._wait_timed_out =3D False
-
-        def wait_timeout_cb():
-            self._wait_timed_out =3D True
+    def _poll_event(self, event):
+        if not self._data_available(0.25):
             return False
 =

-        timeout =3D GLib.timeout_add_seconds(timeout, wait_timeout_cb)
-        context =3D mainloop.get_context()
-
-        while True:
-            context.iteration(may_block=3DFalse)
+        data =3D self.ctrl_sock.recv(4096).decode('utf-8')
+        if event in data:
+            return data
 =

-            while self._data_available(0.25):
-                data =3D self.ctrl_sock.recv(4096).decode('utf-8')
-                if event in data:
-                    GLib.source_remove(timeout)
-                    return data
-
-            if self._wait_timed_out:
-                raise TimeoutError('waiting for hostapd event timed out')
+        return False
 =

-        return None
+    def wait_for_event(self, event, timeout=3D10):
+        return ctx.non_block_wait(self._poll_event, timeout, event,
+                                    exception=3DTimeoutError("waiting for =
event"))
 =

     def _data_available(self, timeout=3D2):
         [r, w, e] =3D select.select([self.ctrl_sock], [], [], timeout)
@@ -123,10 +112,10 @@ class HostapdCLI:
 =

         self.ctrl_sock.send(bytes(command))
 =

-        if self._data_available(timeout):
-            return self.ctrl_sock.recv(4096).decode('utf-8')
+        ctx.non_block_wait(self._data_available, timeout,
+                            exception=3DTimeoutError("waiting for control =
response"))
 =

-        raise Exception('timeout waiting for control response')
+        return self.ctrl_sock.recv(4096).decode('utf-8')
 =

     def _del_hostapd(self, force=3DFalse):
         if not self.ctrl_sock:
-- =

2.31.1

--===============2851495185258939531==--

