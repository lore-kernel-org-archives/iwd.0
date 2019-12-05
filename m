Content-Type: multipart/mixed; boundary="===============6324446942031058745=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/7] wsc: Refactor to separate station-specific code
Date: Thu, 05 Dec 2019 04:22:41 +0100
Message-ID: <20191205032244.5957-4-andrew.zaborowski@intel.com>
In-Reply-To: <20191205032244.5957-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6324446942031058745==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Split the interface-specific logic out of the core WSC logic.  The core
WSC code is the part that we can re-use between P2P and station and
doesn't include the scanning for the target BSS or the attempt to make
a station mode connection.
---
 src/wsc.c | 141 ++++++++++++++++++++++++++++++++++++++----------------
 src/wsc.h |   3 ++
 2 files changed, 103 insertions(+), 41 deletions(-)

diff --git a/src/wsc.c b/src/wsc.c
index eb8489f3..222cc222 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -65,6 +65,11 @@ struct wsc {
 	struct wsc_credentials_info creds[3];
 	uint32_t n_creds;
 	struct l_settings *eap_settings;
+	char *pin;
+
+	wsc_done_cb_t done_cb;
+	void *done_data;
+	uint16_t config_method;
 =

 	bool wsc_association : 1;
 };
@@ -153,15 +158,12 @@ static void wsc_try_credentials(struct wsc *wsc)
 		l_dbus_message_unref(wsc->pending);
 		wsc->pending =3D NULL;
 =

-		goto done;
+		return;
 	}
 =

 	dbus_pending_reply(&wsc->pending,
 					wsc_error_not_reachable(wsc->pending));
 	station_set_autoconnect(wsc->station, true);
-done:
-	memset(wsc->creds, 0, sizeof(wsc->creds));
-	wsc->n_creds =3D 0;
 }
 =

 static void wsc_store_credentials(struct wsc *wsc)
@@ -217,6 +219,22 @@ static void wsc_disconnect_cb(struct netdev *netdev, b=
ool success,
 	station_set_autoconnect(wsc->station, true);
 }
 =

+static void wsc_connect_cleanup(struct wsc *wsc)
+{
+	wsc->wsc_association =3D false;
+
+	l_settings_free(wsc->eap_settings);
+	wsc->eap_settings =3D NULL;
+
+	if (wsc->pin) {
+		explicit_bzero(wsc->pin, strlen(wsc->pin));
+		l_free(wsc->pin);
+		wsc->pin =3D NULL;
+	}
+
+	wsc->target =3D NULL;
+}
+
 static void wsc_connect_cb(struct netdev *netdev, enum netdev_result resul=
t,
 					void *event_data, void *user_data)
 {
@@ -224,33 +242,34 @@ static void wsc_connect_cb(struct netdev *netdev, enu=
m netdev_result result,
 =

 	l_debug("%d, result: %d", netdev_get_ifindex(wsc->netdev), result);
 =

-	wsc->wsc_association =3D false;
-
-	l_settings_free(wsc->eap_settings);
-	wsc->eap_settings =3D NULL;
+	wsc_connect_cleanup(wsc);
 =

 	if (result =3D=3D NETDEV_RESULT_HANDSHAKE_FAILED && wsc->n_creds > 0) {
-		wsc_store_credentials(wsc);
-		wsc_try_credentials(wsc);
+		struct wsc_credentials_info creds[L_ARRAY_SIZE(wsc->creds)];
+		uint32_t n_creds =3D wsc->n_creds;
+
+		memcpy(creds, wsc->creds, sizeof(creds));
+		explicit_bzero(wsc->creds, sizeof(creds));
+		wsc->n_creds =3D 0;
+		wsc->done_cb(0, creds, n_creds, wsc->done_data);
+		explicit_bzero(creds, sizeof(creds));
 		return;
 	}
 =

 	switch (result) {
 	case NETDEV_RESULT_ABORTED:
-		dbus_pending_reply(&wsc->pending,
-					dbus_error_aborted(wsc->pending));
+		wsc->done_cb(-ECANCELED, NULL, 0, wsc->done_data);
 		return;
 	case NETDEV_RESULT_HANDSHAKE_FAILED:
-		dbus_pending_reply(&wsc->pending,
-					wsc_error_no_credentials(wsc->pending));
+		wsc->done_cb(-ENOKEY, NULL, 0, wsc->done_data);
 		break;
 	default:
-		dbus_pending_reply(&wsc->pending,
-					dbus_error_failed(wsc->pending));
+		wsc->done_cb(-EIO, NULL, 0, wsc->done_data);
 		break;
 	}
 =

-	station_set_autoconnect(wsc->station, true);
+	if (wsc->station)
+		station_set_autoconnect(wsc->station, true);
 }
 =

 static void wsc_credential_obtained(struct wsc *wsc,
@@ -452,30 +471,24 @@ static void wsc_connect(struct wsc *wsc)
 	l_settings_set_uint(settings, "WSC", "RFBand",
 					freq_to_rf_band(bss->frequency));
 	l_settings_set_uint(settings, "WSC", "ConfigurationMethods",
-				WSC_CONFIGURATION_METHOD_VIRTUAL_DISPLAY_PIN |
-				WSC_CONFIGURATION_METHOD_VIRTUAL_PUSH_BUTTON |
-				WSC_CONFIGURATION_METHOD_KEYPAD);
+					wsc->config_method);
 	l_settings_set_string(settings, "WSC", "PrimaryDeviceType",
 					"0-00000000-0");
 	l_settings_set_string(settings, "WSC", "EnrolleeMAC",
 		util_address_to_string(netdev_get_address(wsc->netdev)));
 =

-	if (!strcmp(l_dbus_message_get_member(wsc->pending), "StartPin")) {
-		const char *pin;
-
-		if (l_dbus_message_get_arguments(wsc->pending, "s", &pin)) {
-			enum wsc_device_password_id dpid;
+	if (wsc->config_method =3D=3D WSC_CONFIGURATION_METHOD_KEYPAD) {
+		enum wsc_device_password_id dpid;
 =

-			if (strlen(pin) =3D=3D 4 || wsc_pin_is_checksum_valid(pin))
-				dpid =3D WSC_DEVICE_PASSWORD_ID_DEFAULT;
-			else
-				dpid =3D WSC_DEVICE_PASSWORD_ID_USER_SPECIFIED;
+		if (strlen(wsc->pin) =3D=3D 4 ||
+				wsc_pin_is_checksum_valid(wsc->pin))
+			dpid =3D WSC_DEVICE_PASSWORD_ID_DEFAULT;
+		else
+			dpid =3D WSC_DEVICE_PASSWORD_ID_USER_SPECIFIED;
 =

-			l_settings_set_uint(settings, "WSC",
-						"DevicePasswordId", dpid);
-			l_settings_set_string(settings, "WSC",
-						"DevicePassword", pin);
-		}
+		l_settings_set_uint(settings, "WSC", "DevicePasswordId", dpid);
+		l_settings_set_string(settings, "WSC", "DevicePassword",
+					wsc->pin);
 	}
 =

 	handshake_state_set_event_func(hs, wsc_handshake_event, wsc);
@@ -511,8 +524,41 @@ static void wsc_connect(struct wsc *wsc)
 	return;
 error:
 	handshake_state_free(hs);
-	dbus_pending_reply(&wsc->pending,
-				dbus_error_failed(wsc->pending));
+	wsc_connect_cleanup(wsc);
+	wsc->done_cb(r, NULL, 0, wsc->done_data);
+}
+
+/* Done callback for when WSC is triggered by DBus methods */
+static void wsc_dbus_done_cb(int err, struct wsc_credentials_info *creds,
+				unsigned int n_creds, void *user_data)
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
+	wsc_store_credentials(wsc);
+	wsc_try_credentials(wsc);
 }
 =

 static void station_state_watch(enum station_state state, void *userdata)
