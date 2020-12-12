Content-Type: multipart/mixed; boundary="===============5116793811869800003=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/2] eap-tls: Make use of l_pem_load_container_file()
Date: Sat, 12 Dec 2020 02:09:53 +0100
Message-ID: <20201212010954.583418-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5116793811869800003==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows .p12 files and other formats to be used.  When a single file
contains both the client certificates and the private key, it can be
given as either EAP-{TLS,PEAP,TTLS}-ClientCert or -ClientKey.  Also both
settings can point to the same or different files and only the
certificates will be loaded from one and only the key from the other (if
different).
---
 src/eap-tls-common.c | 302 +++++++++++++++++++++++++------------------
 1 file changed, 178 insertions(+), 124 deletions(-)

diff --git a/src/eap-tls-common.c b/src/eap-tls-common.c
index c3eb5ab3..aa43e5a3 100644
--- a/src/eap-tls-common.c
+++ b/src/eap-tls-common.c
@@ -864,31 +864,25 @@ static struct l_queue *eap_tls_load_ca_cert(struct l_=
settings *settings,
 	return l_pem_load_certificate_list_from_data(pem, strlen(pem));
 }
 =

-static struct l_certchain *eap_tls_load_client_cert(struct l_settings *set=
tings,
-							const char *value)
+static struct l_certchain *eap_tls_load_embedded_cert(
+						struct l_settings *settings,
+						const char *value)
 {
-	const char *pem;
-
-	if (!is_embedded(value))
-		return l_pem_load_certificate_chain(value);
+	const char *pem =3D load_embedded_pem(settings, value);
 =

-	pem =3D load_embedded_pem(settings, value);
 	if (!pem)
 		return NULL;
 =

 	return l_pem_load_certificate_chain_from_data(pem, strlen(pem));
 }
 =

