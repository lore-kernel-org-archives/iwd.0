Content-Type: multipart/mixed; boundary="===============6526941034796865351=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/3] wsc: Refactor WSC D-Bus interface logic
Date: Thu, 16 Jan 2020 05:29:30 +0100
Message-ID: <20200116042931.8849-2-andrew.zaborowski@intel.com>
In-Reply-To: <20200116042931.8849-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6526941034796865351==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Split the WSC D-Bus interface class (struct wsc) into a base class
common to station mode and P2P mode (struct wsc_dbus) and station-
specific logic like scanning, saving the credentials as a known network
and triggering the station-mode connection (struct wsc_station_dbus).

Make the base class and its utilities public in wsc.h for P2P use.
---
 src/wsc.c | 363 +++++++++++++++++++++++++++++++++---------------------
 src/wsc.h |  13 ++
 2 files changed, 236 insertions(+), 140 deletions(-)

diff --git a/src/wsc.c b/src/wsc.c
index e381b84f..4f079977 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -61,20 +61,6 @@ struct wsc_enrollee {
 	bool disconnecting : 1;
 };
 =

-struct wsc {
-	struct netdev *netdev;
-	struct station *station;
-	struct wsc_enrollee *enrollee;
-	struct l_dbus_message *pending;
-	struct l_dbus_message *pending_cancel;
-	uint8_t *wsc_ies;
-	size_t wsc_ies_size;
-	struct l_timeout *walk_timer;
-	uint32_t scan_id;
-	struct scan_bss *target;
-	uint32_t station_state_watch;
-};
-
 static struct l_dbus_message *wsc_error_session_overlap(
 						struct l_dbus_message *msg)
 {
@@ -469,7 +455,20 @@ void wsc_enrollee_destroy(struct wsc_enrollee *wsce)
 	wsc_enrollee_free(wsce);
 }
 =

-static void wsc_try_credentials(struct wsc *wsc,
+struct wsc_station_dbus {
+	struct wsc_dbus super;
+	struct wsc_enrollee *enrollee;
+	struct scan_bss *target;
+	struct netdev *netdev;
+	struct station *station;
+	uint8_t *wsc_ies;
+	size_t wsc_ies_size;
+	struct l_timeout *walk_timer;
+	uint32_t scan_id;
+	uint32_t station_state_watch;
+};
+
+static void wsc_try_credentials(struct wsc_station_dbus *wsc,
 				struct wsc_credentials_info *creds,
 				unsigned int n_creds)
 {
@@ -510,15 +509,15 @@ static void wsc_try_credentials(struct wsc *wsc,
 		}
 =

 		station_connect_network(wsc->station, network, bss,
-								wsc->pending);
-		l_dbus_message_unref(wsc->pending);
-		wsc->pending =3D NULL;
+						wsc->super.pending_connect);
+		l_dbus_message_unref(wsc->super.pending_connect);
+		wsc->super.pending_connect =3D NULL;
 =

 		return;
 	}
 =

-	dbus_pending_reply(&wsc->pending,
-					wsc_error_not_reachable(wsc->pending));
+	dbus_pending_reply(&wsc->super.pending_connect,
+			wsc_error_not_reachable(wsc->super.pending_connect));
 	station_set_autoconnect(wsc->station, true);
 }
 =

@@ -559,11 +558,10 @@ static void wsc_store_credentials(struct wsc_credenti=
als_info *creds,
 	}
 }
 =

