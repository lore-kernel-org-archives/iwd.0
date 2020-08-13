Content-Type: multipart/mixed; boundary="===============7296238048935778365=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 16/16] unit: Test a EAP-WSC-R setup in test-eapol
Date: Thu, 13 Aug 2020 02:53:38 +0200
Message-ID: <20200813005338.295108-7-andrew.zaborowski@intel.com>
In-Reply-To: <20200813005338.295108-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7296238048935778365==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am       |   4 +-
 unit/test-eapol.c | 166 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 169 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index e83dbeee..9bb97760 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -457,7 +457,9 @@ unit_test_eapol_SOURCES =3D unit/test-eapol.c \
 				src/eap-md5.c src/util.c \
 				src/eap-tls-common.h src/eap-tls-common.c \
 				src/erp.h src/erp.c \
-				src/mschaputil.h src/mschaputil.c
+				src/mschaputil.h src/mschaputil.c \
+				src/eap-wsc.h src/eap-wsc.c \
+				src/wscutil.h src/wscutil.c
 unit_test_eapol_LDADD =3D $(ell_ldadd)
 unit_test_eapol_DEPENDENCIES =3D $(ell_dependencies) \
 				unit/cert-server.pem \
diff --git a/unit/test-eapol.c b/unit/test-eapol.c
index e15e567a..f29ebb87 100644
--- a/unit/test-eapol.c
+++ b/unit/test-eapol.c
@@ -37,6 +37,8 @@
 #include "src/eap.h"
 #include "src/eap-private.h"
 #include "src/handshake.h"
+#include "src/wscutil.h"
+#include "src/eap-wsc.h"
 =

 /* Our nonce to use + its size */
 static const uint8_t *snonce;
@@ -3767,6 +3769,167 @@ static void eapol_ap_sta_handshake_bad_psk_test(con=
st void *data)
 	assert(s.to_ap_msg_cnt =3D=3D 1 && s.to_sta_msg_cnt =3D=3D 1);
 }
 =

