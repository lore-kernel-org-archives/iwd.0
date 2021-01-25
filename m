Content-Type: multipart/mixed; boundary="===============7941118305144946149=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/7] eap-tls: Make use of l_cert_load_container_file
Date: Mon, 25 Jan 2021 18:56:12 +0100
Message-ID: <20210125175617.2417412-2-andrew.zaborowski@intel.com>
In-Reply-To: <20210125175617.2417412-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7941118305144946149==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Switch EAP-TLS-ClientCert and EAP-TLS-ClientKey to use
l_cert_load_container_file for file loading so that the file format is
autodetected.  Add new setting EAP-TLS-ClientKeyBundle for loading both
the client certificate and private key from one file.
---
 src/eap-tls-common.c |  40 ++++++++++---
 src/eap-tls-common.h |   9 ++-
 src/eap-tls.c        | 137 +++++++++++++++++++++++++++++++++++--------
 3 files changed, 151 insertions(+), 35 deletions(-)

diff --git a/src/eap-tls-common.c b/src/eap-tls-common.c
index 164115d8..5edbfc5d 100644
--- a/src/eap-tls-common.c
+++ b/src/eap-tls-common.c
@@ -868,12 +868,25 @@ static struct l_queue *eap_tls_load_ca_cert(struct l_=
settings *settings,
 }
 =

 struct l_certchain *eap_tls_load_client_cert(struct l_settings *settings,
-						const char *value)
+						const char *value,
+						const char *passphrase,
+						bool *out_is_encrypted)
 {
 	const char *pem;
 =

-	if (!is_embedded(value))
-		return l_pem_load_certificate_chain(value);
+	if (!is_embedded(value)) {
+		struct l_certchain *certchain;
+
+		if (l_cert_load_container_file(value, passphrase,
+						&certchain, NULL,
+						out_is_encrypted))
+			return certchain;
+
+		if (out_is_encrypted)
+			*out_is_encrypted =3D false;
+
+		return NULL;
+	}
 =

 	pem =3D load_embedded_pem(settings, value);
 	if (!pem)
@@ -883,20 +896,31 @@ struct l_certchain *eap_tls_load_client_cert(struct l=
_settings *settings,
 }
 =

 struct l_key *eap_tls_load_priv_key(struct l_settings *settings,
-				const char *value, const char *passphrase,
-				bool *is_encrypted)
+					const char *value,
+					const char *passphrase,
+					bool *out_is_encrypted)
 {
 	const char *pem;
 =

-	if (!is_embedded(value))
-		return l_pem_load_private_key(value, passphrase, is_encrypted);
+	if (!is_embedded(value)) {
+		struct l_key *key;
+
+		if (l_cert_load_container_file(value, passphrase, NULL, &key,
+						out_is_encrypted))
+			return key;
+
+		if (out_is_encrypted)
+			*out_is_encrypted =3D false;
+
+		return NULL;
+	}
 =

 	pem =3D load_embedded_pem(settings, value);
 	if (!pem)
 		return NULL;
 =

 	return l_pem_load_private_key_from_data(pem, strlen(pem),
-						passphrase, is_encrypted);
+						passphrase, out_is_encrypted);
 }
 =

 int eap_tls_common_settings_check(struct l_settings *settings,
diff --git a/src/eap-tls-common.h b/src/eap-tls-common.h
index 81c84c3e..174770c0 100644
--- a/src/eap-tls-common.h
+++ b/src/eap-tls-common.h
@@ -49,10 +49,13 @@ void eap_tls_common_handle_retransmit(struct eap_state =
*eap,
 						const uint8_t *pkt, size_t len);
 =

 struct l_certchain *eap_tls_load_client_cert(struct l_settings *settings,
-						const char *value);
+						const char *value,
+						const char *passphrase,
+						bool *out_is_encrypted);
 struct l_key *eap_tls_load_priv_key(struct l_settings *settings,
-				const char *value, const char *passphrase,
-				bool *is_encrypted);
+					const char *value,
+					const char *passphrase,
+					bool *out_is_encrypted);
 =

 int eap_tls_common_settings_check(struct l_settings *settings,
 						struct l_queue *secrets,
diff --git a/src/eap-tls.c b/src/eap-tls.c
index 88e79147..ac7650dc 100644
--- a/src/eap-tls.c
+++ b/src/eap-tls.c
@@ -123,13 +123,15 @@ static int eap_tls_settings_check(struct l_settings *=
settings,
 	char passphrase_setting[72];
 	char client_cert_setting[72];
 	char priv_key_setting[72];
+	char bundle_setting[72];
 	L_AUTO_FREE_VAR(char *, passphrase) =3D NULL;
 	L_AUTO_FREE_VAR(char *, client_cert_value) =3D NULL;
 	L_AUTO_FREE_VAR(char *, priv_key_value) =3D NULL;
+	L_AUTO_FREE_VAR(char *, bundle_value) =3D NULL;
 	struct l_certchain *client_cert =3D NULL;
 	struct l_key *priv_key =3D NULL;
 	const char *error_str;
-	bool is_encrypted;
+	bool priv_key_encrypted, cert_encrypted;
 	int ret;
 =

 	snprintf(tls_prefix, sizeof(tls_prefix), "%sTLS-", prefix);
@@ -149,6 +151,11 @@ static int eap_tls_settings_check(struct l_settings *s=
ettings,
 	priv_key_value =3D l_settings_get_string(settings, "Security",
 						priv_key_setting);
 =

+	snprintf(bundle_setting, sizeof(bundle_setting),
+			"%sClientKeyBundle", tls_prefix);
+	bundle_value =3D l_settings_get_string(settings, "Security",
+						bundle_setting);
+
 	snprintf(passphrase_setting, sizeof(passphrase_setting),
 			"%sClientKeyPassphrase", tls_prefix);
 	passphrase =3D l_settings_get_string(settings, "Security",
@@ -167,7 +174,12 @@ static int eap_tls_settings_check(struct l_settings *s=
ettings,
 	 * Check whether the combination of settings that are present/missing
 	 * makes sense before validating each setting.
 	 */
-	if (priv_key_value && !client_cert_value) {
+	if (bundle_value && (priv_key_value || client_cert)) {
+		l_error("Either %s or %s/%s can be used, not both",
+			bundle_setting, priv_key_setting, client_cert_setting);
+		ret =3D -EEXIST;
+		goto done;
+	} else if (priv_key_value && !client_cert_value) {
 		l_error("%s present but no client certificate (%s)",
 			priv_key_setting, client_cert_setting);
 		ret =3D -ENOENT;
@@ -179,9 +191,9 @@ static int eap_tls_settings_check(struct l_settings *se=
ttings,
 		goto done;
 	}
 =

-	if (!priv_key_value) {
+	if (!priv_key_value && !bundle_value) {
 		if (passphrase) {
-			l_error("%s present but no client private key set (%s)",
+			l_error("%s present but no client keys set (%s)",
 				passphrase_setting, priv_key_setting);
 			ret =3D -ENOENT;
 			goto done;
@@ -191,30 +203,77 @@ static int eap_tls_settings_check(struct l_settings *=
settings,
 		goto done;
 	}
 =

-	client_cert =3D eap_tls_load_client_cert(settings, client_cert_value);
-	if (!client_cert) {
-		l_error("Failed to load %s", client_cert_value);
-		ret =3D -EIO;
+	if (bundle_value &&
+			(!l_cert_load_container_file(bundle_value, passphrase,
+							&client_cert, &priv_key,
+							&priv_key_encrypted) ||
+			 !client_cert || !priv_key)) {
+		if (client_cert) {
+			l_error("No private key loaded from %s", bundle_value);
+			ret =3D -ENOKEY;
+			goto done;
+		} else if (priv_key) {
+			l_error("No certificates loaded from %s", bundle_value);
+			ret =3D -ENOKEY;
+			goto done;
+		} else if (!priv_key_encrypted) {
+			l_error("Error loading %s", bundle_value);
+			ret =3D -EIO;
+			goto done;
+		} else if (passphrase) {
+			l_error("Error loading key pair from encrypted file %s",
+				bundle_value);
+			ret =3D -EACCES;
+			goto done;
+		}
+
+		/*
+		 * We've got an encrypted file and passphrase was not saved
+		 * in the network settings, need to request the passphrase.
+		 */
+		eap_append_secret(out_missing,
+					EAP_SECRET_LOCAL_PKEY_PASSPHRASE,
+					passphrase_setting, NULL,
+					bundle_value, EAP_CACHE_TEMPORARY);
+		ret =3D 0;
 		goto done;
 	}
 =

-	/*
-	 * Sanity check that certchain provided is valid.  We do not verify
-	 * the certchain against the provided CA since the CA that issued
-	 * user certificates might be different from the one that is used
-	 * to verify the peer.
-	 */
-	if (!l_certchain_verify(client_cert, NULL, &error_str)) {
-		l_error("Certificate chain %s fails verification: %s",
-			client_cert_value, error_str);
-		ret =3D -EINVAL;
+	if (bundle_value)
+		goto validate_keys;
+
+	client_cert =3D eap_tls_load_client_cert(settings, client_cert_value,
+						passphrase, &cert_encrypted);
+	if (!client_cert) {
+		if (!cert_encrypted) {
+			l_error("Failed to load %s", client_cert_value);
+			ret =3D -EIO;
+			goto done;
+		}
+
+		if (passphrase) {
+			l_error("Error loading certificate from encrypted "
+				"file %s", client_cert_value);
+			ret =3D -EACCES;
+			goto done;
+		}
+
+		/*
+		 * We've got an encrypted file and passphrase was not saved
+		 * in the network settings, need to request the passphrase.
+		 */
+		eap_append_secret(out_missing,
+					EAP_SECRET_LOCAL_PKEY_PASSPHRASE,
+					passphrase_setting, NULL,
+					client_cert_value, EAP_CACHE_TEMPORARY);
+		ret =3D 0;
 		goto done;
 	}
 =

 	priv_key =3D eap_tls_load_priv_key(settings, priv_key_value, passphrase,
-						&is_encrypted);
+						&priv_key_encrypted);
 	if (!priv_key) {
-		if (!is_encrypted) {
+		if (!priv_key_encrypted) {
 			l_error("Error loading client private key %s",
 				priv_key_value);
 			ret =3D -EIO;
@@ -240,13 +299,27 @@ static int eap_tls_settings_check(struct l_settings *=
settings,
 		goto done;
 	}
 =

-	if (passphrase && !is_encrypted) {
-		l_error("%s present but client private key %s is not encrypted",
-			passphrase_setting, priv_key_value);
+validate_keys:
+	if (passphrase && !priv_key_encrypted && !cert_encrypted) {
+		l_error("%s present but keys are not encrypted",
+			passphrase_setting);
 		ret =3D -ENOENT;
 		goto done;
 	}
 =

+	/*
+	 * Sanity check that certchain provided is valid.  We do not verify
+	 * the certchain against the provided CA since the CA that issued
+	 * user certificates might be different from the one that is used
+	 * to verify the peer.
+	 */
+	if (!l_certchain_verify(client_cert, NULL, &error_str)) {
+		l_error("Certificate chain %s fails verification: %s",
+			client_cert_value, error_str);
+		ret =3D -EINVAL;
+		goto done;
+	}
+
 	ret =3D eap_tls_check_keys_match(priv_key,
 					l_certchain_get_leaf(client_cert),
 					priv_key_value, client_cert_value);
@@ -290,7 +363,8 @@ static bool eap_tls_settings_load(struct eap_state *eap,
 	snprintf(setting_key, sizeof(setting_key), "%sClientCert", tls_prefix);
 	value =3D l_settings_get_string(settings, "Security", setting_key);
 	if (value) {
-		client_cert =3D eap_tls_load_client_cert(settings, value);
+		client_cert =3D eap_tls_load_client_cert(settings, value,
+							passphrase, NULL);
 		if (!client_cert)
 			goto load_error;
 	}
@@ -306,6 +380,21 @@ static bool eap_tls_settings_load(struct eap_state *ea=
p,
 			goto load_error;
 	}
 =

+	l_free(value);
+
+	snprintf(setting_key, sizeof(setting_key), "%sClientKeyBundle",
+			tls_prefix);
+	value =3D l_settings_get_string(settings, "Security", setting_key);
+	if (value && !client_cert && !client_key &&
+			(!l_cert_load_container_file(value, passphrase,
+							&client_cert,
+							&client_key, NULL) ||
+			 !client_cert || !client_key)) {
+		l_certchain_free(client_cert);
+		l_key_free(client_key);
+		goto load_error;
+	}
+
 	eap_tls_common_set_keys(eap, client_cert, client_key);
 	return true;
 =

-- =

2.27.0

--===============7941118305144946149==--

