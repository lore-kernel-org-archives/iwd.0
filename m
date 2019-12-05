Content-Type: multipart/mixed; boundary="===============4358111218718817734=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 2/6] peap: Delay key installation until success of Phase 2
Date: Thu, 05 Dec 2019 13:13:50 -0800
Message-ID: <20191205211354.19075-2-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191205211354.19075-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4358111218718817734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Previously, the key was installed once the runnel was created
despite the outcome of the second authentication phase. Now, the
key installation is delayed until the successful completion of
the second authentication phase. This excludes the unnecessary
operations in the case of a failure and key reinstallation with
cypro-binding in use.
---
 src/eap-peap.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/src/eap-peap.c b/src/eap-peap.c
index c400ddee..eb0b0c5f 100644
--- a/src/eap-peap.c
+++ b/src/eap-peap.c
@@ -43,6 +43,8 @@
 =

 struct peap_state {
 	struct eap_state *phase2;
+
+	uint8_t key[128];
 };
 =

 static void eap_peap_phase2_send_response(const uint8_t *pdu, size_t pdu_l=
en,
@@ -66,6 +68,7 @@ static void eap_peap_phase2_send_response(const uint8_t *=
pdu, size_t pdu_len,
 static void eap_peap_phase2_complete(enum eap_result result, void *user_da=
ta)
 {
 	struct eap_state *eap =3D user_data;
+	struct peap_state *peap_state;
 =

 	l_debug("result: %d", result);
 =

@@ -94,6 +97,12 @@ static void eap_peap_phase2_complete(enum eap_result res=
ult, void *user_data)
 		return;
 	}
 =

+	peap_state =3D eap_tls_common_get_variant_data(eap);
+
+	eap_set_key_material(eap, peap_state->key + 0, 64, NULL, 0, NULL,
+								0, NULL, 0);
+	explicit_bzero(peap_state->key, sizeof(peap_state->key));
+
 	eap_method_success(eap);
 }
 =

@@ -174,6 +183,7 @@ static void eap_extensions_handle_request(struct eap_st=
ate *eap,
 							const uint8_t *pkt,
 							size_t len)
 {
+	struct peap_state *peap_state;
 	uint8_t response[EAP_EXTENSIONS_HEADER_LEN +
 					EAP_EXTENSIONS_AVP_HEADER_LEN + 2];
 	int r =3D eap_extensions_handle_result_avp(eap, pkt, len, response);
@@ -199,13 +209,19 @@ static void eap_extensions_handle_request(struct eap_=
state *eap,
 		return;
 	}
 =

+	peap_state =3D eap_tls_common_get_variant_data(eap);
+
+	eap_set_key_material(eap, peap_state->key + 0, 64, NULL, 0, NULL,
+								0, NULL, 0);
+	explicit_bzero(peap_state->key, sizeof(peap_state->key));
+
 	eap_method_success(eap);
 }
 =

 static bool eap_peap_tunnel_ready(struct eap_state *eap,
 						const char *peer_identity)
 {
-	uint8_t msk_emsk[128];
+	struct peap_state *peap_state =3D eap_tls_common_get_variant_data(eap);
 =

 	/*
 	* PEAPv1: draft-josefsson-pppext-eap-tls-eap-05, Section 2.1.1
@@ -217,10 +233,7 @@ static bool eap_peap_tunnel_ready(struct eap_state *ea=
p,
 =

 	/* MSK, EMSK and challenge derivation */
 	eap_tls_common_tunnel_prf_get_bytes(eap, true, "client EAP encryption",
-								msk_emsk, 128);
-
-	eap_set_key_material(eap, msk_emsk + 0, 64, NULL, 0, NULL, 0, NULL, 0);
-	explicit_bzero(msk_emsk, sizeof(msk_emsk));
+						peap_state->key, 128);
 =

 	eap_tls_common_send_empty_response(eap);
 =

@@ -286,6 +299,8 @@ static void eap_peap_state_reset(void *variant_data)
 		return;
 =

 	eap_reset(peap_state->phase2);
+
+	explicit_bzero(peap_state->key, sizeof(peap_state->key));
 }
 =

 static void eap_peap_state_destroy(void *variant_data)
@@ -298,6 +313,8 @@ static void eap_peap_state_destroy(void *variant_data)
 	eap_reset(peap_state->phase2);
 	eap_free(peap_state->phase2);
 =

+	explicit_bzero(peap_state->key, sizeof(peap_state->key));
+
 	l_free(peap_state);
 }
 =

-- =

2.13.6

--===============4358111218718817734==--

