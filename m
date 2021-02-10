Content-Type: multipart/mixed; boundary="===============4228994494511875648=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2] test: add a simple signal agent script
Date: Wed, 10 Feb 2021 12:23:42 -0800
Message-ID: <20210210202342.843578-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4228994494511875648==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Creates a signal agent and registers for levels passed
in on the command line, or a default set of levels.
---
 test/signal-agent | 64 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100755 test/signal-agent

v2:
 * Added support for passing in levels on the command line
 * Changed default levels to match iwctl

diff --git a/test/signal-agent b/test/signal-agent
new file mode 100755
index 00000000..fb1b6873
--- /dev/null
+++ b/test/signal-agent
@@ -0,0 +1,64 @@
+#!/usr/bin/python3
+
+from gi.repository import GLib
+
+import dbus
+import dbus.service
+import dbus.mainloop.glib
+import sys
+import time
+import signal
+
+def signal_handler(sig, frame):
+    exit(0)
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
+    level_range =3D [-60, -67, -75]
+
+    if len(sys.argv) < 2 or len(sys.argv) > 3:
+        print("Usage: %s <device path> [dBm ranges]" % sys.argv[0])
+        print("Example: %s /net/connman/iwd/0/10 -65,-70,-75" % sys.argv[0=
])
+        quit()
+
+    if len(sys.argv) =3D=3D 3:
+        level_range =3D [int(x) for x in sys.argv[2].split(',') if int(x) =
< 0]
+
+    signal.signal(signal.SIGINT, signal_handler)
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
+                                        dbus.Array(level_range, 'n'))
+
+    mainloop =3D GLib.MainLoop()
+    mainloop.run()
+
-- =

2.26.2

--===============4228994494511875648==--

