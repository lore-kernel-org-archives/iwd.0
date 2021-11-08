Content-Type: multipart/mixed; boundary="===============1752756856190755469=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH 7/9] ap: Delay ap_free if called inside event handler
Date: Mon, 08 Nov 2021 12:28:36 +0100
Message-ID: <20211108112838.372416-7-andrew.zaborowski@intel.com>
In-Reply-To: 20211108112838.372416-1-andrew.zaborowski@intel.com

--===============1752756856190755469==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ap.c has been mostly careful to call the event handler at the end of any
externally called function to allow methods like ap_free() to be called
within the handler, but that isn't enough.  For example in
ap_del_station we may end up emitting two events: STATION_REMOVED and
DHCP_LEASE_EXPIRED.  Use a slightly more complicated mechanism to
explicitly guard ap_free calls inside the event handler.

To make it easier, simplify cleanup in ap_assoc_reassoc with the use of
_auto_.

In ap_del_station reorder the actions to send the STATION_REMOVED event
first as the DHCP_LEASE_EXPIRED is a consequence of the former and it
makes sense for the handler to react to it first.
---
 src/ap.c | 125 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 80 insertions(+), 45 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 46a7a6a8..1cbd1262 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -101,6 +101,8 @@ struct ap_state {
 	bool started : 1;
 	bool gtk_set : 1;
 	bool netconfig_set_addr4 : 1;
+	bool in_event : 1;
+	bool free_pending : 1;
 };
 =

 struct sta_state {
@@ -250,6 +252,35 @@ static void ap_reset(struct ap_state *ap)
 	}
 }
 =

+static bool ap_event_done(struct ap_state *ap, bool prev_in_event)
+{
+	ap->in_event =3D prev_in_event;
+
+	if (!prev_in_event && ap->free_pending) {
+		ap_free(ap);
+		return true;
+	}
+
+	return ap->free_pending;
+}
+
+/*
+ * Returns true if the AP is considered freed and the caller must avoid
+ * accessing @ap.
+ */
+static bool ap_event(struct ap_state *ap, enum ap_event_type event,
+			const void *event_data)
+{
+	bool prev =3D ap->in_event;
+
+	if (ap->free_pending)
+		return true;
+
+	ap->in_event =3D true;
+	ap->ops->handle_event(event, event_data, ap->user_data);
+	return ap_event_done(ap, prev);
+}
+
 static void ap_del_station(struct sta_state *sta, uint16_t reason,
 				bool disassociate)
 {
@@ -283,6 +314,14 @@ static void ap_del_station(struct sta_state *sta, uint=
16_t reason,
 =

 	ap_stop_handshake(sta);
 =

+	/*
+	 * If the event handler tears the AP down, we've made sure above that
+	 * a subsequent ap_sta_free(sta) has no need to access sta->ap.
+	 */
+	if (send_event)
+		if (ap_event(ap, AP_EVENT_STATION_REMOVED, &event_data))
+			return;
+
 	/*
 	 * Expire any DHCP leases owned by this client when it disconnects to
 	 * make it harder for somebody to DoS the IP pool.  If the client
@@ -290,17 +329,20 @@ static void ap_del_station(struct sta_state *sta, uin=
t16_t reason,
 	 * will get their IP back.
 	 */
 	if (ap->netconfig_dhcp) {
+		bool prev =3D ap->in_event;
+
+		/*
+		 * If the LEASE_EXPIRED event in ap_dhcp_event_cb triggers an
+		 * ap_free(), delay cleanup to avoid destroying the DHCP
+		 * server midway through l_dhcp_server_expire_by_mac().
+		 */
+		ap->in_event =3D true;
+
 		sta->ip_alloc_lease =3D NULL;
 		l_dhcp_server_expire_by_mac(ap->netconfig_dhcp, sta->addr);
-	}
 =

-	/*
-	 * If the event handler tears the AP down, we've made sure above that
-	 * a subsequent ap_sta_free(sta) has no need to access sta->ap.
-	 */
-	if (send_event)
-		ap->ops->handle_event(AP_EVENT_STATION_REMOVED, &event_data,
-					ap->user_data);
+		ap_event_done(ap, prev);
+	}
 }
 =

 static bool ap_sta_match_addr(const void *a, const void *b)
