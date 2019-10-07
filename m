Content-Type: multipart/mixed; boundary="===============8217295659557738125=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/3] eap-tls-common: allow embedded PEMs in settings
Date: Mon, 07 Oct 2019 11:11:56 -0700
Message-ID: <20191007181158.16091-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8217295659557738125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Refactoring was required to allow for embedded certs. The existing
eap_tls_state object was changed to hold the cert types (l_queue,
l_certchain, l_key) rather than the file path, since there may not
actually be separate PEM files.

Care was taken to properly manage the memory of these objects.
Since the TLS object takes ownership when setting auth data or the
CA certs all error cases must be handled properly to free these
objects after they are loaded and in addition they must be set to
NULL so that the cleanup doesn't double free them.

If everything goes to plan, we load all the PEMs in settings_load,
provide these objects to the TLS APIs, and then NULL out the
pointers (TLS now owns this memory). If anything fails between
settings_load and l_tls_start we must free these objects.

A special format must be used to indicate that a PEM is embedded
inside the settings file. First, the l_settings format should be
followed for the PEM itself, e.g.

[@pem(a)my_ca_cert]
<CA Cert data>

This PEM can then be referenced by "embed:my_ca_cert", e.g.

EAP-TLS-CACert=3Dembed:my_ca_cert

Any other value not starting with "embed:" will be treated as a file
path.
---
 src/eap-tls-common.c | 259 +++++++++++++++++++++++++++++--------------
 1 file changed, 177 insertions(+), 82 deletions(-)

diff --git a/src/eap-tls-common.c b/src/eap-tls-common.c
index 39015167..b76770ce 100644
--- a/src/eap-tls-common.c
+++ b/src/eap-tls-common.c
@@ -113,10 +113,9 @@ struct eap_tls_state {
 =

 	bool expecting_frag_ack:1;
 =

-	char *ca_cert;
-	char *client_cert;
-	char *client_key;
-	char *passphrase;
+	struct l_queue *ca_cert;
+	struct l_certchain *client_cert;
+	struct l_key *client_key;
 	char **domain_mask;
 =

 	const struct eap_tls_variant_ops *variant_ops;
@@ -154,6 +153,21 @@ static void __eap_tls_common_state_reset(struct eap_tl=
s_state *eap_tls)
 	}
 }
 =

+static void __eap_tls_common_state_free(struct eap_tls_state *eap_tls)
+{
+	if (eap_tls->ca_cert)
+		l_queue_destroy(eap_tls->ca_cert,
+					(l_queue_destroy_func_t)l_cert_free);
+	if (eap_tls->client_cert)
+		l_certchain_free(eap_tls->client_cert);
+
+	if (eap_tls->client_key)
+		l_key_free(eap_tls->client_key);
+
+	l_strv_free(eap_tls->domain_mask);
+	l_free(eap_tls);
+}
+
 bool eap_tls_common_state_reset(struct eap_state *eap)
 {
 	struct eap_tls_state *eap_tls =3D eap_get_data(eap);
@@ -177,18 +191,7 @@ void eap_tls_common_state_free(struct eap_state *eap)
 	if (eap_tls->variant_ops->destroy)
 		eap_tls->variant_ops->destroy(eap_tls->variant_data);
 =

-	l_free(eap_tls->ca_cert);
-	l_free(eap_tls->client_cert);
-	l_free(eap_tls->client_key);
-
-	if (eap_tls->passphrase) {
-		explicit_bzero(eap_tls->passphrase,
-				strlen(eap_tls->passphrase));
-		l_free(eap_tls->passphrase);
-	}
-
-	l_strv_free(eap_tls->domain_mask);
-	l_free(eap_tls);
+	__eap_tls_common_state_free(eap_tls);
 }
 =

 static void eap_tls_tunnel_debug(const char *str, void *user_data)
