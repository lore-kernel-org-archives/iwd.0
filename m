Content-Type: multipart/mixed; boundary="===============8674605876434030593=="
MIME-Version: 1.0
From: Andrew Zaborowski <balrogg@gmail.com>
Subject: [PATCH 05/11] unit: Update test-wsc to use
 handshake_state_set_eap_event_func
Date: Mon, 21 Oct 2019 15:55:04 +0200
Message-ID: <20191021135510.12657-5-balrogg@gmail.com>
In-Reply-To: <20191021135510.12657-1-balrogg@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8674605876434030593==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Andrew Zaborowski <andrew.zaborowski@intel.com>

---
 unit/test-wsc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/unit/test-wsc.c b/unit/test-wsc.c
index b4814622..76f5e18e 100644
--- a/unit/test-wsc.c
+++ b/unit/test-wsc.c
@@ -1999,11 +1999,10 @@ static void wsc_test_pbc_handshake(const void *data)
 	handshake_state_set_authenticator_address(hs, ap_address);
 	handshake_state_set_supplicant_address(hs, sta_address);
 	handshake_state_set_event_func(hs, verify_handshake_event, &verify);
+	handshake_state_set_eap_event_func(hs, verify_credential, &verify);
 =

 	__eapol_set_tx_packet_func(verify_8021x);
 	__eapol_set_tx_user_data(&verify);
-	eapol_sm_set_user_data(sm, &verify);
-	eapol_sm_set_event_func(sm, verify_credential);
 =

 	settings =3D l_settings_new();
 	l_settings_set_uint(settings, "EAP", "mtu", 1400);
@@ -2109,11 +2108,10 @@ static void wsc_test_retransmission_no_fragmentatio=
n(const void *data)
 	handshake_state_set_authenticator_address(hs, ap_address);
 	handshake_state_set_supplicant_address(hs, sta_address);
 	handshake_state_set_event_func(hs, verify_handshake_event, &verify);
+	handshake_state_set_eap_event_func(hs, verify_credential, &verify);
 =

 	__eapol_set_tx_packet_func(verify_8021x);
 	__eapol_set_tx_user_data(&verify);
-	eapol_sm_set_user_data(sm, &verify);
-	eapol_sm_set_event_func(sm, verify_credential);
 =

 	settings =3D l_settings_new();
 	l_settings_set_uint(settings, "EAP", "mtu", 1400);
-- =

2.20.1

--===============8674605876434030593==--

