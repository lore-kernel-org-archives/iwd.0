Content-Type: multipart/mixed; boundary="===============1683164182211248889=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 1/5] storage: implement network profile encryption
Date: Wed, 02 Feb 2022 10:47:40 -0800
Message-ID: <20220202184744.1954-1-prestwoj@gmail.com>

--===============1683164182211248889==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some users don't like the idea of storing network credentials in plaintext
on the file system. As far as IWD goes the credential directory permissions
should be set up such that nobody but the owner/root have access but
nevertheless they are still plaintext.

For added security these credentials can be encrypted using a secret key.
In this patch the origination of the key does not matter, but in this
patch series IWD will support a systemd provided key.

The encryption itself will operate on the entire [Security] group as well
as all embedded groups. Once encrypted the [Security] group will be replaced
with two key/values:

EncryptedSalt - A random string of bytes used for the encryption
EncryptedSecurity - A string of bytes containing the encrypted [Security]
                    group, as well as all embedded groups.

After the profile has been encrypted these values should not be modified.
Note that any values added to [Security] after encryption has no effect.
Once the profile is encrypted there is no way to modify [Security] without
manually decrypting first, or just removing it entirely which effectively
treated a 'new' profile.

The encryption/decryption is done using AES-SIV with a salt value and the
network SSID as the IV.

Once a key is set any profiles opened will automatically be encrypted and
re-written to disk. Modules using network_storage_open will be provided
the decrypted profile, and will be unaware it was ever encrypted in the
first place. Similarly when network_storage_sync is called the profile
will by automatically encrypted and written to disk without the caller
needing to do anything special.
---
 Makefile.am   |   3 +-
 src/storage.c | 239 +++++++++++++++++++++++++++++++++++++++++++++++---
 src/storage.h |   4 +
 3 files changed, 235 insertions(+), 11 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 89c053a6..35938d22 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -381,7 +381,8 @@ tools_hwsim_SOURCES =3D tools/hwsim.c src/mpdu.h \
 					src/nl80211util.h src/nl80211util.c \
 					src/storage.h src/storage.c \
 					src/common.h src/common.c \
-					src/band.h src/band.c
+					src/band.h src/band.c \
+					src/crypto.h src/crypto.c
 tools_hwsim_LDADD =3D $(ell_ldadd)
 =

 if DBUS_POLICY
diff --git a/src/storage.c b/src/storage.c
index 4b89c615..cc8fcda2 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -41,9 +41,11 @@
 #include <sys/stat.h>
 =

 #include <ell/ell.h>
+#include "ell/useful.h"
 =

 #include "src/common.h"
 #include "src/storage.h"
+#include "src/crypto.h"
 =

 #define STORAGE_DIR_MODE (S_IRUSR | S_IWUSR | S_IXUSR)
 #define STORAGE_FILE_MODE (S_IRUSR | S_IWUSR)
@@ -52,6 +54,8 @@
 =

 static char *storage_path =3D NULL;
 static char *storage_hotspot_path =3D NULL;
