Content-Type: multipart/mixed; boundary="===============3502526717637660490=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/6] ap: Put a public api between AP logic and DBus code
Date: Tue, 04 Aug 2020 16:53:01 +0200
Message-ID: <20200804145303.151878-4-andrew.zaborowski@intel.com>
In-Reply-To: <20200804145303.151878-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3502526717637660490==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Separate AP logic from DBus code, add a public API to make the AP
logic reusable from other files.
---
 Makefile.am |   2 +-
 src/ap.c    | 377 +++++++++++++++++++++++++++++++++++++---------------
 src/ap.h    |  56 ++++++++
 3 files changed, 328 insertions(+), 107 deletions(-)
 create mode 100644 src/ap.h

diff --git a/Makefile.am b/Makefile.am
index 57c694df..e83dbeee 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -207,7 +207,7 @@ src_iwd_SOURCES =3D src/main.c linux/nl80211.h src/iwd.=
h src/missing.h \
 					src/knownnetworks.c \
 					src/rfkill.h src/rfkill.c \
 					src/ft.h src/ft.c \
-					src/ap.c src/adhoc.c \
+					src/ap.h src/ap.c src/adhoc.c \
 					src/sae.h src/sae.c \
 					src/nl80211util.h src/nl80211util.c \
 					src/nl80211cmd.h src/nl80211cmd.c \
diff --git a/src/ap.c b/src/ap.c
index 9c2ce272..dd0aa224 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -45,12 +45,17 @@
 #include "src/dbus.h"
 #include "src/nl80211util.h"
 #include "src/frame-xchg.h"
