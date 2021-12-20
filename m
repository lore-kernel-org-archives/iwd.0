Content-Type: multipart/mixed; boundary="===============1793407455975457006=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/9] dpp-util: add
 dpp_configuration_new/dpp_configuration_to_json
Date: Mon, 20 Dec 2021 13:49:09 -0800
Message-ID: <20211220214915.34093-3-prestwoj@gmail.com>
In-Reply-To: 20211220214915.34093-1-prestwoj@gmail.com

--===============1793407455975457006==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Allows creating a new configuration object based on settings, ssid,
and akm suite (for configurator role) as well as converting a
configuration object to JSON.
---
 src/dpp-util.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/dpp-util.h |  6 ++++
 2 files changed, 87 insertions(+)

diff --git a/src/dpp-util.c b/src/dpp-util.c
index 1db38cfb..55d6f3f1 100644
--- a/src/dpp-util.c
+++ b/src/dpp-util.c
@@ -193,6 +193,87 @@ free_contents:
 	return NULL;
 }
 =

+/*
+ * The DPP spec does not specify a difference between FT AKMs and their no=
rmal
+ * counterpart. Because of this any FT AKM will just result in the standard
+ * 'psk' or 'sae' AKM.
+ */
+static const char *dpp_akm_to_string(enum ie_rsn_akm_suite akm_suite)
+{
+	switch (akm_suite) {
+	case IE_RSN_AKM_SUITE_PSK:
+	case IE_RSN_AKM_SUITE_FT_USING_PSK:
+	case IE_RSN_AKM_SUITE_PSK_SHA256:
+		return "psk";
+	case IE_RSN_AKM_SUITE_SAE_SHA256:
+	case IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256:
+		return "sae";
+	default:
+		return NULL;
+	}
+}
+
+char *dpp_configuration_to_json(struct dpp_configuration *config)
+{
+	_auto_(l_free) char *pass_or_psk;
+	_auto_(l_free) char *ssid;
+
+	ssid =3D l_malloc(config->ssid_len + 1);
+	memcpy(ssid, config->ssid, config->ssid_len);
+	ssid[config->ssid_len] =3D '\0';
+
+	if (config->passphrase)
+		pass_or_psk =3D l_strdup_printf("\"pass\":\"%s\"",
+						config->passphrase);
+	else
+		pass_or_psk =3D l_strdup_printf("\"psk\":\"%s\"",
+						config->psk);
+
+	return l_strdup_printf("{\"wi-fi_tech\":\"infra\","
+				"\"discovery\":{\"ssid\":\"%s\"},"
+				"\"cred\":{\"akm\":\"%s\",%s}}",
+				ssid, dpp_akm_to_string(config->akm_suites),
+				pass_or_psk);
+}
+
+struct dpp_configuration *dpp_configuration_new(
+					const struct l_settings *settings,
+					const char *ssid,
+					enum ie_rsn_akm_suite akm_suite)
+{
+	struct dpp_configuration *config;
+	_auto_(l_free) char *passphrase =3D NULL;
+	_auto_(l_free) char *psk =3D NULL;
+	size_t ssid_len =3D strlen(ssid);
+
+	if (!l_settings_has_group(settings, "Security"))
+		return NULL;
+
+	passphrase =3D l_settings_get_string(settings, "Security", "Passphrase");
+	if (!passphrase) {
+		psk =3D l_settings_get_string(settings, "Security",
+						"PreSharedKey");
+		if (!psk)
+			return NULL;
+	}
+
+	config =3D l_new(struct dpp_configuration, 1);
+
+	memcpy(config->ssid, ssid, ssid_len);
+	config->ssid[ssid_len] =3D '\0';
+	config->ssid_len =3D ssid_len;
+
+	if (passphrase)
+		config->passphrase =3D l_steal_ptr(passphrase);
+	else
+		config->psk =3D l_steal_ptr(psk);
+
+
+	config->akm_suites =3D akm_suite;
+
+	return config;
+}
+
 void dpp_configuration_free(struct dpp_configuration *config)
 {
 	if (config->passphrase)
diff --git a/src/dpp-util.h b/src/dpp-util.h
index 543cf9f8..84d33656 100644
--- a/src/dpp-util.h
+++ b/src/dpp-util.h
@@ -21,6 +21,7 @@
  */
 struct l_ecc_point;
 struct l_ecc_scalar;
+enum ie_rsn_akm_suite;
 =

 enum dpp_frame_type {
 	DPP_FRAME_AUTHENTICATION_REQUEST	=3D 0,
@@ -110,6 +111,11 @@ struct dpp_configuration {
 =

 struct dpp_configuration *dpp_parse_configuration_object(const char *json,
 							size_t json_len);
+struct dpp_configuration *dpp_configuration_new(
+					const struct l_settings *settings,
+					const char *ssid,
+					enum ie_rsn_akm_suite akm_suite);
+char *dpp_configuration_to_json(struct dpp_configuration *config);
 void dpp_configuration_free(struct dpp_configuration *conf);
 =

 struct dpp_attr_iter {
-- =

2.31.1

--===============1793407455975457006==--

