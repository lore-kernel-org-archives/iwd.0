Content-Type: multipart/mixed; boundary="===============6401395273966401851=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 17/26] auto-t: fix SAE FT test and update
Date: Thu, 10 Sep 2020 11:58:46 -0700
Message-ID: <20200910185855.27833-17-prestwoj@gmail.com>
In-Reply-To: <20200910185855.27833-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6401395273966401851==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Updated testFT-SAE-roam to use the TestContext APIs as well as
fixed the failure which was introduced after requiring stricter
AKM logic for SAE networks. The new failure was due to the hostapd
config not including the standard SAE AKM which is actually
required by the spec.
---
 autotests/testFT-SAE-roam/connection_test.py | 22 ++++++++++++--------
 autotests/testFT-SAE-roam/ft-psk-3.conf      |  2 --
 autotests/testFT-SAE-roam/ft-sae-1.conf      |  4 +---
 autotests/testFT-SAE-roam/ft-sae-2.conf      |  4 +---
 4 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/autotests/testFT-SAE-roam/connection_test.py b/autotests/testF=
T-SAE-roam/connection_test.py
index dcea148c..99f58456 100644
--- a/autotests/testFT-SAE-roam/connection_test.py
+++ b/autotests/testFT-SAE-roam/connection_test.py
@@ -11,9 +11,12 @@ from iwd import NetworkType
 from hwsim import Hwsim
 from hostapd import HostapdCLI
 import testutil
+from config import ctx
 =

 class Test(unittest.TestCase):
     def test_roam_success(self):
+        wd =3D IWD()
+
         hwsim =3D Hwsim()
 =

         rule0 =3D hwsim.rules.create()
@@ -28,8 +31,6 @@ class Test(unittest.TestCase):
         rule2.source =3D self.bss_radio[2].addresses[0]
         rule2.bidirectional =3D True
 =

-        wd =3D IWD()
-
         psk_agent =3D PSKAgent("EasilyGuessedPassword")
         wd.register_psk_agent(psk_agent)
 =

@@ -158,17 +159,20 @@ class Test(unittest.TestCase):
                            hwsim.get_radio('rad1'),
                            hwsim.get_radio('rad2') ]
 =

-        # Set interface addresses to those expected by hostapd config files
-        os.system('ifconfig "' + cls.bss_hostapd[0].ifname +
-                '" down hw ether 12:00:00:00:00:01 up')
-        os.system('ifconfig "' + cls.bss_hostapd[1].ifname +
-                '" down hw ether 12:00:00:00:00:02 up')
-        os.system('ifconfig "' + cls.bss_hostapd[2].ifname +
-                '" down hw ether 12:00:00:00:00:03 up')
+        ctx.start_process(['ifconfig', cls.bss_hostapd[0].ifname, 'down', =
'hw', \
+                                'ether', '12:00:00:00:00:01', 'up'], wait=
=3DTrue)
+        ctx.start_process(['ifconfig', cls.bss_hostapd[1].ifname, 'down', =
'hw', \
+                                'ether', '12:00:00:00:00:02', 'up'], wait=
=3DTrue)
+        ctx.start_process(['ifconfig', cls.bss_hostapd[2].ifname, 'down', =
'hw', \
+                                'ether', '12:00:00:00:00:03', 'up'], wait=
=3DTrue)
 =

+        # Set interface addresses to those expected by hostapd config files
         cls.bss_hostapd[0].reload()
+        cls.bss_hostapd[0].wait_for_event("AP-ENABLED")
         cls.bss_hostapd[1].reload()
+        cls.bss_hostapd[1].wait_for_event("AP-ENABLED")
         cls.bss_hostapd[2].reload()
+        cls.bss_hostapd[2].wait_for_event("AP-ENABLED")
 =

         # Fill in the neighbor AP tables in both BSSes.  By default each
         # instance knows only about current BSS, even inside one hostapd
diff --git a/autotests/testFT-SAE-roam/ft-psk-3.conf b/autotests/testFT-SAE=
-roam/ft-psk-3.conf
index 6a2d4cad..8918cf9e 100644
--- a/autotests/testFT-SAE-roam/ft-psk-3.conf
+++ b/autotests/testFT-SAE-roam/ft-psk-3.conf
@@ -16,8 +16,6 @@ wpa_passphrase=3DEasilyGuessedPassword
 wpa_ptk_rekey=3D30
 wpa_group_rekey=3D80
 ieee80211w=3D2
-rsn_preauth=3D1
-rsn_preauth_interfaces=3Dlo
 disable_pmksa_caching=3D0
 # Allow PMK cache to be shared opportunistically among configured interfac=
es
 # and BSSes (i.e., all configurations within a single hostapd process).
diff --git a/autotests/testFT-SAE-roam/ft-sae-1.conf b/autotests/testFT-SAE=
-roam/ft-sae-1.conf
index 6642c398..aa40494a 100644
--- a/autotests/testFT-SAE-roam/ft-sae-1.conf
+++ b/autotests/testFT-SAE-roam/ft-sae-1.conf
@@ -10,14 +10,12 @@ nas_identifier=3Ddummy1
 wpa=3D2
 # Can support SAE and FT-SAE (space separated list) and/or EAP at the same
 # time but we want to force FT
-wpa_key_mgmt=3DFT-SAE
+wpa_key_mgmt=3DFT-SAE SAE
 sae_password=3DEasilyGuessedPassword|mac=3Dff:ff:ff:ff:ff:ff
 wpa_pairwise=3DCCMP
 wpa_ptk_rekey=3D30
 wpa_group_rekey=3D80
 ieee80211w=3D2
-rsn_preauth=3D1
-rsn_preauth_interfaces=3Dlo
 disable_pmksa_caching=3D0
 # Allow PMK cache to be shared opportunistically among configured interfac=
es
 # and BSSes (i.e., all configurations within a single hostapd process).
diff --git a/autotests/testFT-SAE-roam/ft-sae-2.conf b/autotests/testFT-SAE=
-roam/ft-sae-2.conf
index fa841db8..5bff6c9d 100644
--- a/autotests/testFT-SAE-roam/ft-sae-2.conf
+++ b/autotests/testFT-SAE-roam/ft-sae-2.conf
@@ -10,14 +10,12 @@ nas_identifier=3Ddummy2
 wpa=3D2
 # Can support SAE and FT-SAE (space separated list) and/or EAP at the same
 # time but we want to force FT
-wpa_key_mgmt=3DFT-SAE
+wpa_key_mgmt=3DFT-SAE SAE
 sae_password=3DEasilyGuessedPassword|mac=3Dff:ff:ff:ff:ff:ff
 wpa_pairwise=3DCCMP
 wpa_ptk_rekey=3D30
 wpa_group_rekey=3D80
 ieee80211w=3D2
-rsn_preauth=3D1
-rsn_preauth_interfaces=3Dlo
 disable_pmksa_caching=3D0
 # Allow PMK cache to be shared opportunistically among configured interfac=
es
 # and BSSes (i.e., all configurations within a single hostapd process).
-- =

2.21.3

--===============6401395273966401851==--

