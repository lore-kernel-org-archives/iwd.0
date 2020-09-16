Content-Type: multipart/mixed; boundary="===============6067881456641002687=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/6] plugins: remove dependency on ELL plugins
Date: Wed, 16 Sep 2020 12:39:40 -0700
Message-ID: <20200916193945.683476-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6067881456641002687==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There has been a desire to remove the ELL plugin dependency from
IWD which is the only consumer of the plugin API. This removes
the dependency and prepares the tree for converting the existing
ofono plugin into a regular module.

sim_hardcoded was removed completely. This was originall implemented
before full ofono support purely to test the IWD side of EAP-SIM/AKA.
Since the ofono plugin (module-to-be) is now fully implemented there
really isn't a need for sim_hardcoded.
---
 Makefile.am              |   8 +-
 bootstrap-configure      |   1 -
 configure.ac             |   5 -
 plugins/sim_hardcoded.c  | 399 ---------------------------------------
 src/main.c               |  16 --
 {plugins =3D> src}/ofono.c |   0
 6 files changed, 1 insertion(+), 428 deletions(-)
 delete mode 100644 plugins/sim_hardcoded.c
 rename {plugins =3D> src}/ofono.c (100%)

-v2:
 * Removed sim_hardcoded all together

diff --git a/Makefile.am b/Makefile.am
index 5f16920f..d85d3470 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -185,7 +185,6 @@ if DAEMON
 libexec_PROGRAMS +=3D src/iwd
 =

 src_iwd_SOURCES =3D src/main.c linux/nl80211.h src/iwd.h src/missing.h \
-					src/plugin.h src/plugin.c \
 					src/netdev.h src/netdev.c \
 					src/wiphy.h src/wiphy.c \
 					src/device.c \
@@ -235,14 +234,9 @@ src_iwd_SOURCES =3D src/main.c linux/nl80211.h src/iwd=
.h src/missing.h \
 src_iwd_LDADD =3D $(ell_ldadd) -ldl
 src_iwd_DEPENDENCIES =3D $(ell_dependencies)
 =

-if SIM_HARDCODED
-builtin_modules +=3D sim_hardcoded
-builtin_sources +=3D plugins/sim_hardcoded.c
-endif
-
 if OFONO
 builtin_modules +=3D ofono
-builtin_sources +=3D plugins/ofono.c
+builtin_sources +=3D src/ofono.c
 endif
 =

 if DBUS_POLICY
diff --git a/bootstrap-configure b/bootstrap-configure
index 195f2e48..7b907a28 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -13,6 +13,5 @@ fi
 		--enable-hwsim \
 		--enable-tools \
 		--enable-ofono \
-		--enable-sim-hardcoded \
 		--disable-dbus-policy \
 		--disable-systemd-service $*
