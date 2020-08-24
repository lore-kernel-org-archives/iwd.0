Content-Type: multipart/mixed; boundary="===============1104387509755487652=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/5] unit: Test a EAP-WSC-R setup with WPA2 credentials
Date: Tue, 25 Aug 2020 00:34:24 +0200
Message-ID: <20200824223426.475779-3-andrew.zaborowski@intel.com>
In-Reply-To: <20200824223426.475779-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1104387509755487652==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-wsc.c | 275 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 275 insertions(+)

diff --git a/unit/test-wsc.c b/unit/test-wsc.c
index 983570e2..231a7da4 100644
--- a/unit/test-wsc.c
+++ b/unit/test-wsc.c
@@ -2261,6 +2261,278 @@ static void wsc_test_pin_generate(const void *data)
 	}
 }
 =

+struct test_ap_sta_data {
+	struct handshake_state *ap_hs;
+	struct handshake_state *sta_hs;
+	const uint8_t ap_address[6];
+	const uint8_t sta_address[6];
+
+	uint8_t to_sta_data[1024];
+	int to_sta_data_len;
+	int to_sta_msg_cnt;
+	int to_ap_msg_cnt;
+	struct eapol_sm *ap_sm;
+	struct eapol_sm *sta_sm;
+};
+
+static int test_ap_sta_eapol_tx(uint32_t ifindex,
+					const uint8_t *dest, uint16_t proto,
+					const struct eapol_frame *ef,
+					bool noencrypt, void *user_data)
+{
+	struct test_ap_sta_data *s =3D user_data;
+	size_t len =3D sizeof(struct eapol_header) +
+		L_BE16_TO_CPU(ef->header.packet_len);
+
+	assert(ifindex =3D=3D s->ap_hs->ifindex || ifindex =3D=3D s->sta_hs->ifin=
dex);
+	assert(proto =3D=3D ETH_P_PAE && !noencrypt);
+
+	if (ifindex =3D=3D s->ap_hs->ifindex) {	/* From AP to STA */
+		assert(!memcmp(dest, s->sta_address, 6));
+		assert(len < sizeof(s->to_sta_data));
+		memcpy(s->to_sta_data, ef, len);
+		s->to_sta_data_len =3D len;
+		s->to_sta_msg_cnt++;
+		return 0;
+	}
+
+	/* From STA to AP */
+	assert(!memcmp(dest, s->ap_address, 6));
+	s->to_ap_msg_cnt++;
+	__eapol_rx_packet(1, s->sta_address, proto, (const void *) ef, len,
+				noencrypt);
+	return 0;
+}
+
+static void test_ap_sta_run(struct test_ap_sta_data *s)
+{
+	eap_init();
+	eapol_init();
+	__eapol_set_tx_packet_func(test_ap_sta_eapol_tx);
+	__eapol_set_tx_user_data(s);
+
+	s->to_sta_msg_cnt =3D 0;
+	s->to_ap_msg_cnt =3D 0;
+	s->to_sta_data_len =3D 0;
+
+	s->ap_sm =3D eapol_sm_new(s->ap_hs);
+	eapol_register(s->ap_sm);
+
+	s->sta_sm =3D eapol_sm_new(s->sta_hs);
+	eapol_register(s->sta_sm);
+
+	eapol_start(s->sta_sm);
+	eapol_start(s->ap_sm);
+
+	while (s->to_sta_data_len) {
+		int len =3D s->to_sta_data_len;
+		s->to_sta_data_len =3D 0;
+		__eapol_rx_packet(s->sta_hs->ifindex, s->ap_address, ETH_P_PAE,
+					s->to_sta_data, len, false);
+	}
+
+	if (s->ap_sm)
+		eapol_sm_free(s->ap_sm);
+
+	if (s->sta_sm)
+		eapol_sm_free(s->sta_sm);
+
+	eapol_exit();
+	eap_exit();
+}
+
+struct test_ap_sta_hs {
+	struct handshake_state super;
+	struct test_ap_sta_data *s;
+};
+
+static struct handshake_state *test_ap_sta_hs_new(struct test_ap_sta_data =
*s,
+							uint32_t ifindex)
+{
+	struct test_ap_sta_hs *ths =3D l_new(struct test_ap_sta_hs, 1);
+
+	ths->super.ifindex =3D ifindex;
+	ths->super.free =3D (void (*)(struct handshake_state *s)) l_free;
+	ths->s =3D s;
+
+	return &ths->super;
+}
+
+static bool random_nonce(uint8_t nonce[])
+{
+	return l_getrandom(nonce, 32);
+}
+
+static void test_ap_sta_install_tk(struct handshake_state *hs,
+					const uint8_t *tk, uint32_t cipher)
+{
+	assert(false);
+}
+
+struct wsc_r_test_success_data {
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
+	struct wsc_r_test_success_data *data =3D user_data;
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
+		assert(va_arg(args, int) =3D=3D
+			MMPDU_REASON_CODE_IEEE8021X_FAILED);
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
+	struct wsc_r_test_success_data *data =3D user_data;
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
+		assert(va_arg(args, int) =3D=3D
+			MMPDU_REASON_CODE_IEEE8021X_FAILED);
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
+static void wsc_r_test_pbc_handshake_wpa2(const void *data)
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
+	struct wsc_r_test_success_data wsc_data =3D {
+		.s =3D &s,
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
+	assert(wsc_data.sta_eap_failed && wsc_data.credentials_obtained);
+	assert(wsc_data.ap_eap_failed && wsc_data.credentials_sent);
+}
+
 int main(int argc, char *argv[])
 {
 	l_test_init(&argc, &argv);
@@ -2374,6 +2646,9 @@ int main(int argc, char *argv[])
 	l_test_add("/wsc/retransmission/no fragmentation",
 				wsc_test_retransmission_no_fragmentation, NULL);
 =

+	l_test_add("/wsc-r/handshake/PBC Handshake WPA2 Test",
+				wsc_r_test_pbc_handshake_wpa2, NULL);
+
 done:
 	return l_test_run();
 }
-- =

2.25.1

--===============1104387509755487652==--

