Content-Type: multipart/mixed; boundary="===============8245936784190439385=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v2 3/3] auto-t: Validate Connect after ConnectHiddenNetwork
Date: Tue, 09 Jun 2020 18:22:21 -0700
Message-ID: <20200610012221.19263-3-tim.a.kourt@linux.intel.com>
In-Reply-To: <20200610012221.19263-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8245936784190439385==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 .../connect_after_hidden_connect_test.py           | 78 ++++++++++++++++++=
++++
 autotests/testHiddenNetworks/hw.conf               |  3 +-
 autotests/testHiddenNetworks/ssidSomeHidden.conf   |  9 +++
 3 files changed, 89 insertions(+), 1 deletion(-)
 create mode 100644 autotests/testHiddenNetworks/connect_after_hidden_conne=
ct_test.py
 create mode 100644 autotests/testHiddenNetworks/ssidSomeHidden.conf

diff --git a/autotests/testHiddenNetworks/connect_after_hidden_connect_test=
.py b/autotests/testHiddenNetworks/connect_after_hidden_connect_test.py
new file mode 100644
index 00000000..478f1505
--- /dev/null
+++ b/autotests/testHiddenNetworks/connect_after_hidden_connect_test.py
@@ -0,0 +1,78 @@
+#!/usr/bin/python3
+
+import unittest
+import sys
+
+sys.path.append('../util')
+import iwd
+from iwd import IWD
+from iwd import PSKAgent
+import testutil
+import time
+
+class TestConnectionAfterHiddenNetwork(unittest.TestCase):
+    '''
+    Tries to reproduce a memory leak caused by the consecutive calls to
+    ConnectHiddenNetwork and Connect one after another.
+
+    '''
+    _ex =3D None
+    _done =3D False
+
+    def _success(self):
+        self._done =3D True
+
+    def _failure(self, ex):
+        self._done =3D True
+        self._ex =3D ex
+
+    def test_connection(self):
+        wd =3D IWD(True, '/tmp')
+
+        psk_agent =3D PSKAgent("secret123")
+        wd.register_psk_agent(psk_agent)
+
+        device =3D wd.list_devices(1)[0]
+        ordered_network =3D device.get_ordered_network('ssidOpen',
+                                                     scan_if_needed=3DTrue)
+
+        device.connect_hidden_network_async(name=3D'ssidSomeHidden',
+                                                  reply_handler =3D self._=
success,
+                                                  error_handler =3D self._=
failure)
+
+        ordered_network.network_object.connect()
+
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
+        condition =3D 'obj.connected_network is not None'
+        wd.wait_for_object_condition(device, condition)
+
+        testutil.test_iface_operstate(device.name)
+        device.disconnect()
+
+        condition =3D 'obj.state =3D=3D DeviceState.disconnected'
+        wd.wait_for_object_condition(device, condition)
+
+        wd.unregister_psk_agent(psk_agent)
+
+        IWD.clear_storage()
+
+        while not self._done:
+            time.sleep(.300)
+
+        if self._ex is not None:
+            if self._ex.get_dbus_name() !=3D 'net.connman.iwd.Failed':
+                raise self._ex
+
+
+    @classmethod
+    def setUpClass(cls):
+        pass
+
+    @classmethod
+    def tearDownClass(cls):
+        IWD.clear_storage()
+
+if __name__ =3D=3D '__main__':
+    unittest.main(exit=3DTrue)
diff --git a/autotests/testHiddenNetworks/hw.conf b/autotests/testHiddenNet=
works/hw.conf
index edd061a8..7147e4be 100644
--- a/autotests/testHiddenNetworks/hw.conf
+++ b/autotests/testHiddenNetworks/hw.conf
@@ -1,5 +1,5 @@
 [SETUP]
-num_radios=3D6
+num_radios=3D7
 start_iwd=3D0
 max_test_exec_interval_sec=3D160
 tmpfs_extra_stuff=3Dmain.conf
@@ -10,3 +10,4 @@ rad1=3DssidHiddenWPA.conf
 rad2=3DssidOverlap1.conf
 rad3=3DssidOverlap2.conf
 rad4=3DssidOpen.conf
+rad5=3DssidSomeHidden.conf
diff --git a/autotests/testHiddenNetworks/ssidSomeHidden.conf b/autotests/t=
estHiddenNetworks/ssidSomeHidden.conf
new file mode 100644
index 00000000..42c69b3a
--- /dev/null
+++ b/autotests/testHiddenNetworks/ssidSomeHidden.conf
@@ -0,0 +1,9 @@
+hw_mode=3Dg
+channel=3D1
+ssid=3DssidSomeHidden
+
+wpa=3D1
+wpa_pairwise=3DTKIP
+wpa_passphrase=3Dsecret123
+
+ignore_broadcast_ssid=3D1
-- =

2.13.6

--===============8245936784190439385==--

