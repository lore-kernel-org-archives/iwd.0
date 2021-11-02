Content-Type: multipart/mixed; boundary="===============9000455683825928821=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/4] auto-t: allow testAP to benefit from re-scanning
Date: Tue, 02 Nov 2021 12:57:51 -0700
Message-ID: <20211102195752.381604-3-prestwoj@gmail.com>
In-Reply-To: 20211102195752.381604-1-prestwoj@gmail.com

--===============9000455683825928821==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If a beacon is lost testAP will fail since it did not utilize any
rescanning logic. Now it can use this feature by passing full_scan.
This is required since IWD APs are not known to test-runner like
hostapd APs are.
---
 autotests/testAP/connection_test.py  | 5 +++--
 autotests/testAP/dhcp_config_test.py | 4 ++--
 autotests/testAP/dhcp_test.py        | 4 ++--
 autotests/testAP/failure_test.py     | 6 ++++--
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/autotests/testAP/connection_test.py b/autotests/testAP/connect=
ion_test.py
index 1bba5f35..4c784014 100644
--- a/autotests/testAP/connection_test.py
+++ b/autotests/testAP/connection_test.py
@@ -55,9 +55,10 @@ class Test(unittest.TestCase):
             condition =3D 'not obj.scanning'
             wd.wait_for_object_condition(dev2, condition)
 =

-            ordered_networks =3D dev2.get_ordered_networks()
+            networks =3D {}
+            networks['TestAP1'] =3D dev2.get_ordered_network('TestAP1')
+            networks['TestAP2'] =3D dev2.get_ordered_network('TestAP2', fu=
ll_scan=3DTrue)
 =

-            networks =3D { n.name: n for n in ordered_networks }
             self.assertEqual(networks['TestAP1'].type, NetworkType.psk)
             self.assertEqual(networks['TestAP2'].type, NetworkType.psk)
 =

diff --git a/autotests/testAP/dhcp_config_test.py b/autotests/testAP/dhcp_c=
onfig_test.py
index 975cab4d..afea5415 100644
--- a/autotests/testAP/dhcp_config_test.py
+++ b/autotests/testAP/dhcp_config_test.py
@@ -37,9 +37,9 @@ class Test(unittest.TestCase):
             condition =3D 'not obj.scanning'
             wd.wait_for_object_condition(dev2, condition)
 =

-            ordered_networks =3D dev2.get_ordered_networks()
+            networks =3D {}
+            networks['APConfig'] =3D dev2.get_ordered_network('APConfig', =
full_scan=3DTrue)
 =

-            networks =3D { n.name: n for n in ordered_networks }
             self.assertEqual(networks['APConfig'].type, NetworkType.psk)
 =

             psk_agent =3D PSKAgent('password123')
diff --git a/autotests/testAP/dhcp_test.py b/autotests/testAP/dhcp_test.py
index e69c4465..0118b17d 100644
--- a/autotests/testAP/dhcp_test.py
+++ b/autotests/testAP/dhcp_test.py
@@ -34,9 +34,9 @@ class Test(unittest.TestCase):
             condition =3D 'not obj.scanning'
             wd.wait_for_object_condition(dev2, condition)
 =

-            ordered_networks =3D dev2.get_ordered_networks()
+            networks =3D {}
+            networks['TestAP2'] =3D dev2.get_ordered_network('TestAP2', fu=
ll_scan=3DTrue)
 =

-            networks =3D { n.name: n for n in ordered_networks }
             self.assertEqual(networks['TestAP2'].type, NetworkType.psk)
 =

             psk_agent =3D PSKAgent('Password2')
diff --git a/autotests/testAP/failure_test.py b/autotests/testAP/failure_te=
st.py
index fc5cb6a7..05b5a7fb 100644
--- a/autotests/testAP/failure_test.py
+++ b/autotests/testAP/failure_test.py
@@ -56,8 +56,10 @@ class Test(unittest.TestCase):
             condition =3D 'not obj.scanning'
             wd.wait_for_object_condition(dev2, condition)
 =

-            ordered_networks =3D dev2.get_ordered_networks()
-            networks =3D { n.name: n for n in ordered_networks }
+            networks =3D {}
+            networks['TestAP1'] =3D dev2.get_ordered_network('TestAP1')
+            networks['TestAP2'] =3D dev2.get_ordered_network('TestAP2', fu=
ll_scan=3DTrue)
+
             self.assertEqual(networks['TestAP1'].type, NetworkType.psk)
             self.assertEqual(networks['TestAP2'].type, NetworkType.psk)
 =

-- =

2.31.1

--===============9000455683825928821==--