+#include "src/ap.h"
 =

 struct ap_state {
 	struct netdev *netdev;
 	struct l_genl_family *nl80211;
+	ap_event_func_t event_func;
+	ap_stopped_func_t stopped_func;
+	void *user_data;
 	char *ssid;
 	uint8_t channel;
+
 	unsigned int ciphers;
 	enum ie_rsn_cipher_suite group_cipher;
 	uint32_t beacon_interval;
@@ -64,7 +69,6 @@ struct ap_state {
 	uint16_t last_aid;
 	struct l_queue *sta_states;
 =

-	struct l_dbus_message *pending;
 	bool started : 1;
 	bool gtk_set : 1;
 };
@@ -114,16 +118,12 @@ static void ap_reset(struct ap_state *ap)
 {
 	struct netdev *netdev =3D ap->netdev;
 =

-	if (!ap->started)
-		return;
-
-	if (ap->pending)
-		dbus_pending_reply(&ap->pending,
-				dbus_error_aborted(ap->pending));
-
 	l_free(ap->ssid);
 =

-	memset(ap->pmk, 0, sizeof(ap->pmk));
+	explicit_bzero(ap->pmk, sizeof(ap->pmk));
+
+	if (ap->mlme_watch)
+		l_genl_family_unregister(ap->nl80211, ap->mlme_watch);
 =

 	frame_watch_wdev_remove(netdev_get_wdev_id(netdev));
 =

@@ -136,28 +136,28 @@ static void ap_reset(struct ap_state *ap)
 		l_uintset_free(ap->rates);
 =

 	ap->started =3D false;
-
-	l_dbus_property_changed(dbus_get_bus(), netdev_get_path(ap->netdev),
-						IWD_AP_INTERFACE, "Started");
-}
-
-static void ap_free(void *data)
-{
-	struct ap_state *ap =3D data;
-
-	ap_reset(ap);
-	l_genl_family_free(ap->nl80211);
-	l_free(ap);
 }
 =

 static void ap_del_station(struct sta_state *sta, uint16_t reason,
 				bool disassociate)
 {
 	struct ap_state *ap =3D sta->ap;
+	struct ap_event_station_removed_data event_data;
+	bool send_event =3D false;
 =

 	netdev_del_station(ap->netdev, sta->addr, reason, disassociate);
 	sta->associated =3D false;
-	sta->rsna =3D false;
+
+	if (sta->rsna) {
+		if (ap->event_func) {
+			memset(&event_data, 0, sizeof(event_data));
+			event_data.mac =3D sta->addr;
+			event_data.reason =3D reason;
+			send_event =3D true;
+		}
+
+		sta->rsna =3D false;
+	}
 =

 	if (sta->gtk_query_cmd_id) {
 		l_genl_family_cancel(ap->nl80211, sta->gtk_query_cmd_id);
@@ -172,6 +172,10 @@ static void ap_del_station(struct sta_state *sta, uint=
16_t reason,
 =

 	sta->hs =3D NULL;
 	sta->sm =3D NULL;
+
+	if (send_event)
+		ap->event_func(AP_EVENT_STATION_REMOVED, &event_data,
+				ap->user_data);
 }
 =

 static bool ap_sta_match_addr(const void *a, const void *b)
@@ -205,13 +209,19 @@ static void ap_del_key_cb(struct l_genl_msg *msg, voi=
d *user_data)
 =

 static void ap_new_rsna(struct sta_state *sta)
 {
+	struct ap_state *ap =3D sta->ap;
+
 	l_debug("STA "MAC" authenticated", MAC_STR(sta->addr));
 =

 	sta->rsna =3D true;
-	/*
-	 * TODO: Once new AP interface is implemented this is where a
-	 * new "ConnectedPeer" property will be added.
-	 */
+
+	if (ap->event_func) {
+		struct ap_event_station_added_data event_data =3D {};
+		event_data.mac =3D sta->addr;
+		event_data.rsn_ie =3D sta->assoc_rsne;
+		ap->event_func(AP_EVENT_STATION_ADDED, &event_data,
+				ap->user_data);
+	}
 }
 =

 static void ap_drop_rsna(struct sta_state *sta)
@@ -250,6 +260,13 @@ static void ap_drop_rsna(struct sta_state *sta)
 =

 	sta->hs =3D NULL;
 	sta->sm =3D NULL;
+
+	if (ap->event_func) {
+		struct ap_event_station_removed_data event_data =3D {};
+		event_data.mac =3D sta->addr;
+		ap->event_func(AP_EVENT_STATION_REMOVED, &event_data,
+				ap->user_data);
+	}
 }
 =

 static void ap_set_rsn_info(struct ap_state *ap, struct ie_rsn_info *rsn)
@@ -1305,26 +1322,18 @@ static void ap_start_cb(struct l_genl_msg *msg, voi=
d *user_data)
 =

 	ap->start_stop_cmd_id =3D 0;
 =

-	if (!ap->pending)
-		return;
-
 	if (l_genl_msg_get_error(msg) < 0) {
 		l_error("START_AP failed: %i", l_genl_msg_get_error(msg));
 =

-		dbus_pending_reply(&ap->pending,
-				dbus_error_invalid_args(ap->pending));
+		ap->event_func(AP_EVENT_START_FAILED, NULL, ap->user_data);
 		ap_reset(ap);
-
+		l_genl_family_free(ap->nl80211);
+		l_free(ap);
 		return;
 	}
 =

-	dbus_pending_reply(&ap->pending,
-			l_dbus_message_new_method_return(ap->pending));
-
 	ap->started =3D true;
-
-	l_dbus_property_changed(dbus_get_bus(), netdev_get_path(ap->netdev),
-						IWD_AP_INTERFACE, "Started");
+	ap->event_func(AP_EVENT_STARTED, NULL, ap->user_data);
 }
 =

 static struct l_genl_msg *ap_build_cmd_start_ap(struct ap_state *ap)
@@ -1406,25 +1415,53 @@ static void ap_mlme_notify(struct l_genl_msg *msg, =
void *user_data)
 =

 	switch (l_genl_msg_get_command(msg)) {
 	case NL80211_CMD_STOP_AP:
-		if (ap->start_stop_cmd_id)
-			break;
+		if (ap->start_stop_cmd_id) {
+			l_genl_family_cancel(ap->nl80211, ap->start_stop_cmd_id);
+			ap->start_stop_cmd_id =3D 0;
+			ap->event_func(AP_EVENT_START_FAILED, NULL, ap->user_data);
+		} else if (ap->started) {
+			ap->started =3D false;
+			ap->event_func(AP_EVENT_STOPPING, NULL, ap->user_data);
+		}
 =

 		ap_reset(ap);
+		l_genl_family_free(ap->nl80211);
+		l_free(ap);
 		break;
 	}
 }
 =

