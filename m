Content-Type: multipart/mixed; boundary="===============5785324732922275698=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/7] eap-tls: Drop EAP-{TTLS,PEAP}-Client{Cert,Key}
Date: Mon, 25 Jan 2021 18:56:11 +0100
Message-ID: <20210125175617.2417412-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5785324732922275698==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As requested move the client certificate and private key loading from
eap-tls-common.c to eap-tls.c.  No man page change needed because those
two settings weren't documented in it in the first place.
---
 src/eap-tls-common.c | 239 ++++---------------------------------------
 src/eap-tls-common.h |   9 ++
 src/eap-tls.c        | 237 ++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 260 insertions(+), 225 deletions(-)

diff --git a/src/eap-tls-common.c b/src/eap-tls-common.c
index 68e2a10c..164115d8 100644
--- a/src/eap-tls-common.c
+++ b/src/eap-tls-common.c
@@ -867,8 +867,8 @@ static struct l_queue *eap_tls_load_ca_cert(struct l_se=
ttings *settings,
 	return l_pem_load_certificate_list_from_data(pem, strlen(pem));
 }
 =

-static struct l_certchain *eap_tls_load_client_cert(struct l_settings *set=
tings,
-							const char *value)
+struct l_certchain *eap_tls_load_client_cert(struct l_settings *settings,
+						const char *value)
 {
 	const char *pem;
 =

@@ -882,7 +882,7 @@ static struct l_certchain *eap_tls_load_client_cert(str=
uct l_settings *settings,
 	return l_pem_load_certificate_chain_from_data(pem, strlen(pem));
 }
 =

-static struct l_key *eap_tls_load_priv_key(struct l_settings *settings,
+struct l_key *eap_tls_load_priv_key(struct l_settings *settings,
 				const char *value, const char *passphrase,
 				bool *is_encrypted)
 {
@@ -905,186 +905,23 @@ int eap_tls_common_settings_check(struct l_settings =
*settings,
 					struct l_queue **out_missing)
 {
 	char setting_key[72];
-	char client_cert_setting[72];
-	char passphrase_setting[72];
-	struct l_queue *cacerts =3D NULL;
-	struct l_certchain *cert =3D NULL;
-	struct l_key *priv_key =3D NULL;
-	bool is_encrypted, is_public;
-	int ret;
-	const char *error_str;
-	size_t size;
-	ssize_t result;
-	uint8_t *encrypted, *decrypted;
-	struct l_key *pub_key;
+	bool have_cacerts =3D false;
 	const char *domain_mask_str;
-
 	L_AUTO_FREE_VAR(char *, value);
-	L_AUTO_FREE_VAR(char *, client_cert) =3D NULL;
-	L_AUTO_FREE_VAR(char *, passphrase) =3D NULL;
 =

 	snprintf(setting_key, sizeof(setting_key), "%sCACert", prefix);
 	value =3D l_settings_get_string(settings, "Security", setting_key);
 	if (value) {
-		cacerts =3D eap_tls_load_ca_cert(settings, value);
+		struct l_queue *cacerts =3D eap_tls_load_ca_cert(settings, value);
 =

 		if (!cacerts) {
 			l_error("Failed to load %s", value);
 			return -EIO;
 		}
-	}
-
-	snprintf(client_cert_setting, sizeof(client_cert_setting),
-							"%sClientCert", prefix);
-	client_cert =3D l_settings_get_string(settings, "Security",
-							client_cert_setting);
-	if (client_cert) {
-		cert =3D eap_tls_load_client_cert(settings, client_cert);
-
-		if (!cert) {
-			l_error("Failed to load %s", client_cert);
-			ret =3D -EIO;
-			goto done;
-		}
-
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
-
-	l_free(value);
 =

-	snprintf(setting_key, sizeof(setting_key), "%sClientKey", prefix);
-	value =3D l_settings_get_string(settings, "Security", setting_key);
-
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
-	}
-
-	snprintf(passphrase_setting, sizeof(passphrase_setting),
-					"%sClientKeyPassphrase", prefix);
-	passphrase =3D l_settings_get_string(settings, "Security",
-							passphrase_setting);
-
-	if (!passphrase) {
-		const struct eap_secret_info *secret;
-
-		secret =3D l_queue_find(secrets, eap_secret_info_match,
-							passphrase_setting);
-		if (secret)
-			passphrase =3D l_strdup(secret->value);
-	}
-
-	if (!value) {
-		if (passphrase) {
-			l_error("%s present but no client private key"
-				" value set (%s)", passphrase_setting,
-				setting_key);
-			ret =3D -ENOENT;
-			goto done;
-		}
-
-		ret =3D 0;
-		goto done;
-	}
-
-	priv_key =3D eap_tls_load_priv_key(settings, value, passphrase,
-						&is_encrypted);
-
-	if (!priv_key) {
-		if (!is_encrypted) {
-			l_error("Error loading client private key %s", value);
-			ret =3D -EIO;
-			goto done;
-		}
-
-		if (passphrase) {
-			l_error("Error loading encrypted client private key %s",
-				value);
-			ret =3D -EACCES;
-			goto done;
-		}
-
-		/*
-		 * We've got an encrypted key and passphrase was not saved
-		 * in the network settings, need to request the passphrase.
-		 */
-		eap_append_secret(out_missing,
-					EAP_SECRET_LOCAL_PKEY_PASSPHRASE,
-					passphrase_setting, NULL, value,
-					EAP_CACHE_TEMPORARY);
-		ret =3D 0;
-		goto done;
-	}
-
-	if (passphrase && !is_encrypted) {
-		l_error("%s present but client private key %s is not encrypted",
-			passphrase_setting, value);
-		ret =3D -ENOENT;
-		goto done;
-	}
-
-	if (!l_key_get_info(priv_key, L_KEY_RSA_PKCS1_V1_5, L_CHECKSUM_NONE,
-				&size, &is_public) || is_public) {
-		l_error("%s is not a private key or l_key_get_info fails",
-			value);
-		ret =3D -EINVAL;
-		goto done;
-	}
-
-	size /=3D 8;
-	encrypted =3D alloca(size);
-	decrypted =3D alloca(size);
-
-	pub_key =3D l_cert_get_pubkey(l_certchain_get_leaf(cert));
-	if (!pub_key) {
-		l_error("l_cert_get_pubkey fails for %s", client_cert);
-		ret =3D -EIO;
-		goto done;
-	}
-
-	result =3D l_key_encrypt(pub_key, L_KEY_RSA_PKCS1_V1_5, L_CHECKSUM_NONE,
-				"", encrypted, 1, size);
-	l_key_free(pub_key);
-
-	if (result !=3D (ssize_t) size) {
-		l_error("l_key_encrypt fails with %s: %s", client_cert,
-			strerror(-result));
-		ret =3D result;
-		goto done;
-	}
-
-	result =3D l_key_decrypt(priv_key, L_KEY_RSA_PKCS1_V1_5, L_CHECKSUM_NONE,
-				encrypted, decrypted, size, size);
-	if (result < 0) {
-		l_error("l_key_decrypt fails with %s: %s", value,
-			strerror(-result));
-		ret =3D result;
-		goto done;
-	}
-
-	if (result !=3D 1 || decrypted[0] !=3D 0) {
-		l_error("Private key %s does not match certificate %s", value,
-			client_cert);
-		ret =3D -EINVAL;
-		goto done;
+		l_queue_destroy(cacerts,
+				(l_queue_destroy_func_t) l_cert_free);
+		have_cacerts =3D true;
 	}
 =

 	/*
@@ -1097,23 +934,12 @@ int eap_tls_common_settings_check(struct l_settings =
*settings,
 			prefix);
 	domain_mask_str =3D l_settings_get_value(settings, "Security",
 						setting_key);
-	if (domain_mask_str && !cacerts) {
+	if (domain_mask_str && !have_cacerts) {
 		l_error("%s was set but no CA Certificates given", setting_key);
-		ret =3D -EINVAL;
-		goto done;
+		return -EINVAL;
 	}
 =

-	ret =3D 0;
-done:
-	l_queue_destroy(cacerts,
-			(l_queue_destroy_func_t) l_cert_free);
-	l_certchain_free(cert);
-	l_key_free(priv_key);
-
-	if (passphrase)
-		explicit_bzero(passphrase, strlen(passphrase));
-
-	return ret;
+	return 0;
 }
 =

 bool eap_tls_common_settings_load(struct eap_state *eap,
@@ -1124,8 +950,8 @@ bool eap_tls_common_settings_load(struct eap_state *ea=
p,
 	struct eap_tls_state *eap_tls;
 	char setting_key[72];
 	char *domain_mask_str;
+
 	L_AUTO_FREE_VAR(char *, value) =3D NULL;
-	L_AUTO_FREE_VAR(char *, passphrase) =3D NULL;
 =

 	eap_tls =3D l_new(struct eap_tls_state, 1);
 =

@@ -1143,37 +969,6 @@ bool eap_tls_common_settings_load(struct eap_state *e=
ap,
 		}
 	}
 =

-	l_free(value);
-
-	snprintf(setting_key, sizeof(setting_key), "%sClientCert", prefix);
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
-
-	snprintf(setting_key, sizeof(setting_key), "%sClientKey", prefix);
-	value =3D l_settings_get_string(settings, "Security", setting_key);
-	if (value) {
-		eap_tls->client_key =3D eap_tls_load_priv_key(settings, value,
-								passphrase,
-								NULL);
-		if (!eap_tls->client_key) {
-			l_error("Could not load ClientKey %s", value);
-			goto load_error;
-		}
-	}
-
 	snprintf(setting_key, sizeof(setting_key), "%sServerDomainMask",
 								prefix);
 	domain_mask_str =3D l_settings_get_string(settings, "Security",
@@ -1194,6 +989,16 @@ load_error:
 	return false;
 }
 =

+void eap_tls_common_set_keys(struct eap_state *eap,
+				struct l_certchain *client_cert,
+				struct l_key *client_key)
+{
+	struct eap_tls_state *eap_tls =3D eap_get_data(eap);
+
+	eap_tls->client_cert =3D client_cert;
+	eap_tls->client_key =3D client_key;
+}
+
 void eap_tls_common_set_completed(struct eap_state *eap)
 {
 	struct eap_tls_state *eap_tls =3D eap_get_data(eap);
diff --git a/src/eap-tls-common.h b/src/eap-tls-common.h
index 88cac244..81c84c3e 100644
--- a/src/eap-tls-common.h
+++ b/src/eap-tls-common.h
@@ -48,6 +48,12 @@ void eap_tls_common_handle_request(struct eap_state *eap,
 void eap_tls_common_handle_retransmit(struct eap_state *eap,
 						const uint8_t *pkt, size_t len);
 =

+struct l_certchain *eap_tls_load_client_cert(struct l_settings *settings,
+						const char *value);
+struct l_key *eap_tls_load_priv_key(struct l_settings *settings,
+				const char *value, const char *passphrase,
+				bool *is_encrypted);
+
 int eap_tls_common_settings_check(struct l_settings *settings,
 						struct l_queue *secrets,
 						const char *prefix,
@@ -56,6 +62,9 @@ bool eap_tls_common_settings_load(struct eap_state *eap,
 				struct l_settings *settings, const char *prefix,
 				const struct eap_tls_variant_ops *variant_ops,
 				void *variant_data);
+void eap_tls_common_set_keys(struct eap_state *eap,
+				struct l_certchain *client_cert,
+				struct l_key *client_key);
 =

 void eap_tls_common_send_empty_response(struct eap_state *eap);
 enum eap_tls_version eap_tls_common_get_negotiated_version(
diff --git a/src/eap-tls.c b/src/eap-tls.c
index 136f5943..88e79147 100644
--- a/src/eap-tls.c
+++ b/src/eap-tls.c
@@ -60,17 +60,205 @@ static bool eap_tls_tunnel_ready(struct eap_state *eap,
 	return true;
 }
 =

+static int eap_tls_check_keys_match(struct l_key *priv_key, struct l_cert =
*cert,
+					const char *key_name,
+					const char *cert_name)
+{
+	bool is_public;
+	size_t size;
+	ssize_t result;
+	uint8_t *encrypted, *decrypted;
+	struct l_key *pub_key;
+
+	if (!l_key_get_info(priv_key, L_KEY_RSA_PKCS1_V1_5, L_CHECKSUM_NONE,
+				&size, &is_public) || is_public) {
+		l_error("%s is not a private key or l_key_get_info fails",
+			key_name);
+		return -EINVAL;
+	}
+
+	size /=3D 8;
+	encrypted =3D alloca(size);
+	decrypted =3D alloca(size);
+
+	pub_key =3D l_cert_get_pubkey(cert);
+	if (!pub_key) {
+		l_error("l_cert_get_pubkey fails for %s", cert_name);
+		return -EIO;
+	}
+
+	result =3D l_key_encrypt(pub_key, L_KEY_RSA_PKCS1_V1_5, L_CHECKSUM_NONE,
+				"", encrypted, 1, size);
+	l_key_free(pub_key);
+
+	if (result !=3D (ssize_t) size) {
+		l_error("l_key_encrypt fails with %s: %s", cert_name,
+			strerror(-result));
+		return result;
+	}
+
+	result =3D l_key_decrypt(priv_key, L_KEY_RSA_PKCS1_V1_5, L_CHECKSUM_NONE,
+				encrypted, decrypted, size, size);
+	if (result < 0) {
+		l_error("l_key_decrypt fails with %s: %s", key_name,
+			strerror(-result));
+		return result;
+	}
+
+	if (result !=3D 1 || decrypted[0] !=3D 0) {
+		l_error("Private key %s does not match certificate %s", key_name,
+			cert_name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int eap_tls_settings_check(struct l_settings *settings,
 						struct l_queue *secrets,
 						const char *prefix,
 						struct l_queue **out_missing)
 {
-	char tls_prefix[72];
+	char tls_prefix[32];
+	char passphrase_setting[72];
+	char client_cert_setting[72];
+	char priv_key_setting[72];
+	L_AUTO_FREE_VAR(char *, passphrase) =3D NULL;
+	L_AUTO_FREE_VAR(char *, client_cert_value) =3D NULL;
+	L_AUTO_FREE_VAR(char *, priv_key_value) =3D NULL;
+	struct l_certchain *client_cert =3D NULL;
+	struct l_key *priv_key =3D NULL;
+	const char *error_str;
+	bool is_encrypted;
+	int ret;
 =

 	snprintf(tls_prefix, sizeof(tls_prefix), "%sTLS-", prefix);
 =

-	return eap_tls_common_settings_check(settings, secrets, tls_prefix,
-								out_missing);
+	ret =3D eap_tls_common_settings_check(settings, secrets, tls_prefix,
+						out_missing);
+	if (ret < 0)
+		goto done;
+
+	snprintf(client_cert_setting, sizeof(client_cert_setting),
+			"%sClientCert", tls_prefix);
+	client_cert_value =3D l_settings_get_string(settings, "Security",
+							client_cert_setting);
+
+	snprintf(priv_key_setting, sizeof(priv_key_setting), "%sClientKey",
+			tls_prefix);
+	priv_key_value =3D l_settings_get_string(settings, "Security",
+						priv_key_setting);
+
+	snprintf(passphrase_setting, sizeof(passphrase_setting),
+			"%sClientKeyPassphrase", tls_prefix);
+	passphrase =3D l_settings_get_string(settings, "Security",
+						passphrase_setting);
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
+	/*
+	 * Check whether the combination of settings that are present/missing
+	 * makes sense before validating each setting.
+	 */
+	if (priv_key_value && !client_cert_value) {
+		l_error("%s present but no client certificate (%s)",
+			priv_key_setting, client_cert_setting);
+		ret =3D -ENOENT;
+		goto done;
+	} else if (!priv_key_value && client_cert) {
+		l_error("%s present but no client private key (%s)",
+			client_cert_setting, priv_key_setting);
+		ret =3D -ENOENT;
+		goto done;
+	}
+
+	if (!priv_key_value) {
+		if (passphrase) {
+			l_error("%s present but no client private key set (%s)",
+				passphrase_setting, priv_key_setting);
+			ret =3D -ENOENT;
+			goto done;
+		}
+
+		ret =3D 0;
+		goto done;
+	}
+
+	client_cert =3D eap_tls_load_client_cert(settings, client_cert_value);
+	if (!client_cert) {
+		l_error("Failed to load %s", client_cert_value);
+		ret =3D -EIO;
+		goto done;
+	}
+
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
+	priv_key =3D eap_tls_load_priv_key(settings, priv_key_value, passphrase,
+						&is_encrypted);
+	if (!priv_key) {
+		if (!is_encrypted) {
+			l_error("Error loading client private key %s",
+				priv_key_value);
+			ret =3D -EIO;
+			goto done;
+		}
+
+		if (passphrase) {
+			l_error("Error loading encrypted client private key %s",
+				priv_key_value);
+			ret =3D -EACCES;
+			goto done;
+		}
+
+		/*
+		 * We've got an encrypted key and passphrase was not saved
+		 * in the network settings, need to request the passphrase.
+		 */
+		eap_append_secret(out_missing,
+					EAP_SECRET_LOCAL_PKEY_PASSPHRASE,
+					passphrase_setting, NULL,
+					priv_key_value, EAP_CACHE_TEMPORARY);
+		ret =3D 0;
+		goto done;
+	}
+
+	if (passphrase && !is_encrypted) {
+		l_error("%s present but client private key %s is not encrypted",
+			passphrase_setting, priv_key_value);
+		ret =3D -ENOENT;
+		goto done;
+	}
+
+	ret =3D eap_tls_check_keys_match(priv_key,
+					l_certchain_get_leaf(client_cert),
+					priv_key_value, client_cert_value);
+
+done:
+	l_certchain_free(client_cert);
+	l_key_free(priv_key);
+
+	if (passphrase)
+		explicit_bzero(passphrase, strlen(passphrase));
+
+	return ret;
 }
 =

 static const struct eap_tls_variant_ops eap_tls_ops =3D {
@@ -81,16 +269,49 @@ static bool eap_tls_settings_load(struct eap_state *ea=
p,
 						struct l_settings *settings,
 						const char *prefix)
 {
-	char setting_key_prefix[72];
+	char tls_prefix[32];
+	char setting_key[72];
+	struct l_certchain *client_cert =3D NULL;
+	struct l_key *client_key =3D NULL;
 =

-	snprintf(setting_key_prefix, sizeof(setting_key_prefix), "%sTLS-",
-									prefix);
+	L_AUTO_FREE_VAR(char *, value) =3D NULL;
+	L_AUTO_FREE_VAR(char *, passphrase) =3D NULL;
 =

-	if (!eap_tls_common_settings_load(eap, settings, setting_key_prefix,
-							&eap_tls_ops, NULL))
+	snprintf(tls_prefix, sizeof(tls_prefix), "%sTLS-", prefix);
+
+	if (!eap_tls_common_settings_load(eap, settings, tls_prefix,
+						&eap_tls_ops, NULL))
 		return false;
 =

+	snprintf(setting_key, sizeof(setting_key), "%sClientKeyPassphrase",
+			tls_prefix);
+	passphrase =3D l_settings_get_string(settings, "Security", setting_key);
+
+	snprintf(setting_key, sizeof(setting_key), "%sClientCert", tls_prefix);
+	value =3D l_settings_get_string(settings, "Security", setting_key);
+	if (value) {
+		client_cert =3D eap_tls_load_client_cert(settings, value);
+		if (!client_cert)
+			goto load_error;
+	}
+
+	l_free(value);
+
+	snprintf(setting_key, sizeof(setting_key), "%sClientKey", tls_prefix);
+	value =3D l_settings_get_string(settings, "Security", setting_key);
+	if (value) {
+		client_key =3D eap_tls_load_priv_key(settings, value,
+							passphrase, NULL);
+		if (!client_key)
+			goto load_error;
+	}
+
+	eap_tls_common_set_keys(eap, client_cert, client_key);
 	return true;
+
+load_error:
+	eap_tls_common_state_free(eap);
+	return false;
 }
 =

 static struct eap_method eap_tls =3D {
-- =

2.27.0

--===============5785324732922275698==--

