Content-Type: multipart/mixed; boundary="===============5920521676594748544=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/8] wscutil: Add wsc_build_beacon
Date: Fri, 28 Aug 2020 14:46:43 +0200
Message-ID: <20200828124649.78677-2-andrew.zaborowski@intel.com>
In-Reply-To: <20200828124649.78677-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5920521676594748544==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For consistency also update wsc_build_probe_response to use the same
__builtin_popcount based rf_bands check.
---
 src/wscutil.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 src/wscutil.h |  1 +
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/src/wscutil.c b/src/wscutil.c
index f15cd215..f5ff5d75 100644
--- a/src/wscutil.c
+++ b/src/wscutil.c
@@ -2138,6 +2138,53 @@ static void build_credential(struct wsc_attr_builder=
 *builder,
 	l_free(data);
 }
 =

+uint8_t *wsc_build_beacon(const struct wsc_beacon *beacon, size_t *out_len)
+{
+	struct wsc_attr_builder *builder;
+	uint8_t *ret;
+
+	builder =3D wsc_attr_builder_new(512);
+	build_version(builder, 0x10);
+	build_wsc_state(builder, beacon->state);
+
+	if (beacon->ap_setup_locked)
+		build_ap_setup_locked(builder, true);
+
+	if (beacon->selected_registrar) {
+		build_selected_registrar(builder, true);
+		build_device_password_id(builder, beacon->device_password_id);
+		build_selected_registrar_configuration_methods(builder,
+					beacon->selected_reg_config_methods);
+	}
+
+	/* These two "should be provided" if dual-band */
+	if (__builtin_popcount(beacon->rf_bands) > 1) {
+		if (beacon->selected_registrar)
+			build_uuid_e(builder, beacon->uuid_e);
+
+		build_rf_bands(builder, beacon->rf_bands);
+	}
+
+	if (!beacon->version2)
+		goto done;
+
+	START_WFA_VENDOR_EXTENSION();
+
+	if (!util_mem_is_zero(beacon->authorized_macs, 6))
+		wfa_build_authorized_macs(builder, beacon->authorized_macs);
+
+	if (beacon->reg_config_methods) {
+		wsc_attr_builder_put_u8(builder,
+			WSC_WFA_EXTENSION_REGISTRAR_CONFIGRATION_METHODS);
+		wsc_attr_builder_put_u8(builder, 2);
+		wsc_attr_builder_put_u16(builder, beacon->reg_config_methods);
+	}
+
+done:
+	ret =3D wsc_attr_builder_free(builder, false, out_len);
+	return ret;
+}
+
 uint8_t *wsc_build_probe_request(const struct wsc_probe_request *probe_req=
uest,
 							size_t *out_len)
 {
@@ -2210,7 +2257,7 @@ uint8_t *wsc_build_probe_response(
 	build_device_name(builder, probe_response->device_name);
 	build_configuration_methods(builder, probe_response->config_methods);
 =

-	if (probe_response->rf_bands & (probe_response->rf_bands - 1))
+	if (__builtin_popcount(probe_response->rf_bands) > 1)
 		build_rf_bands(builder, probe_response->rf_bands);
 =

 	if (!probe_response->version2)
diff --git a/src/wscutil.h b/src/wscutil.h
index 45d72fbb..5bb26d84 100644
--- a/src/wscutil.h
+++ b/src/wscutil.h
@@ -604,6 +604,7 @@ int wsc_parse_wsc_done(const uint8_t *pdu, uint32_t len=
, struct wsc_done *out);
 =

 uint8_t *wsc_build_credential(const struct wsc_credential *in, size_t *out=
_len);
 =

+uint8_t *wsc_build_beacon(const struct wsc_beacon *beacon, size_t *out_len=
);
 uint8_t *wsc_build_probe_request(const struct wsc_probe_request *probe_req=
uest,
 				size_t *out_len);
 uint8_t *wsc_build_probe_response(
-- =

2.25.1

--===============5920521676594748544==--

