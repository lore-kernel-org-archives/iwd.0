Content-Type: multipart/mixed; boundary="===============4465041300438080356=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/5] auto-t: use stand alone radius server for testFILS
Date: Mon, 30 Dec 2019 10:09:52 -0800
Message-ID: <20191230180954.12644-3-prestwoj@gmail.com>
In-Reply-To: <20191230180954.12644-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4465041300438080356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This fixes the test with recent hostapd versions
---
 autotests/testFILS/hw.conf           |  1 +
 autotests/testFILS/radius.conf       | 15 +++++++++++++++
 autotests/testFILS/ssidFILS-256.conf |  8 --------
 autotests/testFILS/ssidFILS-384.conf |  6 ------
 4 files changed, 16 insertions(+), 14 deletions(-)
 create mode 100644 autotests/testFILS/radius.conf

diff --git a/autotests/testFILS/hw.conf b/autotests/testFILS/hw.conf
index 0028b5f6..3b88f36f 100644
--- a/autotests/testFILS/hw.conf
+++ b/autotests/testFILS/hw.conf
@@ -7,3 +7,4 @@ start_iwd=3D0
 [HOSTAPD]
 rad0=3DssidFILS-256.conf
 rad1=3DssidFILS-384.conf
+radius_server=3Dradius.conf
diff --git a/autotests/testFILS/radius.conf b/autotests/testFILS/radius.conf
new file mode 100644
index 00000000..4fcfdfff
--- /dev/null
+++ b/autotests/testFILS/radius.conf
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
diff --git a/autotests/testFILS/ssidFILS-256.conf b/autotests/testFILS/ssid=
FILS-256.conf
index b3f3139a..a5f70f3a 100644
--- a/autotests/testFILS/ssidFILS-256.conf
+++ b/autotests/testFILS/ssidFILS-256.conf
@@ -14,16 +14,8 @@ auth_server_port=3D1812
 auth_server_shared_secret=3Dsecret
 nas_identifier=3Dnas.w1.fi
 =

-erp_send_reauth_start=3D1
-erp_domain=3Dexample.com
 fils_realm=3Dexample.com
 disable_pmksa_caching=3D1
 =

-radius_server_clients=3D/tmp/certs/radius-clients.text
-radius_server_auth_port=3D1812
-eap_server=3D0
-eap_user_file=3D/tmp/pwd.eap_user
-eap_server_erp=3D1
-pwd_group=3D19
 wpa_group_rekey=3D30
 wpa_ptk_rekey=3D30
diff --git a/autotests/testFILS/ssidFILS-384.conf b/autotests/testFILS/ssid=
FILS-384.conf
index 9a3a3059..613c37be 100644
--- a/autotests/testFILS/ssidFILS-384.conf
+++ b/autotests/testFILS/ssidFILS-384.conf
@@ -14,14 +14,8 @@ auth_server_port=3D1812
 auth_server_shared_secret=3Dsecret
 nas_identifier=3Dnas.w1.fi
 =

-erp_send_reauth_start=3D1
-erp_domain=3Dexample.com
 fils_realm=3Dexample.com
 disable_pmksa_caching=3D1
 =

-eap_server=3D0
-eap_user_file=3D/tmp/pwd.eap_user
-eap_server_erp=3D1
-pwd_group=3D19
 wpa_group_rekey=3D30
 wpa_ptk_rekey=3D30
-- =

2.17.1

--===============4465041300438080356==--

