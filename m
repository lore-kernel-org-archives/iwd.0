Content-Type: multipart/mixed; boundary="===============8561256196311080847=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 11/17] ap: Pass "ops" struct to ap_start()
Date: Wed, 09 Sep 2020 01:49:27 +0200
Message-ID: <20200908234933.301439-11-andrew.zaborowski@intel.com>
In-Reply-To: <20200908234933.301439-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8561256196311080847==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Pass the event callback function pointer in a "struct ap_ops" instead of
as individual ap_start() argument to make adding new callbacks easier.
---
 src/ap.c | 65 +++++++++++++++++++++++++++++++-------------------------
 src/ap.h |  9 +++++---
 2 files changed, 42 insertions(+), 32 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 84d4539a..fab7c20e 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -52,7 +52,7 @@
 struct ap_state {
 	struct netdev *netdev;
 	struct l_genl_family *nl80211;
-	ap_event_func_t event_func;
+	const struct ap_ops *ops;
 	ap_stopped_func_t stopped_func;
 	void *user_data;
 	struct ap_config *config;
@@ -210,7 +210,7 @@ static void ap_del_station(struct sta_state *sta, uint1=
6_t reason,
 	sta->associated =3D false;
 =

 	if (sta->rsna) {
-		if (ap->event_func) {
+		if (ap->ops->handle_event) {
 			memset(&event_data, 0, sizeof(event_data));
 			event_data.mac =3D sta->addr;
 			event_data.reason =3D reason;
@@ -228,8 +228,8 @@ static void ap_del_station(struct sta_state *sta, uint1=
6_t reason,
 	ap_stop_handshake(sta);
 =

 	if (send_event)
-		ap->event_func(AP_EVENT_STATION_REMOVED, &event_data,
-				ap->user_data);
+		ap->ops->handle_event(AP_EVENT_STATION_REMOVED, &event_data,
+					ap->user_data);
 }
 =

 static bool ap_sta_match_addr(const void *a, const void *b)
@@ -269,12 +269,12 @@ static void ap_new_rsna(struct sta_state *sta)
 =

 	sta->rsna =3D true;
 =

-	if (ap->event_func) {
+	if (ap->ops->handle_event) {
 		struct ap_event_station_added_data event_data =3D {};
 		event_data.mac =3D sta->addr;
 		event_data.rsn_ie =3D sta->assoc_rsne;
-		ap->event_func(AP_EVENT_STATION_ADDED, &event_data,
-				ap->user_data);
+		ap->ops->handle_event(AP_EVENT_STATION_ADDED, &event_data,
+					ap->user_data);
 	}
 }
 =

@@ -308,11 +308,11 @@ static void ap_drop_rsna(struct sta_state *sta)
 =

 	ap_stop_handshake(sta);
 =

-	if (ap->event_func) {
+	if (ap->ops->handle_event) {
 		struct ap_event_station_removed_data event_data =3D {};
 		event_data.mac =3D sta->addr;
-		ap->event_func(AP_EVENT_STATION_REMOVED, &event_data,
-				ap->user_data);
+		ap->ops->handle_event(AP_EVENT_STATION_REMOVED, &event_data,
+					ap->user_data);
 	}
 }
 =

@@ -543,7 +543,7 @@ static void ap_wsc_exit_pbc(struct ap_state *ap)
 	ap->wsc_dpid =3D 0;
 	ap_update_beacon(ap);
 =

-	ap->event_func(AP_EVENT_PBC_MODE_EXIT, NULL, ap->user_data);
+	ap->ops->handle_event(AP_EVENT_PBC_MODE_EXIT, NULL, ap->user_data);
 }
 =

 static uint32_t ap_send_mgmt_frame(struct ap_state *ap,
@@ -750,8 +750,9 @@ static void ap_wsc_handshake_event(struct handshake_sta=
te *hs,
 					&expiry_data);
 =

 		event_data.mac =3D sta->addr;
-		sta->ap->event_func(AP_EVENT_REGISTRATION_SUCCESS, &event_data,
-					sta->ap->user_data);
+		sta->ap->ops->handle_event(AP_EVENT_REGISTRATION_SUCCESS,
+						&event_data,
+						sta->ap->user_data);
 		break;
 	default:
 		break;
@@ -1335,8 +1336,8 @@ static void ap_assoc_reassoc(struct sta_state *sta, b=
ool reassoc,
 		sta->wsc_v2 =3D wsc_req.version2;
 =

 		event_data.mac =3D sta->addr;
-		ap->event_func(AP_EVENT_REGISTRATION_START, &event_data,
-				ap->user_data);
+		ap->ops->handle_event(AP_EVENT_REGISTRATION_START, &event_data,
+					ap->user_data);
 =

 		/*
 		 * Since we're starting the PBC Registration Protocol
@@ -1916,7 +1917,8 @@ static void ap_start_cb(struct l_genl_msg *msg, void =
*user_data)
 	if (l_genl_msg_get_error(msg) < 0) {
 		l_error("START_AP failed: %i", l_genl_msg_get_error(msg));
 =

-		ap->event_func(AP_EVENT_START_FAILED, NULL, ap->user_data);
+		ap->ops->handle_event(AP_EVENT_START_FAILED, NULL,
+					ap->user_data);
 		ap_reset(ap);
 		l_genl_family_free(ap->nl80211);
 		l_free(ap);
@@ -1924,7 +1926,7 @@ static void ap_start_cb(struct l_genl_msg *msg, void =
*user_data)
 	}
 =

 	ap->started =3D true;
-	ap->event_func(AP_EVENT_STARTED, NULL, ap->user_data);
+	ap->ops->handle_event(AP_EVENT_STARTED, NULL, ap->user_data);
 }
 =

 static struct l_genl_msg *ap_build_cmd_start_ap(struct ap_state *ap)
@@ -2011,11 +2013,12 @@ static void ap_mlme_notify(struct l_genl_msg *msg, =
void *user_data)
 			l_genl_family_cancel(ap->nl80211,
 						ap->start_stop_cmd_id);
 			ap->start_stop_cmd_id =3D 0;
-			ap->event_func(AP_EVENT_START_FAILED, NULL,
-					ap->user_data);
+			ap->ops->handle_event(AP_EVENT_START_FAILED, NULL,
+						ap->user_data);
 		} else if (ap->started) {
 			ap->started =3D false;
-			ap->event_func(AP_EVENT_STOPPING, NULL, ap->user_data);
+			ap->ops->handle_event(AP_EVENT_STOPPING, NULL,
+						ap->user_data);
 		}
 =

 		ap_reset(ap);
@@ -2028,17 +2031,17 @@ static void ap_mlme_notify(struct l_genl_msg *msg, =
void *user_data)
 /*
  * Start a simple independent WPA2 AP on given netdev.
  *
- * @event_func is required and must react to AP_EVENT_START_FAILED
- * and AP_EVENT_STOPPING by forgetting the ap_state struct, which
- * is going to be freed automatically.
- * In the @config struct only .ssid and .psk need to be non-NUL,
+ * @ops.handle_event is required and must react to AP_EVENT_START_FAILED
+ * and AP_EVENT_STOPPING by forgetting the ap_state struct, which is
+ * going to be freed automatically.
+ * In the @config struct only .ssid and .psk need to be non-NULL,
  * other fields are optional.  If @ap_start succeeds, the returned
  * ap_state takes ownership of @config and the caller shouldn't
  * free it or any of the memory pointed to by its members (they
  * also can't be static).
  */
 struct ap_state *ap_start(struct netdev *netdev, struct ap_config *config,
-				ap_event_func_t event_func, void *user_data)
+				const struct ap_ops *ops, void *user_data)
 {
 	struct ap_state *ap;
 	struct wiphy *wiphy =3D netdev_get_wiphy(netdev);
@@ -2049,7 +2052,7 @@ struct ap_state *ap_start(struct netdev *netdev, stru=
ct ap_config *config,
 	ap->nl80211 =3D l_genl_family_new(iwd_get_genl(), NL80211_GENL_NAME);
 	ap->config =3D config;
 	ap->netdev =3D netdev;
-	ap->event_func =3D event_func;
+	ap->ops =3D ops;
 	ap->user_data =3D user_data;
 =

 	if (!config->channel)
@@ -2180,7 +2183,7 @@ static struct l_genl_msg *ap_build_cmd_stop_ap(struct=
 ap_state *ap)
 =

 /*
  * Schedule the running @ap to be stopped and freed.  The original
- * event_func and user_data are forgotten and a new callback can be
+ * ops and user_data are forgotten and a new callback can be
  * provided if the caller needs to know when the interface becomes
  * free, for example for a new ap_start call.
  *
@@ -2197,7 +2200,7 @@ void ap_shutdown(struct ap_state *ap, ap_stopped_func=
_t stopped_func,
 =

 	if (ap->started) {
 		ap->started =3D false;
-		ap->event_func(AP_EVENT_STOPPING, NULL, ap->user_data);
+		ap->ops->handle_event(AP_EVENT_STOPPING, NULL, ap->user_data);
 	}
 =

 	ap_reset(ap);
@@ -2367,6 +2370,10 @@ static void ap_if_event_func(enum ap_event_type type=
, const void *event_data,
 	}
 }
 =

+static const struct ap_ops ap_dbus_ops =3D {
+	.handle_event =3D ap_if_event_func,
+};
+
 static struct l_dbus_message *ap_dbus_start(struct l_dbus *dbus,
 		struct l_dbus_message *message, void *user_data)
 {
@@ -2387,7 +2394,7 @@ static struct l_dbus_message *ap_dbus_start(struct l_=
dbus *dbus,
 	config->ssid =3D l_strdup(ssid);
 	config->psk =3D l_strdup(wpa2_psk);
 =

-	ap_if->ap =3D ap_start(ap_if->netdev, config, ap_if_event_func, ap_if);
+	ap_if->ap =3D ap_start(ap_if->netdev, config, &ap_dbus_ops, ap_if);
 	if (!ap_if->ap) {
 		ap_config_free(config);
 		return dbus_error_invalid_args(message);
diff --git a/src/ap.h b/src/ap.h
index cb5238d1..bbfecd6d 100644
--- a/src/ap.h
+++ b/src/ap.h
@@ -52,8 +52,6 @@ struct ap_event_registration_success_data {
 	const uint8_t *mac;
 };
 =

-typedef void (*ap_event_func_t)(enum ap_event_type type, const void *event=
_data,
-				void *user_data);
 typedef void (*ap_stopped_func_t)(void *user_data);
 =

 struct ap_config {
@@ -67,10 +65,15 @@ struct ap_config {
 	bool no_cck_rates : 1;
 };
 =

+struct ap_ops {
+	void (*handle_event)(enum ap_event_type type, const void *event_data,
+				void *user_data);
+};
+
 void ap_config_free(struct ap_config *config);
 =

 struct ap_state *ap_start(struct netdev *netdev, struct ap_config *config,
-				ap_event_func_t event_func, void *user_data);
+				const struct ap_ops *ops, void *user_data);
 void ap_shutdown(struct ap_state *ap, ap_stopped_func_t stopped_func,
 			void *user_data);
 void ap_free(struct ap_state *ap);
-- =

2.25.1

--===============8561256196311080847==--

