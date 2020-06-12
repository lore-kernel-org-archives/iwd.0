Content-Type: multipart/mixed; boundary="===============8930041821020528949=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/4] auto-t: add test for delayed ANQP response
Date: Fri, 12 Jun 2020 09:20:25 -0700
Message-ID: <20200612162025.6996-4-prestwoj@gmail.com>
In-Reply-To: <20200612162025.6996-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8930041821020528949==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testHotspot/anqp_delay_test.py | 85 ++++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 autotests/testHotspot/anqp_delay_test.py

diff --git a/autotests/testHotspot/anqp_delay_test.py b/autotests/testHotsp=
ot/anqp_delay_test.py
new file mode 100644
index 00000000..431f16c1
--- /dev/null
+++ b/autotests/testHotspot/anqp_delay_test.py
@@ -0,0 +1,85 @@
+#!/usr/bin/python3
+
+import unittest
+import sys
+import os
+
+sys.path.append('../util')
+import iwd
+from iwd import IWD
+from iwd import PSKAgent
+from iwd import NetworkType
+from hostapd import HostapdCLI
+from hwsim import Hwsim
+import testutil
+from time import sleep
+
+class Test(unittest.TestCase):
+
+    def test_connection_success(self):
+        hwsim =3D Hwsim()
+
+        bss_radio =3D hwsim.get_radio('rad0')
+        rule0 =3D hwsim.rules.create()
+        rule0.source =3D bss_radio.addresses[0]
+        rule0.bidirectional =3D True
+        # Force the case where ANQP does not finish before Connect() comes=
 in
+        rule0.delay =3D 100
+
+        wd =3D IWD(True, '/tmp')
+
+        hapd =3D HostapdCLI(config=3D'ssidHotspot.conf')
+
+        psk_agent =3D PSKAgent('abc', ('domain\\user', 'testpasswd'))
+        wd.register_psk_agent(psk_agent)
+
+        devices =3D wd.list_devices(1)
+        device =3D devices[0]
+
+        # We are dependent on a periodic scan here. We want to wait for th=
is
+        # because this is the first opportunity IWD has to do ANQP. Once A=
NQP
+        # has been done once the network is set up and we cannot simulate =
the
+        # 'Connect() before ANQP' race condition anymore.
+        condition =3D 'obj.scanning'
+        wd.wait_for_object_condition(device, condition)
+
+        condition =3D 'not obj.scanning'
+        wd.wait_for_object_condition(device, condition)
+
+        ordered_network =3D device.get_ordered_network('Hotspot')
+
+        self.assertEqual(ordered_network.type, NetworkType.eap)
+
+        condition =3D 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+
+        ordered_network.network_object.connect()
+
+        rule0.delay =3D 1
+
+        condition =3D 'obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+
+        testutil.test_iface_operstate()
+        testutil.test_ifaces_connected(device.name, hapd.ifname)
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
+        IWD.copy_to_hotspot('example.conf')
+        conf =3D '[General]\nDisableANQP=3D0\n'
+        os.system('echo "%s" > /tmp/main.conf' % conf)
+
+    @classmethod
+    def tearDownClass(cls):
+        IWD.clear_storage()
+        os.remove('/tmp/main.conf')
+
+if __name__ =3D=3D '__main__':
+    unittest.main(exit=3DTrue)
-- =

2.21.1

--===============8930041821020528949==--

