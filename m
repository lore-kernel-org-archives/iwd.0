Content-Type: multipart/mixed; boundary="===============7907471861453245019=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [RFCv2 2/3] network: add support for encrypted [Security] group
Date: Mon, 24 Jan 2022 11:49:35 -0800
Message-ID: <20220124194936.2988442-3-prestwoj@gmail.com>
In-Reply-To: 20220124194936.2988442-1-prestwoj@gmail.com

--===============7907471861453245019==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Using a systemd provided key the [Security] group in a network profile
can be encrypted to avoid storing any sensitive data in plaintext. To
do this the [Security] group will be encrypted when writing to disk
and will contain two values: EncryptedSalt and EncryptedSecurity. The
salt is a string of random bytes used as part of the IV, and
EncryptedSecurity is the (now encrypted) [Security] group. When reading
from disk EncryptedSecurity will be decrypted, and its key/values
populated into IWD's network->settings object. From here IWD can read
them as it normally would, unaware they were ever encrypted in the
first place.

When transitioning to this option any existing provisioning files will
be encrypted. The enabling of SystemdEncrypt assumes you want all your
profiles encrypted. There is no way of encrypting some but not others.

The encryption itself uses AES-SIV with the auth data (IV) set to the
EncryptedSalt value, and network SSID.

If decryption fails for whatever reason the behavior is no different
than if no credentials were found at all, meaning an agent request will
be required to re-establish the credentials and connect to the network.
This could happen, for example, if the secret was changed.
---
 src/network.c | 177 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 157 insertions(+), 20 deletions(-)

diff --git a/src/network.c b/src/network.c
index 4e7af27c..8e8271f8 100644
--- a/src/network.c
+++ b/src/network.c
@@ -92,6 +92,81 @@ struct network {
 	struct l_dbus_message *connect_after_owe_hidden;
 };
 =

+static void copy_group(struct l_settings *to, struct l_settings *from,
+			const char *group)
+{
+	char **keys =3D l_settings_get_keys(from, group);
+	char **i;
+
+	for (i =3D keys; *i; i++) {
+		const char *v =3D l_settings_get_value(from, group, *i);
+
+		l_settings_set_value(to, group, *i, v);
+	}
+
+	l_strv_free(keys);
+}
+
+static bool network_decrypt_security(struct network *network)
+{
+	size_t key_len;
+	const uint8_t *key =3D iwd_get_system_key(&key_len);
+	struct iovec ad[2];
+	size_t elen, slen;
+	_auto_(l_settings_free) struct l_settings *security =3D l_settings_new();
+	_auto_(l_free) uint8_t *encrypted =3D l_settings_get_bytes(
+						network->settings, "Security",
+						"EncryptedSecurity", &elen);
+	_auto_(l_free) uint8_t *salt =3D l_settings_get_bytes(
+						network->settings, "Security",
+						"EncryptedSalt", &slen);
+	_auto_(l_free) uint8_t *decrypted =3D NULL;
+
+	if (!(encrypted && salt)) {
+		/*
+		 * If no key is found and the profile is using a plaintext
+		 * [Security] group just print a warning and continue. Otherwise
+		 * this is likely the first run after enabling SystemdEncrypt,
+		 * so set sync_settings so [Security] will be encrypted when
+		 * writing out the file.
+		 */
+		if (!key)
+			l_warn("Encrypted profile found, but no key to decrypt,"
+				" check iwd.service file");
+		else {
+			l_debug("Will encrypt settings when writing to disk");
+			network->sync_settings =3D true;
+		}
+
+		return false;
+	}
+
+	ad[0].iov_base =3D salt;
+	ad[0].iov_len =3D slen;
+	ad[1].iov_base =3D network->ssid;
+	ad[1].iov_len =3D strlen(network->ssid);
+
+	decrypted =3D l_malloc(elen - 16);
+
+	if (!aes_siv_decrypt(key, key_len, encrypted, elen, ad, 2, decrypted)) {
+		l_error("Could not decrypt %s profile, did the secret change?",
+				network->ssid);
+		return false;
+	}
+
+	if (!l_settings_load_from_data(security, (const char *)decrypted,
+					elen - 16)) {
+		l_error("Could not load decrypted [Security] group");
+		return false;
+	}
+
+	/* Remove encrypted [Security], and copy the decrypted one */
+	l_settings_remove_group(network->settings, "Security");
+	copy_group(network->settings, security, "Security");
+
+	return true;
+}
+
 static bool network_settings_load(struct network *network)
 {
 	if (network->settings)
@@ -100,7 +175,15 @@ static bool network_settings_load(struct network *netw=
ork)
 	if (network->info)
 		network->settings =3D network_info_open_settings(network->info);
 =

-	return network->settings !=3D NULL;
+	if (!network->settings)
+		return false;
+
+	if (iwd_get_system_key(NULL)) {
+		if (!network_decrypt_security(network))
+			return false;
+	}
+
+	return true;
 }
 =

 static void network_reset_psk(struct network *network)