-static int ap_start(struct ap_state *ap, const char *ssid, const char *psk,
-		struct l_dbus_message *message)
+/*
+ * Start a simple independent WPA2 AP on given netdev.
+ *
+ * @event_func is required and must react to AP_EVENT_START_FAILED
+ * and AP_EVENT_STOPPING by forgetting the ap_state struct, which
+ * is going to be freed automatically.
+ * @channel is optional.
+ */
+struct ap_state *ap_start(struct netdev *netdev, const char *ssid,
+				const char *psk, int channel,
+				ap_event_func_t event_func, void *user_data)
 {
-	struct netdev *netdev =3D ap->netdev;
+	struct ap_state *ap;
 	struct wiphy *wiphy =3D netdev_get_wiphy(netdev);
 	struct l_genl_msg *cmd;
 	uint64_t wdev_id =3D netdev_get_wdev_id(netdev);
 =

+	ap =3D l_new(struct ap_state, 1);
+	ap->nl80211 =3D l_genl_family_new(iwd_get_genl(), NL80211_GENL_NAME);
 	ap->ssid =3D l_strdup(ssid);
-	/* TODO: Start a Get Survey to decide the channel */
-	ap->channel =3D 6;
+	ap->netdev =3D netdev;
+	ap->event_func =3D event_func;
+	ap->user_data =3D user_data;
+
+	if (channel)
+		ap->channel =3D channel;
+	else {
+		/* TODO: Start a Get Survey to decide the channel */
+		ap->channel =3D 6;
+	}
+
 	/* TODO: Add all ciphers supported by wiphy */
 	ap->ciphers =3D wiphy_select_cipher(wiphy, 0xffff);
 	ap->group_cipher =3D wiphy_select_cipher(wiphy, 0xffff);
@@ -1485,37 +1522,30 @@ static int ap_start(struct ap_state *ap, const char=
 *ssid, const char *psk,
 		goto error;
 	}
 =

-	ap->pending =3D l_dbus_message_ref(message);
-
-	return 0;
+	return ap;
 =

 error:
 	ap_reset(ap);
-
-	return -EIO;
+	l_genl_family_free(ap->nl80211);
+	l_free(ap);
+	return NULL;
 }
 =

 static void ap_stop_cb(struct l_genl_msg *msg, void *user_data)
 {
 	struct ap_state *ap =3D user_data;
+	int error =3D l_genl_msg_get_error(msg);
 =

 	ap->start_stop_cmd_id =3D 0;
 =

-	if (!ap->pending)
-		goto end;
+	if (error < 0)
+		l_error("STOP_AP failed: %s (%i)", strerror(error), error);
 =

-	if (l_genl_msg_get_error(msg) < 0) {
-		l_error("STOP_AP failed: %i", l_genl_msg_get_error(msg));
-		dbus_pending_reply(&ap->pending,
-				dbus_error_failed(ap->pending));
-		goto end;
-	}
-
-	dbus_pending_reply(&ap->pending,
-			l_dbus_message_new_method_return(ap->pending));
+	if (ap->stopped_func)
+		ap->stopped_func(ap->user_data);
 =

-end:
-	ap_reset(ap);
+	l_genl_family_free(ap->nl80211);
+	l_free(ap);
 }
 =

 static struct l_genl_msg *ap_build_cmd_stop_ap(struct ap_state *ap)
@@ -1529,81 +1559,207 @@ static struct l_genl_msg *ap_build_cmd_stop_ap(str=
uct ap_state *ap)
 	return cmd;
 }
 =

