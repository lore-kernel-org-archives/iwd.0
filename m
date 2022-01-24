Content-Type: multipart/mixed; boundary="===============0870329779012300108=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [RFCv2 3/3] tools: add decrypt-profile tool
Date: Mon, 24 Jan 2022 11:49:36 -0800
Message-ID: <20220124194936.2988442-4-prestwoj@gmail.com>
In-Reply-To: 20220124194936.2988442-1-prestwoj@gmail.com

--===============0870329779012300108==
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
 tools/decrypt-profile.c | 201 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 208 insertions(+), 1 deletion(-)
 create mode 100644 tools/decrypt-profile.c

diff --git a/Makefile.am b/Makefile.am
index 89c053a6..348729c8 100644
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
+					src/storage.h src/storage.c \
+					src/crypto.h src/crypto.c
+tools_decrypt_profile_LDADD =3D ${ell_ldadd}
+
 if HWSIM
 bin_PROGRAMS +=3D tools/hwsim
 =

diff --git a/tools/decrypt-profile.c b/tools/decrypt-profile.c
new file mode 100644
index 00000000..328ac4cf
--- /dev/null
+++ b/tools/decrypt-profile.c
@@ -0,0 +1,201 @@
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
+	printf("\tdecrypt-profile <profile> [--pass | --file]\n");
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
+	{ "help", no_argument,             NULL, 'h' },
+	{ }
+};
+
+static bool do_hash(const uint8_t *data, size_t len, uint8_t hash[static 3=
2])
+{
+	struct l_checksum *sha =3D l_checksum_new(L_CHECKSUM_SHA256);
+
+	l_checksum_update(sha, data, len);
+	l_checksum_get_digest(sha, hash, 32);
+	l_checksum_free(sha);
+
+	return true;
+}
+
+static bool hash_file_key(const char *file, uint8_t hash[static 32])
+{
+	_auto_ (l_free) uint8_t *key =3D NULL;
+	struct stat st;
+
+	if (stat(file, &st) < 0)
+		return false;
+
+	key =3D l_malloc(st.st_size);
+
+	if (read_file(key, st.st_size, "%s", file) < 0)
+		return false;
+
+	return do_hash(key, st.st_size, hash);
+}
+
+static bool hash_pass_key(const char *pass, uint8_t hash[static 32])
+{
+	return do_hash((const uint8_t *) pass, strlen(pass), hash);
+}
+
+int main(int argc, char *argv[])
+{
+	const char *pass =3D NULL;
+	const char *file =3D NULL;
+	const char *ssid;
+	const char *profile;
+	enum security security;
+	_auto_(l_settings_free) struct l_settings *settings =3D NULL;
+	_auto_(l_free) uint8_t *salt =3D NULL;
+	_auto_(l_free) uint8_t *enc =3D NULL;
+	_auto_(l_free) char *dec =3D NULL;
+	size_t slen, elen;
+	uint8_t key_hash[32];
+	struct iovec ad[2];
+	int ret =3D EXIT_FAILURE;
+
+	l_log_set_stderr();
+	l_debug_enable("*");
+	storage_create_dirs();
+
+	if (argc !=3D 4) {
+		usage();
+		goto failed;
+	}
+
+	for (;;) {
+		int opt;
+
+		opt =3D getopt_long(argc - 1, argv + 1, "pfh",
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
+	profile =3D argv[1];
+
+	ssid =3D storage_network_ssid_from_path(profile, &security);
+	if (!ssid) {
+		l_error("Could not locate profile %s", profile);
+		goto failed;
+	}
+
+	settings =3D storage_network_open(security, ssid);
+	if (!settings) {
+		l_error("Could not open profile %s", profile);
+		goto failed;
+	}
+
+	salt =3D l_settings_get_bytes(settings, "Security",
+					"EncryptedSalt", &slen);
+	if (!salt) {
+		l_error("Profile %s is not encrypted (no EncryptedSalt)",
+				profile);
+		goto failed;
+	}
+
+	enc =3D l_settings_get_bytes(settings, "Security",
+					"EncryptedSecurity", &elen);
+	if (!enc) {
+		l_error("Profile %s is not encrpyted (no EncryptedSecurity)",
+				profile);
+		goto failed;
+	}
+
+	if (pass) {
+		if (!hash_pass_key(pass, key_hash)) {
+			l_error("Failed to hash password");
+			goto failed;
+		}
+	} else {
+		if (!hash_file_key(file, key_hash)) {
+			l_error("Failed to hash key file");
+			goto failed;
+		}
+	}
+
+	ad[0].iov_base =3D salt;
+	ad[0].iov_len =3D slen;
+	ad[1].iov_base =3D (void *) ssid;
+	ad[1].iov_len =3D strlen(ssid);
+
+	dec =3D l_malloc(elen - 16 + 1);
+
+	if (!aes_siv_decrypt(key_hash, 32, enc, elen, ad, 2, dec)) {
+		l_error("Failed to decrypt %s", profile);
+		goto failed;
+	}
+
+	dec[elen - 16] =3D '\0';
+
+	l_info("Decrypted Profile:\n\n%s", dec);
+
+	ret =3D EXIT_SUCCESS;
+
+failed:
+	storage_cleanup_dirs();
+	return ret;
+}
-- =

2.31.1

--===============0870329779012300108==--

