Content-Type: multipart/mixed; boundary="===============8028465391949869957=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 11/12] unit: update wsc/eapol with new eap_init
Date: Fri, 11 Oct 2019 12:29:32 -0700
Message-ID: <20191011192933.13550-11-prestwoj@gmail.com>
In-Reply-To: <20191011192933.13550-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8028465391949869957==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

test-eapol was passing zero as the MTU, so this simply needed to be
updated to remove that parameter.

test-wsc was actually setting a MTU value so when building the
settings we now add the proper value so the MTU can be set with
__eap_set_config.
---
 unit/test-eapol.c | 4 ++--
 unit/test-wsc.c   | 8 ++++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/unit/test-eapol.c b/unit/test-eapol.c
index 177b2577..f7099e6d 100644
--- a/unit/test-eapol.c
+++ b/unit/test-eapol.c
@@ -2912,7 +2912,7 @@ static void eapol_sm_test_tls(struct eapol_8021x_tls_=
test_state *s,
 	aa =3D ap_address;
 	spa =3D sta_address;
 =

-	eap_init(0);
+	eap_init();
 	eapol_init();
 	__handshake_set_get_nonce_func(test_nonce);
 =

@@ -3375,7 +3375,7 @@ static void eapol_sm_test_eap_nak(const void *data)
 	aa =3D ap_address;
 	spa =3D sta_address;
 =

-	eap_init(0);
+	eap_init();
 	eapol_init();
 	__handshake_set_get_nonce_func(test_nonce);
 =

diff --git a/unit/test-wsc.c b/unit/test-wsc.c
index b1a6d786..b4814622 100644
--- a/unit/test-wsc.c
+++ b/unit/test-wsc.c
@@ -1989,7 +1989,7 @@ static void wsc_test_pbc_handshake(const void *data)
 	char *hex;
 	struct l_settings *settings;
 =

-	eap_init(1400);
+	eap_init();
 	eapol_init();
 =

 	hs =3D test_handshake_state_new(1);
@@ -2006,6 +2006,7 @@ static void wsc_test_pbc_handshake(const void *data)
 	eapol_sm_set_event_func(sm, verify_credential);
 =

 	settings =3D l_settings_new();
+	l_settings_set_uint(settings, "EAP", "mtu", 1400);
 	l_settings_set_string(settings, "Security", "EAP-Identity",
 					"WFA-SimpleConfig-Enrollee-1-0");
 	l_settings_set_string(settings, "Security", "EAP-Method", "WSC");
@@ -2039,6 +2040,7 @@ static void wsc_test_pbc_handshake(const void *data)
 	l_settings_set_string(settings, "WSC", "IV2",
 					"4e3a4cf088176989e148d4c10b96e8fd");
 =

+	__eap_set_config(settings);
 	handshake_state_set_8021x_config(hs, settings);
 	eapol_start(sm);
 =

@@ -2097,7 +2099,7 @@ static void wsc_test_retransmission_no_fragmentation(=
const void *data)
 	char *hex;
 	struct l_settings *settings;
 =

-	eap_init(1400);
+	eap_init();
 	eapol_init();
 =

 	hs =3D test_handshake_state_new(1);
@@ -2114,6 +2116,7 @@ static void wsc_test_retransmission_no_fragmentation(=
const void *data)
 	eapol_sm_set_event_func(sm, verify_credential);
 =

 	settings =3D l_settings_new();
+	l_settings_set_uint(settings, "EAP", "mtu", 1400);
 	l_settings_set_string(settings, "Security", "EAP-Identity",
 					"WFA-SimpleConfig-Enrollee-1-0");
 	l_settings_set_string(settings, "Security", "EAP-Method", "WSC");
@@ -2147,6 +2150,7 @@ static void wsc_test_retransmission_no_fragmentation(=
const void *data)
 	l_settings_set_string(settings, "WSC", "IV2",
 					"4e3a4cf088176989e148d4c10b96e8fd");
 =

+	__eap_set_config(settings);
 	handshake_state_set_8021x_config(hs, settings);
 	eapol_start(sm);
 =

-- =

2.17.1

--===============8028465391949869957==--