-static int ap_stop(struct ap_state *ap, struct l_dbus_message *message)
+/*
+ * Schedule the running @ap to be stopped and freed.  The original
+ * event_func and user_data are forgotten and a new callback can be
+ * provided if the caller needs to know when the interface becomes
+ * free, for example for a new ap_start call.
+ *
+ * The user must forget @ap when @stopped_func is called.  If the
+ * @user_data ends up being destroyed before that, ap_free(ap) should
+ * be used to prevent @stopped_func from being called.
+ * If @stopped_func is not provided, the caller must forget @ap
+ * immediately.
+ */
+void ap_shutdown(struct ap_state *ap, ap_stopped_func_t stopped_func,
+			void *user_data)
 {
 	struct l_genl_msg *cmd;
 =

-	cmd =3D ap_build_cmd_stop_ap(ap);
-	if (!cmd)
-		return -ENOMEM;
+	if (ap->started) {
+		ap->started =3D false;
+		ap->event_func(AP_EVENT_STOPPING, NULL, ap->user_data);
+	}
 =

-	if (ap->start_stop_cmd_id)
-		l_genl_family_cancel(ap->nl80211, ap->start_stop_cmd_id);
+	ap_reset(ap);
 =

-	if (ap->mlme_watch)
-		l_genl_family_unregister(ap->nl80211, ap->mlme_watch);
+	if (ap->gtk_set) {
+		ap->gtk_set =3D false;
+
+		cmd =3D ap_build_cmd_del_key(ap);
+		if (!cmd) {
+			l_error("ap_build_cmd_del_key failed");
+			goto free_ap;
+		}
+
+		if (!l_genl_family_send(ap->nl80211, cmd, ap_gtk_op_cb, NULL,
+					NULL)) {
+			l_genl_msg_unref(cmd);
+			l_error("Issuing DEL_KEY failed");
+			goto free_ap;
+		}
+	}
+
+	cmd =3D ap_build_cmd_stop_ap(ap);
+	if (!cmd) {
+		l_error("ap_build_cmd_stop_ap failed");
+		goto free_ap;
+	}
 =

 	ap->start_stop_cmd_id =3D l_genl_family_send(ap->nl80211, cmd, ap_stop_cb,
 							ap, NULL);
 	if (!ap->start_stop_cmd_id) {
 		l_genl_msg_unref(cmd);
-		return -EIO;
+		l_error("Sending STOP_AP failed");
+		goto free_ap;
 	}
 =

-	if (ap->gtk_set) {
-		struct l_genl_msg *msg;
+	ap->stopped_func =3D stopped_func;
+	ap->user_data =3D user_data;
+	return;
 =

-		ap->gtk_set =3D false;
+free_ap:
+	if (stopped_func)
+		stopped_func(user_data);
 =

-		msg =3D ap_build_cmd_del_key(ap);
-		if (!l_genl_family_send(ap->nl80211, msg, ap_gtk_op_cb, NULL,
-					NULL)) {
-			l_genl_msg_unref(msg);
-			l_error("Issuing DEL_KEY failed");
-		}
-	}
+	l_genl_family_free(ap->nl80211);
+	l_free(ap);
+}
 =

-	ap->pending =3D l_dbus_message_ref(message);
+/* Free @ap without a graceful shutdown */
+void ap_free(struct ap_state *ap)
+{
+	ap_reset(ap);
+	l_genl_family_free(ap->nl80211);
+	l_free(ap);
+}
 =

