Content-Type: multipart/mixed; boundary="===============2434457378494357917=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/4] wsc: Refactor to make the DBus interface reusable
Date: Thu, 19 Dec 2019 04:50:58 +0100
Message-ID: <20191219035059.15214-3-andrew.zaborowski@intel.com>
In-Reply-To: <20191219035059.15214-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2434457378494357917==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Allow adding the DBus SimpleConfiguration interface on both station mode
netdevs and P2P peers by putting public functions and callbacks between
the DBus method handlers and their actual implementation.  The
implementation provides its own callbacks for each method using the
wsc_ops struct.

For patch readability I didn't move some functions in wsc.c around and
group them logically, we can do the moving separately.
---
 src/wsc.c | 406 ++++++++++++++++++++++++++++++++----------------------
 src/wsc.h |  21 ++-
 2 files changed, 263 insertions(+), 164 deletions(-)

diff --git a/src/wsc.c b/src/wsc.c
index 222cc222..1901feb6 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -52,6 +52,9 @@
 static uint32_t netdev_watch =3D 0;
 =

 struct wsc {
+	const struct wsc_ops *ops;
+	void *user_data;
+
 	struct netdev *netdev;
 	struct station *station;
 	struct l_dbus_message *pending;
@@ -66,9 +69,6 @@ struct wsc {
 	uint32_t n_creds;
 	struct l_settings *eap_settings;
 	char *pin;
-
-	wsc_done_cb_t done_cb;
-	void *done_data;
 	uint16_t config_method;
 =

 	bool wsc_association : 1;
@@ -113,20 +113,20 @@ static struct l_dbus_message *wsc_error_time_expired(=
struct l_dbus_message *msg)
 					"No APs in PIN mode found in "
 					"the alloted time");
 }