+struct test_wsc_success_data {
+	bool credentials_obtained;
+	bool credentials_sent;
+	bool ap_eap_failed;
+	bool sta_eap_failed;
+	struct test_ap_sta_data *s;
+};
+
+static void test_ap_sta_hs_event_ap(struct handshake_state *hs,
+				enum handshake_event event,
+				void *user_data, ...)
+{
+	struct test_wsc_success_data *data =3D user_data;
+	va_list args;
+
+	va_start(args, user_data);
+
+	switch (event) {
+	case HANDSHAKE_EVENT_EAP_NOTIFY:
+		assert(va_arg(args, unsigned int) =3D=3D
+			EAP_WSC_EVENT_CREDENTIAL_SENT);
+		assert(!data->credentials_sent);
+		assert(!data->ap_eap_failed);
+		data->credentials_sent =3D true;
+		break;
+	case HANDSHAKE_EVENT_FAILED:
+		assert(!data->ap_eap_failed);
+		data->ap_eap_failed =3D true;
+		data->s->ap_sm =3D NULL;
+		break;
+	default:
+		break;
+	}
+
+	va_end(args);
+}
+
+static void test_ap_sta_hs_event_sta(struct handshake_state *hs,
+				enum handshake_event event,
+				void *user_data, ...)
+{
+	struct test_wsc_success_data *data =3D user_data;
+	va_list args;
+
+	va_start(args, user_data);
+
+	switch (event) {
+	case HANDSHAKE_EVENT_EAP_NOTIFY:
+	{
+		unsigned int eap_event =3D va_arg(args, unsigned int);
+		const struct wsc_credential *cred;
+
+		assert(eap_event =3D=3D EAP_WSC_EVENT_CREDENTIAL_OBTAINED);
+		cred =3D va_arg(args, const struct wsc_credential *);
+		assert(cred->ssid_len =3D=3D 7 &&
+			!memcmp(cred->ssid, "thessid", 7));
+		assert(cred->auth_type =3D=3D
+			WSC_AUTHENTICATION_TYPE_WPA2_PERSONAL);
+		assert(cred->encryption_type =3D=3D WSC_ENCRYPTION_TYPE_AES_TKIP);
+		assert(cred->network_key_len =3D=3D 12 &&
+			!memcmp(cred->network_key, "secretsecret", 12));
+		assert(!memcmp(cred->addr, data->s->sta_address, 6));
+		assert(!data->credentials_obtained);
+		assert(!data->sta_eap_failed);
+		data->credentials_obtained =3D true;
+		break;
+	}
+	case HANDSHAKE_EVENT_FAILED:
+		assert(!data->sta_eap_failed);
+		data->sta_eap_failed =3D true;
+		data->s->sta_sm =3D NULL;
+		break;
+	default:
+		break;
+	}
+
+	va_end(args);
+}
+
+static void eapol_ap_sta_handshake_eap_wsc_pbc_test(const void *data)
+{
+	static const unsigned char ap_rsne[] =3D {
+		0x30, 0x12, 0x01, 0x00, 0x00, 0x0f, 0xac, 0x04,
+		0x01, 0x00, 0x00, 0x0f, 0xac, 0x04, 0x01, 0x00,
+		0x00, 0x0f, 0xac, 0x02 };
+	static const char *ssid =3D "TestWPA2EAP";
+	static const char *ap_8021x_str =3D "[Security]\n"
+		"EAP-Method=3DWSC-R\n"
+		"[WSC]\n"
+		"UUID-R=3D00112233445566778899aabbccddeeff\n"
+		"WPA2-SSID=3Dthessid\n"
+		"WPA2-Passphrase=3Dsecretsecret\n"
+		"RFBand=3D1\n"
+		"ConfigurationMethods=3D0x680\n";
+	static const char *sta_8021x_str =3D "[Security]\n"
+		"EAP-Identity=3DWFA-SimpleConfig-Enrollee-1-0\n"
+		"EAP-Method=3DWSC\n"
+		"[WSC]\n"
+		"RFBand=3D1\n"
+		"ConfigurationMethods=3D0x680\n";
+	struct l_settings *ap_8021x_settings =3D l_settings_new();
+	struct l_settings *sta_8021x_settings =3D l_settings_new();
+	struct test_ap_sta_data s =3D {
+		.ap_hs =3D test_ap_sta_hs_new(&s, 1),
+		.sta_hs =3D test_ap_sta_hs_new(&s, 2),
+		.ap_address =3D { 0x02, 0x03, 0x04, 0x05, 0x06, 0x07 },
+		.sta_address =3D { 0x02, 0x03, 0x04, 0x05, 0x06, 0x08 },
+	};
+	struct test_wsc_success_data wsc_data =3D {
+		.s =3D &s
+	};
+	uint8_t uuid_e[16];
+	L_AUTO_FREE_VAR(char *, uuid_e_str) =3D NULL;
+
+	wsc_uuid_from_addr(s.sta_address, uuid_e);
+	uuid_e_str =3D l_util_hexstring(uuid_e, 16);
+
+	__handshake_set_get_nonce_func(random_nonce);
+	__handshake_set_install_tk_func(test_ap_sta_install_tk);
+	__handshake_set_install_gtk_func(NULL);
+
+	handshake_state_set_authenticator(s.ap_hs, true);
+	handshake_state_set_event_func(s.ap_hs, test_ap_sta_hs_event_ap,
+					&wsc_data);
+	handshake_state_set_authenticator_address(s.ap_hs, s.ap_address);
+	handshake_state_set_supplicant_address(s.ap_hs, s.sta_address);
+	handshake_state_set_authenticator_ie(s.ap_hs, ap_rsne);
+	handshake_state_set_ssid(s.ap_hs, (void *) ssid, strlen(ssid));
+	l_settings_load_from_data(ap_8021x_settings, ap_8021x_str,
+					strlen(ap_8021x_str));
+	l_settings_set_string(ap_8021x_settings, "WSC", "EnrolleeMAC",
+				util_address_to_string(s.sta_address));
+	l_settings_set_string(ap_8021x_settings, "WSC", "UUID-E", uuid_e_str);
+	handshake_state_set_8021x_config(s.ap_hs, ap_8021x_settings);
+
+	handshake_state_set_authenticator(s.sta_hs, false);
+	handshake_state_set_event_func(s.sta_hs, test_ap_sta_hs_event_sta,
+					&wsc_data);
+	handshake_state_set_authenticator_address(s.sta_hs, s.ap_address);
+	handshake_state_set_supplicant_address(s.sta_hs, s.sta_address);
+	handshake_state_set_authenticator_ie(s.sta_hs, ap_rsne);
+	handshake_state_set_ssid(s.sta_hs, (void *) ssid, strlen(ssid));
+	l_settings_load_from_data(sta_8021x_settings, sta_8021x_str,
+					strlen(sta_8021x_str));
+	l_settings_set_string(sta_8021x_settings, "WSC", "EnrolleeMAC",
+				util_address_to_string(s.sta_address));
+	handshake_state_set_8021x_config(s.sta_hs, sta_8021x_settings);
+
+	test_ap_sta_run(&s);
+
+	handshake_state_free(s.ap_hs);
+	handshake_state_free(s.sta_hs);
+	__handshake_set_install_tk_func(NULL);
+	l_settings_free(ap_8021x_settings);
+	l_settings_free(sta_8021x_settings);
+
+	assert(!s.ap_success && !s.sta_success);
+	assert(wsc_data.sta_eap_failed && wsc_data.credentials_obtained);
+	assert(wsc_data.ap_eap_failed && wsc_data.credentials_sent);
+}
+
 #define IS_ENABLED(config_macro) _IS_ENABLED1(config_macro)
 #define _IS_ENABLED1(config_macro) _IS_ENABLED2(_XXXX##config_macro)
 #define _XXXX1 _YYYY,
@@ -3912,6 +4075,9 @@ int main(int argc, char *argv[])
 	l_test_add("EAPoL/Supplicant+Authenticator 4-Way Handshake Bad PSK",
 			&eapol_ap_sta_handshake_bad_psk_test, NULL);
 =

+	l_test_add("EAPoL/Supplicant+Authenticator EAP-WSC PBC (WPA2 creds)",
+			&eapol_ap_sta_handshake_eap_wsc_pbc_test, NULL);
+
 done:
 	return l_test_run();
 }
-- =

2.25.1

--===============7296238048935778365==--

