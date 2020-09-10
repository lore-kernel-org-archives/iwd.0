Content-Type: multipart/mixed; boundary="===============6330977531474127583=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 26/26] auto-t: fix testFT-PSK-roam
Date: Thu, 10 Sep 2020 16:12:47 -0700
Message-ID: <20200910231248.4995-26-prestwoj@gmail.com>
In-Reply-To: <20200910231248.4995-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6330977531474127583==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Switched around hwsim rules with the IWD initializer to avoid
IWD periodically scanning before hwsim rules are in place. Removed
some unneeded code during teardown.
---
 autotests/testFT-PSK-roam/connection_test.py | 39 ++++++--------------
 autotests/testFT-PSK-roam/hw.conf            |  1 +
 2 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/autotests/testFT-PSK-roam/connection_test.py b/autotests/testF=
T-PSK-roam/connection_test.py
index 37dd80d0..ccbaccb8 100644
--- a/autotests/testFT-PSK-roam/connection_test.py
+++ b/autotests/testFT-PSK-roam/connection_test.py
@@ -24,7 +24,11 @@ class Test(unittest.TestCase):
         rule1.source =3D self.bss_radio[1].addresses[0]
         rule1.bidirectional =3D True
 =

-        wd =3D self.wd
+        # Check that iwd selects BSS 0 first
+        rule0.signal =3D -2000
+        rule1.signal =3D -2500
+
+        wd =3D IWD(True)
 =

         psk_agent =3D PSKAgent("EasilyGuessedPassword")
         wd.register_psk_agent(psk_agent)
@@ -33,10 +37,6 @@ class Test(unittest.TestCase):
         # prevent autoconnect
         device.disconnect()
 =

-        # Check that iwd selects BSS 0 first
-        rule0.signal =3D -2000
-        rule1.signal =3D -2500
-
         condition =3D 'not obj.scanning'
         wd.wait_for_object_condition(device, condition)
 =

@@ -61,8 +61,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         self.assertTrue(self.bss_hostapd[0].list_sta())
         self.assertFalse(self.bss_hostapd[1].list_sta())
@@ -109,7 +109,11 @@ class Test(unittest.TestCase):
         rule1.source =3D self.bss_radio[1].addresses[0]
         rule1.bidirectional =3D True
 =

-        wd =3D self.wd
+        # Check that iwd selects BSS 0 first
+        rule0.signal =3D -2000
+        rule1.signal =3D -2500
+
+        wd =3D IWD(True)
 =

         psk_agent =3D PSKAgent("EasilyGuessedPassword")
         wd.register_psk_agent(psk_agent)
@@ -118,10 +122,6 @@ class Test(unittest.TestCase):
         # prevent autoconnect
         device.disconnect()
 =

-        # Check that iwd selects BSS 0 first
-        rule0.signal =3D -2000
-        rule1.signal =3D -2500
-
         condition =3D 'not obj.scanning'
         wd.wait_for_object_condition(device, condition)
 =

@@ -180,8 +180,6 @@ class Test(unittest.TestCase):
         testutil.test_ifaces_connected(self.bss_hostapd[1].ifname, device.=
name)
         self.assertRaises(Exception, testutil.test_ifaces_connected,
                           (self.bss_hostapd[0].ifname, device.name))
-    def setUp(self):
-        self.wd =3D IWD()
 =

     def tearDown(self):
         os.system('ifconfig "' + self.bss_hostapd[0].ifname + '" down')
@@ -189,19 +187,6 @@ class Test(unittest.TestCase):
         os.system('ifconfig "' + self.bss_hostapd[0].ifname + '" up')
         os.system('ifconfig "' + self.bss_hostapd[1].ifname + '" up')
 =

-        hwsim =3D Hwsim()
-        device =3D self.wd.list_devices(1)[0]
-        try:
-            device.disconnect()
-        except:
-            pass
-
-        condition =3D 'obj.state =3D=3D DeviceState.disconnected'
-        self.wd.wait_for_object_condition(device, condition)
-
-        for rule in list(hwsim.rules.keys()):
-            del hwsim.rules[rule]
-
     @classmethod
     def setUpClass(cls):
         hwsim =3D Hwsim()
diff --git a/autotests/testFT-PSK-roam/hw.conf b/autotests/testFT-PSK-roam/=
hw.conf
index d2d50863..d08534c4 100644
--- a/autotests/testFT-PSK-roam/hw.conf
+++ b/autotests/testFT-PSK-roam/hw.conf
@@ -3,6 +3,7 @@ num_radios=3D3
 max_test_exec_interval_sec=3D45
 tmpfs_extra_stuff=3Dmain.conf
 needs_hwsim=3D1
+start_iwd=3D0
 =

 [HOSTAPD]
 rad0=3Dft-psk-ccmp-1.conf
-- =

2.26.2

--===============6330977531474127583==--

