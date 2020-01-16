Content-Type: multipart/mixed; boundary="===============1232383026878689543=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/3] wsc: Split out enrollee state machine to own object
Date: Thu, 16 Jan 2020 05:29:29 +0100
Message-ID: <20200116042931.8849-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1232383026878689543==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Create struct wsc_enrollee which is allocated with wsc_enrollee_new,
taking a done callback as a parameter.  The callback is always
called so there's no need for a separate destroy callback.  The object
only lives until the done callback happens so wsc_enrollee_cancel/destroy
can only be used before this.

Looks like the rest of the file is simplified thanks to this.
---
 src/wsc.c | 504 +++++++++++++++++++++++++++++-------------------------
 src/wsc.h |   9 +
 2 files changed, 276 insertions(+), 237 deletions(-)

diff --git a/src/wsc.c b/src/wsc.c
index d50f240f..e381b84f 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -51,9 +51,20 @@
 =

 static uint32_t netdev_watch =3D 0;
 =

+struct wsc_enrollee {
+	struct netdev *netdev;
+	struct wsc_credentials_info creds[3];
+	uint32_t n_creds;
+	struct l_settings *eap_settings;
+	wsc_done_cb_t done_cb;
+	void *done_data;
+	bool disconnecting : 1;
+};
+
 struct wsc {
 	struct netdev *netdev;
 	struct station *station;
+	struct wsc_enrollee *enrollee;
 	struct l_dbus_message *pending;
 	struct l_dbus_message *pending_cancel;
 	uint8_t *wsc_ies;
@@ -62,16 +73,6 @@ struct wsc {
 	uint32_t scan_id;
 	struct scan_bss *target;
 	uint32_t station_state_watch;
-	struct wsc_credentials_info creds[3];
-	uint32_t n_creds;
-	struct l_settings *eap_settings;
-	char *pin;
-
-	wsc_done_cb_t done_cb;
-	void *done_data;
-	uint16_t config_method;
-
-	bool wsc_association : 1;
 };
 =

 static struct l_dbus_message *wsc_error_session_overlap(
@@ -113,171 +114,50 @@ static struct l_dbus_message *wsc_error_time_expired=
(struct l_dbus_message *msg)
 					"No APs in PIN mode found in "
 					"the alloted time");
 }
-static void wsc_try_credentials(struct wsc *wsc,
-					struct wsc_credentials_info *creds,
-					unsigned int n_creds)
-{
-	unsigned int i;
-	struct network *network;
-	struct scan_bss *bss;
-
-	for (i =3D 0; i < n_creds; i++) {
-		network =3D station_network_find(wsc->station, creds[i].ssid,
-						creds[i].security);
-		if (!network)
-			continue;
-
-		bss =3D network_bss_find_by_addr(network, creds[i].addr);
-
-		if (!bss)
-			bss =3D network_bss_select(network, true);
-
-		if (!bss)
-			continue;
-
-		if (creds[i].security =3D=3D SECURITY_PSK) {
-			bool ret;
-
-			/*
-			 * Prefer setting passphrase, this will work for both
-			 * WPA2 and WPA3 since the PSK can always be generated
-			 * if needed
-			 */
-			if (creds[i].has_passphrase)
-				ret =3D network_set_passphrase(network,
-							creds[i].passphrase);
-			else
-				ret =3D network_set_psk(network, creds[i].psk);
-
-			if (!ret)
-				continue;
-		}
-
-		station_connect_network(wsc->station, network, bss,
-								wsc->pending);
-		l_dbus_message_unref(wsc->pending);
-		wsc->pending =3D NULL;
-
-		return;
-	}
-
-	dbus_pending_reply(&wsc->pending,
-					wsc_error_not_reachable(wsc->pending));
-	station_set_autoconnect(wsc->station, true);
-}
 =