diff --git a/configure.ac b/configure.ac
index bf7e94df..78db15e9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -291,11 +291,6 @@ AC_ARG_ENABLE([ofono], AC_HELP_STRING([--enable-ofono],
 					[enable_ofono=3D${enableval}])
 AM_CONDITIONAL(OFONO, test "${enable_ofono}" =3D "yes")
 =

-AC_ARG_ENABLE([sim_hardcoded], AC_HELP_STRING([--enable-sim-hardcoded],
-				[enable hard coded SIM keys]),
-					[enable_sim_hardcoded=3D${enableval}])
-AM_CONDITIONAL(SIM_HARDCODED, test "${enable_sim_hardcoded}" =3D "yes")
-
 AC_CONFIG_FILES(Makefile)
 =

 AC_OUTPUT
diff --git a/plugins/sim_hardcoded.c b/plugins/sim_hardcoded.c
deleted file mode 100644
index 463c39fe..00000000
--- a/plugins/sim_hardcoded.c
+++ /dev/null
@@ -1,399 +0,0 @@
-/*
- *
- *  Wireless daemon for Linux
- *
- *  Copyright (C) 2017-2019  Intel Corporation. All rights reserved.
- *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <errno.h>
-
-#include <ell/ell.h>
-#include <ell/plugin.h>
-
-#include "src/simauth.h"
-
-struct hardcoded_sim {
-	char *identity;
-	uint8_t sim_supported;
-	uint8_t kc[NUM_RANDS_MAX][EAP_SIM_KC_LEN];
-	uint8_t sres[NUM_RANDS_MAX][EAP_SIM_SRES_LEN];
-	uint8_t aka_supported;
-	uint8_t ki[EAP_AKA_KI_LEN];
-	uint8_t opc[EAP_AKA_OPC_LEN];
-	uint8_t amf[EAP_AKA_AMF_LEN];
-	uint8_t sqn[EAP_AKA_SQN_LEN];
-	struct iwd_sim_auth *auth;
-};
-
-static struct hardcoded_sim *sim;
-
-/*
- * Helper to XOR an array
- * to - result of XOR array
- * a - array 1
- * b - array 2
- * len - size of array
- */
-#define XOR(to, a, b, len) \
-	for (i =3D 0; i < len; i++) { \
-		to[i] =3D a[i] ^ b[i]; \
-	}
-
-static int get_milenage(const uint8_t *opc, const uint8_t *k,
-		const uint8_t *rand, const uint8_t *sqn, const uint8_t *amf,
-		const uint8_t *autn_in, uint8_t *autn, uint8_t *ck, uint8_t *ik,
-		uint8_t *res, uint8_t *auts)
-{
-	/* algorithm variables: TEMP, IN1, OUT1, OUT2, OUT5 (OUT3/4 =3D=3D IK/CK)=
 */
-	uint8_t temp[16];
-	uint8_t in1[16];
-	uint8_t out1[16], out2[16], out5[16];
-	/* other variables */
-	struct l_cipher *aes;
-	int i;
-	uint8_t tmp1[16];
-	uint8_t tmp2[16];
-	uint8_t sqn_autn[6];
-
-	aes =3D l_cipher_new(L_CIPHER_AES, k, 16);
-
-	/* temp =3D TEMP =3D E[RAND ^ OPc]k */
-	XOR(tmp1, rand, opc, 16);
-	l_cipher_encrypt(aes, tmp1, temp, 16);
-
-	/* IN1[0-47] =3D SQN[0-47] */
-	memcpy(in1, sqn, 6);
-	/* IN1[48-63] =3D AMF[0-15] */
-	memcpy(in1 + 6, amf, 2);
-	/* IN1[64-111] =3D SQN[0-47] */
-	memcpy(in1 + 8, sqn, 6);
-	/* IN1[112-127] =3D AMF[0-15] */
-	memcpy(in1 + 14, amf, 2);
-
-	/*
-	 * f1 and f1* output OUT1
-	 */
-	/*
-	 * tmp1 =3D rot(IN1 ^ OPc)r1
-	 * r1 =3D 64 bits =3D 8 bytes
-	 */
-	for (i =3D 0; i < 16; i++)
-		tmp1[(i + 8) % 16] =3D in1[i] ^ opc[i];
-
-	/* tmp2 =3D TEMP ^ tmp1 */
-	XOR(tmp2, temp, tmp1, 16);
-	/* tmp2 =3D E[tmp2]k */
-	l_cipher_encrypt(aes, tmp2, tmp1, 16);
-	/* out1 =3D OUT1 =3D tmp1 ^ opc */
-	XOR(out1, tmp1, opc, 16);
-
-	/*
-	 * f2 outputs OUT2 (RES | AK)
-	 *
-	 * r2 =3D 0 =3D=3D no rotation
-	 */
-	/* tmp1 =3D rot(TEMP ^ OPc)r2 */
-	XOR(tmp1, temp, opc, 16);
-	/* tmp1 ^ c2. c2 at bit 127 =3D=3D 1 */
-	tmp1[15] ^=3D 1;
-	l_cipher_encrypt(aes, tmp1, out2, 16);
-
-	/* get RES from OUT2 */
-	XOR(out2, out2, opc, 16);
-	memcpy(res, out2 + 8, 8);
-
-	/* check input autn (AUTN ^ AK =3D SQN)*/
-	XOR(sqn_autn, autn_in, out2, 6);
-
-	/* if SQN was not correct, generate AUTS */
-	if (memcmp(sqn_autn, sqn, 6)) {
-		/*
-		 * f5* outputs AK' (OUT5)
-		 */
-		for (i =3D 0; i < 16; i++)
-			tmp1[(i + 4) % 16] =3D temp[i] ^ opc[i];
-
-		/* tmp1 ^ c5. c5 at bit 124 =3D=3D 1 */
-		tmp1[15] ^=3D 1 << 3;
-		l_cipher_encrypt(aes, tmp1, out5, 16);
-		/* out5 ^ opc */
-		XOR(out5, out5, opc, 16);
-
-		XOR(auts, sqn, out5, 6);
-
-		/* run f1 with zero'd AMF to finish AUTS */
-		in1[6] =3D 0x00;
-		in1[7] =3D 0x00;
-		in1[14] =3D 0x00;
-		in1[15] =3D 0x00;
-
-		for (i =3D 0; i < 16; i++)
-			tmp1[(i + 8) % 16] =3D in1[i] ^ opc[i];
-
-		/* tmp2 =3D TEMP ^ tmp1 */
-		XOR(tmp2, temp, tmp1, 16);
-		/* tmp2 =3D E[tmp2]k */
-		l_cipher_encrypt(aes, tmp2, tmp1, 16);
-		/* out1 =3D OUT1 =3D tmp1 ^ opc */
-		XOR(out1, tmp1, opc, 16);
-
-		memcpy(auts + 6, in1 + 8, 8);
-
-		return -1;
-	}
-
-	/* AUTN =3D (SQN ^ AK) | AMF | MAC_A */
-	XOR(autn, sqn, out2, 6);
-	memcpy(autn + 6, amf, 2);
-	memcpy(autn + 8, out1, 8);
-
-	if (memcmp(autn, autn_in, 16))
-		return -2;
-
-	/*
-	 * f3 outputs CK (OUT3)
-	 *
-	 * tmp1 =3D rot(TEMP ^ OPc)r3
-	 *
-	 * r3 =3D 32 bits =3D 4 bytes
-	 */
-	for (i =3D 0; i < 16; i++)
-		tmp1[(i + 12) % 16] =3D temp[i] ^ opc[i];
-
-	/* tmp1 ^ c3. c3 at bit 126 =3D=3D 1 */
-	tmp1[15] ^=3D 1 << 1;
-	l_cipher_encrypt(aes, tmp1, ck, 16);
-	/* ck ^ opc */
-	XOR(ck, ck, opc, 16);
-
-	/*
-	 * f4 outputs IK (OUT4)
-	 *
-	 * tmp1 =3D rot(TEMP ^ OPc)r4
-	 *
-	 * r4 =3D 64 bits =3D 8 bytes
-	 */
-	for (i =3D 0; i < 16; i++)
-		tmp1[(i + 8) % 16] =3D temp[i] ^ opc[i];
-
-	/* tmp1 ^ c4. c4@bit 125 =3D=3D 1 */
-	tmp1[15] ^=3D 1 << 2;
-	l_cipher_encrypt(aes, tmp1, ik, 16);
-	/* ik ^ opc */
-	XOR(ik, ik, opc, 16);
-
-	l_cipher_free(aes);
-
-	return 0;
-}
-
-static int check_milenage(struct iwd_sim_auth *auth, const uint8_t *rand,
-		const uint8_t *autn, sim_auth_check_milenage_cb_t cb,
-		void *data)
-{
-	uint8_t res[8];
-	uint8_t ck[16];
-	uint8_t ik[16];
-	uint8_t _autn[16];
-	uint8_t auts[14];
-	int ret;
-
-	if (!sim->aka_supported)
-		return -ENOTSUP;
-
-	ret =3D get_milenage(sim->opc, sim->ki, rand, sim->sqn, sim->amf,
-			autn, _autn, ck, ik, res, auts);
-
-	/* ret =3D=3D 0, success; ret =3D=3D -1, sync failure; ret =3D=3D -2, fai=
lure */
-	if (ret =3D=3D 0)
-		cb(res, ck, ik, NULL, data);
-	else if (ret =3D=3D -1)
-		cb(NULL, NULL, NULL, auts, data);
-	else
-		cb(NULL, NULL, NULL, NULL, data);
-
-	return 0;
-
-}
-
-static int run_gsm(struct iwd_sim_auth *auth, const uint8_t *rands,
-		int num_rands, sim_auth_run_gsm_cb_t cb, void *data)
-{
-	if (!sim->sim_supported)
-		return -ENOTSUP;
-
-	cb((const uint8_t *)sim->sres, (const uint8_t *)sim->kc, data);
-
-	return 0;
-}
-
-static struct iwd_sim_auth_driver hardcoded_sim_driver =3D {
-		.name =3D "Hardcoded SIM driver",
-		.check_milenage =3D check_milenage,
-		.run_gsm =3D run_gsm
-};
-
-static int sim_hardcoded_init(void)
-{
-	void *kc;
-	void *sres;
-	void *ki;
-	void *opc;
-	void *amf;
-	void *sqn;
-	const char *str;
-	size_t len;
-	struct l_settings *key_settings;
-	const char *config_path =3D getenv("IWD_SIM_KEYS");
-
-	if (!config_path) {
-		l_debug("IWD_SIM_KEYS not set in env");
-		return -ENOENT;
-	}
-
-	key_settings =3D l_settings_new();
-
-	if (!l_settings_load_from_file(key_settings, config_path)) {
-		l_error("No %s file found", config_path);
-		l_settings_free(key_settings);
-		return -ENOENT;
-	}
-
-	sim =3D l_new(struct hardcoded_sim, 1);
-
-	if (l_settings_has_group(key_settings, "SIM")) {
-		str =3D l_settings_get_value(key_settings, "SIM", "Kc");
-		if (!str) {
-			l_debug("Kc value must be present for SIM");
-			goto try_aka;
-		}
-
-		kc =3D l_util_from_hexstring(str, &len);
-		memcpy(sim->kc, kc, len);
-		l_free(kc);
-
-		str =3D l_settings_get_value(key_settings, "SIM", "SRES");
-		if (!str) {
-			l_debug("SRES value must be present for SIM");
-			goto try_aka;
-		}
-
-		sres =3D l_util_from_hexstring(str, &len);
-		memcpy(sim->sres, sres, NUM_RANDS_MAX * EAP_SIM_SRES_LEN);
-		l_free(sres);
-
-		str =3D l_settings_get_value(key_settings, "SIM", "Identity");
-		if (!str) {
-			l_debug("Identity setting must be present for SIM");
-			goto try_aka;
-		}
-
-		sim->identity =3D l_strdup(str);
-
-		sim->sim_supported =3D 1;
-	}
-
-try_aka:
-	if (l_settings_has_group(key_settings, "AKA")) {
-		str =3D l_settings_get_value(key_settings, "AKA", "KI");
-		if (!str) {
-			l_debug("KI value must be present for AKA");
-			goto end;
-		}
-
-		ki =3D l_util_from_hexstring(str, &len);
-		memcpy(sim->ki, ki, EAP_AKA_KI_LEN);
-		l_free(ki);
-
-		str =3D l_settings_get_value(key_settings, "AKA", "OPC");
-		if (!str) {
-			l_debug("OPC value must be preset for AKA");
-			goto end;
-		}
-
-		opc =3D l_util_from_hexstring(str, &len);
-		memcpy(sim->opc, opc, EAP_AKA_OPC_LEN);
-		l_free(opc);
-
-		str =3D l_settings_get_value(key_settings, "AKA", "AMF");
-		if (!str) {
-			l_debug("AMF value must be present for AKA");
-			goto end;
-		}
-
-		amf =3D l_util_from_hexstring(str, &len);
-		memcpy(sim->amf, amf, EAP_AKA_AMF_LEN);
-		l_free(amf);
-
-		str =3D l_settings_get_value(key_settings, "AKA", "SQN");
-		if (!str) {
-			l_debug("SQN value must be present for AKA");
-			goto end;
-		}
-
-		sqn =3D l_util_from_hexstring(str, &len);
-		memcpy(sim->sqn, sqn, EAP_AKA_SQN_LEN);
-		l_free(sqn);
-
-		str =3D l_settings_get_value(key_settings, "AKA", "Identity");
-		if (!str) {
-			l_debug("Identity setting must be present for AKA");
-			goto end;
-		}
-
-		sim->identity =3D l_strdup(str);
-
-		sim->aka_supported =3D 1;
-	}
-end:
-	l_settings_free(key_settings);
-
-	if (!sim->sim_supported && !sim->aka_supported) {
-		l_debug("error parsing config file, values missing");
-
-		return -EINVAL;
-	}
-
-	sim->auth =3D iwd_sim_auth_create(&hardcoded_sim_driver);
-
-	iwd_sim_auth_set_nai(sim->auth, sim->identity);
-	iwd_sim_auth_set_capabilities(sim->auth, sim->sim_supported,
-							sim->aka_supported);
-
-	iwd_sim_auth_register(sim->auth);
-
-	return 0;
-}
-
-static void sim_hardcoded_exit(void)
-{
-	iwd_sim_auth_remove(sim->auth);
-
-	if (sim)
-		l_free(sim->identity);
-
-	l_free(sim);
-}
-
-L_PLUGIN_DEFINE(__iwd_builtin_sim_hardcoded, sim_hardcoded,
-		"Hardcoded SIM driver", "1.0", L_PLUGIN_PRIORITY_DEFAULT,
-		sim_hardcoded_init, sim_hardcoded_exit)
diff --git a/src/main.c b/src/main.c
index 3216f508..2ee6188c 100644
--- a/src/main.c
+++ b/src/main.c
@@ -40,7 +40,6 @@
 #include "src/eap.h"
 #include "src/eapol.h"
 #include "src/rfkill.h"
-#include "src/plugin.h"
 #include "src/storage.h"
 #include "src/anqp.h"
 =

@@ -54,8 +53,6 @@ static const char *interfaces;
 static const char *nointerfaces;
 static const char *phys;
 static const char *nophys;
-static const char *plugins;
-static const char *noplugins;
 static const char *debugopt;
 static bool terminating;
 static bool nl80211_complete;
@@ -140,8 +137,6 @@ static void usage(void)
 		"\t-I, --nointerfaces     Interfaces to ignore\n"
 		"\t-p, --phys             Phys to manage\n"
 		"\t-P, --nophys           Phys to ignore\n"
-		"\t-l, --plugin           Plugins to include\n"
-		"\t-L, --noplugin         Plugins to exclude\n"
 		"\t-d, --debug            Enable debug output\n"
 		"\t-v, --version          Show version\n"
 		"\t-h, --help             Show help options\n");
