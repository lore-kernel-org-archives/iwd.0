Content-Type: multipart/mixed; boundary="===============5005458632813130197=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/7] auto-t: make hwsim registration off by default
Date: Thu, 12 Aug 2021 13:38:10 -0700
Message-ID: <20210812203812.738060-5-prestwoj@gmail.com>
In-Reply-To: <20210812203812.738060-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5005458632813130197==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With the addition of connect_bssid/roam very few tests actually
require hwsim. Since hwsim can lead to problems with scan results
its best to have it off by default and have each test that needs
it explicitly turn it on.

Tests which previously turned it off have had that option removed.

Tests that do require hwsim still are vulnerable to scan result
problems, so for these tests beacon_int was added to the hostapd
config which seems to help with reliability somewhat.
---
 autotests/testAP/hw.conf                           | 1 -
 autotests/testBSSBlacklist/hw.conf                 | 1 +
 autotests/testBSSBlacklist/ssid1.conf              | 1 +
 autotests/testBSSBlacklist/ssid2.conf              | 1 +
 autotests/testBSSBlacklist/ssid3.conf              | 3 ++-
 autotests/testFT-FILS/hw.conf                      | 1 +
 autotests/testHT-VHT/ht.conf                       | 1 +
 autotests/testHT-VHT/hw.conf                       | 1 +
 autotests/testHT-VHT/non-ht-vht.conf               | 1 +
 autotests/testHT-VHT/vht.conf                      | 1 +
 autotests/testHiddenNetworks/hw.conf               | 1 -
 autotests/testHotspot/hw.conf                      | 1 +
 autotests/testHotspot/ssidHotspot.conf             | 1 +
 autotests/testHotspot/ssidHotspotUnconfigured.conf | 1 +
 autotests/testHotspot/ssidWPA2-1.conf              | 1 +
 autotests/testHotspot/ssidWPA2-2.conf              | 1 +
 autotests/testHotspot/ssidWPA2-3.conf              | 1 +
 autotests/testKnownNetworks/ssidCCMP-2G.conf       | 1 +
 autotests/testKnownNetworks/ssidCCMP-5G.conf       | 1 +
 autotests/testKnownNetworks/ssidHotspot.conf       | 1 +
 autotests/testNetconfig/hw.conf                    | 1 -
 autotests/testOWE/hw.conf                          | 1 +
 autotests/testP2P/hw.conf                          | 1 -
 autotests/testPSK-roam/hw.conf                     | 1 +
 autotests/testRSSIAgent/hw.conf                    | 1 +
 autotests/testRoamRetry/hw.conf                    | 1 +
 autotests/testRoamRetry/ssid1.conf                 | 1 +
 autotests/testRoamRetry/ssid2.conf                 | 1 +
 autotests/testSAE/hw.conf                          | 1 +
 autotests/testSAQuery-spoofing/hw.conf             | 1 +
 autotests/testSAQuery-spoofing/ssidCCMP.conf       | 1 +
 tools/test-runner                                  | 2 +-
 32 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/autotests/testAP/hw.conf b/autotests/testAP/hw.conf
index c9c0c7ca..f1ed6cd9 100644
--- a/autotests/testAP/hw.conf
+++ b/autotests/testAP/hw.conf
@@ -1,7 +1,6 @@
 [SETUP]
 num_radios=3D6
 start_iwd=3D0
-hwsim_medium=3Dno
 =

 [HOSTAPD]
 rad0=3Dpsk-ccmp.conf
diff --git a/autotests/testBSSBlacklist/hw.conf b/autotests/testBSSBlacklis=
t/hw.conf
index d6b754aa..cfabbc32 100644
--- a/autotests/testBSSBlacklist/hw.conf
+++ b/autotests/testBSSBlacklist/hw.conf
@@ -1,6 +1,7 @@
 [SETUP]
 num_radios=3D5
 start_iwd=3D0
+hwsim_medium=3Dyes
 =

 [HOSTAPD]
 rad0=3Dssid1.conf