-static void wsc_store_credentials(struct wsc_credentials_info *creds,
-					unsigned int n_creds)
+static void wsc_enrollee_free(struct wsc_enrollee *wsce)
 {
-	unsigned int i;
-
-	for (i =3D 0; i < n_creds; i++) {
-		enum security security =3D creds[i].security;
-		const char *ssid =3D creds[i].ssid;
-		struct l_settings *settings =3D l_settings_new();
-
-		l_debug("Storing credential for '%s(%s)'", ssid,
-						security_to_str(security));
-
-		if (security =3D=3D SECURITY_PSK) {
-			char *hex =3D l_util_hexstring(creds[i].psk,
-						sizeof(creds[i].psk));
-
-			l_settings_set_value(settings, "Security",
-							"PreSharedKey", hex);
-			explicit_bzero(hex, strlen(hex));
-			l_free(hex);
-		}
-
-		storage_network_sync(security, ssid, settings);
-		l_settings_free(settings);
-
-		/*
-		 * TODO: Mark this network as known.  We might be getting
-		 * multiple credentials from WSC, so there is a possibility
-		 * that the network is not known and / or not in scan results.
-		 * In both cases, the network should be considered for
-		 * auto-connect.  Note, since we sync the settings, the next
-		 * reboot will put the network on the known list.
-		 */
-	}
+	l_settings_free(wsce->eap_settings);
+	explicit_bzero(wsce->creds, sizeof(wsce->creds));
+	l_free(wsce);
 }
 =

