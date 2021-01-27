Content-Type: multipart/mixed; boundary="===============5752638185935989009=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] eap-tls: Use the right variable in settings check
Date: Wed, 27 Jan 2021 15:02:25 +0100
Message-ID: <20210127140225.2476214-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5752638185935989009==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/eap-tls.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/eap-tls.c b/src/eap-tls.c
index ac7650dc..b20a1b39 100644
--- a/src/eap-tls.c
+++ b/src/eap-tls.c
@@ -174,7 +174,7 @@ static int eap_tls_settings_check(struct l_settings *se=
ttings,
 	 * Check whether the combination of settings that are present/missing
 	 * makes sense before validating each setting.
 	 */
-	if (bundle_value && (priv_key_value || client_cert)) {
+	if (bundle_value && (priv_key_value || client_cert_value)) {
 		l_error("Either %s or %s/%s can be used, not both",
 			bundle_setting, priv_key_setting, client_cert_setting);
 		ret =3D -EEXIST;
@@ -184,7 +184,7 @@ static int eap_tls_settings_check(struct l_settings *se=
ttings,
 			priv_key_setting, client_cert_setting);
 		ret =3D -ENOENT;
 		goto done;
-	} else if (!priv_key_value && client_cert) {
+	} else if (!priv_key_value && client_cert_value) {
 		l_error("%s present but no client private key (%s)",
 			client_cert_setting, priv_key_setting);
 		ret =3D -ENOENT;
-- =

2.27.0

--===============5752638185935989009==--

