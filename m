Content-Type: multipart/mixed; boundary="===============0605067319251551538=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v4 1/7] storage: implement network profile encryption
Date: Fri, 04 Feb 2022 09:31:14 -0800
Message-ID: <20220204173120.231730-1-prestwoj@gmail.com>

--===============0605067319251551538==
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

A few private storage.c helpers were added to serve several purposes:

__storage_set_encryption_key():
This sets the encryption key direct from systemd then uses extract and expa=
nd
to create a new fixed length key to do encryption/decryption.

__storage_decrypt():
Low level API to decrypt an l_settings object using a previously set key and
the SSID/name for the network. This returns a 'changed' out parameter signi=
fying
that the settings need to be encrypted and re-written to disk. The purpose =
of
exposing this is for a standalone decryption tool which does not re-write a=
ny
settings.

__storage_open():
Wrapper around __storage_decrypt() that handles re-writing a new profile to
disk. This was exposed in order to support hotspot profiles.

__storage_encrypt():
Encrypts an l_settings object and returns the full profile as data
---
 Makefile.am   |   3 +-
 src/storage.c | 279 ++++++++++++++++++++++++++++++++++++++++++++++++--
 src/storage.h |   8 ++
 3 files changed, 278 insertions(+), 12 deletions(-)

v4:
 * Made settings const in __storage_encrypt
 * Remove all encryptable settings before loading decrypted ones

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
index 4b89c615..f5c89604 100644
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
+static uint8_t system_key[32];
+static bool system_key_set =3D false;
 =

 static int create_dirs(const char *filename)
 {
@@ -347,24 +351,254 @@ const char *storage_network_ssid_from_path(const cha=
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
+char *__storage_encrypt(const struct l_settings *settings, const char *ssi=
d,
+				size_t *out_len)
+{
+	struct iovec ad[2];
+	uint8_t salt[32];
+	size_t len;
+	_auto_(l_settings_free) struct l_settings *to_encrypt =3D NULL;
+	_auto_(l_settings_free) struct l_settings *original =3D NULL;
+	_auto_(l_free) char *plaintext =3D NULL;
+	_auto_(l_free) uint8_t *enc =3D NULL;
+	_auto_(l_strv_free) char **groups =3D NULL;
+	char **i;
+
+	if (!system_key_set || !l_settings_has_group(settings, "Security"))
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
+	if (!aes_siv_encrypt(system_key, sizeof(system_key), plaintext, len,
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
+int __storage_decrypt(struct l_settings *settings, const char *ssid,
+				bool *changed)
+{
+	_auto_(l_settings_free) struct l_settings *security =3D NULL;
+	_auto_(l_free) uint8_t *encrypted =3D NULL;
+	_auto_(l_free) uint8_t *decrypted =3D NULL;
+	_auto_(l_free) uint8_t *salt =3D NULL;
+	_auto_(l_strv_free) char **embedded =3D NULL;
+	_auto_(l_strv_free) char **groups =3D NULL;
+	char **i;
+	size_t elen, slen;
+	struct iovec ad[2];
+
+	if (!system_key_set)
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
+			return -EBADMSG;
+		}
+
+		if (changed)
+			*changed =3D true;
+
+		return 0;
+	}
+
+	decrypted =3D l_malloc(elen - 16 + 1);
+
+	ad[0].iov_base =3D (void *)salt;
+	ad[0].iov_len =3D slen;
+	ad[1].iov_base =3D (void *)ssid;
+	ad[1].iov_len =3D strlen(ssid);
+
+	if (!aes_siv_decrypt(system_key, sizeof(system_key), encrypted, elen,
+				ad, 2, decrypted)) {
+		l_error("Could not decrypt %s profile, did the secret change?",
+				ssid);
+		return -ENOKEY;
+	}
+
+	decrypted[elen - 16] =3D '\0';
+
+	/*
+	 * Remove any groups that are marked as encrypted (plus embedded),
+	 * and copy the decrypted groups back into settings.
+	 */
+	groups =3D l_settings_get_groups(settings);
+	for (i =3D groups; *i; i++) {
+		if (encrypt_group(*i))
+			l_settings_remove_group(settings, *i);
+	}
+
+	l_settings_remove_embedded_groups(settings);
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
+		return -EBADMSG;
+	}
+
+done:
+	if (changed)
+		*changed =3D false;
+
+	return 0;
+}
+
+/*
+ * Direct open() by path. 'name' is used for decryption and depends on the
+ * module calling. For regular storage operations 'name' is the SSID. For
+ * hotspot 'name' is the consortium name (since the SSID is not always the
+ * same).
+ */
+bool __storage_open(struct l_settings *settings, const char *path,
+			enum security type, const char *name)
+{
+	bool changed;
+	_auto_(l_free) char *encrypted =3D NULL;
+	size_t elen;
+
+	if (type =3D=3D SECURITY_NONE)
+		return true;
+
+	if (__storage_decrypt(settings, name, &changed) < 0)
+		return false;
+
+	if (!changed)
+		return true;
+
+	/* Profile never encrypted before. Encrypt and write to disk */
+	encrypted =3D __storage_encrypt(settings, name, &elen);
+	if (!encrypted) {
+		l_error("Could not encrypt new profile %s", name);
+		return false;
+	}
+
+	if (write_file(encrypted, elen, false, "%s", path) < 0) {
+		l_error("Failed to write out encrypted profile");
+		return false;
+	}
+
+	l_debug("Encrypted a new profile %s", path);
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
 =

 	if (ssid =3D=3D NULL)
 		return NULL;
 =

 	path =3D storage_get_network_file_path(type, ssid);
+
 	settings =3D l_settings_new();
 =

-	if (!l_settings_load_from_file(settings, path)) {
-		l_settings_free(settings);
-		settings =3D NULL;
-	}
+	if (!l_settings_load_from_file(settings, path))
+		goto error;
+
+	if (!__storage_open(settings, path, type, ssid))
+		goto error;
 =

-	l_free(path);
 	return settings;
+
+error:
+	l_settings_free(settings);
+	return NULL;
 }
 =

 int storage_network_touch(enum security type, const char *ssid)
@@ -388,15 +622,19 @@ int storage_network_touch(enum security type, const c=
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
+	data =3D __storage_encrypt(settings, ssid, &length);
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
@@ -463,3 +701,22 @@ bool storage_is_file(const char *filename)
 =

 	return false;
 }
+
+/*
+ * Initialize a systemd encryption key for encrypting/decrypting credentia=
ls.
+ * This uses the 'extract and expand' concept from RFC 5869 to derive a ne=
w,
+ * fixed length, key.
+ */
+void __storage_set_encryption_key(const uint8_t *key, size_t key_len)
+{
+	uint8_t tmp[32];
+
+	if (!hkdf_extract(L_CHECKSUM_SHA256, NULL, 0, 1, tmp, key, key_len))
+		return;
+
+	if (!hkdf_expand(L_CHECKSUM_SHA256, tmp, sizeof(tmp), "IWD System Key",
+				system_key, sizeof(system_key)))
+		return;
+
+	system_key_set =3D true;
+}
diff --git a/src/storage.h b/src/storage.h
index e1ec2cd4..14d81f0a 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -50,3 +50,11 @@ int storage_network_remove(enum security type, const cha=
r *ssid);
 =

 struct l_settings *storage_known_frequencies_load(void);
 void storage_known_frequencies_sync(struct l_settings *known_freqs);
+
+void __storage_set_encryption_key(const uint8_t *key, size_t key_len);
+int __storage_decrypt(struct l_settings *settings, const char *ssid,
+				bool *changed);
+char *__storage_encrypt(const struct l_settings *settings, const char *ssi=
d,
+				size_t *out_len);
+bool __storage_open(struct l_settings *settings, const char *path,
+			enum security type, const char *name);
-- =

2.31.1

--===============0605067319251551538==--

