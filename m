Content-Type: multipart/mixed; boundary="===============2581461561593509793=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/2] auto-t: add static netconfig test
Date: Thu, 10 Dec 2020 13:22:10 -0800
Message-ID: <20201210212210.880245-2-prestwoj@gmail.com>
In-Reply-To: <20201210212210.880245-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2581461561593509793==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Tests netconfig with a static configuration, as well as tests ACD
functionality.

The test has two IWD radios which will eventually use the same IP.
One is configured statically, one will receive the IP via DHCP.
The static client sets its IP first and begins using it. Then the
DHCP client is started. Since ACD in a DHCP client is configured
to use its address indefinitely, the static client *should* give
up its address.
---
 autotests/testNetconfig/connection_test.py   |  10 +-
 autotests/testNetconfig/hw.conf              |   7 +-
 autotests/testNetconfig/static_test.py       | 105 +++++++++++++++++++
 autotests/testNetconfig/storage/ssidTKIP.psk |   3 +
 4 files changed, 121 insertions(+), 4 deletions(-)
 create mode 100644 autotests/testNetconfig/static_test.py
 create mode 100644 autotests/testNetconfig/storage/ssidTKIP.psk

diff --git a/autotests/testNetconfig/connection_test.py b/autotests/testNet=
config/connection_test.py
index 5fc7a88e..caab090c 100644
--- a/autotests/testNetconfig/connection_test.py
+++ b/autotests/testNetconfig/connection_test.py
@@ -11,11 +11,12 @@ from iwd import NetworkType
 from hostapd import HostapdCLI
 import testutil
 from config import ctx
+import os
 =

 class Test(unittest.TestCase):
 =

     def test_connection_success(self):
-        wd =3D IWD()
+        wd =3D IWD(True)
 =

         psk_agent =3D PSKAgent("secret123")
         wd.register_psk_agent(psk_agent)
@@ -62,12 +63,15 @@ class Test(unittest.TestCase):
         ctx.start_process(['ifconfig', hapd.ifname, '192.168.1.1', 'netmas=
k', '255.255.255.0'],
                                 wait=3DTrue)
         ctx.start_process(['touch', '/tmp/dhcpd.leases'], wait=3DTrue)
-        ctx.start_process(['dhcpd', '-cf', '/tmp/dhcpd.conf', '-lf', '/tmp=
/dhcpd.leases',
-                            hapd.ifname])
+        cls.dhcpd_pid =3D ctx.start_process(['dhcpd', '-f', '-cf', '/tmp/d=
hcpd.conf',
+                                            '-lf', '/tmp/dhcpd.leases',
+                                            hapd.ifname])
 =

     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
+        cls.dhcpd_pid.kill()
+        os.system('rm -rf /tmp/dhcpd.leases')
 =

 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
diff --git a/autotests/testNetconfig/hw.conf b/autotests/testNetconfig/hw.c=
onf
index 75c5ac6e..323f1fb2 100644
--- a/autotests/testNetconfig/hw.conf
+++ b/autotests/testNetconfig/hw.conf
@@ -1,6 +1,11 @@
 [SETUP]
-num_radios=3D2
+num_radios=3D3
 max_test_exec_interval_sec=3D40
+start_iwd=3D0
+hwsim_medium=3Dno
 =

 [HOSTAPD]
 rad0=3DssidTKIP.conf
+
+[NameSpaces]
+ns0=3Drad2
diff --git a/autotests/testNetconfig/static_test.py b/autotests/testNetconf=
ig/static_test.py
new file mode 100644
index 00000000..b304f06d
--- /dev/null
+++ b/autotests/testNetconfig/static_test.py
@@ -0,0 +1,105 @@
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
+from hostapd import HostapdCLI
+import testutil
+from config import ctx
+import os
+
+class Test(unittest.TestCase):
+
+    def test_connection_success(self):
+        wd =3D IWD(True, iwd_storage_dir=3D'/tmp/storage')
+
+        ns0 =3D ctx.get_namespace('ns0')
+
+        wd_ns0 =3D IWD(True, namespace=3Dns0)
+
+        psk_agent =3D PSKAgent("secret123")
+        psk_agent_ns0 =3D PSKAgent("secret123", namespace=3Dns0)
+        wd.register_psk_agent(psk_agent)
+        wd_ns0.register_psk_agent(psk_agent_ns0)
+
+        dev1 =3D wd.list_devices(1)[0]
+        dev2 =3D wd_ns0.list_devices(1)[0]
+
+        condition =3D 'not obj.scanning'
+        wd.wait_for_object_condition(dev1, condition)
+
+        dev1.scan()
+
+        condition =3D 'not obj.scanning'
+        wd.wait_for_object_condition(dev1, condition)
+
+        ordered_network =3D dev1.get_ordered_network('ssidTKIP')
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
+        wd.wait_for_object_condition(dev1, condition)
+
+        testutil.test_iface_operstate()
+        testutil.test_ifaces_connected()
+
+        testutil.test_ip_address_match(dev1.name, '192.168.1.10')
+
+        dev2.scan()
+
+        condition =3D 'not obj.scanning'
+        wd_ns0.wait_for_object_condition(dev2, condition)
+
+        ordered_network =3D dev2.get_ordered_network('ssidTKIP', scan_if_n=
eeded=3DTrue)
+
+        condition =3D 'not obj.connected'
+        wd_ns0.wait_for_object_condition(ordered_network.network_object, c=
ondition)
+
+        ordered_network.network_object.connect()
+
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd_ns0.wait_for_object_condition(dev2, condition)
+
+        wd.wait(1)
+        testutil.test_ip_address_match(dev1.name, None)
+
+        dev1.disconnect()
+        dev2.disconnect()
+
+        condition =3D 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+
+        wd.unregister_psk_agent(psk_agent)
+
+    @classmethod
+    def setUpClass(cls):
+        hapd =3D HostapdCLI()
+        # TODO: This could be moved into test-runner itself if other tests=
 ever
+        #       require this functionality (p2p, FILS, etc.). Since its si=
mple
+        #       enough it can stay here for now.
+        ctx.start_process(['ifconfig', hapd.ifname, '192.168.1.1', 'netmas=
k', '255.255.255.0'],
+                                wait=3DTrue)
+        ctx.start_process(['touch', '/tmp/dhcpd.leases'], wait=3DTrue)
+        cls.dhcpd_pid =3D ctx.start_process(['dhcpd', '-f', '-cf', '/tmp/d=
hcpd.conf',
+                                            '-lf', '/tmp/dhcpd.leases',
+                                            hapd.ifname])
+        IWD.copy_to_storage('ssidTKIP.psk', '/tmp/storage')
+
+    @classmethod
+    def tearDownClass(cls):
+        IWD.clear_storage()
+        cls.dhcpd_pid.kill()
+        os.system('rm -rf /tmp/dhcpd.leases')
+
+if __name__ =3D=3D '__main__':
+    unittest.main(exit=3DTrue)
diff --git a/autotests/testNetconfig/storage/ssidTKIP.psk b/autotests/testN=
etconfig/storage/ssidTKIP.psk
new file mode 100644
index 00000000..f15724a3
--- /dev/null
+++ b/autotests/testNetconfig/storage/ssidTKIP.psk
@@ -0,0 +1,3 @@
+[IPv4]
+Address=3D192.168.1.10
+Gateway=3D192.168.1.1
-- =

2.26.2

--===============2581461561593509793==--

