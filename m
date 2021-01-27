Content-Type: multipart/mixed; boundary="===============6201730053728850473=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] auto-t: remove stale hw.conf options
Date: Wed, 27 Jan 2021 11:34:26 -0800
Message-ID: <20210127193426.939890-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6201730053728850473==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After the test-runner re-write many tests were left with
stale options that are no longer used at all. These were
periodically getting removed as changes were made to
individual tests, but its apparent now that a tree wide
removal was needed.
---
 autotests/testAPRoam/hw.conf                   | 1 -
 autotests/testAdHoc/hw.conf                    | 1 -
 autotests/testAddressRandomization/hw.conf     | 1 -
 autotests/testAgent/hw.conf                    | 1 -
 autotests/testBSSBlacklist/hw.conf             | 2 --
 autotests/testClientNonInteractive/hw.conf     | 2 --
 autotests/testConnectAutoconnect/hw.conf       | 4 +---
 autotests/testDisconnectOnConnect/hw.conf      | 1 -
 autotests/testEAP-AKA-ofono/hw.conf            | 2 --
 autotests/testEAP-AKA-prime-ofono/hw.conf      | 2 --
 autotests/testEAP-MSCHAPV2/hw.conf             | 1 -
 autotests/testEAP-PEAP-GTC/hw.conf             | 2 --
 autotests/testEAP-PEAP-MSCHAPv2/hw.conf        | 2 --
 autotests/testEAP-PEAP/hw.conf                 | 2 --
 autotests/testEAP-PEAPv0-CryptoBinding/hw.conf | 2 --
 autotests/testEAP-PWD/hw.conf                  | 2 --
 autotests/testEAP-SIM-ofono/hw.conf            | 2 --
 autotests/testEAP-TLS-Frag/hw.conf             | 1 -
 autotests/testEAP-TLS-embedded-pems/hw.conf    | 1 -
 autotests/testEAP-TLS/hw.conf                  | 1 -
 autotests/testEAP-TLSwithMFPC/hw.conf          | 1 -
 autotests/testEAP-TLSwithMFPR/hw.conf          | 1 -
 autotests/testEAP-TTLS-CHAP/hw.conf            | 1 -
 autotests/testEAP-TTLS-EAP-MSCHAPV2/hw.conf    | 1 -
 autotests/testEAP-TTLS-Frag/hw.conf            | 1 -
 autotests/testEAP-TTLS-MSCHAP/hw.conf          | 1 -
 autotests/testEAP-TTLS-MSCHAPv2/hw.conf        | 2 --
 autotests/testEAP-TTLS-PAP/hw.conf             | 1 -
 autotests/testEAP-TTLS/hw.conf                 | 1 -
 autotests/testEAP-WPS-Frag/hw.conf             | 1 -
 autotests/testEAP-WPS/hw.conf                  | 1 -
 autotests/testFILS/hw.conf                     | 2 --
 autotests/testFT-8021x-roam/hw.conf            | 3 ---
 autotests/testFT-FILS-SHA256/hw.conf           | 2 --
 autotests/testFT-FILS-SHA384/hw.conf           | 2 --
 autotests/testFT-PSK-over-DS/hw.conf           | 3 ---
 autotests/testFT-PSK-roam/hw.conf              | 3 ---
 autotests/testFT-SAE-roam/hw.conf              | 3 ---
 autotests/testHT-VHT/hw.conf                   | 2 --
 autotests/testHotspot/hw.conf                  | 2 --
 autotests/testKnownNetworks/hw.conf            | 1 -
 autotests/testMFP-Options/hw.conf              | 2 --
 autotests/testNetconfig/hw.conf                | 1 -
 autotests/testPreauth-roam/hw.conf             | 3 ---
 autotests/testRSSIAgent/hw.conf                | 3 ---
 autotests/testRoamRetry/hw.conf                | 1 -
 autotests/testSAQuery-spoofing/hw.conf         | 1 -
 autotests/testScan/hw.conf                     | 2 --
 autotests/testScanKnownFreqs/hw.conf           | 1 -
 autotests/testWPA/hw.conf                      | 1 -
 50 files changed, 1 insertion(+), 82 deletions(-)

