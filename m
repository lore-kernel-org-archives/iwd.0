Content-Type: multipart/mixed; boundary="===============7485286734179162417=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 2/4] peap: Add inner EAP key material into imsk calculation
Date: Fri, 31 Jan 2020 14:25:15 -0800
Message-ID: <20200131222517.8182-2-tim.a.kourt@linux.intel.com>
In-Reply-To: <20200131222517.8182-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7485286734179162417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For the inner EAP methods that support generation of the key material
include it into imck generation. This allows to cryptographically
bind the inner method with the tunnel.
---
 src/eap-peap.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/src/eap-peap.c b/src/eap-peap.c
index 005eacc4..6decbfb3 100644
--- a/src/eap-peap.c
+++ b/src/eap-peap.c
@@ -46,8 +46,23 @@ struct peap_state {
 	struct eap_state *phase2;
 =

 	uint8_t key[128];
+	uint8_t isk[32];
 };
 =

+static void eap_peap_phase2_key_ready(const uint8_t *msk_data, size_t msk_=
len,
+				const uint8_t *emsk_data, size_t emsk_len,
+				const uint8_t *iv, size_t iv_len,
+				const uint8_t *session_id, size_t session_len,
+				void *user_data)
+{
+	struct peap_state *peap_state =3D
+				eap_tls_common_get_variant_data(user_data);
+
+	l_debug("PEAP: New ISK received");
+
+	memcpy(peap_state->isk, msk_data, sizeof(peap_state->isk));
+}
+
 static void eap_peap_phase2_send_response(const uint8_t *pdu, size_t pdu_l=
en,
 								void *user_data)
 {
@@ -103,6 +118,7 @@ static void eap_peap_phase2_complete(enum eap_result re=
sult, void *user_data)
 	eap_set_key_material(eap, peap_state->key + 0, 64, NULL, 0, NULL,
 								0, NULL, 0);
 	explicit_bzero(peap_state->key, sizeof(peap_state->key));
+	explicit_bzero(peap_state->isk, sizeof(peap_state->isk));
 =

 	eap_method_success(eap);
 }
@@ -144,12 +160,9 @@ static bool cryptobinding_tlv_generate_imck(struct eap=
_state *eap,
 {
 	struct peap_state *peap_state =3D eap_tls_common_get_variant_data(eap);
 	static const char *label =3D "Inner Methods Compound Keys";
-	uint8_t isk[32];
-
-	memset(isk, 0, sizeof(isk));
 =

 	if (!prf_plus_sha1(peap_state->key, 40, label, strlen(label),
-					isk, sizeof(isk), imck_out, 60))
+					peap_state->isk, 32, imck_out, 60))
 		return false;
 =

 	return true;
@@ -441,6 +454,7 @@ static void eap_extensions_handle_request(struct eap_st=
ate *eap,
 	eap_set_key_material(eap, peap_state->key + 0, 64, NULL, 0, NULL,
 								0, NULL, 0);
 	explicit_bzero(peap_state->key, sizeof(peap_state->key));
+	explicit_bzero(peap_state->isk, sizeof(peap_state->isk));
 =

 	eap_method_success(eap);
 }
@@ -528,6 +542,7 @@ static void eap_peap_state_reset(void *variant_data)
 	eap_reset(peap_state->phase2);
 =

 	explicit_bzero(peap_state->key, sizeof(peap_state->key));
+	explicit_bzero(peap_state->isk, sizeof(peap_state->isk));
 }
 =

 static void eap_peap_state_destroy(void *variant_data)
@@ -541,6 +556,7 @@ static void eap_peap_state_destroy(void *variant_data)
 	eap_free(peap_state->phase2);
 =

 	explicit_bzero(peap_state->key, sizeof(peap_state->key));
+	explicit_bzero(peap_state->isk, sizeof(peap_state->isk));
 =

 	l_free(peap_state);
 }
@@ -604,6 +620,8 @@ static bool eap_peap_settings_load(struct eap_state *ea=
p,
 =

 	peap_state =3D l_new(struct peap_state, 1);
 	peap_state->phase2 =3D phase2;
+	eap_set_key_material_func(peap_state->phase2,
+						eap_peap_phase2_key_ready);
 =

 	snprintf(setting_key_prefix, sizeof(setting_key_prefix), "%sPEAP-",
 									prefix);
-- =

2.13.6

--===============7485286734179162417==--

