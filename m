Content-Type: multipart/mixed; boundary="===============1474641315877841484=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] eap: Print a hint if Identity is likely wrong
Date: Wed, 28 Apr 2021 17:48:38 +0200
Message-ID: <20210428154838.1346865-2-andrew.zaborowski@intel.com>
In-Reply-To: <20210428154838.1346865-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1474641315877841484==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/eap.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/src/eap.c b/src/eap.c
index bef46e00..0645be47 100644
--- a/src/eap.c
+++ b/src/eap.c
@@ -57,12 +57,15 @@ struct eap_state {
 =

 	struct eap_method *method;
 	char *identity;
+	char *identity_setting;
 	bool authenticator;
 =

 	int last_id;
 	void *method_state;
 	bool method_success;
 	struct l_timeout *complete_timeout;
+	unsigned int identity_req_count;
+	unsigned int method_req_count;
 =

 	bool discard_success_and_failure:1;
 };
@@ -124,11 +127,31 @@ static void eap_free_common(struct eap_state *eap)
 	if (eap->identity) {
 		l_free(eap->identity);
 		eap->identity =3D NULL;
+		l_free(eap->identity_setting);
+		eap->identity_setting =3D NULL;
 	}
 }
 =

 void eap_free(struct eap_state *eap)
 {
+	/*
+	 * In supplicant mode we get here whether the authenticator has
+	 * sent an EAP-Failure or interrupted the connection at a higher
+	 * layer, or even when the negotiation stalled and we interrupted
+	 * it, so use this code path to check if it is the Identity value
+	 * that the authenticator may have a problem with.  We don't know
+	 * whether we're the phase 1 or phase 2 EAP state machine
+	 * (eap->set_key_material is a hint but doesn't work with EAP-PEAP
+	 * phase2) so print the setting name.
+	 */
+	if (!eap->authenticator && !eap->method_success) {
+		if (eap->identity_req_count && !eap->method_req_count)
+			l_info("EAP negotiation stopped after the Identity "
+				"exchange, this can happen when the %s value "
+				"is not what the authenticator expects",
+				eap->identity_setting ?: "identity");
+	}
+
 	eap_free_common(eap);
 	l_timeout_remove(eap->complete_timeout);
 =

@@ -286,6 +309,8 @@ void __eap_handle_request(struct eap_state *eap, uint16=
_t id,
 		void (*op)(struct eap_state *eap,
 					const uint8_t *pkt, size_t len);
 =

+		eap->method_req_count++;
+
 		if (type !=3D eap->method->request_type) {
 			l_warn("EAP server tried method %i while client was "
 					"configured for method %i",
@@ -316,6 +341,8 @@ void __eap_handle_request(struct eap_state *eap, uint16=
_t id,
 =

 	switch (type) {
 	case EAP_TYPE_IDENTITY:
+		eap->identity_req_count++;
+
 		if (len >=3D 2)
 			l_debug("Optional EAP server identity prompt: \"%.*s\"",
 					(int) len - 1, pkt + 1);
@@ -776,6 +803,7 @@ bool eap_load_settings(struct eap_state *eap, struct l_=
settings *settings,
 		snprintf(setting, sizeof(setting), "%sIdentity", prefix);
 		eap->identity =3D l_settings_get_string(settings,
 							"Security", setting);
+		eap->identity_setting =3D l_strdup(setting);
 	} else {
 		eap->identity =3D l_strdup(eap->method->get_identity(eap));
 	}
-- =

2.27.0

--===============1474641315877841484==--