-static struct l_key *eap_tls_load_priv_key(struct l_settings *settings,
-				const char *value, const char *passphrase,
-				bool *is_encrypted)
+static struct l_key *eap_tls_load_embedded_priv_key(struct l_settings *set=
tings,
+							const char *value,
+							const char *passphrase,
+							bool *is_encrypted)
 {
-	const char *pem;
+	const char *pem =3D load_embedded_pem(settings, value);
 =

-	if (!is_embedded(value))
-		return l_pem_load_private_key(value, passphrase, is_encrypted);
-
-	pem =3D load_embedded_pem(settings, value);
 	if (!pem)
 		return NULL;
 =

@@ -903,11 +897,14 @@ int eap_tls_common_settings_check(struct l_settings *=
settings,
 {
 	char setting_key[72];
 	char client_cert_setting[72];
+	char client_key_setting[72];
 	char passphrase_setting[72];
 	struct l_queue *cacerts =3D NULL;
 	struct l_certchain *cert =3D NULL;
 	struct l_key *priv_key =3D NULL;
-	bool is_encrypted, is_public;
+	bool is_public;
+	bool cert_is_encrypted;
+	bool key_is_encrypted;
 	int ret;
 	const char *error_str;
 	size_t size;
@@ -916,17 +913,32 @@ int eap_tls_common_settings_check(struct l_settings *=
settings,
 	struct l_key *pub_key;
 	const char *domain_mask_str;
 =

-	L_AUTO_FREE_VAR(char *, value);
+	L_AUTO_FREE_VAR(char *, ca_cert);
 	L_AUTO_FREE_VAR(char *, client_cert) =3D NULL;
+	L_AUTO_FREE_VAR(char *, client_key) =3D NULL;
 	L_AUTO_FREE_VAR(char *, passphrase) =3D NULL;
 =

+	snprintf(passphrase_setting, sizeof(passphrase_setting),
+					"%sClientKeyPassphrase", prefix);
+	passphrase =3D l_settings_get_string(settings, "Security",
+							passphrase_setting);
+
+	if (!passphrase) {
+		const struct eap_secret_info *secret;
+
+		secret =3D l_queue_find(secrets, eap_secret_info_match,
+							passphrase_setting);
+		if (secret)
+			passphrase =3D l_strdup(secret->value);
+	}
+
 	snprintf(setting_key, sizeof(setting_key), "%sCACert", prefix);
-	value =3D l_settings_get_string(settings, "Security", setting_key);
-	if (value) {
-		cacerts =3D eap_tls_load_ca_cert(settings, value);
+	ca_cert =3D l_settings_get_string(settings, "Security", setting_key);
+	if (ca_cert) {
+		cacerts =3D eap_tls_load_ca_cert(settings, ca_cert);
 =

 		if (!cacerts) {
-			l_error("Failed to load %s", value);
+			l_error("Failed to load %s", ca_cert);
 			return -EIO;
 		}
 	}
@@ -935,113 +947,146 @@ int eap_tls_common_settings_check(struct l_settings=
 *settings,
 							"%sClientCert", prefix);
 	client_cert =3D l_settings_get_string(settings, "Security",
 							client_cert_setting);
-	if (client_cert) {
-		cert =3D eap_tls_load_client_cert(settings, client_cert);
-
-		if (!cert) {
-			l_error("Failed to load %s", client_cert);
-			ret =3D -EIO;
-			goto done;
-		}
 =

-		/*
-		 * Sanity check that certchain provided is valid.  We do not
-		 * verify the certchain against the provided CA, since the
-		 * CA that issued user certificates might be different from
-		 * the one that is used to verify the peer
-		 */
-		if (!l_certchain_verify(cert, NULL, &error_str)) {
-			l_error("Certificate chain %s fails verification: %s",
-				client_cert, error_str);
-			ret =3D -EINVAL;
-			goto done;
-		}
-	}
+	snprintf(client_key_setting, sizeof(client_key_setting),
+							"%sClientKey", prefix);
+	client_key =3D l_settings_get_string(settings, "Security",
+							client_key_setting);
 =

-	l_free(value);
-
-	snprintf(setting_key, sizeof(setting_key), "%sClientKey", prefix);
-	value =3D l_settings_get_string(settings, "Security", setting_key);
+	/*
+	 * If ClientCert and ClientKey are both provided, try to load only the
+	 * certificate chain from the former and only the private key from the
+	 * latter.  If only one is present and is a file path, take whatever
+	 * the file contains.
+	 */
 =

-	if (value && !client_cert) {
-		l_error("%s present but no client certificate (%s)",
-					setting_key, client_cert_setting);
-		ret =3D -ENOENT;
-		goto done;
-	} else if (!value && client_cert) {
-		l_error("%s present but no client private key (%s)",
-					client_cert_setting, setting_key);
-		ret =3D -ENOENT;
-		goto done;
+	if (client_cert && is_embedded(client_cert)) {
+		cert =3D eap_tls_load_embedded_cert(settings, client_cert);
+		cert_is_encrypted =3D false;
+	} else if (client_cert) {
+		l_pem_load_container_file(client_cert, passphrase,
+						&cert,
+						client_key ? NULL : &priv_key,
+						&cert_is_encrypted);
 	}
 =

-	snprintf(passphrase_setting, sizeof(passphrase_setting),
-					"%sClientKeyPassphrase", prefix);
-	passphrase =3D l_settings_get_string(settings, "Security",
-							passphrase_setting);
+	if (client_key && is_embedded(client_key))
+		priv_key =3D eap_tls_load_embedded_priv_key(settings, client_key,
+							passphrase,
+							&key_is_encrypted);
+	else if (client_key) {
+		l_pem_load_container_file(client_key, passphrase,
+						client_cert ? NULL : &cert,
+						&priv_key,
+						&key_is_encrypted);
+	}
 =

-	if (!passphrase) {
-		const struct eap_secret_info *secret;
+	/* Analyze all possible error condition */
 =

-		secret =3D l_queue_find(secrets, eap_secret_info_match,
-							passphrase_setting);
-		if (secret)
-			passphrase =3D l_strdup(secret->value);
-	}
+	if (client_cert && !cert) {
+		if (!cert_is_encrypted) {
+			l_error("Failed to load %s", client_cert);
+			ret =3D -EIO;
+			goto done;
+		}
 =

-	if (!value) {
 		if (passphrase) {
-			l_error("%s present but no client private key"
-				" value set (%s)", passphrase_setting,
-				setting_key);
-			ret =3D -ENOENT;
+			l_error("Error loading encrypted contents from %s",
+				client_cert);
+			ret =3D -EACCES;
 			goto done;
 		}
 =

+		/*
+		 * We've got an encrypted file and passphrase was not saved
+		 * in the network settings, need to request the passphrase.
+		 */
+		eap_append_secret(out_missing,
+					EAP_SECRET_LOCAL_PKEY_PASSPHRASE,
+					passphrase_setting, NULL, client_cert,
+					EAP_CACHE_TEMPORARY);
 		ret =3D 0;
 		goto done;
 	}
 =

-	priv_key =3D eap_tls_load_priv_key(settings, value, passphrase,
-						&is_encrypted);
-
-	if (!priv_key) {
-		if (!is_encrypted) {
-			l_error("Error loading client private key %s", value);
+	if (client_key && !priv_key) {
+		if (!key_is_encrypted) {
+			l_error("Failed to load %s", client_key);
 			ret =3D -EIO;
 			goto done;
 		}
 =

 		if (passphrase) {
-			l_error("Error loading encrypted client private key %s",
-				value);
+			l_error("Error loading encrypted contents from %s",
+				client_key);
 			ret =3D -EACCES;
 			goto done;
 		}
 =

 		/*
-		 * We've got an encrypted key and passphrase was not saved
+		 * We've got an encrypted file and passphrase was not saved
 		 * in the network settings, need to request the passphrase.
 		 */
 		eap_append_secret(out_missing,
 					EAP_SECRET_LOCAL_PKEY_PASSPHRASE,
-					passphrase_setting, NULL, value,
+					passphrase_setting, NULL, client_key,
 					EAP_CACHE_TEMPORARY);
 		ret =3D 0;
 		goto done;
 	}
 =

-	if (passphrase && !is_encrypted) {
-		l_error("%s present but client private key %s is not encrypted",
-			passphrase_setting, value);
+	/* We now know that the provided certificate and key (if any) load */
+
+	if (cert && !priv_key) {
+		/* priv_key is NULL so ClientKey must have been unset */
+		l_error("A client certificate was loaded (%s) but no client "
+			"private key found, please set %s",
+			client_cert, client_key_setting);
+		ret =3D -ENOENT;
+		goto done;
+	} else if (!cert && priv_key) {
+		/* cert is NULL so ClientCert must have been unset */
+		l_error("A client private key was loaded (%s) but no client "
+			"certificate found, please set %s",
+			client_key, client_cert_setting);
+		ret =3D -ENOENT;
+		goto done;
+	} else if (!priv_key && passphrase) {
+		l_error("%s was set but no client private key (%s)",
+			passphrase_setting, client_key_setting);
+		ret =3D -ENOENT;
+		goto done;
+	} else if (!cert_is_encrypted && !key_is_encrypted && passphrase) {
+		l_error("%s was set but client %sprivate key file (%s) is "
+			"not encrypted", passphrase_setting,
+			(!client_key || !client_cert) ? "certificate and " : "",
+			client_key ?: client_cert);
 		ret =3D -ENOENT;
 		goto done;
 	}
 =

+	if (!cert) {
+		ret =3D 0;
+		goto done;
+	}
+
+	/*
+	 * Sanity check that provided certchain is valid.  We do not verify
+	 * the certchain against the provided CA, since the CA that issued
+	 * user certificates might be different from the one that is used
+	 * to verify the peer.
+	 */
+	if (!l_certchain_verify(cert, NULL, &error_str)) {
+		l_error("The certificate chain in %s fails verification: %s",
+			client_cert ?: client_key, error_str);
+		ret =3D -EINVAL;
+		goto done;
+	}
+
 	if (!l_key_get_info(priv_key, L_KEY_RSA_PKCS1_V1_5, L_CHECKSUM_NONE,
 				&size, &is_public) || is_public) {
-		l_error("%s is not a private key or l_key_get_info fails",
-			value);
+		l_error("The key in %s is not a private key or l_key_get_info "
+			"fails", client_key ?: client_cert);
 		ret =3D -EINVAL;
 		goto done;
 	}
@@ -1052,7 +1097,8 @@ int eap_tls_common_settings_check(struct l_settings *=
settings,
 =

 	pub_key =3D l_cert_get_pubkey(l_certchain_get_leaf(cert));
 	if (!pub_key) {
-		l_error("l_cert_get_pubkey fails for %s", client_cert);
+		l_error("l_cert_get_pubkey fails for the certificate in %s",
+			client_cert ?: client_key);
 		ret =3D -EIO;
 		goto done;
 	}
@@ -1062,7 +1108,8 @@ int eap_tls_common_settings_check(struct l_settings *=
settings,
 	l_key_free(pub_key);
 =

 	if (result !=3D (ssize_t) size) {
-		l_error("l_key_encrypt fails with %s: %s", client_cert,
+		l_error("l_key_encrypt fails with the public key in the "
+			"certificate in %s: %s", client_cert ?: client_key,
 			strerror(-result));
 		ret =3D result;
 		goto done;
@@ -1071,15 +1118,16 @@ int eap_tls_common_settings_check(struct l_settings=
 *settings,
 	result =3D l_key_decrypt(priv_key, L_KEY_RSA_PKCS1_V1_5, L_CHECKSUM_NONE,
 				encrypted, decrypted, size, size);
 	if (result < 0) {
-		l_error("l_key_decrypt fails with %s: %s", value,
-			strerror(-result));
+		l_error("l_key_decrypt fails with the private key in %s: %s",
+			client_key ?: client_cert, strerror(-result));
 		ret =3D result;
 		goto done;
 	}
 =

 	if (result !=3D 1 || decrypted[0] !=3D 0) {
-		l_error("Private key %s does not match certificate %s", value,
-			client_cert);
+		l_error("The private key in %s does not match certificate in "
+			"%s", client_key ?: client_cert,
+			client_cert ?: client_key);
 		ret =3D -EINVAL;
 		goto done;
 	}
@@ -1121,7 +1169,9 @@ bool eap_tls_common_settings_load(struct eap_state *e=
ap,
 	struct eap_tls_state *eap_tls;
 	char setting_key[72];
 	char *domain_mask_str;
-	L_AUTO_FREE_VAR(char *, value) =3D NULL;
+	L_AUTO_FREE_VAR(char *, ca_cert) =3D NULL;
+	L_AUTO_FREE_VAR(char *, client_cert) =3D NULL;
+	L_AUTO_FREE_VAR(char *, client_key) =3D NULL;
 	L_AUTO_FREE_VAR(char *, passphrase) =3D NULL;
 =

 	eap_tls =3D l_new(struct eap_tls_state, 1);
@@ -1130,47 +1180,51 @@ bool eap_tls_common_settings_load(struct eap_state =
*eap,
 	eap_tls->variant_ops =3D variant_ops;
 	eap_tls->variant_data =3D variant_data;
 =

+	snprintf(setting_key, sizeof(setting_key), "%sClientKeyPassphrase",
+									prefix);
+	passphrase =3D l_settings_get_string(settings, "Security", setting_key);
+
 	snprintf(setting_key, sizeof(setting_key), "%sCACert", prefix);
-	value =3D l_settings_get_string(settings, "Security", setting_key);
-	if (value) {
-		eap_tls->ca_cert =3D eap_tls_load_ca_cert(settings, value);
-		if (!eap_tls->ca_cert) {
-			l_error("Could not load CACert %s", value);
+	ca_cert =3D l_settings_get_string(settings, "Security", setting_key);
+	if (ca_cert) {
+		eap_tls->ca_cert =3D eap_tls_load_ca_cert(settings, ca_cert);
+		if (!eap_tls->ca_cert)
 			goto load_error;
-		}
 	}
 =

-	l_free(value);
-
 	snprintf(setting_key, sizeof(setting_key), "%sClientCert", prefix);
-	value =3D l_settings_get_string(settings, "Security", setting_key);
-	if (value) {
-		eap_tls->client_cert =3D eap_tls_load_client_cert(settings,
-								value);
-		if (!eap_tls->client_cert) {
-			l_error("Could not load ClientCert %s", value);
-			goto load_error;
-		}
-	}
-
-	l_free(value);
-
-	snprintf(setting_key, sizeof(setting_key), "%sClientKeyPassphrase",
-									prefix);
-	passphrase =3D l_settings_get_string(settings, "Security", setting_key);
+	client_cert =3D l_settings_get_string(settings, "Security", setting_key);
 =

 	snprintf(setting_key, sizeof(setting_key), "%sClientKey", prefix);
-	value =3D l_settings_get_string(settings, "Security", setting_key);
-	if (value) {
-		eap_tls->client_key =3D eap_tls_load_priv_key(settings, value,
+	client_key =3D l_settings_get_string(settings, "Security", setting_key);
+
+	if (client_cert && is_embedded(client_cert))
+		eap_tls->client_cert =3D eap_tls_load_embedded_cert(settings,
+								client_cert);
+	else if (client_cert) {
+		l_pem_load_container_file(client_cert, passphrase,
+						&eap_tls->client_cert,
+						client_key ? NULL :
+						&eap_tls->client_key, NULL);
+	}
+
+	if (client_key && is_embedded(client_key))
+		eap_tls->client_key =3D eap_tls_load_embedded_priv_key(settings,
+								client_key,
 								passphrase,
 								NULL);
-		if (!eap_tls->client_key) {
-			l_error("Could not load ClientKey %s", value);
-			goto load_error;
-		}
+	else if (client_key) {
+		l_pem_load_container_file(client_key, passphrase,
+						client_cert ? NULL :
+						&eap_tls->client_cert,
+						&eap_tls->client_key, NULL);
 	}
 =

+	if ((client_cert && !eap_tls->client_cert) ||
+			(client_key && !eap_tls->client_key) ||
+			!eap_tls->client_cert !=3D !eap_tls->client_key)
+		goto load_error;
+
 	snprintf(setting_key, sizeof(setting_key), "%sServerDomainMask",
 								prefix);
 	domain_mask_str =3D l_settings_get_string(settings, "Security",
-- =

2.27.0

--===============5116793811869800003==--

