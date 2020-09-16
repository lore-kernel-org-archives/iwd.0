Content-Type: multipart/mixed; boundary="===============5488685545581508981=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 5/6] auto-t: remove sim_hardcoded tests
Date: Wed, 16 Sep 2020 12:39:44 -0700
Message-ID: <20200916193945.683476-5-prestwoj@gmail.com>
In-Reply-To: <20200916193945.683476-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5488685545581508981==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 .../testEAP-AKA-prime/connection_test.py      | 61 ---------------
 autotests/testEAP-AKA-prime/hw.conf           |  8 --
 autotests/testEAP-AKA-prime/sim.db            |  1 -
 autotests/testEAP-AKA-prime/sim.eap_user      |  1 -
 autotests/testEAP-AKA-prime/sim_keys.conf     |  6 --
 autotests/testEAP-AKA-prime/ssidEAP-AKA.8021x |  5 --
 autotests/testEAP-AKA-prime/ssidEAP-AKA.conf  | 16 ----
 autotests/testEAP-AKA/connection_test.py      | 75 -------------------
 autotests/testEAP-AKA/hw.conf                 |  8 --
 autotests/testEAP-AKA/sim.db                  |  1 -
 autotests/testEAP-AKA/sim.eap_user            |  1 -
 autotests/testEAP-AKA/sim_keys.conf           |  6 --
 autotests/testEAP-AKA/ssidEAP-AKA.8021x       |  5 --
 autotests/testEAP-AKA/ssidEAP-AKA.conf        | 16 ----
 autotests/testEAP-SIM/connection_test.py      | 74 ------------------
 autotests/testEAP-SIM/hw.conf                 |  8 --
 autotests/testEAP-SIM/sim.db                  |  1 -
 autotests/testEAP-SIM/sim.eap_user            |  1 -
 autotests/testEAP-SIM/sim_keys.conf           |  4 -
 autotests/testEAP-SIM/ssidEAP-SIM.8021x       |  5 --
 autotests/testEAP-SIM/ssidEAP-SIM.conf        | 16 ----
 21 files changed, 319 deletions(-)
 delete mode 100644 autotests/testEAP-AKA-prime/connection_test.py
 delete mode 100644 autotests/testEAP-AKA-prime/hw.conf
 delete mode 100644 autotests/testEAP-AKA-prime/sim.db
 delete mode 100644 autotests/testEAP-AKA-prime/sim.eap_user
 delete mode 100644 autotests/testEAP-AKA-prime/sim_keys.conf
 delete mode 100644 autotests/testEAP-AKA-prime/ssidEAP-AKA.8021x
 delete mode 100644 autotests/testEAP-AKA-prime/ssidEAP-AKA.conf
 delete mode 100644 autotests/testEAP-AKA/connection_test.py
 delete mode 100644 autotests/testEAP-AKA/hw.conf
 delete mode 100644 autotests/testEAP-AKA/sim.db
 delete mode 100644 autotests/testEAP-AKA/sim.eap_user
 delete mode 100644 autotests/testEAP-AKA/sim_keys.conf
 delete mode 100644 autotests/testEAP-AKA/ssidEAP-AKA.8021x
 delete mode 100644 autotests/testEAP-AKA/ssidEAP-AKA.conf
 delete mode 100644 autotests/testEAP-SIM/connection_test.py
 delete mode 100644 autotests/testEAP-SIM/hw.conf
 delete mode 100644 autotests/testEAP-SIM/sim.db
 delete mode 100644 autotests/testEAP-SIM/sim.eap_user
 delete mode 100644 autotests/testEAP-SIM/sim_keys.conf
 delete mode 100644 autotests/testEAP-SIM/ssidEAP-SIM.8021x
 delete mode 100644 autotests/testEAP-SIM/ssidEAP-SIM.conf