-/* Done callback for when WSC is triggered by DBus methods */
 static void wsc_dbus_done_cb(int err, struct wsc_credentials_info *creds,
 				unsigned int n_creds, void *user_data)
 {
-	struct wsc *wsc =3D user_data;
+	struct wsc_station_dbus *wsc =3D user_data;
 =

 	wsc->enrollee =3D NULL;
 	wsc->target =3D NULL;
@@ -578,27 +576,31 @@ static void wsc_dbus_done_cb(int err, struct wsc_cred=
entials_info *creds,
 		break;
 	case -ECANCELED:
 		/* Send reply if we haven't already sent one e.g. in Cancel() */
-		if (wsc->pending)
-			dbus_pending_reply(&wsc->pending,
-					dbus_error_aborted(wsc->pending));
+		if (wsc->super.pending_connect)
+			dbus_pending_reply(&wsc->super.pending_connect,
+					dbus_error_aborted(
+						wsc->super.pending_connect));
 =

-		if (wsc->pending_cancel)
-			dbus_pending_reply(&wsc->pending_cancel,
+		if (wsc->super.pending_cancel)
+			dbus_pending_reply(&wsc->super.pending_cancel,
 					l_dbus_message_new_method_return(
-							wsc->pending_cancel));
+						wsc->super.pending_cancel));
 =

 		return;
 	case -ENOKEY:
-		dbus_pending_reply(&wsc->pending,
-					wsc_error_no_credentials(wsc->pending));
+		dbus_pending_reply(&wsc->super.pending_connect,
+					wsc_error_no_credentials(
+						wsc->super.pending_connect));
 		return;
 	case -EBUSY:
-		dbus_pending_reply(&wsc->pending,
-					dbus_error_busy(wsc->pending));
+		dbus_pending_reply(&wsc->super.pending_connect,
+					dbus_error_busy(
+						wsc->super.pending_connect));
 		return;
 	default:
-		dbus_pending_reply(&wsc->pending,
-					dbus_error_failed(wsc->pending));
+		dbus_pending_reply(&wsc->super.pending_connect,
+					dbus_error_failed(
+						wsc->super.pending_connect));
 		return;
 	}
 =

@@ -606,12 +608,14 @@ static void wsc_dbus_done_cb(int err, struct wsc_cred=
entials_info *creds,
 	wsc_try_credentials(wsc, creds, n_creds);
 }
 =

-static void wsc_connect(struct wsc *wsc)
+static void wsc_connect(struct wsc_station_dbus *wsc)
 {
 	const char *pin =3D NULL;
 =

-	if (!strcmp(l_dbus_message_get_member(wsc->pending), "StartPin"))
-		l_dbus_message_get_arguments(wsc->pending, "s", &pin);
+	if (!strcmp(l_dbus_message_get_member(wsc->super.pending_connect),
+			"StartPin"))
+		l_dbus_message_get_arguments(wsc->super.pending_connect, "s",
+						&pin);
 =

 	wsc->enrollee =3D wsc_enrollee_new(wsc->netdev, wsc->target, pin,
 						wsc_dbus_done_cb, wsc);
@@ -623,7 +627,7 @@ static void wsc_connect(struct wsc *wsc)
 =

 static void station_state_watch(enum station_state state, void *userdata)
 {
-	struct wsc *wsc =3D userdata;
+	struct wsc_station_dbus *wsc =3D userdata;
 =

 	if (state !=3D STATION_STATE_DISCONNECTED)
 		return;
@@ -636,7 +640,8 @@ static void station_state_watch(enum station_state stat=
e, void *userdata)
 	wsc_connect(wsc);
 }
 =

-static void wsc_check_can_connect(struct wsc *wsc, struct scan_bss *target)
+static void wsc_check_can_connect(struct wsc_station_dbus *wsc,
+					struct scan_bss *target)
 {
 	l_debug("%p", wsc);
 =

@@ -671,10 +676,11 @@ static void wsc_check_can_connect(struct wsc *wsc, st=
ruct scan_bss *target)
 	}
 error:
 	wsc->target =3D NULL;
-	dbus_pending_reply(&wsc->pending, dbus_error_failed(wsc->pending));
+	dbus_pending_reply(&wsc->super.pending_connect,
+				dbus_error_failed(wsc->super.pending_connect));
 }
 =