diff --git a/autotests/testBSSBlacklist/ssid1.conf b/autotests/testBSSBlack=
list/ssid1.conf
index 2db39a8c..21f1a2fe 100644
--- a/autotests/testBSSBlacklist/ssid1.conf
+++ b/autotests/testBSSBlacklist/ssid1.conf
@@ -9,3 +9,4 @@ wpa_passphrase=3Dsecret123
 ctrl_interface=3D/var/run/hostapd
 =

 rrm_neighbor_report=3D1
+beacon_int=3D10
diff --git a/autotests/testBSSBlacklist/ssid2.conf b/autotests/testBSSBlack=
list/ssid2.conf
index d37c308d..9d350506 100644
--- a/autotests/testBSSBlacklist/ssid2.conf
+++ b/autotests/testBSSBlacklist/ssid2.conf
@@ -9,3 +9,4 @@ wpa_passphrase=3Dsecret123
 ctrl_interface=3D/var/run/hostapd
 =

 rrm_neighbor_report=3D1
+beacon_int=3D10
diff --git a/autotests/testBSSBlacklist/ssid3.conf b/autotests/testBSSBlack=
list/ssid3.conf
index c352d781..9ac34fcb 100644
--- a/autotests/testBSSBlacklist/ssid3.conf
+++ b/autotests/testBSSBlacklist/ssid3.conf
@@ -9,4 +9,5 @@ wpa_passphrase=3Dsecret123
 ctrl_interface=3D/var/run/hostapd
 =

 rrm_neighbor_report=3D1
-max_num_sta=3D1
\ No newline at end of file
+max_num_sta=3D1
+beacon_int=3D10
diff --git a/autotests/testFT-FILS/hw.conf b/autotests/testFT-FILS/hw.conf
index 322f0862..c74cf864 100644
--- a/autotests/testFT-FILS/hw.conf
+++ b/autotests/testFT-FILS/hw.conf
@@ -1,6 +1,7 @@
 [SETUP]
 num_radios=3D3
 start_iwd=3D0
+hwsim_medium=3Dyes
 =

 [HOSTAPD]
 rad0=3Dft-eap-ccmp-1.conf
diff --git a/autotests/testHT-VHT/ht.conf b/autotests/testHT-VHT/ht.conf
index 9a84b063..71829074 100644
--- a/autotests/testHT-VHT/ht.conf
+++ b/autotests/testHT-VHT/ht.conf
@@ -9,3 +9,4 @@ wpa_passphrase=3Dsecret123
 =

 ieee80211n=3D1
 channel=3D36
+beacon_int=3D10
diff --git a/autotests/testHT-VHT/hw.conf b/autotests/testHT-VHT/hw.conf
index 037b3e85..b9335368 100644
--- a/autotests/testHT-VHT/hw.conf
+++ b/autotests/testHT-VHT/hw.conf
@@ -1,6 +1,7 @@
 [SETUP]
 num_radios=3D4
 reg_domain=3DUS
+hwsim_medium=3Dyes
 =

 [HOSTAPD]
 rad0=3Dnon-ht-vht.conf
diff --git a/autotests/testHT-VHT/non-ht-vht.conf b/autotests/testHT-VHT/no=
n-ht-vht.conf
index 6df06a02..dc00a249 100644
--- a/autotests/testHT-VHT/non-ht-vht.conf
+++ b/autotests/testHT-VHT/non-ht-vht.conf
@@ -6,3 +6,4 @@ ssid=3DtestSSID
 wpa=3D2
 wpa_pairwise=3DCCMP
 wpa_passphrase=3Dsecret123
+beacon_int=3D10
diff --git a/autotests/testHT-VHT/vht.conf b/autotests/testHT-VHT/vht.conf
index 9a7ec0d7..513cf4cc 100644
--- a/autotests/testHT-VHT/vht.conf
+++ b/autotests/testHT-VHT/vht.conf
@@ -12,3 +12,4 @@ ieee80211n=3D1
 ieee80211ac=3D1
 =

 channel=3D36
