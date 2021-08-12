Content-Type: multipart/mixed; boundary="===============1202793979001384532=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 06/18] auto-t: iwd.py: add connect_bssid() method
Date: Thu, 12 Aug 2021 13:21:55 -0700
Message-ID: <20210812202207.737053-6-prestwoj@gmail.com>
In-Reply-To: <20210812202207.737053-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1202793979001384532==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Python API for ConnectBssid() developer method
---
 autotests/util/iwd.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 350e1aca..be072a42 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -39,6 +39,7 @@ IWD_P2P_INTERFACE =3D             'net.connman.iwd.p2p.De=
vice'
 IWD_P2P_PEER_INTERFACE =3D        'net.connman.iwd.p2p.Peer'
 IWD_P2P_SERVICE_MANAGER_INTERFACE =3D 'net.connman.iwd.p2p.ServiceManager'
 IWD_P2P_WFD_INTERFACE =3D         'net.connman.iwd.p2p.Display'
+IWD_STATION_DEBUG_INTERFACE =3D   'net.connman.iwd.StationDebug'
 =

 IWD_AGENT_MANAGER_PATH =3D        '/net/connman/iwd'
 IWD_TOP_LEVEL_PATH =3D            '/'
@@ -535,6 +536,12 @@ class Device(IWDDBusAbstract):
     def stop_adhoc(self):
         self._prop_proxy.Set(IWD_DEVICE_INTERFACE, 'Mode', 'station')
 =

+    def connect_bssid(self, address):
+        self._station_debug_if =3D dbus.Interface(self._bus.get_object(IWD=
_SERVICE,
+                                                self.device_path),
+                                                IWD_STATION_DEBUG_INTERFAC=
E)
+        self._station_debug_if.ConnectBssid(dbus.ByteArray.fromhex(address=
.replace(':', '')))
+
     def __str__(self, prefix =3D ''):
         return prefix + 'Device: ' + self.device_path + '\n'\
                + prefix + '\tName:\t\t' + self.name + '\n'\
-- =

2.31.1

--===============1202793979001384532==--