diff --git a/autotests/testAPRoam/hw.conf b/autotests/testAPRoam/hw.conf
index ab89c096..00a31063 100644
--- a/autotests/testAPRoam/hw.conf
+++ b/autotests/testAPRoam/hw.conf
@@ -1,6 +1,5 @@
 [SETUP]
 num_radios=3D4
-needs_hwsim=3D1
 =

 [HOSTAPD]
 rad0=3Dssid1.conf
diff --git a/autotests/testAdHoc/hw.conf b/autotests/testAdHoc/hw.conf
index 74cdd2d8..c6553537 100644
--- a/autotests/testAdHoc/hw.conf
+++ b/autotests/testAdHoc/hw.conf
@@ -1,4 +1,3 @@
 [SETUP]
 num_radios=3D2
-max_test_exec_interval_sec=3D35
 start_iwd=3D0
diff --git a/autotests/testAddressRandomization/hw.conf b/autotests/testAdd=
ressRandomization/hw.conf
index 35af520e..fad15b88 100644
--- a/autotests/testAddressRandomization/hw.conf
+++ b/autotests/testAddressRandomization/hw.conf
@@ -1,6 +1,5 @@
 [SETUP]
 num_radios=3D2
-tmpfs_extra_stuff=3Dmain.conf
 =

 [HOSTAPD]
 rad0=3DssidCCMP.conf
diff --git a/autotests/testAgent/hw.conf b/autotests/testAgent/hw.conf
index 53249c9c..8b450b63 100644
--- a/autotests/testAgent/hw.conf
+++ b/autotests/testAgent/hw.conf
@@ -1,6 +1,5 @@
 [SETUP]
 num_radios=3D3
-max_test_exec_interval_sec=3D40
 =

 [HOSTAPD]
 rad0=3Dssid1.conf
diff --git a/autotests/testBSSBlacklist/hw.conf b/autotests/testBSSBlacklis=
t/hw.conf
index 60b147da..d6b754aa 100644
--- a/autotests/testBSSBlacklist/hw.conf
+++ b/autotests/testBSSBlacklist/hw.conf
@@ -1,7 +1,5 @@
 [SETUP]
 num_radios=3D5
-tmpfs_extra_stuff=3Dmain.conf
-max_test_exec_interval_sec=3D45
 start_iwd=3D0
 =

 [HOSTAPD]
diff --git a/autotests/testClientNonInteractive/hw.conf b/autotests/testCli=
entNonInteractive/hw.conf
index 371caabe..babfd811 100644
--- a/autotests/testClientNonInteractive/hw.conf
+++ b/autotests/testClientNonInteractive/hw.conf
@@ -1,7 +1,5 @@
 [SETUP]
 num_radios=3D4
-max_test_exec_interval_sec=3D40
-tmpfs_extra_stuff=3D../misc/certs:eap-user-ttls-mschap.text
 =

 [HOSTAPD]
 rad0=3DssidPassphrase.conf
diff --git a/autotests/testConnectAutoconnect/hw.conf b/autotests/testConne=
ctAutoconnect/hw.conf
index 437cc4c3..913e5095 100644
--- a/autotests/testConnectAutoconnect/hw.conf
+++ b/autotests/testConnectAutoconnect/hw.conf
@@ -1,11 +1,9 @@
 [SETUP]
 num_radios=3D5
 start_iwd=3D0
-max_test_exec_interval_sec=3D120
-tmpfs_extra_stuff=3D../misc/certs
 =

 [HOSTAPD]
 rad0=3DssidOpen.conf
 rad1=3DssidWPA.conf
 rad2=3DssidEAP-TLS.conf
-rad3=3DssidEAP-Other.conf
\ No newline at end of file
+rad3=3DssidEAP-Other.conf
diff --git a/autotests/testDisconnectOnConnect/hw.conf b/autotests/testDisc=
onnectOnConnect/hw.conf
index d95b41e2..9cd67c8f 100644
--- a/autotests/testDisconnectOnConnect/hw.conf
+++ b/autotests/testDisconnectOnConnect/hw.conf
@@ -1,6 +1,5 @@
 [SETUP]
 num_radios=3D3
