Content-Type: multipart/mixed; boundary="===============5935715266332874832=="
MIME-Version: 1.0
From: Andrew Zaborowski <balrogg@gmail.com>
Subject: [PATCH 08/11] wsc: Add wsc_new_p2p_enrollee, refactor
Date: Mon, 21 Oct 2019 15:55:07 +0200
Message-ID: <20191021135510.12657-8-balrogg@gmail.com>
In-Reply-To: <20191021135510.12657-1-balrogg@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5935715266332874832==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Andrew Zaborowski <andrew.zaborowski@intel.com>

Until now WSC could only be triggered by calling a DBus method and
success and error paths would end with a reply to the DBus method.
Instead use a wsc done callback pointer so that the WSC connection
logic can be triggered through DBus or a C API.  The DBus method reply
is sent from inside the callback when WSC is triggered through DBus.

Export a function that adds a new entry point to start the WSC
connection for the P2P provisioning phase.  The function doesn't have
anything specific to P2P at this point.
---
 Makefile.am |   2 +-
 src/wsc.c   | 181 +++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 131 insertions(+), 52 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index ecd1c228..03be9577 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -199,7 +199,7 @@ src_iwd_SOURCES =3D src/main.c linux/nl80211.h src/iwd.=
h src/missing.h \
 					src/agent.h src/agent.c \
 					src/storage.h src/storage.c \
 					src/network.h src/network.c \
-					src/wsc.c \
+					src/wsc.h src/wsc.c \
 					src/backtrace.h src/backtrace.c \
 					src/knownnetworks.h \
 					src/knownnetworks.c \
diff --git a/src/wsc.c b/src/wsc.c
index d971797a..61683e7b 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -44,6 +44,7 @@
 #include "src/storage.h"
 #include "src/iwd.h"
 #include "src/network.h"
+#include "src/wsc.h"
 =

 #define WALK_TIME 120
 =

@@ -60,18 +61,14 @@ struct wsc {
 	uint32_t scan_id;
 	struct scan_bss *target;
 	uint32_t station_state_watch;
-	struct {
-		char ssid[33];
-		enum security security;
-		union {
-			uint8_t psk[32];
-			char passphrase[64];
-		};
-		uint8_t addr[6];
-		bool has_passphrase;
-	} creds[3];
+	struct wsc_credentials creds[3];
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
@@ -160,15 +157,12 @@ static void wsc_try_credentials(struct wsc *wsc)
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
@@ -224,6 +218,22 @@ static void wsc_disconnect_cb(struct netdev *netdev, b=
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
@@ -231,33 +241,34 @@ static void wsc_connect_cb(struct netdev *netdev, enu=
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
+		struct wsc_credentials creds[L_ARRAY_SIZE(wsc->creds)];
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
@@ -451,30 +462,24 @@ static void wsc_connect(struct wsc *wsc)
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
@@ -511,8 +516,38 @@ static void wsc_connect(struct wsc *wsc)
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
+static void wsc_dbus_done_cb(int err, struct wsc_credentials *creds,
+				unsigned int n_creds, void *user_data)
+{
+	struct wsc *wsc =3D user_data;
+
+	l_debug("err=3D%i", err);
+
+	if (err =3D=3D -ECANCELED) {
+		dbus_pending_reply(&wsc->pending,
+					dbus_error_aborted(wsc->pending));
+		return;
+	} else if (err =3D=3D -ENOKEY) {
+		dbus_pending_reply(&wsc->pending,
+					wsc_error_no_credentials(wsc->pending));
+		return;
+	} else if (err =3D=3D -EBUSY) {
+		dbus_pending_reply(&wsc->pending,
+					dbus_error_busy(wsc->pending));
+		return;
+	} else if (err) {
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
@@ -541,6 +576,22 @@ static void wsc_check_can_connect(struct wsc *wsc, str=
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
@@ -564,7 +615,7 @@ static void wsc_check_can_connect(struct wsc *wsc, stru=
ct scan_bss *target)
 		break;
 	}
 error:
-	wsc->target =3D NULL;
+	wsc_connect_cleanup(wsc);
 	dbus_pending_reply(&wsc->pending, dbus_error_failed(wsc->pending));
 }
 =

@@ -1074,12 +1125,12 @@ static void wsc_free(void *userdata)
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
@@ -1090,9 +1141,6 @@ static void wsc_free(void *userdata)
 		dbus_pending_reply(&wsc->pending_cancel,
 				dbus_error_aborted(wsc->pending_cancel));
 =

-	if (wsc->eap_settings)
-		l_settings_free(wsc->eap_settings);
-
 	l_free(wsc);
 }
 =

@@ -1139,6 +1187,37 @@ static void wsc_netdev_watch(struct netdev *netdev,
 	}
 }
 =

+struct wsc *wsc_new_p2p_enrollee(struct netdev *netdev, struct scan_bss *t=
arget,
+					char *pin, wsc_done_cb_t done_cb,
+					void *user_data)
+{
+	struct wsc *wsc;
+
+	wsc =3D l_new(struct wsc, 1);
+	wsc->netdev =3D netdev;
+	wsc->target =3D target;
+	wsc->config_method =3D pin ? WSC_CONFIGURATION_METHOD_KEYPAD :
+		WSC_CONFIGURATION_METHOD_PUSH_BUTTON;
+	wsc->done_cb =3D done_cb;
+	wsc->done_data =3D user_data;
+	wsc->pin =3D l_strdup(pin);
+
+	wsc_connect(wsc);
+
+	/*
+	 * Wsc objects created this way are not handled in wsc_remove_interface,
+	 * the caller is expected to watch interfaces going away and there's no
+	 * need to handle the event in both places.
+	 */
+
+	return wsc;
+}
+
+void wsc_destroy(struct wsc *wsc)
+{
+	wsc_free(wsc);
+}
+
 static int wsc_init(void)
 {
 	l_debug("");
-- =

2.20.1

--===============5935715266332874832==--

