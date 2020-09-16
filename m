Content-Type: multipart/mixed; boundary="===============0959997772396403181=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2] auto-t: add netconfig autotest
Date: Tue, 15 Sep 2020 17:00:22 -0700
Message-ID: <20200916000022.570808-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0959997772396403181==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Tests that DHCP using IWD's internal netconfig functions properly.
The actual IP address assignment is not verified, but since IWD does
not signal the connection as successful unless DHCP succeeds we
can assume it was successful by checking that the device is connected.

The process of actually starting dhcpd and configuring the interfaces
is quite simple so it was left in the autotest itself. If (or when)
more tests require IP capabilities (p2p, FILS, etc) this could be
moved into test-runner itself and be made common. The reason I did not
put it in there now is a) because this is the only test and b) more
complex DHCP cases are likely to develop and may require more than this
simplistic setup (like multiple APs/interfaces)
---
 autotests/testNetconfig/connection_test.py | 70 ++++++++++++++++++++++
 autotests/testNetconfig/dhcpd.conf         | 16 +++++
 autotests/testNetconfig/hw.conf            |  6 ++
 autotests/testNetconfig/main.conf          |  2 +
 autotests/testNetconfig/ssidTKIP.conf      |  7 +++
 5 files changed, 101 insertions(+)
 create mode 100644 autotests/testNetconfig/connection_test.py
 create mode 100644 autotests/testNetconfig/dhcpd.conf
 create mode 100644 autotests/testNetconfig/hw.conf
 create mode 100644 autotests/testNetconfig/main.conf
 create mode 100644 autotests/testNetconfig/ssidTKIP.conf

-v2:
 * Removed dhcpd.leases. Its an empty file anyways which caused issues with=
 applying
   the patches. Instead we can just touch /tmp/dhcpd.leases before starting=
 dhcpd.

diff --git a/autotests/testNetconfig/connection_test.py b/autotests/testNet=
config/connection_test.py
new file mode 100644
index 00000000..3a590aeb
--- /dev/null
+++ b/autotests/testNetconfig/connection_test.py
@@ -0,0 +1,70 @@
+#!/usr/bin/python3
+
+import unittest
+import sys
+
+sys.path.append('../util')
+import iwd
+from iwd import IWD
+from iwd import PSKAgent
+from iwd import NetworkType
+import testutil
+from config import ctx
+
+class Test(unittest.TestCase):
+
+    def test_connection_success(self):
+        wd =3D IWD()
+
+        psk_agent =3D PSKAgent("secret123")
+        wd.register_psk_agent(psk_agent)
+
+        devices =3D wd.list_devices(1)
+        device =3D devices[0]
+
+        condition =3D 'not obj.scanning'
+        wd.wait_for_object_condition(device, condition)
+
+        device.scan()
+
+        condition =3D 'not obj.scanning'
+        wd.wait_for_object_condition(device, condition)
+
+        ordered_network =3D device.get_ordered_network('ssidTKIP')
+
+        self.assertEqual(ordered_network.type, NetworkType.psk)
+
+        condition =3D 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+
+        ordered_network.network_object.connect()
+
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
+        testutil.test_iface_operstate()
+        testutil.test_ifaces_connected()
+
+        device.disconnect()
+
+        condition =3D 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+
+        wd.unregister_psk_agent(psk_agent)
+
+    @classmethod
+    def setUpClass(cls):
+        # TODO: This could be moved into test-runner itself if other tests=
 ever
+        #       require this functionality (p2p, FILS, etc.). Since its si=
mple
+        #       enough it can stay here for now.
+        ctx.start_process(['ifconfig', 'wln0', '192.168.1.1', 'netmask', '=
255.255.255.0'],
+                                wait=3DTrue)
+        ctx.start_process(['touch', '/tmp/dhcpd.leases'], wait=3DTrue)
+        ctx.start_process(['dhcpd', '-cf', '/tmp/dhcpd.conf', '-lf', '/tmp=
/dhcpd.leases'])
+
+    @classmethod
+    def tearDownClass(cls):
+        IWD.clear_storage()
+
+if __name__ =3D=3D '__main__':
+    unittest.main(exit=3DTrue)
diff --git a/autotests/testNetconfig/dhcpd.conf b/autotests/testNetconfig/d=
hcpd.conf
new file mode 100644
index 00000000..77b4da1c
--- /dev/null
+++ b/autotests/testNetconfig/dhcpd.conf
@@ -0,0 +1,16 @@
+default-lease-time 600;         # 10 minutes
+max-lease-time 7200;            # 2  hours
+
+option broadcast-address 192.168.1.255;
+option routers 192.168.1.254;
+option subnet-mask 255.255.255.0;
+
+subnet 192.168.1.0 netmask 255.255.255.0
+ {
+  option routers 192.168.1.1;
+  option subnet-mask 255.255.255.0;
+  option domain-name-servers 192.168.1.1;
+  interface wln0;
+  range 192.168.1.10 192.168.1.20;
+  range 192.168.1.100 192.168.1.200;
+ }
diff --git a/autotests/testNetconfig/hw.conf b/autotests/testNetconfig/hw.c=
onf
new file mode 100644
index 00000000..75c5ac6e
--- /dev/null
+++ b/autotests/testNetconfig/hw.conf
@@ -0,0 +1,6 @@
+[SETUP]
+num_radios=3D2
+max_test_exec_interval_sec=3D40
+
+[HOSTAPD]
+rad0=3DssidTKIP.conf
diff --git a/autotests/testNetconfig/main.conf b/autotests/testNetconfig/ma=
in.conf
new file mode 100644
index 00000000..982e5445
--- /dev/null
+++ b/autotests/testNetconfig/main.conf
@@ -0,0 +1,2 @@
+[General]
+EnableNetworkConfiguration=3Dtrue
diff --git a/autotests/testNetconfig/ssidTKIP.conf b/autotests/testNetconfi=
g/ssidTKIP.conf
new file mode 100644
index 00000000..11ef15f0
--- /dev/null
+++ b/autotests/testNetconfig/ssidTKIP.conf
@@ -0,0 +1,7 @@
+hw_mode=3Dg
+channel=3D1
+ssid=3DssidTKIP
+
+wpa=3D1
+wpa_pairwise=3DTKIP
+wpa_passphrase=3Dsecret123
-- =

2.26.2

--===============0959997772396403181==--

