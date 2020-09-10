Content-Type: multipart/mixed; boundary="===============5326073743549243264=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 16/26] auto-t: Increase all test timeouts
Date: Thu, 10 Sep 2020 16:12:37 -0700
Message-ID: <20200910231248.4995-16-prestwoj@gmail.com>
In-Reply-To: <20200910231248.4995-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5326073743549243264==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Slower systems may not be able to make some timeouts that tests
mandated. All timeouts were increased significantly to allow tests
to pass on slow systems.
---
 autotests/testAPRoam/connection_test.py           | 4 ++--
 autotests/testBSSBlacklist/connection_test.py     | 4 ++--
 autotests/testFT-8021x-roam/connection_test.py    | 8 ++++----
 autotests/testFT-FILS-SHA256/connection_test.py   | 4 ++--
 autotests/testFT-FILS-SHA384/connection_test.py   | 4 ++--
 autotests/testFT-PSK-over-DS/connection_test.py   | 4 ++--
 autotests/testFT-PSK-roam/connection_test.py      | 4 ++--
 autotests/testFT-SAE-roam/connection_test.py      | 8 ++++----
 autotests/testHiddenNetworks/validation.py        | 6 +++---
 autotests/testKnownNetworks/known_network_test.py | 4 ++--
 autotests/testPreauth-roam/connection_test.py     | 4 ++--
 autotests/testRSSIAgent/connection_test.py        | 2 +-
 autotests/testSAE/autoconnect_test.py             | 2 +-
 autotests/testScan/requested_scan_test.py         | 4 ++--
 autotests/util/iwd.py                             | 8 ++++----
 autotests/util/testutil.py                        | 2 +-
 tools/test-runner                                 | 2 +-
 17 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/autotests/testAPRoam/connection_test.py b/autotests/testAPRoam=
/connection_test.py
index c8c2ca9f..308bbc28 100644
--- a/autotests/testAPRoam/connection_test.py
+++ b/autotests/testAPRoam/connection_test.py
@@ -60,10 +60,10 @@ class Test(unittest.TestCase):
                  (bss_radio[2].addresses[0], '8f0000005103060603000000')])
 =

         condition =3D 'obj.state =3D=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition, 15)
+        wd.wait_for_object_condition(device, condition)
 =

         condition =3D 'obj.state !=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition, 5)
+        wd.wait_for_object_condition(device, condition)
 =

         self.assertEqual(device.state, iwd.DeviceState.connected)
         self.assertTrue(bss_hostapd[1].list_sta())
diff --git a/autotests/testBSSBlacklist/connection_test.py b/autotests/test=
BSSBlacklist/connection_test.py
index 825439d4..0a51b8cb 100644
--- a/autotests/testBSSBlacklist/connection_test.py
+++ b/autotests/testBSSBlacklist/connection_test.py
@@ -99,10 +99,10 @@ class Test(unittest.TestCase):
         # Now we wait... AutoConnect should take over
 =

         condition =3D 'obj.state =3D=3D DeviceState.connecting'
-        wd.wait_for_object_condition(device, condition, 15)
+        wd.wait_for_object_condition(device, condition)
 =

         condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition, 15)
+        wd.wait_for_object_condition(device, condition)
 =

         # Same as before, make sure we didn't connect to the blacklisted A=
P.
         self.assertNotIn(device.address, bss_hostapd[0].list_sta())
diff --git a/autotests/testFT-8021x-roam/connection_test.py b/autotests/tes=
tFT-8021x-roam/connection_test.py
index 65c73492..084bac64 100644
--- a/autotests/testFT-8021x-roam/connection_test.py
+++ b/autotests/testFT-8021x-roam/connection_test.py
@@ -75,12 +75,12 @@ class Test(unittest.TestCase):
         rule0.signal =3D -8000
 =

         condition =3D 'obj.state =3D=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition, 10)
+        wd.wait_for_object_condition(device, condition)
 =

         # Check that iwd is on BSS 1 once out of roaming state and doesn't
         # go through 'disconnected', 'autoconnect', 'connecting' in between
         condition =3D 'obj.state !=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition, 5)
+        wd.wait_for_object_condition(device, condition)
 =

         self.assertEqual(device.state, iwd.DeviceState.connected)
         self.assertTrue(self.bss_hostapd[1].list_sta())
@@ -151,12 +151,12 @@ class Test(unittest.TestCase):
         rule0.drop =3D False
 =

         condition =3D 'obj.state =3D=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition, 20)
