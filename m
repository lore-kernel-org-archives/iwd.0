Content-Type: multipart/mixed; boundary="===============1764388289159474458=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v4 3/7] main: add SystemdEncrypt option, and initialize key
Date: Fri, 04 Feb 2022 09:31:16 -0800
Message-ID: <20220204173120.231730-3-prestwoj@gmail.com>
In-Reply-To: 20220204173120.231730-1-prestwoj@gmail.com

--===============1764388289159474458==
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
 src/main.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/src/main.c b/src/main.c
index d0dbedc8..a345c950 100644
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

@@ -397,6 +402,63 @@ done:
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
+	__storage_set_encryption_key(key, st.st_size);
+
+	munmap(key, st.st_size);
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

--===============1764388289159474458==--

