Content-Type: multipart/mixed; boundary="===============2822449082827042966=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 23/26] auto-t: harden testHotspot
Date: Thu, 10 Sep 2020 16:12:44 -0700
Message-ID: <20200910231248.4995-23-prestwoj@gmail.com>
In-Reply-To: <20200910231248.4995-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2822449082827042966==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This test occationally failed, and it uses the old style of waiting
for connected on the network object instead of the device object.

The hwsim rule was also moved ahead of the IWD() initializer which
ensures that IWD doesn't scan before the rule can be set/processed.
---
 autotests/testHotspot/anqp_delay_test.py | 11 ++++++-----
 autotests/testHotspot/hessid_test.py     |  4 ++--
 autotests/testHotspot/hotspot_test.py    |  4 ++--
 autotests/testHotspot/roaming_test.py    |  4 ++--
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/autotests/testHotspot/anqp_delay_test.py b/autotests/testHotsp=
ot/anqp_delay_test.py
index 431f16c1..adfa57fc 100644
--- a/autotests/testHotspot/anqp_delay_test.py
+++ b/autotests/testHotspot/anqp_delay_test.py
@@ -23,10 +23,8 @@ class Test(unittest.TestCase):
         rule0 =3D hwsim.rules.create()
         rule0.source =3D bss_radio.addresses[0]
         rule0.bidirectional =3D True
-        # Force the case where ANQP does not finish before Connect() comes=
 in
-        rule0.delay =3D 100
 =

-        wd =3D IWD(True, '/tmp')
+        wd =3D IWD(True)
 =

         hapd =3D HostapdCLI(config=3D'ssidHotspot.conf')
 =

@@ -53,12 +51,15 @@ class Test(unittest.TestCase):
         condition =3D 'not obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
 =

+        # Force the case where ANQP does not finish before Connect() comes=
 in
+        rule0.delay =3D 100
+
         ordered_network.network_object.connect()
 =

         rule0.delay =3D 1
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         testutil.test_iface_operstate()
         testutil.test_ifaces_connected(device.name, hapd.ifname)
diff --git a/autotests/testHotspot/hessid_test.py b/autotests/testHotspot/h=
essid_test.py
index f511fd62..d22c5d61 100644
--- a/autotests/testHotspot/hessid_test.py
+++ b/autotests/testHotspot/hessid_test.py
@@ -42,8 +42,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         testutil.test_iface_operstate()
         testutil.test_ifaces_connected(device.name, hapd.ifname)
diff --git a/autotests/testHotspot/hotspot_test.py b/autotests/testHotspot/=
hotspot_test.py
index 0f18fae1..4fb6b071 100644
--- a/autotests/testHotspot/hotspot_test.py
+++ b/autotests/testHotspot/hotspot_test.py
@@ -42,8 +42,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         testutil.test_iface_operstate()
         testutil.test_ifaces_connected(device.name, hapd.ifname)
diff --git a/autotests/testHotspot/roaming_test.py b/autotests/testHotspot/=
roaming_test.py
index a7274a82..52d89f84 100644
--- a/autotests/testHotspot/roaming_test.py
+++ b/autotests/testHotspot/roaming_test.py
@@ -42,8 +42,8 @@ class Test(unittest.TestCase):
 =

         ordered_network.network_object.connect()
 =

-        condition =3D 'obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
 =

         testutil.test_iface_operstate()
         testutil.test_ifaces_connected(device.name, hapd.ifname)
-- =

2.26.2

--===============2822449082827042966==--

