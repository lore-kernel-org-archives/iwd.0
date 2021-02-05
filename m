Content-Type: multipart/mixed; boundary="===============6836126635309985503=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] auto-t: update roaming tests with wait_for_object_change
Date: Fri, 05 Feb 2021 11:06:37 -0800
Message-ID: <20210205190637.325992-2-prestwoj@gmail.com>
In-Reply-To: <20210205190637.325992-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6836126635309985503==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Every single roaming test had one of two problems with watching the
state change between roaming --> connected. Either the test used
wait_for_object_condition to wait for 'connected' which could allow
other states in between. Or it simply used an assert. The assert
wouldn't allow other state changes, but at the cost of potentially
failing due to IWD not having made it to the 'connected' state yet.

Now we have wait_for_object_change which takes two conditions:
initial (from_str) and expected (to_str). This API will not allow
any other conditions except these, and will wait for the expected
condition before continuing. This allows roaming test to reliably
wait for the roaming --> connected state change.
---
 autotests/testFT-8021x-roam/connection_test.py  | 8 +++-----
 autotests/testFT-FILS-SHA256/connection_test.py | 8 +++-----
 autotests/testFT-FILS-SHA384/connection_test.py | 6 +++---
 autotests/testFT-PSK-over-DS/connection_test.py | 8 +++-----
 autotests/testFT-PSK-roam/connection_test.py    | 7 +++----
 autotests/testFT-SAE-roam/connection_test.py    | 6 +++---
 autotests/testPreauth-roam/connection_test.py   | 6 +++---
 autotests/testRoamRetry/fast_retry_test.py      | 6 +++---
 autotests/testRoamRetry/stop_retry_test.py      | 6 +++---
 9 files changed, 27 insertions(+), 34 deletions(-)

diff --git a/autotests/testFT-8021x-roam/connection_test.py b/autotests/tes=
tFT-8021x-roam/connection_test.py
index 6e905f0d..c50c90ee 100644
--- a/autotests/testFT-8021x-roam/connection_test.py
+++ b/autotests/testFT-8021x-roam/connection_test.py
@@ -79,11 +79,9 @@ class Test(unittest.TestCase):
 =

         # Check that iwd is on BSS 1 once out of roaming state and doesn't
         # go through 'disconnected', 'autoconnect', 'connecting' in between
-        condition =3D 'obj.state !=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition)
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
+        from_condition =3D 'obj.state =3D=3D DeviceState.roaming'
+        to_condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_change(device, from_condition, to_condition)
 =

         self.assertTrue(self.bss_hostapd[1].list_sta())
 =

diff --git a/autotests/testFT-FILS-SHA256/connection_test.py b/autotests/te=
stFT-FILS-SHA256/connection_test.py
index 267639cd..81201e08 100644
--- a/autotests/testFT-FILS-SHA256/connection_test.py
+++ b/autotests/testFT-FILS-SHA256/connection_test.py
@@ -109,11 +109,9 @@ class Test(unittest.TestCase):
 =

         # Check that iwd is on BSS 1 once out of roaming state and doesn't
         # go through 'disconnected', 'autoconnect', 'connecting' in between
-        condition =3D 'obj.state !=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition)
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
+        from_condition =3D 'obj.state =3D=3D DeviceState.roaming'
+        to_condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_change(device, from_condition, to_condition)
 =

         self.assertTrue(self.bss_hostapd[1].list_sta())
 =

diff --git a/autotests/testFT-FILS-SHA384/connection_test.py b/autotests/te=
stFT-FILS-SHA384/connection_test.py
index 12a85e3f..81201e08 100644
--- a/autotests/testFT-FILS-SHA384/connection_test.py
+++ b/autotests/testFT-FILS-SHA384/connection_test.py
@@ -109,10 +109,10 @@ class Test(unittest.TestCase):
 =

         # Check that iwd is on BSS 1 once out of roaming state and doesn't
         # go through 'disconnected', 'autoconnect', 'connecting' in between
-        condition =3D 'obj.state !=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition)
+        from_condition =3D 'obj.state =3D=3D DeviceState.roaming'
+        to_condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_change(device, from_condition, to_condition)
 =

-        self.assertEqual(device.state, iwd.DeviceState.connected)
         self.assertTrue(self.bss_hostapd[1].list_sta())
 =

         testutil.test_iface_operstate(device.name)
diff --git a/autotests/testFT-PSK-over-DS/connection_test.py b/autotests/te=
stFT-PSK-over-DS/connection_test.py
index b6cad5a4..ad186d07 100644
--- a/autotests/testFT-PSK-over-DS/connection_test.py
+++ b/autotests/testFT-PSK-over-DS/connection_test.py
@@ -85,11 +85,9 @@ class Test(unittest.TestCase):
 =

         # Check that iwd is on BSS 1 once out of roaming state and doesn't
         # go through 'disconnected', 'autoconnect', 'connecting' in between
