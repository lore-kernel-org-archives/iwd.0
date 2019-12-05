Content-Type: multipart/mixed; boundary="===============7766711337738231564=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 1/6] peap: Introduce PEAP state
Date: Thu, 05 Dec 2019 13:13:49 -0800
Message-ID: <20191205211354.19075-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7766711337738231564==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Introduction of the state struct will allow to hold the additional
state variables related to the implementation of PEAP.
---
 src/eap-peap.c | 44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/src/eap-peap.c b/src/eap-peap.c
index 16ab0319..c400ddee 100644
--- a/src/eap-peap.c
+++ b/src/eap-peap.c
@@ -41,6 +41,10 @@
  * PEAPv1: draft-josefsson-pppext-eap-tls-eap-05
  */
 =

+struct peap_state {
+	struct eap_state *phase2;
+};
+
 static void eap_peap_phase2_send_response(const uint8_t *pdu, size_t pdu_l=
en,
 								void *user_data)
 {
@@ -116,6 +120,7 @@ static int eap_extensions_handle_result_avp(struct eap_=
state *eap,
 						size_t data_len,
 						uint8_t *response)
 {
+	struct peap_state *peap_state;
 	uint16_t type;
 	uint16_t len;
 	uint16_t result;
@@ -143,8 +148,9 @@ static int eap_extensions_handle_result_avp(struct eap_=
state *eap,
 =

 	switch (result) {
 	case EAP_EXTENSIONS_RESULT_SUCCCESS:
-		result =3D eap_method_is_success(
-				eap_tls_common_get_variant_data(eap)) ?
+		peap_state =3D eap_tls_common_get_variant_data(eap);
+
+		result =3D eap_method_is_success(peap_state->phase2) ?
 					EAP_EXTENSIONS_RESULT_SUCCCESS :
 					EAP_EXTENSIONS_RESULT_FAILURE;
 		/* fall through */
@@ -225,6 +231,7 @@ static bool eap_peap_tunnel_handle_request(struct eap_s=
tate *eap,
 							const uint8_t *pkt,
 								size_t len)
 {
+	struct peap_state *peap_state;
 	uint8_t id;
 =

 	if (len > 4 && pkt[4] =3D=3D EAP_TYPE_EXTENSIONS) {
@@ -247,6 +254,8 @@ static bool eap_peap_tunnel_handle_request(struct eap_s=
tate *eap,
 		return true;
 	}
 =

+	peap_state =3D eap_tls_common_get_variant_data(eap);
+
 	if (eap_tls_common_get_negotiated_version(eap) =3D=3D EAP_TLS_VERSION_0) {
 		if (len < 1)
 			return false;
@@ -259,32 +268,37 @@ static bool eap_peap_tunnel_handle_request(struct eap=
_state *eap,
 		 */
 		eap_save_last_id(eap, &id);
 =

-		__eap_handle_request(eap_tls_common_get_variant_data(eap), id,
-								pkt, len);
+		__eap_handle_request(peap_state->phase2, id, pkt, len);
 =

 		return true;
 	}
 =

-	eap_rx_packet(eap_tls_common_get_variant_data(eap), pkt, len);
+	eap_rx_packet(peap_state->phase2, pkt, len);
 =

 	return true;
 }
 =

-static void eap_peap_state_reset(void *phase2)
+static void eap_peap_state_reset(void *variant_data)
 {
-	if (!phase2)
+	struct peap_state *peap_state =3D variant_data;
+
+	if (!peap_state)
 		return;
 =

-	eap_reset(phase2);
+	eap_reset(peap_state->phase2);
 }
 =

-static void eap_peap_state_destroy(void *phase2)
+static void eap_peap_state_destroy(void *variant_data)
 {
-	if (!phase2)
+	struct peap_state *peap_state =3D variant_data;
+
+	if (!peap_state)
 		return;
 =

-	eap_reset(phase2);
-	eap_free(phase2);
+	eap_reset(peap_state->phase2);
+	eap_free(peap_state->phase2);
+
+	l_free(peap_state);
 }
 =

 static int eap_peap_settings_check(struct l_settings *settings,
@@ -323,6 +337,7 @@ static bool eap_peap_settings_load(struct eap_state *ea=
p,
 						const char *prefix)
 {
 	char setting_key_prefix[72];
+	struct peap_state *peap_state;
 	void *phase2;
 =

 	phase2 =3D eap_new(eap_peap_phase2_send_response,
@@ -343,11 +358,14 @@ static bool eap_peap_settings_load(struct eap_state *=
eap,
 		return false;
 	}
 =

+	peap_state =3D l_new(struct peap_state, 1);
+	peap_state->phase2 =3D phase2;
+
 	snprintf(setting_key_prefix, sizeof(setting_key_prefix), "%sPEAP-",
 									prefix);
 =

 	if (!eap_tls_common_settings_load(eap, settings, setting_key_prefix,
-							&eap_ttls_ops, phase2))
+						&eap_ttls_ops, peap_state))
 		return false;
 =

 	return true;
-- =

2.13.6

--===============7766711337738231564==--

