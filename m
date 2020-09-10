Content-Type: multipart/mixed; boundary="===============4566400944823868294=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 20/26] auto-t: fix testBSSBlacklist
Date: Thu, 10 Sep 2020 16:12:41 -0700
Message-ID: <20200910231248.4995-20-prestwoj@gmail.com>
In-Reply-To: <20200910231248.4995-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4566400944823868294==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There were a number of fixes here. The waits were changed to wait
on the device state instead of the network state and hwsim rules
were removed after the test as to not interfere with future tests.
One of the rules was setting the signal to -10000 wich was causing
the ranking to be zero.
---
 .../testBSSBlacklist/all_blacklisted_test.py      | 11 ++++++++---
 autotests/testBSSBlacklist/bad_pass_test.py       |  8 +++++++-
 autotests/testBSSBlacklist/connection_test.py     |  9 +++++++--
 autotests/testBSSBlacklist/temp_blacklist_test.py | 15 ++++++++++++++-
 4 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/autotests/testBSSBlacklist/all_blacklisted_test.py b/autotests=
/testBSSBlacklist/all_blacklisted_test.py
index 099804a8..d3ed7acc 100644
--- a/autotests/testBSSBlacklist/all_blacklisted_test.py
+++ b/autotests/testBSSBlacklist/all_blacklisted_test.py
@@ -37,7 +37,7 @@ class Test(unittest.TestCase):
         rule2 =3D hwsim.rules.create()
         rule2.source =3D bss_radio[2].addresses[0]
         rule2.bidirectional =3D True
-        rule2.signal =3D -10000
+        rule2.signal =3D -9000
 =

         wd =3D IWD(True)
 =

@@ -72,17 +72,22 @@ class Test(unittest.TestCase):
 =

         rule0.drop =3D False
         rule1.drop =3D False
+        rule2.drop =3D False
 =

         # This connect should work
         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         self.assertIn(device.address, bss_hostapd[0].list_sta())
 =

         wd.unregister_psk_agent(psk_agent)
 =

+        rule0.remove()
+        rule1.remove()
+        rule2.remove()
+
     @classmethod
     def setUpClass(cls):
         pass
diff --git a/autotests/testBSSBlacklist/bad_pass_test.py b/autotests/testBS=
SBlacklist/bad_pass_test.py
index 220ffcc8..b2ceb998 100644
--- a/autotests/testBSSBlacklist/bad_pass_test.py
+++ b/autotests/testBSSBlacklist/bad_pass_test.py
@@ -39,7 +39,7 @@ class Test(unittest.TestCase):
         rule2.bidirectional =3D True
         rule2.signal =3D -4000
 =

-        wd =3D IWD(True, '/tmp')
+        wd =3D IWD(True)
 =

         psk_agent =3D PSKAgent("wrong_password")
         wd.register_psk_agent(psk_agent)
@@ -80,6 +80,12 @@ class Test(unittest.TestCase):
         condition =3D 'obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
 =

+        wd.unregister_psk_agent(psk_agent)
+
+        rule0.remove()
+        rule1.remove()
+        rule2.remove()
+
     @classmethod
     def setUpClass(cls):
         pass
diff --git a/autotests/testBSSBlacklist/connection_test.py b/autotests/test=
BSSBlacklist/connection_test.py
index 0a51b8cb..8083fc92 100644
--- a/autotests/testBSSBlacklist/connection_test.py
+++ b/autotests/testBSSBlacklist/connection_test.py
@@ -10,7 +10,6 @@ from iwd import PSKAgent
 from iwd import NetworkType
 =

 from hostapd import HostapdCLI
-
 from hwsim import Hwsim
 =

 import time
@@ -42,7 +41,7 @@ class Test(unittest.TestCase):
         rule2.bidirectional =3D True
         rule2.signal =3D -4000
 =

-        wd =3D IWD(True, '/tmp')
+        wd =3D IWD(True)
 =

         psk_agent =3D PSKAgent("secret123")
         wd.register_psk_agent(psk_agent)
@@ -67,6 +66,8 @@ class Test(unittest.TestCase):
         condition =3D 'not obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
 =

+        rule0.drop =3D True
+
         ordered_network.network_object.connect(wait=3DFalse)
 =

         # Have AP1 drop all packets, should result in a connection timeout
@@ -140,6 +141,10 @@ class Test(unittest.TestCase):
 =

         wd.unregister_psk_agent(psk_agent)
 =

+        rule0.remove()
+        rule1.remove()
+        rule2.remove()
+
     @classmethod
     def setUpClass(cls):
         IWD.copy_to_storage('main.conf')
diff --git a/autotests/testBSSBlacklist/temp_blacklist_test.py b/autotests/=
testBSSBlacklist/temp_blacklist_test.py
index b2b57035..2a9590b8 100644
--- a/autotests/testBSSBlacklist/temp_blacklist_test.py
+++ b/autotests/testBSSBlacklist/temp_blacklist_test.py
@@ -39,7 +39,7 @@ class Test(unittest.TestCase):
         rule2.bidirectional =3D True
         rule2.signal =3D -2000
 =

-        wd =3D IWD(True, '/tmp')
+        wd =3D IWD(True)
 =

         psk_agent =3D PSKAgent("secret123")
         wd.register_psk_agent(psk_agent)
@@ -63,6 +63,9 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(dev1, condition)
+
         self.assertIn(dev1.address, bss_hostapd[2].list_sta())
 =

         # dev1 now connected, this should max out the first AP, causing th=
e next
@@ -85,6 +88,9 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(dev2, condition)
+
         # We should have temporarily blacklisted the first BSS, and connec=
ted
         # to this one.
         self.assertIn(dev2.address, bss_hostapd[1].list_sta())
@@ -111,10 +117,17 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(dev2, condition)
+
         self.assertIn(dev2.address, bss_hostapd[2].list_sta())
 =

         wd.unregister_psk_agent(psk_agent)
 =

+        rule0.remove()
+        rule1.remove()
+        rule2.remove()
+
     @classmethod
     def setUpClass(cls):
         IWD.copy_to_storage('main.conf')
-- =

2.26.2

--===============4566400944823868294==--

