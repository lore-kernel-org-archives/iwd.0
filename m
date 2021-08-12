Content-Type: multipart/mixed; boundary="===============9001001825018002885=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/6] auto-t: add python API for StationDebug.Scan
Date: Thu, 12 Aug 2021 16:12:29 -0700
Message-ID: <20210812231233.747743-2-prestwoj@gmail.com>
In-Reply-To: <20210812231233.747743-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9001001825018002885==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/iwd.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index f5c224b8..7bb4c9f0 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -242,6 +242,10 @@ class StationDebug(IWDDBusAbstract):
     def autoconnect(self):
         return self._properties['AutoConnect']
 =

+    def scan(self, frequencies):
+        frequencies =3D dbus.Array([dbus.UInt16(f) for f in frequencies])
+        self._iface.Scan(frequencies)
+
 class Device(IWDDBusAbstract):
     '''
         Class represents a network device object: net.connman.iwd.Device
@@ -585,6 +589,12 @@ class Device(IWDDBusAbstract):
                                                 IWD_STATION_DEBUG_INTERFAC=
E)
         self._station_debug_if.Roam(dbus.ByteArray.fromhex(address.replace=
(':', '')))
 =

+    def debug_scan(self, frequencies):
+        if not self._station_debug:
+            self._station_debug =3D StationDebug(self._object_path)
+
+        self._station_debug.scan(frequencies)
+
     def __str__(self, prefix =3D ''):
         return prefix + 'Device: ' + self.device_path + '\n'\
                + prefix + '\tName:\t\t' + self.name + '\n'\
-- =

2.31.1

--===============9001001825018002885==--