+        wd.wait_for_object_condition(device, condition)
 =

         # Check that iwd is on BSS 1 once out of roaming state and doesn't
         # go through 'disconnected', 'autoconnect', 'connecting' in between
         condition =3D 'obj.state !=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition, 5)
+        wd.wait_for_object_condition(device, condition)
 =

         self.assertEqual(device.state, iwd.DeviceState.connected)
         self.assertTrue(self.bss_hostapd[1].list_sta())
diff --git a/autotests/testFT-FILS-SHA256/connection_test.py b/autotests/te=
stFT-FILS-SHA256/connection_test.py
index 16f46210..d87afce0 100644
--- a/autotests/testFT-FILS-SHA256/connection_test.py
+++ b/autotests/testFT-FILS-SHA256/connection_test.py
@@ -105,12 +105,12 @@ class Test(unittest.TestCase):
         rule0.signal =3D -8000
 =

         condition =3D 'obj.state =3D=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition, 10)
+        wd.wait_for_object_condition(device, condition)
 =

         # Check that iwd is on BSS 1 once out of roaming state and doesn't
         # go through 'disconnected', 'autoconnect', 'connecting' in between
         condition =3D 'obj.state !=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition, 5)
+        wd.wait_for_object_condition(device, condition)
 =

         self.assertEqual(device.state, iwd.DeviceState.connected)
         self.assertTrue(self.bss_hostapd[1].list_sta())
diff --git a/autotests/testFT-FILS-SHA384/connection_test.py b/autotests/te=
stFT-FILS-SHA384/connection_test.py
index 16f46210..d87afce0 100644
--- a/autotests/testFT-FILS-SHA384/connection_test.py
+++ b/autotests/testFT-FILS-SHA384/connection_test.py
@@ -105,12 +105,12 @@ class Test(unittest.TestCase):
         rule0.signal =3D -8000
 =

         condition =3D 'obj.state =3D=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition, 10)
+        wd.wait_for_object_condition(device, condition)
 =

         # Check that iwd is on BSS 1 once out of roaming state and doesn't
         # go through 'disconnected', 'autoconnect', 'connecting' in between
         condition =3D 'obj.state !=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition, 5)
+        wd.wait_for_object_condition(device, condition)
 =

         self.assertEqual(device.state, iwd.DeviceState.connected)
         self.assertTrue(self.bss_hostapd[1].list_sta())
diff --git a/autotests/testFT-PSK-over-DS/connection_test.py b/autotests/te=
stFT-PSK-over-DS/connection_test.py
index 2cfdf245..188eca63 100644
--- a/autotests/testFT-PSK-over-DS/connection_test.py
+++ b/autotests/testFT-PSK-over-DS/connection_test.py
@@ -81,12 +81,12 @@ class Test(unittest.TestCase):
         rule0.signal =3D -8000
 =

         condition =3D 'obj.state =3D=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition, 10)
+        wd.wait_for_object_condition(device, condition)
 =

         # Check that iwd is on BSS 1 once out of roaming state and doesn't
         # go through 'disconnected', 'autoconnect', 'connecting' in between
         condition =3D 'obj.state !=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition, 5)
+        wd.wait_for_object_condition(device, condition)
 =

         self.assertEqual(device.state, iwd.DeviceState.connected)
         self.assertTrue(self.bss_hostapd[1].list_sta())
diff --git a/autotests/testFT-PSK-roam/connection_test.py b/autotests/testF=
T-PSK-roam/connection_test.py
index f40fdf58..37dd80d0 100644
--- a/autotests/testFT-PSK-roam/connection_test.py
+++ b/autotests/testFT-PSK-roam/connection_test.py
@@ -83,12 +83,12 @@ class Test(unittest.TestCase):
         rule0.signal =3D -8000
 =

         condition =3D 'obj.state =3D=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition, 10)
+        wd.wait_for_object_condition(device, condition)
 =

         # Check that iwd is on BSS 1 once out of roaming state and doesn't
         # go through 'disconnected', 'autoconnect', 'connecting' in between
         condition =3D 'obj.state !=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition, 5)
+        wd.wait_for_object_condition(device, condition)
 =

         self.assertEqual(device.state, iwd.DeviceState.connected)
         self.assertTrue(self.bss_hostapd[1].list_sta())
diff --git a/autotests/testFT-SAE-roam/connection_test.py b/autotests/testF=
T-SAE-roam/connection_test.py
index 3e209560..dcea148c 100644
--- a/autotests/testFT-SAE-roam/connection_test.py
+++ b/autotests/testFT-SAE-roam/connection_test.py
@@ -86,12 +86,12 @@ class Test(unittest.TestCase):
         rule0.signal =3D -8000
 =

         condition =3D 'obj.state =3D=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition, 10)
