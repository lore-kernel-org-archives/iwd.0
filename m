Content-Type: multipart/mixed; boundary="===============0222115249415038999=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 05/15] auto-t: ofono.py: fix timeout cleanup and wait for
 service
Date: Fri, 28 Aug 2020 09:40:40 -0700
Message-ID: <20200828164050.1456-6-prestwoj@gmail.com>
In-Reply-To: <20200828164050.1456-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0222115249415038999==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Ofono.py was not cleaning up the timeout, nor waiting for the ofono.org
service to come up before continuing.
---
 autotests/util/ofono.py | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/autotests/util/ofono.py b/autotests/util/ofono.py
index 2bc6338b..f1ed14ee 100644
--- a/autotests/util/ofono.py
+++ b/autotests/util/ofono.py
@@ -1,4 +1,5 @@
 import dbus
+import time
 from gi.repository import GLib
 =

 SIM_AUTH_IFACE =3D 'org.ofono.SimAuthentication'
@@ -7,6 +8,14 @@ class Ofono(dbus.service.Object):
     def __init__(self):
         self._bus =3D dbus.SystemBus()
 =

+        tries =3D 0
+
+        while not self._bus.name_has_owner('org.ofono'):
+            if tries > 100:
+                raise TimeoutError('Waiting for org.ofono service timed ou=
t')
+            tries +=3D 1
+            time.sleep(0.1)
+
     def enable_modem(self, path):
         self._modem_path =3D path
         self._modem_iface =3D dbus.Interface(
@@ -37,11 +46,13 @@ class Ofono(dbus.service.Object):
             self._wait_timed_out =3D True
             return False
 =

-        timeout =3D GLib.timeout_add_seconds(max_wait, wait_timeout_cb)
-        context =3D mainloop.get_context()
-        while (not self._sim_auth_up):
-            context.iteration(may_block=3DTrue)
-            if self._wait_timed_out:
-                raise TimeoutError('waiting for SimAuthentication timed ou=
t')
+        try:
+            timeout =3D GLib.timeout_add_seconds(max_wait, wait_timeout_cb)
+            context =3D mainloop.get_context()
+            while (not self._sim_auth_up):
+                context.iteration(may_block=3DTrue)
+                if self._wait_timed_out:
+                    raise TimeoutError('waiting for SimAuthentication time=
d out')
 =

-        GLib.source_remove(timeout)
+        finally:
+            GLib.source_remove(timeout)
-- =

2.21.1

--===============0222115249415038999==--