+static const uint8_t *system_key =3D NULL;
+static size_t system_key_len;
 =

 static int create_dirs(const char *filename)
 {
@@ -347,10 +351,188 @@ const char *storage_network_ssid_from_path(const cha=
r *path,
 	return buf;
 }
 =

+/* Groups requiring encryption (if enabled) */
+static char *encrypt_groups[] =3D {
+	"Security",
+	NULL
+};
+
+static bool encrypt_group(const char *group)
+{
+	char **g;
+
+	for (g =3D encrypt_groups; *g; g++) {
+		if (!strcmp(*g, group))
+			return true;
+	}
+
+	return false;
+}
+
+/*
+ * Encrypt needed groups of 'settings' without modifying the object. Retur=
ns
+ * the entire settings object as data, with encrypted groups as a bytestri=
ng
+ * set as the value to [Security].EncryptedSecurity. This also includes any
+ * embedded groups.
+ *
+ * Note: If encryption is not enabled or there is no Security group this is
+ *       effectively l_settings_to_data.
+ */
+static char *storage_encrypt(struct l_settings *settings, const char *ssid,
+				size_t *out_len)
+{
+	struct iovec ad[2];
+	uint8_t salt[32];
+	size_t len;
+	_auto_(l_free) struct l_settings *to_encrypt =3D NULL;
+	_auto_(l_free) struct l_settings *original =3D NULL;
+	_auto_(l_free) char *plaintext =3D NULL;
+	_auto_(l_free) uint8_t *enc =3D NULL;
+	_auto_(l_strv_free) char **groups =3D NULL;
+	char **i;
+
+	if (!system_key || !l_settings_has_group(settings, "Security"))
+		return l_settings_to_data(settings, out_len);
+
+	/*
+	 * Make two copies of the settings: One will contain only data to be
+	 * encrypted (to_encrypt), the other will contain data to be left
+	 * unencrypted (original). At the end any encrypted data will be set
+	 * into 'original' as EncryptedSecurity.
+	 */
+	to_encrypt =3D l_settings_clone(settings);
+	original =3D l_settings_clone(settings);
+
+	groups =3D l_settings_get_groups(to_encrypt);
+	for (i =3D groups; *i; i++) {
+		if (encrypt_group(*i))
+			l_settings_remove_group(original, *i);
+		else
+			l_settings_remove_group(to_encrypt, *i);
+	}
+
+	l_settings_remove_embedded_groups(original);
+
+	plaintext =3D l_settings_to_data(to_encrypt, &len);
+	if (!plaintext)
+		return NULL;
+
+	l_getrandom(salt, 32);
+
+	ad[0].iov_base =3D (void *) salt;
+	ad[0].iov_len =3D 32;
+	ad[1].iov_base =3D (void *) ssid;
+	ad[1].iov_len =3D strlen(ssid);
+
+	enc =3D l_malloc(len + 16);
+
+	if (!aes_siv_encrypt(system_key, system_key_len, plaintext, len,
+				ad, 2, enc)) {
+		l_error("Could not encrypt [Security] group");
+		return NULL;
+	}
+
+	l_settings_set_bytes(original, "Security", "EncryptedSalt", salt, 32);
+	l_settings_set_bytes(original, "Security", "EncryptedSecurity",
+				enc, len + 16);
+
+	return l_settings_to_data(original, out_len);
+}
+
+/*
+ * Decrypt data in [Security].EncryptedSecurity. This data also includes
+ * embedded groups potentially. Once decrypted the data is put back into t=
he
+ * object.
+ *
+ * Note: if encryption is not enabled or there is no Security group settin=
gs
+ *       is not modified.
+ */
+bool __storage_decrypt(struct l_settings *settings, const char *ssid,
+				bool *changed)
+{
+	_auto_(l_settings_free) struct l_settings *security =3D NULL;
+	_auto_(l_free) uint8_t *encrypted =3D NULL;
+	_auto_(l_free) uint8_t *decrypted =3D NULL;
+	_auto_(l_free) uint8_t *salt =3D NULL;
+	_auto_(l_strv_free) char **embedded =3D NULL;
+	size_t elen, slen;
+	struct iovec ad[2];
+
+	if (!system_key)
+		goto done;
+
+	if (!l_settings_has_group(settings, "Security"))
+		goto done;
+
+	encrypted =3D l_settings_get_bytes(settings, "Security",
+						"EncryptedSecurity", &elen);
+	salt =3D l_settings_get_bytes(settings, "Security",
+						"EncryptedSalt", &slen);
+
+	/*
+	 * Either profile has never been loaded after enabling encryption or is
+	 * missing Encrypted{Salt,Security} values. If either are missing this
+	 * profile is corrupted and must be fixed.
+	 */
+	if (!(encrypted && salt)) {
+		/* Profile corrupted */
+		if (encrypted || salt) {
+			l_warn("Profile %s is corrupted reconfigure manually",
+					ssid);
+			return false;
+		}
+
+		if (changed)
+			*changed =3D true;
+
+		return true;
+	}
+
+	decrypted =3D l_malloc(elen - 16 + 1);
+
+	ad[0].iov_base =3D (void *)salt;
+	ad[0].iov_len =3D slen;
+	ad[1].iov_base =3D (void *)ssid;
+	ad[1].iov_len =3D strlen(ssid);
+
+	if (!aes_siv_decrypt(system_key, system_key_len, encrypted, elen,
+				ad, 2, decrypted)) {
+		l_error("Could not decrypt %s profile, did the secret change?",
+				ssid);
+		return false;
+	}
+
+	decrypted[elen - 16] =3D '\0';
+
+	/* Remove encrypted [Security], and copy the decrypted one */
+	l_settings_remove_group(settings, "Security");
+
+	/*
+	 * Load decrypted data into existing settings. This is not how the API
+	 * is indended to be used (since this could result in duplicate groups)
+	 * but since the Security group was just removed and EncryptedSecurity
+	 * should only contain a Security group its safe to use it this way.
+	 */
+	if (!l_settings_load_from_data(settings, (const char *) decrypted,
+					elen - 16)) {
+		l_error("Could not load decrypted security group");
+		return false;
+	}
+
+done:
+	if (changed)
+		*changed =3D false;
+
+	return true;
+}
+
 struct l_settings *storage_network_open(enum security type, const char *ss=
id)
 {
 	struct l_settings *settings;
-	char *path;
+	_auto_(l_free) char *path =3D NULL;
+	_auto_(l_free) char *encrypted =3D NULL;
+	size_t elen;
+	bool changed;
 =

 	if (ssid =3D=3D NULL)
 		return NULL;
@@ -358,13 +540,37 @@ struct l_settings *storage_network_open(enum security=
 type, const char *ssid)
 	path =3D storage_get_network_file_path(type, ssid);
 	settings =3D l_settings_new();
 =

-	if (!l_settings_load_from_file(settings, path)) {
-		l_settings_free(settings);
-		settings =3D NULL;
+	if (!l_settings_load_from_file(settings, path))
+		goto error;
+
+	if (type =3D=3D SECURITY_NONE)
+		return settings;
+
+	if (!__storage_decrypt(settings, ssid, &changed))
+		goto error;
+
+	if (!changed)
+		return settings;
+
+	/* Profile never encrypted before. Encrypt and write to disk */
+	encrypted =3D storage_encrypt(settings, ssid, &elen);
+	if (!encrypted) {
+		l_error("Could not encrypt new profile %s", ssid);
+		goto error;
 	}
 =

-	l_free(path);
+	if (write_file(encrypted, elen, false, "%s", path) < 0) {
+		l_error("Failed to write out encrypted profile");
+		goto error;
+	}
+
+	l_debug("Encrypted a new profile %s", path);
+
 	return settings;
+
+error:
+	l_settings_free(settings);
+	return NULL;
 }
 =

 int storage_network_touch(enum security type, const char *ssid)
@@ -388,15 +594,19 @@ int storage_network_touch(enum security type, const c=
har *ssid)
 void storage_network_sync(enum security type, const char *ssid,
 				struct l_settings *settings)
 {
-	char *data;
+	_auto_(l_free) char *data =3D NULL;
+	_auto_(l_free) char *path =3D NULL;
 	size_t length =3D 0;
-	char *path;
 =

 	path =3D storage_get_network_file_path(type, ssid);
-	data =3D l_settings_to_data(settings, &length);
+	data =3D storage_encrypt(settings, ssid, &length);
+
+	if (!data) {
+		l_error("Unable to sync profile %s", ssid);
+		return;
+	}
+
 	write_file(data, length, true, "%s", path);
-	l_free(data);
-	l_free(path);
 }
 =

 int storage_network_remove(enum security type, const char *ssid)
@@ -463,3 +673,12 @@ bool storage_is_file(const char *filename)
 =

 	return false;
 }
+
+/*
+ * Initialize a systemd encryption key for encrypting/decrypting credentia=
ls.
+ */
+void __storage_set_encryption_key(const uint8_t *key, size_t key_len)
+{
+	system_key =3D key;
+	system_key_len =3D key_len;
+}
diff --git a/src/storage.h b/src/storage.h
index e1ec2cd4..5e703bac 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -50,3 +50,7 @@ int storage_network_remove(enum security type, const char=
 *ssid);
 =

 struct l_settings *storage_known_frequencies_load(void);
 void storage_known_frequencies_sync(struct l_settings *known_freqs);
+
+void __storage_set_encryption_key(const uint8_t *key, size_t key_len);
+bool __storage_decrypt(struct l_settings *settings, const char *ssid,
+				bool *changed);
-- =

2.31.1

--===============1683164182211248889==--

