Content-Type: multipart/mixed; boundary="===============6296398212162890122=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/5] tools: add decrypt-profile tool
Date: Mon, 31 Jan 2022 12:11:53 -0800
Message-ID: <20220131201155.3878756-3-prestwoj@gmail.com>
In-Reply-To: 20220131201155.3878756-1-prestwoj@gmail.com

--===============6296398212162890122==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This tool will decrypt an IWD network profile which was previously
encrypted using a systemd provided key. Either a text passphrase
can be provided (--pass) or a file containing the secret (--file).

This can be useful for debugging, or recovering an encrypted
profile after enabling SystemdEncrypt.
---
 Makefile.am             |   8 +-
 tools/decrypt-profile.c | 163 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 170 insertions(+), 1 deletion(-)
 create mode 100644 tools/decrypt-profile.c

diff --git a/Makefile.am b/Makefile.am
index 35938d22..a106b56f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -362,7 +362,7 @@ man_MANS +=3D wired/ead.8
 endif
 endif
 =

-noinst_PROGRAMS +=3D tools/probe-req
+noinst_PROGRAMS +=3D tools/probe-req tools/decrypt-profile
 =

 tools_probe_req_SOURCES =3D tools/probe-req.c src/mpdu.h src/mpdu.c \
 					src/ie.h src/ie.c \
@@ -372,6 +372,12 @@ tools_probe_req_SOURCES =3D tools/probe-req.c src/mpdu=
.h src/mpdu.c \
 					src/band.h src/band.c
 tools_probe_req_LDADD =3D $(ell_ldadd)
 =

+tools_decrypt_profile_SOURCES =3D tools/decrypt-profile.c \
+					src/common.h src/common.c \
+					src/crypto.h src/crypto.c \
+					src/storage.h src/storage.c
+tools_decrypt_profile_LDADD =3D ${ell_ldadd}
+
 if HWSIM
 bin_PROGRAMS +=3D tools/hwsim
 =

diff --git a/tools/decrypt-profile.c b/tools/decrypt-profile.c
new file mode 100644
index 00000000..7247ea35
--- /dev/null
+++ b/tools/decrypt-profile.c
@@ -0,0 +1,163 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2022  Intel Corporation. All rights reserved.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#include <getopt.h>
+#include <stdio.h>
+#include <sys/stat.h>
+#include <ell/ell.h>
+
+#include "ell/useful.h"
+
+#include "src/storage.h"
+#include "src/common.h"
+#include "src/crypto.h"
+
+static void usage(void)
+{
+	printf("decrypt-profile - Decrypt a network profile\n"
+		"Usage:\n");
+	printf("\tdecrypt-profile <file> [--pass | --file]\n");
+	printf("\n\tEither --pass or --file must be provided\n");
+	printf("Options:\n"
+		"\t-p, --pass             Password/key used to encrypt\n"
+		"\t-f, --file             File containing key\n"
+		"\t-h, --help             Show help options\n");
+}
+
+static const struct option main_options[] =3D {
+	{ "pass", required_argument,       NULL, 'p' },
+	{ "file", required_argument,       NULL, 'f' },
+	{ "debug", no_argument,            NULL, 'd' },
+	{ "help", no_argument,             NULL, 'h' },
+	{ }
+};
+
+static uint8_t *secret_from_file(const char *file, size_t *len)
+{
+	uint8_t *key;
+	struct stat st;
+
+	if (stat(file, &st) < 0)
+		return NULL;
+
+	key =3D l_malloc(st.st_size);
+
+	if (read_file(key, st.st_size, "%s", file) < 0) {
+		l_free(key);
+		return NULL;
+	}
+
+	*len =3D st.st_size;
+
+	return key;
+}
+
+int main(int argc, char *argv[])
+{
+	const char *pass =3D NULL;
+	const char *file =3D NULL;
+	bool debug =3D false;
+	const char *ssid;
+	const char *profile;
+	enum security security;
+	_auto_(l_free) char *decrypted =3D NULL;
+	_auto_(l_settings_free) struct l_settings *settings =3D NULL;
+	_auto_(l_free) uint8_t *secret =3D NULL;
+	size_t secret_len =3D 0;
+	int ret =3D EXIT_FAILURE;
+
+	if (argc > 5) {
+		usage();
+		goto failed;
+	}
+
+	for (;;) {
+		int opt;
+
+		opt =3D getopt_long(argc - 1, argv + 1, "pfhd",
+					main_options, NULL);
+		if (opt < 0)
+			break;
+
+		switch (opt) {
+		case 'p':
+			pass =3D optarg;
+			break;
+		case 'f':
+			file =3D optarg;
+			break;
+		case 'd':
+			debug =3D true;
+			break;
+		case 'h':
+			usage();
+			return EXIT_SUCCESS;
+		default:
+			goto failed;
+		}
+	}
+
+	if (!file && !pass) {
+		usage();
+		goto failed;
+	}
+
+	if (debug)
+		l_debug_enable("*");
+
+	l_log_set_stderr();
+
+	if (!storage_create_dirs())
+		return EXIT_FAILURE;
+
+	if (pass) {
+		secret_len =3D strlen(pass);
+		secret =3D l_memdup(pass, secret_len);
+	} else
+		secret =3D secret_from_file(file, &secret_len);
+
+	profile =3D argv[1];
+
+	ssid =3D storage_network_ssid_from_path(profile, &security);
+	if (!ssid) {
+		l_error("Could not locate profile %s", profile);
+		goto failed;
+	}
+
+	__storage_set_encryption_key(secret, secret_len);
+
+	settings =3D storage_network_open(security, ssid);
+	if (!settings) {
+		l_error("Could not open profile %s", profile);
+		goto failed;
+	}
+
+	decrypted =3D l_settings_to_data(settings, NULL);
+
+	l_info("%s", decrypted);
+
+	ret =3D EXIT_SUCCESS;
+
+failed:
+	storage_cleanup_dirs();
+	return ret;
+}
-- =

2.31.1

--===============6296398212162890122==--

