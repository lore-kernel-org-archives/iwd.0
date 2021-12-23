Content-Type: multipart/mixed; boundary="===============5175078989996622117=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/2] auto-t: iwd.py: fix namespaces on StationDebug
Date: Wed, 22 Dec 2021 17:12:22 -0800
Message-ID: <20211223011222.20509-2-prestwoj@gmail.com>
In-Reply-To: 20211223011222.20509-1-prestwoj@gmail.com

--===============5175078989996622117==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Passing the full argument list to StationDebug was removed
because any existing properties (for Device) were being
included and causing incorrect behavior.

This neglected to handle namespaces which should also be
passed to StationDebug. Unfortunately the arguments are not
named when Device() is initialized so they cannot easily be
sorted. Instead just define Device() arguments to match the
DBus abstraction and pass only the path and namespace to
StationDebug
---
 autotests/util/iwd.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 185a31fe..e95bd96d 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -280,14 +280,17 @@ class Device(IWDDBusAbstract):
     '''
     _iface_name =3D IWD_DEVICE_INTERFACE
 =

-    def __init__(self, *args, **kwargs):
+    def __init__(self, object_path =3D None, properties =3D None,
+                    service=3DIWD_SERVICE, namespace=3Dctx):
         self._wps_manager_if =3D None
         self._station_if =3D None
         self._station_props =3D None
 =

-        IWDDBusAbstract.__init__(self, *args, **kwargs)
+        IWDDBusAbstract.__init__(self, object_path, properties, service,
+                                    namespace)
 =

-        self._station_debug =3D StationDebug(args[0])
+        self._station_debug =3D StationDebug(object_path=3Dobject_path,
+                                            namespace=3Dnamespace)
 =

     @property
     def _wps_manager(self):
-- =

2.31.1

--===============5175078989996622117==--

