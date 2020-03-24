Content-Type: multipart/mixed; boundary="===============9100589016053869122=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] auto-t: remove iwd_config_dir from autotests
Date: Tue, 24 Mar 2020 13:24:03 -0700
Message-ID: <20200324202403.26860-3-prestwoj@gmail.com>
In-Reply-To: <20200324202403.26860-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9100589016053869122==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is no longer needed unless setting a different
directory than /tmp
---
 autotests/testAP/hw.conf             | 1 -
 autotests/testEAP-TLS-Frag/hw.conf   | 1 -
 autotests/testEAP-TTLS-Frag/hw.conf  | 1 -
 autotests/testEAP-WPS-Frag/hw.conf   | 1 -
 autotests/testFT-8021x-roam/hw.conf  | 2 --
 autotests/testFT-FILS-SHA256/hw.conf | 1 -
 autotests/testFT-FILS-SHA384/hw.conf | 1 -
 autotests/testFT-PSK-over-DS/hw.conf | 1 -
 autotests/testFT-PSK-roam/hw.conf    | 1 -
 autotests/testFT-SAE-roam/hw.conf    | 1 -
 autotests/testHT-VHT/hw.conf         | 1 -
 autotests/testRSSIAgent/hw.conf      | 1 -
 12 files changed, 13 deletions(-)

diff --git a/autotests/testAP/hw.conf b/autotests/testAP/hw.conf
index dc9b7bff..96a2bbb1 100644
--- a/autotests/testAP/hw.conf
+++ b/autotests/testAP/hw.conf
@@ -1,7 +1,6 @@
 [SETUP]
 num_radios=3D3
 max_test_exec_interval_sec=3D40
-iwd_config_dir=3D/tmp
 tmpfs_extra_stuff=3Dmain.conf
 =

 [HOSTAPD]
diff --git a/autotests/testEAP-TLS-Frag/hw.conf b/autotests/testEAP-TLS-Fra=
g/hw.conf
index e210f674..80b08975 100644
--- a/autotests/testEAP-TLS-Frag/hw.conf
+++ b/autotests/testEAP-TLS-Frag/hw.conf
@@ -1,7 +1,6 @@
 [SETUP]
 num_radios=3D2
 tmpfs_extra_stuff=3D../misc/certs:main.conf
-iwd_config_dir=3D/tmp
 =

 [HOSTAPD]
 rad0=3DssidEAP-TLS.conf
diff --git a/autotests/testEAP-TTLS-Frag/hw.conf b/autotests/testEAP-TTLS-F=
rag/hw.conf
index f0e55bd6..279842c2 100644
--- a/autotests/testEAP-TTLS-Frag/hw.conf
+++ b/autotests/testEAP-TTLS-Frag/hw.conf
@@ -1,7 +1,6 @@
 [SETUP]
 num_radios=3D2
 tmpfs_extra_stuff=3D../misc/certs:main.conf
-iwd_config_dir=3D/tmp
 =

 [HOSTAPD]
 rad0=3DssidEAP-TTLS.conf
diff --git a/autotests/testEAP-WPS-Frag/hw.conf b/autotests/testEAP-WPS-Fra=
g/hw.conf
index ebeade92..eeac3bab 100644
--- a/autotests/testEAP-WPS-Frag/hw.conf
+++ b/autotests/testEAP-WPS-Frag/hw.conf
@@ -1,7 +1,6 @@
 [SETUP]
 num_radios=3D2
 tmpfs_extra_stuff=3Dmain.conf
-iwd_config_dir=3D/tmp
 =

 [HOSTAPD]
 rad0=3Dssid-wps-small-mtu.conf
diff --git a/autotests/testFT-8021x-roam/hw.conf b/autotests/testFT-8021x-r=
oam/hw.conf
index d3c039ae..4906bbf3 100644
--- a/autotests/testFT-8021x-roam/hw.conf
+++ b/autotests/testFT-8021x-roam/hw.conf
@@ -2,8 +2,6 @@
 num_radios=3D3
 max_test_exec_interval_sec=3D45
 tmpfs_extra_stuff=3D../misc/certs:main.conf
-iwd_config_dir=3D/tmp
-tmpfs_extra_stuff=3D../misc/certs
 needs_hwsim=3D1
 =

 [HOSTAPD]
