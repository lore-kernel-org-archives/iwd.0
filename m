Content-Type: multipart/mixed; boundary="===============5430868384370509672=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 3/5] tools: add decrypt-profile tool
Date: Wed, 02 Feb 2022 10:47:42 -0800
Message-ID: <20220202184744.1954-3-prestwoj@gmail.com>
In-Reply-To: 20220202184744.1954-1-prestwoj@gmail.com

--===============5430868384370509672==
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
 tools/decrypt-profile.c | 232 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 239 insertions(+), 1 deletion(-)
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
index 00000000..80942dc6
--- /dev/null
+++ b/tools/decrypt-profile.c
@@ -0,0 +1,232 @@
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
+#include <stdio.h>
+#include <unistd.h>
+#include <libgen.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <sys/stat.h>
+#include <ell/ell.h>
+
+#include "ell/useful.h"
+
+#include "src/storage.h"
+
+static void usage(void)
+{
+	printf("decrypt-profile - Decrypt a network profile\n"
+		"Usage:\n");
+	printf("\tdecrypt-profile [--pass | --file] [OPTIONS]\n");
+	printf("\n\tEither --pass or --file must be provided. The profile\n");
+	printf("\twill be read from stdin or from --infile.\n");
+	printf("\tThe --ssid argument must be used if the SSID cannot be\n");
+	printf("\tinferred from the input file\n\n");
+	printf("Options:\n"
+		"\t-p, --pass             Password/key used to encrypt\n"
+		"\t-f, --file             File containing key\n"
+		"\t-s, --ssid             SSID for associated profile (will\n"
+		"\t                       be inferred from --infile if not\n"
+		"\t                       provided)\n"
+		"\t-i, --infile           Input profile (if stdin is not used)\n"
+		"\t-o, --outfile          Output file for decrypted profile\n"
+		"\t-h, --help             Show help options\n");
+	printf("\n");
+}
+
+static const struct option main_options[] =3D {
+	{ "pass", required_argument,       NULL, 'p' },
+	{ "file", required_argument,       NULL, 'f' },
+	{ "infile", required_argument,     NULL, 'i' },
+	{ "outfile", required_argument,    NULL, 'o' },
+	{ "ssid", required_argument,       NULL, 's' },
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
+	const char *infile =3D NULL;
+	const char *outfile =3D NULL;
+	_auto_(l_free) char *ssid =3D NULL;
+	_auto_(l_free) char *decrypted =3D NULL;
+	_auto_(l_settings_free) struct l_settings *settings =3D NULL;
+	_auto_(l_free) uint8_t *secret =3D NULL;
+	size_t secret_len =3D 0;
+	int ret =3D EXIT_FAILURE;
+	char profile[BUFSIZ];
+	ssize_t len =3D 0;
+	char *line;
+
+	if (isatty(0))
+		goto done_reading;
+
+	while ((line =3D fgets(profile + len, sizeof(profile) - len, stdin)))
+		len +=3D strlen(profile + len);
+
+done_reading:
+	for (;;) {
+		int opt;
+
+		opt =3D getopt_long(argc, argv, "pfhio",
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
+		case 'i':
+			infile =3D optarg;
+			break;
+		case 'o':
+			outfile =3D optarg;
+			break;
+		case 's':
+			ssid =3D l_strdup(optarg);
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
+	if (!len && !infile) {
+		printf("No input file (use stdin or --infile)\n\n");
+		usage();
+		goto failed;
+	}
+
+	if (len && infile) {
+		printf("Use only stdin or --infile for input profile\n\n");
+		usage();
+		goto failed;
+	}
+
+	if (infile) {
+		/* Try and detect SSID from input file */
+		if (!ssid) {
+			char *dot;
+
+			ssid =3D l_strdup(basename((char *)infile));
+			/* remove extension */
+			dot =3D strchr(ssid, '.');
+			if (!dot)
+				goto no_ssid;
+
+			*dot =3D '\0';
+		}
+
+		len =3D read_file(profile, sizeof(profile), "%s", infile);
+		if (len < 0) {
+			printf("Could not read from %s (%ld)\n", infile, len);
+			goto failed;
+		}
+	}
+
+	if (!ssid) {
+no_ssid:
+		printf("Can't detect SSID from input source (use --ssid)\n");
+		goto failed;
+	}
+
+	if (pass) {
+		secret_len =3D strlen(pass);
+		secret =3D l_memdup(pass, secret_len);
+	} else
+		secret =3D secret_from_file(file, &secret_len);
+
+	__storage_set_encryption_key(secret, secret_len);
+
+	settings =3D l_settings_new();
+
+	if (!l_settings_load_from_data(settings, profile, len)) {
+		printf("Profile is not formatted correctly\n");
+		goto failed;
+	}
+
+	if (!__storage_decrypt(settings, ssid, NULL)) {
+		printf("Unable to decrypt profile\n");
+		goto failed;
+	}
+
+	decrypted =3D l_settings_to_data(settings, (size_t *)&len);
+
+	if (!outfile)
+		printf("%s\n", decrypted);
+	else {
+		int fd =3D open(outfile, O_CREAT | O_WRONLY, S_IRUSR | S_IWUSR);
+
+		if (fd < 0) {
+			printf("Unable to open %s (%d)\n\n", outfile, fd);
+			close(fd);
+			goto failed;
+		}
+
+		len =3D write(fd, decrypted, len);
+
+		close(fd);
+
+		if (len < 0) {
+			printf("Unable to write to %s (%ld)\n\n", outfile, len);
+			goto failed;
+		}
+	}
+
+	ret =3D EXIT_SUCCESS;
+
+failed:
+	return ret;
+}
-- =

2.31.1

--===============5430868384370509672==--

