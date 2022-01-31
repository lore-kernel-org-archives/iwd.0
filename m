Content-Type: multipart/mixed; boundary="===============3082310982050039314=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/5] main: add SystemdEncrypt option, and initialize key
Date: Mon, 31 Jan 2022 12:11:52 -0800
Message-ID: <20220131201155.3878756-2-prestwoj@gmail.com>
In-Reply-To: 20220131201155.3878756-1-prestwoj@gmail.com

--===============3082310982050039314==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Recently systemd added the ability to pass secret credentials to
services via LoadCredentialEncrypted/SetCredentialEncrypted. Once
set up the service is able to read the decrypted credentials from
a file. The file path is found in the environment variable
CREDENTIALS_DIRECTORY + an identifier. The value of SystemdEncrypt
should be set to the systemd key ID used when the credential was
created.

When SystemdEncrypt is set IWD will attempt to read the decrypted
secret from systemd. If at any point this fails warnings will be
printed but IWD will continue normally. Its expected that any failures
will result in the inability to connect to any networks which have
previously encrypted the passphrase/PSK without re-entering
the passphrase manually. This could happen, for example, if the
systemd secret was changed.

Once the secret is read in it is set into storage to be used for
profile encryption/decryption.
---
 src/main.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/src/main.c b/src/main.c
index d0dbedc8..a61da7cc 100644
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
@@ -397,6 +398,49 @@ done:
 	return r;
 }
 =

+/*
+ * Initialize a systemd encryption key for encrypting/decrypting credentia=
ls.
+ */
+static void setup_system_key(void)
+{
+	const char *cred_dir;
+	ssize_t len;
+	struct stat st;
+	_auto_(l_free) char *path =3D NULL;
+	_auto_(l_free) uint8_t *key =3D NULL;
+	_auto_(l_free) char *key_id =3D NULL;
+
+	key_id =3D l_settings_get_string(iwd_config, "General", "SystemdEncrypt");
+	if (!key_id)
+		return;
+
+	cred_dir =3D getenv("CREDENTIALS_DIRECTORY");
+	if (!cred_dir) {
+		l_warn("SystemdEncrypt enabled, but CREDENTIALS_DIRECTORY not "
+			"set, check iwd.service file");
+		return;
+	}
+
+	path =3D l_strdup_printf("%s/%s", cred_dir, key_id);
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
+	__storage_set_encryption_key(key, st.st_size);
+}
+
 int main(int argc, char *argv[])
 {
 	int exit_status;
@@ -529,6 +573,8 @@ int main(int argc, char *argv[])
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

--===============3082310982050039314==--

