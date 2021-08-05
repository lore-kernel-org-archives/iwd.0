Content-Type: multipart/mixed; boundary="===============6512975656720530761=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/6] auto-t: add reassociate test to FT-SAE-roam
Date: Thu, 05 Aug 2021 08:19:56 -0700
Message-ID: <20210805151958.288829-4-prestwoj@gmail.com>
In-Reply-To: <20210805151958.288829-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6512975656720530761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This refactors to test both FT and reassociation.
---
 autotests/testFT-SAE-roam/connection_test.py | 91 +++++++++++++-------
 1 file changed, 61 insertions(+), 30 deletions(-)

diff --git a/autotests/testFT-SAE-roam/connection_test.py b/autotests/testF=
T-SAE-roam/connection_test.py
index bea42856..16316123 100644
--- a/autotests/testFT-SAE-roam/connection_test.py
+++ b/autotests/testFT-SAE-roam/connection_test.py
@@ -14,32 +14,17 @@ import testutil
 from config import ctx
 =

 class Test(unittest.TestCase):
-    def test_roam_success(self):
-        hwsim =3D Hwsim()
-
-        rule0 =3D hwsim.rules.create()
-        rule0.source =3D self.bss_radio[0].addresses[0]
-        rule0.bidirectional =3D True
-
-        rule1 =3D hwsim.rules.create()
-        rule1.source =3D self.bss_radio[1].addresses[0]
-        rule1.bidirectional =3D True
-
-        rule2 =3D hwsim.rules.create()
-        rule2.source =3D self.bss_radio[2].addresses[0]
-        rule2.bidirectional =3D True
-
+    def validate_connection(self, wd, ft=3DTrue):
         # Check that iwd selects BSS 0 first
-        rule0.signal =3D -2000
-        rule1.signal =3D -6900
-        rule2.signal =3D -7200
-
-        wd =3D IWD(True)
+        self.rule[0].signal =3D -2000
+        self.rule[1].signal =3D -6900
+        self.rule[2].signal =3D -7200
 =

         psk_agent =3D PSKAgent("EasilyGuessedPassword")
         wd.register_psk_agent(psk_agent)
 =

         device =3D wd.list_devices(1)[0]
+        device.disconnect()
 =

         condition =3D 'not obj.scanning'
         wd.wait_for_object_condition(device, condition)
@@ -84,7 +69,7 @@ class Test(unittest.TestCase):
         # by mac80211_hwsim will not finish.  If this times out then, but
         # device_roam_trigger_cb has happened, it probably means that
         # Neighbor Reports are broken.
-        rule0.signal =3D -8000
+        self.rule[0].signal =3D -8000
 =

         condition =3D 'obj.state =3D=3D DeviceState.roaming'
         wd.wait_for_object_condition(device, condition)
@@ -95,7 +80,7 @@ class Test(unittest.TestCase):
         to_condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_change(device, from_condition, to_condition)
 =

-        rule1.signal =3D -2000
+        self.rule[1].signal =3D -2000
 =

         # wait for IWD's signal levels to recover
         wd.wait(5)
@@ -107,10 +92,13 @@ class Test(unittest.TestCase):
         self.assertRaises(Exception, testutil.test_ifaces_connected,
                           (self.bss_hostapd[0].ifname, device.name))
 =

-        # test FT-PSK after FT-SAE
-        rule1.signal =3D -8000
-        rule0.signal =3D -8000
-        rule2.signal =3D -1000
+        if not ft:
+                return
+
+         # test FT-PSK after FT-SAE
+        self.rule[1].signal =3D -8000
+        self.rule[0].signal =3D -8000
+        self.rule[2].signal =3D -1000
 =

         condition =3D 'obj.state =3D=3D DeviceState.roaming'
         wd.wait_for_object_condition(device, condition)
@@ -125,6 +113,35 @@ class Test(unittest.TestCase):
         testutil.test_ifaces_connected(self.bss_hostapd[2].ifname, device.=
name)
         self.assertRaises(Exception, testutil.test_ifaces_connected,
                             (self.bss_hostapd[1].ifname, device.name))
+    def test_ft_roam_success(self):
+        wd =3D IWD(True)
+
+        self.bss_hostapd[0].set_value('wpa_key_mgmt', 'FT-SAE SAE')
+        self.bss_hostapd[0].reload()
+        self.bss_hostapd[0].wait_for_event("AP-ENABLED")
+        self.bss_hostapd[1].set_value('wpa_key_mgmt', 'FT-SAE SAE')
+        self.bss_hostapd[1].reload()
+        self.bss_hostapd[1].wait_for_event("AP-ENABLED")
+        self.bss_hostapd[2].set_value('wpa_key_mgmt', 'FT-PSK')
+        self.bss_hostapd[2].reload()
+        self.bss_hostapd[2].wait_for_event("AP-ENABLED")
+
+        self.validate_connection(wd, True)
+
+    def test_reassociate_roam_success(self):
+        wd =3D IWD(True)
+
+        self.bss_hostapd[0].set_value('wpa_key_mgmt', 'SAE')
+        self.bss_hostapd[0].reload()
+        self.bss_hostapd[0].wait_for_event("AP-ENABLED")
+        self.bss_hostapd[1].set_value('wpa_key_mgmt', 'SAE')
+        self.bss_hostapd[1].reload()
+        self.bss_hostapd[1].wait_for_event("AP-ENABLED")
+        self.bss_hostapd[2].set_value('wpa_key_mgmt', 'WPA-PSK')
+        self.bss_hostapd[2].reload()
+        self.bss_hostapd[2].wait_for_event("AP-ENABLED")
+
+        self.validate_connection(wd, False)
 =

     def tearDown(self):
         os.system('ifconfig "' + self.bss_hostapd[0].ifname + '" down')
@@ -134,10 +151,6 @@ class Test(unittest.TestCase):
         os.system('ifconfig "' + self.bss_hostapd[1].ifname + '" up')
         os.system('ifconfig "' + self.bss_hostapd[2].ifname + '" up')
 =

-        hwsim =3D Hwsim()
-        for rule in list(hwsim.rules.keys()):
-            del hwsim.rules[rule]
-
     @classmethod
     def setUpClass(cls):
         hwsim =3D Hwsim()
@@ -149,6 +162,19 @@ class Test(unittest.TestCase):
                            hwsim.get_radio('rad1'),
                            hwsim.get_radio('rad2') ]
 =

+        cls.rule =3D [ hwsim.rules.create(),
+                     hwsim.rules.create(),
+                     hwsim.rules.create() ]
+
+        cls.rule[0].source =3D cls.bss_radio[0].addresses[0]
+        cls.rule[0].bidirectional =3D True
+
+        cls.rule[1].source =3D cls.bss_radio[1].addresses[0]
+        cls.rule[1].bidirectional =3D True
+
+        cls.rule[2].source =3D cls.bss_radio[2].addresses[0]
+        cls.rule[2].bidirectional =3D True
+
         ctx.start_process(['ifconfig', cls.bss_hostapd[0].ifname, 'down', =
'hw', \
                                 'ether', '12:00:00:00:00:01', 'up'], wait=
=3DTrue)
         ctx.start_process(['ifconfig', cls.bss_hostapd[1].ifname, 'down', =
'hw', \
@@ -187,6 +213,11 @@ class Test(unittest.TestCase):
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
+
+        hwsim =3D Hwsim()
+        for rule in list(hwsim.rules.keys()):
+            del hwsim.rules[rule]
+
         cls.bss_hostapd =3D None
         cls.bss_radio =3D None
 =

-- =

2.31.1

--===============6512975656720530761==--

