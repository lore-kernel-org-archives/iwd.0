Content-Type: multipart/mixed; boundary="===============0155969483472285629=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/5] unit: Use hs_override_pairwise_cipher in eapol
 authenticator tests
Date: Sat, 30 Jan 2021 00:27:40 +0100
Message-ID: <20210129232740.27393-5-andrew.zaborowski@intel.com>
In-Reply-To: <20210129232740.27393-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0155969483472285629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-eapol.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/unit/test-eapol.c b/unit/test-eapol.c
index eba249ed..6032fc5b 100644
--- a/unit/test-eapol.c
+++ b/unit/test-eapol.c
@@ -3682,6 +3682,8 @@ static void eapol_ap_sta_handshake_test(const void *d=
ata)
 	handshake_state_set_authenticator_ie(s.ap_hs, ap_rsne);
 	handshake_state_set_ssid(s.ap_hs, (void *) ssid, strlen(ssid));
 	handshake_state_set_pmk(s.ap_hs, psk, 32);
+	handshake_state_override_pairwise_cipher(s.ap_hs,
+						IE_RSN_CIPHER_SUITE_CCMP);
 =

 	handshake_state_set_authenticator(s.sta_hs, false);
 	handshake_state_set_event_func(s.sta_hs, test_ap_sta_hs_event, &s);
@@ -3743,6 +3745,8 @@ static void eapol_ap_sta_handshake_bad_psk_test(const=
 void *data)
 	handshake_state_set_authenticator_ie(s.ap_hs, ap_rsne);
 	handshake_state_set_ssid(s.ap_hs, (void *) ssid, strlen(ssid));
 	handshake_state_set_pmk(s.ap_hs, psk1, 32);
+	handshake_state_override_pairwise_cipher(s.ap_hs,
+						IE_RSN_CIPHER_SUITE_CCMP);
 =

 	handshake_state_set_authenticator(s.sta_hs, false);
 	handshake_state_set_event_func(s.sta_hs, test_ap_sta_hs_event, &s);
@@ -3804,6 +3808,8 @@ static void eapol_ap_sta_handshake_ip_alloc_ok_test(c=
onst void *data)
 	handshake_state_set_authenticator_ie(s.ap_hs, ap_rsne);
 	handshake_state_set_ssid(s.ap_hs, (void *) ssid, strlen(ssid));
 	handshake_state_set_pmk(s.ap_hs, psk, 32);
+	handshake_state_override_pairwise_cipher(s.ap_hs,
+						IE_RSN_CIPHER_SUITE_CCMP);
 	s.ap_hs->support_ip_allocation =3D true;
 	s.ap_hs->client_ip_addr =3D 0x01020304;
 	s.ap_hs->subnet_mask =3D 0xffff0000;
@@ -3871,6 +3877,8 @@ static void eapol_ap_sta_handshake_ip_alloc_no_req_te=
st(const void *data)
 	handshake_state_set_authenticator_ie(s.ap_hs, ap_rsne);
 	handshake_state_set_ssid(s.ap_hs, (void *) ssid, strlen(ssid));
 	handshake_state_set_pmk(s.ap_hs, psk, 32);
+	handshake_state_override_pairwise_cipher(s.ap_hs,
+						IE_RSN_CIPHER_SUITE_CCMP);
 	s.ap_hs->support_ip_allocation =3D true;
 	s.ap_hs->client_ip_addr =3D 0x01020304;
 	s.ap_hs->subnet_mask =3D 0xffff0000;
-- =

2.20.1

--===============0155969483472285629==--

