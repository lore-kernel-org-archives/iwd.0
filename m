Content-Type: multipart/mixed; boundary="===============6289611505392954095=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/5] unit: Add two EAPOL IP allocation scenarios
Date: Mon, 14 Sep 2020 15:51:20 +0200
Message-ID: <20200914135120.463623-5-andrew.zaborowski@intel.com>
In-Reply-To: <20200914135120.463623-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6289611505392954095==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-eapol.c | 135 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/unit/test-eapol.c b/unit/test-eapol.c
index 08740a8e..eba249ed 100644
--- a/unit/test-eapol.c
+++ b/unit/test-eapol.c
@@ -3769,6 +3769,137 @@ static void eapol_ap_sta_handshake_bad_psk_test(con=
st void *data)
 	assert(s.to_ap_msg_cnt =3D=3D 1 && s.to_sta_msg_cnt =3D=3D 1);
 }
 =

+static void eapol_ap_sta_handshake_ip_alloc_ok_test(const void *data)
+{
+	static const unsigned char ap_rsne[] =3D {
+		0x30, 0x14, 0x01, 0x00, 0x00, 0x0f, 0xac, 0x04,
+		0x01, 0x00, 0x00, 0x0f, 0xac, 0x04, 0x01, 0x00,
+		0x00, 0x0f, 0xac, 0x02, 0x81, 0x00 };
+	static const unsigned char sta_rsne[] =3D {
+		0x30, 0x12, 0x01, 0x00, 0x00, 0x0f, 0xac, 0x04,
+		0x01, 0x00, 0x00, 0x0f, 0xac, 0x04, 0x01, 0x00,
+		0x00, 0x0f, 0xac, 0x02 };
+	static const char *ssid =3D "TestWPA2PSK";
+	static const uint8_t psk[32] =3D {	/* secretsecret */
+		0x6a, 0xa3, 0xf0, 0x0b, 0x68, 0xbd, 0x8b, 0x46,
+		0x69, 0x83, 0xa5, 0x29, 0xa3, 0xfa, 0x57, 0x1c,
+		0x6c, 0x7b, 0x72, 0x41, 0x1d, 0xce, 0x33, 0x02,
+		0xa2, 0x2d, 0xdf, 0x77, 0xd1, 0x93, 0xdb, 0x5f };
+	struct test_ap_sta_data s =3D {
+		.ap_hs =3D test_ap_sta_hs_new(&s, 1),
+		.sta_hs =3D test_ap_sta_hs_new(&s, 2),
+		.ap_address =3D { 0x02, 0x03, 0x04, 0x05, 0x06, 0x07 },
+		.sta_address =3D { 0x02, 0x03, 0x04, 0x05, 0x06, 0x08 },
+	};
+
+	__handshake_set_get_nonce_func(random_nonce);
+	__handshake_set_install_tk_func(test_ap_sta_install_tk);
+	__handshake_set_install_gtk_func(NULL);
+
+	handshake_state_set_authenticator(s.ap_hs, true);
+	handshake_state_set_event_func(s.ap_hs, test_ap_sta_hs_event, &s);
+	handshake_state_set_authenticator_address(s.ap_hs, s.ap_address);
+	handshake_state_set_supplicant_address(s.ap_hs, s.sta_address);
+	handshake_state_set_supplicant_ie(s.ap_hs, sta_rsne);
+	handshake_state_set_authenticator_ie(s.ap_hs, ap_rsne);
+	handshake_state_set_ssid(s.ap_hs, (void *) ssid, strlen(ssid));
+	handshake_state_set_pmk(s.ap_hs, psk, 32);
+	s.ap_hs->support_ip_allocation =3D true;
+	s.ap_hs->client_ip_addr =3D 0x01020304;
+	s.ap_hs->subnet_mask =3D 0xffff0000;
+	s.ap_hs->go_ip_addr =3D 0x01020305;
+
+	handshake_state_set_authenticator(s.sta_hs, false);
+	handshake_state_set_event_func(s.sta_hs, test_ap_sta_hs_event, &s);
+	handshake_state_set_authenticator_address(s.sta_hs, s.ap_address);
+	handshake_state_set_supplicant_address(s.sta_hs, s.sta_address);
+	handshake_state_set_supplicant_ie(s.sta_hs, sta_rsne);
+	handshake_state_set_authenticator_ie(s.sta_hs, ap_rsne);
+	handshake_state_set_ssid(s.sta_hs, (void *) ssid, strlen(ssid));
+	handshake_state_set_pmk(s.sta_hs, psk, 32);
+	s.sta_hs->support_ip_allocation =3D true;
+
+	test_ap_sta_run(&s);
+
+	assert(s.ap_hs->support_ip_allocation);
+	assert(s.sta_hs->support_ip_allocation);
+	assert(s.sta_hs->client_ip_addr =3D=3D s.ap_hs->client_ip_addr);
+	assert(s.sta_hs->subnet_mask =3D=3D s.ap_hs->subnet_mask);
+	assert(s.sta_hs->go_ip_addr =3D=3D s.ap_hs->go_ip_addr);
+
+	handshake_state_free(s.ap_hs);
+	handshake_state_free(s.sta_hs);
+	__handshake_set_install_tk_func(NULL);
+
+	assert(s.ap_success && s.sta_success);
+	assert(s.to_ap_msg_cnt =3D=3D 2 && s.to_sta_msg_cnt =3D=3D 2);
+	assert(!memcmp(s.ap_tk, s.sta_tk, 16));
+}
+
+static void eapol_ap_sta_handshake_ip_alloc_no_req_test(const void *data)
+{
+	static const unsigned char ap_rsne[] =3D {
+		0x30, 0x14, 0x01, 0x00, 0x00, 0x0f, 0xac, 0x04,
+		0x01, 0x00, 0x00, 0x0f, 0xac, 0x04, 0x01, 0x00,
+		0x00, 0x0f, 0xac, 0x02, 0x81, 0x00 };
+	static const unsigned char sta_rsne[] =3D {
+		0x30, 0x12, 0x01, 0x00, 0x00, 0x0f, 0xac, 0x04,
+		0x01, 0x00, 0x00, 0x0f, 0xac, 0x04, 0x01, 0x00,
+		0x00, 0x0f, 0xac, 0x02 };
+	static const char *ssid =3D "TestWPA2PSK";
+	static const uint8_t psk[32] =3D {	/* secretsecret */
+		0x6a, 0xa3, 0xf0, 0x0b, 0x68, 0xbd, 0x8b, 0x46,
+		0x69, 0x83, 0xa5, 0x29, 0xa3, 0xfa, 0x57, 0x1c,
+		0x6c, 0x7b, 0x72, 0x41, 0x1d, 0xce, 0x33, 0x02,
+		0xa2, 0x2d, 0xdf, 0x77, 0xd1, 0x93, 0xdb, 0x5f };
+	struct test_ap_sta_data s =3D {
+		.ap_hs =3D test_ap_sta_hs_new(&s, 1),
+		.sta_hs =3D test_ap_sta_hs_new(&s, 2),
+		.ap_address =3D { 0x02, 0x03, 0x04, 0x05, 0x06, 0x07 },
+		.sta_address =3D { 0x02, 0x03, 0x04, 0x05, 0x06, 0x08 },
+	};
+
+	__handshake_set_get_nonce_func(random_nonce);
+	__handshake_set_install_tk_func(test_ap_sta_install_tk);
+	__handshake_set_install_gtk_func(NULL);
+
+	handshake_state_set_authenticator(s.ap_hs, true);
+	handshake_state_set_event_func(s.ap_hs, test_ap_sta_hs_event, &s);
+	handshake_state_set_authenticator_address(s.ap_hs, s.ap_address);
+	handshake_state_set_supplicant_address(s.ap_hs, s.sta_address);
+	handshake_state_set_supplicant_ie(s.ap_hs, sta_rsne);
+	handshake_state_set_authenticator_ie(s.ap_hs, ap_rsne);
+	handshake_state_set_ssid(s.ap_hs, (void *) ssid, strlen(ssid));
+	handshake_state_set_pmk(s.ap_hs, psk, 32);
+	s.ap_hs->support_ip_allocation =3D true;
+	s.ap_hs->client_ip_addr =3D 0x01020304;
+	s.ap_hs->subnet_mask =3D 0xffff0000;
+	s.ap_hs->go_ip_addr =3D 0x01020305;
+
+	handshake_state_set_authenticator(s.sta_hs, false);
+	handshake_state_set_event_func(s.sta_hs, test_ap_sta_hs_event, &s);
+	handshake_state_set_authenticator_address(s.sta_hs, s.ap_address);
+	handshake_state_set_supplicant_address(s.sta_hs, s.sta_address);
+	handshake_state_set_supplicant_ie(s.sta_hs, sta_rsne);
+	handshake_state_set_authenticator_ie(s.sta_hs, ap_rsne);
+	handshake_state_set_ssid(s.sta_hs, (void *) ssid, strlen(ssid));
+	handshake_state_set_pmk(s.sta_hs, psk, 32);
+	s.ap_hs->support_ip_allocation =3D false;
+
+	test_ap_sta_run(&s);
+
+	assert(!s.ap_hs->support_ip_allocation);
+	assert(!s.sta_hs->support_ip_allocation);
+
+	handshake_state_free(s.ap_hs);
+	handshake_state_free(s.sta_hs);
+	__handshake_set_install_tk_func(NULL);
+
+	assert(s.ap_success && s.sta_success);
+	assert(s.to_ap_msg_cnt =3D=3D 2 && s.to_sta_msg_cnt =3D=3D 2);
+	assert(!memcmp(s.ap_tk, s.sta_tk, 16));
+}
+
 #define IS_ENABLED(config_macro) _IS_ENABLED1(config_macro)
 #define _IS_ENABLED1(config_macro) _IS_ENABLED2(_XXXX##config_macro)
 #define _XXXX1 _YYYY,
@@ -3913,6 +4044,10 @@ int main(int argc, char *argv[])
 			&eapol_ap_sta_handshake_test, NULL);
 	l_test_add("EAPoL/Supplicant+Authenticator 4-Way Handshake Bad PSK",
 			&eapol_ap_sta_handshake_bad_psk_test, NULL);
+	l_test_add("EAPoL/Supplicant+Authenticator IP Allocation OK",
+			&eapol_ap_sta_handshake_ip_alloc_ok_test, NULL);
+	l_test_add("EAPoL/Supplicant+Authenticator IP Allocation no request",
+			&eapol_ap_sta_handshake_ip_alloc_no_req_test, NULL);
 =

 done:
 	return l_test_run();
-- =

2.25.1

--===============6289611505392954095==--

