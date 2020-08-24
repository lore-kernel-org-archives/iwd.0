Content-Type: multipart/mixed; boundary="===============0325448437206983337=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/5] unit: Add a WSC-R test with a raw PSK
Date: Tue, 25 Aug 2020 00:34:25 +0200
Message-ID: <20200824223426.475779-4-andrew.zaborowski@intel.com>
In-Reply-To: <20200824223426.475779-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0325448437206983337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The wsc credentials can contain the passphrase or the raw PSK bytes,
now test both scenarios.
---
 unit/test-wsc.c | 91 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 73 insertions(+), 18 deletions(-)

diff --git a/unit/test-wsc.c b/unit/test-wsc.c
index 231a7da4..0b9ec2f3 100644
--- a/unit/test-wsc.c
+++ b/unit/test-wsc.c
@@ -2375,6 +2375,7 @@ struct wsc_r_test_success_data {
 	bool ap_eap_failed;
 	bool sta_eap_failed;
 	struct test_ap_sta_data *s;
+	struct wsc_credential expected_creds;
 };
 =

 static void test_ap_sta_hs_event_ap(struct handshake_state *hs,
@@ -2425,14 +2426,7 @@ static void test_ap_sta_hs_event_sta(struct handshak=
e_state *hs,
 =

 		assert(eap_event =3D=3D EAP_WSC_EVENT_CREDENTIAL_OBTAINED);
 		cred =3D va_arg(args, const struct wsc_credential *);
-		assert(cred->ssid_len =3D=3D 7 &&
-			!memcmp(cred->ssid, "thessid", 7));
-		assert(cred->auth_type =3D=3D
-			WSC_AUTHENTICATION_TYPE_WPA2_PERSONAL);
-		assert(cred->encryption_type =3D=3D WSC_ENCRYPTION_TYPE_AES_TKIP);
-		assert(cred->network_key_len =3D=3D 12 &&
-			!memcmp(cred->network_key, "secretsecret", 12));
-		assert(!memcmp(cred->addr, data->s->sta_address, 6));
+		assert(!memcmp(cred, &data->expected_creds, sizeof(*cred)));
 		assert(!data->credentials_obtained);
 		assert(!data->sta_eap_failed);
 		data->credentials_obtained =3D true;
@@ -2452,7 +2446,7 @@ static void test_ap_sta_hs_event_sta(struct handshake=
_state *hs,
 	va_end(args);
 }
 =

-static void wsc_r_test_pbc_handshake_wpa2(const void *data)
+static void wsc_r_test_pbc_handshake(const void *data)
 {
 	static const unsigned char ap_rsne[] =3D {
 		0x30, 0x12, 0x01, 0x00, 0x00, 0x0f, 0xac, 0x04,
@@ -2463,8 +2457,6 @@ static void wsc_r_test_pbc_handshake_wpa2(const void =
*data)
 		"EAP-Method=3DWSC-R\n"
 		"[WSC]\n"
 		"UUID-R=3D00112233445566778899aabbccddeeff\n"
-		"WPA2-SSID=3Dthessid\n"
-		"WPA2-Passphrase=3Dsecretsecret\n"
 		"RFBand=3D1\n"
 		"ConfigurationMethods=3D0x680\n";
 	static const char *sta_8021x_str =3D "[Security]\n"
@@ -2481,15 +2473,60 @@ static void wsc_r_test_pbc_handshake_wpa2(const voi=
d *data)
 		.ap_address =3D { 0x02, 0x03, 0x04, 0x05, 0x06, 0x07 },
 		.sta_address =3D { 0x02, 0x03, 0x04, 0x05, 0x06, 0x08 },
 	};
+	const struct wsc_credential *expected_creds =3D data;
 	struct wsc_r_test_success_data wsc_data =3D {
 		.s =3D &s,
+		.expected_creds =3D *expected_creds,
 	};
 	uint8_t uuid_e[16];
 	L_AUTO_FREE_VAR(char *, uuid_e_str) =3D NULL;
+	char ssid_str[33];
 =

 	wsc_uuid_from_addr(s.sta_address, uuid_e);
 	uuid_e_str =3D l_util_hexstring(uuid_e, 16);
 =

+	memcpy(wsc_data.expected_creds.addr, s.sta_address, 6);
+	memset(wsc_data.expected_creds.ssid + expected_creds->ssid_len, 0,
+		sizeof(expected_creds->ssid) - expected_creds->ssid_len);
+	memset(wsc_data.expected_creds.network_key +
+		expected_creds->network_key_len, 0,
+		sizeof(expected_creds->network_key) -
+		expected_creds->network_key_len);
+
+	memcpy(ssid_str, expected_creds->ssid, expected_creds->ssid_len);
+	ssid_str[expected_creds->ssid_len] =3D '\0';
+
+	l_settings_load_from_data(ap_8021x_settings, ap_8021x_str,
+					strlen(ap_8021x_str));
+	l_settings_set_string(ap_8021x_settings, "WSC", "EnrolleeMAC",
+				util_address_to_string(s.sta_address));
+	l_settings_set_string(ap_8021x_settings, "WSC", "UUID-E", uuid_e_str);
+
+	if (expected_creds->auth_type =3D=3D WSC_AUTHENTICATION_TYPE_WPA2_PERSONA=
L) {
+		l_settings_set_string(ap_8021x_settings, "WSC",
+					"WPA2-SSID", ssid_str);
+
+		if (expected_creds->network_key_len < 64)
+			l_settings_set_string(ap_8021x_settings, "WSC",
+					"WPA2-Passphrase", (char *)
+					wsc_data.expected_creds.network_key);
+		else {
+			char psk_str[65];
+
+			/*
+			 * The PSK is 32-byte long but the setting value is
+			 * a hexstring, same as what we expect to receive in
+			 * the raw wsc_credential.network_key data.
+			 */
+			memcpy(psk_str, expected_creds->network_key, 64);
+			psk_str[64] =3D '\0';
+			l_settings_set_string(ap_8021x_settings, "WSC",
+						"WPA2-PSK", psk_str);
+		}
+	} else
+		l_settings_set_string(ap_8021x_settings, "WSC",
+					"Open-SSID", ssid_str);
+
 	__handshake_set_get_nonce_func(random_nonce);
 	__handshake_set_install_tk_func(test_ap_sta_install_tk);
 	__handshake_set_install_gtk_func(NULL);
@@ -2501,11 +2538,6 @@ static void wsc_r_test_pbc_handshake_wpa2(const void=
 *data)
 	handshake_state_set_supplicant_address(s.ap_hs, s.sta_address);
 	handshake_state_set_authenticator_ie(s.ap_hs, ap_rsne);
 	handshake_state_set_ssid(s.ap_hs, (void *) ssid, strlen(ssid));
-	l_settings_load_from_data(ap_8021x_settings, ap_8021x_str,
-					strlen(ap_8021x_str));
-	l_settings_set_string(ap_8021x_settings, "WSC", "EnrolleeMAC",
-				util_address_to_string(s.sta_address));
-	l_settings_set_string(ap_8021x_settings, "WSC", "UUID-E", uuid_e_str);
 	handshake_state_set_8021x_config(s.ap_hs, ap_8021x_settings);
 =

 	handshake_state_set_authenticator(s.sta_hs, false);
@@ -2533,6 +2565,25 @@ static void wsc_r_test_pbc_handshake_wpa2(const void=
 *data)
 	assert(wsc_data.ap_eap_failed && wsc_data.credentials_sent);
 }
 =

+struct wsc_credential wsc_r_test_wpa2_cred_passphrase =3D {
+	.ssid_len =3D 7,
+	.ssid =3D "thessid",
+	.auth_type =3D WSC_AUTHENTICATION_TYPE_WPA2_PERSONAL,
+	.network_key_len =3D 12,
+	.network_key =3D "secretsecret",
+	.encryption_type =3D WSC_ENCRYPTION_TYPE_AES_TKIP,
+};
+
+struct wsc_credential wsc_r_test_wpa2_cred_psk =3D {
+	.ssid_len =3D 7,
+	.ssid =3D "thessid",
+	.auth_type =3D WSC_AUTHENTICATION_TYPE_WPA2_PERSONAL,
+	.network_key_len =3D 64,
+	.network_key =3D "2aacd631143bbc2d83fabf3febed3c45"
+		"6ea9f7539a1692ffb416c41cfee0c96f",
+	.encryption_type =3D WSC_ENCRYPTION_TYPE_AES_TKIP,
+};
+
 int main(int argc, char *argv[])
 {
 	l_test_init(&argc, &argv);
@@ -2646,8 +2697,12 @@ int main(int argc, char *argv[])
 	l_test_add("/wsc/retransmission/no fragmentation",
 				wsc_test_retransmission_no_fragmentation, NULL);
 =

-	l_test_add("/wsc-r/handshake/PBC Handshake WPA2 Test",
-				wsc_r_test_pbc_handshake_wpa2, NULL);
+	l_test_add("/wsc-r/handshake/PBC Handshake WPA2 passphrase test",
+				wsc_r_test_pbc_handshake,
+				&wsc_r_test_wpa2_cred_passphrase);
+	l_test_add("/wsc-r/handshake/PBC Handshake WPA2 PSK test",
+				wsc_r_test_pbc_handshake,
+				&wsc_r_test_wpa2_cred_psk);
 =

 done:
 	return l_test_run();
-- =

2.25.1

--===============0325448437206983337==--

