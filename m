Content-Type: multipart/mixed; boundary="===============6111207961265893166=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] unit: add test for embedded certs to test-eapol
Date: Mon, 07 Oct 2019 09:11:13 -0700
Message-ID: <20191007161113.13435-3-prestwoj@gmail.com>
In-Reply-To: <20191007161113.13435-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6111207961265893166==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Refactored eapol_sm_test_tls to take a l_settings object rather than
a settings string. This lets the caller either load from data or
from file (the new test loads the build time generated tls-settings
file).
---
 unit/test-eapol.c | 65 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 15 deletions(-)

diff --git a/unit/test-eapol.c b/unit/test-eapol.c
index 933d9522..1fe39b0c 100644
--- a/unit/test-eapol.c
+++ b/unit/test-eapol.c
@@ -2886,7 +2886,7 @@ static void test_handshake_event(struct handshake_sta=
te *hs,
 }
 =

 static void eapol_sm_test_tls(struct eapol_8021x_tls_test_state *s,
-				const char *config)
+				struct l_settings *config)
 {
 	static const unsigned char ap_wpa_ie[] =3D {
 		0xdd, 0x16, 0x00, 0x50, 0xf2, 0x01, 0x01, 0x00,
@@ -2898,7 +2898,6 @@ static void eapol_sm_test_tls(struct eapol_8021x_tls_=
test_state *s,
 	struct handshake_state *hs;
 	struct test_handshake_state *ths;
 	struct eapol_sm *sm;
-	struct l_settings *settings;
 	uint8_t tx_buf[2000];
 	size_t header_len, data_len, tx_len;
 	bool start;
@@ -2933,13 +2932,9 @@ static void eapol_sm_test_tls(struct eapol_8021x_tls=
_test_state *s,
 =

 	handshake_state_set_authenticator_ie(hs, ap_wpa_ie);
 =

-	settings =3D l_settings_new();
-	l_settings_load_from_data(settings, config, strlen(config));
-	handshake_state_set_8021x_config(hs, settings);
+	handshake_state_set_8021x_config(hs, config);
 	eapol_start(sm);
 =

-	l_settings_free(settings);
-
 	__eapol_set_tx_packet_func(verify_8021x_identity_resp);
 	s->pending_req =3D 1;
 	__eapol_rx_packet(1, ap_address, ETH_P_PAE, eap_identity_req,
@@ -3152,25 +3147,48 @@ done:
 =

 static void eapol_sm_test_eap_tls(const void *data)
 {
-	static const char *eapol_8021x_config =3D "[Security]\n"
+	static const char *config_8021x =3D "[Security]\n"
 		"EAP-Method=3DTLS\n"
 		"EAP-Identity=3Dabc(a)example.com\n"
 		"EAP-TLS-CACert=3D" CERTDIR "cert-ca.pem\n"
 		"EAP-TLS-ClientCert=3D" CERTDIR "cert-client.pem\n"
 		"EAP-TLS-ClientKey=3D" CERTDIR "cert-client-key-pkcs8.pem";
 	struct eapol_8021x_tls_test_state s =3D {};
+	struct l_settings* config =3D l_settings_new();
+
+	l_settings_load_from_data(config, config_8021x, strlen(config_8021x));
 =

 	s.app_data_cb =3D eapol_sm_test_tls_new_data;
 	s.ready_cb =3D eapol_sm_test_tls_test_ready;
 	s.disconnect_cb =3D eapol_sm_test_tls_test_disconnected;
 	s.method =3D EAP_TYPE_TLS;
 =

-	eapol_sm_test_tls(&s, eapol_8021x_config);
+	eapol_sm_test_tls(&s, config);
+
+	l_settings_free(config);
+}
+
+static void eapol_sm_test_eap_tls_embedded(const void *data)
+{
+	struct eapol_8021x_tls_test_state s =3D {};
+	struct l_settings *config;
+
+	config =3D l_settings_new();
+	l_settings_load_from_file(config, CERTDIR "tls-settings.8021x");
+
+	s.app_data_cb =3D eapol_sm_test_tls_new_data;
+	s.ready_cb =3D eapol_sm_test_tls_test_ready;
+	s.disconnect_cb =3D eapol_sm_test_tls_test_disconnected;
+	s.method =3D EAP_TYPE_TLS;
+
+	eapol_sm_test_tls(&s, config);
+
+	l_settings_free(config);
 }
 =

 static void eapol_sm_test_eap_tls_subject_good(const void *data)
 {
-	static const char *eapol_8021x_config =3D "[Security]\n"
+	static const char *config_8021x =3D "[Security]\n"
 		"EAP-Method=3DTLS\n"
 		"EAP-Identity=3Dabc(a)example.com\n"
 		"EAP-TLS-CACert=3D" CERTDIR "cert-ca.pem\n"
@@ -3178,18 +3196,23 @@ static void eapol_sm_test_eap_tls_subject_good(cons=
t void *data)
 		"EAP-TLS-ClientKey=3D" CERTDIR "cert-client-key-pkcs8.pem\n"
 		"EAP-TLS-ServerDomainMask=3Dbad.example.org;*.example.org";
 	struct eapol_8021x_tls_test_state s =3D {};
+	struct l_settings* config =3D l_settings_new();
+
+	l_settings_load_from_data(config, config_8021x, strlen(config_8021x));
 =

 	s.app_data_cb =3D eapol_sm_test_tls_new_data;
 	s.ready_cb =3D eapol_sm_test_tls_test_ready;
 	s.disconnect_cb =3D eapol_sm_test_tls_test_disconnected;
 	s.method =3D EAP_TYPE_TLS;
 =

-	eapol_sm_test_tls(&s, eapol_8021x_config);
+	eapol_sm_test_tls(&s, config);
+
+	l_settings_free(config);
 }
 =

 static void eapol_sm_test_eap_tls_subject_bad(const void *data)
 {
-	static const char *eapol_8021x_config =3D "[Security]\n"
+	static const char *config_8021x =3D "[Security]\n"
 		"EAP-Method=3DTLS\n"
 		"EAP-Identity=3Dabc(a)example.com\n"
 		"EAP-TLS-CACert=3D" CERTDIR "cert-ca.pem\n"
@@ -3197,6 +3220,9 @@ static void eapol_sm_test_eap_tls_subject_bad(const v=
oid *data)
 		"EAP-TLS-ClientKey=3D" CERTDIR "cert-client-key-pkcs8.pem\n"
 		"EAP-TLS-ServerDomainMask=3Dbad.example.org";
 	struct eapol_8021x_tls_test_state s =3D {};
+	struct l_settings* config =3D l_settings_new();
+
+	l_settings_load_from_data(config, config_8021x, strlen(config_8021x));
 =

 	s.app_data_cb =3D eapol_sm_test_tls_new_data;
 	s.ready_cb =3D eapol_sm_test_tls_test_ready;
@@ -3204,7 +3230,9 @@ static void eapol_sm_test_eap_tls_subject_bad(const v=
oid *data)
 	s.method =3D EAP_TYPE_TLS;
 	s.expect_handshake_fail =3D true;
 =

-	eapol_sm_test_tls(&s, eapol_8021x_config);
+	eapol_sm_test_tls(&s, config);
+
+	l_settings_free(config);
 }
 =

 static const uint8_t eap_ttls_eap_identity_avp[] =3D {
@@ -3267,7 +3295,7 @@ static void eapol_sm_test_eap_ttls_test_ready(const c=
har *peer_identity,
 =

 static void eapol_sm_test_eap_ttls_md5(const void *data)
 {
-	static const char *eapol_8021x_config =3D "[Security]\n"
+	static const char *config_8021x =3D "[Security]\n"
 		"EAP-Method=3DTTLS\n"
 		"EAP-Identity=3Dabc(a)example.com\n"
 		"EAP-TTLS-CACert=3D" CERTDIR "cert-ca.pem\n"
@@ -3277,13 +3305,18 @@ static void eapol_sm_test_eap_ttls_md5(const void *=
data)
 		"EAP-TTLS-Phase2-Identity=3Dabc(a)example.com\n"
 		"EAP-TTLS-Phase2-Password=3Dtestpasswd";
 	struct eapol_8021x_eap_ttls_test_state s =3D {};
+	struct l_settings* config =3D l_settings_new();
+
+	l_settings_load_from_data(config, config_8021x, strlen(config_8021x));
 =

 	s.tls.app_data_cb =3D eapol_sm_test_eap_ttls_new_data;
 	s.tls.ready_cb =3D eapol_sm_test_eap_ttls_test_ready;
 	s.tls.disconnect_cb =3D eapol_sm_test_tls_test_disconnected;
 	s.tls.method =3D EAP_TYPE_TTLS;
 =

-	eapol_sm_test_tls(&s.tls, eapol_8021x_config);
+	eapol_sm_test_tls(&s.tls, config);
+
+	l_settings_free(config);
 }
 =

 static const uint8_t eap_ttls_start_req[] =3D {
@@ -3605,6 +3638,8 @@ int main(int argc, char *argv[])
 				&eapol_sm_test_eap_tls_subject_good, NULL);
 		l_test_add("EAPoL/8021x EAP-TLS subject name mismatch",
 				&eapol_sm_test_eap_tls_subject_bad, NULL);
+		l_test_add("EAPoL/8021x EAP-TLS embedded certs",
+				&eapol_sm_test_eap_tls_embedded, NULL);
 	}
 =

 	l_test_add("EAPoL/FT-Using-PSK 4-Way Handshake",
-- =

2.17.1

--===============6111207961265893166==--

