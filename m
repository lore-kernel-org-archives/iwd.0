Content-Type: multipart/mixed; boundary="===============4903979965298518287=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] auto-t: update testEAP-TLS to use HostapdCLI
Date: Mon, 28 Oct 2019 12:52:01 -0700
Message-ID: <20191028195201.21904-3-prestwoj@gmail.com>
In-Reply-To: <20191028195201.21904-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4903979965298518287==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This test did not use the updated HostapdCLI where you can specify
a config file rather than iterate hostapd list.
---
 autotests/testEAP-TLS/connection_test.py | 11 +++--------
 autotests/testEAP-TLS/ssidEAP-TLS.conf   |  1 +
 autotests/testEAP-TLS/ssidEAP-TLS2.conf  |  1 +
 autotests/testEAP-TLS/ssidEAP-TLS3.conf  |  1 +
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/autotests/testEAP-TLS/connection_test.py b/autotests/testEAP-T=
LS/connection_test.py
index 6d82dda7..9b696aa4 100644
--- a/autotests/testEAP-TLS/connection_test.py
+++ b/autotests/testEAP-TLS/connection_test.py
@@ -9,23 +9,18 @@ from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
 import testutil
-import hostapd
+from hostapd import HostapdCLI
 =

 class Test(unittest.TestCase):
 =

     def do_test_connection_success(self, ssid, passphrase=3DNone):
+        hapd =3D HostapdCLI(config=3Dssid + '.conf')
         wd =3D IWD()
 =

         if passphrase:
             psk_agent =3D PSKAgent(passphrase)
             wd.register_psk_agent(psk_agent)
 =

-        hostapd_ifname =3D None
-        for ifname in hostapd.hostapd_map:
-            if ssid + '.conf' in hostapd.hostapd_map[ifname].config:
-                hostapd_ifname =3D ifname
-                break
-
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

@@ -52,7 +47,7 @@ class Test(unittest.TestCase):
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
 =

         testutil.test_iface_operstate()
-        testutil.test_ifaces_connected(hostapd_ifname, device.name)
+        testutil.test_ifaces_connected(hapd.ifname, device.name)
 =

         device.disconnect()
 =

diff --git a/autotests/testEAP-TLS/ssidEAP-TLS.conf b/autotests/testEAP-TLS=
/ssidEAP-TLS.conf
index e1d7c6b4..b14ea423 100644
--- a/autotests/testEAP-TLS/ssidEAP-TLS.conf
+++ b/autotests/testEAP-TLS/ssidEAP-TLS.conf
@@ -1,3 +1,4 @@
+ctrl_interface=3D/var/run/hostapd
 hw_mode=3Dg
 channel=3D1
 ssid=3DssidEAP-TLS
diff --git a/autotests/testEAP-TLS/ssidEAP-TLS2.conf b/autotests/testEAP-TL=
S/ssidEAP-TLS2.conf
index ebb0f36b..6a811deb 100644
--- a/autotests/testEAP-TLS/ssidEAP-TLS2.conf
+++ b/autotests/testEAP-TLS/ssidEAP-TLS2.conf
@@ -1,3 +1,4 @@
+ctrl_interface=3D/var/run/hostapd
 hw_mode=3Dg
 channel=3D2
 ssid=3DssidEAP-TLS2
diff --git a/autotests/testEAP-TLS/ssidEAP-TLS3.conf b/autotests/testEAP-TL=
S/ssidEAP-TLS3.conf
index ebbeab13..3a5f70bf 100644
--- a/autotests/testEAP-TLS/ssidEAP-TLS3.conf
+++ b/autotests/testEAP-TLS/ssidEAP-TLS3.conf
@@ -1,3 +1,4 @@
+ctrl_interface=3D/var/run/hostapd
 hw_mode=3Dg
 channel=3D3
 ssid=3DssidEAP-TLS3
-- =

2.17.1

--===============4903979965298518287==--

