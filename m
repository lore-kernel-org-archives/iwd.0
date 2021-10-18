Content-Type: multipart/mixed; boundary="===============4109065373445442401=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/4] netdev: add OCI elements to SA Query request/response
 frames
Date: Mon, 18 Oct 2021 15:33:57 -0700
Message-ID: <20211018223359.497849-2-prestwoj@gmail.com>
In-Reply-To: 20211018223359.497849-1-prestwoj@gmail.com

--===============4109065373445442401==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

SA query is the final protocol that requires OCI inclusion and
verification. The OCI element is now included and verified in
both request and response frames as required by 802.11.
---
 src/netdev.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 111 insertions(+), 12 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 18ac3e45..dabce0b1 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4863,12 +4863,23 @@ static void netdev_sa_query_resp_cb(struct l_genl_m=
sg *msg, void *user_data)
 			ext_error ? ext_error : strerror(-err));
 }
 =

+static int netdev_build_oci(struct netdev *netdev, uint8_t *out)
+{
+	out[0] =3D IE_TYPE_EXTENSION;
+	out[1] =3D 4;
+	out[2] =3D IE_TYPE_OCI & 0xff;
+
+	return oci_from_chandef(netdev->handshake->chandef, out + 3);
+}
+
 static void netdev_sa_query_req_frame_event(const struct mmpdu_header *hdr,
 					const void *body, size_t body_len,
 					int rssi, void *user_data)
 {
-	uint8_t sa_resp[4];
+	uint8_t sa_resp[10];
+	uint8_t *ptr =3D sa_resp;
 	uint16_t transaction;
+	const uint8_t *oci;
 	struct netdev *netdev =3D user_data;
 =

 	if (body_len < 4) {
@@ -4885,15 +4896,57 @@ static void netdev_sa_query_req_frame_event(const s=
truct mmpdu_header *hdr,
 =

 	transaction =3D l_get_u16(body + 2);
 =

-	sa_resp[0] =3D 0x08;	/* SA Query */
-	sa_resp[1] =3D 0x01;	/* Response */
-	memcpy(sa_resp + 2, &transaction, 2);
+	body_len -=3D 4;
+
+	if (netdev->handshake->supplicant_ocvc) {
+		/*
+		 * IEEE 802.11 Section 11.13
+		 *
+		 * "A STA that supports the SA Query procedure and receives an
+		 * SA Query Request frame shall respond with an SA Query
+		 * Response frame if none of the following are true...
+		 * - OCI element is not present in the request or
+		 * - Operating channel information indicated does not match the
+		 *   current channel information (see 12.2.9)."
+		 */
+		if (ie_parse_oci(body + 4, body_len, &oci) < 0) {
+			l_debug("Could not parse OCI");
+			return;
+		}
+
+		if (oci_verify(oci, netdev->handshake->chandef) < 0) {
+			l_debug("Could not verify OCI");
+			return;
+		}
+	}
+
+	ptr[0] =3D 0x08;	/* SA Query */
+	ptr[1] =3D 0x01;	/* Response */
+	memcpy(ptr + 2, &transaction, 2);
+
+	ptr +=3D 4;
+
+	/*
+	 * IEEE 802.11 Section 11.13
+	 *
+	 * "A STA that responds with an SA Query Response frame to a STA that
+	 * indicated OCVC capability shall include OCI element in the response
+	 * frame if dot11RSNAOperatingChannelValidationActivated is true"
+	 */
+	if (!netdev->handshake->supplicant_ocvc) {
+		if (netdev_build_oci(netdev, ptr) < 0) {
+			l_debug("Could not build OCI");
+			return;
+		}
+
+		ptr +=3D 6;
+	}
 =

 	l_info("received SA Query request from "MAC", transaction=3D%u",
 			MAC_STR(hdr->address_2), transaction);
 =

 	if (!netdev_send_action_frame(netdev, netdev->handshake->aa,
-			sa_resp, sizeof(sa_resp),
+			sa_resp, ptr - sa_resp,
 			netdev->frequency,
 			netdev_sa_query_resp_cb, netdev)) {
 		l_error("error sending SA Query response");
@@ -4906,15 +4959,22 @@ static void netdev_sa_query_resp_frame_event(const =
struct mmpdu_header *hdr,
 					int rssi, void *user_data)
 {
 	struct netdev *netdev =3D user_data;
+	const uint8_t *ptr =3D body;
+	const uint8_t *oci;
+
+	if (!netdev->connected)
+		return;
 =

 	if (body_len < 4) {
 		l_debug("SA Query frame too short");
 		return;
 	}
 =

+	ptr +=3D 2;
+
 	l_debug("SA Query src=3D"MAC" dest=3D"MAC" bssid=3D"MAC" transaction=3D%u=
",
 			MAC_STR(hdr->address_2), MAC_STR(hdr->address_1),
-			MAC_STR(hdr->address_3), l_get_u16(body + 2));
+			MAC_STR(hdr->address_3), l_get_u16(ptr));
 =

 	if (!netdev->sa_query_timeout) {
 		l_debug("no SA Query request sent");
@@ -4927,11 +4987,38 @@ static void netdev_sa_query_resp_frame_event(const =
struct mmpdu_header *hdr,
 		return;
 	}
 =

-	if (memcmp(body + 2, &netdev->sa_query_id, 2)) {
+	if (memcmp(ptr, &netdev->sa_query_id, 2)) {
 		l_debug("SA Query transaction ID's did not match");
 		return;
 	}
 =

+	if (!netdev->handshake->supplicant_ocvc)
+		goto keep_alive;
+
+	ptr +=3D 2;
+	body_len -=3D 4;
+
+	/*
+	 * IEEE 802.11 Section 11.13
+	 *
+	 * "When a non-AP or non-PCP STA receives the SA Query Response frame
+	 * from a STA that indicated OCVC capability, it shall ensure that OCI
+	 * element is present in the response and the channel information in the
+	 * OCI element matches current operating channel parameters
+	 * (see 12.2.9). Otherwise, the receiving STA shall deem the response
+	 * as invalid and discard it"
+	 */
+	if (ie_parse_oci(ptr, body_len, &oci) < 0) {
+		l_debug("Invalid OCI element");
+		return;
+	}
+
+	if (oci_verify(oci, netdev->handshake->chandef) < 0) {
+		l_debug("Could not verify OCI element");
+		return;
+	}
+
+keep_alive:
 	l_info("SA Query response from connected BSS received, "
 			"keeping the connection active");
 =

@@ -4981,7 +5068,8 @@ static void netdev_unprot_disconnect_event(struct l_g=
enl_msg *msg,
 	uint16_t type;
 	uint16_t len;
 	const void *data;
-	uint8_t action_frame[4];
+	uint8_t action_frame[10];
+	uint8_t *ptr =3D action_frame;
 	uint8_t reason_code;
 =

 	if (!netdev->connected)
@@ -5025,14 +5113,25 @@ static void netdev_unprot_disconnect_event(struct l=
_genl_msg *msg,
 		return;
 	}
 =

-	action_frame[0] =3D 0x08; /* Category: SA Query */
-	action_frame[1] =3D 0x00; /* SA Query Action: Request */
+	ptr[0] =3D 0x08; /* Category: SA Query */
+	ptr[1] =3D 0x00; /* SA Query Action: Request */
 =

 	/* Transaction ID */
-	l_getrandom(action_frame + 2, 2);
+	l_getrandom(ptr + 2, 2);
+
+	ptr +=3D 4;
+
+	if (netdev->handshake->supplicant_ocvc) {
+		if (netdev_build_oci(netdev, ptr) < 0) {
+			l_debug("Could not build OCI");
+			return;
+		}
+
+		ptr +=3D 6;
+	}
 =

 	if (!netdev_send_action_frame(netdev, netdev->handshake->aa,
-			action_frame, sizeof(action_frame),
+			action_frame, ptr - action_frame,
 			netdev->frequency,
 			netdev_sa_query_req_cb, netdev)) {
 		l_error("error sending SA Query action frame");
-- =

2.31.1

--===============4109065373445442401==--

