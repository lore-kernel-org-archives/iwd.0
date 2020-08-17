Content-Type: multipart/mixed; boundary="===============2357094941606974679=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 08/10] unit: Add an authenticator-side 4-Way Handshake test
Date: Mon, 17 Aug 2020 12:06:45 +0200
Message-ID: <20200817100647.338184-8-andrew.zaborowski@intel.com>
In-Reply-To: <20200817100647.338184-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2357094941606974679==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Test the eapol.c code responsible for the access point mode 4-way
handshake with correct IEs and PSK on both sides (success scenario).
---
 unit/test-eapol.c | 193 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 193 insertions(+)

diff --git a/unit/test-eapol.c b/unit/test-eapol.c
index f6af6f06..022f9e4a 100644
--- a/unit/test-eapol.c
+++ b/unit/test-eapol.c
@@ -3513,6 +3513,196 @@ static void eapol_ft_handshake_test(const void *dat=
a)
 	eapol_exit();
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
+	uint8_t ap_tk[32];
+	uint8_t sta_tk[32];
+	bool ap_success;
+	bool sta_success;
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
+	s->ap_success =3D false;
+	s->sta_success =3D false;
+	s->to_sta_msg_cnt =3D 0;
+	s->to_ap_msg_cnt =3D 0;
+	s->to_sta_data_len =3D 0,
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
+static void test_ap_sta_hs_event(struct handshake_state *hs,
+				enum handshake_event event,
+				void *user_data, ...)
+{
+	assert(event !=3D HANDSHAKE_EVENT_FAILED);
+}
+
+static void test_ap_sta_install_tk(struct handshake_state *hs,
+					const uint8_t *tk, uint32_t cipher)
+{
+	struct test_ap_sta_hs *ths =3D
+		l_container_of(hs, struct test_ap_sta_hs, super);
+	assert(hs =3D=3D ths->s->ap_hs || hs =3D=3D ths->s->sta_hs);
+	assert(cipher =3D=3D CRYPTO_CIPHER_CCMP);
+
+	if (hs =3D=3D ths->s->ap_hs) {
+		assert(!ths->s->ap_success);
+		memcpy(ths->s->ap_tk, tk, 16);
+		ths->s->ap_success =3D true;
+	} else {
+		assert(!ths->s->sta_success);
+		memcpy(ths->s->sta_tk, tk, 16);
+		ths->s->sta_success =3D true;
+	}
+}
+
+static void eapol_ap_sta_handshake_test(const void *data)
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
+
+	handshake_state_set_authenticator(s.sta_hs, false);
+	handshake_state_set_event_func(s.sta_hs, test_ap_sta_hs_event, &s);
+	handshake_state_set_authenticator_address(s.sta_hs, s.ap_address);
+	handshake_state_set_supplicant_address(s.sta_hs, s.sta_address);
+	handshake_state_set_supplicant_ie(s.sta_hs, sta_rsne);
+	handshake_state_set_authenticator_ie(s.sta_hs, ap_rsne);
+	handshake_state_set_ssid(s.sta_hs, (void *) ssid, strlen(ssid));
+	handshake_state_set_pmk(s.sta_hs, psk, 32);
+
+	test_ap_sta_run(&s);
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
@@ -3653,6 +3843,9 @@ int main(int argc, char *argv[])
 	l_test_add("EAPoL/FT-Using-PSK 4-Way Handshake",
 			&eapol_ft_handshake_test, NULL);
 =

+	l_test_add("EAPoL/Supplicant+Authenticator 4-Way Handshake",
+			&eapol_ap_sta_handshake_test, NULL);
+
 done:
 	return l_test_run();
 }
-- =

2.25.1

--===============2357094941606974679==--