-max_test_exec_interval_sec=3D40
 =

 [HOSTAPD]
 rad0=3DssidTKIP.conf
diff --git a/autotests/testEAP-AKA-ofono/hw.conf b/autotests/testEAP-AKA-of=
ono/hw.conf
index f92487bb..a4555c6f 100644
--- a/autotests/testEAP-AKA-ofono/hw.conf
+++ b/autotests/testEAP-AKA-ofono/hw.conf
@@ -1,7 +1,5 @@
 [SETUP]
 num_radios=3D2
-max_test_exec_interval_sec=3D40
-tmpfs_extra_stuff=3Dsim.eap_user:sim.db:../misc/phonesim/phonesim.conf
 sim_keys=3Dofono
 =

 [HOSTAPD]
diff --git a/autotests/testEAP-AKA-prime-ofono/hw.conf b/autotests/testEAP-=
AKA-prime-ofono/hw.conf
index f92487bb..a4555c6f 100644
--- a/autotests/testEAP-AKA-prime-ofono/hw.conf
+++ b/autotests/testEAP-AKA-prime-ofono/hw.conf
@@ -1,7 +1,5 @@
 [SETUP]
 num_radios=3D2
-max_test_exec_interval_sec=3D40
-tmpfs_extra_stuff=3Dsim.eap_user:sim.db:../misc/phonesim/phonesim.conf
 sim_keys=3Dofono
 =

 [HOSTAPD]
diff --git a/autotests/testEAP-MSCHAPV2/hw.conf b/autotests/testEAP-MSCHAPV=
2/hw.conf
index 1d5539ad..b22a2c9f 100644
--- a/autotests/testEAP-MSCHAPV2/hw.conf
+++ b/autotests/testEAP-MSCHAPV2/hw.conf
@@ -1,6 +1,5 @@
 [SETUP]
 num_radios=3D2
-tmpfs_extra_stuff=3D../misc/secrets
 =

 [HOSTAPD]
 rad0=3DssidEAP-MSCHAPV2.conf
diff --git a/autotests/testEAP-PEAP-GTC/hw.conf b/autotests/testEAP-PEAP-GT=
C/hw.conf
index dc1192e1..acca16b0 100644
--- a/autotests/testEAP-PEAP-GTC/hw.conf
+++ b/autotests/testEAP-PEAP-GTC/hw.conf
@@ -1,8 +1,6 @@
 [SETUP]
 num_radios=3D3
 start_iwd=3D0
-max_test_exec_interval_sec=3D60
-tmpfs_extra_stuff=3D../misc/certs:eap-user-peap-gtc.text
 =

 [HOSTAPD]
 rad0=3DssidEAP-PEAPv1-GTC.conf
diff --git a/autotests/testEAP-PEAP-MSCHAPv2/hw.conf b/autotests/testEAP-PE=
AP-MSCHAPv2/hw.conf
index bff2eff4..12e11211 100644
--- a/autotests/testEAP-PEAP-MSCHAPv2/hw.conf
+++ b/autotests/testEAP-PEAP-MSCHAPv2/hw.conf
@@ -1,8 +1,6 @@
 [SETUP]
 num_radios=3D2
 start_iwd=3D0
-max_test_exec_interval_sec=3D60
-tmpfs_extra_stuff=3D../misc/certs:../misc/secrets
 =

 [HOSTAPD]
 rad0=3DssidEAP-PEAP-MSCHAPv2.conf
diff --git a/autotests/testEAP-PEAP/hw.conf b/autotests/testEAP-PEAP/hw.conf
index e0377ae4..0dcda0a2 100644
--- a/autotests/testEAP-PEAP/hw.conf
+++ b/autotests/testEAP-PEAP/hw.conf
@@ -1,8 +1,6 @@
 [SETUP]
 num_radios=3D4
 start_iwd=3D0
-max_test_exec_interval_sec=3D60
-tmpfs_extra_stuff=3D../misc/certs:../misc/secrets:IWD-Frag
 =

 [HOSTAPD]
 rad0=3DssidEAP-PEAPv1.conf