@@ -335,19 +377,16 @@ static void ap_del_key_cb(struct l_genl_msg *msg, voi=
d *user_data)
 static void ap_new_rsna(struct sta_state *sta)
 {
 	struct ap_state *ap =3D sta->ap;
+	struct ap_event_station_added_data event_data =3D {};
 =

 	l_debug("STA "MAC" authenticated", MAC_STR(sta->addr));
 =

 	sta->rsna =3D true;
 =

-	if (ap->ops->handle_event) {
-		struct ap_event_station_added_data event_data =3D {};
-		event_data.mac =3D sta->addr;
-		event_data.assoc_ies =3D sta->assoc_ies;
-		event_data.assoc_ies_len =3D sta->assoc_ies_len;
-		ap->ops->handle_event(AP_EVENT_STATION_ADDED, &event_data,
-					ap->user_data);
-	}
+	event_data.mac =3D sta->addr;
+	event_data.assoc_ies =3D sta->assoc_ies;
+	event_data.assoc_ies_len =3D sta->assoc_ies_len;
+	ap_event(ap, AP_EVENT_STATION_ADDED, &event_data);
 }
 =

 static void ap_drop_rsna(struct sta_state *sta)
@@ -356,6 +395,7 @@ static void ap_drop_rsna(struct sta_state *sta)
 	struct l_genl_msg *msg;
 	uint32_t ifindex =3D netdev_get_ifindex(sta->ap->netdev);
 	uint8_t key_id =3D 0;
+	struct ap_event_station_removed_data event_data =3D {};
 =

 	sta->rsna =3D false;
 =

@@ -380,12 +420,8 @@ static void ap_drop_rsna(struct sta_state *sta)
 =

 	ap_stop_handshake(sta);
 =

-	if (ap->ops->handle_event) {
-		struct ap_event_station_removed_data event_data =3D {};
-		event_data.mac =3D sta->addr;
-		ap->ops->handle_event(AP_EVENT_STATION_REMOVED, &event_data,
-					ap->user_data);
-	}
+	event_data.mac =3D sta->addr;
+	ap_event(ap, AP_EVENT_STATION_REMOVED, &event_data);
 }
 =

 static void ap_set_rsn_info(struct ap_state *ap, struct ie_rsn_info *rsn)
@@ -405,7 +441,7 @@ static void ap_wsc_exit_pbc(struct ap_state *ap)
 	ap->wsc_dpid =3D 0;
 	ap_update_beacon(ap);
 =

