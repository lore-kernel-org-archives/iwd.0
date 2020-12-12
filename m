Content-Type: multipart/mixed; boundary="===============5106568532138167817=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/2] eap-tls: Don't skip a ServerDomainMask vs. CACert check
Date: Sat, 12 Dec 2020 02:09:54 +0100
Message-ID: <20201212010954.583418-2-andrew.zaborowski@intel.com>
In-Reply-To: <20201212010954.583418-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5106568532138167817==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The check that requires CACert if ServerDomainMask is given should
be independent of whether a client certificate and key are set, but
was in the part of eap_tls_common_settings_check() that only runs if
a certificate and key are given, move it up and simplify the logic
slightly.
---
 src/eap-tls-common.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/src/eap-tls-common.c b/src/eap-tls-common.c
index aa43e5a3..3d04d943 100644
--- a/src/eap-tls-common.c
+++ b/src/eap-tls-common.c
@@ -899,7 +899,6 @@ int eap_tls_common_settings_check(struct l_settings *se=
ttings,
 	char client_cert_setting[72];
 	char client_key_setting[72];
 	char passphrase_setting[72];
-	struct l_queue *cacerts =3D NULL;
 	struct l_certchain *cert =3D NULL;
 	struct l_key *priv_key =3D NULL;
 	bool is_public;
@@ -913,7 +912,7 @@ int eap_tls_common_settings_check(struct l_settings *se=
ttings,
 	struct l_key *pub_key;
 	const char *domain_mask_str;
 =

-	L_AUTO_FREE_VAR(char *, ca_cert);
+	L_AUTO_FREE_VAR(char *, ca_cert) =3D NULL;
 	L_AUTO_FREE_VAR(char *, client_cert) =3D NULL;
 	L_AUTO_FREE_VAR(char *, client_key) =3D NULL;
 	L_AUTO_FREE_VAR(char *, passphrase) =3D NULL;
@@ -935,12 +934,31 @@ int eap_tls_common_settings_check(struct l_settings *=
settings,
 	snprintf(setting_key, sizeof(setting_key), "%sCACert", prefix);
 	ca_cert =3D l_settings_get_string(settings, "Security", setting_key);
 	if (ca_cert) {
-		cacerts =3D eap_tls_load_ca_cert(settings, ca_cert);
+		struct l_queue *cacerts =3D
+			eap_tls_load_ca_cert(settings, ca_cert);
 =

 		if (!cacerts) {
 			l_error("Failed to load %s", ca_cert);
 			return -EIO;
 		}
+
+		l_queue_destroy(cacerts,
+				(l_queue_destroy_func_t) l_cert_free);
+	}
+
+	/*
+	 * Require CACert if ServerDomainMask is present.  If the server
+	 * certificate is not being checked against any trusted certificates
+	 * there's no point validating its contents and we wouldn't even
+	 * receive the subject DN from ell, because it may be freely made up.
+	 */
+	snprintf(setting_key, sizeof(setting_key), "%sServerDomainMask",
+			prefix);
+	domain_mask_str =3D l_settings_get_value(settings, "Security",
+						setting_key);
+	if (domain_mask_str && !ca_cert) {
+		l_error("%s was set but no CA Certificates given", setting_key);
+		return -EINVAL;
 	}
 =

 	snprintf(client_cert_setting, sizeof(client_cert_setting),
@@ -1132,26 +1150,8 @@ int eap_tls_common_settings_check(struct l_settings =
*settings,
 		goto done;
 	}
 =

-	/*
-	 * Require CACert if ServerDomainMask is present.  If the server
-	 * certificate is not being checked against any trusted certificates
-	 * there's no point validating its contents and we wouldn't even
-	 * receive the subject DN from ell, because it may be freely made up.
-	 */
-	snprintf(setting_key, sizeof(setting_key), "%sServerDomainMask",
-			prefix);
-	domain_mask_str =3D l_settings_get_value(settings, "Security",
-						setting_key);
-	if (domain_mask_str && !cacerts) {
-		l_error("%s was set but no CA Certificates given", setting_key);
-		ret =3D -EINVAL;
-		goto done;
-	}
-
 	ret =3D 0;
 done:
-	l_queue_destroy(cacerts,
-			(l_queue_destroy_func_t) l_cert_free);
 	l_certchain_free(cert);
 	l_key_free(priv_key);
 =

-- =

2.27.0

--===============5106568532138167817==--