diff --git a/autotests/testEAP-PEAPv0-CryptoBinding/hw.conf b/autotests/tes=
tEAP-PEAPv0-CryptoBinding/hw.conf
index cceb79fb..0c8ba519 100644
--- a/autotests/testEAP-PEAPv0-CryptoBinding/hw.conf
+++ b/autotests/testEAP-PEAPv0-CryptoBinding/hw.conf
@@ -1,8 +1,6 @@
 [SETUP]
 num_radios=3D3
 start_iwd=3D0
-max_test_exec_interval_sec=3D60
-tmpfs_extra_stuff=3D../misc/certs:../misc/secrets:main.conf
 =

 [HOSTAPD]
 rad0=3DssidEAP-PEAPv0-NoISK.conf
diff --git a/autotests/testEAP-PWD/hw.conf b/autotests/testEAP-PWD/hw.conf
index 4d5ef302..40427c13 100644
--- a/autotests/testEAP-PWD/hw.conf
+++ b/autotests/testEAP-PWD/hw.conf
@@ -1,8 +1,6 @@
 [SETUP]
 num_radios=3D3
 start_iwd=3D0
-max_test_exec_interval_sec=3D55
-tmpfs_extra_stuff=3Dpwd.eap_user:IWD-Frag
 =

 [HOSTAPD]
 rad0=3DssidEAP-PWD.conf
diff --git a/autotests/testEAP-SIM-ofono/hw.conf b/autotests/testEAP-SIM-of=
ono/hw.conf
index 5f4fc8e4..0255b153 100644
--- a/autotests/testEAP-SIM-ofono/hw.conf
+++ b/autotests/testEAP-SIM-ofono/hw.conf
@@ -1,7 +1,5 @@
 [SETUP]
 num_radios=3D2
-max_test_exec_interval_sec=3D40
-tmpfs_extra_stuff=3Dsim.eap_user:sim.db:../misc/phonesim/phonesim.conf
 sim_keys=3Dofono
 =

 [HOSTAPD]
diff --git a/autotests/testEAP-TLS-Frag/hw.conf b/autotests/testEAP-TLS-Fra=
g/hw.conf
index 80b08975..fba8466c 100644
--- a/autotests/testEAP-TLS-Frag/hw.conf
+++ b/autotests/testEAP-TLS-Frag/hw.conf
@@ -1,6 +1,5 @@
 [SETUP]
 num_radios=3D2
-tmpfs_extra_stuff=3D../misc/certs:main.conf
 =

 [HOSTAPD]
 rad0=3DssidEAP-TLS.conf
diff --git a/autotests/testEAP-TLS-embedded-pems/hw.conf b/autotests/testEA=
P-TLS-embedded-pems/hw.conf
index 0cbda377..fba8466c 100644
--- a/autotests/testEAP-TLS-embedded-pems/hw.conf
+++ b/autotests/testEAP-TLS-embedded-pems/hw.conf
@@ -1,6 +1,5 @@
 [SETUP]
 num_radios=3D2
-tmpfs_extra_stuff=3D../misc/certs
 =

 [HOSTAPD]
 rad0=3DssidEAP-TLS.conf
diff --git a/autotests/testEAP-TLS/hw.conf b/autotests/testEAP-TLS/hw.conf
index 0ce95320..03ded83a 100644
--- a/autotests/testEAP-TLS/hw.conf
+++ b/autotests/testEAP-TLS/hw.conf
@@ -1,6 +1,5 @@
 [SETUP]
 num_radios=3D5
-tmpfs_extra_stuff=3D../misc/certs
 =

 [HOSTAPD]
 rad0=3DssidEAP-TLS.conf
diff --git a/autotests/testEAP-TLSwithMFPC/hw.conf b/autotests/testEAP-TLSw=
ithMFPC/hw.conf
index 0cbda377..fba8466c 100644
--- a/autotests/testEAP-TLSwithMFPC/hw.conf
+++ b/autotests/testEAP-TLSwithMFPC/hw.conf
@@ -1,6 +1,5 @@
 [SETUP]
 num_radios=3D2
-tmpfs_extra_stuff=3D../misc/certs
 =

 [HOSTAPD]
 rad0=3DssidEAP-TLS.conf
