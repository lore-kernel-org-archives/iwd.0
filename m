Content-Type: multipart/mixed; boundary="===============1280462390746002565=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [RFC 2/2] network: add support for encrypted Passphrase/PSK
Date: Thu, 20 Jan 2022 16:41:30 -0800
Message-ID: <20220121004130.2473281-3-prestwoj@gmail.com>
In-Reply-To: 20220121004130.2473281-1-prestwoj@gmail.com

--===============1280462390746002565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Two keys were added: PreSharedKeyEncrypted, PassphraseEncrypted which
are now automatically set/loaded if SystemdEncrypt=3Dtrue.

When transitioning to this option any existing provisioning files will
be read in as plaintext but when synced the *Encrypted options will be
used instead. After that the file will no longer contain any plaintext
psk/passphrase values.

The encryption itself uses AES-CTR with a zero IV. This is to avoid
extra padding and dealing with block sizes. A magic 32 bit value is
prepended to the beginning of the plaintext data to serve as verification
that the decryption succeeded.

If decryption fails for whatever reason the behavior is no different
than if no PSK/Passphrase value was found at all, meaning an agent
request will be required to re-establish the PSK/passphrase or manually
providing the PreSharedKey/Passphrase in plaintext in the provisioning file.
---
 src/network.c | 183 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 177 insertions(+), 6 deletions(-)

diff --git a/src/network.c b/src/network.c
index 10937ab7..89d6b8e2 100644
--- a/src/network.c
+++ b/src/network.c
@@ -572,8 +572,108 @@ generate:
 	return -EIO;
 }
 =