+beacon_int=3D10
diff --git a/autotests/testHiddenNetworks/hw.conf b/autotests/testHiddenNet=
works/hw.conf
index 065e9003..be72c4a5 100644
--- a/autotests/testHiddenNetworks/hw.conf
+++ b/autotests/testHiddenNetworks/hw.conf
@@ -1,7 +1,6 @@
 [SETUP]
 num_radios=3D7
 start_iwd=3D0
-hwsim_medium=3Dno
 =

 [HOSTAPD]
 rad0=3DssidHiddenOpen.conf
diff --git a/autotests/testHotspot/hw.conf b/autotests/testHotspot/hw.conf
index d2e49ffd..20204694 100644
--- a/autotests/testHotspot/hw.conf
+++ b/autotests/testHotspot/hw.conf
@@ -1,6 +1,7 @@
 [SETUP]
 num_radios=3D6
 start_iwd=3D0
+hwsim_medium=3Dyes
 =

 [HOSTAPD]
 rad0=3DssidHotspot.conf
diff --git a/autotests/testHotspot/ssidHotspot.conf b/autotests/testHotspot=
/ssidHotspot.conf
index bcad7210..860aacfb 100644
--- a/autotests/testHotspot/ssidHotspot.conf
+++ b/autotests/testHotspot/ssidHotspot.conf
@@ -44,3 +44,4 @@ eap_user_file=3D/tmp/eap_users.text
 ca_cert=3D/tmp/certs/cert-ca.pem
 server_cert=3D/tmp/certs/cert-server.pem
 private_key=3D/tmp/certs/cert-server-key.pem
+beacon_int=3D10
diff --git a/autotests/testHotspot/ssidHotspotUnconfigured.conf b/autotests=
/testHotspot/ssidHotspotUnconfigured.conf
index 287dab6c..635fc0b3 100644
--- a/autotests/testHotspot/ssidHotspotUnconfigured.conf
+++ b/autotests/testHotspot/ssidHotspotUnconfigured.conf
@@ -44,3 +44,4 @@ eap_user_file=3D/tmp/eap_users.text
 ca_cert=3D/tmp/certs/cert-ca.pem
 server_cert=3D/tmp/certs/cert-server.pem
 private_key=3D/tmp/certs/cert-server-key.pem
+beacon_int=3D10
diff --git a/autotests/testHotspot/ssidWPA2-1.conf b/autotests/testHotspot/=
ssidWPA2-1.conf
index 0c9aede5..b2f04eec 100644
--- a/autotests/testHotspot/ssidWPA2-1.conf
+++ b/autotests/testHotspot/ssidWPA2-1.conf
@@ -6,3 +6,4 @@ ssid=3DssidWPA2-1
 wpa=3D2
 wpa_pairwise=3DCCMP
 wpa_passphrase=3Dsecret123
+beacon_int=3D10
diff --git a/autotests/testHotspot/ssidWPA2-2.conf b/autotests/testHotspot/=
ssidWPA2-2.conf
index 2058d4a3..cc0c31b3 100644
--- a/autotests/testHotspot/ssidWPA2-2.conf
+++ b/autotests/testHotspot/ssidWPA2-2.conf
@@ -6,3 +6,4 @@ ssid=3DssidWPA2-2
 wpa=3D2
 wpa_pairwise=3DCCMP
 wpa_passphrase=3Dsecret123
+beacon_int=3D10
diff --git a/autotests/testHotspot/ssidWPA2-3.conf b/autotests/testHotspot/=
ssidWPA2-3.conf
index d536ebd1..a3468936 100644
--- a/autotests/testHotspot/ssidWPA2-3.conf
+++ b/autotests/testHotspot/ssidWPA2-3.conf
@@ -6,3 +6,4 @@ ssid=3DssidWPA2-3
 wpa=3D2
 wpa_pairwise=3DCCMP
 wpa_passphrase=3Dsecret123