@@ -544,55 +547,34 @@ static bool eap_tls_tunnel_init(struct eap_state *eap)
 									NULL);
 =

 	if (eap_tls->client_cert || eap_tls->client_key) {
-		struct l_certchain *client_cert =3D
-			l_pem_load_certificate_chain(eap_tls->client_cert);
-		struct l_key *client_key;
-
-		if (!client_cert) {
-			l_error("%s: Failed to parse client certificate: %s.",
-					eap_get_method_name(eap),
-					eap_tls->client_cert);
-			return false;
-		}
+		if (!l_tls_set_auth_data(eap_tls->tunnel, eap_tls->client_cert,
+						eap_tls->client_key)) {
+			l_certchain_free(eap_tls->client_cert);
+			eap_tls->client_cert =3D NULL;
 =

-		client_key =3D l_pem_load_private_key(eap_tls->client_key,
-							eap_tls->passphrase,
-							NULL);
-		if (!client_key) {
-			l_error("%s: Failed to parse client private key: %s.",
-					eap_get_method_name(eap),
-					eap_tls->client_key);
-			return false;
-		}
+			l_key_free(eap_tls->client_key);
+			eap_tls->client_key =3D NULL;
 =

-		if (!l_tls_set_auth_data(eap_tls->tunnel,
-						client_cert, client_key)) {
-			l_certchain_free(client_cert);
-			l_key_free(client_key);
 			l_error("%s: Failed to set auth data.",
 					eap_get_method_name(eap));
 			return false;
 		}
+
+		eap_tls->client_cert =3D NULL;
+		eap_tls->client_key =3D NULL;
 	}
 =

 	if (eap_tls->ca_cert) {
-		struct l_queue *ca_cert =3D
-			l_pem_load_certificate_list(eap_tls->ca_cert);
-
-		if (!ca_cert) {
-			l_error("%s: Error loading CA certificates from %s.",
-						eap_get_method_name(eap),
-						eap_tls->ca_cert);
-			return false;
-		}
-
-		if (!l_tls_set_cacert(eap_tls->tunnel, ca_cert)) {
-			l_queue_destroy(ca_cert,
+		if (!l_tls_set_cacert(eap_tls->tunnel, eap_tls->ca_cert)) {
+			l_queue_destroy(eap_tls->ca_cert,
 					(l_queue_destroy_func_t)l_cert_free);
+			eap_tls->ca_cert =3D NULL;
 			l_error("%s: Error settings CA certificates.",
 					eap_get_method_name(eap));
 			return false;
 		}
+
+		eap_tls->ca_cert =3D NULL;
 	}
 =

 	if (eap_tls->domain_mask)
@@ -793,6 +775,83 @@ error:
 	eap_method_error(eap);
 }
 =

+static const char *load_embedded_pem(struct l_settings *settings,
+					const char *name)
+{
+	const char *pem;
+	const char *type;
+
+	pem =3D l_settings_get_embedded_value(settings, name + 6, &type);
+	if (!pem)
+		return NULL;
+
+	if (strcmp(type, "pem"))
+		return NULL;
+
+	return pem;
+}
+
+static bool is_embedded(const char *str)
+{
+	if (!str)
+		return false;
+
+	if (strlen(str) < 6)
+		return false;
+
+	if (!strncmp("embed:", str, 6))
+		return true;
+
+	return false;
+}
+
+static struct l_queue *eap_tls_load_ca_cert(struct l_settings *settings,
+						const char *value)
+{
+	const char *pem;
+
+	if (!is_embedded(value))
+		return l_pem_load_certificate_list(value);
+
+	pem =3D load_embedded_pem(settings, value);
+	if (!pem)
+		return NULL;
+
+	return l_pem_load_certificate_list_from_data(pem, strlen(pem));
+}
+
+static struct l_certchain *eap_tls_load_client_cert(struct l_settings *set=
tings,
+							const char *value)
+{
+	const char *pem;
+
+	if (!is_embedded(value))
+		return l_pem_load_certificate_chain(value);
+
+	pem =3D load_embedded_pem(settings, value);
+	if (!pem)
+		return NULL;
+
+	return l_pem_load_certificate_chain_from_data(pem, strlen(pem));
+}
+
+static struct l_key *eap_tls_load_priv_key(struct l_settings *settings,
+				const char *value, const char *passphrase,
+				bool *is_encrypted)
+{
+	const char *pem;
+
+	if (!is_embedded(value))
+		return l_pem_load_private_key(value, passphrase, is_encrypted);
+
+	pem =3D load_embedded_pem(settings, value);
+	if (!pem)
+		return NULL;
+
+	return l_pem_load_private_key_from_data(pem, strlen(pem),
+						passphrase, is_encrypted);
+}
+
 int eap_tls_common_settings_check(struct l_settings *settings,
 					struct l_queue *secrets,
 					const char *prefix,
@@ -813,16 +872,17 @@ int eap_tls_common_settings_check(struct l_settings *=
settings,
 	struct l_key *pub_key;
 	const char *domain_mask_str;
 =

-	L_AUTO_FREE_VAR(char *, path);
+	L_AUTO_FREE_VAR(char *, value);
 	L_AUTO_FREE_VAR(char *, client_cert) =3D NULL;
 	L_AUTO_FREE_VAR(char *, passphrase) =3D NULL;
 =

 	snprintf(setting_key, sizeof(setting_key), "%sCACert", prefix);
-	path =3D l_settings_get_string(settings, "Security", setting_key);
-	if (path) {
-		cacerts =3D l_pem_load_certificate_list(path);
+	value =3D l_settings_get_string(settings, "Security", setting_key);
+	if (value) {
+		cacerts =3D eap_tls_load_ca_cert(settings, value);
+
 		if (!cacerts) {
-			l_error("Failed to load %s", path);
+			l_error("Failed to load %s", value);
 			return -EIO;
 		}
 	}
@@ -832,7 +892,8 @@ int eap_tls_common_settings_check(struct l_settings *se=
ttings,
 	client_cert =3D l_settings_get_string(settings, "Security",
 							client_cert_setting);
 	if (client_cert) {
-		cert =3D l_pem_load_certificate_chain(client_cert);
+		cert =3D eap_tls_load_client_cert(settings, client_cert);
+
 		if (!cert) {
 			l_error("Failed to load %s", client_cert);
 			ret =3D -EIO;
@@ -843,7 +904,7 @@ int eap_tls_common_settings_check(struct l_settings *se=
ttings,
 			if (cacerts)
 				l_error("Certificate chain %s is not trusted "
 					"by any CA in %s or fails verification"
-					": %s", client_cert, path, error_str);
+					": %s", client_cert, value, error_str);
 			else
 				l_error("Certificate chain %s fails "
 					"verification: %s",
@@ -854,17 +915,17 @@ int eap_tls_common_settings_check(struct l_settings *=
settings,
 		}
 	}
 =

-	l_free(path);
+	l_free(value);
 =

 	snprintf(setting_key, sizeof(setting_key), "%sClientKey", prefix);
-	path =3D l_settings_get_string(settings, "Security", setting_key);
+	value =3D l_settings_get_string(settings, "Security", setting_key);
 =

-	if (path && !client_cert) {
+	if (value && !client_cert) {
 		l_error("%s present but no client certificate (%s)",
 					setting_key, client_cert_setting);
 		ret =3D -ENOENT;
 		goto done;
-	} else if (!path && client_cert) {
+	} else if (!value && client_cert) {
 		l_error("%s present but no client private key (%s)",
 					client_cert_setting, setting_key);
 		ret =3D -ENOENT;
@@ -885,10 +946,11 @@ int eap_tls_common_settings_check(struct l_settings *=
settings,
 			passphrase =3D l_strdup(secret->value);
 	}
 =

-	if (!path) {
+	if (!value) {
 		if (passphrase) {
-			l_error("%s present but no client private key path set (%s)",
-				passphrase_setting, setting_key);
+			l_error("%s present but no client private key"
+				" value set (%s)", passphrase_setting,
+				setting_key);
 			ret =3D -ENOENT;
 			goto done;
 		}
@@ -897,17 +959,19 @@ int eap_tls_common_settings_check(struct l_settings *=
settings,
 		goto done;
 	}
 =

-	priv_key =3D l_pem_load_private_key(path, passphrase, &is_encrypted);
+	priv_key =3D eap_tls_load_priv_key(settings, value, passphrase,
+						&is_encrypted);
+
 	if (!priv_key) {
 		if (!is_encrypted) {
-			l_error("Error loading client private key %s", path);
+			l_error("Error loading client private key %s", value);
 			ret =3D -EIO;
 			goto done;
 		}
 =

 		if (passphrase) {
 			l_error("Error loading encrypted client private key %s",
-				path);
+				value);
 			ret =3D -EACCES;
 			goto done;
 		}
@@ -918,7 +982,7 @@ int eap_tls_common_settings_check(struct l_settings *se=
ttings,
 		 */
 		eap_append_secret(out_missing,
 					EAP_SECRET_LOCAL_PKEY_PASSPHRASE,
-					passphrase_setting, NULL, path,
+					passphrase_setting, NULL, value,
 					EAP_CACHE_TEMPORARY);
 		ret =3D 0;
 		goto done;
@@ -926,7 +990,7 @@ int eap_tls_common_settings_check(struct l_settings *se=
ttings,
 =

 	if (passphrase && !is_encrypted) {
 		l_error("%s present but client private key %s is not encrypted",
-			passphrase_setting, path);
+			passphrase_setting, value);
 		ret =3D -ENOENT;
 		goto done;
 	}
@@ -934,7 +998,7 @@ int eap_tls_common_settings_check(struct l_settings *se=
ttings,
 	if (!l_key_get_info(priv_key, L_KEY_RSA_PKCS1_V1_5, L_CHECKSUM_NONE,
 				&size, &is_public) || is_public) {
 		l_error("%s is not a private key or l_key_get_info fails",
-			path);
+			value);
 		ret =3D -EINVAL;
 		goto done;
 	}
@@ -964,14 +1028,14 @@ int eap_tls_common_settings_check(struct l_settings =
*settings,
 	result =3D l_key_decrypt(priv_key, L_KEY_RSA_PKCS1_V1_5, L_CHECKSUM_NONE,
 				encrypted, decrypted, size, size);
 	if (result < 0) {
-		l_error("l_key_decrypt fails with %s: %s", path,
+		l_error("l_key_decrypt fails with %s: %s", value,
 			strerror(-result));
 		ret =3D result;
 		goto done;
 	}
 =

 	if (result !=3D 1 || decrypted[0] !=3D 0) {
-		l_error("Private key %s does not match certificate %s", path,
+		l_error("Private key %s does not match certificate %s", value,
 			client_cert);
 		ret =3D -EINVAL;
 		goto done;
@@ -1014,6 +1078,8 @@ bool eap_tls_common_settings_load(struct eap_state *e=
ap,
 	struct eap_tls_state *eap_tls;
 	char setting_key[72];
 	char *domain_mask_str;
+	L_AUTO_FREE_VAR(char *, value) =3D NULL;
+	L_AUTO_FREE_VAR(char *, passphrase) =3D NULL;
 =

 	eap_tls =3D l_new(struct eap_tls_state, 1);
 =

@@ -1022,21 +1088,45 @@ bool eap_tls_common_settings_load(struct eap_state =
*eap,
 	eap_tls->variant_data =3D variant_data;
 =

 	snprintf(setting_key, sizeof(setting_key), "%sCACert", prefix);
-	eap_tls->ca_cert =3D l_settings_get_string(settings, "Security",
-								setting_key);
+	value =3D l_settings_get_string(settings, "Security", setting_key);
+	if (value) {
+		eap_tls->ca_cert =3D eap_tls_load_ca_cert(settings, value);
+		if (!eap_tls->ca_cert) {
+			l_error("Could not load CACert %s", value);
+			goto load_error;
+		}
+	}
+
+	l_free(value);
 =

 	snprintf(setting_key, sizeof(setting_key), "%sClientCert", prefix);
-	eap_tls->client_cert =3D l_settings_get_string(settings, "Security",
-								setting_key);
+	value =3D l_settings_get_string(settings, "Security", setting_key);
+	if (value) {
+		eap_tls->client_cert =3D eap_tls_load_client_cert(settings,
+								value);
+		if (!eap_tls->ca_cert) {
+			l_error("Could not load ClientCert %s", value);
+			goto load_error;
+		}
+	}
 =

-	snprintf(setting_key, sizeof(setting_key), "%sClientKey", prefix);
-	eap_tls->client_key =3D l_settings_get_string(settings, "Security",
-								setting_key);
+	l_free(value);
 =

 	snprintf(setting_key, sizeof(setting_key), "%sClientKeyPassphrase",
 									prefix);
-	eap_tls->passphrase =3D l_settings_get_string(settings, "Security",
-								setting_key);
+	passphrase =3D l_settings_get_string(settings, "Security", setting_key);
+
+	snprintf(setting_key, sizeof(setting_key), "%sClientKey", prefix);
+	value =3D l_settings_get_string(settings, "Security", setting_key);
+	if (value) {
+		eap_tls->client_key =3D eap_tls_load_priv_key(settings, value,
+								passphrase,
+								NULL);
+		if (!eap_tls->client_key) {
+			l_error("Could not load ClientKey %s", value);
+			goto load_error;
+		}
+	}
 =

 	snprintf(setting_key, sizeof(setting_key), "%sServerDomainMask",
 								prefix);
@@ -1051,6 +1141,11 @@ bool eap_tls_common_settings_load(struct eap_state *=
eap,
 	eap_set_data(eap, eap_tls);
 =

 	return true;
+
+load_error:
+	__eap_tls_common_state_free(eap_tls);
+
+	return false;
 }
 =

 void eap_tls_common_set_completed(struct eap_state *eap)
-- =

2.17.1

--===============8217295659557738125==--

