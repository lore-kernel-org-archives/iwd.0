Content-Type: multipart/mixed; boundary="===============2471689382646283531=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 2/6] dpp: add role definitions
Date: Mon, 20 Dec 2021 16:07:43 -0800
Message-ID: <20211221000747.56696-2-prestwoj@gmail.com>
In-Reply-To: 20211221000747.56696-1-prestwoj@gmail.com

--===============2471689382646283531==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Added both enrollee and configurator roles, as well as the needed
logic inside the authentication protocol to verify role compatibility.
The dpp_sm's role will now be used when setting capability bits making
the auth protocol agnostic to enrollees or configurators.
---
 src/dpp.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 8288aa6c..b6e59176 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -58,9 +58,15 @@ enum dpp_state {
 	DPP_STATE_CONFIGURING,
 };
 =

+enum dpp_capability {
+	DPP_CAPABILITY_ENROLLEE =3D 0x01,
+	DPP_CAPABILITY_CONFIGURATOR =3D 0x02,
+};
+
 struct dpp_sm {
 	struct netdev *netdev;
 	char *uri;
+	uint8_t role;
 =

 	uint64_t wdev_id;
 =

@@ -588,7 +594,6 @@ static void send_authenticate_response(struct dpp_sm *d=
pp, void *r_auth)
 	uint8_t status =3D DPP_STATUS_OK;
 	uint64_t r_proto_key[L_ECC_MAX_DIGITS * 2];
 	uint8_t version =3D 2;
-	uint8_t r_capabilities =3D 0x01;
 	struct iovec iov[3];
 	uint8_t wrapped2_plaintext[dpp->key_len + 4];
 	uint8_t wrapped2[dpp->key_len + 16 + 8];
@@ -628,7 +633,7 @@ static void send_authenticate_response(struct dpp_sm *d=
pp, void *r_auth)
 			ptr, sizeof(attrs), dpp->k2, dpp->key_len, 4,
 			DPP_ATTR_RESPONDER_NONCE, dpp->nonce_len, dpp->r_nonce,
 			DPP_ATTR_INITIATOR_NONCE, dpp->nonce_len, dpp->i_nonce,
-			DPP_ATTR_RESPONDER_CAPABILITIES, 1, &r_capabilities,
+			DPP_ATTR_RESPONDER_CAPABILITIES, 1, &dpp->role,
 			DPP_ATTR_WRAPPED_DATA, wrapped2_len, wrapped2);
 =

 	iov[1].iov_base =3D attrs;
@@ -760,7 +765,9 @@ static void authenticate_confirm(struct dpp_sm *dpp, co=
nst uint8_t *from,
 	l_debug("Authentication successful");
 =

 	dpp_reset_protocol_timer(dpp);
-	dpp_configuration_start(dpp, from);
+
+	if (dpp->role =3D=3D DPP_CAPABILITY_ENROLLEE)
+		dpp_configuration_start(dpp, from);
 =

 	return;
 =

@@ -777,7 +784,6 @@ static void dpp_auth_request_failed(struct dpp_sm *dpp,
 	uint8_t attrs[128];
 	uint8_t *ptr =3D attrs;
 	uint8_t version =3D 2;
-	uint8_t r_capabilities =3D 0x01;
 	uint8_t s =3D status;
 	struct iovec iov[2];
 =

@@ -795,7 +801,7 @@ static void dpp_auth_request_failed(struct dpp_sm *dpp,
 	ptr +=3D dpp_append_wrapped_data(hdr + 26, 6, attrs, ptr - attrs,
 			ptr, sizeof(attrs) - (ptr - attrs), k1, dpp->key_len, 2,
 			DPP_ATTR_INITIATOR_NONCE, dpp->nonce_len, dpp->i_nonce,
-			DPP_ATTR_RESPONDER_CAPABILITIES, 1, &r_capabilities);
+			DPP_ATTR_RESPONDER_CAPABILITIES, 1, &dpp->role);
 =

 	iov[1].iov_base =3D attrs;
 	iov[1].iov_len =3D ptr - attrs;
@@ -804,6 +810,18 @@ static void dpp_auth_request_failed(struct dpp_sm *dpp,
 				dpp->current_freq);
 }
 =

+static bool dpp_check_roles(struct dpp_sm *dpp, uint8_t peer_capa)
+{
+	if (dpp->role =3D=3D DPP_CAPABILITY_ENROLLEE &&
+			!(peer_capa & DPP_CAPABILITY_CONFIGURATOR))
+		return false;
+	else if (dpp->role =3D=3D DPP_CAPABILITY_CONFIGURATOR &&
+			!(peer_capa & DPP_CAPABILITY_ENROLLEE))
+		return false;
+
+	return true;
+}
+
 static void authenticate_request(struct dpp_sm *dpp, const uint8_t *from,
 					const uint8_t *body, size_t body_len)
 {
@@ -816,6 +834,7 @@ static void authenticate_request(struct dpp_sm *dpp, co=
nst uint8_t *from,
 	const uint8_t *i_proto =3D NULL;
 	const void *wrapped =3D NULL;
 	const uint8_t *i_nonce =3D NULL;
+	uint8_t i_capa =3D 0;
 	size_t r_boot_len =3D 0, i_proto_len =3D 0, wrapped_len =3D 0;
 	size_t i_nonce_len =3D 0;
 	_auto_(l_free) uint8_t *unwrapped =3D NULL;
@@ -925,9 +944,10 @@ static void authenticate_request(struct dpp_sm *dpp, c=
onst uint8_t *from,
 			 * failure by adding the DPP Status field set to
 			 * STATUS_NOT_COMPATIBLE"
 			 */
-			if (!(l_get_u8(data) & 0x2)) {
-				l_debug("Initiator is not configurator");
+			i_capa =3D l_get_u8(data);
 =

+			if (!dpp_check_roles(dpp, i_capa)) {
+				l_debug("Peer does not support required role");
 				dpp_auth_request_failed(dpp,
 						DPP_STATUS_NOT_COMPATIBLE, k1);
 				goto auth_request_failed;
@@ -1042,9 +1062,11 @@ static void dpp_roc_started(void *user_data)
 	struct dpp_sm *dpp =3D user_data;
 =

 	/*
-	 * If not in presence procedure, just stay on channel.
+	 * If not in presence procedure or in a configurator role, just stay
+	 * on channel.
 	 */
-	if (dpp->state !=3D DPP_STATE_PRESENCE)
+	if (dpp->state !=3D DPP_STATE_PRESENCE ||
+			dpp->role =3D=3D DPP_CAPABILITY_CONFIGURATOR)
 		return;
 =

 	dpp_presence_announce(dpp);
@@ -1235,6 +1257,7 @@ static struct l_dbus_message *dpp_dbus_start_enrollee=
(struct l_dbus *dbus,
 					1, NULL, NULL);
 =

 	dpp->state =3D DPP_STATE_PRESENCE;
+	dpp->role =3D DPP_CAPABILITY_ENROLLEE;
 =

 	l_debug("DPP Start Enrollee: %s", dpp->uri);
 =

-- =

2.31.1

--===============2471689382646283531==--