-	return 0;
+bool ap_station_disconnect(struct ap_state *ap, const uint8_t *mac,
+				enum mmpdu_reason_code reason)
+{
+	struct sta_state *sta;
+
+	if (!ap->started)
+		return false;
+
+	sta =3D l_queue_remove_if(ap->sta_states, ap_sta_match_addr, mac);
+	if (!sta)
+		return false;
+
+	ap_del_station(sta, reason, false);
+	ap_sta_free(sta);
+	return true;
+}
+
+struct ap_if_data {
+	struct netdev *netdev;
+	struct ap_state *ap;
+	struct l_dbus_message *pending;
+};
+
+static void ap_if_event_func(enum ap_event_type type, const void *event_da=
ta,
+				void *user_data)
+{
+	struct ap_if_data *ap_if =3D user_data;
+	struct l_dbus_message *reply;
+
+	switch (type) {
+	case AP_EVENT_START_FAILED:
+		if (L_WARN_ON(!ap_if->pending))
+			break;
+
+		reply =3D dbus_error_failed(ap_if->pending);
+		dbus_pending_reply(&ap_if->pending, reply);
+		ap_if->ap =3D NULL;
+		break;
+
+	case AP_EVENT_STARTED:
+		if (L_WARN_ON(!ap_if->pending))
+			break;
+
+		reply =3D l_dbus_message_new_method_return(ap_if->pending);
+		dbus_pending_reply(&ap_if->pending, reply);
+		l_dbus_property_changed(dbus_get_bus(),
+					netdev_get_path(ap_if->netdev),
+					IWD_AP_INTERFACE, "Started");
+		break;
+
+	case AP_EVENT_STOPPING:
+		l_dbus_property_changed(dbus_get_bus(),
+					netdev_get_path(ap_if->netdev),
+					IWD_AP_INTERFACE, "Started");
+
+		if (!ap_if->pending)
+			ap_if->ap =3D NULL;
+
+		break;
+
+	case AP_EVENT_STATION_ADDED:
+	case AP_EVENT_STATION_REMOVED:
+		/* Ignored */
+		break;
+	}
 }
 =

 static struct l_dbus_message *ap_dbus_start(struct l_dbus *dbus,
 		struct l_dbus_message *message, void *user_data)
 {
-	struct ap_state *ap =3D user_data;
+	struct ap_if_data *ap_if =3D user_data;
 	const char *ssid, *wpa2_psk;
 =

-	if (ap->pending)
-		return dbus_error_busy(message);
-
-	if (ap->started)
+	if (ap_if->ap && ap_if->ap->started)
 		return dbus_error_already_exists(message);
 =

+	if (ap_if->ap || ap_if->pending)
+		return dbus_error_busy(message);
+
 	if (!l_dbus_message_get_arguments(message, "ss", &ssid, &wpa2_psk))
 		return dbus_error_invalid_args(message);
 =

-	if (ap_start(ap, ssid, wpa2_psk, message) < 0)
+	ap_if->ap =3D ap_start(ap_if->netdev, ssid, wpa2_psk, 0,
+				ap_if_event_func, ap_if);
+	if (!ap_if->ap)
 		return dbus_error_invalid_args(message);
 =

+	ap_if->pending =3D l_dbus_message_ref(message);
 	return NULL;
 }
 =

+static void ap_dbus_stop_cb(void *user_data)
+{
+	struct ap_if_data *ap_if =3D user_data;
+	struct l_dbus_message *reply;
+
+	if (L_WARN_ON(!ap_if->pending))
+		return;
+
+	reply =3D l_dbus_message_new_method_return(ap_if->pending);
+	dbus_pending_reply(&ap_if->pending, reply);
+	ap_if->ap =3D NULL;
+}
+
 static struct l_dbus_message *ap_dbus_stop(struct l_dbus *dbus,
 		struct l_dbus_message *message, void *user_data)
 {
-	struct ap_state *ap =3D user_data;
+	struct ap_if_data *ap_if =3D user_data;
 =

-	if (ap->pending)
-		return dbus_error_busy(message);
+	if (!ap_if->ap) {
+		if (ap_if->pending)
+			return dbus_error_busy(message);
 =

-	/* already stopped, no-op */
-	if (!ap->started)
+		/* already stopped, no-op */
 		return l_dbus_message_new_method_return(message);
+	}
 =

-	if (ap_stop(ap, message) < 0)
-		return dbus_error_failed(message);
+	if (ap_if->pending) {
+		struct l_dbus_message *reply;
+
+		reply =3D dbus_error_aborted(ap_if->pending);
+		dbus_pending_reply(&ap_if->pending, reply);
+	}
 =

+	ap_if->pending =3D l_dbus_message_ref(message);
+	ap_shutdown(ap_if->ap, ap_dbus_stop_cb, ap_if);
 	return NULL;
 }
 =