+        wd.wait_for_object_condition(device, condition)
 =

         # Check that iwd is on BSS 1 once out of roaming state and doesn't
         # go through 'disconnected', 'autoconnect', 'connecting' in between
         condition =3D 'obj.state !=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition, 5)
+        wd.wait_for_object_condition(device, condition)
 =

         rule1.signal =3D -2000
 =

@@ -112,10 +112,10 @@ class Test(unittest.TestCase):
         rule2.signal =3D -1000
 =

         condition =3D 'obj.state =3D=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition, 15)
+        wd.wait_for_object_condition(device, condition)
 =

         condition =3D 'obj.state !=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition, 5)
+        wd.wait_for_object_condition(device, condition)
 =

         self.assertEqual(device.state, iwd.DeviceState.connected)
         self.assertTrue(self.bss_hostapd[2].list_sta())
diff --git a/autotests/testHiddenNetworks/validation.py b/autotests/testHid=
denNetworks/validation.py
index 780af8b3..7ff7075a 100644
--- a/autotests/testHiddenNetworks/validation.py
+++ b/autotests/testHiddenNetworks/validation.py
@@ -20,12 +20,12 @@ class TestConnectAutoConnect(unittest.TestCase):
             device.connect_hidden_network(ssid)
 =

         condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition, 30)
+        wd.wait_for_object_condition(device, condition)
 =

     def check_autoconnect_hidden_network(self, wd, device, ssid, throws):
         if throws is None:
             condition =3D 'obj.state =3D=3D DeviceState.connected'
-            wd.wait_for_object_condition(device, condition, 30)
+            wd.wait_for_object_condition(device, condition)
 =

             condition =3D 'obj.connected_network is not None'
             wd.wait_for_object_condition(device, condition)
@@ -37,7 +37,7 @@ class TestConnectAutoConnect(unittest.TestCase):
             device.disconnect()
 =

         condition =3D 'obj.state =3D=3D DeviceState.disconnected'
-        wd.wait_for_object_condition(device, condition, 30)
+        wd.wait_for_object_condition(device, condition)
 =

     def validate_connection(self, wd, ssid, autoconnect, throws, use_agent,
                                                             wait_periodic_=
scan):
diff --git a/autotests/testKnownNetworks/known_network_test.py b/autotests/=
testKnownNetworks/known_network_test.py
index b2b3d105..a94a2151 100644
--- a/autotests/testKnownNetworks/known_network_test.py
+++ b/autotests/testKnownNetworks/known_network_test.py
@@ -56,7 +56,7 @@ class Test(unittest.TestCase):
 =

         IWD.copy_to_storage('known_networks/ssidPSK.psk')
         condition =3D 'len(obj.list_known_networks()) =3D=3D 5'
-        wd.wait_for_object_condition(wd, condition, 1)
+        wd.wait_for_object_condition(wd, condition)
 =

         expected =3D ['ssidNew', 'ssidOpen', 'ssidPSK', 'ssidEAP-TLS',
                     'Hotspot Network']
@@ -65,7 +65,7 @@ class Test(unittest.TestCase):
 =

         IWD.remove_from_storage('ssidPSK.psk')
         condition =3D 'len(obj.list_known_networks()) =3D=3D 4'
-        wd.wait_for_object_condition(wd, condition, 1)
+        wd.wait_for_object_condition(wd, condition)
 =

         for net in known_networks:
             net.forget()
diff --git a/autotests/testPreauth-roam/connection_test.py b/autotests/test=
Preauth-roam/connection_test.py
index ed043c3f..839e04b0 100644
--- a/autotests/testPreauth-roam/connection_test.py
+++ b/autotests/testPreauth-roam/connection_test.py
@@ -91,14 +91,14 @@ class Test(unittest.TestCase):
         rule0.signal =3D -8000
 =

         condition =3D 'obj.state =3D=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition, 15)
+        wd.wait_for_object_condition(device, condition)
 =

         # TODO: verify that the PMK from preauthentication was used
 =

         # Check that iwd is on BSS 1 once out of roaming state and doesn't
         # go through 'disconnected', 'autoconnect', 'connecting' in between
         condition =3D 'obj.state !=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition, 5)
+        wd.wait_for_object_condition(device, condition)
 =

         self.assertEqual(device.state, iwd.DeviceState.connected)
         self.assertTrue(bss_hostapd[1].list_sta())
