Content-Type: multipart/mixed; boundary="===============6528260508846378723=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/5] unit: Add a WSC-R PBC test with Open auth_type
Date: Tue, 25 Aug 2020 00:34:26 +0200
Message-ID: <20200824223426.475779-5-andrew.zaborowski@intel.com>
In-Reply-To: <20200824223426.475779-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6528260508846378723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-wsc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/unit/test-wsc.c b/unit/test-wsc.c
index 0b9ec2f3..2063244c 100644
--- a/unit/test-wsc.c
+++ b/unit/test-wsc.c
@@ -2584,6 +2584,14 @@ struct wsc_credential wsc_r_test_wpa2_cred_psk =3D {
 	.encryption_type =3D WSC_ENCRYPTION_TYPE_AES_TKIP,
 };
 =

+struct wsc_credential wsc_r_test_open_cred =3D {
+	.ssid_len =3D 7,
+	.ssid =3D "thessid",
+	.auth_type =3D WSC_AUTHENTICATION_TYPE_OPEN,
+	.network_key_len =3D 0,
+	.encryption_type =3D WSC_ENCRYPTION_TYPE_NONE,
+};
+
 int main(int argc, char *argv[])
 {
 	l_test_init(&argc, &argv);
@@ -2703,6 +2711,9 @@ int main(int argc, char *argv[])
 	l_test_add("/wsc-r/handshake/PBC Handshake WPA2 PSK test",
 				wsc_r_test_pbc_handshake,
 				&wsc_r_test_wpa2_cred_psk);
+	l_test_add("/wsc-r/handshake/PBC Handshake Open test",
+				wsc_r_test_pbc_handshake,
+				&wsc_r_test_open_cred);
 =

 done:
 	return l_test_run();
-- =

2.25.1

--===============6528260508846378723==--

