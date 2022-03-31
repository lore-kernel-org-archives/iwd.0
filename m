Content-Type: multipart/mixed; boundary="===============6625909932616438452=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 13/14] auto-t: iwd.py: use IO watch for station debug events
Date: Thu, 31 Mar 2022 16:16:40 -0700
Message-ID: <20220331231641.484200-13-prestwoj@gmail.com>
In-Reply-To: 20220331231641.484200-1-prestwoj@gmail.com

--===============6625909932616438452==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Similarly to hostapd.wait_for_event, IWD's variant needed to act on
an IO watch because events were being received prior to even calling
wait_for_event.
---
 autotests/util/iwd.py | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 253fe25e..a2062258 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -232,16 +232,14 @@ class StationDebug(IWDDBusAbstract):
     _iface_name =3D IWD_STATION_DEBUG_INTERFACE
 =

     def __init__(self, *args, **kwargs):
-        self._last_event =3D None
-        self._last_event_data =3D []
+        self._events =3D []
 =

         IWDDBusAbstract.__init__(self, *args, **kwargs)
 =

         self._iface.connect_to_signal("Event", self._event_handler)
 =

     def _event_handler(self, event, data):
-        self._last_event =3D event
-        self._last_event_data =3D data
+        self._events.insert(0, (event, data))
 =

     @property
     def autoconnect(self):
@@ -257,19 +255,18 @@ class StationDebug(IWDDBusAbstract):
         frequencies =3D dbus.Array([dbus.UInt16(f) for f in frequencies])
         self._iface.Scan(frequencies)
 =

-    def wait_for_event(self, event, timeout=3D10):
-        try:
-            if self._last_event is not None:
-                return self._last_event_data
+    def _poll_event(self, event):
+        for idx, e in enumerate(self._events):
+            if event =3D=3D e[0]:
+                # Consume any older events
+                self._events =3D self._events[:idx]
+                return True
 =

-            ctx.non_block_wait(lambda s, e : s._last_event =3D=3D e, timeo=
ut, self, event,
-                                exception=3DTimeoutError("waiting for Stat=
ionDebug.Event"))
+        return False
 =

-            return self._last_event_data
-        finally:
-            # Consume the event
-            self._last_event_data =3D None
-            self._last_event =3D None
+    def wait_for_event(self, event, timeout=3D10):
+        return ctx.non_block_wait(self._poll_event, timeout, event,
+                                    exception=3DTimeoutError("waiting for =
event"))
 =

 class DeviceProvisioning(IWDDBusAbstract):
     '''
-- =

2.34.1

--===============6625909932616438452==--