diff --git a/autotests/testEAP-TLSwithMFPR/hw.conf b/autotests/testEAP-TLSw=
ithMFPR/hw.conf
index 0cbda377..fba8466c 100644
--- a/autotests/testEAP-TLSwithMFPR/hw.conf
+++ b/autotests/testEAP-TLSwithMFPR/hw.conf
@@ -1,6 +1,5 @@
 [SETUP]
 num_radios=3D2
-tmpfs_extra_stuff=3D../misc/certs
 =

 [HOSTAPD]
 rad0=3DssidEAP-TLS.conf
diff --git a/autotests/testEAP-TTLS-CHAP/hw.conf b/autotests/testEAP-TTLS-C=
HAP/hw.conf
index 4cf51117..c209fa4e 100644
--- a/autotests/testEAP-TTLS-CHAP/hw.conf
+++ b/autotests/testEAP-TTLS-CHAP/hw.conf
@@ -1,6 +1,5 @@
 [SETUP]
 num_radios=3D2
-tmpfs_extra_stuff=3D../misc/certs:eap-user-ttls-chap.text
 =

 [HOSTAPD]
 rad0=3DssidEAP-TTLS-CHAP.conf
diff --git a/autotests/testEAP-TTLS-EAP-MSCHAPV2/hw.conf b/autotests/testEA=
P-TTLS-EAP-MSCHAPV2/hw.conf
index 970a971b..8cef6a61 100644
--- a/autotests/testEAP-TTLS-EAP-MSCHAPV2/hw.conf
+++ b/autotests/testEAP-TTLS-EAP-MSCHAPV2/hw.conf
@@ -1,6 +1,5 @@
 [SETUP]
 num_radios=3D2
-tmpfs_extra_stuff=3D../misc/certs
 =

 [HOSTAPD]
 rad0=3DssidEAP-TTLS.conf
diff --git a/autotests/testEAP-TTLS-Frag/hw.conf b/autotests/testEAP-TTLS-F=
rag/hw.conf
index 279842c2..8cef6a61 100644
--- a/autotests/testEAP-TTLS-Frag/hw.conf
+++ b/autotests/testEAP-TTLS-Frag/hw.conf
@@ -1,6 +1,5 @@
 [SETUP]
 num_radios=3D2
-tmpfs_extra_stuff=3D../misc/certs:main.conf
 =

 [HOSTAPD]
 rad0=3DssidEAP-TTLS.conf
diff --git a/autotests/testEAP-TTLS-MSCHAP/hw.conf b/autotests/testEAP-TTLS=
-MSCHAP/hw.conf
index 4d6a2fa4..cffb804b 100644
--- a/autotests/testEAP-TTLS-MSCHAP/hw.conf
+++ b/autotests/testEAP-TTLS-MSCHAP/hw.conf
@@ -1,6 +1,5 @@
 [SETUP]
 num_radios=3D2
-tmpfs_extra_stuff=3D../misc/certs:eap-user-ttls-mschap.text
 =

 [HOSTAPD]
 rad0=3DssidEAP-TTLS-MSCHAP.conf
diff --git a/autotests/testEAP-TTLS-MSCHAPv2/hw.conf b/autotests/testEAP-TT=
LS-MSCHAPv2/hw.conf
index 3535d56a..856678b6 100644
--- a/autotests/testEAP-TTLS-MSCHAPv2/hw.conf
+++ b/autotests/testEAP-TTLS-MSCHAPv2/hw.conf
@@ -1,8 +1,6 @@
 [SETUP]
 num_radios=3D2
-tmpfs_extra_stuff=3D../misc/certs:eap-user-ttls-mschapv2.text
 start_iwd=3DFalse
-max_test_exec_interval_sec=3D45
 =

 [HOSTAPD]
 rad0=3DssidEAP-TTLS-MSCHAPv2.conf
diff --git a/autotests/testEAP-TTLS-PAP/hw.conf b/autotests/testEAP-TTLS-PA=
P/hw.conf
index 8320ec3f..dccfb229 100644
--- a/autotests/testEAP-TTLS-PAP/hw.conf
+++ b/autotests/testEAP-TTLS-PAP/hw.conf
@@ -1,6 +1,5 @@
 [SETUP]
 num_radios=3D2
