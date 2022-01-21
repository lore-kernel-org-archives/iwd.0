Content-Type: multipart/mixed; boundary="===============8479819010841802797=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [RFC 1/2] main: add SystemdEncrypt option, and initialize key
Date: Thu, 20 Jan 2022 16:41:29 -0800
Message-ID: <20220121004130.2473281-2-prestwoj@gmail.com>
In-Reply-To: 20220121004130.2473281-1-prestwoj@gmail.com

--===============8479819010841802797==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Recently systemd added the ability to pass secret credentials to
services via LoadCredentialEncrypted/SetCredentialEncrypted. Once
set up the service is able to read the decrypted credentials from
a file. The file path is found in the environment variable
CREDENTIALS_DIRECTORY + an identifier. The ID used by IWD is
iwd-secret, and the service file should be configured as such.

A new boolean option was added to main.conf: SystemdEncrypt.
When true IWD will attempt to read the decrypted secret from
systemd. If at any point this fails warnings will be printed but
IWD will continue normally. Its expected that any failures will
result in the inability to connect to any networks which have
previously encrypted the passphrase/PSK without re-entering
the passphrase manually. This could happen, for example, if the
systemd secret was changed.

Once the secret is read in, it is hashed, and made available to
modules via iwd_get_system_key(). This can be used as a key
to encrypt sensitive data IWD stores on disk such as the network
PSK/passphrase, EAP credentials etc.
---
 src/iwd.h  |  1 +
 src/main.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/src/iwd.h b/src/iwd.h
index 1be20df3..4aa792de 100644
--- a/src/iwd.h
+++ b/src/iwd.h
@@ -33,6 +33,7 @@ struct l_genl_family;
 const struct l_settings *iwd_get_config(void);
 struct l_genl *iwd_get_genl(void);
 struct l_netlink *iwd_get_rtnl(void);
+const unsigned char *iwd_get_system_key(size_t *len);
 =

 void netdev_shutdown(void);
 =

diff --git a/src/main.c b/src/main.c
index d0dbedc8..c0b8b7c3 100644
--- a/src/main.c
+++ b/src/main.c
@@ -29,6 +29,7 @@
 #include <errno.h>
 #include <getopt.h>
 #include <signal.h>
+#include <sys/stat.h>
 #include <ell/ell.h>
 =

 #include <ell/useful.h>
@@ -60,6 +61,7 @@ static const char *debugopt;
 static bool developeropt;
 static bool terminating;
 static bool nl80211_complete;
+static unsigned char system_key[32];
 =

 static void main_loop_quit(struct l_timeout *timeout, void *user_data)
 {
@@ -130,6 +132,16 @@ const char *iwd_get_phy_blacklist(void)
 	return nophys;
 }
 =

+const unsigned char *iwd_get_system_key(size_t *len)
+{
+	if (l_memeqzero(system_key, sizeof(system_key)))
+		return NULL;
+
+	*len =3D sizeof(system_key);
+
+	return system_key;
+}
+
 bool iwd_is_developer_mode(void)
 {
 	return developeropt;
@@ -397,6 +409,56 @@ done:
 	return r;
 }
 =

+/*
+ * Initialize a systemd encryption key for encrypting/decrypting credentia=
ls.
+ * IWD expects a key ID of "iwd-secret". Creating this key is left up to t=
he
+ * user/systemd.
+ */
+static void setup_system_key(void)
+{
+	bool enabled;
+	_auto_(l_free) char *path =3D NULL;
+	const char *cred_dir;
+	ssize_t len;
+	struct stat st;
+	_auto_(l_free) uint8_t *key =3D NULL;
+	struct l_checksum *sha;
+
+	if (!l_settings_get_bool(iwd_config, "General", "SystemdEncrypt",
+					&enabled) || !enabled)
+		return;
+
+	cred_dir =3D getenv("CREDENTIALS_DIRECTORY");
+	if (!cred_dir) {
+		l_warn("SystemdEncrypt enabled, but CREDENTIALS_DIRECTORY not "
+			"set, check iwd.service file");
+		return;
+	}
+
+	path =3D l_strdup_printf("%s/iwd-secret", cred_dir);
+
+	if (stat(path, &st) < 0) {
+		l_warn("SystemdEncrypt enabled, but could not stat %s",
+			path);
+		return;
+	}
+
+	key =3D l_malloc(st.st_size);
+
+	len =3D read_file(key, st.st_size, "%s", path);
+	if (len < 0) {
+		l_warn("SystemdEncrypt enabled, but reading %s failed (%ld)",
+			path, len);
+		return;
+	}
+
+	sha =3D l_checksum_new(L_CHECKSUM_SHA256);
+
+	l_checksum_update(sha, key, st.st_size);
+	l_checksum_get_digest(sha, system_key, sizeof(system_key));
+	l_checksum_free(sha);
+}
+
 int main(int argc, char *argv[])
 {
 	int exit_status;
@@ -529,6 +591,8 @@ int main(int argc, char *argv[])
 	l_dbus_set_disconnect_handler(dbus, dbus_disconnected, NULL, NULL);
 	dbus_init(dbus);
 =

+	setup_system_key();
+
 	exit_status =3D l_main_run_with_signal(signal_handler, NULL);
 =

 	iwd_modules_exit();
-- =

2.31.1

--===============8479819010841802797==--