@@ -1612,8 +1768,8 @@ static bool ap_dbus_property_get_started(struct l_dbu=
s *dbus,
 					struct l_dbus_message_builder *builder,
 					void *user_data)
 {
-	struct ap_state *ap =3D user_data;
-	bool started =3D ap->started;
+	struct ap_if_data *ap_if =3D user_data;
+	bool started =3D ap_if->ap && ap_if->ap->started;
 =

 	l_dbus_message_builder_append_basic(builder, 'b', &started);
 =

@@ -1632,27 +1788,36 @@ static void ap_setup_interface(struct l_dbus_interf=
ace *interface)
 =

 static void ap_destroy_interface(void *user_data)
 {
-	struct ap_state *ap =3D user_data;
+	struct ap_if_data *ap_if =3D user_data;
+
+	if (ap_if->pending) {
+		struct l_dbus_message *reply;
+
+		reply =3D dbus_error_aborted(ap_if->pending);
+		dbus_pending_reply(&ap_if->pending, reply);
+	}
 =

-	ap_free(ap);
+	if (ap_if->ap)
+		ap_free(ap_if->ap);
+
+	l_free(ap_if);
 }
 =

 static void ap_add_interface(struct netdev *netdev)
 {
-	struct ap_state *ap;
+	struct ap_if_data *ap_if;
 =

 	/*
 	 * TODO: Check wiphy supported channels and NL80211_ATTR_TX_FRAME_TYPES
 	 */
 =

 	/* just allocate/set device, Start method will complete setup */
-	ap =3D l_new(struct ap_state, 1);
-	ap->netdev =3D netdev;
-	ap->nl80211 =3D l_genl_family_new(iwd_get_genl(), NL80211_GENL_NAME);
+	ap_if =3D l_new(struct ap_if_data, 1);
+	ap_if->netdev =3D netdev;
 =

 	/* setup ap dbus interface */
 	l_dbus_object_add_interface(dbus_get_bus(),
-			netdev_get_path(netdev), IWD_AP_INTERFACE, ap);
+			netdev_get_path(netdev), IWD_AP_INTERFACE, ap_if);
 }
 =

 static void ap_remove_interface(struct netdev *netdev)
diff --git a/src/ap.h b/src/ap.h
new file mode 100644
index 00000000..1fd8b63e
--- /dev/null
+++ b/src/ap.h
@@ -0,0 +1,56 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2020  Intel Corporation. All rights reserved.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+struct ap_state;
+struct iovec;
+
+enum ap_event_type {
+	AP_EVENT_START_FAILED,
+	AP_EVENT_STARTED,
+	AP_EVENT_STOPPING,
+	AP_EVENT_STATION_ADDED,
+	AP_EVENT_STATION_REMOVED,
+};
+
+struct ap_event_station_added_data {
+	const uint8_t *mac;
+	const uint8_t *rsn_ie;
+};
+
+struct ap_event_station_removed_data {
+	const uint8_t *mac;
+	enum mmpdu_reason_code reason;
+};
+
+typedef void (*ap_event_func_t)(enum ap_event_type type, const void *event=
_data,
+				void *user_data);
+typedef void (*ap_stopped_func_t)(void *user_data);
+
+struct ap_state *ap_start(struct netdev *netdev, const char *ssid,
+				const char *psk, int channel,
+				ap_event_func_t event_func, void *user_data);
+void ap_shutdown(struct ap_state *ap, ap_stopped_func_t stopped_func,
+			void *user_data);
+void ap_free(struct ap_state *ap);
+
+bool ap_station_disconnect(struct ap_state *ap, const uint8_t *mac,
+				enum mmpdu_reason_code reason);
-- =

2.25.1

--===============3502526717637660490==--

