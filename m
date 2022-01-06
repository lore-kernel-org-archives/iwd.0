Content-Type: multipart/mixed; boundary="===============8767027667399131607=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/2] dpp: parse configuration request values
Date: Thu, 06 Jan 2022 15:02:04 -0800
Message-ID: <20220106230205.571804-1-prestwoj@gmail.com>

--===============8767027667399131607==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With better JSON support the configuration request object
can now be fully parsed. As stated in the previous comment
there really isn't much use from the configurator side apart
from verifying mandatory values are included.

This patch also modifies the configuration result to handle
sending non 'OK' status codes in case of JSON parsing errors.
---
 src/dpp.c | 76 ++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 58 insertions(+), 18 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 5f25f1c2..dedbd3b2 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -579,14 +579,13 @@ static void dpp_handle_config_response_frame(const st=
ruct mmpdu_header *frame,
 	send_config_result(dpp, dpp->auth_addr);
 }
 =

-static void dpp_send_config_response(struct dpp_sm *dpp)
+static void dpp_send_config_response(struct dpp_sm *dpp, uint8_t status)
 {
-	_auto_(l_free) char *json;
+	_auto_(l_free) char *json =3D NULL;
 	struct iovec iov[3];
 	uint8_t hdr[41];
 	uint8_t attrs[512];
 	size_t json_len;
-	uint8_t zero =3D 0;
 	uint8_t *ptr =3D hdr + 24;
 =

 	l_put_le16(0x00d0, hdr);
@@ -611,9 +610,6 @@ static void dpp_send_config_response(struct dpp_sm *dpp)
 	*ptr++ =3D 0x1a;
 	*ptr++ =3D 1;
 =

-	json =3D dpp_configuration_to_json(dpp->config);
-	json_len =3D strlen(json);
-
 	iov[0].iov_base =3D hdr;
 	iov[0].iov_len =3D ptr - hdr;
 =

@@ -621,12 +617,31 @@ static void dpp_send_config_response(struct dpp_sm *d=
pp)
 =

 	ptr +=3D 2; /* length */
 =

-	ptr +=3D dpp_append_attr(ptr, DPP_ATTR_STATUS, &zero, 1);
+	ptr +=3D dpp_append_attr(ptr, DPP_ATTR_STATUS, &status, 1);
 =

-	ptr +=3D dpp_append_wrapped_data(attrs + 2, ptr - attrs - 2, NULL, 0, ptr,
-			sizeof(attrs), dpp->ke, dpp->key_len, 2,
-			DPP_ATTR_ENROLLEE_NONCE, dpp->nonce_len, dpp->e_nonce,
-			DPP_ATTR_CONFIGURATION_OBJECT, json_len, json);
+	/*
+	 * There are several failure status codes that can be used (defined in
+	 * 6.4.3.1), each with their own set of attributes that should be
+	 * included. For now IWD's basic DPP implementation will assume
+	 * STATUS_CONFIGURE_FAILURE which only includes the E-Nonce.
+	 */
+	if (status =3D=3D DPP_STATUS_OK) {
+		json =3D dpp_configuration_to_json(dpp->config);
+		json_len =3D strlen(json);
+
+		ptr +=3D dpp_append_wrapped_data(attrs + 2, ptr - attrs - 2,
+						NULL, 0, ptr, sizeof(attrs),
+						dpp->ke, dpp->key_len, 2,
+						DPP_ATTR_ENROLLEE_NONCE,
+						dpp->nonce_len, dpp->e_nonce,
+						DPP_ATTR_CONFIGURATION_OBJECT,
+						json_len, json);
+	} else
+		ptr +=3D dpp_append_wrapped_data(attrs + 2, ptr - attrs - 2,
+						NULL, 0, ptr, sizeof(attrs),
+						dpp->ke, dpp->key_len, 2,
+						DPP_ATTR_ENROLLEE_NONCE,
+						dpp->nonce_len, dpp->e_nonce);
 =

 	l_put_le16(ptr - attrs - 2, attrs);
 =

@@ -655,6 +670,9 @@ static void dpp_handle_config_request_frame(const struc=
t mmpdu_header *frame,
 	_auto_(l_free) uint8_t *unwrapped =3D NULL;
 	uint8_t hdr_check[] =3D { IE_TYPE_ADVERTISEMENT_PROTOCOL, 0x08, 0x7f,
 				IE_TYPE_VENDOR_SPECIFIC, 5 };
+	struct json_iter jsiter;
+	_auto_(l_free) char *tech =3D NULL;
+	_auto_(l_free) char *role =3D NULL;
 =

 	if (dpp->state !=3D DPP_STATE_AUTHENTICATING) {
 		l_debug("Configuration request in wrong state");
@@ -747,25 +765,47 @@ static void dpp_handle_config_request_frame(const str=
uct mmpdu_header *frame,
 		return;
 	}
 =

-	/*
-	 * TODO: Full JSON type support (arrays/numbers) is not yet implemented.
-	 * Just verify the JSON is valid for now. There really isn't much need
-	 * to parse this anyhow since IWD only supports configuring stations.
-	 * If this request is for anything else it will fail regardless.
-	 */
 	c =3D json_contents_new(json, json_len);
 	if (!c) {
 		json_contents_free(c);
 		return;
 	}
 =

+	json_iter_init(&jsiter, c);
+
+	/*
+	 * Check mandatory values (Table 7). There isn't much that can be done
+	 * with these, but the spec requires they be included.
+	 */
+	if (!json_iter_parse(&jsiter,
+			JSON_MANDATORY("name", JSON_STRING, NULL),
+			JSON_MANDATORY("wi-fi_tech", JSON_STRING, &tech),
+			JSON_MANDATORY("netRole", JSON_STRING, &role),
+			JSON_UNDEFINED))
+		goto configure_failure;
+
+	if (strcmp(tech, "infra"))
+		goto configure_failure;
+
+	if (strcmp(role, "sta"))
+		goto configure_failure;
+
 	json_contents_free(c);
 =

 	memcpy(dpp->e_nonce, e_nonce, dpp->nonce_len);
 =

 	dpp->state =3D DPP_STATE_CONFIGURING;
 =

-	dpp_send_config_response(dpp);
+	dpp_send_config_response(dpp, DPP_STATUS_OK);
+
+	return;
+
+configure_failure:
+	dpp_send_config_response(dpp, DPP_STATUS_CONFIGURE_FAILURE);
+	/*
+	 * The other peer is still authenticated, and can potentially send
+	 * additional requests so keep this session alive.
+	 */
 }
 =

 static void dpp_handle_config_result_frame(struct dpp_sm *dpp,
-- =

2.31.1

--===============8767027667399131607==--

