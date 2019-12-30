Content-Type: multipart/mixed; boundary="===============2322169532085132268=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/5] auto-t: use stand alone radius server for
 testFT-FILS-SHA256
Date: Mon, 30 Dec 2019 10:09:53 -0800
Message-ID: <20191230180954.12644-4-prestwoj@gmail.com>
In-Reply-To: <20191230180954.12644-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2322169532085132268==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This fixes the test with recent hostapd versions
---
 autotests/testFT-FILS-SHA256/ft-eap-ccmp-1.conf | 14 ++------------
 autotests/testFT-FILS-SHA256/ft-eap-ccmp-2.conf | 11 ++---------
 autotests/testFT-FILS-SHA256/hw.conf            |  1 +
 autotests/testFT-FILS-SHA256/radius.conf        | 15 +++++++++++++++
 4 files changed, 20 insertions(+), 21 deletions(-)
 create mode 100644 autotests/testFT-FILS-SHA256/radius.conf

diff --git a/autotests/testFT-FILS-SHA256/ft-eap-ccmp-1.conf b/autotests/te=
stFT-FILS-SHA256/ft-eap-ccmp-1.conf
index a55d90a2..1853ff70 100644
--- a/autotests/testFT-FILS-SHA256/ft-eap-ccmp-1.conf
+++ b/autotests/testFT-FILS-SHA256/ft-eap-ccmp-1.conf
@@ -12,16 +12,9 @@ wpa=3D2
 wpa_key_mgmt=3DFT-EAP FILS-SHA256 FT-FILS-SHA256
 wpa_pairwise=3DCCMP
 ieee8021x=3D1
-eap_server=3D0
-eap_server_erp=3D1
-erp_domain=3Dexample.com
+
 fils_realm=3Dexample.com
-#eap_user_file=3D/tmp/certs/eap-user-tls.text
-eap_user_file=3D/tmp/pwd.eap_user
-pwd_group=3D19
-#ca_cert=3D/tmp/certs/cert-ca.pem
-#server_cert=3D/tmp/certs/cert-server.pem
-#private_key=3D/tmp/certs/cert-server-key.pem
+
 wpa_ptk_rekey=3D30
 wpa_group_rekey=3D80
 ieee80211w=3D1
@@ -43,9 +36,6 @@ ap_table_expiration_time=3D36000
 ap_table_max_size=3D10
 rrm_neighbor_report=3D1
 =

-radius_server_clients=3D/tmp/certs/radius-clients.text
-radius_server_auth_port=3D1812
-
 auth_server_addr=3D127.0.0.1
 auth_server_port=3D1812
 auth_server_shared_secret=3Dsecret
diff --git a/autotests/testFT-FILS-SHA256/ft-eap-ccmp-2.conf b/autotests/te=
stFT-FILS-SHA256/ft-eap-ccmp-2.conf
index a7878264..24266ea9 100644
--- a/autotests/testFT-FILS-SHA256/ft-eap-ccmp-2.conf
+++ b/autotests/testFT-FILS-SHA256/ft-eap-ccmp-2.conf
@@ -12,16 +12,9 @@ wpa=3D2
 wpa_key_mgmt=3DFT-FILS-SHA256
 wpa_pairwise=3DCCMP
 ieee8021x=3D1
-eap_server=3D0
-eap_server_erp=3D1
-erp_domain=3Dexample.com
+
 fils_realm=3Dexample.com
-#eap_user_file=3D/tmp/certs/eap-user-tls.text
-eap_user_file=3D/tmp/pwd.eap_user
-pwd_group=3D19
-#ca_cert=3D/tmp/certs/cert-ca.pem
-#server_cert=3D/tmp/certs/cert-server.pem
-#private_key=3D/tmp/certs/cert-server-key.pem
+
 wpa_ptk_rekey=3D30
 wpa_group_rekey=3D80
 ieee80211w=3D1
diff --git a/autotests/testFT-FILS-SHA256/hw.conf b/autotests/testFT-FILS-S=
HA256/hw.conf
index 9ea4f110..b5c6757c 100644
--- a/autotests/testFT-FILS-SHA256/hw.conf
+++ b/autotests/testFT-FILS-SHA256/hw.conf
@@ -7,3 +7,4 @@ iwd_config_dir=3D/tmp
 [HOSTAPD]
 rad0=3Dft-eap-ccmp-1.conf
 rad1=3Dft-eap-ccmp-2.conf
+radius_server=3Dradius.conf
diff --git a/autotests/testFT-FILS-SHA256/radius.conf b/autotests/testFT-FI=
LS-SHA256/radius.conf
new file mode 100644
index 00000000..4fcfdfff
--- /dev/null
+++ b/autotests/testFT-FILS-SHA256/radius.conf
@@ -0,0 +1,15 @@
+driver=3Dnone
+radius_server_clients=3D/tmp/certs/radius-clients.text
+radius_server_auth_port=3D1812
+eap_user_file=3D/tmp/pwd.eap_user
+eap_server=3D0
+eap_server_erp=3D1
+
+erp_send_reauth_start=3D1
+erp_domain=3Dexample.com
+fils_realm=3Dexample.com
+disable_pmksa_caching=3D1
+
+pwd_group=3D19
+wpa_group_rekey=3D30
+wpa_ptk_rekey=3D30
-- =

2.17.1

--===============2322169532085132268==--

