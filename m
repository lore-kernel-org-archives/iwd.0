Content-Type: multipart/mixed; boundary="===============3837363895202734951=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/5] autotests: Move some variables from IWD class to instance
Date: Fri, 09 Oct 2020 20:08:54 +0200
Message-ID: <20201009180855.1063394-4-andrew.zaborowski@intel.com>
In-Reply-To: <20201009180855.1063394-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3837363895202734951==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These variables were probably meant as instance members and not class
members.
---
 autotests/util/iwd.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 7e3676d9..94a118ce 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -231,9 +231,12 @@ class Device(IWDDBusAbstract):
         with its properties and methods
     '''
     _iface_name =3D IWD_DEVICE_INTERFACE
-    _wps_manager_if =3D None
-    _station_if =3D None
-    _station_props =3D None
+
+    def __init__(self, *args, **kwargs):
+        self._wps_manager_if =3D None
+        self._station_if =3D None
+        self._station_props =3D None
+        IWDDBusAbstract.__init__(self, *args, **kwargs)
 =

     @property
     def _wps_manager(self):
-- =

2.25.1

--===============3837363895202734951==--