@@ -154,8 +149,6 @@ static const struct option main_options[] =3D {
 	{ "nointerfaces", required_argument, NULL, 'I' },
 	{ "phys",         required_argument, NULL, 'p' },
 	{ "nophys",       required_argument, NULL, 'P' },
-	{ "plugin",       required_argument, NULL, 'l' },
-	{ "noplugin",     required_argument, NULL, 'L' },
 	{ "debug",        optional_argument, NULL, 'd' },
 	{ "help",         no_argument,       NULL, 'h' },
 	{ }
@@ -179,8 +172,6 @@ static void nl80211_appeared(const struct l_genl_family=
_info *info,
 		l_main_quit();
 		return;
 	}
-
-	plugin_init(plugins, noplugins);
 }
 =

 static void request_name_callback(struct l_dbus *dbus, bool success,
@@ -393,12 +384,6 @@ int main(int argc, char *argv[])
 		case 'P':
 			nophys =3D optarg;
 			break;
-		case 'l':
-			plugins =3D optarg;
-			break;
-		case 'L':
-			noplugins =3D optarg;
-			break;
 		case 'd':
 			if (optarg)
 				debugopt =3D optarg;
@@ -504,7 +489,6 @@ int main(int argc, char *argv[])
 =

 	exit_status =3D l_main_run_with_signal(signal_handler, NULL);
 =

-	plugin_exit();
 	iwd_modules_exit();
 	dbus_exit();
 	l_dbus_destroy(dbus);
diff --git a/plugins/ofono.c b/src/ofono.c
similarity index 100%
rename from plugins/ofono.c
rename to src/ofono.c
-- =

2.26.2

--===============6067881456641002687==--

