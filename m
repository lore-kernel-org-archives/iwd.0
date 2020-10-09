Content-Type: multipart/mixed; boundary="===============0155206343121664497=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/5] autotests: Add testP2P
Date: Fri, 09 Oct 2020 20:08:55 +0200
Message-ID: <20201009180855.1063394-5-andrew.zaborowski@intel.com>
In-Reply-To: <20201009180855.1063394-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0155206343121664497==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add two P2P client connection scenarios.
---
 autotests/testP2P/client_test.py | 106 +++++++++++++++++++++++++++++++
 autotests/testP2P/dhcpd.conf     |   4 ++
 autotests/testP2P/hw.conf        |   6 ++
 autotests/testP2P/main.conf      |   6 ++
 autotests/testP2P/rad1-p2p.conf  |  10 +++
 5 files changed, 132 insertions(+)
 create mode 100644 autotests/testP2P/client_test.py
 create mode 100644 autotests/testP2P/dhcpd.conf
 create mode 100644 autotests/testP2P/hw.conf
 create mode 100644 autotests/testP2P/main.conf
 create mode 100644 autotests/testP2P/rad1-p2p.conf

diff --git a/autotests/testP2P/client_test.py b/autotests/testP2P/client_te=
st.py
new file mode 100644
index 00000000..4994de76
--- /dev/null
+++ b/autotests/testP2P/client_test.py
@@ -0,0 +1,106 @@
+#!/usr/bin/python3
+
+import unittest
+import sys
+import netifaces
+import os
+
+import iwd
+from iwd import IWD
+import testutil
+from config import ctx
+from wpas import Wpas
+
+class Test(unittest.TestCase):
+    def test_1_client_go_neg_responder(self):
+        self.p2p_client_test(False)
+
+    def test_2_client_go_neg_initiator(self):
+        self.p2p_client_test(True)
+
+    def p2p_client_test(self, preauthorize):
+        wpas =3D Wpas(p2p=3DTrue)
+        wd =3D IWD()
+
+        # Not strictly necessary but prevents the station interface from q=
ueuing its scans
+        # in the wiphy radio work queue and delaying P2P scans.
+        wd.list_devices(1)[0].disconnect()
+
+        devices =3D wd.list_p2p_devices(1)
+        p2p =3D devices[0]
+        p2p.enabled =3D True
+        p2p.name =3D 'testdev1'
+
+        wpas.p2p_find()
+        p2p.discovery_request =3D True
+        wd.wait(5)
+        wd.wait_for_object_condition(wpas, 'len(obj.p2p_peers) =3D=3D 1', =
max_wait=3D20)
+        p2p.discovery_request =3D False
+        wpas.p2p_listen()
+
+        peers =3D p2p.get_peers()
+        self.assertEqual(len(peers), 1)
+        peer =3D next(iter(peers.values()))
+        self.assertEqual(peer.name, wpas.config['device_name'])
+        self.assertEqual(peer.category, 'display')
+        self.assertEqual(peer.subcategory, 'monitor')
+
+        wpas_peer =3D next(iter(wpas.p2p_peers.values()))
+        self.assertEqual(wpas_peer['name'], p2p.name)
+        self.assertEqual(wpas_peer['pri_dev_type'], '1-0050F204-6') # 1 =
=3D=3D Computer, 6 =3D=3D Desktop
+        self.assertEqual(wpas_peer['config_methods'], '0x1080')
+
+        if preauthorize:
+            wpas.p2p_authorize(wpas_peer)
+
+        peer.connect(wait=3DFalse)
+
+        self.assertEqual(len(wpas.p2p_go_neg_requests), 0)
+        self.assertEqual(len(wpas.p2p_clients), 0)
+        wd.wait_for_object_condition(wpas, 'len(obj.p2p_go_neg_requests) =
=3D=3D 1', max_wait=3D3)
+        request =3D wpas.p2p_go_neg_requests[wpas_peer['p2p_dev_addr']]
+
+        if not preauthorize:
+            self.assertEqual(request['dev_passwd_id'], '4')
+            self.assertEqual(request['go_intent'], '2') # Hardcoded in src=
/p2p.c
+
+            wpas.p2p_accept_go_neg_request(request)
+
+        wd.wait_for_object_condition(request, '\'success\' in obj', max_wa=
it=3D3)
+        self.assertEqual(request['success'], True)
+        self.assertEqual(request['role'], 'GO')
+        self.assertEqual(request['wps_method'], 'PBC')
+        self.assertEqual(request['p2p_dev_addr'], wpas_peer['p2p_dev_addr'=
])
+
+        wd.wait_for_object_condition(wpas, 'obj.p2p_group is not None', ma=
x_wait=3D3)
+        go_ifname =3D wpas.p2p_group['ifname']
+        ctx.start_process(['ifconfig', go_ifname, '192.168.1.20', 'netmask=
', '255.255.255.0'], wait=3DTrue)
+        os.system('> /tmp/dhcpd.leases')
+        dhcpd =3D ctx.start_process(['dhcpd', '-f', '-cf', '/tmp/dhcpd.con=
f', '-lf', '/tmp/dhcpd.leases', go_ifname])
+
+        wd.wait_for_object_condition(wpas, 'len(obj.p2p_clients) =3D=3D 1'=
, max_wait=3D3)
+        client =3D wpas.p2p_clients[request['peer_iface']]
+        self.assertEqual(client['p2p_dev_addr'], wpas_peer['p2p_dev_addr'])
+
+        wd.wait_for_object_condition(peer, 'obj.connected', max_wait=3D15)
+        our_ip =3D netifaces.ifaddresses(peer.connected_interface)[netifac=
es.AF_INET][0]['addr']
+        self.assertEqual(peer.connected_ip, '192.168.1.20')
+        self.assertEqual(our_ip, '192.168.1.30')
+
+        testutil.test_iface_operstate(peer.connected_interface)
+        testutil.test_ifaces_connected(peer.connected_interface, go_ifname)
+
+        peer.disconnect()
+        wd.wait_for_object_condition(wpas, 'len(obj.p2p_clients) =3D=3D 0'=
, max_wait=3D3)
+        self.assertEqual(peer.connected, False)
+
+        p2p.enabled =3D False
+        ctx.stop_process(dhcpd)
+        wpas.clean_up()
+
+    @classmethod
+    def tearDownClass(cls):
+        IWD.clear_storage()
+
+if __name__ =3D=3D '__main__':
+    unittest.main(exit=3DTrue)
diff --git a/autotests/testP2P/dhcpd.conf b/autotests/testP2P/dhcpd.conf
new file mode 100644
index 00000000..a5ef0b4a
--- /dev/null
+++ b/autotests/testP2P/dhcpd.conf
@@ -0,0 +1,4 @@
+subnet 192.168.1.0 netmask 255.255.255.0
+ {
+  range 192.168.1.30;
+ }
diff --git a/autotests/testP2P/hw.conf b/autotests/testP2P/hw.conf
new file mode 100644
index 00000000..d8f213f7
--- /dev/null
+++ b/autotests/testP2P/hw.conf
@@ -0,0 +1,6 @@
+[SETUP]
+num_radios=3D2
+hwsim_medium=3Dno
+
+[WPA_SUPPLICANT]
+rad1=3Drad1-p2p.conf
diff --git a/autotests/testP2P/main.conf b/autotests/testP2P/main.conf
new file mode 100644
index 00000000..75040f78
--- /dev/null
+++ b/autotests/testP2P/main.conf
@@ -0,0 +1,6 @@
+[General]
+EnableNetworkConfiguration=3Dtrue
+
+[P2P]
+# Something different from the default of 'pc' for validation
+DeviceType=3Ddesktop
diff --git a/autotests/testP2P/rad1-p2p.conf b/autotests/testP2P/rad1-p2p.c=
onf
new file mode 100644
index 00000000..a34f3d91
--- /dev/null
+++ b/autotests/testP2P/rad1-p2p.conf
@@ -0,0 +1,10 @@
+ctrl_interface=3D/tmp/rad1-p2p-wpas
+update_config=3D0
+device_name=3Dtestdev2
+device_type=3D7-0050F204-4 # 7 =3D=3D Display, 4 =3D=3D Monitor
+config_methods=3Dvirtual_push_button
+p2p_listen_reg_class=3D81
+p2p_listen_channel=3D11
+p2p_oper_reg_class=3D81
+p2p_oper_channel=3D11
+p2p_go_intent=3D10
-- =

2.25.1

--===============0155206343121664497==--

