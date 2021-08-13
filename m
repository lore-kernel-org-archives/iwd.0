Content-Type: multipart/mixed; boundary="===============8249477788969007751=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/6] auto-t: ofono.py: use non_block_wait
Date: Fri, 13 Aug 2021 09:24:37 -0700
Message-ID: <20210813162440.793847-3-prestwoj@gmail.com>
In-Reply-To: <20210813162440.793847-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8249477788969007751==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/ofono.py | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/autotests/util/ofono.py b/autotests/util/ofono.py
index 584a656a..ea3aad60 100644
--- a/autotests/util/ofono.py
+++ b/autotests/util/ofono.py
@@ -9,13 +9,8 @@ class Ofono(dbus.service.Object):
     def __init__(self, namespace=3Dctx):
         self._bus =3D namespace.get_bus()
 =

-        tries =3D 0
-
-        while not self._bus.name_has_owner('org.ofono'):
-            if tries > 100:
-                raise TimeoutError('Waiting for org.ofono service timed ou=
t')
-            tries +=3D 1
-            time.sleep(0.1)
+        ctx.non_block_wait(self._bus.name_has_owner, 10, 'org.ofono',
+                            exception=3DTimeoutError('Waiting for org.ofon=
o service timed out'))
 =

     def enable_modem(self, path):
         self._modem_path =3D path
@@ -31,7 +26,6 @@ class Ofono(dbus.service.Object):
                 self._sim_auth_up =3D True
 =

     def wait_for_sim_auth(self, max_wait =3D 15):
-        mainloop =3D GLib.MainLoop()
         self._sim_auth_up =3D False
 =

         props =3D self._modem_iface.GetProperties()
@@ -42,18 +36,5 @@ class Ofono(dbus.service.Object):
         self._modem_iface.connect_to_signal('PropertyChanged',
                                              self._modem_prop_changed)
 =

-        self._wait_timed_out =3D False
-        def wait_timeout_cb():
-            self._wait_timed_out =3D True
-            return False
-
-        try:
-            timeout =3D GLib.timeout_add_seconds(max_wait, wait_timeout_cb)
-            context =3D mainloop.get_context()
-            while (not self._sim_auth_up):
-                context.iteration(may_block=3DTrue)
-                if self._wait_timed_out:
-                    raise TimeoutError('waiting for SimAuthentication time=
d out')
-
-        finally:
-            GLib.source_remove(timeout)
+        ctx.non_block_wait(lambda s : s._sim_auth_up, max_wait, self,
+                            exception=3DTimeoutError('waiting for SimAuthe=
tication timed out'))
-- =

2.31.1

--===============8249477788969007751==--

