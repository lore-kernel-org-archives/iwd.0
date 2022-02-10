Content-Type: multipart/mixed; boundary="===============6658407559958106657=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v6 3/6] main: add SystemdEncrypt option, and initialize key
Date: Thu, 10 Feb 2022 11:03:17 -0800
Message-ID: <20220210190320.848755-3-prestwoj@gmail.com>
In-Reply-To: 20220210190320.848755-1-prestwoj@gmail.com

--===============6658407559958106657==
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
 src/main.c    | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/storage.c |  3 +++
 2 files changed, 74 insertions(+)

v6:
 * Use mlock/munlock on secret data as suggested on the mailing list. This
   will prevent the unencrypted secret from hitting swap space until IWD
   is done hashing it.

diff --git a/src/main.c b/src/main.c
index d0dbedc8..61c8a1b0 100644
--- a/src/main.c
+++ b/src/main.c
@@ -29,6 +29,10 @@
 #include <errno.h>
 #include <getopt.h>
 #include <signal.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
 #include <ell/ell.h>
 =

 #include <ell/useful.h>
@@ -45,6 +49,7 @@
 #include "src/storage.h"
 #include "src/anqp.h"
 #include "src/netconfig.h"
+#include "src/crypto.h"
 =

 #include "src/backtrace.h"
 =

@@ -397,6 +402,70 @@ done:
 	return r;
 }
 =

+/*
+ * Initialize a systemd encryption key for encrypting/decrypting credentia=
ls.
+ */
+static void setup_system_key(void)
+{
+	int fd;
+	struct stat st;
+	const char *cred_dir;
+	void *key =3D NULL;
+	_auto_(l_free) char *path =3D NULL;
+	_auto_(l_free) char *key_id =3D NULL;
+
+	key_id =3D l_settings_get_string(iwd_config, "General", "SystemdEncrypt");
+	if (!key_id)
+		return;
+
+	cred_dir =3D getenv("CREDENTIALS_DIRECTORY");
+	if (!cred_dir) {
+		l_warn("SystemdEncrypt enabled but CREDENTIALS_DIRECTORY not "
+			"set, check iwd.service file");
+		return;
+	}
+
+	path =3D l_strdup_printf("%s/%s", cred_dir, key_id);
+
+	if (stat(path, &st) < 0) {
+		l_warn("SystemdEncrypt enabled but could not stat %s",
+			path);
+		return;
+	}
+
+	fd =3D open(path, O_RDONLY, 0);
+	if (fd < 0) {
+		l_warn("SystemdEncrypt enabled but cannot open secret (%d)",
+				fd);
+		return;
+	}
+
+	if (fstat(fd, &st) < 0 || st.st_size =3D=3D 0) {
+		close(fd);
+		return;
+	}
+
+	key =3D mmap(NULL, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
+	if (key =3D=3D MAP_FAILED) {
+		l_warn("SystemdEncrypt enabled but can't mmap secret");
+		close(fd);
+		return;
+	}
+
+	close(fd);
+
+	if (mlock(key, st.st_size) < 0) {
+		l_warn("Failed to mlock Systemd secret file");
+		return;
+	}
+
+	__storage_set_encryption_key(key, st.st_size);
+
+	munlock(key, st.st_size);
+
+	munmap(key, st.st_size);
+}
+
 int main(int argc, char *argv[])
 {
 	int exit_status;
@@ -529,6 +598,8 @@ int main(int argc, char *argv[])
 	l_dbus_set_disconnect_handler(dbus, dbus_disconnected, NULL, NULL);
 	dbus_init(dbus);
 =

+	setup_system_key();
+
 	exit_status =3D l_main_run_with_signal(signal_handler, NULL);
 =

 	iwd_modules_exit();
diff --git a/src/storage.c b/src/storage.c
index f5c89604..1131ee8f 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -234,6 +234,9 @@ void storage_cleanup_dirs(void)
 {
 	l_free(storage_path);
 	l_free(storage_hotspot_path);
+
+	if (system_key_set)
+		explicit_bzero(system_key, sizeof(system_key));
 }
 =

 char *storage_get_path(const char *format, ...)
-- =

2.34.1

--===============6658407559958106657==--

