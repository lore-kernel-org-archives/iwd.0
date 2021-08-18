Content-Type: multipart/mixed; boundary="===============3949693726758727300=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 8/8] auto-t: remove ANQP delay test
Date: Wed, 18 Aug 2021 15:09:34 -0700
Message-ID: <20210818220934.295721-8-prestwoj@gmail.com>
In-Reply-To: <20210818220934.295721-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3949693726758727300==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The idea of this test is valid but it is extremely timing dependent
which simply isn't testable on all machines. Removing this test
at least until this can be tested reliably.
---
 autotests/testHotspot/anqp_delay_test.py | 106 -----------------------
 1 file changed, 106 deletions(-)
 delete mode 100644 autotests/testHotspot/anqp_delay_test.py

diff --git a/autotests/testHotspot/anqp_delay_test.py b/autotests/testHotsp=
ot/anqp_delay_test.py
deleted file mode 100644
index 22a5bdbe..00000000
--- a/autotests/testHotspot/anqp_delay_test.py
+++ /dev/null
@@ -1,106 +0,0 @@
-#!/usr/bin/python3
-
-import unittest
-import sys
-import os
-
-sys.path.append('../util')
-from iwd import IWD
-from iwd import IWD_CONFIG_DIR
-from iwd import PSKAgent
-from iwd import NetworkType
-from hostapd import HostapdCLI
-from hwsim import Hwsim
-import testutil
-from time import sleep
-
-class Test(unittest.TestCase):
-
-    def test_connection_success(self):
-        wd =3D self.wd
-        hapd =3D self.hapd
-        rule0 =3D self.rule0
-
-        devices =3D wd.list_devices(1)
-        device =3D devices[0]
-        device.autoconnect =3D True
-
-        # We are dependent on a periodic scan here. We want to wait for th=
is
-        # because this is the first opportunity IWD has to do ANQP. Once A=
NQP
-        # has been done once the network is set up and we cannot simulate =
the
-        # 'Connect() before ANQP' race condition anymore.
-        condition =3D 'obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        # If no networks were found we likely had a quick scan. Try again =
to
-        # allow the full autoconnect scan to happen.
-        try:
-            ordered_network =3D device.get_ordered_network('Hotspot')
-        except:
-            condition =3D 'obj.scanning'
-            wd.wait_for_object_condition(device, condition)
-
-            condition =3D 'not obj.scanning'
-            wd.wait_for_object_condition(device, condition)
-
-            ordered_network =3D device.get_ordered_network('Hotspot')
-
-        self.assertEqual(ordered_network.type, NetworkType.eap)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        # Force the case where ANQP does not finish before Connect() comes=
 in
-        rule0.delay =3D 100
-        rule0.prefix =3D '0d'
-
-        ordered_network.network_object.connect(wait=3DFalse)
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        hapd.wait_for_event('AP-STA-CONNECTED')
-
-        testutil.test_iface_operstate()
-        testutil.test_ifaces_connected(device.name, hapd.ifname)
-
-        device.disconnect()
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-    @classmethod
-    def setUpClass(cls):
-        cls.hwsim =3D Hwsim()
-
-        bss_radio =3D cls.hwsim.get_radio('rad0')
-        cls.rule0 =3D cls.hwsim.rules.create()
-        cls.rule0.source =3D bss_radio.addresses[0]
-        cls.rule0.bidirectional =3D True
-
-        cls.hapd =3D HostapdCLI(config=3D'ssidHotspot.conf')
-
-        IWD.copy_to_hotspot('example.conf')
-        IWD.copy_to_storage('anqp_enabled.conf', storage_dir=3DIWD_CONFIG_=
DIR, name=3D'main.conf')
-
-        cls.wd =3D IWD(True)
-        cls.psk_agent =3D PSKAgent('abc', ('domain\\user', 'testpasswd'))
-        cls.wd.register_psk_agent(cls.psk_agent)
-
-    @classmethod
-    def tearDownClass(cls):
-        IWD.clear_storage()
-
-        cls.wd.unregister_psk_agent(cls.psk_agent)
-        cls.psk_agent =3D None
-        os.remove('/tmp/main.conf')
-
-        cls.hwsim.rules.remove_all()
-        cls.hwsim =3D None
-        cls.wd =3D None
-
-if __name__ =3D=3D '__main__':
-    unittest.main(exit=3DTrue)
-- =

2.31.1

--===============3949693726758727300==--

