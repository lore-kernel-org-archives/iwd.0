Content-Type: multipart/mixed; boundary="===============8338080875409522793=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 3/6] dpp: implement configurator role
Date: Mon, 20 Dec 2021 16:07:44 -0800
Message-ID: <20211221000747.56696-3-prestwoj@gmail.com>
In-Reply-To: 20211221000747.56696-1-prestwoj@gmail.com

--===============8338080875409522793==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This implements a configurator in the responder role. Currently
configuring an enrollee is limited to only the connected network.
This is to avoid the need to go offchannel for any reason. But
because of this a roam, channel switch, or disconnect will cause
the configuration to fail as none of the frames are being sent
offchannel.
---
 src/dpp.c | 335 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 333 insertions(+), 2 deletions(-)

v2:
 * Fail if extra DPP attributes are included

diff --git a/src/dpp.c b/src/dpp.c
index b6e59176..48343445 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -45,7 +45,12 @@
 #include "src/mpdu.h"
 #include "ell/useful.h"
 #include "src/common.h"
+#include "src/json.h"
 #include "src/storage.h"
+#include "src/station.h"
+#include "src/scan.h"
+#include "src/network.h"
+#include "src/handshake.h"
 =

 static uint32_t netdev_watch;
 static struct l_genl_family *nl80211;
@@ -107,6 +112,8 @@ struct dpp_sm {
 =

 	/* Timeout of either auth/config protocol */
 	struct l_timeout *timeout;
+
+	struct dpp_configuration *config;
 };
 =

 static void dpp_free_auth_data(struct dpp_sm *dpp)
@@ -149,6 +156,11 @@ static void dpp_reset(struct dpp_sm *dpp)
 		dpp->timeout =3D NULL;
 	}
 =

+	if (dpp->config) {
+		dpp_configuration_free(dpp->config);
+		dpp->config =3D NULL;
+	}
+
 	dpp->state =3D DPP_STATE_NOTHING;
 =

 	dpp_free_auth_data(dpp);
@@ -561,6 +573,260 @@ static void dpp_handle_config_response_frame(const st=
ruct mmpdu_header *frame,
 	send_config_result(dpp, dpp->auth_addr);
 }
 =

