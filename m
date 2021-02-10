Content-Type: multipart/mixed; boundary="===============6867196465684752932=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] test: add a simple signal agent script
Date: Wed, 10 Feb 2021 10:07:59 -0800
Message-ID: <20210210180759.834988-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6867196465684752932==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Creates a signal agent and registers for a few levels.
---
 test/signal-agent | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100755 test/signal-agent

diff --git a/test/signal-agent b/test/signal-agent
new file mode 100755
index 00000000..65f16cfd
--- /dev/null
+++ b/test/signal-agent
@@ -0,0 +1,52 @@
+#!/usr/bin/python3
+
+from gi.repository import GLib
+
+import dbus
+import dbus.service
+import dbus.mainloop.glib
+import sys
+import time
+
+class SignalAgent(dbus.service.Object):
+    def __init__(self):
+        self._bus =3D dbus.SystemBus()
+        self._path =3D '/test/agent/' + str(int(round(time.time() * 1000)))
+
+        dbus.service.Object.__init__(self, self._bus, self._path)
+
+    @property
+    def path(self):
+        return self._path
+
+    @dbus.service.method('net.connman.iwd.SignalLevelAgent',
+                         in_signature=3D'', out_signature=3D'')
+    def Release(self):
+        print("SignalAgent released")
+
+    @dbus.service.method('net.connman.iwd.SignalLevelAgent',
+                         in_signature=3D'oy', out_signature=3D'')
+    def Changed(self, path, level):
+        self.handle_new_level(str(path), int(level))
+
+    def handle_new_level(self, path, level):
+        print("New signal level %d" % level)
+
+if __name__ =3D=3D '__main__':
+    if len(sys.argv) < 2:
+        print("Usage: %s <device path>" % sys.argv[0])
+        quit()
+
+    dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
+
+    bus =3D dbus.SystemBus()
+    agent =3D SignalAgent()
+
+    station_if =3D dbus.Interface(bus.get_object('net.connman.iwd', sys.ar=
gv[1]),
+                                            'net.connman.iwd.Station')
+    station_if.RegisterSignalLevelAgent(agent.path,
+                                        dbus.Array([-70, -75, -80], 'n'))
+
+    mainloop =3D GLib.MainLoop()
+    mainloop.run()
+
-- =

2.26.2

--===============6867196465684752932==--