-        condition =3D 'obj.state !=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition)
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
+        from_condition =3D 'obj.state =3D=3D DeviceState.roaming'
+        to_condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_change(device, from_condition, to_condition)
 =

         self.assertTrue(self.bss_hostapd[1].list_sta())
 =

diff --git a/autotests/testFT-PSK-roam/connection_test.py b/autotests/testF=
T-PSK-roam/connection_test.py
index a7acf495..c0eec0ae 100644
--- a/autotests/testFT-PSK-roam/connection_test.py
+++ b/autotests/testFT-PSK-roam/connection_test.py
@@ -87,11 +87,10 @@ class Test(unittest.TestCase):
 =

         # Check that iwd is on BSS 1 once out of roaming state and doesn't
         # go through 'disconnected', 'autoconnect', 'connecting' in between
-        condition =3D 'obj.state !=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition)
+        from_condition =3D 'obj.state =3D=3D DeviceState.roaming'
+        to_condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_change(device, from_condition, to_condition)
 =

-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
         self.assertTrue(self.bss_hostapd[1].list_sta())
 =

         testutil.test_iface_operstate(device.name)
diff --git a/autotests/testFT-SAE-roam/connection_test.py b/autotests/testF=
T-SAE-roam/connection_test.py
index a8d1da6c..f2c694dd 100644
--- a/autotests/testFT-SAE-roam/connection_test.py
+++ b/autotests/testFT-SAE-roam/connection_test.py
@@ -91,15 +91,15 @@ class Test(unittest.TestCase):
 =

         # Check that iwd is on BSS 1 once out of roaming state and doesn't
         # go through 'disconnected', 'autoconnect', 'connecting' in between
-        condition =3D 'obj.state !=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition)
+        from_condition =3D 'obj.state =3D=3D DeviceState.roaming'
+        to_condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_change(device, from_condition, to_condition)
 =

         rule1.signal =3D -2000
 =

         # wait for IWD's signal levels to recover
         wd.wait(5)
 =

-        self.assertEqual(device.state, iwd.DeviceState.connected)
         self.assertTrue(self.bss_hostapd[1].list_sta())
 =

         testutil.test_iface_operstate(device.name)
diff --git a/autotests/testPreauth-roam/connection_test.py b/autotests/test=
Preauth-roam/connection_test.py
index 5eee3078..8a50abb5 100644
--- a/autotests/testPreauth-roam/connection_test.py
+++ b/autotests/testPreauth-roam/connection_test.py
@@ -97,10 +97,10 @@ class Test(unittest.TestCase):
 =

         # Check that iwd is on BSS 1 once out of roaming state and doesn't
         # go through 'disconnected', 'autoconnect', 'connecting' in between
-        condition =3D 'obj.state !=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition)
+        from_condition =3D 'obj.state =3D=3D DeviceState.roaming'
+        to_condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_change(device, from_condition, to_condition)
 =

-        self.assertEqual(device.state, iwd.DeviceState.connected)
         self.assertTrue(bss_hostapd[1].list_sta())
 =

         testutil.test_iface_operstate(device.name)
diff --git a/autotests/testRoamRetry/fast_retry_test.py b/autotests/testRoa=
mRetry/fast_retry_test.py
index 32d80002..ce2c5603 100644
--- a/autotests/testRoamRetry/fast_retry_test.py
+++ b/autotests/testRoamRetry/fast_retry_test.py
@@ -117,10 +117,10 @@ class Test(unittest.TestCase):
 =

         # Check that iwd is on BSS 1 once out of roaming state and doesn't
         # go through 'disconnected', 'autoconnect', 'connecting' in between
-        condition =3D 'obj.state !=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition, max_wait=3D5)
+        from_condition =3D 'obj.state =3D=3D DeviceState.roaming'
+        to_condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_change(device, from_condition, to_condition)
 =

-        self.assertEqual(device.state, iwd.DeviceState.connected)
         self.assertTrue(bss_hostapd[1].list_sta())
 =

         device.disconnect()
diff --git a/autotests/testRoamRetry/stop_retry_test.py b/autotests/testRoa=
mRetry/stop_retry_test.py
index a2729d6c..38f58398 100644
--- a/autotests/testRoamRetry/stop_retry_test.py
+++ b/autotests/testRoamRetry/stop_retry_test.py
@@ -92,10 +92,10 @@ class Test(unittest.TestCase):
 =

         # Check that iwd is on BSS 1 once out of roaming state and doesn't
         # go through 'disconnected', 'autoconnect', 'connecting' in between
-        condition =3D 'obj.state !=3D DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition)
+        from_condition =3D 'obj.state =3D=3D DeviceState.roaming'
+        to_condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_change(device, from_condition, to_condition)
 =

-        self.assertEqual(device.state, iwd.DeviceState.connected)
         self.assertTrue(bss_hostapd[1].list_sta())
 =

         # Now make sure that we don't roam anymore. In order to catch this=
 via
-- =

2.26.2

--===============6836126635309985503==--

