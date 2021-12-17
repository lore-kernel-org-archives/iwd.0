Content-Type: multipart/mixed; boundary="===============2999110436959979882=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v6 1/2] dpp: add support for configuration protocol
Date: Fri, 17 Dec 2021 13:29:51 -0800
Message-ID: <20211217212952.228229-1-prestwoj@gmail.com>

--===============2999110436959979882==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a minimal implementation only supporting legacy network
configuration, i.e. only SSID and PSK/passphrase are supported.

Missing features include:
 - Fragmentation/comeback delay support
 - DPP AKM support
 - 8021x/PKEX support
---
 src/dpp.c | 334 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 334 insertions(+)

v6:
 * Added length checks to configuration response

diff --git a/src/dpp.c b/src/dpp.c
index dd17cc47..c703de75 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -44,6 +44,8 @@
 #include "src/crypto.h"
 #include "src/mpdu.h"
 #include "ell/useful.h"
+#include "src/common.h"
+#include "src/storage.h"
 =

 static uint32_t netdev_watch;
 static struct l_genl_family *nl80211;
@@ -53,6 +55,7 @@ enum dpp_state {
 	DPP_STATE_NOTHING,
 	DPP_STATE_PRESENCE,
 	DPP_STATE_AUTHENTICATING,
+	DPP_STATE_CONFIGURING,
 };
 =

 struct dpp_sm {
@@ -84,6 +87,7 @@ struct dpp_sm {
 	uint8_t auth_addr[6];
 	uint8_t r_nonce[32];
 	uint8_t i_nonce[32];
+	uint8_t e_nonce[32];
 =

 	uint64_t ke[L_ECC_MAX_DIGITS];
 	uint64_t k2[L_ECC_MAX_DIGITS];
@@ -92,6 +96,8 @@ struct dpp_sm {
 	struct l_ecc_point *proto_public;
 =

 	struct l_ecc_point *i_proto_public;
+
+	uint8_t diag_token;
 };
 =

 static void dpp_free_auth_data(struct dpp_sm *dpp)
@@ -203,6 +209,327 @@ static size_t dpp_build_header(const uint8_t *src, co=
nst uint8_t *dest,
 	return ptr - buf;
 }
 =

+static size_t dpp_build_config_header(const uint8_t *src, const uint8_t *d=
est,
+					uint8_t diag_token,
+					uint8_t buf[static 37])
+{
+	uint8_t *ptr =3D buf + 24;
+
+	memset(buf, 0, 37);
+
+	l_put_le16(0x00d0, buf);
+	memcpy(buf + 4, dest, 6);
+	memcpy(buf + 10, src, 6);
+	memcpy(buf + 16, broadcast, 6);
+
+	*ptr++ =3D 0x04; /* Public */
+	*ptr++ =3D 0x0a; /* Action */
+	*ptr++ =3D diag_token;
+
+	*ptr++ =3D IE_TYPE_ADVERTISEMENT_PROTOCOL;
+	*ptr++ =3D 8; /* len */
+	*ptr++ =3D 0x00;
+	*ptr++ =3D IE_TYPE_VENDOR_SPECIFIC;
+	*ptr++ =3D 5;
+	memcpy(ptr, wifi_alliance_oui, 3);
+	ptr +=3D 3;
+	*ptr++ =3D 0x1a;
+	*ptr++ =3D 1;
+
+	return ptr - buf;
+}
+
+/*
+ * The configuration protocols use of AD components is somewhat confusing
+ * since the request/response frames are of a different format than the re=
st.
+ * In addition there are situations where the components length is zero ye=
t it
+ * is still passed as such to AES-SIV.
+ *
+ * For the configuration request/response frames:
+ *
+ * "AAD for use with AES-SIV for protected messages in the DPP Configurati=
on
+ * protocol shall consist of all octets in the Query Request and Query Res=
ponse
+ * fields up to the first octet of the Wrapped Data attribute, which is th=
e last
+ * attribute in a DPP Configuration frame. When the number of octets of AA=
D is
+ * zero, the number of components of AAD passed to AES-SIV is zero."
+ *
+ *  - For configuration requests the optional query request field is not
+ *    included, therefore no AAD data is passed. (dpp_configuration_start)
+ *
+ *  - The configuration response does contain a query response field which=
 is
+ *    5 bytes. (dpp_handle_config_response_frame)
+ *
+ * For the configuration result/status, the same rules are used as the
+ * authentication protocol. This is reiterated in section 6.4.1.
+ *
+ *  - For the configuration result there is some confusion as to exactly h=
ow the
+ *    second AAD component should be passed (since the spec specifically
+ *    mentions using two components). There are no attributes prior to the
+ *    wrapped data component meaning the length would be zero.
+ *    Hostapd/wpa_supplicant pass a zero length AAD component to AES-SIV w=
hich
+ *    does effect the resulting encryption/decryption so this is also what=
 IWD
+ *    will do to remain compliant with it.
+ */
+static void dpp_configuration_start(struct dpp_sm *dpp, const uint8_t *add=
r)
+{
+	const char *json =3D "{\"name\":\"IWD\",\"wi-fi_tech\":\"infra\","
+				"\"netRole\":\"sta\"}";
+	struct iovec iov[3];
+	uint8_t hdr[37];
+	uint8_t attrs[512];
+	size_t json_len =3D strlen(json);
+	uint8_t *ptr =3D attrs;
+
+	l_getrandom(&dpp->diag_token, 1);
+
+	iov[0].iov_len =3D dpp_build_config_header(
+					netdev_get_address(dpp->netdev),
+					addr, dpp->diag_token, hdr);
+	iov[0].iov_base =3D hdr;
+
+	l_getrandom(dpp->e_nonce, dpp->nonce_len);
+
+	/* length */
+	ptr +=3D 2;
+
+	/*
+	 * "AAD for use with AES-SIV for protected messages in the DPP
+	 * Configuration protocol shall consist of all octets in the Query
+	 * Request and Query Response fields up to the first octet of the
+	 * Wrapped Data attribute"
+	 *
+	 * In this case there is no query request/response fields, nor any
+	 * attributes besides wrapped data meaning zero AD components.
+	 */
+	ptr +=3D dpp_append_wrapped_data(NULL, 0, NULL, 0, ptr, sizeof(attrs),
+			dpp->ke, dpp->key_len, 2,
+			DPP_ATTR_ENROLLEE_NONCE, dpp->nonce_len, dpp->e_nonce,
+			DPP_ATTR_CONFIGURATION_REQUEST, json_len, json);
+
+	l_put_le16(ptr - attrs - 2, attrs);
+
+	iov[1].iov_base =3D attrs;
+	iov[1].iov_len =3D ptr - attrs;
+
+	dpp->state =3D DPP_STATE_CONFIGURING;
+
+	dpp_send_frame(dpp->wdev_id, iov, 2, dpp->current_freq);
+}
+
+static void send_config_result(struct dpp_sm *dpp, const uint8_t *to)
+{
+	uint8_t hdr[32];
+	struct iovec iov[2];
+	uint8_t attrs[256];
+	uint8_t *ptr =3D attrs;
+	uint8_t zero =3D 0;
+
+	iov[0].iov_len =3D dpp_build_header(netdev_get_address(dpp->netdev), to,
+					DPP_FRAME_CONFIGURATION_RESULT, hdr);
+	iov[0].iov_base =3D hdr;
+
+	ptr +=3D dpp_append_wrapped_data(hdr + 26, 6, attrs, 0, ptr,
+			sizeof(attrs), dpp->ke, dpp->key_len, 2,
+			DPP_ATTR_STATUS, 1, &zero,
+			DPP_ATTR_ENROLLEE_NONCE, dpp->nonce_len, dpp->e_nonce);
+
+	iov[1].iov_base =3D attrs;
+	iov[1].iov_len =3D ptr - attrs;
+
+	dpp_send_frame(dpp->wdev_id, iov, 2, dpp->current_freq);
+}
+
+static void dpp_write_config(struct dpp_configuration *config)
+{
+	_auto_(l_free) char *ssid =3D l_malloc(config->ssid_len + 1);
+	_auto_(l_settings_free) struct l_settings *settings =3D l_settings_new();
+	_auto_(l_free) char *path;
+
+	memcpy(ssid, config->ssid, config->ssid_len);
+	ssid[config->ssid_len] =3D '\0';
+
+	path =3D storage_get_network_file_path(SECURITY_PSK, ssid);
+
+	if (l_settings_load_from_file(settings, path)) {
+		/* Remove any existing Security keys */
+		l_settings_remove_group(settings, "Security");
+	}
+
+	if (config->passphrase)
+		l_settings_set_string(settings, "Security", "Passphrase",
+				config->passphrase);
+	else if (config->psk)
+		l_settings_set_string(settings, "Security", "PreSharedKey",
+				config->psk);
+
+	l_debug("Storing credential for '%s(%s)'", ssid,
+						security_to_str(SECURITY_PSK));
+	storage_network_sync(SECURITY_PSK, ssid, settings);
+}
+
+static void dpp_handle_config_response_frame(const struct mmpdu_header *fr=
ame,
+				const void *body, size_t body_len,
+				int rssi, void *user_data)
+{
+	struct dpp_sm *dpp =3D user_data;
+	const uint8_t *ptr =3D body;
+	uint16_t status;
+	uint16_t fragmented; /* Fragmented/Comeback delay field */
+	uint8_t adv_protocol_element[] =3D { 0x6C, 0x08, 0x7F };
+	uint8_t adv_protocol_id[] =3D { 0xDD, 0x05, 0x50, 0x6F,
+					0x9A, 0x1A, 0x01 };
+	uint16_t query_len;
+	struct dpp_attr_iter iter;
+	enum dpp_attribute_type type;
+	size_t len;
+	const uint8_t *data;
+	const char *json =3D NULL;
+	size_t json_len =3D 0;
+	int dstatus =3D -1;
+	const uint8_t *wrapped =3D NULL;
+	const uint8_t *e_nonce =3D NULL;
+	size_t wrapped_len =3D 0;
+	_auto_(l_free) uint8_t *unwrapped =3D NULL;
+	struct dpp_configuration *config;
+	uint8_t ad0[] =3D { 0x00, 0x10, 0x01, 0x00, 0x05 };
+
+	if (dpp->state !=3D DPP_STATE_CONFIGURING)
+		return;
+
+	/*
+	 * Can a configuration request come from someone other than who you
+	 * authenticated to?
+	 */
+	if (memcmp(dpp->auth_addr, frame->address_2, 6))
+		return;
+
+	if (body_len < 19)
+		return;
+
+	ptr +=3D 2;
+
+	if (*ptr++ !=3D dpp->diag_token)
+		return;
+
+	status =3D l_get_le16(ptr);
+	ptr +=3D 2;
+
+	if (status !=3D 0) {
+		l_debug("Bad configuration status %u", status);
+		return;
+	}
+
+	fragmented =3D l_get_le16(ptr);
+	ptr +=3D 2;
+
+	/*
+	 * TODO: handle 0x0001 (fragmented), as well as comeback delay.
+	 */
+	if (fragmented !=3D 0) {
+		l_debug("Fragmented messages not currently supported");
+		return;
+	}
+
+	if (memcmp(ptr, adv_protocol_element, sizeof(adv_protocol_element))) {
+		l_debug("Invalid Advertisement protocol element");
+		return;
+	}
+
+	ptr +=3D sizeof(adv_protocol_element);
+
+	if (memcmp(ptr, adv_protocol_id, sizeof(adv_protocol_id))) {
+		l_debug("Invalid Advertisement protocol ID");
+		return;
+	}
+
+	ptr +=3D sizeof(adv_protocol_id);
+
+	query_len =3D l_get_le16(ptr);
+	ptr +=3D 2;
+
+	if (query_len > body_len - 19)
+		return;
+
+	dpp_attr_iter_init(&iter, ptr, query_len);
+
+	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
+		switch (type) {
+		case DPP_ATTR_STATUS:
+			dstatus =3D l_get_u8(data);
+			break;
+		case DPP_ATTR_WRAPPED_DATA:
+			wrapped =3D data;
+			wrapped_len =3D len;
+			break;
+		default:
+			/*
+			 * TODO: CSR Attribute
+			 */
+			break;
+		}
+	}
+
+	if (dstatus !=3D DPP_STATUS_OK || !wrapped) {
+		l_debug("Bad status or missing attributes");
+		return;
+	}
+
+	unwrapped =3D dpp_unwrap_attr(ad0, sizeof(ad0), NULL, 0, dpp->ke,
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
+			if (memcmp(data, dpp->e_nonce, dpp->nonce_len))
+				break;
+
+			e_nonce =3D data;
+			break;
+		case DPP_ATTR_CONFIGURATION_OBJECT:
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
+	config =3D dpp_parse_configuration_object(json, json_len);
+	if (!config) {
+		l_error("Configuration object did not parse");
+		return;
+	}
+
+	dpp_write_config(config);
+	/*
+	 * TODO: Depending on the info included in the configuration object a
+	 * limited scan could be issued to get autoconnect to trigger faster.
+	 * In addition this network may already be in past scan results and
+	 * could be joined immediately.
+	 *
+	 * For now just wait for autoconnect.
+	 */
+
+	dpp_configuration_free(config);
+
+	send_config_result(dpp, dpp->auth_addr);
+}
+
 /*
  * The Authentication protocol has a consistent use of AD components, and =
this
  * use is defined in 6.3.1.4:
@@ -407,6 +734,8 @@ static void authenticate_confirm(struct dpp_sm *dpp, co=
nst uint8_t *from,
 =

 	l_debug("Authentication successful");
 =

+	dpp_configuration_start(dpp, from);
+
 	return;
 =

 auth_confirm_failed:
@@ -693,6 +1022,7 @@ static void dpp_create(struct netdev *netdev)
 	struct l_dbus *dbus =3D dbus_get_bus();
 	struct dpp_sm *dpp =3D l_new(struct dpp_sm, 1);
 	uint8_t dpp_prefix[] =3D { 0x04, 0x09, 0x50, 0x6f, 0x9a, 0x1a, 0x01 };
+	uint8_t dpp_conf_response_prefix[] =3D { 0x04, 0x0b };
 =

 	dpp->netdev =3D netdev;
 	dpp->state =3D DPP_STATE_NOTHING;
@@ -715,6 +1045,10 @@ static void dpp_create(struct netdev *netdev)
 	frame_watch_add(netdev_get_wdev_id(netdev), 0, 0x00d0, dpp_prefix,
 				sizeof(dpp_prefix), dpp_handle_auth_frame,
 				dpp, NULL);
+	frame_watch_add(netdev_get_wdev_id(netdev), 0, 0x00d0,
+				dpp_conf_response_prefix,
+				sizeof(dpp_conf_response_prefix),
+				dpp_handle_config_response_frame, dpp, NULL);
 }
 =

 static void dpp_netdev_watch(struct netdev *netdev,
-- =

2.31.1

--===============2999110436959979882==--