diff --git a/autotests/testFT-FILS-SHA256/hw.conf b/autotests/testFT-FILS-S=
HA256/hw.conf
index b5c6757c..c3330d04 100644
--- a/autotests/testFT-FILS-SHA256/hw.conf
+++ b/autotests/testFT-FILS-SHA256/hw.conf
@@ -2,7 +2,6 @@
 num_radios=3D3
 max_test_exec_interval_sec=3D45
 tmpfs_extra_stuff=3D../misc/certs:main.conf:pwd.eap_user
-iwd_config_dir=3D/tmp
 =

 [HOSTAPD]
 rad0=3Dft-eap-ccmp-1.conf
diff --git a/autotests/testFT-FILS-SHA384/hw.conf b/autotests/testFT-FILS-S=
HA384/hw.conf
index b5c6757c..c3330d04 100644
--- a/autotests/testFT-FILS-SHA384/hw.conf
+++ b/autotests/testFT-FILS-SHA384/hw.conf
@@ -2,7 +2,6 @@
 num_radios=3D3
 max_test_exec_interval_sec=3D45
 tmpfs_extra_stuff=3D../misc/certs:main.conf:pwd.eap_user
-iwd_config_dir=3D/tmp
 =

 [HOSTAPD]
 rad0=3Dft-eap-ccmp-1.conf
diff --git a/autotests/testFT-PSK-over-DS/hw.conf b/autotests/testFT-PSK-ov=
er-DS/hw.conf
index e020b54f..d2d50863 100644
--- a/autotests/testFT-PSK-over-DS/hw.conf
+++ b/autotests/testFT-PSK-over-DS/hw.conf
@@ -1,7 +1,6 @@
 [SETUP]
 num_radios=3D3
 max_test_exec_interval_sec=3D45
-iwd_config_dir=3D/tmp
 tmpfs_extra_stuff=3Dmain.conf
 needs_hwsim=3D1
 =

diff --git a/autotests/testFT-PSK-roam/hw.conf b/autotests/testFT-PSK-roam/=
hw.conf
index e020b54f..d2d50863 100644
--- a/autotests/testFT-PSK-roam/hw.conf
+++ b/autotests/testFT-PSK-roam/hw.conf
@@ -1,7 +1,6 @@
 [SETUP]
 num_radios=3D3
 max_test_exec_interval_sec=3D45
-iwd_config_dir=3D/tmp
 tmpfs_extra_stuff=3Dmain.conf
 needs_hwsim=3D1
 =

diff --git a/autotests/testFT-SAE-roam/hw.conf b/autotests/testFT-SAE-roam/=
hw.conf
index a0ff7b16..1f0f1c12 100644
--- a/autotests/testFT-SAE-roam/hw.conf
+++ b/autotests/testFT-SAE-roam/hw.conf
@@ -1,7 +1,6 @@
 [SETUP]
 num_radios=3D4
 max_test_exec_interval_sec=3D120
-iwd_config_dir=3D/tmp
 tmpfs_extra_stuff=3Dmain.conf
 needs_hwsim=3D1
 =

diff --git a/autotests/testHT-VHT/hw.conf b/autotests/testHT-VHT/hw.conf
index 98e1b2ea..6d557ad1 100644
--- a/autotests/testHT-VHT/hw.conf
+++ b/autotests/testHT-VHT/hw.conf
@@ -2,7 +2,6 @@
 num_radios=3D4
 max_test_exec_interval_sec=3D45
 reg_domain=3DUS
-iwd_config_dir=3D/tmp
 tmpfs_extra_stuff=3Dmain.conf
 =

 [HOSTAPD]
diff --git a/autotests/testRSSIAgent/hw.conf b/autotests/testRSSIAgent/hw.c=
onf
index 094e9378..9b9d75be 100644
--- a/autotests/testRSSIAgent/hw.conf
+++ b/autotests/testRSSIAgent/hw.conf
@@ -1,7 +1,6 @@
 [SETUP]
 num_radios=3D2
 max_test_exec_interval_sec=3D60
-iwd_config_dir=3D/tmp
 tmpfs_extra_stuff=3Dmain.conf
 needs_hwsim=3D1
 =

-- =

2.21.1

--===============9100589016053869122==--