+beacon_int=3D10
diff --git a/autotests/testKnownNetworks/ssidCCMP-2G.conf b/autotests/testK=
nownNetworks/ssidCCMP-2G.conf
index 074e8228..83b82e35 100644
--- a/autotests/testKnownNetworks/ssidCCMP-2G.conf
+++ b/autotests/testKnownNetworks/ssidCCMP-2G.conf
@@ -5,3 +5,4 @@ ssid=3DssidCCMP
 wpa=3D2
 wpa_pairwise=3DCCMP
 wpa_passphrase=3Dsecret123
+beacon_int=3D10
diff --git a/autotests/testKnownNetworks/ssidCCMP-5G.conf b/autotests/testK=
nownNetworks/ssidCCMP-5G.conf
index feb26a9d..3110cce8 100644
--- a/autotests/testKnownNetworks/ssidCCMP-5G.conf
+++ b/autotests/testKnownNetworks/ssidCCMP-5G.conf
@@ -6,3 +6,4 @@ country_code=3DUS
 wpa=3D2
 wpa_pairwise=3DCCMP
 wpa_passphrase=3Dsecret123
+beacon_int=3D10
diff --git a/autotests/testKnownNetworks/ssidHotspot.conf b/autotests/testK=
nownNetworks/ssidHotspot.conf
index 8f5ea7cc..95170c84 100644
--- a/autotests/testKnownNetworks/ssidHotspot.conf
+++ b/autotests/testKnownNetworks/ssidHotspot.conf
@@ -44,3 +44,4 @@ eap_user_file=3D/tmp/eap_users.text
 ca_cert=3D/tmp/certs/cert-ca.pem
 server_cert=3D/tmp/certs/cert-server.pem
 private_key=3D/tmp/certs/cert-server-key.pem
+beacon_int=3D10
diff --git a/autotests/testNetconfig/hw.conf b/autotests/testNetconfig/hw.c=
onf
index a2618b35..d5adc9ad 100644
--- a/autotests/testNetconfig/hw.conf
+++ b/autotests/testNetconfig/hw.conf
@@ -1,7 +1,6 @@
 [SETUP]
 num_radios=3D3
 start_iwd=3D0
-hwsim_medium=3Dno
 =

 [HOSTAPD]
 rad0=3DssidTKIP.conf
diff --git a/autotests/testOWE/hw.conf b/autotests/testOWE/hw.conf
index fe59f389..1421b69c 100644
--- a/autotests/testOWE/hw.conf
+++ b/autotests/testOWE/hw.conf
@@ -1,5 +1,6 @@
 [SETUP]
 num_radios=3D4
+hwsim_medium=3Dyes
 =

 [HOSTAPD]
 rad0=3DssidOWE-1.conf
diff --git a/autotests/testP2P/hw.conf b/autotests/testP2P/hw.conf
index d8f213f7..7cc89267 100644
--- a/autotests/testP2P/hw.conf
+++ b/autotests/testP2P/hw.conf
@@ -1,6 +1,5 @@
 [SETUP]
 num_radios=3D2
-hwsim_medium=3Dno
 =

 [WPA_SUPPLICANT]
 rad1=3Drad1-p2p.conf
diff --git a/autotests/testPSK-roam/hw.conf b/autotests/testPSK-roam/hw.conf
index 3fc77613..c2b35d6e 100644
--- a/autotests/testPSK-roam/hw.conf
+++ b/autotests/testPSK-roam/hw.conf
@@ -1,6 +1,7 @@
 [SETUP]
 num_radios=3D3
 start_iwd=3D0
+hwsim_medium=3Dyes
 =

 [HOSTAPD]
 rad0=3Dft-psk-ccmp-1.conf
diff --git a/autotests/testRSSIAgent/hw.conf b/autotests/testRSSIAgent/hw.c=
onf
index 1145b4b6..fb5a0bbd 100644
--- a/autotests/testRSSIAgent/hw.conf
+++ b/autotests/testRSSIAgent/hw.conf
@@ -1,5 +1,6 @@
 [SETUP]
 num_radios=3D2