-tmpfs_extra_stuff=3D../misc/certs:eap-user-ttls-pap.text
 =

 [HOSTAPD]
 rad0=3DssidEAP-TTLS-PAP.conf
diff --git a/autotests/testEAP-TTLS/hw.conf b/autotests/testEAP-TTLS/hw.conf
index 970a971b..8cef6a61 100644
--- a/autotests/testEAP-TTLS/hw.conf
+++ b/autotests/testEAP-TTLS/hw.conf
@@ -1,6 +1,5 @@
 [SETUP]
 num_radios=3D2
-tmpfs_extra_stuff=3D../misc/certs
 =

 [HOSTAPD]
 rad0=3DssidEAP-TTLS.conf
diff --git a/autotests/testEAP-WPS-Frag/hw.conf b/autotests/testEAP-WPS-Fra=
g/hw.conf
index eeac3bab..ab3a143b 100644
--- a/autotests/testEAP-WPS-Frag/hw.conf
+++ b/autotests/testEAP-WPS-Frag/hw.conf
@@ -1,6 +1,5 @@
 [SETUP]
 num_radios=3D2
-tmpfs_extra_stuff=3Dmain.conf
 =

 [HOSTAPD]
 rad0=3Dssid-wps-small-mtu.conf
diff --git a/autotests/testEAP-WPS/hw.conf b/autotests/testEAP-WPS/hw.conf
index 61af4456..53562f48 100644
--- a/autotests/testEAP-WPS/hw.conf
+++ b/autotests/testEAP-WPS/hw.conf
@@ -1,7 +1,6 @@
 [SETUP]
 num_radios=3D2
 start_iwd=3Dfalse
-max_test_exec_interval_sec=3D40
 =

 [HOSTAPD]
 rad0=3DssidWPS.conf
diff --git a/autotests/testFILS/hw.conf b/autotests/testFILS/hw.conf
index 3b88f36f..87863b75 100644
--- a/autotests/testFILS/hw.conf
+++ b/autotests/testFILS/hw.conf
@@ -1,7 +1,5 @@
 [SETUP]
 num_radios=3D3
-max_test_exec_interval_sec=3D45
-tmpfs_extra_stuff=3D../misc/secrets:pwd.eap_user:../misc/certs
 start_iwd=3D0
 =

 [HOSTAPD]
diff --git a/autotests/testFT-8021x-roam/hw.conf b/autotests/testFT-8021x-r=
oam/hw.conf
index 4906bbf3..353a194d 100644
--- a/autotests/testFT-8021x-roam/hw.conf
+++ b/autotests/testFT-8021x-roam/hw.conf
@@ -1,8 +1,5 @@
 [SETUP]
 num_radios=3D3
-max_test_exec_interval_sec=3D45
-tmpfs_extra_stuff=3D../misc/certs:main.conf
-needs_hwsim=3D1
 =

 [HOSTAPD]
 rad0=3Dft-eap-ccmp-1.conf
diff --git a/autotests/testFT-FILS-SHA256/hw.conf b/autotests/testFT-FILS-S=
HA256/hw.conf
index c3330d04..bb3ddd18 100644
--- a/autotests/testFT-FILS-SHA256/hw.conf
+++ b/autotests/testFT-FILS-SHA256/hw.conf
@@ -1,7 +1,5 @@
 [SETUP]
 num_radios=3D3
-max_test_exec_interval_sec=3D45
-tmpfs_extra_stuff=3D../misc/certs:main.conf:pwd.eap_user
 =

 [HOSTAPD]
 rad0=3Dft-eap-ccmp-1.conf
diff --git a/autotests/testFT-FILS-SHA384/hw.conf b/autotests/testFT-FILS-S=
HA384/hw.conf
index c3330d04..bb3ddd18 100644
--- a/autotests/testFT-FILS-SHA384/hw.conf
+++ b/autotests/testFT-FILS-SHA384/hw.conf
@@ -1,7 +1,5 @@
 [SETUP]
 num_radios=3D3
-max_test_exec_interval_sec=3D45
-tmpfs_extra_stuff=3D../misc/certs:main.conf:pwd.eap_user
 =

 [HOSTAPD]
 rad0=3Dft-eap-ccmp-1.conf
