Content-Type: multipart/mixed; boundary="===============4365432831107620328=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 09/10] unit: Authenticator 4-way handshake error scenario
Date: Mon, 17 Aug 2020 12:06:46 +0200
Message-ID: <20200817100647.338184-9-andrew.zaborowski@intel.com>
In-Reply-To: <20200817100647.338184-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4365432831107620328==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-eapol.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/unit/test-eapol.c b/unit/test-eapol.c
index 022f9e4a..08c1085e 100644
--- a/unit/test-eapol.c
+++ b/unit/test-eapol.c
@@ -3703,6 +3703,72 @@ static void eapol_ap_sta_handshake_test(const void *=
data)
 	assert(!memcmp(s.ap_tk, s.sta_tk, 16));
 }
 =

+static void eapol_ap_sta_handshake_bad_psk_test(const void *data)
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
+	static const uint8_t psk1[32] =3D {	/* secretsecret */
+		0x6a, 0xa3, 0xf0, 0x0b, 0x68, 0xbd, 0x8b, 0x46,
+		0x69, 0x83, 0xa5, 0x29, 0xa3, 0xfa, 0x57, 0x1c,
+		0x6c, 0x7b, 0x72, 0x41, 0x1d, 0xce, 0x33, 0x02,
+		0xa2, 0x2d, 0xdf, 0x77, 0xd1, 0x93, 0xdb, 0x5f };
+	static const uint8_t psk2[32] =3D {	/* wrongpasswd */
+		0x04, 0x86, 0x45, 0x37, 0x4c, 0x95, 0xdd, 0x1e,
+		0x96, 0xbb, 0xdf, 0x12, 0x0a, 0x1c, 0x4c, 0x5b,
+		0x6d, 0x22, 0xc1, 0x1c, 0xa2, 0xe0, 0x15, 0x99,
+		0xbf, 0x82, 0x10, 0xd3, 0x59, 0x2c, 0xfb, 0x2d };
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
+	handshake_state_set_pmk(s.ap_hs, psk1, 32);
+
+	handshake_state_set_authenticator(s.sta_hs, false);
+	handshake_state_set_event_func(s.sta_hs, test_ap_sta_hs_event, &s);
+	handshake_state_set_authenticator_address(s.sta_hs, s.ap_address);
+	handshake_state_set_supplicant_address(s.sta_hs, s.sta_address);
+	handshake_state_set_supplicant_ie(s.sta_hs, sta_rsne);
+	handshake_state_set_authenticator_ie(s.sta_hs, ap_rsne);
+	handshake_state_set_ssid(s.sta_hs, (void *) ssid, strlen(ssid));
+	handshake_state_set_pmk(s.sta_hs, psk2, 32);
+
+	test_ap_sta_run(&s);
+
+	handshake_state_free(s.ap_hs);
+	handshake_state_free(s.sta_hs);
+	__handshake_set_install_tk_func(NULL);
+
+	/*
+	 * There should have been 2 EAPoL-Key frame exchanged: 1/4 and
+	 * 2/4 after which the AP will have detected wrong MIC and not
+	 * sent any more messages with both sides waiting for the
+	 * timeout.
+	 */
+	assert(!s.ap_success && !s.sta_success);
+	assert(s.to_ap_msg_cnt =3D=3D 1 && s.to_sta_msg_cnt =3D=3D 1);
+}
+
 #define IS_ENABLED(config_macro) _IS_ENABLED1(config_macro)
 #define _IS_ENABLED1(config_macro) _IS_ENABLED2(_XXXX##config_macro)
 #define _XXXX1 _YYYY,
@@ -3845,6 +3911,8 @@ int main(int argc, char *argv[])
 =

 	l_test_add("EAPoL/Supplicant+Authenticator 4-Way Handshake",
 			&eapol_ap_sta_handshake_test, NULL);
+	l_test_add("EAPoL/Supplicant+Authenticator 4-Way Handshake Bad PSK",
+			&eapol_ap_sta_handshake_bad_psk_test, NULL);
 =

 done:
 	return l_test_run();
-- =

2.25.1

--===============4365432831107620328==--

