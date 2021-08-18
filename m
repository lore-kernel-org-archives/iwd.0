Content-Type: multipart/mixed; boundary="===============2451830517408219916=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] auto-t: fix error handling in testHotspot
Date: Wed, 18 Aug 2021 10:26:02 -0700
Message-ID: <20210818172603.266294-3-prestwoj@gmail.com>
In-Reply-To: <20210818172603.266294-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2451830517408219916==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

testHotspot suffered from improper cleanup and if a single test failed
all subsequent tests would fail due to IWD still running since IWD()
was never cleaned up.

In addition the PSK agent and hwsim rules are now set onto the cls
object and removed in tearDownClass()
---
 autotests/testHotspot/anqp_delay_test.py  | 38 ++++++++++++++---------
 autotests/testHotspot/autoconnect_test.py |  6 +++-
 autotests/testHotspot/hessid_test.py      |  6 +++-
 autotests/testHotspot/hotspot_test.py     |  6 +++-
 autotests/testHotspot/roaming_test.py     | 14 +++++----
 5 files changed, 46 insertions(+), 24 deletions(-)

diff --git a/autotests/testHotspot/anqp_delay_test.py b/autotests/testHotsp=
ot/anqp_delay_test.py
index 04e5a1d7..22a5bdbe 100644
--- a/autotests/testHotspot/anqp_delay_test.py
+++ b/autotests/testHotspot/anqp_delay_test.py
@@ -17,19 +17,9 @@ from time import sleep
 class Test(unittest.TestCase):
 =

     def test_connection_success(self):
-        hwsim =3D Hwsim()
-
-        bss_radio =3D hwsim.get_radio('rad0')
-        rule0 =3D hwsim.rules.create()
-        rule0.source =3D bss_radio.addresses[0]
-        rule0.bidirectional =3D True
-
-        wd =3D IWD(True)
-
-        hapd =3D HostapdCLI(config=3D'ssidHotspot.conf')
-
-        psk_agent =3D PSKAgent('abc', ('domain\\user', 'testpasswd'))
-        wd.register_psk_agent(psk_agent)
+        wd =3D self.wd
+        hapd =3D self.hapd
+        rule0 =3D self.rule0
 =

         devices =3D wd.list_devices(1)
         device =3D devices[0]
@@ -82,17 +72,35 @@ class Test(unittest.TestCase):
         condition =3D 'not obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
 =

-        wd.unregister_psk_agent(psk_agent)
-
     @classmethod
     def setUpClass(cls):
+        cls.hwsim =3D Hwsim()
+
+        bss_radio =3D cls.hwsim.get_radio('rad0')
+        cls.rule0 =3D cls.hwsim.rules.create()
+        cls.rule0.source =3D bss_radio.addresses[0]
+        cls.rule0.bidirectional =3D True
+
+        cls.hapd =3D HostapdCLI(config=3D'ssidHotspot.conf')
+
         IWD.copy_to_hotspot('example.conf')
         IWD.copy_to_storage('anqp_enabled.conf', storage_dir=3DIWD_CONFIG_=
DIR, name=3D'main.conf')
 =

+        cls.wd =3D IWD(True)
+        cls.psk_agent =3D PSKAgent('abc', ('domain\\user', 'testpasswd'))
+        cls.wd.register_psk_agent(cls.psk_agent)
+
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
+
+        cls.wd.unregister_psk_agent(cls.psk_agent)
+        cls.psk_agent =3D None
         os.remove('/tmp/main.conf')
 =

+        cls.hwsim.rules.remove_all()
+        cls.hwsim =3D None
+        cls.wd =3D None
+
 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
diff --git a/autotests/testHotspot/autoconnect_test.py b/autotests/testHots=
pot/autoconnect_test.py
index 777a0670..8b718dc7 100644
--- a/autotests/testHotspot/autoconnect_test.py
+++ b/autotests/testHotspot/autoconnect_test.py
@@ -14,7 +14,7 @@ import testutil
 class Test(unittest.TestCase):
 =

     def test_connection_success(self):
-        wd =3D IWD(True, '/tmp')
+        wd =3D self.wd
 =

         hapd_hotspot =3D HostapdCLI(config=3D'ssidHotspot.conf')
         hapd_wpa =3D HostapdCLI(config=3D'ssidWPA2-1.conf')