+hwsim_medium=3Dyes
 =

 [HOSTAPD]
 rad0=3Dopen.conf
diff --git a/autotests/testRoamRetry/hw.conf b/autotests/testRoamRetry/hw.c=
onf
index 8b450b63..3408a352 100644
--- a/autotests/testRoamRetry/hw.conf
+++ b/autotests/testRoamRetry/hw.conf
@@ -1,5 +1,6 @@
 [SETUP]
 num_radios=3D3
+hwsim_medium=3Dyes
 =

 [HOSTAPD]
 rad0=3Dssid1.conf
diff --git a/autotests/testRoamRetry/ssid1.conf b/autotests/testRoamRetry/s=
sid1.conf
index 2c5cc8d6..f7b3dac5 100644
--- a/autotests/testRoamRetry/ssid1.conf
+++ b/autotests/testRoamRetry/ssid1.conf
@@ -9,3 +9,4 @@ wpa_passphrase=3Dsecret123
 ctrl_interface=3D/var/run/hostapd
 =

 rrm_neighbor_report=3D1
+beacon_int=3D10
diff --git a/autotests/testRoamRetry/ssid2.conf b/autotests/testRoamRetry/s=
sid2.conf
index 5626c032..4907b549 100644
--- a/autotests/testRoamRetry/ssid2.conf
+++ b/autotests/testRoamRetry/ssid2.conf
@@ -9,3 +9,4 @@ wpa_passphrase=3Dsecret123
 ctrl_interface=3D/var/run/hostapd
 =

 rrm_neighbor_report=3D1
+beacon_int=3D10
diff --git a/autotests/testSAE/hw.conf b/autotests/testSAE/hw.conf
index c2b1ba51..72b161b8 100644
--- a/autotests/testSAE/hw.conf
+++ b/autotests/testSAE/hw.conf
@@ -1,6 +1,7 @@
 [SETUP]
 num_radios=3D2
 start_iwd=3D0
+hwsim_medium=3Dyes
 =

 [HOSTAPD]
 rad0=3DssidSAE.conf
diff --git a/autotests/testSAQuery-spoofing/hw.conf b/autotests/testSAQuery=
-spoofing/hw.conf
index fad15b88..38b57e18 100644
--- a/autotests/testSAQuery-spoofing/hw.conf
+++ b/autotests/testSAQuery-spoofing/hw.conf
@@ -1,5 +1,6 @@
 [SETUP]
 num_radios=3D2
+hwsim_medium=3Dyes
 =

 [HOSTAPD]
 rad0=3DssidCCMP.conf
diff --git a/autotests/testSAQuery-spoofing/ssidCCMP.conf b/autotests/testS=
AQuery-spoofing/ssidCCMP.conf
index c79f5e55..517083bf 100644
--- a/autotests/testSAQuery-spoofing/ssidCCMP.conf
+++ b/autotests/testSAQuery-spoofing/ssidCCMP.conf
@@ -8,3 +8,4 @@ wpa_passphrase=3Dsecret123
 =

 ieee80211w=3D2
 wpa_key_mgmt=3DWPA-PSK-SHA256
+beacon_int=3D10
diff --git a/tools/test-runner b/tools/test-runner
index 28c7d900..1d148b13 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -755,7 +755,7 @@ class TestContext(Namespace):
 		nradios =3D int(setup['num_radios'])
 		args =3D ['hwsim']
 =

-		if not self.hw_config['SETUP'].get('hwsim_medium', 'yes') in ['yes', '1'=
, 'true']:
+		if self.hw_config['SETUP'].get('hwsim_medium', 'no') in ['no', '0', 'fal=
se']:
 			# register hwsim as medium
 			args.extend(['--no-register'])
 =

-- =

2.31.1

--===============5005458632813130197==--

