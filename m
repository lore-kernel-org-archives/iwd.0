Content-Type: multipart/mixed; boundary="===============3921338702960134481=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/6] auto-t: ead.py: use non_block_wait
Date: Fri, 13 Aug 2021 09:24:40 -0700
Message-ID: <20210813162440.793847-6-prestwoj@gmail.com>
In-Reply-To: <20210813162440.793847-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3921338702960134481==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/ead.py | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/autotests/util/ead.py b/autotests/util/ead.py
index 3a613bbe..8f333a8a 100644
--- a/autotests/util/ead.py
+++ b/autotests/util/ead.py
@@ -81,12 +81,8 @@ class EAD(iwd.AsyncOpAbstract):
     _adapters =3D None
 =

     def __init__(self):
-        tries =3D 0
-        while not self._bus.name_has_owner(EAD_SERVICE):
-            if tries > 200:
-                raise TimeoutError('IWD has failed to start')
-            tries +=3D 1
-            time.sleep(0.1)
+        ctx.non_block_wait(self._bus.name_has_owner, 20, EAD_SERVICE,
+                            exception=3DTimeoutError('EAD has failed to st=
art'))
 =

         self._adapters =3D AdapterList(self)
 =

@@ -103,21 +99,8 @@ class EAD(iwd.AsyncOpAbstract):
         if not wait_to_appear:
             return list(self._adapters.values())
 =

-        self._wait_timed_out =3D False
-        def wait_timeout_cb():
-            self._wait_timed_out =3D True
-            return False
-
-        try:
-            timeout =3D GLib.timeout_add_seconds(max_wait, wait_timeout_cb)
-            context =3D ctx.mainloop.get_context()
-            while len(self._adapters) < wait_to_appear:
-                context.iteration(may_block=3DTrue)
-                if self._wait_timed_out:
-                    raise TimeoutError('IWD has no associated devices')
-        finally:
-            if not self._wait_timed_out:
-                GLib.source_remove(timeout)
+        ctx.non_block_wait(lambda s, num : len(s._adapters) >=3D num, max_=
wait, self, wait_to_appear,
+                            exception=3DTimeoutError('EAD has no associate=
d devices'))
 =

         return list(self._adapters.values())
 =

-- =

2.31.1

--===============3921338702960134481==--

