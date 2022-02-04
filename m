Content-Type: multipart/mixed; boundary="===============7194199325789850782=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v5 4/6] tools: add decrypt-profile tool
Date: Fri, 04 Feb 2022 13:33:29 -0800
Message-ID: <20220204213331.337524-4-prestwoj@gmail.com>
In-Reply-To: 20220204213331.337524-1-prestwoj@gmail.com

--===============7194199325789850782==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This tool will decrypt an IWD network profile which was previously
encrypted using a systemd provided key. Either a text passphrase
can be provided (--pass) or a file containing the secret (--file).

This can be useful for debugging, or recovering an encrypted
profile after enabling SystemdEncrypt.
---
 Makefile.am                 |   8 +-
 tools/iwd-decrypt-profile.c | 212 ++++++++++++++++++++++++++++++++++++
 2 files changed, 219 insertions(+), 1 deletion(-)
 create mode 100644 tools/iwd-decrypt-profile.c

v5:
 * Removed reading from stdin, --infile must be used

diff --git a/Makefile.am b/Makefile.am
index 35938d22..a0e54594 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -362,7 +362,7 @@ man_MANS +=3D wired/ead.8
 endif
 endif
 =

-noinst_PROGRAMS +=3D tools/probe-req
+noinst_PROGRAMS +=3D tools/probe-req tools/iwd-decrypt-profile
 =

 tools_probe_req_SOURCES =3D tools/probe-req.c src/mpdu.h src/mpdu.c \
 					src/ie.h src/ie.c \
@@ -372,6 +372,12 @@ tools_probe_req_SOURCES =3D tools/probe-req.c src/mpdu=
.h src/mpdu.c \
 					src/band.h src/band.c
 tools_probe_req_LDADD =3D $(ell_ldadd)
 =

+tools_iwd_decrypt_profile_SOURCES =3D tools/iwd-decrypt-profile.c \
+					src/common.h src/common.c \
+					src/crypto.h src/crypto.c \
+					src/storage.h src/storage.c
+tools_iwd_decrypt_profile_LDADD =3D ${ell_ldadd}
+
 if HWSIM
 bin_PROGRAMS +=3D tools/hwsim
 =

diff --git a/tools/iwd-decrypt-profile.c b/tools/iwd-decrypt-profile.c
new file mode 100644
index 00000000..0afd7888
--- /dev/null
+++ b/tools/iwd-decrypt-profile.c
@@ -0,0 +1,212 @@
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
+#include <fcntl.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <getopt.h>
+
+#include <ell/ell.h>
+
+#include "ell/useful.h"
+
+#include "src/storage.h"
+#include "src/common.h"
+
+static void usage(void)
+{
+	printf("decrypt-profile - Decrypt a network profile\n"
+		"Usage:\n");
+	printf("\tdecrypt-profile [--pass | --file] [OPTIONS]\n");
+	printf("\n\tEither --pass or --file must be provided. The profile\n");
+	printf("\tshould be supplied using --infile.\n");
+	printf("\tThe --ssid argument must be used if the SSID cannot be\n");
+	printf("\tinferred from the input file\n\n");
+	printf("Options:\n"
+		"\t-p, --pass             Password/key used to encrypt\n"
+		"\t-f, --file             File containing key\n"
+		"\t-s, --ssid             SSID for associated profile (will\n"
+		"\t                       be inferred from --infile if not\n"
+		"\t                       provided)\n"
+		"\t-i, --infile           Input profile\n"
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
+static bool secret_from_file(const char *file)
+{
+	int fd;
+	struct stat st;
+	void *data =3D NULL;
+
+	fd =3D open(file, O_RDONLY, 0);
+	if (fd < 0) {
+		printf("Cant open %s (%d)\n", file, fd);
+		return false;
+	}
+
+	if (fstat(fd, &st) < 0 || st.st_size =3D=3D 0) {
+		close(fd);
+		return false;
+	}
+
+	data =3D mmap(NULL, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
+	close(fd);
+
+	if (data =3D=3D MAP_FAILED)
+		return false;
+
+	__storage_set_encryption_key(data, st.st_size);
+
+	munmap(data, st.st_size);
+
+	return true;
+}
+
+int main(int argc, char *argv[])
+{
+	const char *pass =3D NULL;
+	const char *file =3D NULL;
+	const char *infile =3D NULL;
+	const char *outfile =3D NULL;
+	const char *ssid =3D NULL;
+	_auto_(l_free) char *decrypted =3D NULL;
+	_auto_(l_settings_free) struct l_settings *settings =3D NULL;
+	enum security sec;
+	int ret =3D EXIT_FAILURE;
+	ssize_t len =3D 0;
+	int r;
+
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
+			ssid =3D optarg;
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
+		printf("--file or --pass must be supplied\n\n");
+		goto usage;
+	}
+
+	if (!infile) {
+		printf("--infile must be supplied\n\n");
+		goto usage;
+	}
+
+	if (!ssid) {
+		ssid =3D storage_network_ssid_from_path(infile, &sec);
+		if (!ssid) {
+			printf("Can't get SSID from --infile, use --ssid\n\n");
+			goto usage;
+		}
+	}
+
+	settings =3D l_settings_new();
+
+	if (!l_settings_load_from_file(settings, infile)) {
+		printf("Profile is not formatted correctly\n");
+		goto failed;
+	}
+
+	if (pass)
+		__storage_set_encryption_key((const uint8_t *)pass,
+						strlen(pass));
+	else if (!secret_from_file(file))
+		goto failed;
+
+	r =3D __storage_decrypt(settings, ssid, NULL);
+	if (r < 0) {
+		printf("Unable to decrypt profile (%d)\n", r);
+		goto failed;
+	}
+
+	decrypted =3D l_settings_to_data(settings, (size_t *)&len);
+
+	if (!outfile)
+		fwrite(decrypted, 1, len, stdout);
+	else {
+		int fd =3D open(outfile, O_CREAT | O_WRONLY, S_IRUSR | S_IWUSR);
+
+		if (fd < 0) {
+			printf("Unable to open %s (%d)\n", outfile, fd);
+			close(fd);
+			goto failed;
+		}
+
+		len =3D write(fd, decrypted, len);
+
+		close(fd);
+
+		if (len < 0) {
+			printf("Unable to write to %s (%ld)\n", outfile, len);
+			goto failed;
+		}
+	}
+
+	ret =3D EXIT_SUCCESS;
+
+usage:
+	if (ret !=3D EXIT_SUCCESS)
+		usage();
+
+failed:
+	return ret;
+}
-- =

2.31.1

--===============7194199325789850782==--