-	ap->ops->handle_event(AP_EVENT_PBC_MODE_EXIT, NULL, ap->user_data);
+	ap_event(ap, AP_EVENT_PBC_MODE_EXIT, NULL);
 }
 =

 struct ap_pbc_record_expiry_data {
@@ -1090,9 +1126,7 @@ static void ap_wsc_handshake_event(struct handshake_s=
tate *hs,
 					&expiry_data);
 =

 		event_data.mac =3D sta->addr;
-		sta->ap->ops->handle_event(AP_EVENT_REGISTRATION_SUCCESS,
-						&event_data,
-						sta->ap->user_data);
+		ap_event(sta->ap, AP_EVENT_REGISTRATION_SUCCESS, &event_data);
 		break;
 	default:
 		break;
@@ -1594,11 +1628,11 @@ static void ap_assoc_reassoc(struct sta_state *sta,=
 bool reassoc,
 	const char *ssid =3D NULL;
 	const uint8_t *rsn =3D NULL;
 	size_t ssid_len =3D 0;
-	struct l_uintset *rates =3D NULL;
+	_auto_(l_uintset_free) struct l_uintset *rates =3D NULL;
 	struct ie_rsn_info rsn_info;
 	int err;
 	struct ie_tlv_iter iter;
-	uint8_t *wsc_data =3D NULL;
+	_auto_(l_free) uint8_t *wsc_data =3D NULL;
 	ssize_t wsc_data_len;
 	bool fils_ip_req =3D false;
 	struct ie_fils_ip_addr_request_info fils_ip_req_info;
@@ -1685,9 +1719,6 @@ static void ap_assoc_reassoc(struct sta_state *sta, b=
ool reassoc,
 			goto bad_frame;
 		}
 =

-		l_free(wsc_data);
-		wsc_data =3D NULL;
-
 		if (wsc_req.request_type !=3D
 				WSC_REQUEST_TYPE_ENROLLEE_OPEN_8021X) {
 			err =3D MMPDU_REASON_CODE_INVALID_IE;
@@ -1728,8 +1759,9 @@ static void ap_assoc_reassoc(struct sta_state *sta, b=
ool reassoc,
 		event_data.mac =3D sta->addr;
 		event_data.assoc_ies =3D ies;
 		event_data.assoc_ies_len =3D ies_len;
-		ap->ops->handle_event(AP_EVENT_REGISTRATION_START, &event_data,
-					ap->user_data);
+
+		if (ap_event(ap, AP_EVENT_REGISTRATION_START, &event_data))
+			return;
 =

 		/*
 		 * Since we're starting the PBC Registration Protocol
@@ -1781,7 +1813,7 @@ static void ap_assoc_reassoc(struct sta_state *sta, b=
ool reassoc,
 	if (sta->rates)
 		l_uintset_free(sta->rates);
 =

-	sta->rates =3D rates;
+	sta->rates =3D l_steal_ptr(rates);
 =

 	l_free(sta->assoc_ies);
 =

@@ -1823,11 +1855,6 @@ bad_frame:
 	else if (sta->associated)
 		ap_stop_handshake(sta);
 =

-	if (rates)
-		l_uintset_free(rates);
-
-	l_free(wsc_data);
-
 	if (!ap_assoc_resp(ap, sta, sta->addr, err, reassoc,
 				req, (void *) ies + ies_len - (void *) req,
 				NULL, ap_fail_assoc_resp_cb))
@@ -2209,6 +2236,7 @@ static void ap_start_failed(struct ap_state *ap, int =
err)
 {
 	struct ap_event_start_failed_data data =3D { err };
 =

+	ap->in_event =3D true;
 	ap->ops->handle_event(AP_EVENT_START_FAILED, &data, ap->user_data);
 	ap_reset(ap);
 	l_genl_family_free(ap->nl80211);
@@ -2224,13 +2252,11 @@ static void ap_dhcp_event_cb(struct l_dhcp_server *=
server,
 =

 	switch (event) {
 	case L_DHCP_SERVER_EVENT_NEW_LEASE:
-		ap->ops->handle_event(AP_EVENT_DHCP_NEW_LEASE, lease,
-					ap->user_data);
+		ap_event(ap, AP_EVENT_DHCP_NEW_LEASE, lease);
 		break;
 =

 	case L_DHCP_SERVER_EVENT_LEASE_EXPIRED:
-		ap->ops->handle_event(AP_EVENT_DHCP_LEASE_EXPIRED, lease,
-					ap->user_data);
+		ap_event(ap, AP_EVENT_DHCP_LEASE_EXPIRED, lease);
 		break;
 =

 	default:
@@ -2267,7 +2293,7 @@ static void ap_start_cb(struct l_genl_msg *msg, void =
*user_data)
 	}
 =

 	ap->started =3D true;
-	ap->ops->handle_event(AP_EVENT_STARTED, NULL, ap->user_data);
+	ap_event(ap, AP_EVENT_STARTED, NULL);
 }
 =

 static struct l_genl_msg *ap_build_cmd_start_ap(struct ap_state *ap)
@@ -2552,6 +2578,8 @@ static void ap_mlme_notify(struct l_genl_msg *msg, vo=
id *user_data)
 =

 	switch (l_genl_msg_get_command(msg)) {
 	case NL80211_CMD_STOP_AP:
+		ap->in_event =3D true;
+
 		if (ap->start_stop_cmd_id) {
 			struct ap_event_start_failed_data data =3D { -ECANCELED };
 =

@@ -3304,7 +3332,9 @@ void ap_shutdown(struct ap_state *ap, ap_stopped_func=
_t stopped_func,
 =

 	if (ap->started) {
 		ap->started =3D false;
-		ap->ops->handle_event(AP_EVENT_STOPPING, NULL, ap->user_data);
+
+		if (ap_event(ap, AP_EVENT_STOPPING, NULL))
+			return;
 	}
 =

 	ap_reset(ap);
@@ -3355,6 +3385,11 @@ free_ap:
 /* Free @ap without a graceful shutdown */
 void ap_free(struct ap_state *ap)
 {
+	if (ap->in_event) {
+		ap->free_pending =3D true;
+		return;
+	}
+
 	ap_reset(ap);
 	l_genl_family_free(ap->nl80211);
 	l_free(ap);
-- =

2.32.0

--===============1752756856190755469==--