@@ -111,10 +111,14 @@ class Test(unittest.TestCase):
         IWD.copy_to_storage('ssidWPA2-1.psk')
         IWD.copy_to_storage('anqp_enabled.conf', storage_dir=3DIWD_CONFIG_=
DIR, name=3D'main.conf')
 =

+        cls.wd =3D IWD(True)
+
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
         os.remove('/tmp/main.conf')
 =

+        cls.wd =3D None
+
 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
diff --git a/autotests/testHotspot/hessid_test.py b/autotests/testHotspot/h=
essid_test.py
index 88e750de..4a47e5c7 100644
--- a/autotests/testHotspot/hessid_test.py
+++ b/autotests/testHotspot/hessid_test.py
@@ -15,7 +15,7 @@ import testutil
 class Test(unittest.TestCase):
 =

     def test_connection_success(self):
-        wd =3D IWD(True, '/tmp')
+        wd =3D self.wd
 =

         hapd =3D HostapdCLI(config=3D'ssidHotspot.conf')
 =

@@ -52,10 +52,14 @@ class Test(unittest.TestCase):
         IWD.copy_to_hotspot('hessid.conf')
         IWD.copy_to_storage('anqp_disabled.conf', storage_dir=3DIWD_CONFIG=
_DIR, name=3D'main.conf')
 =

+        cls.wd =3D IWD(True)
+
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
         os.remove('/tmp/main.conf')
 =

+        cls.wd =3D None
+
 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
diff --git a/autotests/testHotspot/hotspot_test.py b/autotests/testHotspot/=
hotspot_test.py
index f49477dc..054a1a8f 100644
--- a/autotests/testHotspot/hotspot_test.py
+++ b/autotests/testHotspot/hotspot_test.py
@@ -15,7 +15,7 @@ import testutil
 class Test(unittest.TestCase):
 =

     def test_connection_success(self):
-        wd =3D IWD(True, '/tmp')
+        wd =3D self.wd
 =

         hapd =3D HostapdCLI(config=3D'ssidHotspot.conf')
 =

@@ -52,10 +52,14 @@ class Test(unittest.TestCase):
         IWD.copy_to_hotspot('example.conf')
         IWD.copy_to_storage('anqp_enabled.conf', storage_dir=3DIWD_CONFIG_=
DIR, name=3D'main.conf')
 =

+        cls.wd =3D IWD(True)
+
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
         os.remove('/tmp/main.conf')
 =

+        cls.wd =3D None
+
 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
diff --git a/autotests/testHotspot/roaming_test.py b/autotests/testHotspot/=
roaming_test.py
index 6cdd6922..1d785700 100644
--- a/autotests/testHotspot/roaming_test.py
+++ b/autotests/testHotspot/roaming_test.py
@@ -15,13 +15,10 @@ import testutil
 class Test(unittest.TestCase):
 =

     def test_connection_success(self):
-        wd =3D IWD(True, '/tmp')
+        wd =3D self.wd
 =

         hapd =3D HostapdCLI(config=3D'ssidHotspot.conf')
 =

-        psk_agent =3D PSKAgent('abc', ('domain\\user', 'testpasswd'))
-        wd.register_psk_agent(psk_agent)
-
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

@@ -45,17 +42,22 @@ class Test(unittest.TestCase):
         condition =3D 'not obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
 =

-        wd.unregister_psk_agent(psk_agent)
-
     @classmethod
     def setUpClass(cls):
         IWD.copy_to_hotspot('roaming.conf')
         IWD.copy_to_storage('anqp_disabled.conf', storage_dir=3DIWD_CONFIG=
_DIR, name=3D'main.conf')
 =

+        cls.wd =3D IWD(True)
+        cls.psk_agent =3D PSKAgent('abc', ('domain\\user', 'testpasswd'))
+        cls.wd.register_psk_agent(cls.psk_agent)
+
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
         os.remove('/tmp/main.conf')
 =

+        cls.wd.unregister_psk_agent(cls.psk_agent)
+        cls.wd =3D None
+
 if __name__ =3D=3D '__main__':
     unittest.main(exit=3DTrue)
-- =

2.31.1

--===============2451830517408219916==--