diff --git a/autotests/testFT-PSK-over-DS/hw.conf b/autotests/testFT-PSK-ov=
er-DS/hw.conf
index d2d50863..38251be8 100644
--- a/autotests/testFT-PSK-over-DS/hw.conf
+++ b/autotests/testFT-PSK-over-DS/hw.conf
@@ -1,8 +1,5 @@
 [SETUP]
 num_radios=3D3
-max_test_exec_interval_sec=3D45
-tmpfs_extra_stuff=3Dmain.conf
-needs_hwsim=3D1
 =

 [HOSTAPD]
 rad0=3Dft-psk-ccmp-1.conf
diff --git a/autotests/testFT-PSK-roam/hw.conf b/autotests/testFT-PSK-roam/=
hw.conf
index d08534c4..3fc77613 100644
--- a/autotests/testFT-PSK-roam/hw.conf
+++ b/autotests/testFT-PSK-roam/hw.conf
@@ -1,8 +1,5 @@
 [SETUP]
 num_radios=3D3
-max_test_exec_interval_sec=3D45
-tmpfs_extra_stuff=3Dmain.conf
-needs_hwsim=3D1
 start_iwd=3D0
 =

 [HOSTAPD]
diff --git a/autotests/testFT-SAE-roam/hw.conf b/autotests/testFT-SAE-roam/=
hw.conf
index 1f0f1c12..b576711f 100644
--- a/autotests/testFT-SAE-roam/hw.conf
+++ b/autotests/testFT-SAE-roam/hw.conf
@@ -1,8 +1,5 @@
 [SETUP]
 num_radios=3D4
-max_test_exec_interval_sec=3D120
-tmpfs_extra_stuff=3Dmain.conf
-needs_hwsim=3D1
 =

 [HOSTAPD]
 rad0=3Dft-sae-1.conf
diff --git a/autotests/testHT-VHT/hw.conf b/autotests/testHT-VHT/hw.conf
index 6d557ad1..037b3e85 100644
--- a/autotests/testHT-VHT/hw.conf
+++ b/autotests/testHT-VHT/hw.conf
@@ -1,8 +1,6 @@
 [SETUP]
 num_radios=3D4
-max_test_exec_interval_sec=3D45
 reg_domain=3DUS
-tmpfs_extra_stuff=3Dmain.conf
 =

 [HOSTAPD]
 rad0=3Dnon-ht-vht.conf
diff --git a/autotests/testHotspot/hw.conf b/autotests/testHotspot/hw.conf
index db1536da..d2e49ffd 100644
--- a/autotests/testHotspot/hw.conf
+++ b/autotests/testHotspot/hw.conf
@@ -1,7 +1,5 @@
 [SETUP]
 num_radios=3D6
-tmpfs_extra_stuff=3D../misc/certs:eap_users.text:example.conf:hessid.conf
-max_test_exec_interval_sec=3D60
 start_iwd=3D0
 =

 [HOSTAPD]
diff --git a/autotests/testKnownNetworks/hw.conf b/autotests/testKnownNetwo=
rks/hw.conf
index 2165611a..8a7ef73a 100644
--- a/autotests/testKnownNetworks/hw.conf
+++ b/autotests/testKnownNetworks/hw.conf
@@ -2,7 +2,6 @@
 num_radios=3D5
 start_iwd=3D0
 reg_domain=3DUS
-tmpfs_extra_stuff=3D../misc/certs:eap_users.text:example.conf
 =

 [HOSTAPD]
 rad0=3DssidNew.conf
diff --git a/autotests/testMFP-Options/hw.conf b/autotests/testMFP-Options/=
hw.conf
index cdeb0dfa..3cbba4b3 100644
--- a/autotests/testMFP-Options/hw.conf
+++ b/autotests/testMFP-Options/hw.conf
@@ -1,8 +1,6 @@
 [SETUP]
 num_radios=3D4
 start_iwd=3D0
-max_test_exec_interval_sec=3D50
-tmpfs_extra_stuff=3DIWD-MFP0:IWD-MFP1:IWD-MFP2
 =

 [HOSTAPD]
 rad0=3DssidMFP0.conf
