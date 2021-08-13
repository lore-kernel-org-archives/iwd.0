Content-Type: multipart/mixed; boundary="===============0952831056187979202=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] auto-t: iwd.py: add roam_scanning property
Date: Fri, 13 Aug 2021 09:13:45 -0700
Message-ID: <20210813161346.793270-2-prestwoj@gmail.com>
In-Reply-To: <20210813161346.793270-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0952831056187979202==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/iwd.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index cee1b99d..18840cd6 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -242,6 +242,10 @@ class StationDebug(IWDDBusAbstract):
     def autoconnect(self):
         return self._properties['AutoConnect']
 =

+    @property
+    def roam_scanning(self):
+        return self._properties['RoamScanning']
+
     def scan(self, frequencies):
         frequencies =3D dbus.Array([dbus.UInt16(f) for f in frequencies])
         self._iface.Scan(frequencies)
@@ -389,6 +393,13 @@ class Device(IWDDBusAbstract):
         self._station_debug._prop_proxy.Set(IWD_STATION_DEBUG_INTERFACE,
                                             'AutoConnect', value)
 =

+    @property
+    def roam_scanning(self):
+        if not self._station_debug:
+            self._station_debug =3D StationDebug(self._object_path)
+
+        return self._station_debug.roam_scanning
+
     def scan(self):
         '''Schedule a network scan.
 =

-- =

2.31.1

--===============0952831056187979202==--