-static void wsc_disconnect_cb(struct netdev *netdev, bool success,
-							void *user_data)
-{
-	struct wsc *wsc =3D user_data;
-	struct l_dbus_message *reply;
-
-	l_debug("%p, success: %d", wsc, success);
-
-	wsc->wsc_association =3D false;
-
-	reply =3D l_dbus_message_new_method_return(wsc->pending_cancel);
-	l_dbus_message_set_arguments(reply, "");
-	dbus_pending_reply(&wsc->pending_cancel, reply);
-
-	station_set_autoconnect(wsc->station, true);
-}
-
-static void wsc_connect_cleanup(struct wsc *wsc)
-{
-	wsc->wsc_association =3D false;
-
-	l_settings_free(wsc->eap_settings);
-	wsc->eap_settings =3D NULL;
-
-	if (wsc->pin) {
-		explicit_bzero(wsc->pin, strlen(wsc->pin));
-		l_free(wsc->pin);
-		wsc->pin =3D NULL;
-	}
-
-	wsc->target =3D NULL;
-}
-
-static void wsc_connect_cb(struct netdev *netdev, enum netdev_result resul=
t,
+static void wsc_enrollee_connect_cb(struct netdev *netdev,
+					enum netdev_result result,
 					void *event_data, void *user_data)
 {
-	struct wsc *wsc =3D user_data;
+	struct wsc_enrollee *wsce =3D user_data;
 =

-	l_debug("%d, result: %d", netdev_get_ifindex(wsc->netdev), result);
+	l_debug("%d, result: %d", netdev_get_ifindex(wsce->netdev), result);
 =

-	wsc_connect_cleanup(wsc);
+	if (wsce->disconnecting)
+		return;	/* Free the state in the disconnect callback */
 =

-	if (result =3D=3D NETDEV_RESULT_HANDSHAKE_FAILED && wsc->n_creds > 0) {
-		struct wsc_credentials_info creds[L_ARRAY_SIZE(wsc->creds)];
-		uint32_t n_creds =3D wsc->n_creds;
+	if (!wsce->done_cb)
+		goto done;
 =

-		/*
-		 * Once we call done_cb, the state is assumed to be wiped,
-		 * so use a temporary array for creds here
-		 */
-		memcpy(creds, wsc->creds, sizeof(creds));
-		explicit_bzero(wsc->creds, sizeof(creds));
-		wsc->n_creds =3D 0;
-		wsc->done_cb(0, creds, n_creds, wsc->done_data);
-		explicit_bzero(creds, sizeof(creds));
-		return;
+	if (result =3D=3D NETDEV_RESULT_HANDSHAKE_FAILED && wsce->n_creds > 0) {
+		wsce->done_cb(0, wsce->creds, wsce->n_creds, wsce->done_data);
+		goto done;
 	}
 =

 	switch (result) {
 	case NETDEV_RESULT_ABORTED:
-		wsc->done_cb(-ECANCELED, NULL, 0, wsc->done_data);
-		return;
+		wsce->done_cb(-ECANCELED, NULL, 0, wsce->done_data);
+		break;
 	case NETDEV_RESULT_HANDSHAKE_FAILED:
-		wsc->done_cb(-ENOKEY, NULL, 0, wsc->done_data);
+		wsce->done_cb(-ENOKEY, NULL, 0, wsce->done_data);
 		break;
 	default:
-		wsc->done_cb(-EIO, NULL, 0, wsc->done_data);
+		wsce->done_cb(-EIO, NULL, 0, wsce->done_data);
 		break;
 	}
 =

-	if (wsc->station)
-		station_set_autoconnect(wsc->station, true);
+done:
+	wsc_enrollee_free(wsce);
 }
 =

-static void wsc_credential_obtained(struct wsc *wsc,
+static void wsc_enrollee_credential_obtained(struct wsc_enrollee *wsce,
 					const struct wsc_credential *cred)
 {
 	uint16_t auth_mask;
@@ -294,7 +174,7 @@ static void wsc_credential_obtained(struct wsc *wsc,
 		l_debug("Key (%u): %.*s", cred->network_key_len,
 				cred->network_key_len, cred->network_key);
 =

-	if (wsc->n_creds =3D=3D L_ARRAY_SIZE(wsc->creds)) {
+	if (wsce->n_creds =3D=3D L_ARRAY_SIZE(wsce->creds)) {
 		l_warn("Maximum number of credentials obtained, ignoring...");
 		return;
 	}
@@ -304,8 +184,8 @@ static void wsc_credential_obtained(struct wsc *wsc,
 		return;
 	}
 =

-	memcpy(wsc->creds[wsc->n_creds].ssid, cred->ssid, cred->ssid_len);
-	wsc->creds[wsc->n_creds].ssid[cred->ssid_len] =3D '\0';
+	memcpy(wsce->creds[wsce->n_creds].ssid, cred->ssid, cred->ssid_len);
+	wsce->creds[wsce->n_creds].ssid[cred->ssid_len] =3D '\0';
 =

 	/* We only support open/personal wpa/personal wpa2 */
 	auth_mask =3D WSC_AUTHENTICATION_TYPE_OPEN |
@@ -324,11 +204,11 @@ static void wsc_credential_obtained(struct wsc *wsc,
 			return;
 		}
 =

-		wsc->creds[wsc->n_creds].security =3D SECURITY_NONE;
+		wsce->creds[wsce->n_creds].security =3D SECURITY_NONE;
 	} else
-		wsc->creds[wsc->n_creds].security =3D SECURITY_PSK;
+		wsce->creds[wsce->n_creds].security =3D SECURITY_PSK;
 =

-	switch (wsc->creds[wsc->n_creds].security) {
+	switch (wsce->creds[wsce->n_creds].security) {
 	case SECURITY_NONE:
 		if (cred->network_key_len !=3D 0) {
 			l_warn("ignoring invalid open key length");
@@ -347,14 +227,14 @@ static void wsc_credential_obtained(struct wsc *wsc,
 				return;
 			}
 =

-			memcpy(wsc->creds[wsc->n_creds].psk, decoded, 32);
+			memcpy(wsce->creds[wsce->n_creds].psk, decoded, 32);
 			explicit_bzero(decoded, 32);
 			l_free(decoded);
 		} else {
-			strncpy(wsc->creds[wsc->n_creds].passphrase,
+			strncpy(wsce->creds[wsce->n_creds].passphrase,
 					(const char *) cred->network_key,
 					cred->network_key_len);
-			wsc->creds[wsc->n_creds].has_passphrase =3D true;
+			wsce->creds[wsce->n_creds].has_passphrase =3D true;
 		}
 =

 		break;
@@ -362,25 +242,27 @@ static void wsc_credential_obtained(struct wsc *wsc,
 		return;
 	}
 =

-	for (i =3D 0; i < wsc->n_creds; i++) {
-		if (strcmp(wsc->creds[i].ssid, wsc->creds[wsc->n_creds].ssid))
+	for (i =3D 0; i < wsce->n_creds; i++) {
+		if (strcmp(wsce->creds[i].ssid,
+				wsce->creds[wsce->n_creds].ssid))
 			continue;
 =

 		l_warn("Found duplicate credentials for SSID: %s",
-				wsc->creds[i].ssid);
-		explicit_bzero(&wsc->creds[wsc->n_creds],
-				sizeof(wsc->creds[wsc->n_creds]));
+				wsce->creds[i].ssid);
+		explicit_bzero(&wsce->creds[wsce->n_creds],
+				sizeof(wsce->creds[wsce->n_creds]));
 		return;
 	}
 =

-	memcpy(wsc->creds[wsc->n_creds].addr, cred->addr, 6);
-	wsc->n_creds +=3D 1;
+	memcpy(wsce->creds[wsce->n_creds].addr, cred->addr, 6);
+	wsce->n_creds +=3D 1;
 }
 =

-static void wsc_netdev_event(struct netdev *netdev, enum netdev_event even=
t,
+static void wsc_enrollee_netdev_event(struct netdev *netdev,
+					enum netdev_event event,
 					void *event_data, void *user_data)
 {
-	struct wsc *wsc =3D user_data;
+	struct wsc_enrollee *wsce =3D user_data;
 =

 	switch (event) {
 	case NETDEV_EVENT_AUTHENTICATING:
@@ -391,8 +273,9 @@ static void wsc_netdev_event(struct netdev *netdev, enu=
m netdev_event event,
 		break;
 	case NETDEV_EVENT_DISCONNECT_BY_AP:
 		l_debug("Disconnect by AP");
-		wsc_connect_cb(wsc->netdev, NETDEV_RESULT_HANDSHAKE_FAILED,
-				event_data, wsc);
+		wsc_enrollee_connect_cb(wsce->netdev,
+					NETDEV_RESULT_HANDSHAKE_FAILED,
+					event_data, wsce);
 		break;
 	case NETDEV_EVENT_RSSI_THRESHOLD_LOW:
 	case NETDEV_EVENT_RSSI_THRESHOLD_HIGH:
@@ -403,11 +286,11 @@ static void wsc_netdev_event(struct netdev *netdev, e=
num netdev_event event,
 	};
 }
 =

-static void wsc_handshake_event(struct handshake_state *hs,
-				enum handshake_event event, void *user_data,
-				...)
+static void wsc_enrollee_handshake_event(struct handshake_state *hs,
+						enum handshake_event event,
+						void *user_data, ...)
 {
-	struct wsc *wsc =3D user_data;
+	struct wsc_enrollee *wsce =3D user_data;
 	va_list args;
 =

 	va_start(args, user_data);
@@ -422,7 +305,7 @@ static void wsc_handshake_event(struct handshake_state =
*hs,
 =

 		switch (eap_event) {
 		case EAP_WSC_EVENT_CREDENTIAL_OBTAINED:
-			wsc_credential_obtained(wsc,
+			wsc_enrollee_credential_obtained(wsce,
 				va_arg(args, const struct wsc_credential *));
 			break;
 		default:
@@ -454,20 +337,18 @@ static inline enum wsc_rf_band freq_to_rf_band(uint32=
_t freq)
 	return WSC_RF_BAND_2_4_GHZ;
 }
 =

-static void wsc_connect(struct wsc *wsc)
+static int wsc_enrollee_connect(struct wsc_enrollee *wsce, struct scan_bss=
 *bss,
+					const char *pin)
 {
 	struct handshake_state *hs;
 	struct l_settings *settings =3D l_settings_new();
-	struct scan_bss *bss =3D wsc->target;
 	int r;
 	struct wsc_association_request request;
 	uint8_t *pdu;
 	size_t pdu_len;
 	struct iovec ie_iov;
 =

-	wsc->target =3D NULL;
-
-	hs =3D netdev_handshake_state_new(wsc->netdev);
+	hs =3D netdev_handshake_state_new(wsce->netdev);
 =

 	l_settings_set_string(settings, "Security", "EAP-Identity",
 					"WFA-SimpleConfig-Enrollee-1-0");
@@ -482,25 +363,23 @@ static void wsc_connect(struct wsc *wsc)
 	l_settings_set_string(settings, "WSC", "PrimaryDeviceType",
 					"0-00000000-0");
 	l_settings_set_string(settings, "WSC", "EnrolleeMAC",
-		util_address_to_string(netdev_get_address(wsc->netdev)));
+		util_address_to_string(netdev_get_address(wsce->netdev)));
 =

-	if (wsc->config_method =3D=3D WSC_CONFIGURATION_METHOD_KEYPAD) {
+	if (pin) {
 		enum wsc_device_password_id dpid;
 =

-		if (strlen(wsc->pin) =3D=3D 4 ||
-				wsc_pin_is_checksum_valid(wsc->pin))
+		if (strlen(pin) =3D=3D 4 || wsc_pin_is_checksum_valid(pin))
 			dpid =3D WSC_DEVICE_PASSWORD_ID_DEFAULT;
 		else
 			dpid =3D WSC_DEVICE_PASSWORD_ID_USER_SPECIFIED;
 =

 		l_settings_set_uint(settings, "WSC", "DevicePasswordId", dpid);
-		l_settings_set_string(settings, "WSC", "DevicePassword",
-					wsc->pin);
+		l_settings_set_string(settings, "WSC", "DevicePassword", pin);
 	}
 =

-	handshake_state_set_event_func(hs, wsc_handshake_event, wsc);
+	handshake_state_set_event_func(hs, wsc_enrollee_handshake_event, wsce);
 	handshake_state_set_8021x_config(hs, settings);
-	wsc->eap_settings =3D settings;
+	wsce->eap_settings =3D settings;
 =

 	request.version2 =3D true;
 	request.request_type =3D WSC_REQUEST_TYPE_ENROLLEE_OPEN_8021X;
@@ -520,19 +399,164 @@ static void wsc_connect(struct wsc *wsc)
 		goto error;
 	}
 =

-	r =3D netdev_connect(wsc->netdev, bss, hs, &ie_iov, 1, wsc_netdev_event,
-				wsc_connect_cb, wsc);
+	r =3D netdev_connect(wsce->netdev, bss, hs, &ie_iov, 1,
+				wsc_enrollee_netdev_event,
+				wsc_enrollee_connect_cb, wsce);
 	l_free(ie_iov.iov_base);
 =

-	if (r < 0)
-		goto error;
+	if (r =3D=3D 0)
+		return 0;
 =

-	wsc->wsc_association =3D true;
-	return;
 error:
 	handshake_state_free(hs);
-	wsc_connect_cleanup(wsc);
-	wsc->done_cb(r, NULL, 0, wsc->done_data);
+	return r;
+}
+
+struct wsc_enrollee *wsc_enrollee_new(struct netdev *netdev,
+					struct scan_bss *target,
+					const char *pin,
+					wsc_done_cb_t done_cb, void *user_data)
+{
+	struct wsc_enrollee *wsce;
+
+	wsce =3D l_new(struct wsc_enrollee, 1);
+	wsce->netdev =3D netdev;
+	wsce->done_cb =3D done_cb;
+	wsce->done_data =3D user_data;
+
+	if (wsc_enrollee_connect(wsce, target, pin) =3D=3D 0)
+		return wsce;
+
+	wsc_enrollee_free(wsce);
+	return NULL;
+}
+
+static void wsc_enrollee_disconnect_cb(struct netdev *netdev, bool result,
+					void *user_data)
+{
+	struct wsc_enrollee *wsce =3D user_data;
+
+	wsce->done_cb(-ECANCELED, NULL, 0, wsce->done_data);
+	wsc_enrollee_free(wsce);
+}
+
+void wsc_enrollee_cancel(struct wsc_enrollee *wsce, bool defer_cb)
+{
+	if (defer_cb) {
+		wsce->disconnecting =3D true;
+		netdev_disconnect(wsce->netdev, wsc_enrollee_disconnect_cb,
+					wsce);
+	} else {
+		wsce->done_cb(-ECANCELED, NULL, 0, wsce->done_data);
+		wsce->done_cb =3D NULL;
+		/*
+		 * Results in a call to
+		 * wsc_enrollee_connect_cb -> wsc_enrollee_free
+		 */
+		netdev_disconnect(wsce->netdev, NULL, NULL);
+	}
+}
+
+/* To be called instead of wsc_enrollee_cancel if we know the netdev is go=
ne */
+void wsc_enrollee_destroy(struct wsc_enrollee *wsce)
+{
+	/*
+	 * Note: wsc_enrollee_cancel(wsce, true) may have been called before
+	 * but since the netdev is going away wsc_enrollee_disconnect_cb
+	 * is not happening anymore.
+	 */
+	wsce->done_cb(-ECANCELED, NULL, 0, wsce->done_data);
+	wsc_enrollee_free(wsce);
+}
+
+static void wsc_try_credentials(struct wsc *wsc,
+				struct wsc_credentials_info *creds,
+				unsigned int n_creds)
+{
+	unsigned int i;
+	struct network *network;
+	struct scan_bss *bss;
+
+	for (i =3D 0; i < n_creds; i++) {
+		network =3D station_network_find(wsc->station, creds[i].ssid,
+						creds[i].security);
+		if (!network)
+			continue;
+
+		bss =3D network_bss_find_by_addr(network, creds[i].addr);
+
+		if (!bss)
+			bss =3D network_bss_select(network, true);
+
+		if (!bss)
+			continue;
+
+		if (creds[i].security =3D=3D SECURITY_PSK) {
+			bool ret;
+
+			/*
+			 * Prefer setting passphrase, this will work for both
+			 * WPA2 and WPA3 since the PSK can always be generated
+			 * if needed
+			 */
+			if (creds[i].has_passphrase)
+				ret =3D network_set_passphrase(network,
+							creds[i].passphrase);
+			else
+				ret =3D network_set_psk(network, creds[i].psk);
+
+			if (!ret)
+				continue;
+		}
+
+		station_connect_network(wsc->station, network, bss,
+								wsc->pending);
+		l_dbus_message_unref(wsc->pending);
+		wsc->pending =3D NULL;
+
+		return;
+	}
+
+	dbus_pending_reply(&wsc->pending,
+					wsc_error_not_reachable(wsc->pending));
+	station_set_autoconnect(wsc->station, true);
+}
+
+static void wsc_store_credentials(struct wsc_credentials_info *creds,
+					unsigned int n_creds)
+{
+	unsigned int i;
+
+	for (i =3D 0; i < n_creds; i++) {
+		enum security security =3D creds[i].security;
+		const char *ssid =3D creds[i].ssid;
+		struct l_settings *settings =3D l_settings_new();
+
+		l_debug("Storing credential for '%s(%s)'", ssid,
+						security_to_str(security));
+
+		if (security =3D=3D SECURITY_PSK) {
+			char *hex =3D l_util_hexstring(creds[i].psk,
+						sizeof(creds[i].psk));
+
+			l_settings_set_value(settings, "Security",
+							"PreSharedKey", hex);
+			explicit_bzero(hex, strlen(hex));
+			l_free(hex);
+		}
+
+		storage_network_sync(security, ssid, settings);
+		l_settings_free(settings);
+
+		/*
+		 * TODO: Mark this network as known.  We might be getting
+		 * multiple credentials from WSC, so there is a possibility
+		 * that the network is not known and / or not in scan results.
+		 * In both cases, the network should be considered for
+		 * auto-connect.  Note, since we sync the settings, the next
+		 * reboot will put the network on the known list.
+		 */
+	}
 }
 =

 /* Done callback for when WSC is triggered by DBus methods */
@@ -541,14 +565,28 @@ static void wsc_dbus_done_cb(int err, struct wsc_cred=
entials_info *creds,
 {
 	struct wsc *wsc =3D user_data;
 =

+	wsc->enrollee =3D NULL;
+	wsc->target =3D NULL;
+
 	l_debug("err=3D%i", err);
 =

+	if (err && wsc->station)
+		station_set_autoconnect(wsc->station, true);
+
 	switch (err) {
 	case 0:
 		break;
 	case -ECANCELED:
-		dbus_pending_reply(&wsc->pending,
+		/* Send reply if we haven't already sent one e.g. in Cancel() */
+		if (wsc->pending)
+			dbus_pending_reply(&wsc->pending,
 					dbus_error_aborted(wsc->pending));
+
+		if (wsc->pending_cancel)
+			dbus_pending_reply(&wsc->pending_cancel,
+					l_dbus_message_new_method_return(
+							wsc->pending_cancel));
+
 		return;
 	case -ENOKEY:
 		dbus_pending_reply(&wsc->pending,
@@ -568,6 +606,21 @@ static void wsc_dbus_done_cb(int err, struct wsc_crede=
ntials_info *creds,
 	wsc_try_credentials(wsc, creds, n_creds);
 }
 =

+static void wsc_connect(struct wsc *wsc)
+{
+	const char *pin =3D NULL;
+
+	if (!strcmp(l_dbus_message_get_member(wsc->pending), "StartPin"))
+		l_dbus_message_get_arguments(wsc->pending, "s", &pin);
+
+	wsc->enrollee =3D wsc_enrollee_new(wsc->netdev, wsc->target, pin,
+						wsc_dbus_done_cb, wsc);
+	if (wsc->enrollee)
+		return;
+
+	wsc_dbus_done_cb(-EIO, NULL, 0, wsc);
+}
+
 static void station_state_watch(enum station_state state, void *userdata)
 {
 	struct wsc *wsc =3D userdata;
@@ -594,22 +647,6 @@ static void wsc_check_can_connect(struct wsc *wsc, str=
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
 		wsc_connect(wsc);
@@ -633,7 +670,7 @@ static void wsc_check_can_connect(struct wsc *wsc, stru=
ct scan_bss *target)
 		break;
 	}
 error:
-	wsc_connect_cleanup(wsc);
+	wsc->target =3D NULL;
 	dbus_pending_reply(&wsc->pending, dbus_error_failed(wsc->pending));
 }
 =

@@ -1089,13 +1126,15 @@ static struct l_dbus_message *wsc_cancel(struct l_d=
bus *dbus,
 						void *user_data)
 {
 	struct wsc *wsc =3D user_data;
-	struct l_dbus_message *reply;
 =

 	l_debug("");
 =

 	if (!wsc->pending)
 		return dbus_error_not_available(message);
 =

+	if (wsc->pending_cancel)
+		return dbus_error_busy(message);
+
 	wsc_cancel_scan(wsc);
 =

 	if (wsc->station_state_watch) {
@@ -1105,25 +1144,14 @@ static struct l_dbus_message *wsc_cancel(struct l_d=
bus *dbus,
 		wsc->target =3D NULL;
 	}
 =

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
 	dbus_pending_reply(&wsc->pending, dbus_error_aborted(wsc->pending));
 =

-	reply =3D l_dbus_message_new_method_return(message);
-	l_dbus_message_set_arguments(reply, "");
-
-	return reply;
+	if (wsc->enrollee) {
+		wsc_enrollee_cancel(wsc->enrollee, true);
+		wsc->pending_cancel =3D l_dbus_message_ref(message);
+		return NULL;
+	} else
+		return l_dbus_message_new_method_return(message);
 }
 =

 static void setup_wsc_interface(struct l_dbus_interface *interface)
@@ -1143,7 +1171,6 @@ static void wsc_free(void *userdata)
 	struct wsc *wsc =3D userdata;
 =

 	wsc_cancel_scan(wsc);
-	wsc_connect_cleanup(wsc);
 =

 	if (wsc->station_state_watch) {
 		station_remove_state_watch(wsc->station,
@@ -1157,7 +1184,10 @@ static void wsc_free(void *userdata)
 =

 	if (wsc->pending_cancel)
 		dbus_pending_reply(&wsc->pending_cancel,
-				dbus_error_aborted(wsc->pending_cancel));
+				dbus_error_not_available(wsc->pending_cancel));
+
+	if (wsc->enrollee)
+		wsc_enrollee_destroy(wsc->enrollee);
 =

 	l_free(wsc);
 }
diff --git a/src/wsc.h b/src/wsc.h
index ada08c89..14084aea 100644
--- a/src/wsc.h
+++ b/src/wsc.h
@@ -31,5 +31,14 @@ struct wsc_credentials_info {
 	bool has_passphrase;
 };
 =

+struct wsc_enrollee;
+
 typedef void (*wsc_done_cb_t)(int err, struct wsc_credentials_info *creds,
 				unsigned int n_creds, void *user_data);
+
+struct wsc_enrollee *wsc_enrollee_new(struct netdev *netdev,
+					struct scan_bss *target,
+					const char *pin,
+					wsc_done_cb_t done_cb, void *user_data);
+void wsc_enrollee_cancel(struct wsc_enrollee *wsce, bool defer_cb);
+void wsc_enrollee_destroy(struct wsc_enrollee *wsce);
-- =

2.20.1

--===============1232383026878689543==--

