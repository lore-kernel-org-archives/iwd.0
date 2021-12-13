Content-Type: multipart/mixed; boundary="===============5424835217499035976=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 7/9] dpp-util: add dpp_parse_configuration_object
Date: Mon, 13 Dec 2021 12:33:30 -0800
Message-ID: <20211213203332.2191003-7-prestwoj@gmail.com>
In-Reply-To: 20211213203332.2191003-1-prestwoj@gmail.com

--===============5424835217499035976==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This parses the configuration JSON object from the configuration
response. Only a minimal configuration object is supported for
now.
---
 Makefile.am    |   5 +--
 src/dpp-util.c | 110 +++++++++++++++++++++++++++++++++++++++++++++++++
 src/dpp-util.h |  12 ++++++
 3 files changed, 124 insertions(+), 3 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 5d14963b..d079ba89 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -552,9 +552,8 @@ unit_test_p2p_LDADD =3D $(ell_ldadd)
 =

 unit_test_dpp_SOURCES =3D unit/test-dpp.c src/dpp-util.h src/dpp-util.c \
 				src/band.h src/band.c \
-				src/util.h src/util.c src/crypto.h src/crypto.c
-				src/util.h src/util.c
-
+				src/util.h src/util.c src/crypto.h \
+				src/crypto.c src/json.h src/json.c
 unit_test_dpp_LDADD =3D $(ell_ldadd)
 =

 unit_test_json_SOURCES =3D unit/test-json.c src/json.h src/json.c shared/j=
smn.h
diff --git a/src/dpp-util.c b/src/dpp-util.c
index 75b0b11c..54bf56cd 100644
--- a/src/dpp-util.c
+++ b/src/dpp-util.c
@@ -34,6 +34,9 @@
 #include "src/util.h"
 #include "src/band.h"
 #include "src/crypto.h"
+#include "src/json.h"
+#include "ell/useful.h"
+#include "src/ie.h"
 =

 #define TOKEN_NEXT(p, sep) \
 ({ \
@@ -127,6 +130,113 @@ char *dpp_generate_uri(const uint8_t *asn1, size_t as=
n1_len, uint8_t version,
 	return l_string_unwrap(uri);
 }
 =

+static uint32_t dpp_parse_akm(char *akms)
+{
+	_auto_(l_strv_free) char **split =3D l_strsplit(akms, '+');
+	char **i =3D split;
+	uint32_t akm_out =3D 0;
+
+	while (*i) {
+		if (!strncmp(*i, "psk", 3))
+			akm_out |=3D IE_RSN_AKM_SUITE_PSK;
+		else if (!strncmp(*i, "sae", 3))
+			akm_out |=3D IE_RSN_AKM_SUITE_SAE_SHA256;
+
+		i++;
+	}
+
+	return akm_out;
+}
+
+/*
+ * TODO: This handles the most basic configuration. i.e. a configuration o=
bject
+ * with ssid/passphrase/akm.
+ */
+struct dpp_configuration *dpp_parse_configuration_object(const char *json,
+							size_t json_len)
+{
+	struct dpp_configuration *config;
+	struct json_contents *c;
+	struct json_iter iter;
+	struct json_iter discovery;
+	struct json_iter cred;
+	_auto_(l_free)char *tech =3D NULL;
+	_auto_(l_free)char *ssid =3D NULL;
+	_auto_(l_free)char *akm =3D NULL;
+	_auto_(l_free)char *pass =3D NULL;
+	_auto_(l_free)char *psk =3D NULL;
+
+	c =3D json_contents_new(json, json_len);
+	if (!c)
+		return NULL;
+
+	json_iter_init(&iter, c);
+
+	if (!json_iter_parse(&iter,
+			JSON_MANDATORY("wi-fi_tech", JSON_STRING, &tech),
+			JSON_MANDATORY("discovery", JSON_OBJECT, &discovery),
+			JSON_MANDATORY("cred", JSON_OBJECT, &cred),
+			JSON_UNDEFINED))
+		goto free_contents;
+
+	if (!tech || strncmp(tech, "infra", 5))
+		goto free_contents;
+
+
+	if (!json_iter_parse(&discovery,
+			JSON_MANDATORY("ssid", JSON_STRING, &ssid),
+			JSON_UNDEFINED))
+		goto free_contents;
+
+	if (!ssid || !util_ssid_is_utf8(strlen(ssid),(const uint8_t *)ssid))
+		goto free_contents;
+
+	if (!json_iter_parse(&cred,
+			JSON_MANDATORY("akm", JSON_STRING, &akm),
+			JSON_OPTIONAL("pass", JSON_STRING, &pass),
+			JSON_OPTIONAL("psk", JSON_STRING, &psk),
+			JSON_UNDEFINED))
+		goto free_contents;
+
+	if (!pass && (!psk || strlen(psk) !=3D 64))
+		goto free_contents;
+
+	config =3D l_new(struct dpp_configuration, 1);
+
+	if (pass)
+		config->passphrase =3D l_steal_ptr(pass);
+	else
+		config->psk =3D l_steal_ptr(psk);
+
+	memcpy(config->ssid, ssid, strlen(ssid));
+	config->ssid_len =3D strlen(ssid);
+
+	config->akm_suites =3D dpp_parse_akm(akm);
+	if (!config->akm_suites)
+		goto free_config;
+
+	json_contents_free(c);
+
+	return config;
+
+free_config:
+	dpp_configuration_free(config);
+free_contents:
+	json_contents_free(c);
+	return NULL;
+}
+
+void dpp_configuration_free(struct dpp_configuration *config)
+{
+	if (config->passphrase)
+		l_free(config->passphrase);
+
+	if (config->psk)
+		l_free(config->psk);
+
+	l_free(config);
+}
+
 void dpp_attr_iter_init(struct dpp_attr_iter *iter, const uint8_t *pdu,
 			size_t len)
 {
diff --git a/src/dpp-util.h b/src/dpp-util.h
index 0856f19d..86996eb3 100644
--- a/src/dpp-util.h
+++ b/src/dpp-util.h
@@ -113,6 +113,18 @@ enum dpp_attribute_type {
 	DPP_ATTR_CONFIGURATOR_NONCE		=3D 0x1022,
 };
 =

+struct dpp_configuration {
+	uint8_t ssid[32];
+	size_t ssid_len;
+	uint32_t akm_suites;
+	char *passphrase;
+	char *psk;		/* hex string */
+};
+
+struct dpp_configuration *dpp_parse_configuration_object(const char *json,
+							size_t json_len);
+void dpp_configuration_free(struct dpp_configuration *conf);
+
 struct dpp_attr_iter {
 	const uint8_t *pos;
 	const uint8_t *end;
-- =

2.31.1

--===============5424835217499035976==--

