Content-Type: multipart/mixed; boundary="===============3088835728659673953=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/9] ap: Fix an invalid access in ap_write_wsc_ie
Date: Sat, 07 Aug 2021 04:10:43 +0200
Message-ID: <20210807021048.321664-4-andrew.zaborowski@intel.com>
In-Reply-To: <20210807021048.321664-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3088835728659673953==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

client_frame is not valid for a beacon frame as beacons are not sent in
response to another frame.  Move the access to client_frame->address_2
to the conditional blocks for Probe Response and Association Response
frames.
---
 src/ap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/ap.c b/src/ap.c
index 51cb5602..a16200df 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -535,7 +535,6 @@ static size_t ap_write_wsc_ie(struct ap_state *ap,
 				size_t client_frame_len,
 				uint8_t *out_buf)
 {
-	const uint8_t *from =3D client_frame->address_2;
 	uint8_t *wsc_data;
 	size_t wsc_data_size;
 	uint8_t *wsc_ie;
@@ -544,6 +543,7 @@ static size_t ap_write_wsc_ie(struct ap_state *ap,
 =

 	/* WSC IE */
 	if (type =3D=3D MPDU_MANAGEMENT_SUBTYPE_PROBE_RESPONSE) {
+		const uint8_t *from =3D client_frame->address_2;
 		struct wsc_probe_response wsc_pr =3D {};
 		const struct mmpdu_probe_request *req =3D
 			mmpdu_body(client_frame);
@@ -606,6 +606,7 @@ static size_t ap_write_wsc_ie(struct ap_state *ap,
 		wsc_data =3D wsc_build_beacon(&wsc_beacon, &wsc_data_size);
 	} else if (L_IN_SET(type, MPDU_MANAGEMENT_SUBTYPE_ASSOCIATION_RESPONSE,
 			MPDU_MANAGEMENT_SUBTYPE_REASSOCIATION_RESPONSE)) {
+		const uint8_t *from =3D client_frame->address_2;
 		struct wsc_association_response wsc_resp =3D {};
 		struct sta_state *sta =3D
 			l_queue_find(ap->sta_states, ap_sta_match_addr, from);
-- =

2.30.2

--===============3088835728659673953==--

