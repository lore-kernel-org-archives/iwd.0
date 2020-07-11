Content-Type: multipart/mixed; boundary="===============1173920915543032369=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 10/18] p2putil: Add WFD IEs when building P2P Action frames
Date: Sat, 11 Jul 2020 03:00:45 +0200
Message-ID: <20200711010053.224223-10-andrew.zaborowski@intel.com>
In-Reply-To: <20200711010053.224223-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1173920915543032369==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/p2putil.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/src/p2putil.c b/src/p2putil.c
index d581a2a3..d0f3a444 100644
--- a/src/p2putil.c
+++ b/src/p2putil.c
@@ -2238,7 +2238,8 @@ static uint8_t *p2p_build_action_frame(bool public, u=
int8_t frame_subtype,
 					uint8_t dialog_token,
 					struct p2p_attr_builder *p2p_attrs,
 					const struct wsc_p2p_attrs *wsc_attrs,
-					size_t *out_len)
+					const uint8_t *wfd_ie,
+					size_t wfd_ie_len, size_t *out_len)
 {
 	uint8_t *p2p_ie, *wsc_ie, *ret;
 	size_t p2p_ie_len, wsc_ie_len;
@@ -2267,7 +2268,7 @@ static uint8_t *p2p_build_action_frame(bool public, u=
int8_t frame_subtype,
 		wsc_ie =3D NULL;
 =

 	*out_len =3D (public ? 8 : 7) + (p2p_ie ? p2p_ie_len : 0) +
-		(wsc_ie ? wsc_ie_len : 0);
+		(wsc_ie ? wsc_ie_len : 0) + (wfd_ie ? wfd_ie_len : 0);
 	ret =3D l_malloc(*out_len);
 =

 	if (public) {
@@ -2292,8 +2293,12 @@ static uint8_t *p2p_build_action_frame(bool public, =
uint8_t frame_subtype,
 	if (wsc_ie) {
 		memcpy(ret + pos, wsc_ie, wsc_ie_len);
 		l_free(wsc_ie);
+		pos +=3D wsc_ie_len;
 	}
 =

+	if (wfd_ie)
+		memcpy(ret + pos, wfd_ie, wfd_ie_len);
+
 	return ret;
 }
 =

@@ -2323,7 +2328,7 @@ uint8_t *p2p_build_go_negotiation_req(const struct p2=
p_go_negotiation_req *data,
 =

 	return p2p_build_action_frame(true, P2P_ACTION_GO_NEGOTIATION_REQ,
 					data->dialog_token, builder, &wsc_attrs,
-					out_len);
+					data->wfd, data->wfd_size, out_len);
 }
 =

 /* Section 4.2.9.3 */
@@ -2353,7 +2358,7 @@ uint8_t *p2p_build_go_negotiation_resp(
 =

 	return p2p_build_action_frame(true, P2P_ACTION_GO_NEGOTIATION_RESP,
 					data->dialog_token, builder, &wsc_attrs,
-					out_len);
+					data->wfd, data->wfd_size, out_len);
 }
 =

 /* Section 4.2.9.4 */
@@ -2374,7 +2379,7 @@ uint8_t *p2p_build_go_negotiation_confirmation(
 =

 	return p2p_build_action_frame(true, P2P_ACTION_GO_NEGOTIATION_CONFIRM,
 					data->dialog_token, builder, NULL,
-					out_len);
+					data->wfd, data->wfd_size, out_len);
 }
 =

 /* Section 4.2.9.5 */
@@ -2404,7 +2409,8 @@ uint8_t *p2p_build_invitation_req(const struct p2p_in=
vitation_req *data,
 	return p2p_build_action_frame(true, P2P_ACTION_INVITATION_REQ,
 					data->dialog_token, builder,
 					data->device_password_id ?
-					&wsc_attrs : NULL, out_len);
+					&wsc_attrs : NULL,
+					data->wfd, data->wfd_size, out_len);
 }
 =

 /* Section 4.2.9.6 */
@@ -2428,7 +2434,7 @@ uint8_t *p2p_build_invitation_resp(const struct p2p_i=
nvitation_resp *data,
 =

 	return p2p_build_action_frame(true, P2P_ACTION_INVITATION_RESP,
 					data->dialog_token, builder, NULL,
-					out_len);
+					data->wfd, data->wfd_size, out_len);
 }
 =

 /* Section 4.2.9.7 */
@@ -2447,7 +2453,7 @@ uint8_t *p2p_build_device_disc_req(
 	return p2p_build_action_frame(true,
 					P2P_ACTION_DEVICE_DISCOVERABILITY_REQ,
 					data->dialog_token, builder, NULL,
-					out_len);
+					NULL, 0, out_len);
 }
 =

 /* Section 4.2.9.8 */
@@ -2463,7 +2469,7 @@ uint8_t *p2p_build_device_disc_resp(
 	return p2p_build_action_frame(true,
 					P2P_ACTION_DEVICE_DISCOVERABILITY_RESP,
 					data->dialog_token, builder, NULL,
-					out_len);
+					NULL, 0, out_len);
 }
 =

 /* Section 4.2.9.9 */
@@ -2507,7 +2513,7 @@ uint8_t *p2p_build_provision_disc_req(
 =

 	return p2p_build_action_frame(true, P2P_ACTION_PROVISION_DISCOVERY_REQ,
 					data->dialog_token, builder, &wsc_attrs,
-					out_len);
+					data->wfd, data->wfd_size, out_len);
 }
 =

 /* Section 4.2.9.10 */
@@ -2553,7 +2559,7 @@ uint8_t *p2p_build_provision_disc_resp(
 =

 	return p2p_build_action_frame(true, P2P_ACTION_PROVISION_DISCOVERY_RESP,
 					data->dialog_token, builder, &wsc_attrs,
-					out_len);
+					data->wfd, data->wfd_size, out_len);
 }
 =

 /* Section 4.2.10.2 */
@@ -2567,7 +2573,7 @@ uint8_t *p2p_build_notice_of_absence(const struct p2p=
_notice_of_absence *data,
 						&data->notice_of_absence);
 =

 	return p2p_build_action_frame(false, P2P_ACTION_NOTICE_OF_ABSENCE,
-					0, builder, NULL, out_len);
+					0, builder, NULL, NULL, 0, out_len);
 }
 =

 /* Section 4.2.10.3 */
@@ -2581,7 +2587,7 @@ uint8_t *p2p_build_presence_req(const struct p2p_pres=
ence_req *data,
 						&data->notice_of_absence);
 =

 	return p2p_build_action_frame(false, P2P_ACTION_PRESENCE_REQ,
-					0, builder, NULL, out_len);
+					0, builder, NULL, NULL, 0, out_len);
 }
 =

 /* Section 4.2.10.4 */
@@ -2596,12 +2602,12 @@ uint8_t *p2p_build_presence_resp(const struct p2p_p=
resence_resp *data,
 						&data->notice_of_absence);
 =

 	return p2p_build_action_frame(false, P2P_ACTION_PRESENCE_RESP,
-					0, builder, NULL, out_len);
+					0, builder, NULL, NULL, 0, out_len);
 }
 =

 /* Section 4.2.10.5 */
 uint8_t *p2p_build_go_disc_req(size_t *out_len)
 {
 	return p2p_build_action_frame(false, P2P_ACTION_GO_DISCOVERABILITY_REQ,
-					0, NULL, NULL, out_len);
+					0, NULL, NULL, NULL, 0, out_len);
 }
-- =

2.25.1

--===============1173920915543032369==--