diff --git a/autotests/testNetconfig/hw.conf b/autotests/testNetconfig/hw.c=
onf
index 323f1fb2..a2618b35 100644
--- a/autotests/testNetconfig/hw.conf
+++ b/autotests/testNetconfig/hw.conf
@@ -1,6 +1,5 @@
 [SETUP]
 num_radios=3D3
-max_test_exec_interval_sec=3D40
 start_iwd=3D0
 hwsim_medium=3Dno
 =

diff --git a/autotests/testPreauth-roam/hw.conf b/autotests/testPreauth-roa=
m/hw.conf
index 0070712c..72fe7290 100644
--- a/autotests/testPreauth-roam/hw.conf
+++ b/autotests/testPreauth-roam/hw.conf
@@ -1,8 +1,5 @@
 [SETUP]
 num_radios=3D3
-max_test_exec_interval_sec=3D30
-tmpfs_extra_stuff=3D../misc/certs
-needs_hwsim=3D1
 =

 [HOSTAPD]
 rad0=3Deaptls-preauth-1.conf
diff --git a/autotests/testRSSIAgent/hw.conf b/autotests/testRSSIAgent/hw.c=
onf
index 9b9d75be..1145b4b6 100644
--- a/autotests/testRSSIAgent/hw.conf
+++ b/autotests/testRSSIAgent/hw.conf
@@ -1,8 +1,5 @@
 [SETUP]
 num_radios=3D2
-max_test_exec_interval_sec=3D60
-tmpfs_extra_stuff=3Dmain.conf
-needs_hwsim=3D1
 =

 [HOSTAPD]
 rad0=3Dopen.conf
diff --git a/autotests/testRoamRetry/hw.conf b/autotests/testRoamRetry/hw.c=
onf
index 5dbe97b4..8b450b63 100644
--- a/autotests/testRoamRetry/hw.conf
+++ b/autotests/testRoamRetry/hw.conf
@@ -1,6 +1,5 @@
 [SETUP]
 num_radios=3D3
-needs_hwsim=3D1
 =

 [HOSTAPD]
 rad0=3Dssid1.conf
diff --git a/autotests/testSAQuery-spoofing/hw.conf b/autotests/testSAQuery=
-spoofing/hw.conf
index ba63798c..fad15b88 100644
--- a/autotests/testSAQuery-spoofing/hw.conf
+++ b/autotests/testSAQuery-spoofing/hw.conf
@@ -1,6 +1,5 @@
 [SETUP]
 num_radios=3D2
-needs_hwsim=3D1
 =

 [HOSTAPD]
 rad0=3DssidCCMP.conf
diff --git a/autotests/testScan/hw.conf b/autotests/testScan/hw.conf
index 82875f0b..b2464baf 100644
--- a/autotests/testScan/hw.conf
+++ b/autotests/testScan/hw.conf
@@ -1,8 +1,6 @@
 [SETUP]
 num_radios=3D5
 start_iwd=3D0
-max_test_exec_interval_sec=3D60
-tmpfs_extra_stuff=3D../misc/certs:../misc/secrets:main.conf
 =

 [HOSTAPD]
 rad0=3Dssid_hidden.conf
diff --git a/autotests/testScanKnownFreqs/hw.conf b/autotests/testScanKnown=
Freqs/hw.conf
index cdaaede5..50f0c6d0 100644
--- a/autotests/testScanKnownFreqs/hw.conf
+++ b/autotests/testScanKnownFreqs/hw.conf
@@ -1,7 +1,6 @@
 [SETUP]
 num_radios=3D4
 start_iwd=3D0
-max_test_exec_interval_sec=3D60
 reg_domain=3DUS
 =

 [HOSTAPD]
diff --git a/autotests/testWPA/hw.conf b/autotests/testWPA/hw.conf
index 75c5ac6e..c5a935d2 100644
--- a/autotests/testWPA/hw.conf
+++ b/autotests/testWPA/hw.conf
@@ -1,6 +1,5 @@
 [SETUP]
 num_radios=3D2
-max_test_exec_interval_sec=3D40
 =

 [HOSTAPD]
 rad0=3DssidTKIP.conf
-- =

2.26.2

--===============6201730053728850473==--

