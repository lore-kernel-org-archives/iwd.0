Content-Type: multipart/mixed; boundary="===============4104847478297036309=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 09/16] unit: Update event handler in WSC, eapol tests
Date: Mon, 28 Oct 2019 15:05:01 +0100
Message-ID: <20191028140508.13518-9-andrew.zaborowski@intel.com>
In-Reply-To: <20191028140508.13518-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4104847478297036309==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-eapol.c |  2 +-
 unit/test-wsc.c   | 42 +++++++++++++++++++-----------------------
 2 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/unit/test-eapol.c b/unit/test-eapol.c
index 6760db6d..41bce402 100644
--- a/unit/test-eapol.c
+++ b/unit/test-eapol.c
@@ -2871,7 +2871,7 @@ static void eapol_sm_test_tls_test_disconnected(enum =
l_tls_alert_desc reason,
 =

 static void test_handshake_event(struct handshake_state *hs,
 					enum handshake_event event,
-					void *event_data, void *user_data)
+					void *user_data, ...)
 {
 	struct test_handshake_state *ths =3D
 			l_container_of(hs, struct test_handshake_state, super);
diff --git a/unit/test-wsc.c b/unit/test-wsc.c
index f11dce0d..0e845dc2 100644
--- a/unit/test-wsc.c
+++ b/unit/test-wsc.c
@@ -1931,16 +1931,32 @@ struct verify_data {
 	verify.expected_len =3D sizeof(e)
 =

 static void verify_handshake_event(struct handshake_state *hs,
-		enum handshake_event event, void *event_data, void *user_data)
+					enum handshake_event event,
+					void *user_data, ...)
 {
 	struct verify_data *data =3D user_data;
+	va_list args;
+
+	va_start(args, user_data);
 =

 	switch (event) {
 	case HANDSHAKE_EVENT_FAILED:
-		assert(l_get_u16(event_data) =3D=3D
-				MMPDU_REASON_CODE_IEEE8021X_FAILED);
+		assert(va_arg(args, int) =3D=3D MMPDU_REASON_CODE_IEEE8021X_FAILED);
 		data->eapol_failed =3D true;
 		break;
+	case HANDSHAKE_EVENT_EAP_NOTIFY:
+	{
+		const struct wsc_credential *cred;
+
+		assert(va_arg(args, unsigned int) !=3D
+			EAP_WSC_EVENT_CREDENTIAL_OBTAINED);
+
+		cred =3D va_arg(args, const struct wsc_credential *);
+		assert(!memcmp(cred, data->expected_creds + data->cur_cred,
+						sizeof(struct wsc_credential)));
+
+		data->cur_cred +=3D 1;
+	}
 	default:
 		break;
 	}
@@ -1963,22 +1979,6 @@ static int verify_8021x(uint32_t ifindex,
 	return 0;
 }
 =

-static void verify_credential(unsigned int event, const void *event_data,
-					void *user_data)
-{
-	struct verify_data *data =3D user_data;
-	const struct wsc_credential *cred;
-
-	if (event !=3D EAP_WSC_EVENT_CREDENTIAL_OBTAINED)
-		assert(false);
-
-	cred =3D event_data;
-	assert(!memcmp(cred, data->expected_creds + data->cur_cred,
-						sizeof(struct wsc_credential)));
-
-	data->cur_cred +=3D 1;
-}
-
 static void wsc_test_pbc_handshake(const void *data)
 {
 	static uint8_t ap_address[] =3D { 0x24, 0xa2, 0xe1, 0xec, 0x17, 0x04 };
@@ -2002,8 +2002,6 @@ static void wsc_test_pbc_handshake(const void *data)
 =

 	__eapol_set_tx_packet_func(verify_8021x);
 	__eapol_set_tx_user_data(&verify);
-	eapol_sm_set_user_data(sm, &verify);
-	eapol_sm_set_event_func(sm, verify_credential);
 =

 	settings =3D l_settings_new();
 	l_settings_set_string(settings, "Security", "EAP-Identity",
@@ -2110,8 +2108,6 @@ static void wsc_test_retransmission_no_fragmentation(=
const void *data)
 =

 	__eapol_set_tx_packet_func(verify_8021x);
 	__eapol_set_tx_user_data(&verify);
-	eapol_sm_set_user_data(sm, &verify);
-	eapol_sm_set_event_func(sm, verify_credential);
 =

 	settings =3D l_settings_new();
 	l_settings_set_string(settings, "Security", "EAP-Identity",
-- =

2.20.1

--===============4104847478297036309==--

