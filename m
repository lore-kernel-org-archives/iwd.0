Content-Type: multipart/mixed; boundary="===============5764058929052433861=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 9/9] auto-t: add sae test for non-acked commit
Date: Tue, 07 Sep 2021 14:14:50 -0700
Message-ID: <20210907211450.27270-9-prestwoj@gmail.com>
In-Reply-To: <20210907211450.27270-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5764058929052433861==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This test simulates the scenario where IWDs commit is not acked which
exposes a hostapd bug that ultimately fails the connection. This behavior
can be seen by reverting the commit which works around this issue:

"sae: don't send commit in confirmed state"

With the above patch applied this test should pass.

Note: The existing timeout test was reused as it was not of much use
anyways. All it did was block auth/assoc frames and expect a failure
which didn't exercise any SAE logic anyways.
---
 autotests/testSAE/timeout_test.py | 41 ++++++++++++++++---------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/autotests/testSAE/timeout_test.py b/autotests/testSAE/timeout_=
test.py
index abef109b..1792f1c0 100644
--- a/autotests/testSAE/timeout_test.py
+++ b/autotests/testSAE/timeout_test.py
@@ -9,13 +9,12 @@ from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
 from hwsim import Hwsim
+from hostapd import HostapdCLI
+from config import ctx
 =

 class Test(unittest.TestCase):
 =

     def validate_connection(self, wd):
-        hwsim =3D Hwsim()
-        bss_radio =3D hwsim.get_radio('rad0')
-
         psk_agent =3D PSKAgent(["secret123", "secret123"])
         wd.register_psk_agent(psk_agent)
 =

@@ -30,29 +29,31 @@ class Test(unittest.TestCase):
         condition =3D 'not obj.connected'
         wd.wait_for_object_condition(network.network_object, condition)
 =

+        network.network_object.connect()
+
+        condition =3D 'obj.state =3D=3D DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
+    def test_not_acked_commit(self):
+        #
+        # TODO: This merely forces group 19 by acting as a 'buggy' AP. Thi=
s is
+        # needed because the hwsim rule only matches once and must be matc=
hed
+        # on the first commit, not during group negotiation.
+        #
+        hostapd =3D HostapdCLI(config=3D'ssidSAE.conf')
+        hostapd.set_value('vendor_elements', 'dd0cf4f5e8050500000000000000=
')
+
+        hwsim =3D Hwsim()
+        bss_radio =3D hwsim.get_radio('rad0')
+
         rule0 =3D hwsim.rules.create()
         rule0.source =3D bss_radio.addresses[0]
-        rule0.bidirectional =3D True
         rule0.drop =3D True
         rule0.prefix =3D 'b0'
+        rule0.match_times =3D 1
+        rule0.drop_ack =3D True
         rule0.enabled =3D True
 =

-        wd.wait(1)
-        print(rule0)
-
-        with self.assertRaises(iwd.FailedEx):
-            network.network_object.connect()
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(network.network_object, condition)
-
-        rule0.prefix =3D '00'
-        with self.assertRaises(iwd.FailedEx):
-            network.network_object.connect()
-
-        wd.unregister_psk_agent(psk_agent)
-
-    def test_connection_success(self):
         wd =3D IWD(True)
         self.validate_connection(wd)
 =

-- =

2.31.1

--===============5764058929052433861==--

