Content-Type: multipart/mixed; boundary="===============2806073678519001528=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 14/17] ap: Pass extra IEs between mgmt frames and user
Date: Wed, 09 Sep 2020 01:49:30 +0200
Message-ID: <20200908234933.301439-14-andrew.zaborowski@intel.com>
In-Reply-To: <20200908234933.301439-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2806073678519001528==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add user callbacks to add extra IEs to the AP's beacons and other
frames.  I considered a few ways for the user to pass this data
without callbacks but so far this seems to be the easiest and most
versatile way.

Similarly pass the string of IEs from STA association frames to the user
through the AP events.  I dropped ap_event_station_added_data.rsn_ie
because that probably would have not been very useful and the RSN IE
is included in the IE array in any case.
---
 src/ap.c | 57 +++++++++++++++++++++++++++++++++++++++++++++-----------
 src/ap.h | 10 +++++++++-
 2 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 3579d30f..c1e1e389 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -88,6 +88,8 @@ struct sta_state {
 	struct l_uintset *rates;
 	uint32_t assoc_resp_cmd_id;
 	struct ap_state *ap;
+	uint8_t *assoc_ies;
+	size_t assoc_ies_len;
 	uint8_t *assoc_rsne;
 	struct eapol_sm *sm;
 	struct handshake_state *hs;
@@ -159,7 +161,7 @@ static void ap_sta_free(void *data)
 	struct ap_state *ap =3D sta->ap;
 =

 	l_uintset_free(sta->rates);
-	l_free(sta->assoc_rsne);
+	l_free(sta->assoc_ies);
 =

 	if (sta->assoc_resp_cmd_id)
 		l_genl_family_cancel(ap->nl80211, sta->assoc_resp_cmd_id);
@@ -272,7 +274,8 @@ static void ap_new_rsna(struct sta_state *sta)
 	if (ap->ops->handle_event) {
 		struct ap_event_station_added_data event_data =3D {};
 		event_data.mac =3D sta->addr;
-		event_data.rsn_ie =3D sta->assoc_rsne;
+		event_data.assoc_ies =3D sta->assoc_ies;
+		event_data.assoc_ies_len =3D sta->assoc_ies_len;
 		ap->ops->handle_event(AP_EVENT_STATION_ADDED, &event_data,
 					ap->user_data);
 	}
@@ -491,6 +494,12 @@ static size_t ap_build_beacon_pr_tail(struct ap_state =
*ap, bool pr,
 	len +=3D wsc_ie_size;
 	l_free(wsc_ie);
 =

+	if (ap->ops->write_mgmt_frame_ies)
+		len +=3D ap->ops->write_mgmt_frame_ies(
+				pr ? MPDU_MANAGEMENT_SUBTYPE_PROBE_RESPONSE :
+				MPDU_MANAGEMENT_SUBTYPE_BEACON,
+				out_buf + len, ap->user_data);
+
 	return len;
 }
 =

@@ -505,7 +514,11 @@ static void ap_set_beacon_cb(struct l_genl_msg *msg, v=
oid *user_data)
 static void ap_update_beacon(struct ap_state *ap)
 {
 	struct l_genl_msg *cmd;
-	uint8_t head[256], tail[256];
+	size_t extra_ies_len =3D ap->ops->get_mgmt_frame_ies_len ?
+		ap->ops->get_mgmt_frame_ies_len(MPDU_MANAGEMENT_SUBTYPE_BEACON,
+						ap->user_data) : 0;
+	uint8_t head[256];
+	uint8_t tail[256 + extra_ies_len];
 	size_t head_len, tail_len;
 	uint64_t wdev_id =3D netdev_get_wdev_id(ap->netdev);
 	static const uint8_t bcast_addr[6] =3D {
@@ -1059,7 +1072,11 @@ static uint32_t ap_assoc_resp(struct ap_state *ap, s=
truct sta_state *sta,
 				bool reassoc, l_genl_msg_func_t callback)
 {
 	const uint8_t *addr =3D netdev_get_address(ap->netdev);
-	uint8_t mpdu_buf[128];
+	size_t extra_ies_len =3D ap->ops->get_mgmt_frame_ies_len ?
+		ap->ops->get_mgmt_frame_ies_len(
+				MPDU_MANAGEMENT_SUBTYPE_ASSOCIATION_RESPONSE,
+				ap->user_data) : 0;
+	uint8_t mpdu_buf[128 + extra_ies_len];
 	struct mmpdu_header *mpdu =3D (void *) mpdu_buf;
 	struct mmpdu_association_response *resp;
 	size_t ies_len =3D 0;
@@ -1135,6 +1152,11 @@ static uint32_t ap_assoc_resp(struct ap_state *ap, s=
truct sta_state *sta,
 		l_free(wsc_ie);
 	}
 =

+	if (ap->ops->write_mgmt_frame_ies)
+		ies_len +=3D ap->ops->write_mgmt_frame_ies(
+				MPDU_MANAGEMENT_SUBTYPE_ASSOCIATION_RESPONSE,
+				resp->ies + ies_len, ap->user_data);
+
 send_frame:
 	return ap_send_mgmt_frame(ap, mpdu, resp->ies + ies_len - mpdu_buf,
 					true, callback, sta);
@@ -1336,6 +1358,8 @@ static void ap_assoc_reassoc(struct sta_state *sta, b=
ool reassoc,
 		sta->wsc_v2 =3D wsc_req.version2;
 =

 		event_data.mac =3D sta->addr;
+		event_data.assoc_ies =3D ies;
+		event_data.assoc_ies_len =3D ies_len;
 		ap->ops->handle_event(AP_EVENT_REGISTRATION_START, &event_data,
 					ap->user_data);
 =

@@ -1385,13 +1409,16 @@ static void ap_assoc_reassoc(struct sta_state *sta,=
 bool reassoc,
 =

 	sta->rates =3D rates;
 =

-	if (sta->assoc_rsne)
-		l_free(sta->assoc_rsne);
+	l_free(sta->assoc_ies);
 =

-	if (rsn)
-		sta->assoc_rsne =3D l_memdup(rsn, rsn[1] + 2);
-	else
+	if (rsn) {
+		sta->assoc_ies =3D l_memdup(ies, ies_len);
+		sta->assoc_ies_len =3D ies_len;
+		sta->assoc_rsne =3D sta->assoc_ies + (rsn - ies);
+	} else {
+		sta->assoc_ies =3D NULL;
 		sta->assoc_rsne =3D NULL;
+	}
 =

 	sta->assoc_resp_cmd_id =3D ap_assoc_resp(ap, sta, sta->addr, 0, reassoc,
 						ap_success_assoc_resp_cb);
@@ -1636,7 +1663,11 @@ static void ap_probe_req_cb(const struct mmpdu_heade=
r *hdr, const void *body,
 	struct ie_tlv_iter iter;
 	const uint8_t *bssid =3D netdev_get_address(ap->netdev);
 	bool match =3D false;
-	uint8_t resp[512];
+	size_t extra_ies_len =3D ap->ops->get_mgmt_frame_ies_len ?
+		ap->ops->get_mgmt_frame_ies_len(
+					MPDU_MANAGEMENT_SUBTYPE_PROBE_RESPONSE,
+					ap->user_data) : 0;
+	uint8_t resp[512 + extra_ies_len];
 	uint8_t *wsc_data;
 	ssize_t wsc_data_len;
 =

@@ -1936,7 +1967,11 @@ static struct l_genl_msg *ap_build_cmd_start_ap(stru=
ct ap_state *ap)
 {
 	struct l_genl_msg *cmd;
 =

-	uint8_t head[256], tail[256];
+	size_t extra_ies_len =3D ap->ops->get_mgmt_frame_ies_len ?
+		ap->ops->get_mgmt_frame_ies_len(MPDU_MANAGEMENT_SUBTYPE_BEACON,
+						ap->user_data) : 0;
+	uint8_t head[256];
+	uint8_t tail[256 + extra_ies_len];
 	size_t head_len, tail_len;
 =

 	uint32_t dtim_period =3D 3;
diff --git a/src/ap.h b/src/ap.h
index bbfecd6d..25ecc15a 100644
--- a/src/ap.h
+++ b/src/ap.h
@@ -22,6 +22,7 @@
 =

 struct ap_state;
 struct iovec;
+enum mpdu_management_subtype;
 =

 enum ap_event_type {
 	AP_EVENT_START_FAILED,
@@ -36,7 +37,8 @@ enum ap_event_type {
 =

 struct ap_event_station_added_data {
 	const uint8_t *mac;
-	const uint8_t *rsn_ie;
+	const uint8_t *assoc_ies;
+	size_t assoc_ies_len;
 };
 =

 struct ap_event_station_removed_data {
@@ -46,6 +48,8 @@ struct ap_event_station_removed_data {
 =

 struct ap_event_registration_start_data {
 	const uint8_t *mac;
+	const uint8_t *assoc_ies;
+	size_t assoc_ies_len;
 };
 =

 struct ap_event_registration_success_data {
@@ -68,6 +72,10 @@ struct ap_config {
 struct ap_ops {
 	void (*handle_event)(enum ap_event_type type, const void *event_data,
 				void *user_data);
+	size_t (*get_mgmt_frame_ies_len)(enum mpdu_management_subtype type,
+						void *user_data);
+	size_t (*write_mgmt_frame_ies)(enum mpdu_management_subtype type,
+					uint8_t *out_buf, void *user_data);
 };
 =

 void ap_config_free(struct ap_config *config);
-- =

2.25.1

--===============2806073678519001528==--