diff --git a/autotests/testEAP-AKA-prime/connection_test.py b/autotests/tes=
tEAP-AKA-prime/connection_test.py
deleted file mode 100644
index 8367022c..00000000
--- a/autotests/testEAP-AKA-prime/connection_test.py
+++ /dev/null
@@ -1,61 +0,0 @@
-#!/usr/bin/python3
-
-import unittest
-import sys
-
-sys.path.append('../util')
-import iwd
-from iwd import IWD
-from iwd import NetworkType
-from hlrauc import AuthCenter
-
-class Test(unittest.TestCase):
-
-    def test_connection_success(self):
-        auth =3D AuthCenter('/tmp/hlrauc.sock', '/tmp/sim.db')
-
-        wd =3D IWD()
-
-        devices =3D wd.list_devices(1)
-        device =3D devices[0]
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        ordered_network =3D device.get_ordered_network('ssidEAP-AKA')
-
-        self.assertEqual(ordered_network.type, NetworkType.eap)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        try:
-                ordered_network.network_object.connect()
-        except:
-                auth.stop()
-                raise
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        device.disconnect()
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        auth.stop()
-    @classmethod
-    def setUpClass(cls):
-        IWD.copy_to_storage('ssidEAP-AKA.8021x')
-
-    @classmethod
-    def tearDownClass(cls):
-        IWD.clear_storage()
-
-if __name__ =3D=3D '__main__':
-    unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-AKA-prime/hw.conf b/autotests/testEAP-AKA-pr=
ime/hw.conf
deleted file mode 100644
index 61dcc807..00000000
--- a/autotests/testEAP-AKA-prime/hw.conf
+++ /dev/null
@@ -1,8 +0,0 @@
-[SETUP]
-num_radios=3D2
-max_test_exec_interval_sec=3D40
-tmpfs_extra_stuff=3Dsim.eap_user:sim.db:sim_keys.conf
-sim_keys=3D/tmp/sim_keys.conf
-
-[HOSTAPD]
-rad0=3DssidEAP-AKA.conf
diff --git a/autotests/testEAP-AKA-prime/sim.db b/autotests/testEAP-AKA-pri=
me/sim.db
deleted file mode 100644
index 526e4bb1..00000000
--- a/autotests/testEAP-AKA-prime/sim.db
+++ /dev/null
@@ -1 +0,0 @@
-32010000000000:90dca4eda45b53cf0f12d7c9c3bc6a89:cb9cccc4b9258e6dca4760379f=
b82581:61df:000000000021
\ No newline at end of file
diff --git a/autotests/testEAP-AKA-prime/sim.eap_user b/autotests/testEAP-A=
KA-prime/sim.eap_user
deleted file mode 100644
index 915c8fb0..00000000
--- a/autotests/testEAP-AKA-prime/sim.eap_user
+++ /dev/null
@@ -1 +0,0 @@
-"632010000000000(a)example.com"	AKA'
\ No newline at end of file
diff --git a/autotests/testEAP-AKA-prime/sim_keys.conf b/autotests/testEAP-=
AKA-prime/sim_keys.conf
deleted file mode 100644
index fe7a6399..00000000
--- a/autotests/testEAP-AKA-prime/sim_keys.conf
+++ /dev/null
@@ -1,6 +0,0 @@
-[AKA]
-Identity=3D32010000000000(a)example.com
-KI=3D90dca4eda45b53cf0f12d7c9c3bc6a89
-OPC=3Dcb9cccc4b9258e6dca4760379fb82581
-AMF=3D61df
-SQN=3D000000000021
diff --git a/autotests/testEAP-AKA-prime/ssidEAP-AKA.8021x b/autotests/test=
EAP-AKA-prime/ssidEAP-AKA.8021x
deleted file mode 100644
index 6e88da6b..00000000
--- a/autotests/testEAP-AKA-prime/ssidEAP-AKA.8021x
+++ /dev/null
@@ -1,5 +0,0 @@
-[Security]
-EAP-Method=3DAKA'
-
-[Settings]
-AutoConnect=3Dfalse
diff --git a/autotests/testEAP-AKA-prime/ssidEAP-AKA.conf b/autotests/testE=
AP-AKA-prime/ssidEAP-AKA.conf
deleted file mode 100644
index 01f01f45..00000000
--- a/autotests/testEAP-AKA-prime/ssidEAP-AKA.conf
+++ /dev/null
@@ -1,16 +0,0 @@
-hw_mode=3Dg
-channel=3D1
-
-driver=3Dnl80211
-ieee8021x=3D1
-eap_server=3D1
-ssid=3DssidEAP-AKA
-eap_user_file=3D/tmp/sim.eap_user
-eap_sim_db=3Dunix:/tmp/hlrauc.sock
-wpa=3D2
-wpa_key_mgmt=3DWPA-EAP
-wpa_pairwise=3DTKIP CCMP
-rsn_pairwise=3DCCMP TKIP
-wpa_passphrase=3Dsecret123
-channel=3D1
-eap_sim_aka_result_ind=3D1
diff --git a/autotests/testEAP-AKA/connection_test.py b/autotests/testEAP-A=
KA/connection_test.py
deleted file mode 100644
index 122fd6b7..00000000
--- a/autotests/testEAP-AKA/connection_test.py
+++ /dev/null
@@ -1,75 +0,0 @@
-#!/usr/bin/python3
-
-import unittest
-import sys
-
-sys.path.append('../util')
-import iwd
-from iwd import IWD
-from iwd import NetworkType
-from hlrauc import AuthCenter
-
-from hostapd import HostapdCLI
-
-class Test(unittest.TestCase):
-
-    def test_connection_success(self):
-        hostapd =3D HostapdCLI(config=3D'ssidEAP-AKA.conf')
-
-        self.assertIsNotNone(hostapd)
-
-        auth =3D AuthCenter('/tmp/hlrauc.sock', '/tmp/sim.db')
-
-        wd =3D IWD()
-
-        devices =3D wd.list_devices(1)
-        device =3D devices[0]
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        ordered_network =3D device.get_ordered_network('ssidEAP-AKA')
-
-        self.assertEqual(ordered_network.type, NetworkType.eap)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        try:
-                ordered_network.network_object.connect()
-        except:
-                auth.stop()
-                raise
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        hostapd.eapol_reauth(device.address)
-
-        hostapd.wait_for_event('CTRL-EVENT-EAP-STARTED')
-        hostapd.wait_for_event('CTRL-EVENT-EAP-SUCCESS')
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        device.disconnect()
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        auth.stop()
-    @classmethod
-    def setUpClass(cls):
-        IWD.copy_to_storage('ssidEAP-AKA.8021x')
-
-    @classmethod
-    def tearDownClass(cls):
-        IWD.clear_storage()
-
-if __name__ =3D=3D '__main__':
-    unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-AKA/hw.conf b/autotests/testEAP-AKA/hw.conf
deleted file mode 100644
index 61dcc807..00000000
--- a/autotests/testEAP-AKA/hw.conf
+++ /dev/null
@@ -1,8 +0,0 @@
-[SETUP]
-num_radios=3D2
-max_test_exec_interval_sec=3D40
-tmpfs_extra_stuff=3Dsim.eap_user:sim.db:sim_keys.conf
-sim_keys=3D/tmp/sim_keys.conf
-
-[HOSTAPD]
-rad0=3DssidEAP-AKA.conf
diff --git a/autotests/testEAP-AKA/sim.db b/autotests/testEAP-AKA/sim.db
deleted file mode 100644
index 526e4bb1..00000000
--- a/autotests/testEAP-AKA/sim.db
+++ /dev/null
@@ -1 +0,0 @@
-32010000000000:90dca4eda45b53cf0f12d7c9c3bc6a89:cb9cccc4b9258e6dca4760379f=
b82581:61df:000000000021
\ No newline at end of file
diff --git a/autotests/testEAP-AKA/sim.eap_user b/autotests/testEAP-AKA/sim=
.eap_user
deleted file mode 100644
index ef82f9f1..00000000
--- a/autotests/testEAP-AKA/sim.eap_user
+++ /dev/null
@@ -1 +0,0 @@
-"032010000000000(a)example.com"	AKA
diff --git a/autotests/testEAP-AKA/sim_keys.conf b/autotests/testEAP-AKA/si=
m_keys.conf
deleted file mode 100644
index fe7a6399..00000000
--- a/autotests/testEAP-AKA/sim_keys.conf
+++ /dev/null
@@ -1,6 +0,0 @@
-[AKA]
-Identity=3D32010000000000(a)example.com
-KI=3D90dca4eda45b53cf0f12d7c9c3bc6a89
-OPC=3Dcb9cccc4b9258e6dca4760379fb82581
-AMF=3D61df
-SQN=3D000000000021
diff --git a/autotests/testEAP-AKA/ssidEAP-AKA.8021x b/autotests/testEAP-AK=
A/ssidEAP-AKA.8021x
deleted file mode 100644
index 304eb276..00000000
--- a/autotests/testEAP-AKA/ssidEAP-AKA.8021x
+++ /dev/null
@@ -1,5 +0,0 @@
-[Security]
-EAP-Method=3DAKA
-
-[Settings]
-AutoConnect=3Dfalse
diff --git a/autotests/testEAP-AKA/ssidEAP-AKA.conf b/autotests/testEAP-AKA=
/ssidEAP-AKA.conf
deleted file mode 100644
index 01f01f45..00000000
--- a/autotests/testEAP-AKA/ssidEAP-AKA.conf
+++ /dev/null
@@ -1,16 +0,0 @@
-hw_mode=3Dg
-channel=3D1
-
-driver=3Dnl80211
-ieee8021x=3D1
-eap_server=3D1
-ssid=3DssidEAP-AKA
-eap_user_file=3D/tmp/sim.eap_user
-eap_sim_db=3Dunix:/tmp/hlrauc.sock
-wpa=3D2
-wpa_key_mgmt=3DWPA-EAP
-wpa_pairwise=3DTKIP CCMP
-rsn_pairwise=3DCCMP TKIP
-wpa_passphrase=3Dsecret123
-channel=3D1
-eap_sim_aka_result_ind=3D1
diff --git a/autotests/testEAP-SIM/connection_test.py b/autotests/testEAP-S=
IM/connection_test.py
deleted file mode 100644
index a7615b52..00000000
--- a/autotests/testEAP-SIM/connection_test.py
+++ /dev/null
@@ -1,74 +0,0 @@
-#!/usr/bin/python3
-
-import unittest
-import sys
-
-sys.path.append('../util')
-import iwd
-from iwd import IWD
-from iwd import NetworkType
-from hlrauc import AuthCenter
-
-from hostapd import HostapdCLI
-
-class Test(unittest.TestCase):
-
-    def test_connection_success(self):
-        hostapd =3D HostapdCLI(config=3D'ssidEAP-SIM.conf')
-
-        auth =3D AuthCenter('/tmp/hlrauc.sock', '/tmp/sim.db')
-
-        wd =3D IWD()
-
-        devices =3D wd.list_devices(1)
-        device =3D devices[0]
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        device.scan()
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        ordered_network =3D device.get_ordered_network('ssidEAP-SIM')
-
-        self.assertEqual(ordered_network.type, NetworkType.eap)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        try:
-                ordered_network.network_object.connect()
-        except:
-                auth.stop()
-                raise
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        hostapd.eapol_reauth(device.address)
-
-        hostapd.wait_for_event('CTRL-EVENT-EAP-STARTED')
-        hostapd.wait_for_event('CTRL-EVENT-EAP-SUCCESS')
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        device.disconnect()
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        auth.stop()
-
-    @classmethod
-    def setUpClass(cls):
-        IWD.copy_to_storage('ssidEAP-SIM.8021x')
-
-    @classmethod
-    def tearDownClass(cls):
-        IWD.clear_storage()
-
-if __name__ =3D=3D '__main__':
-    unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-SIM/hw.conf b/autotests/testEAP-SIM/hw.conf
deleted file mode 100644
index d725e38a..00000000
--- a/autotests/testEAP-SIM/hw.conf
+++ /dev/null
@@ -1,8 +0,0 @@
-[SETUP]
-num_radios=3D2
-max_test_exec_interval_sec=3D40
-tmpfs_extra_stuff=3Dsim.eap_user:sim.db:sim_keys.conf
-sim_keys=3D/tmp/sim_keys.conf
-
-[HOSTAPD]
-rad0=3DssidEAP-SIM.conf
diff --git a/autotests/testEAP-SIM/sim.db b/autotests/testEAP-SIM/sim.db
deleted file mode 100644
index 04f0ac8e..00000000
--- a/autotests/testEAP-SIM/sim.db
+++ /dev/null
@@ -1 +0,0 @@
-32010000000000:D0D1D2D3D4D5D6D7:E1E2E3E4:DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
\ No newline at end of file
diff --git a/autotests/testEAP-SIM/sim.eap_user b/autotests/testEAP-SIM/sim=
.eap_user
deleted file mode 100644
index 17f7e1ae..00000000
--- a/autotests/testEAP-SIM/sim.eap_user
+++ /dev/null
@@ -1 +0,0 @@
-"132010000000000(a)example.com"	SIM
diff --git a/autotests/testEAP-SIM/sim_keys.conf b/autotests/testEAP-SIM/si=
m_keys.conf
deleted file mode 100644
index 000760ad..00000000
--- a/autotests/testEAP-SIM/sim_keys.conf
+++ /dev/null
@@ -1,4 +0,0 @@
-[SIM]
-Identity=3D32010000000000(a)example.com
-Kc=3Dd0d1d2d3d4d5d6d7d0d1d2d3d4d5d6d7d0d1d2d3d4d5d6d7
-SRES=3De1e2e3e4e1e2e3e4e1e2e3e4
diff --git a/autotests/testEAP-SIM/ssidEAP-SIM.8021x b/autotests/testEAP-SI=
M/ssidEAP-SIM.8021x
deleted file mode 100644
index 1dcdbcb6..00000000
--- a/autotests/testEAP-SIM/ssidEAP-SIM.8021x
+++ /dev/null
@@ -1,5 +0,0 @@
-[Security]
-EAP-Method=3DSIM
-
-[Settings]
-AutoConnect=3Dfalse
diff --git a/autotests/testEAP-SIM/ssidEAP-SIM.conf b/autotests/testEAP-SIM=
/ssidEAP-SIM.conf
deleted file mode 100644
index 6071e301..00000000
--- a/autotests/testEAP-SIM/ssidEAP-SIM.conf
+++ /dev/null
@@ -1,16 +0,0 @@
-hw_mode=3Dg
-channel=3D1
-
-driver=3Dnl80211
-ieee8021x=3D1
-eap_server=3D1
-ssid=3DssidEAP-SIM
-eap_user_file=3D/tmp/sim.eap_user
-eap_sim_db=3Dunix:/tmp/hlrauc.sock
-wpa=3D2
-wpa_key_mgmt=3DWPA-EAP
-wpa_pairwise=3DTKIP CCMP
-rsn_pairwise=3DCCMP TKIP
-wpa_passphrase=3Dsecret123
-channel=3D1
-eap_sim_aka_result_ind=3D1
-- =

2.26.2

--===============5488685545581508981==--

