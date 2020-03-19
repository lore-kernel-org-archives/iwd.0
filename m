Content-Type: multipart/mixed; boundary="===============6078523510612352608=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/9] wscutil: Implement wsc_build_probe_response
Date: Thu, 19 Mar 2020 22:12:12 +0100
Message-ID: <20200319211218.32083-3-andrew.zaborowski@intel.com>
In-Reply-To: <20200319211218.32083-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6078523510612352608==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/wscutil.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/wscutil.h |  3 ++
 2 files changed, 96 insertions(+)

diff --git a/src/wscutil.c b/src/wscutil.c
index 99a74d1e..4f22bd83 100644
--- a/src/wscutil.c
+++ b/src/wscutil.c
@@ -31,6 +31,7 @@
 =

 #include <ell/ell.h>
 =

+#include "src/util.h"
 #include "src/wscutil.h"
 =

 const unsigned char wsc_wfa_oui[3] =3D { 0x00, 0x37, 0x2a };
@@ -1759,6 +1760,12 @@ static uint8_t *wsc_attr_builder_free(struct wsc_att=
r_builder *builder,
 	return ret;
 }
 =

+static void build_ap_setup_locked(struct wsc_attr_builder *builder, bool l=
ocked)
+{
+	wsc_attr_builder_start_attr(builder, WSC_ATTR_AP_SETUP_LOCKED);
+	wsc_attr_builder_put_u8(builder, locked ? 0x01 : 0x00);
+}
+
 static void build_association_state(struct wsc_attr_builder *builder,
 					enum wsc_association_state state)
 {
@@ -2014,6 +2021,22 @@ static void build_r_snonce2(struct wsc_attr_builder =
*builder,
 	wsc_attr_builder_put_bytes(builder, nonce, 16);
 }
 =

+static void build_selected_registrar(struct wsc_attr_builder *builder,
+							bool selected)
+{
+	wsc_attr_builder_start_attr(builder, WSC_ATTR_SELECTED_REGISTRAR);
+	wsc_attr_builder_put_u8(builder, selected ? 0x01 : 0x00);
+}
+
+static void build_selected_registrar_configuration_methods(
+					struct wsc_attr_builder *builder,
+					uint16_t config_methods)
+{
+	wsc_attr_builder_start_attr(builder,
+			WSC_ATTR_SELECTED_REGISTRAR_CONFIGURATION_METHODS);
+	wsc_attr_builder_put_u16(builder, config_methods);
+}
+
 static void build_ssid(struct wsc_attr_builder *builder, const uint8_t *ss=
id,
 							size_t ssid_len)
 {
@@ -2129,6 +2152,76 @@ done:
 	return ret;
 }
 =

+uint8_t *wsc_build_probe_response(
+		const struct wsc_probe_response *probe_response,
+		size_t *out_len)
+{
+	struct wsc_attr_builder *builder;
+	uint8_t *ret;
+
+	builder =3D wsc_attr_builder_new(512);
+	build_version(builder, 0x10);
+	build_wsc_state(builder, probe_response->state);
+
+	if (probe_response->ap_setup_locked)
+		build_ap_setup_locked(builder, true);
+
+	if (probe_response->selected_registrar) {
+		build_selected_registrar(builder, true);
+		build_device_password_id(builder,
+				probe_response->device_password_id);
+		build_selected_registrar_configuration_methods(builder,
+				probe_response->selected_reg_config_methods);
+	}
+
+	build_response_type(builder, probe_response->response_type);
+	build_uuid_e(builder, probe_response->uuid_e);
+	build_manufacturer(builder, probe_response->manufacturer);
+	build_model_name(builder, probe_response->model_name);
+	build_model_number(builder, probe_response->model_number);
+	build_serial_number(builder, probe_response->serial_number);
+	build_primary_device_type(builder,
+					&probe_response->primary_device_type);
+	build_device_name(builder, probe_response->device_name);
+	build_configuration_methods(builder, probe_response->config_methods);
+
+	if (probe_response->rf_bands & (probe_response->rf_bands - 1))
+		build_rf_bands(builder, probe_response->rf_bands);
+
+	if (!probe_response->version2)
+		goto done;
+
+	START_WFA_VENDOR_EXTENSION();
+
+	if (!util_mem_is_zero(probe_response->authorized_macs, 30)) {
+		int count;
+
+		for (count =3D 1; count < 5; count++)
+			if (util_mem_is_zero(probe_response->authorized_macs +
+						count * 6, 30 - count * 6))
+				break;
+
+		wsc_attr_builder_put_u8(builder,
+					WSC_WFA_EXTENSION_AUTHORIZED_MACS);
+		wsc_attr_builder_put_u8(builder, count * 6);
+		wsc_attr_builder_put_bytes(builder,
+					probe_response->authorized_macs,
+					count * 6);
+	}
+
+	if (probe_response->reg_config_methods) {
+		wsc_attr_builder_put_u8(builder,
+			WSC_WFA_EXTENSION_REGISTRAR_CONFIGRATION_METHODS);
+		wsc_attr_builder_put_u8(builder, 2);
+		wsc_attr_builder_put_u16(builder,
+					probe_response->reg_config_methods);
+	}
+
+done:
+	ret =3D wsc_attr_builder_free(builder, false, out_len);
+	return ret;
+}
+
 uint8_t *wsc_build_association_request(
 		const struct wsc_association_request *association_request,
 		size_t *out_len)
diff --git a/src/wscutil.h b/src/wscutil.h
index 0d06a60f..fc28a01e 100644
--- a/src/wscutil.h
+++ b/src/wscutil.h
@@ -606,6 +606,9 @@ uint8_t *wsc_build_credential(const struct wsc_credenti=
al *in, size_t *out_len);
 =

 uint8_t *wsc_build_probe_request(const struct wsc_probe_request *probe_req=
uest,
 				size_t *out_len);
+uint8_t *wsc_build_probe_response(
+		const struct wsc_probe_response *probe_response,
+		size_t *out_len);
 uint8_t *wsc_build_association_request(
 		const struct wsc_association_request *association_request,
 		size_t *out_len);
-- =

2.20.1

--===============6078523510612352608==--

