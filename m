Content-Type: multipart/mixed; boundary="===============2418892534064417774=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/3] auto-t: iwd.py: add StationDebug.Event support
Date: Fri, 13 Aug 2021 12:47:09 -0700
Message-ID: <20210813194710.807550-2-prestwoj@gmail.com>
In-Reply-To: <20210813194710.807550-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2418892534064417774==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adds a new wait_for_event API which waits for a StationDebug.Event.
---
 autotests/util/iwd.py | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index b5546bcd..36b8f6f9 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -233,9 +233,17 @@ class StationDebug(IWDDBusAbstract):
     def __init__(self, *args, **kwargs):
         self._debug_props =3D None
         self._debug_iface =3D None
+        self._last_event =3D None
+        self._last_event_data =3D []
 =

         IWDDBusAbstract.__init__(self, *args, **kwargs)
 =

+        self._iface.connect_to_signal("Event", self._event_handler)
+
+    def _event_handler(self, event, data):
+        self._last_event =3D event
+        self._last_event_data =3D data
+
     @property
     def autoconnect(self):
         return self._properties['AutoConnect']
@@ -244,6 +252,21 @@ class StationDebug(IWDDBusAbstract):
         frequencies =3D dbus.Array([dbus.UInt16(f) for f in frequencies])
         self._iface.Scan(frequencies)
 =

+    def wait_for_event(self, event, timeout=3D10):
+        try:
+            if self._last_event is not None:
+                return self._last_event_data
+
+            ctx.non_block_wait(lambda s, e : s._last_event =3D=3D e, timeo=
ut, self, event,
+                                exception=3DTimeoutError("waiting for Stat=
ionDebug.Event"))
+
+            return self._last_event_data
+        finally:
+            # Consume the event
+            self._last_event_data =3D None
+            self._last_event =3D None
+
+
 class Device(IWDDBusAbstract):
     '''
         Class represents a network device object: net.connman.iwd.Device
@@ -596,6 +619,12 @@ class Device(IWDDBusAbstract):
 =

         self._station_debug.scan(frequencies)
 =

+    def wait_for_event(self, event, timeout=3D10):
+        if not self._station_debug:
+            self._station_debug =3D StationDebug(self._object_path)
+
+        self._station_debug.wait_for_event(event, timeout)
+
     def __str__(self, prefix =3D ''):
         return prefix + 'Device: ' + self.device_path + '\n'\
                + prefix + '\tName:\t\t' + self.name + '\n'\
-- =

2.31.1

--===============2418892534064417774==--