@@ -541,6 +587,22 @@ static void wsc_check_can_connect(struct wsc *wsc, str=
uct scan_bss *target)
 	wsc->target =3D target;
 	station_set_autoconnect(wsc->station, false);
 =

+	if (!strcmp(l_dbus_message_get_member(wsc->pending), "StartPin")) {
+		char *pin;
+
+		wsc->config_method =3D WSC_CONFIGURATION_METHOD_KEYPAD;
+
+		if (!l_dbus_message_get_arguments(wsc->pending, "s", &pin))
+			goto error;
+
+		wsc->pin =3D l_strdup(pin);
+	} else
+		wsc->config_method =3D
+			WSC_CONFIGURATION_METHOD_VIRTUAL_PUSH_BUTTON;
+
+	wsc->done_cb =3D wsc_dbus_done_cb;
+	wsc->done_data =3D wsc;
+
 	switch (station_get_state(wsc->station)) {
 	case STATION_STATE_DISCONNECTED:
 		wsc_connect(wsc);
@@ -564,7 +626,7 @@ static void wsc_check_can_connect(struct wsc *wsc, stru=
ct scan_bss *target)
 		break;
 	}
 error:
-	wsc->target =3D NULL;
+	wsc_connect_cleanup(wsc);
 	dbus_pending_reply(&wsc->pending, dbus_error_failed(wsc->pending));
 }
 =

@@ -1074,12 +1136,12 @@ static void wsc_free(void *userdata)
 	struct wsc *wsc =3D userdata;
 =

 	wsc_cancel_scan(wsc);
+	wsc_connect_cleanup(wsc);
 =

 	if (wsc->station_state_watch) {
 		station_remove_state_watch(wsc->station,
 						wsc->station_state_watch);
 		wsc->station_state_watch =3D 0;
-		wsc->target =3D NULL;
 	}
 =

 	if (wsc->pending)
@@ -1090,9 +1152,6 @@ static void wsc_free(void *userdata)
 		dbus_pending_reply(&wsc->pending_cancel,
 				dbus_error_aborted(wsc->pending_cancel));
 =

-	if (wsc->eap_settings)
-		l_settings_free(wsc->eap_settings);
-
 	l_free(wsc);
 }
 =

diff --git a/src/wsc.h b/src/wsc.h
index b0e6f24a..ada08c89 100644
--- a/src/wsc.h
+++ b/src/wsc.h
@@ -30,3 +30,6 @@ struct wsc_credentials_info {
 	uint8_t addr[6];
 	bool has_passphrase;
 };
+
+typedef void (*wsc_done_cb_t)(int err, struct wsc_credentials_info *creds,
+				unsigned int n_creds, void *user_data);
-- =

2.20.1

--===============6324446942031058745==--