-static void wsc_cancel_scan(struct wsc *wsc)
+static void wsc_cancel_scan(struct wsc_station_dbus *wsc)
 {
 	l_free(wsc->wsc_ies);
 	wsc->wsc_ies =3D 0;
@@ -692,30 +698,32 @@ static void wsc_cancel_scan(struct wsc *wsc)
 =

 static void walk_timeout(struct l_timeout *timeout, void *user_data)
 {
-	struct wsc *wsc =3D user_data;
+	struct wsc_station_dbus *wsc =3D user_data;
 =

 	wsc_cancel_scan(wsc);
 =

-	if (wsc->pending)
-		dbus_pending_reply(&wsc->pending,
-				wsc_error_walk_time_expired(wsc->pending));
+	if (wsc->super.pending_connect)
+		dbus_pending_reply(&wsc->super.pending_connect,
+				wsc_error_walk_time_expired(
+						wsc->super.pending_connect));
 }
 =

 static void pin_timeout(struct l_timeout *timeout, void *user_data)
 {
-	struct wsc *wsc =3D user_data;
+	struct wsc_station_dbus *wsc =3D user_data;
 =

 	wsc_cancel_scan(wsc);
 =

-	if (wsc->pending)
-		dbus_pending_reply(&wsc->pending,
-					wsc_error_time_expired(wsc->pending));
+	if (wsc->super.pending_connect)
+		dbus_pending_reply(&wsc->super.pending_connect,
+				wsc_error_time_expired(
+						wsc->super.pending_connect));
 }
 =

 static bool push_button_scan_results(int err, struct l_queue *bss_list,
 					void *userdata)
 {
-	struct wsc *wsc =3D userdata;
+	struct wsc_station_dbus *wsc =3D userdata;
 	struct scan_bss *bss_2g;
 	struct scan_bss *bss_5g;
 	struct scan_bss *target;
@@ -726,8 +734,8 @@ static bool push_button_scan_results(int err, struct l_=
queue *bss_list,
 =

 	if (err) {
 		wsc_cancel_scan(wsc);
-		dbus_pending_reply(&wsc->pending,
-					dbus_error_failed(wsc->pending));
+		dbus_pending_reply(&wsc->super.pending_connect,
+				dbus_error_failed(wsc->super.pending_connect));
 =

 		return false;
 	}
@@ -828,8 +836,8 @@ static bool push_button_scan_results(int err, struct l_=
queue *bss_list,
 =

 session_overlap:
 	wsc_cancel_scan(wsc);
-	dbus_pending_reply(&wsc->pending,
-				wsc_error_session_overlap(wsc->pending));
+	dbus_pending_reply(&wsc->super.pending_connect,
+			wsc_error_session_overlap(wsc->super.pending_connect));
 =

 	return false;
 }
@@ -873,15 +881,15 @@ static bool pin_scan_results(int err, struct l_queue =
*bss_list, void *userdata)
 {
 	static const uint8_t wildcard_address[] =3D
 					{ 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
-	struct wsc *wsc =3D userdata;
+	struct wsc_station_dbus *wsc =3D userdata;
 	struct scan_bss *target =3D NULL;
 	const struct l_queue_entry *bss_entry;
 	struct wsc_probe_response probe_response;
 =

 	if (err) {
 		wsc_cancel_scan(wsc);
-		dbus_pending_reply(&wsc->pending,
-					dbus_error_failed(wsc->pending));
+		dbus_pending_reply(&wsc->super.pending_connect,
+				dbus_error_failed(wsc->super.pending_connect));
 =

 		return false;
 	}
@@ -973,7 +981,7 @@ static bool pin_scan_results(int err, struct l_queue *b=
ss_list, void *userdata)
 	return true;
 }
 =

-static bool wsc_initiate_scan(struct wsc *wsc,
+static bool wsc_initiate_scan(struct wsc_station_dbus *wsc,
 					enum wsc_device_password_id dpid,
 					scan_notify_func_t callback)
 {
@@ -1037,28 +1045,117 @@ static bool wsc_initiate_scan(struct wsc *wsc,
 	return true;
 }
 =

+static const char *wsc_station_dbus_get_path(struct wsc_dbus *super)
+{
+	struct wsc_station_dbus *wsc =3D
+		l_container_of(super, struct wsc_station_dbus, super);
+
+	return netdev_get_path(wsc->netdev);
+}
+
+static void wsc_station_dbus_connect(struct wsc_dbus *super,
+						const char *pin)
+{
+	struct wsc_station_dbus *wsc =3D
+		l_container_of(super, struct wsc_station_dbus, super);
+	scan_notify_func_t scan_callback;
+	enum wsc_device_password_id dpid;
+
+	wsc->station =3D station_find(netdev_get_ifindex(wsc->netdev));
+	if (!wsc->station) {
+		dbus_pending_reply(&wsc->super.pending_connect,
+					dbus_error_not_available(
+						wsc->super.pending_connect));
+		return;
+	}
+
+	if (pin) {
+		if (strlen(pin) =3D=3D 4 || wsc_pin_is_checksum_valid(pin))
+			dpid =3D WSC_DEVICE_PASSWORD_ID_DEFAULT;
+		else
+			dpid =3D WSC_DEVICE_PASSWORD_ID_USER_SPECIFIED;
+
+		scan_callback =3D pin_scan_results;
+	} else {
+		dpid =3D WSC_DEVICE_PASSWORD_ID_PUSH_BUTTON;
+		scan_callback =3D push_button_scan_results;
+	}
+
+	if (!wsc_initiate_scan(wsc, dpid, scan_callback)) {
+		dbus_pending_reply(&wsc->super.pending_connect,
+					dbus_error_failed(
+						wsc->super.pending_connect));
+		return;
+	}
+
+	if (pin) {
+		wsc->walk_timer =3D l_timeout_create(60, pin_timeout, wsc, NULL);
+	} else {
+		wsc->walk_timer =3D l_timeout_create(WALK_TIME, walk_timeout, wsc,
+							NULL);
+	}
+}
+
+static void wsc_station_dbus_cancel(struct wsc_dbus *super)
+{
+	struct wsc_station_dbus *wsc =3D
+		l_container_of(super, struct wsc_station_dbus, super);
+
+	wsc_cancel_scan(wsc);
+
+	if (wsc->station_state_watch) {
+		station_remove_state_watch(wsc->station,
+						wsc->station_state_watch);
+		wsc->station_state_watch =3D 0;
+		wsc->target =3D NULL;
+	}
+
+	dbus_pending_reply(&wsc->super.pending_connect,
+				dbus_error_aborted(wsc->super.pending_connect));
+
+	if (wsc->enrollee)
+		wsc_enrollee_cancel(wsc->enrollee, true);
+	else
+		dbus_pending_reply(&wsc->super.pending_cancel,
+					l_dbus_message_new_method_return(
+						wsc->super.pending_cancel));
+}
+
+static void wsc_station_dbus_remove(struct wsc_dbus *super)
+{
+	struct wsc_station_dbus *wsc =3D
+		l_container_of(super, struct wsc_station_dbus, super);
+
+	wsc_cancel_scan(wsc);
+
+	if (wsc->station_state_watch) {
+		station_remove_state_watch(wsc->station,
+						wsc->station_state_watch);
+		wsc->station_state_watch =3D 0;
+	}
+
+	if (wsc->enrollee)
+		wsc_enrollee_destroy(wsc->enrollee);
+
+	l_free(wsc);
+}
+
 static struct l_dbus_message *wsc_push_button(struct l_dbus *dbus,
 						struct l_dbus_message *message,
 						void *user_data)
 {
-	struct wsc *wsc =3D user_data;
+	struct wsc_dbus *wsc =3D user_data;
 =

 	l_debug("");
 =

-	if (wsc->pending)
-		return dbus_error_busy(message);
-
-	wsc->station =3D station_find(netdev_get_ifindex(wsc->netdev));
-	if (!wsc->station)
-		return dbus_error_not_available(message);
-
-	if (!wsc_initiate_scan(wsc, WSC_DEVICE_PASSWORD_ID_PUSH_BUTTON,
-				push_button_scan_results))
-		return dbus_error_failed(message);
+	if (!l_dbus_message_get_arguments(message, ""))
+		return dbus_error_invalid_args(message);
 =

-	wsc->walk_timer =3D l_timeout_create(WALK_TIME, walk_timeout, wsc, NULL);
-	wsc->pending =3D l_dbus_message_ref(message);
+	if (wsc->pending_connect)
+		return dbus_error_busy(message);
 =

+	wsc->pending_connect =3D l_dbus_message_ref(message);
+	wsc->connect(wsc, NULL);
 	return NULL;
 }
 =

@@ -1066,13 +1163,13 @@ static struct l_dbus_message *wsc_generate_pin(stru=
ct l_dbus *dbus,
 						struct l_dbus_message *message,
 						void *user_data)
 {
-	struct wsc *wsc =3D user_data;
+	struct wsc_dbus *wsc =3D user_data;
 	struct l_dbus_message *reply;
 	char pin[9];
 =

 	l_debug("");
 =

-	if (wsc->pending)
+	if (wsc->pending_connect)
 		return dbus_error_busy(message);
 =

 	if (!wsc_pin_generate(pin))
@@ -1088,36 +1185,22 @@ static struct l_dbus_message *wsc_start_pin(struct =
l_dbus *dbus,
 						struct l_dbus_message *message,
 						void *user_data)
 {
-	struct wsc *wsc =3D user_data;
+	struct wsc_dbus *wsc =3D user_data;
 	const char *pin;
-	enum wsc_device_password_id dpid;
 =

 	l_debug("");
 =

-	if (wsc->pending)
+	if (wsc->pending_connect)
 		return dbus_error_busy(message);
 =

-	wsc->station =3D station_find(netdev_get_ifindex(wsc->netdev));
-	if (!wsc->station)
-		return dbus_error_not_available(message);
-
 	if (!l_dbus_message_get_arguments(message, "s", &pin))
 		return dbus_error_invalid_args(message);
 =

 	if (!wsc_pin_is_valid(pin))
 		return dbus_error_invalid_format(message);
 =

-	if (strlen(pin) =3D=3D 4 || wsc_pin_is_checksum_valid(pin))
-		dpid =3D WSC_DEVICE_PASSWORD_ID_DEFAULT;
-	else
-		dpid =3D WSC_DEVICE_PASSWORD_ID_USER_SPECIFIED;
-
-	if (!wsc_initiate_scan(wsc, dpid, pin_scan_results))
-		return dbus_error_failed(message);
-
-	wsc->walk_timer =3D l_timeout_create(60, pin_timeout, wsc, NULL);
-	wsc->pending =3D l_dbus_message_ref(message);
-
+	wsc->pending_connect =3D l_dbus_message_ref(message);
+	wsc->connect(wsc, pin);
 	return NULL;
 }
 =

@@ -1125,33 +1208,22 @@ static struct l_dbus_message *wsc_cancel(struct l_d=
bus *dbus,
 						struct l_dbus_message *message,
 						void *user_data)
 {
-	struct wsc *wsc =3D user_data;
+	struct wsc_dbus *wsc =3D user_data;
 =

 	l_debug("");
 =

-	if (!wsc->pending)
+	if (!l_dbus_message_get_arguments(message, ""))
+		return dbus_error_invalid_args(message);
+
+	if (!wsc->pending_connect)
 		return dbus_error_not_available(message);
 =

 	if (wsc->pending_cancel)
 		return dbus_error_busy(message);
 =

-	wsc_cancel_scan(wsc);
-
-	if (wsc->station_state_watch) {
-		station_remove_state_watch(wsc->station,
-						wsc->station_state_watch);
-		wsc->station_state_watch =3D 0;
-		wsc->target =3D NULL;
-	}
-
-	dbus_pending_reply(&wsc->pending, dbus_error_aborted(wsc->pending));
-
-	if (wsc->enrollee) {
-		wsc_enrollee_cancel(wsc->enrollee, true);
-		wsc->pending_cancel =3D l_dbus_message_ref(message);
-		return NULL;
-	} else
-		return l_dbus_message_new_method_return(message);
+	wsc->pending_cancel =3D l_dbus_message_ref(message);
+	wsc->cancel(wsc);
+	return NULL;
 }
 =

 static void setup_wsc_interface(struct l_dbus_interface *interface)
@@ -1166,36 +1238,47 @@ static void setup_wsc_interface(struct l_dbus_inter=
face *interface)
 				wsc_cancel, "", "");
 }
 =

-static void wsc_free(void *userdata)
+bool wsc_dbus_add_interface(struct wsc_dbus *wsc)
 {
-	struct wsc *wsc =3D userdata;
-
-	wsc_cancel_scan(wsc);
+	struct l_dbus *dbus =3D dbus_get_bus();
 =

-	if (wsc->station_state_watch) {
-		station_remove_state_watch(wsc->station,
-						wsc->station_state_watch);
-		wsc->station_state_watch =3D 0;
+	if (!l_dbus_object_add_interface(dbus, wsc->get_path(wsc),
+						IWD_WSC_INTERFACE, wsc)) {
+		l_info("Unable to register %s interface", IWD_WSC_INTERFACE);
+		return false;
 	}
 =

-	if (wsc->pending)
-		dbus_pending_reply(&wsc->pending,
-					dbus_error_not_available(wsc->pending));
+	return true;
+}
+
+void wsc_dbus_remove_interface(struct wsc_dbus *wsc)
+{
+	struct l_dbus *dbus =3D dbus_get_bus();
+
+	l_dbus_object_remove_interface(dbus, wsc->get_path(wsc),
+					IWD_WSC_INTERFACE);
+}
+
+static void wsc_dbus_free(void *user_data)
+{
+	struct wsc_dbus *wsc =3D user_data;
+
+	if (wsc->pending_connect)
+		dbus_pending_reply(&wsc->pending_connect,
+					dbus_error_not_available(
+						wsc->pending_connect));
 =

 	if (wsc->pending_cancel)
 		dbus_pending_reply(&wsc->pending_cancel,
-				dbus_error_not_available(wsc->pending_cancel));
-
-	if (wsc->enrollee)
-		wsc_enrollee_destroy(wsc->enrollee);
+					dbus_error_not_available(
+						wsc->pending_cancel));
 =

-	l_free(wsc);
+	wsc->remove(wsc);
 }
 =

-static void wsc_add_interface(struct netdev *netdev)
+static void wsc_add_station(struct netdev *netdev)
 {
-	struct l_dbus *dbus =3D dbus_get_bus();
-	struct wsc *wsc;
+	struct wsc_station_dbus *wsc;
 =

 	if (!wiphy_get_max_scan_ie_len(netdev_get_wiphy(netdev))) {
 		l_debug("Simple Configuration isn't supported by ifindex %u",
@@ -1204,18 +1287,18 @@ static void wsc_add_interface(struct netdev *netdev)
 		return;
 	}
 =

-	wsc =3D l_new(struct wsc, 1);
+	wsc =3D l_new(struct wsc_station_dbus, 1);
 	wsc->netdev =3D netdev;
+	wsc->super.get_path =3D wsc_station_dbus_get_path;
+	wsc->super.connect =3D wsc_station_dbus_connect;
+	wsc->super.cancel =3D wsc_station_dbus_cancel;
+	wsc->super.remove =3D wsc_station_dbus_remove;
 =

-	if (!l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
-						IWD_WSC_INTERFACE,
-						wsc)) {
-		wsc_free(wsc);
-		l_info("Unable to register %s interface", IWD_WSC_INTERFACE);
-	}
+	if (!wsc_dbus_add_interface(&wsc->super))
+		wsc_station_dbus_remove(&wsc->super);
 }
 =

-static void wsc_remove_interface(struct netdev *netdev)
+static void wsc_remove_station(struct netdev *netdev)
 {
 	struct l_dbus *dbus =3D dbus_get_bus();
 =

@@ -1231,11 +1314,11 @@ static void wsc_netdev_watch(struct netdev *netdev,
 	case NETDEV_WATCH_EVENT_NEW:
 		if (netdev_get_iftype(netdev) =3D=3D NETDEV_IFTYPE_STATION &&
 				netdev_get_is_up(netdev))
-			wsc_add_interface(netdev);
+			wsc_add_station(netdev);
 		break;
 	case NETDEV_WATCH_EVENT_DOWN:
 	case NETDEV_WATCH_EVENT_DEL:
-		wsc_remove_interface(netdev);
+		wsc_remove_station(netdev);
 		break;
 	default:
 		break;
@@ -1248,7 +1331,7 @@ static int wsc_init(void)
 	netdev_watch =3D netdev_watch_add(wsc_netdev_watch, NULL, NULL);
 	l_dbus_register_interface(dbus_get_bus(), IWD_WSC_INTERFACE,
 					setup_wsc_interface,
-					wsc_free, false);
+					wsc_dbus_free, false);
 	return 0;
 }
 =

diff --git a/src/wsc.h b/src/wsc.h
index 14084aea..fdf677b6 100644
--- a/src/wsc.h
+++ b/src/wsc.h
@@ -42,3 +42,16 @@ struct wsc_enrollee *wsc_enrollee_new(struct netdev *net=
dev,
 					wsc_done_cb_t done_cb, void *user_data);
 void wsc_enrollee_cancel(struct wsc_enrollee *wsce, bool defer_cb);
 void wsc_enrollee_destroy(struct wsc_enrollee *wsce);
+
+struct wsc_dbus {
+	struct l_dbus_message *pending_connect;
+	struct l_dbus_message *pending_cancel;
+
+	const char *(*get_path)(struct wsc_dbus *wsc);
+	void (*connect)(struct wsc_dbus *wsc, const char *pin);
+	void (*cancel)(struct wsc_dbus *wsc);
+	void (*remove)(struct wsc_dbus *wsc);
+};
+
+bool wsc_dbus_add_interface(struct wsc_dbus *wsc);
+void wsc_dbus_remove_interface(struct wsc_dbus *wsc);
-- =

2.20.1

--===============6526941034796865351==--