diff --git a/autotests/testRSSIAgent/connection_test.py b/autotests/testRSS=
IAgent/connection_test.py
index f8140850..ab0bc3a5 100644
--- a/autotests/testRSSIAgent/connection_test.py
+++ b/autotests/testRSSIAgent/connection_test.py
@@ -71,7 +71,7 @@ class Test(unittest.TestCase):
                 rule.signal =3D centre
                 agent.level =3D -1
                 condition =3D 'obj.level =3D=3D ' + str(level)
-                wd.wait_for_object_condition(agent, condition, 3)
+                wd.wait_for_object_condition(agent, condition)
 =

                 self.assertTrue(agent.calls > 0)
                 self.assertEqual(agent.device_path, device.device_path)
diff --git a/autotests/testSAE/autoconnect_test.py b/autotests/testSAE/auto=
connect_test.py
index 0613d91e..48b4b6cd 100644
--- a/autotests/testSAE/autoconnect_test.py
+++ b/autotests/testSAE/autoconnect_test.py
@@ -24,7 +24,7 @@ class Test(unittest.TestCase):
         devices[3].disconnect()
 =

         condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition, 30)
+        wd.wait_for_object_condition(device, condition)
 =

         condition =3D 'obj.connected_network is not None'
         wd.wait_for_object_condition(device, condition)
diff --git a/autotests/testScan/requested_scan_test.py b/autotests/testScan=
/requested_scan_test.py
index 11282ce1..3858b4f5 100644
--- a/autotests/testScan/requested_scan_test.py
+++ b/autotests/testScan/requested_scan_test.py
@@ -36,9 +36,9 @@ class Test(unittest.TestCase):
         device =3D devices[0]
 =

         condition =3D 'obj.scanning'
-        wd.wait_for_object_condition(device, condition, 20)
+        wd.wait_for_object_condition(device, condition)
         condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition, 20)
+        wd.wait_for_object_condition(device, condition)
 =

         device.scan()
 =

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index ec5e662f..e74a6faf 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -867,8 +867,8 @@ class IWD(AsyncOpAbstract):
 =

         tries =3D 0
         while not self._bus.name_has_owner(IWD_SERVICE):
-            if ctx.args.gdb =3D=3D 'None':
-                if tries > 100:
+            if not ctx.args.gdb:
+                if tries > 200:
                     if start_iwd_daemon:
                         ctx.stop_process(self._iwd_proc)
                         self._iwd_proc =3D None
@@ -913,7 +913,7 @@ class IWD(AsyncOpAbstract):
                                IWD_AGENT_MANAGER_INTERFACE)
         return self._agent_manager_if
 =

-    def wait_for_object_condition(self, obj, condition_str, max_wait =3D 1=
5):
+    def wait_for_object_condition(self, obj, condition_str, max_wait =3D 5=
0):
         self._wait_timed_out =3D False
         def wait_timeout_cb():
             self._wait_timed_out =3D True
@@ -982,7 +982,7 @@ class IWD(AsyncOpAbstract):
     def remove_from_storage(file_name):
         os.system('rm -rf ' + IWD_STORAGE_DIR + '/\'' + file_name + '\'')
 =

-    def list_devices(self, wait_to_appear =3D 0, max_wait =3D 15):
+    def list_devices(self, wait_to_appear =3D 0, max_wait =3D 50):
         if not wait_to_appear:
             return list(self._devices.values())
 =

diff --git a/autotests/util/testutil.py b/autotests/util/testutil.py
index 0a94e23a..f9cfbf29 100644
--- a/autotests/util/testutil.py
+++ b/autotests/util/testutil.py
@@ -82,7 +82,7 @@ def test_connected(if0=3DNone, if1=3DNone, group=3DTrue):
             rec.append(False)
 =

         while not all(rec):
-            r, w, x =3D select.select([sock0, sock1], [], [], 1.0)
+            r, w, x =3D select.select([sock0, sock1], [], [], 10)
             if not r:
                 raise Exception('timeout waiting for packets: ' + repr(rec=
))
 =

diff --git a/tools/test-runner b/tools/test-runner
index d09f08d2..d7f831ac 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -43,7 +43,7 @@ config =3D None
 intf_id =3D 0
 rad_id =3D 0
 =

-TEST_MAX_TIMEOUT =3D 45
+TEST_MAX_TIMEOUT =3D 120
 =

 dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
 =

-- =

2.26.2

--===============5326073743549243264==--

