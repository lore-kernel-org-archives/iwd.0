Content-Type: multipart/mixed; boundary="===============3733151181909902021=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 07/18] auto-t: iwd.py: add roam() method
Date: Thu, 12 Aug 2021 13:21:56 -0700
Message-ID: <20210812202207.737053-7-prestwoj@gmail.com>
In-Reply-To: <20210812202207.737053-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3733151181909902021==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will use the Roam() developer method to force a roam to
a certain BSS. This is particularly useful for any test requiring
roams that are not testing IWD's BSS selection logic. Rather than
creating hwsim rules, setting low RSSI values, and waiting for the
roam logic/scan to happen Roam() can be used to force the roam
logic immediately.
---
 autotests/util/iwd.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index be072a42..1785081f 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -542,6 +542,12 @@ class Device(IWDDBusAbstract):
                                                 IWD_STATION_DEBUG_INTERFAC=
E)
         self._station_debug_if.ConnectBssid(dbus.ByteArray.fromhex(address=
.replace(':', '')))
 =

+    def roam(self, address):
+        self._station_debug_if =3D dbus.Interface(self._bus.get_object(IWD=
_SERVICE,
+                                                self.device_path),
+                                                IWD_STATION_DEBUG_INTERFAC=
E)
+        self._station_debug_if.Roam(dbus.ByteArray.fromhex(address.replace=
(':', '')))
+
     def __str__(self, prefix =3D ''):
         return prefix + 'Device: ' + self.device_path + '\n'\
                + prefix + '\tName:\t\t' + self.name + '\n'\
-- =

2.31.1

--===============3733151181909902021==--