+static uint8_t *network_decrypt(const uint8_t *key, size_t key_len,
+				void *encrypted, size_t len, size_t *len_out)
+{
+	struct l_cipher *aes;
+	uint8_t iv[16] =3D { 0 };
+	uint32_t magic =3D 0x0abcdef0;
+	uint8_t *out;
+
+	aes =3D l_cipher_new(L_CIPHER_AES_CTR, key, key_len);
+	l_cipher_set_iv(aes, iv, sizeof(iv));
+
+	out =3D l_malloc(len);
+
+	l_cipher_decrypt(aes, encrypted, out, len);
+
+	if (memcmp(out, &magic, 4)) {
+		l_free(out);
+		return NULL;
+	}
+
+	memmove(out, out + 4, len - 4);
+
+	*len_out =3D len - 4;
+
+	return out;
+}
+
+static int network_decrypt_secrets(const uint8_t *key, size_t key_len,
+					struct network *network,
+					uint8_t **psk, size_t *psk_len,
+					char **passphrase)
+{
+	uint8_t *encrypted;
+	size_t elen, dlen;
+	uint8_t *psk_out =3D NULL;
+	size_t psk_len_out =3D 0;
+	char *passphrase_out =3D NULL;
+
+	if (*psk || *passphrase) {
+		/*
+		 * Likely the first time running IWD after SystemdEncrypt was
+		 * enabled. Let network_load_psk process the psk/passphrase in
+		 * plaintext but set sync_settings so they will be force written
+		 * to disk as the *Encrypted options.
+		 *
+		 * Someone could have manually added Passphrase/PreSharedKey
+		 * back into the file too but either way sync the settings.
+		 */
+		network->sync_settings =3D true;
+		return 0;
+	}
+
+	encrypted =3D l_settings_get_bytes(network->settings, "Security",
+					"PreSharedKeyEncrypted", &elen);
+	if (encrypted) {
+		psk_out =3D network_decrypt(key, key_len, encrypted,
+					elen, &psk_len_out);
+		if (!psk_out) {
+			l_error("Decryption failed for PreSharedKey");
+			l_free(encrypted);
+			return -ENOKEY;
+		}
+
+		l_free(encrypted);
+	}
+
+	encrypted =3D l_settings_get_bytes(network->settings, "Security",
+					"PassphraseEncrypted", &elen);
+	if (encrypted) {
+		uint8_t *p =3D network_decrypt(key, key_len, encrypted,
+						elen, &dlen);
+		if (!p) {
+			l_error("Decryption failed for Passphrase");
+			l_free(encrypted);
+			return -ENOKEY;
+		}
+
+		passphrase_out =3D l_malloc(dlen + 1);
+		memcpy(passphrase_out, p, dlen);
+		passphrase_out[dlen] =3D '\0';
+
+		l_free(p);
+		l_free(encrypted);
+	}
+
+	if (psk)
+		*psk =3D psk_out;
+
+	if (psk_len)
+		*psk_len =3D psk_len_out;
+
+	if (passphrase)
+		*passphrase =3D passphrase_out;
+
+	return 0;
+}
+
 static int network_load_psk(struct network *network, bool need_passphrase)
 {
+	size_t key_len;
+	const uint8_t *key =3D iwd_get_system_key(&key_len);
+	int ret;
 	const char *ssid =3D network_get_ssid(network);
 	enum security security =3D network_get_security(network);
 	size_t psk_len;
@@ -586,6 +686,13 @@ static int network_load_psk(struct network *network, b=
ool need_passphrase)
 	_auto_(l_free) char *path =3D
 		storage_get_network_file_path(security, ssid);
 =

+	if (key) {
+		ret =3D network_decrypt_secrets(key, key_len, network,
+						&psk, &psk_len, &passphrase);
+		if (ret < 0)
+			return ret;
+	}
+
 	if (psk && psk_len !=3D 32) {
 		l_error("%s: invalid PreSharedKey format", path);
 		l_free(psk);
@@ -639,9 +746,69 @@ static void network_settings_save_sae_pt_ecc(struct l_=
settings *settings,
 	l_settings_set_bytes(settings, "Security", key, buf, len);
 }
 =

+/*
+ * Using AES-CTR to with a zero IV to avoid dealing with padding as oppose=
d to
+ * regular AES. 4 magic bytes are prepended to the plaintext bytes to act =
as
+ * verification when the data is decrypted.
+ */
+static uint8_t *network_encrypt(const uint8_t *key, size_t key_len,
+				void *decrypted, size_t len, size_t *len_out)
+{
+	struct l_cipher *aes;
+	uint8_t iv[16] =3D { 0 };
+	uint32_t magic =3D 0x0abcdef0;
+	uint8_t in[len + 4];
+	uint8_t *out;
+
+	aes =3D l_cipher_new(L_CIPHER_AES_CTR, key, key_len);
+	l_cipher_set_iv(aes, iv, sizeof(iv));
+
+	memcpy(in, &magic, 4);
+	memcpy(in + 4, decrypted, len);
+
+	out =3D l_malloc(len + 4);
+
+	l_cipher_encrypt(aes, in, out, len + 4);
+
+	*len_out =3D len + 4;
+
+	return out;
+}
+
+static void network_encrypt_secrets(const uint8_t *key, size_t len,
+					struct network *network,
+					struct l_settings *settings)
+{
+	uint8_t *enc;
+	size_t enc_len;
+
+	if (network->psk) {
+		enc =3D network_encrypt(key, len, network->psk, 32, &enc_len);
+
+		l_settings_set_bytes(settings, "Security",
+					"PreSharedKeyEncrypted", enc, enc_len);
+
+		l_free(enc);
+	}
+
+	if (network->passphrase) {
+		enc =3D network_encrypt(key, len, network->passphrase,
+					strlen(network->passphrase), &enc_len);;
+
+		l_settings_set_bytes(settings, "Security",
+					"PassphraseEncrypted", enc, enc_len);
+
+		l_free(enc);
+	}
+
+}
+
 static void network_settings_save(struct network *network,
 						struct l_settings *settings)
 {
+	size_t key_len;
+	const uint8_t *encrypt_key =3D iwd_get_system_key(&key_len);
+
 	if (network->have_transition_disable) {
 		char *modes[4];
 		unsigned int i =3D 0;
@@ -670,13 +837,17 @@ static void network_settings_save(struct network *net=
work,
 	/* We only update the [Security] bits here, wipe the group first */
 	l_settings_remove_group(settings, "Security");
 =

-	if (network->psk)
-		l_settings_set_bytes(settings, "Security", "PreSharedKey",
-					network->psk, 32);
+	if (!encrypt_key) {
+		if (network->psk)
+			l_settings_set_bytes(settings, "Security", "PreSharedKey",
+						network->psk, 32);
 =

-	if (network->passphrase)
-		l_settings_set_string(settings, "Security", "Passphrase",
-					network->passphrase);
+		if (network->passphrase)
+			l_settings_set_string(settings, "Security", "Passphrase",
+						network->passphrase);
+	} else
+		network_encrypt_secrets(encrypt_key, key_len, network,
+						settings);
 =

 	if (network->sae_pt_19)
 		network_settings_save_sae_pt_ecc(settings, network->sae_pt_19);
-- =

2.31.1

--===============1280462390746002565==--

