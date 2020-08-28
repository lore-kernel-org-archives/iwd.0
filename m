Content-Type: multipart/mixed; boundary="===============5297755261141592630=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] ap: Pass extra IEs between mgmt frames and user
Date: Fri, 28 Aug 2020 17:25:12 +0200
Message-ID: <20200828152512.86105-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5297755261141592630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Allow passing user callbacks to add extra IEs to the AP's beacons and
other frames.  I considered a few ways for the user to pass this data
without callbacks but so far this seems to be the easiest and most
versatile way.  Unfortunately the config is no longer static in a way
that could be completely contained in an l_settings for example.

Similarly pass the string of IEs from STA association frames to the user
through the AP events.  I dropped ap_event_station_added_data.rsn_ie
because that probably would have never been very useful and the RSN IE
is included in the IE array in any case.
---
 src/ap.c | 59 +++++++++++++++++++++++++++++++++++++++++++++-----------
 src/ap.h | 10 +++++++++-
 2 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 1cee185c..3e3df5a8 100644
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
 	if (ap->event_func) {
 		struct ap_event_station_added_data event_data =3D {};
 		event_data.mac =3D sta->addr;
-		event_data.rsn_ie =3D sta->assoc_rsne;
+		event_data.assoc_ies =3D sta->assoc_ies;
+		event_data.assoc_ies_len =3D sta->assoc_ies_len;
 		ap->event_func(AP_EVENT_STATION_ADDED, &event_data,
 				ap->user_data);
 	}
@@ -491,6 +494,12 @@ static size_t ap_build_beacon_pr_tail(struct ap_state =
*ap, bool pr,
 	len +=3D wsc_ie_size;
 	l_free(wsc_ie);
 =

+	if (ap->config->write_mgmt_frame_ies)
+		len +=3D ap->config->write_mgmt_frame_ies(
+				pr ? MPDU_MANAGEMENT_SUBTYPE_PROBE_RESPONSE :
+				MPDU_MANAGEMENT_SUBTYPE_BEACON,
+				out_buf + len, ap->user_data);
+
 	return len;
 }
 =

@@ -505,7 +514,12 @@ static void ap_set_beacon_cb(struct l_genl_msg *msg, v=
oid *user_data)
 static void ap_update_beacon(struct ap_state *ap)
 {
 	struct l_genl_msg *cmd;
-	uint8_t head[256], tail[256];
+	size_t extra_ies_len =3D ap->config->get_mgmt_frame_ies_len ?
+		ap->config->get_mgmt_frame_ies_len(
+						MPDU_MANAGEMENT_SUBTYPE_BEACON,
+						ap->user_data) : 0;
+	uint8_t head[256];
+	uint8_t tail[256 + extra_ies_len];
 	size_t head_len, tail_len;
 	uint64_t wdev_id =3D netdev_get_wdev_id(ap->netdev);
 	static const uint8_t bcast_addr[6] =3D {
@@ -1058,7 +1072,11 @@ static uint32_t ap_assoc_resp(struct ap_state *ap, s=
truct sta_state *sta,
 				bool reassoc, l_genl_msg_func_t callback)
 {
 	const uint8_t *addr =3D netdev_get_address(ap->netdev);
-	uint8_t mpdu_buf[128];
+	size_t extra_ies_len =3D ap->config->get_mgmt_frame_ies_len ?
+		ap->config->get_mgmt_frame_ies_len(
+				MPDU_MANAGEMENT_SUBTYPE_ASSOCIATION_RESPONSE,
+				ap->user_data) : 0;
+	uint8_t mpdu_buf[128 + extra_ies_len];
 	struct mmpdu_header *mpdu =3D (void *) mpdu_buf;
 	struct mmpdu_association_response *resp;
 	size_t ies_len =3D 0;
@@ -1134,6 +1152,11 @@ static uint32_t ap_assoc_resp(struct ap_state *ap, s=
truct sta_state *sta,
 		l_free(wsc_ie);
 	}
 =

+	if (ap->config->write_mgmt_frame_ies)
+		ies_len +=3D ap->config->write_mgmt_frame_ies(
+				MPDU_MANAGEMENT_SUBTYPE_ASSOCIATION_RESPONSE,
+				resp->ies + ies_len, ap->user_data);
+
 send_frame:
 	return ap_send_mgmt_frame(ap, mpdu, resp->ies + ies_len - mpdu_buf,
 					true, callback, sta);
@@ -1335,6 +1358,8 @@ static void ap_assoc_reassoc(struct sta_state *sta, b=
ool reassoc,
 		sta->wsc_v2 =3D wsc_req.version2;
 =

 		event_data.mac =3D sta->addr;
+		event_data.assoc_ies =3D ies;
+		event_data.assoc_ies_len =3D ies_len;
 		ap->event_func(AP_EVENT_REGISTRATION_START, &event_data,
 				ap->user_data);
 =

@@ -1384,13 +1409,16 @@ static void ap_assoc_reassoc(struct sta_state *sta,=
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
@@ -1635,7 +1663,11 @@ static void ap_probe_req_cb(const struct mmpdu_heade=
r *hdr, const void *body,
 	struct ie_tlv_iter iter;
 	const uint8_t *bssid =3D netdev_get_address(ap->netdev);
 	bool match =3D false;
-	uint8_t resp[512];
+	size_t extra_ies_len =3D ap->config->get_mgmt_frame_ies_len ?
+		ap->config->get_mgmt_frame_ies_len(
+					MPDU_MANAGEMENT_SUBTYPE_PROBE_RESPONSE,
+					ap->user_data) : 0;
+	uint8_t resp[512 + extra_ies_len];
 	uint8_t *wsc_data;
 	ssize_t wsc_data_len;
 =

@@ -1931,7 +1963,12 @@ static struct l_genl_msg *ap_build_cmd_start_ap(stru=
ct ap_state *ap)
 {
 	struct l_genl_msg *cmd;
 =

-	uint8_t head[256], tail[256];
+	size_t extra_ies_len =3D ap->config->get_mgmt_frame_ies_len ?
+		ap->config->get_mgmt_frame_ies_len(
+						MPDU_MANAGEMENT_SUBTYPE_BEACON,
+						ap->user_data) : 0;
+	uint8_t head[256];
+	uint8_t tail[256 + extra_ies_len];
 	size_t head_len, tail_len;
 =

 	uint32_t dtim_period =3D 3;
diff --git a/src/ap.h b/src/ap.h
index cb5238d1..19b72a33 100644
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
@@ -64,6 +68,10 @@ struct ap_config {
 	unsigned int authorized_macs_num;
 	char *wsc_name;
 	struct wsc_primary_device_type wsc_primary_device_type;
+	size_t (*get_mgmt_frame_ies_len)(enum mpdu_management_subtype type,
+						void *user_data);
+	size_t (*write_mgmt_frame_ies)(enum mpdu_management_subtype type,
+					uint8_t *out_buf, void *user_data);
 	bool no_cck_rates : 1;
 };
 =

-- =

2.25.1

--===============5297755261141592630==--

