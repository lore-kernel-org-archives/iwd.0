Content-Type: multipart/mixed; boundary="===============7761901895280780153=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 03/10] eap: Add authenticator method logic and API
Date: Mon, 17 Aug 2020 12:06:40 +0200
Message-ID: <20200817100647.338184-3-andrew.zaborowski@intel.com>
In-Reply-To: <20200817100647.338184-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7761901895280780153==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The goal is to add specifically EAP-WSC registrar side and it looks like
extending our EAP and EAPoL code to support both supplicant and
authenticator-side methods is simpler than adding just EAP-WSC as a
special case.

Since EAP-WSC always ends in an EAP failure, I haven't actually tested
the success path.
---
v2: Added an eap_start to send the Request/Identity from there instead
  of doing it directly at the end of eap_load_settings.
---
 src/eap-private.h |   5 ++
 src/eap.c         | 211 +++++++++++++++++++++++++++++++++++++++++++++-
 src/eap.h         |   1 +
 3 files changed, 214 insertions(+), 3 deletions(-)

diff --git a/src/eap-private.h b/src/eap-private.h
index 65ee871d..5121a330 100644
--- a/src/eap-private.h
+++ b/src/eap-private.h
@@ -81,6 +81,10 @@ struct eap_method {
 	void (*handle_retransmit)(struct eap_state *eap,
 				const uint8_t *pkt, size_t len);
 	const char *(*get_identity)(struct eap_state *eap);
+
+	bool (*validate_identity)(struct eap_state *eap, const char *identity);
+	void (*handle_response)(struct eap_state *eap,
+				const uint8_t *pkt, size_t len);
 };
 =

 struct eap_method_desc {
@@ -123,6 +127,7 @@ void eap_set_key_material(struct eap_state *eap,
 void eap_start_complete_timeout(struct eap_state *eap);
 =

 void eap_method_respond(struct eap_state *eap, uint8_t *buf, size_t len);
+void eap_method_new_request(struct eap_state *eap, uint8_t *buf, size_t le=
n);
 bool eap_method_is_success(struct eap_state *eap);
 void eap_method_success(struct eap_state *eap);
 void eap_method_error(struct eap_state *eap);
diff --git a/src/eap.c b/src/eap.c
index d3bfa4e3..fcc18c77 100644
--- a/src/eap.c
+++ b/src/eap.c
@@ -32,6 +32,7 @@
 =

 #include "src/missing.h"
 #include "src/module.h"
+#include "src/util.h"
 #include "src/eap.h"
 #include "src/eap-private.h"
 #include "src/iwd.h"
@@ -56,6 +57,7 @@ struct eap_state {
 =

 	struct eap_method *method;
 	char *identity;
+	bool authenticator;
 =

 	int last_id;
 	void *method_state;
@@ -193,6 +195,19 @@ void eap_method_respond(struct eap_state *eap, uint8_t=
 *buf, size_t len)
 	eap_send_response(eap, eap->method->request_type, buf, len);
 }
 =

+void eap_method_new_request(struct eap_state *eap, uint8_t *buf, size_t le=
n)
+{
+	buf[4] =3D eap->method->request_type;
+
+	if (eap->method->request_type =3D=3D EAP_TYPE_EXPANDED) {
+		memcpy(buf + 5, eap->method->vendor_id, 3);
+		l_put_be32(eap->method->vendor_type, buf + 8);
+	}
+
+	/* TODO: Save copy for retransmissions, set timer, increment counter */
+	eap_send_packet(eap, EAP_CODE_REQUEST, ++eap->last_id, buf, len);
+}
+
 static void eap_complete_timeout(struct l_timeout *timeout, void *user_dat=
a)
 {
 	struct eap_state *eap =3D user_data;
@@ -225,6 +240,17 @@ static void eap_send_identity_response(struct eap_stat=
e *eap, char *identity)
 	eap_send_response(eap, EAP_TYPE_IDENTITY, buf, len + 5);
 }
 =

+/* To be used in authenticator mode to trigger our first request */
+void eap_start(struct eap_state *eap)
+{
+	uint8_t buf[5];
+
+	L_WARN_ON(!eap->method || !eap->authenticator || eap->identity);
+
+	buf[4] =3D EAP_TYPE_IDENTITY;
+	eap_send_packet(eap, EAP_CODE_REQUEST, ++eap->last_id, buf, 5);
+}
+
 void __eap_handle_request(struct eap_state *eap, uint16_t id,
 				const uint8_t *pkt, size_t len)
 {
@@ -325,6 +351,152 @@ void __eap_handle_request(struct eap_state *eap, uint=
16_t id,
 	}
 }
 =

+static const char *eap_type_to_str(enum eap_type type, uint32_t vendor_id,
+					uint32_t vendor_type)
+{
+	static char buf[100];
+
+	/*
+	 * Show vendor ID if type is expanded unless vendor_id and
+	 * vendor_type are 0 which means the peer is requesting an
+	 * expanded type through a Legacy Nak.  A Legacy Nak won't let
+	 * the peer specify the which expanded type it wants.
+	 *
+	 * TODO: Could also use names for known methods and/or vendors.
+	 */
+	if (type =3D=3D EAP_TYPE_EXPANDED && vendor_id =3D=3D 0 && vendor_type !=
=3D 0)
+		type =3D vendor_type;
+
+	if (type !=3D EAP_TYPE_EXPANDED || (vendor_id =3D=3D 0 && vendor_type =3D=
=3D 0)) {
+		snprintf(buf, sizeof(buf), "type(%i)", type);
+		return buf;
+	}
+
+	snprintf(buf, sizeof(buf), "vendor(%02x, %02x, %02x), type(%i)",
+			(vendor_id >> 16) & 255, (vendor_id >> 8) & 255,
+			vendor_id & 255, vendor_type);
+	return buf;
+}
+
+static void eap_handle_response(struct eap_state *eap, const uint8_t *pkt,
+				size_t len)
+{
+	enum eap_type type;
+	enum eap_type req_type =3D eap->method->request_type;
+	uint32_t vendor_id;
+	uint32_t uninitialized_var(vendor_type);
+
+	if (len < 1)
+		/* Invalid packets to be ignored */
+		return;
+
+	type =3D *pkt++;
+	len--;
+
+	if (type =3D=3D EAP_TYPE_EXPANDED) {
+		if (len < 7)
+			return;
+
+		vendor_id =3D (pkt[0] << 16) | (pkt[1] << 8) | pkt[2];
+		vendor_type =3D l_get_be32(pkt + 3);
+		pkt +=3D 7;
+		len -=3D 7;
+
+		if (vendor_id =3D=3D 0 && vendor_type =3D=3D EAP_TYPE_NAK &&
+				req_type !=3D EAP_TYPE_EXPANDED)
+			/*
+			 * RFC3748 5.3.2: "[The Expanded Nak Type] MUST
+			 * be sent only in reply to a Request of Type 254.
+			 */
+			return;
+	}
+
+	if (type =3D=3D EAP_TYPE_NAK ||
+			(type =3D=3D EAP_TYPE_EXPANDED &&
+			 vendor_id =3D=3D 0 && vendor_type =3D=3D EAP_TYPE_NAK)) {
+		l_debug("EAP peer not configured for method: %s",
+			eap_type_to_str(type, vendor_id, vendor_type));
+
+		if ((type =3D=3D EAP_TYPE_NAK && len =3D=3D 1 && pkt[0] =3D=3D 0) ||
+				(type !=3D EAP_TYPE_NAK && len =3D=3D 8 &&
+				 util_mem_is_zero(pkt, 8)))
+			l_debug("EAP peer proposed no alternative methods");
+		else if (type =3D=3D EAP_TYPE_NAK)
+			while (len) {
+				l_debug("EAP peer proposed method: %s",
+					eap_type_to_str(*pkt++, 0, 0));
+				len--;
+			}
+		else
+			while (len >=3D 8) {
+				uint32_t v_id =3D (pkt[0] << 16) | (pkt[1] << 8) |
+					pkt[2];
+
+				l_debug("EAP peer proposed method: %s",
+					eap_type_to_str(pkt[0], v_id,
+							l_get_be32(pkt + 3)));
+				pkt +=3D 8;
+				len -=3D 8;
+			}
+
+		goto unsupported_method;
+	}
+
+	/*
+	 * RFC3748 5.7: "An implementation that supports the Expanded
+	 * attribute MUST treat EAP Types that are less than 256 equivalently,
+	 * whether they appear as a single octet or as the 32-bit Vendor-Type
+	 * within an Expanded Type where Vendor-Id is 0."
+	 * (with the exception of the Nak)
+	 */
+	if (type =3D=3D EAP_TYPE_EXPANDED && vendor_id =3D=3D 0)
+		type =3D vendor_type;
+
+	/*
+	 * If we don't have peer's identity yet it means we've only sent the
+	 * Identity Request so far so we expect an Identity Response and
+	 * nothing else.  Otherwise we only accept Response types matching
+	 * the method type and we forward responses directly to the method.
+	 */
+
+	if (!eap->identity) {
+		if (type !=3D EAP_TYPE_IDENTITY)
+			goto unsupported_method;
+
+		/*
+		 * RFC3748 Section 5.1: "The Identity Response field MUST NOT be
+		 * null terminated."
+		 * Only the Request can have data after a NUL char.
+		 */
+		if (len > 253 && memchr(pkt, '\0', len))
+			goto error;
+
+		eap->identity =3D l_strndup((char *) pkt, len);
+		if (eap->method->validate_identity &&
+				!eap->method->validate_identity(eap,
+								eap->identity))
+			goto error;
+
+		return;
+	}
+
+	if (type !=3D req_type ||
+			(type =3D=3D EAP_TYPE_EXPANDED &&
+			 ((vendor_id !=3D (uint32_t)
+			   ((eap->method->vendor_id[0] << 16) |
+			    (eap->method->vendor_id[1] << 8) |
+			    eap->method->vendor_id[2])) ||
+			  vendor_type !=3D eap->method->vendor_type)))
+		goto unsupported_method;
+
+	eap->method->handle_response(eap, pkt, len);
+	return;
+
+error:
+unsupported_method:
+	eap_method_error(eap);
+}
+
 void eap_rx_packet(struct eap_state *eap, const uint8_t *pkt, size_t len)
 {
 	uint8_t code, id;
@@ -340,11 +512,24 @@ void eap_rx_packet(struct eap_state *eap, const uint8=
_t *pkt, size_t len)
 =

 	switch ((enum eap_code) code) {
 	case EAP_CODE_REQUEST:
+		if (eap->authenticator)
+			goto invalid;
+
 		__eap_handle_request(eap, id, pkt + 4, eap_len - 4);
 		return;
 =

+	case EAP_CODE_RESPONSE:
+		if (!eap->authenticator || id !=3D eap->last_id || !eap->method)
+			goto invalid;
+
+		eap_handle_response(eap, pkt + 4, eap_len - 4);
+		return;
+
 	case EAP_CODE_FAILURE:
 	case EAP_CODE_SUCCESS:
+		if (eap->authenticator)
+			goto invalid;
+
 		if (eap->discard_success_and_failure)
 			return;
 =

@@ -365,8 +550,7 @@ void eap_rx_packet(struct eap_state *eap, const uint8_t=
 *pkt, size_t len)
 			return;
 =

 		if (eap_len !=3D 4)
-			/* Invalid packets to be silently discarded */
-			return;
+			goto invalid;
 =

 		if (code =3D=3D EAP_CODE_SUCCESS && !eap->method_success)
 			/* "Canned" success packets to be discarded */
@@ -392,6 +576,7 @@ void eap_rx_packet(struct eap_state *eap, const uint8_t=
 *pkt, size_t len)
 				EAP_RESULT_FAIL, eap->user_data);
 		return;
 =

+	invalid:
 	default:
 		/* Invalid packets to be silently discarded */
 		return;
@@ -563,6 +748,11 @@ bool eap_load_settings(struct eap_state *eap, struct l=
_settings *settings,
 		if (!eap->method->load_settings(eap, settings, prefix))
 			goto err;
 =

+	eap->authenticator =3D eap->method->handle_request =3D=3D NULL;
+
+	if (eap->authenticator)
+		return true;
+
 	/* get identity from settings or from EAP method */
 	if (!eap->method->get_identity) {
 		snprintf(setting, sizeof(setting), "%sIdentity", prefix);
@@ -650,6 +840,14 @@ bool eap_method_is_success(struct eap_state *eap)
 void eap_method_success(struct eap_state *eap)
 {
 	eap->method_success =3D true;
+
+	if (eap->authenticator) {
+		uint8_t buf[4];
+
+		/* ID not incremented for Success or Failure (RFC3748 4.2) */
+		eap_send_packet(eap, EAP_CODE_FAILURE, eap->last_id, buf, 4);
+		eap->complete(EAP_RESULT_SUCCESS, eap->user_data);
+	}
 }
 =

 void eap_discard_success_and_failure(struct eap_state *eap, bool discard)
@@ -659,6 +857,13 @@ void eap_discard_success_and_failure(struct eap_state =
*eap, bool discard)
 =

 void eap_method_error(struct eap_state *eap)
 {
+	if (eap->authenticator) {
+		uint8_t buf[4];
+
+		/* ID not incremented for Success or Failure (RFC3748 4.2) */
+		eap_send_packet(eap, EAP_CODE_FAILURE, eap->last_id, buf, 4);
+	}
+
 	/*
 	 * It looks like neither EAP nor EAP-TLS specify the error handling
 	 * behavior.
@@ -678,7 +883,7 @@ void eap_restore_last_id(struct eap_state *eap, uint8_t=
 last_id)
 =

 int eap_register_method(struct eap_method *method)
 {
-	if (!method->handle_request)
+	if (!method->handle_request && !method->handle_response)
 		return -EPERM;
 =

 	l_queue_push_head(eap_methods, method);
diff --git a/src/eap.h b/src/eap.h
index 12495e64..f1e867f5 100644
--- a/src/eap.h
+++ b/src/eap.h
@@ -81,6 +81,7 @@ int eap_check_settings(struct l_settings *settings, struc=
t l_queue *secrets,
 bool eap_load_settings(struct eap_state *eap, struct l_settings *settings,
 			const char *prefix);
 bool eap_reset(struct eap_state *eap);
+void eap_start(struct eap_state *eap);
 =

 void eap_set_key_material_func(struct eap_state *eap,
 				eap_key_material_func_t func);
-- =

2.25.1

--===============7761901895280780153==--