+static void dpp_send_config_response(struct dpp_sm *dpp)
+{
+	_auto_(l_free) char *json;
+	struct iovec iov[3];
+	uint8_t hdr[41];
+	uint8_t attrs[512];
+	size_t json_len;
+	uint8_t zero =3D 0;
+	uint8_t *ptr =3D hdr + 24;
+
+	l_put_le16(0x00d0, hdr);
+	memcpy(hdr + 4, dpp->auth_addr, 6);
+	memcpy(hdr + 10, netdev_get_address(dpp->netdev), 6);
+	memcpy(hdr + 16, broadcast, 6);
+
+	*ptr++ =3D 0x04;
+	*ptr++ =3D 0x0b;
+	*ptr++ =3D dpp->diag_token;
+	l_put_le16(0, ptr); /* status */
+	ptr +=3D 2;
+	l_put_le16(0, ptr); /* fragmented (no) */
+	ptr +=3D 2;
+	*ptr++ =3D IE_TYPE_ADVERTISEMENT_PROTOCOL;
+	*ptr++ =3D 0x08;
+	*ptr++ =3D 0x7f;
+	*ptr++ =3D IE_TYPE_VENDOR_SPECIFIC;
+	*ptr++ =3D 5;
+	memcpy(ptr, wifi_alliance_oui, sizeof(wifi_alliance_oui));
+	ptr +=3D sizeof(wifi_alliance_oui);
+	*ptr++ =3D 0x1a;
+	*ptr++ =3D 1;
+
+	json =3D dpp_configuration_to_json(dpp->config);
+	json_len =3D strlen(json);
+
+	iov[0].iov_base =3D hdr;
+	iov[0].iov_len =3D ptr - hdr;
+
+	ptr =3D attrs;
+
+	ptr +=3D 2; /* length */
+
+	ptr +=3D dpp_append_attr(ptr, DPP_ATTR_STATUS, &zero, 1);
+
+	ptr +=3D dpp_append_wrapped_data(attrs + 2, ptr - attrs - 2, NULL, 0, ptr,
+			sizeof(attrs), dpp->ke, dpp->key_len, 2,
+			DPP_ATTR_ENROLLEE_NONCE, dpp->nonce_len, dpp->e_nonce,
+			DPP_ATTR_CONFIGURATION_OBJECT, json_len, json);
+
+	l_put_le16(ptr - attrs - 2, attrs);
+
+	iov[1].iov_base =3D attrs;
+	iov[1].iov_len =3D ptr - attrs;
+
+	dpp_send_frame(dpp->wdev_id, iov, 2, dpp->current_freq);
+}
+
+static void dpp_handle_config_request_frame(const struct mmpdu_header *fra=
me,
+				const void *body, size_t body_len,
+				int rssi, void *user_data)
+{
+	struct dpp_sm *dpp =3D user_data;
+	const uint8_t *ptr =3D body;
+	struct dpp_attr_iter iter;
+	enum dpp_attribute_type type;
+	size_t len;
+	const uint8_t *data;
+	const char *json =3D NULL;
+	size_t json_len =3D 0;
+	struct json_contents *c;
+	const uint8_t *wrapped =3D NULL;
+	const uint8_t *e_nonce =3D NULL;
+	size_t wrapped_len =3D 0;
+	_auto_(l_free) uint8_t *unwrapped =3D NULL;
+	uint8_t hdr_check[] =3D { IE_TYPE_ADVERTISEMENT_PROTOCOL, 0x08, 0x7f,
+				IE_TYPE_VENDOR_SPECIFIC, 5 };
+
+	if (dpp->state !=3D DPP_STATE_AUTHENTICATING) {
+		l_debug("Configuration request in wrong state");
+		return;
+	}
+
+	if (memcmp(dpp->auth_addr, frame->address_2, 6)) {
+		l_debug("Configuration request not from authenticated peer");
+		return;
+	}
+
+	if (body_len < 15) {
+		l_debug("Configuration request data not long enough");
+		return;
+	}
+
+	ptr +=3D 2;
+
+	dpp->diag_token =3D *ptr++;
+
+	if (memcmp(ptr, hdr_check, sizeof(hdr_check)))
+		return;
+
+	ptr +=3D sizeof(hdr_check);
+
+	if (memcmp(ptr, wifi_alliance_oui, sizeof(wifi_alliance_oui)))
+		return;
+
+	ptr +=3D sizeof(wifi_alliance_oui);
+
+	if (*ptr !=3D 0x1a && *(ptr + 1) !=3D 1)
+		return;
+
+	ptr +=3D 2;
+
+	len =3D l_get_le16(ptr);
+	ptr +=3D 2;
+
+	if (len > body_len - 15)
+		return;
+
+	dpp_attr_iter_init(&iter, ptr, len);
+
+	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
+		switch (type) {
+		case DPP_ATTR_WRAPPED_DATA:
+			wrapped =3D data;
+			wrapped_len =3D len;
+			break;
+		default:
+			/* Wrapped data should be only attribute */
+			return;
+		}
+	}
+
+	if (!wrapped) {
+		l_debug("Wrapped data missing");
+		return;
+	}
+
+	unwrapped =3D dpp_unwrap_attr(NULL, 0, NULL, 0, dpp->ke,
+					dpp->key_len, wrapped, wrapped_len,
+					&wrapped_len);
+	if (!unwrapped) {
+		l_debug("Failed to unwrap");
+		return;
+	}
+
+	dpp_attr_iter_init(&iter, unwrapped, wrapped_len);
+
+	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
+		switch (type) {
+		case DPP_ATTR_ENROLLEE_NONCE:
+			if (len !=3D dpp->nonce_len)
+				break;
+
+			e_nonce =3D data;
+			break;
+		case DPP_ATTR_CONFIGURATION_REQUEST:
+			json =3D (const char *)data;
+			json_len =3D len;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (!json || !e_nonce) {
+		l_debug("No configuration object in response");
+		return;
+	}
+
+	/*
+	 * TODO: Full JSON type support (arrays/numbers) is not yet implemented.
+	 * Just verify the JSON is valid for now. There really isn't much need
+	 * to parse this anyhow since IWD only supports configuring stations.
+	 * If this request is for anything else it will fail regardless.
+	 */
+	c =3D json_contents_new(json, json_len);
+	if (!c) {
+		json_contents_free(c);
+		return;
+	}
+
+	json_contents_free(c);
+
+	memcpy(dpp->e_nonce, e_nonce, dpp->nonce_len);
+
+	dpp->state =3D DPP_STATE_CONFIGURING;
+
+	dpp_send_config_response(dpp);
+}
+
+static void dpp_handle_config_result_frame(struct dpp_sm *dpp,
+					const uint8_t *from, const void *body,
+					size_t body_len)
+{
+	struct dpp_attr_iter iter;
+	enum dpp_attribute_type type;
+	size_t len;
+	const uint8_t *data;
+	int status =3D -1;
+	const void *e_nonce =3D NULL;
+	const void *wrapped =3D NULL;
+	size_t wrapped_len;
+	_auto_(l_free) void *unwrapped;
+
+	if (dpp->state !=3D DPP_STATE_CONFIGURING)
+		return;
+
+	dpp_attr_iter_init(&iter, body + 8, body_len - 8);
+
+	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
+		switch (type) {
+		case DPP_ATTR_WRAPPED_DATA:
+			wrapped =3D data;
+			wrapped_len =3D len;
+			break;
+		default:
+			/* Wrapped data should be only attribute */
+			return;
+		}
+	}
+
+	if (!wrapped)
+		return;
+
+	unwrapped =3D dpp_unwrap_attr(body + 2, wrapped - body - 6, wrapped, 0,
+					dpp->ke, dpp->key_len, wrapped,
+					wrapped_len, &wrapped_len);
+	if (!unwrapped) {
+		l_debug("Failed to unwrap DPP configuration result");
+		return;
+	}
+
+	dpp_attr_iter_init(&iter, unwrapped, wrapped_len);
+
+	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
+		switch (type) {
+		case DPP_ATTR_STATUS:
+			status =3D l_get_u8(data);
+			break;
+		case DPP_ATTR_ENROLLEE_NONCE:
+			e_nonce =3D data;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (status !=3D DPP_STATUS_OK || !e_nonce)
+		l_debug("Enrollee signaled a failed configuration");
+	else
+		l_debug("Configuration success");
+
+	dpp_reset(dpp);
+}
+
 /*
  * The Authentication protocol has a consistent use of AD components, and =
this
  * use is defined in 6.3.1.4:
@@ -999,7 +1265,7 @@ auth_request_failed:
 	dpp_free_auth_data(dpp);
 }
 =

-static void dpp_handle_auth_frame(const struct mmpdu_header *frame,
+static void dpp_handle_frame(const struct mmpdu_header *frame,
 				const void *body, size_t body_len,
 				int rssi, void *user_data)
 {
@@ -1023,6 +1289,10 @@ static void dpp_handle_auth_frame(const struct mmpdu=
_header *frame,
 	case DPP_FRAME_AUTHENTICATION_CONFIRM:
 		authenticate_confirm(dpp, frame->address_2, body, body_len);
 		break;
+	case DPP_FRAME_CONFIGURATION_RESULT:
+		dpp_handle_config_result_frame(dpp, frame->address_2,
+						body, body_len);
+		break;
 	default:
 		l_debug("Unhandled DPP frame %u", *ptr);
 		break;
@@ -1078,6 +1348,7 @@ static void dpp_create(struct netdev *netdev)
 	struct dpp_sm *dpp =3D l_new(struct dpp_sm, 1);
 	uint8_t dpp_prefix[] =3D { 0x04, 0x09, 0x50, 0x6f, 0x9a, 0x1a, 0x01 };
 	uint8_t dpp_conf_response_prefix[] =3D { 0x04, 0x0b };
+	uint8_t dpp_conf_request_prefix[] =3D { 0x04, 0x0a };
 =

 	dpp->netdev =3D netdev;
 	dpp->state =3D DPP_STATE_NOTHING;
@@ -1098,12 +1369,16 @@ static void dpp_create(struct netdev *netdev)
 					IWD_DPP_INTERFACE, dpp);
 =

 	frame_watch_add(netdev_get_wdev_id(netdev), 0, 0x00d0, dpp_prefix,
-				sizeof(dpp_prefix), dpp_handle_auth_frame,
+				sizeof(dpp_prefix), dpp_handle_frame,
 				dpp, NULL);
 	frame_watch_add(netdev_get_wdev_id(netdev), 0, 0x00d0,
 				dpp_conf_response_prefix,
 				sizeof(dpp_conf_response_prefix),
 				dpp_handle_config_response_frame, dpp, NULL);
+	frame_watch_add(netdev_get_wdev_id(netdev), 0, 0x00d0,
+				dpp_conf_request_prefix,
+				sizeof(dpp_conf_request_prefix),
+				dpp_handle_config_request_frame, dpp, NULL);
 }
 =

 static void dpp_netdev_watch(struct netdev *netdev,
@@ -1275,6 +1550,60 @@ static struct l_dbus_message *dpp_dbus_start_enrolle=
e(struct l_dbus *dbus,
 	return reply;
 }
 =

+static struct l_dbus_message *dpp_dbus_start_configurator(struct l_dbus *d=
bus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct dpp_sm *dpp =3D user_data;
+	struct l_dbus_message *reply;
+	struct station *station =3D station_find(netdev_get_ifindex(dpp->netdev));
+	struct scan_bss *bss;
+	struct network *network;
+	struct l_settings *settings;
+	struct handshake_state *hs =3D netdev_get_handshake(dpp->netdev);
+
+	/*
+	 * For now limit the configurator to only configuring enrollees to the
+	 * currently connected network.
+	 */
+	if (!station)
+		return dbus_error_not_available(message);
+
+	bss =3D station_get_connected_bss(station);
+	network =3D station_get_connected_network(station);
+	if (!bss || !network)
+		return dbus_error_not_connected(message);
+
+	settings =3D network_get_settings(network);
+	if (!settings)
+		return dbus_error_not_configured(message);
+
+	if (network_get_security(network) !=3D SECURITY_PSK)
+		return dbus_error_not_supported(message);
+
+	if (dpp->state !=3D DPP_STATE_NOTHING)
+		return dbus_error_busy(message);
+
+	dpp->uri =3D dpp_generate_uri(dpp->pub_asn1, dpp->pub_asn1_len, 2,
+					netdev_get_address(dpp->netdev),
+					&bss->frequency, 1, NULL, NULL);
+
+	dpp->state =3D DPP_STATE_PRESENCE;
+	dpp->role =3D DPP_CAPABILITY_CONFIGURATOR;
+	dpp->current_freq =3D bss->frequency;
+	dpp->config =3D dpp_configuration_new(settings,
+						network_get_ssid(network),
+						hs->akm_suite);
+
+	l_debug("DPP Start Configurator: %s", dpp->uri);
+
+	reply =3D l_dbus_message_new_method_return(message);
+
+	l_dbus_message_set_arguments(reply, "s", dpp->uri);
+
+	return reply;
+}
+
 static struct l_dbus_message *dpp_dbus_stop(struct l_dbus *dbus,
 						struct l_dbus_message *message,
 						void *user_data)
@@ -1290,6 +1619,8 @@ static void dpp_setup_interface(struct l_dbus_interfa=
ce *interface)
 {
 	l_dbus_interface_method(interface, "StartEnrollee", 0,
 				dpp_dbus_start_enrollee, "s", "", "uri");
+	l_dbus_interface_method(interface, "StartConfigurator", 0,
+				dpp_dbus_start_configurator, "s", "", "uri");
 	l_dbus_interface_method(interface, "Stop", 0,
 				dpp_dbus_stop, "", "");
 }
-- =

2.31.1

--===============8338080875409522793==--