-static void wsc_try_credentials(struct wsc *wsc)
+static void wsc_try_credentials(struct wsc *wsc, struct wsc_credentials_in=
fo *creds,
+					unsigned int n_creds)
 {
 	unsigned int i;
 	struct network *network;
 	struct scan_bss *bss;
 =

-	for (i =3D 0; i < wsc->n_creds; i++) {
-		network =3D station_network_find(wsc->station,
-						wsc->creds[i].ssid,
-						wsc->creds[i].security);
+	for (i =3D 0; i < n_creds; i++) {
+		network =3D station_network_find(wsc->station, creds[i].ssid,
+						creds[i].security);
 		if (!network)
 			continue;
 =

-		bss =3D network_bss_find_by_addr(network, wsc->creds[i].addr);
+		bss =3D network_bss_find_by_addr(network, creds[i].addr);
 =

 		if (!bss)
 			bss =3D network_bss_select(network, true);
@@ -134,7 +134,7 @@ static void wsc_try_credentials(struct wsc *wsc)
 		if (!bss)
 			continue;
 =

-		if (wsc->creds[i].security =3D=3D SECURITY_PSK) {
+		if (creds[i].security =3D=3D SECURITY_PSK) {
 			bool ret;
 =

 			/*
@@ -142,12 +142,11 @@ static void wsc_try_credentials(struct wsc *wsc)
 			 * WPA2 and WPA3 since the PSK can always be generated
 			 * if needed
 			 */
-			if (wsc->creds[i].has_passphrase)
+			if (creds[i].has_passphrase)
 				ret =3D network_set_passphrase(network,
-						wsc->creds[i].passphrase);
+							creds[i].passphrase);
 			else
-				ret =3D network_set_psk(network,
-						wsc->creds[i].psk);
+				ret =3D network_set_psk(network, creds[i].psk);
 =

 			if (!ret)
 				continue;
@@ -166,21 +165,22 @@ static void wsc_try_credentials(struct wsc *wsc)
 	station_set_autoconnect(wsc->station, true);
 }
 =

-static void wsc_store_credentials(struct wsc *wsc)
+static void wsc_store_credentials(struct wsc_credentials_info *creds,
+					unsigned int n_creds)
 {
 	unsigned int i;
 =

-	for (i =3D 0; i < wsc->n_creds; i++) {
-		enum security security =3D wsc->creds[i].security;
-		const char *ssid =3D wsc->creds[i].ssid;
+	for (i =3D 0; i < n_creds; i++) {
+		enum security security =3D creds[i].security;
+		const char *ssid =3D creds[i].ssid;
 		struct l_settings *settings =3D l_settings_new();
 =

 		l_debug("Storing credential for '%s(%s)'", ssid,
 						security_to_str(security));
 =

 		if (security =3D=3D SECURITY_PSK) {
-			char *hex =3D l_util_hexstring(wsc->creds[i].psk,
-						sizeof(wsc->creds[i].psk));
+			char *hex =3D l_util_hexstring(creds[i].psk,
+						sizeof(creds[i].psk));
 =

 			l_settings_set_value(settings, "Security",
 							"PreSharedKey", hex);
@@ -210,8 +210,6 @@ static void wsc_disconnect_cb(struct netdev *netdev, bo=
ol success,
 =

 	l_debug("%p, success: %d", wsc, success);
 =

-	wsc->wsc_association =3D false;
-
 	reply =3D l_dbus_message_new_method_return(wsc->pending_cancel);
 	l_dbus_message_set_arguments(reply, "");
 	dbus_pending_reply(&wsc->pending_cancel, reply);
@@ -251,20 +249,20 @@ static void wsc_connect_cb(struct netdev *netdev, enu=
m netdev_result result,
 		memcpy(creds, wsc->creds, sizeof(creds));
 		explicit_bzero(wsc->creds, sizeof(creds));
 		wsc->n_creds =3D 0;
-		wsc->done_cb(0, creds, n_creds, wsc->done_data);
+		wsc->ops->enrollee_done_cb(0, creds, n_creds, wsc->user_data);
 		explicit_bzero(creds, sizeof(creds));
 		return;
 	}
 =

 	switch (result) {
 	case NETDEV_RESULT_ABORTED:
-		wsc->done_cb(-ECANCELED, NULL, 0, wsc->done_data);
+		wsc->ops->enrollee_done_cb(-ECANCELED, NULL, 0, wsc->user_data);
 		return;
 	case NETDEV_RESULT_HANDSHAKE_FAILED:
-		wsc->done_cb(-ENOKEY, NULL, 0, wsc->done_data);
+		wsc->ops->enrollee_done_cb(-ENOKEY, NULL, 0, wsc->user_data);
 		break;
 	default:
-		wsc->done_cb(-EIO, NULL, 0, wsc->done_data);
+		wsc->ops->enrollee_done_cb(-EIO, NULL, 0, wsc->user_data);
 		break;
 	}
 =

@@ -525,40 +523,19 @@ static void wsc_connect(struct wsc *wsc)
 error:
 	handshake_state_free(hs);
 	wsc_connect_cleanup(wsc);
-	wsc->done_cb(r, NULL, 0, wsc->done_data);
+	wsc->ops->enrollee_done_cb(r, NULL, 0, wsc->user_data);
 }
 =

-/* Done callback for when WSC is triggered by DBus methods */
-static void wsc_dbus_done_cb(int err, struct wsc_credentials_info *creds,
-				unsigned int n_creds, void *user_data)
+static void wsc_connect_set_method(struct wsc *wsc)
 {
-	struct wsc *wsc =3D user_data;
-
-	l_debug("err=3D%i", err);
+	const char *pin;
 =

-	switch (err) {
-	case 0:
-		break;
-	case -ECANCELED:
-		dbus_pending_reply(&wsc->pending,
-					dbus_error_aborted(wsc->pending));
-		return;
-	case -ENOKEY:
-		dbus_pending_reply(&wsc->pending,
-					wsc_error_no_credentials(wsc->pending));
-		return;
-	case -EBUSY:
-		dbus_pending_reply(&wsc->pending,
-					dbus_error_busy(wsc->pending));
-		return;
-	default:
-		dbus_pending_reply(&wsc->pending,
-					dbus_error_failed(wsc->pending));
-		return;
-	}
+	if (!strcmp(l_dbus_message_get_member(wsc->pending), "StartPin"))
+		l_dbus_message_get_arguments(wsc->pending, "s", &pin);
+	else
+		pin =3D NULL;
 =

-	wsc_store_credentials(wsc);
-	wsc_try_credentials(wsc);
+	wsc_start_enrollee(wsc, wsc->netdev, wsc->target, pin, NULL, 0);
 }
 =

 static void station_state_watch(enum station_state state, void *userdata)
@@ -573,7 +550,7 @@ static void station_state_watch(enum station_state stat=
e, void *userdata)
 	station_remove_state_watch(wsc->station, wsc->station_state_watch);
 	wsc->station_state_watch =3D 0;
 =

-	wsc_connect(wsc);
+	wsc_connect_set_method(wsc);
 }
 =

 static void wsc_check_can_connect(struct wsc *wsc, struct scan_bss *target)
@@ -587,25 +564,9 @@ static void wsc_check_can_connect(struct wsc *wsc, str=
uct scan_bss *target)
 	wsc->target =3D target;
 	station_set_autoconnect(wsc->station, false);
 =

-	if (!strcmp(l_dbus_message_get_member(wsc->pending), "StartPin")) {
-		char *pin;
-
-		wsc->config_method =3D WSC_CONFIGURATION_METHOD_KEYPAD;
-
-		if (!l_dbus_message_get_arguments(wsc->pending, "s", &pin))
-			goto error;
-
-		wsc->pin =3D l_strdup(pin);
-	} else
-		wsc->config_method =3D
-			WSC_CONFIGURATION_METHOD_VIRTUAL_PUSH_BUTTON;
-
-	wsc->done_cb =3D wsc_dbus_done_cb;
-	wsc->done_data =3D wsc;
-
 	switch (station_get_state(wsc->station)) {
 	case STATION_STATE_DISCONNECTED:
-		wsc_connect(wsc);
+		wsc_connect_set_method(wsc);
 		return;
 	case STATION_STATE_CONNECTING:
 	case STATION_STATE_CONNECTED:
@@ -652,20 +613,13 @@ static void walk_timeout(struct l_timeout *timeout, v=
oid *user_data)
 =

 	wsc_cancel_scan(wsc);
 =

-	if (wsc->pending)
-		dbus_pending_reply(&wsc->pending,
-				wsc_error_walk_time_expired(wsc->pending));
-}
+	if (wsc->pending) {
+		struct l_dbus_message *reply =3D wsc->pin ?
+			wsc_error_time_expired(wsc->pending) :
+			wsc_error_walk_time_expired(wsc->pending);
 =

-static void pin_timeout(struct l_timeout *timeout, void *user_data)
-{
-	struct wsc *wsc =3D user_data;
-
-	wsc_cancel_scan(wsc);
-
-	if (wsc->pending)
-		dbus_pending_reply(&wsc->pending,
-					wsc_error_time_expired(wsc->pending));
+		dbus_pending_reply(&wsc->pending, reply);
+	}
 }
 =

 static bool push_button_scan_results(int err, struct l_queue *bss_list,
@@ -1001,20 +955,7 @@ static struct l_dbus_message *wsc_push_button(struct =
l_dbus *dbus,
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
-
-	wsc->walk_timer =3D l_timeout_create(WALK_TIME, walk_timeout, wsc, NULL);
-	wsc->pending =3D l_dbus_message_ref(message);
-
+	wsc->ops->connect(message, NULL, wsc->user_data);
 	return NULL;
 }
 =

@@ -1046,77 +987,29 @@ static struct l_dbus_message *wsc_start_pin(struct l=
_dbus *dbus,
 {
 	struct wsc *wsc =3D user_data;
 	const char *pin;
-	enum wsc_device_password_id dpid;
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
+	wsc->ops->connect(message, pin, wsc->user_data);
 	return NULL;
 }
 =

-static struct l_dbus_message *wsc_cancel(struct l_dbus *dbus,
+static struct l_dbus_message *wsc_dbus_cancel(struct l_dbus *dbus,
 						struct l_dbus_message *message,
 						void *user_data)
 {
 	struct wsc *wsc =3D user_data;
-	struct l_dbus_message *reply;
 =

 	l_debug("");
 =

-	if (!wsc->pending)
-		return dbus_error_not_available(message);
-
-	wsc_cancel_scan(wsc);
-
-	if (wsc->station_state_watch) {
-		station_remove_state_watch(wsc->station,
-						wsc->station_state_watch);
-		wsc->station_state_watch =3D 0;
-		wsc->target =3D NULL;
-	}
-
-	if (wsc->wsc_association) {
-		int r;
-
-		r =3D netdev_disconnect(wsc->netdev, wsc_disconnect_cb, wsc);
-		if (r =3D=3D 0) {
-			wsc->pending_cancel =3D l_dbus_message_ref(message);
-			return NULL;
-		}
-
-		l_warn("Unable to initiate disconnect: %s", strerror(-r));
-		wsc->wsc_association =3D false;
-	}
-
-	dbus_pending_reply(&wsc->pending, dbus_error_aborted(wsc->pending));
-
-	reply =3D l_dbus_message_new_method_return(message);
-	l_dbus_message_set_arguments(reply, "");
-
-	return reply;
+	wsc->ops->cancel(message, wsc->user_data);
+	return NULL;
 }
 =

 static void setup_wsc_interface(struct l_dbus_interface *interface)
@@ -1128,7 +1021,7 @@ static void setup_wsc_interface(struct l_dbus_interfa=
ce *interface)
 	l_dbus_interface_method(interface, "StartPin", 0,
 				wsc_start_pin, "", "s", "pin");
 	l_dbus_interface_method(interface, "Cancel", 0,
-				wsc_cancel, "", "");
+				wsc_dbus_cancel, "", "");
 }
 =

 static void wsc_free(void *userdata)
@@ -1155,7 +1048,194 @@ static void wsc_free(void *userdata)
 	l_free(wsc);
 }
 =

-static void wsc_add_interface(struct netdev *netdev)
+struct wsc *wsc_new(const struct wsc_ops *ops, void *user_data)
+{
+	struct l_dbus *dbus =3D dbus_get_bus();
+	struct wsc *wsc;
+	const char *path;
+
+	wsc =3D l_new(struct wsc, 1);
+	wsc->ops =3D ops;
+	wsc->user_data =3D user_data;
+
+	path =3D wsc->ops->get_path(wsc->user_data);
+	if (!path)
+		return wsc;
+
+	if (l_dbus_object_add_interface(dbus, path, IWD_WSC_INTERFACE, wsc))
+		return wsc;
+
+	wsc_free(wsc);
+	l_info("Unable to register interface %s at %s", IWD_WSC_INTERFACE,
+		path);
+	return NULL;
+}
+
+void wsc_destroy(struct wsc *wsc)
+{
+	l_dbus_object_remove_interface(dbus_get_bus(),
+					wsc->ops->get_path(wsc->user_data),
+					IWD_WSC_INTERFACE);
+}
+
+void wsc_start_enrollee(struct wsc *wsc, struct netdev *netdev,
+			struct scan_bss *target, const char *pin)
+{
+	wsc->netdev =3D netdev;
+	wsc->target =3D target;
+	wsc->config_method =3D pin ? WSC_CONFIGURATION_METHOD_KEYPAD :
+		WSC_CONFIGURATION_METHOD_VIRTUAL_PUSH_BUTTON;
+	wsc->pin =3D l_strdup(pin);
+
+	wsc_connect(wsc);
+}
+
+void wsc_cancel(struct wsc *wsc, netdev_disconnect_cb_t cb)
+{
+	int r;
+
+	if (!wsc->wsc_association)
+		return;
+
+	r =3D netdev_disconnect(wsc->netdev, cb, wsc->user_data);
+	if (r =3D=3D 0)
+		return;
+
+	l_warn("Unable to initiate disconnect: %s", strerror(-r));
+	wsc_connect_cleanup(wsc);
+	wsc->ops->enrollee_done_cb(-ECANCELED, NULL, 0, wsc->user_data);
+
+	if (cb)
+		cb(wsc->netdev, false, wsc->user_data);
+}
+
+static const char *wsc_device_get_path(void *user_data)
+{
+	struct wsc *wsc =3D user_data;
+
+	if (!wsc || !wsc->netdev)
+		return NULL;
+
+	return netdev_get_path(wsc->netdev);
+}
+
+static void wsc_device_connect(struct l_dbus_message *message, const char =
*pin,
+				void *user_data)
+{
+	struct wsc *wsc =3D user_data;
+	struct l_dbus *dbus =3D dbus_get_bus();
+	unsigned int walk_time;
+	enum wsc_device_password_id dpid;
+	scan_notify_func_t results_cb;
+
+	if (wsc->pending) {
+		l_dbus_send(dbus, dbus_error_busy(message));
+		return;
+	}
+
+	wsc->station =3D station_find(netdev_get_ifindex(wsc->netdev));
+	if (!wsc->station) {
+		l_dbus_send(dbus, dbus_error_not_available(message));
+		return;
+	}
+
+	if (pin) {
+		if (strlen(pin) =3D=3D 4 || wsc_pin_is_checksum_valid(pin))
+			dpid =3D WSC_DEVICE_PASSWORD_ID_DEFAULT;
+		else
+			dpid =3D WSC_DEVICE_PASSWORD_ID_USER_SPECIFIED;
+
+		walk_time =3D 60;
+		results_cb =3D pin_scan_results;
+	} else {
+		dpid =3D WSC_DEVICE_PASSWORD_ID_PUSH_BUTTON;
+		walk_time =3D WALK_TIME;
+		results_cb =3D push_button_scan_results;
+	}
+
+	if (!wsc_initiate_scan(wsc, dpid, results_cb)) {
+		l_dbus_send(dbus, dbus_error_failed(message));
+		return;
+	}
+
+	wsc->walk_timer =3D l_timeout_create(walk_time, walk_timeout, wsc, NULL);
+	wsc->pending =3D l_dbus_message_ref(message);
+}
+
+static void wsc_device_cancel(struct l_dbus_message *message, void *user_d=
ata)
+{
+	struct wsc *wsc =3D user_data;
+	struct l_dbus *dbus =3D dbus_get_bus();
+
+	if (!wsc->pending) {
+		l_dbus_send(dbus, dbus_error_not_available(message));
+		return;
+	}
+
+	if (wsc->pending_cancel) {
+		l_dbus_send(dbus, dbus_error_busy(message));
+		return;
+	}
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
+	if (wsc->wsc_association) {
+		wsc->pending_cancel =3D l_dbus_message_ref(message);
+		wsc_cancel(wsc, wsc_disconnect_cb);
+		return;
+	}
+
+	dbus_pending_reply(&wsc->pending, dbus_error_aborted(wsc->pending));
+	l_dbus_send(dbus, l_dbus_message_new_method_return(message));
+}
+
+static void wsc_device_enrollee_done(int err, struct wsc_credentials_info =
*creds,
+					unsigned int n_creds, void *user_data)
+{
+	struct wsc *wsc =3D user_data;
+
+	l_debug("err=3D%i", err);
+
+	switch (err) {
+	case 0:
+		break;
+	case -ECANCELED:
+		dbus_pending_reply(&wsc->pending,
+					dbus_error_aborted(wsc->pending));
+		return;
+	case -ENOKEY:
+		dbus_pending_reply(&wsc->pending,
+					wsc_error_no_credentials(wsc->pending));
+		return;
+	case -EBUSY:
+		dbus_pending_reply(&wsc->pending,
+					dbus_error_busy(wsc->pending));
+		return;
+	default:
+		dbus_pending_reply(&wsc->pending,
+					dbus_error_failed(wsc->pending));
+		return;
+	}
+
+	wsc_store_credentials(creds, n_creds);
+	wsc_try_credentials(wsc, creds, n_creds);
+}
+
+static const struct wsc_ops wsc_device_ops =3D {
+	.get_path =3D wsc_device_get_path,
+	.connect =3D wsc_device_connect,
+	.cancel =3D wsc_device_cancel,
+	.enrollee_done_cb =3D wsc_device_enrollee_done,
+};
+
+static void wsc_device_new(struct netdev *netdev)
 {
 	struct l_dbus *dbus =3D dbus_get_bus();
 	struct wsc *wsc;
@@ -1167,15 +1247,17 @@ static void wsc_add_interface(struct netdev *netdev)
 		return;
 	}
 =

-	wsc =3D l_new(struct wsc, 1);
+	wsc =3D wsc_new(&wsc_device_ops, NULL);
+	wsc->user_data =3D wsc;
 	wsc->netdev =3D netdev;
 =

-	if (!l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
-						IWD_WSC_INTERFACE,
-						wsc)) {
-		wsc_free(wsc);
-		l_info("Unable to register %s interface", IWD_WSC_INTERFACE);
-	}
+	if (l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
+					IWD_WSC_INTERFACE, wsc))
+		return;
+
+	wsc_free(wsc);
+	l_info("Unable to register interface %s at %s", IWD_WSC_INTERFACE,
+		netdev_get_path(netdev));
 }
 =

 static void wsc_remove_interface(struct netdev *netdev)
@@ -1194,7 +1276,7 @@ static void wsc_netdev_watch(struct netdev *netdev,
 	case NETDEV_WATCH_EVENT_NEW:
 		if (netdev_get_iftype(netdev) =3D=3D NETDEV_IFTYPE_STATION &&
 				netdev_get_is_up(netdev))
-			wsc_add_interface(netdev);
+			wsc_device_new(netdev);
 		break;
 	case NETDEV_WATCH_EVENT_DOWN:
 	case NETDEV_WATCH_EVENT_DEL:
diff --git a/src/wsc.h b/src/wsc.h
index ada08c89..e8a965f2 100644
--- a/src/wsc.h
+++ b/src/wsc.h
@@ -20,6 +20,11 @@
  *
  */
 =

+struct wsc;
+struct netdev;
+struct scan_bss;
+struct iovec;
+
 struct wsc_credentials_info {
 	char ssid[33];
 	enum security security;
@@ -31,5 +36,17 @@ struct wsc_credentials_info {
 	bool has_passphrase;
 };
 =

-typedef void (*wsc_done_cb_t)(int err, struct wsc_credentials_info *creds,
-				unsigned int n_creds, void *user_data);
+struct wsc_ops {
+	const char *(*get_path)(void *user_data);
+	void (*connect)(struct l_dbus_message *message, const char *pin,
+			void *user_data);
+	void (*cancel)(struct l_dbus_message *message, void *user_data);
+	void (*enrollee_done_cb)(int err, struct wsc_credentials_info *creds,
+					unsigned int n_creds, void *user_data);
+};
+
+struct wsc *wsc_new(const struct wsc_ops *ops, void *user_data);
+void wsc_start_enrollee(struct wsc *wsc, struct netdev *netdev,
+			struct scan_bss *target, const char *pin);
+void wsc_cancel(struct wsc *wsc, netdev_disconnect_cb_t cb);
+void wsc_destroy(struct wsc *wsc);
-- =

2.20.1

--===============2434457378494357917==--