@@ -639,6 +722,78 @@ static void network_settings_save_sae_pt_ecc(struct l_=
settings *settings,
 	l_settings_set_bytes(settings, "Security", key, buf, len);
 }
 =

+static void network_update_security(struct network *network,
+					struct l_settings *settings)
+{
+	size_t key_len;
+	const uint8_t *key =3D iwd_get_system_key(&key_len);
+	struct iovec ad[2];
+	_auto_(l_free) char *plaintext =3D NULL;
+	_auto_(l_free) uint8_t *encrypted =3D NULL;
+	size_t plen, slen;
+	_auto_(l_free) uint8_t *salt =3D NULL;
+
+	if (!key)
+		goto write_settings;
+
+	salt =3D l_settings_get_bytes(network->settings, "Security",
+						"EncryptedSalt", &slen);
+	/*
+	 * Must be a first run after enabling encryption, generate a new salt.
+	 * A new salt could also be generated each update/sync too...
+	 */
+	if (!salt) {
+		salt =3D l_malloc(32);
+		l_getrandom(salt, 32);
+		slen =3D 32;
+	}
+
+write_settings:
+	if (network->security !=3D SECURITY_PSK)
+		goto end_psk;
+
+	if (network->psk)
+		l_settings_set_bytes(settings, "Security", "PreSharedKey",
+						network->psk, 32);
+
+	if (network->passphrase)
+		l_settings_set_string(settings, "Security", "Passphrase",
+						network->passphrase);
+	if (network->sae_pt_19)
+		network_settings_save_sae_pt_ecc(settings, network->sae_pt_19);
+
+	if (network->sae_pt_20)
+		network_settings_save_sae_pt_ecc(settings, network->sae_pt_20);
+
+end_psk:
+	if (!key)
+		return;
+
+	/*
+	 * Get plaintext [Security], remove [Security] group, and re-fill with
+	 * encrypted values
+	 */
+	plaintext =3D l_settings_to_data(settings, &plen);
+	l_settings_remove_group(settings, "Security");
+
+	ad[0].iov_base =3D salt;
+	ad[0].iov_len =3D slen;
+	ad[1].iov_base =3D network->ssid;
+	ad[1].iov_len =3D strlen(network->ssid);
+
+	encrypted =3D l_malloc(plen + 16);
+
+	if (!aes_siv_encrypt(key, key_len, plaintext, plen, ad, 2, encrypted)) {
+		l_error("Could not encrypt [Security] group");
+		return;
+	}
+
+	l_settings_set_bytes(settings, "Security", "EncryptedSalt",
+				salt, slen);
+	l_settings_set_bytes(settings, "Security", "EncryptedSecurity",
+				encrypted, plen + 16);
+}
+
 static void network_settings_save(struct network *network,
 						struct l_settings *settings)
 {
@@ -664,25 +819,7 @@ static void network_settings_save(struct network *netw=
ork,
 					modes, ' ');
 	}
 =

-	if (network->security !=3D SECURITY_PSK)
-		return;
-
-	/* We only update the [Security] bits here, wipe the group first */
-	l_settings_remove_group(settings, "Security");
-
-	if (network->psk)
-		l_settings_set_bytes(settings, "Security", "PreSharedKey",
-					network->psk, 32);
-
-	if (network->passphrase)
-		l_settings_set_string(settings, "Security", "Passphrase",
-					network->passphrase);
-
-	if (network->sae_pt_19)
-		network_settings_save_sae_pt_ecc(settings, network->sae_pt_19);
-
-	if (network->sae_pt_20)
-		network_settings_save_sae_pt_ecc(settings, network->sae_pt_20);
+	network_update_security(network, settings);
 }
 =

 void network_sync_settings(struct network *network)
-- =

2.31.1

--===============7907471861453245019==--

