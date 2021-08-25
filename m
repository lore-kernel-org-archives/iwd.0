Content-Type: multipart/mixed; boundary="===============6561476270167025569=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 5/5] auto-t: add force SAE group 19 autotest
Date: Wed, 25 Aug 2021 10:12:58 -0700
Message-ID: <20210825171258.764596-5-prestwoj@gmail.com>
In-Reply-To: <20210825171258.764596-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6561476270167025569==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The vendor element was taken directly from observed logs of an AP
behaving this way. This causes IWD to force group 19.
---
 autotests/testSAE/connection_test.py | 34 ++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/autotests/testSAE/connection_test.py b/autotests/testSAE/conne=
ction_test.py
index f3e865e1..88aa077e 100644
--- a/autotests/testSAE/connection_test.py
+++ b/autotests/testSAE/connection_test.py
@@ -25,7 +25,7 @@ class Test(unittest.TestCase):
 =

         wd.wait_for_object_condition(device, 'not obj.scanning')
 =

-        device.scan()
+        device.debug_scan([2412])
 =

         wd.wait_for_object_condition(device, 'obj.scanning')
         wd.wait_for_object_condition(device, 'not obj.scanning')
@@ -57,8 +57,21 @@ class Test(unittest.TestCase):
         wd.unregister_psk_agent(psk_agent)
 =

     def test_SAE(self):
-        self.hostapd.set_value('sae_pwe', '0');
-        self.hostapd.set_value('sae_groups', '19');
+        self.hostapd.set_value('sae_pwe', '0')
+        self.hostapd.set_value('sae_groups', '19')
+        self.hostapd.set_value('vendor_elements', '')
+        self.hostapd.reload()
+        self.hostapd.wait_for_event("AP-ENABLED")
+        wd =3D IWD(True)
+        self.validate_connection(wd)
+        wd.clear_storage()
+
+    def test_SAE_force_group_19(self):
+        self.hostapd.set_value('sae_pwe', '0')
+        self.hostapd.set_value('sae_groups', '19')
+        # Vendor data from APs which require group 19 be used first
+        # TODO: (for all tests) verify the expected group was used
+        self.hostapd.set_value('vendor_elements', 'dd0cf4f5e80505000000000=
00000')
         self.hostapd.reload()
         self.hostapd.wait_for_event("AP-ENABLED")
         wd =3D IWD(True)
@@ -66,8 +79,9 @@ class Test(unittest.TestCase):
         wd.clear_storage()
 =

     def test_SAE_Group20(self):
-        self.hostapd.set_value('sae_pwe', '0');
-        self.hostapd.set_value('sae_groups', '20');
+        self.hostapd.set_value('sae_pwe', '0')
+        self.hostapd.set_value('sae_groups', '20')
+        self.hostapd.set_value('vendor_elements', '')
         self.hostapd.reload()
         self.hostapd.wait_for_event("AP-ENABLED")
         wd =3D IWD(True)
@@ -75,8 +89,9 @@ class Test(unittest.TestCase):
         wd.clear_storage()
 =

     def test_SAE_H2E(self):
-        self.hostapd.set_value('sae_pwe', '1');
-        self.hostapd.set_value('sae_groups', '19');
+        self.hostapd.set_value('sae_pwe', '1')
+        self.hostapd.set_value('sae_groups', '19')
+        self.hostapd.set_value('vendor_elements', '')
         self.hostapd.reload()
         self.hostapd.wait_for_event("AP-ENABLED")
         wd =3D IWD(True)
@@ -84,8 +99,9 @@ class Test(unittest.TestCase):
         wd.clear_storage()
 =

     def test_SAE_H2E_Group20(self):
-        self.hostapd.set_value('sae_pwe', '1');
-        self.hostapd.set_value('sae_groups', '20');
+        self.hostapd.set_value('sae_pwe', '1')
+        self.hostapd.set_value('sae_groups', '20')
+        self.hostapd.set_value('vendor_elements', '')
         self.hostapd.reload()
         self.hostapd.wait_for_event("AP-ENABLED")
         wd =3D IWD(True)
-- =

2.31.1

--===============6561476270167025569==--

