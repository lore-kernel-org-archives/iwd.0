Content-Type: multipart/mixed; boundary="===============0055349497365562647=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 01/11] wscutil: Add wsc_build_beacon
Date: Thu, 27 Aug 2020 20:14:43 +0200
Message-ID: <20200827181453.61823-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0055349497365562647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/wscutil.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/wscutil.h |  1 +
 2 files changed, 60 insertions(+)

diff --git a/src/wscutil.c b/src/wscutil.c
index d78a0354..f24e67ed 100644
--- a/src/wscutil.c
+++ b/src/wscutil.c
@@ -2124,6 +2124,65 @@ static void build_credential(struct wsc_attr_builder=
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
+	if (beacon->rf_bands & (beacon->rf_bands - 1)) {
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
+	if (!util_mem_is_zero(beacon->authorized_macs, 30)) {
+		int count;
+
+		for (count =3D 1; count < 5; count++)
+			if (util_mem_is_zero(beacon->authorized_macs + count * 6,
+						30 - count * 6))
+				break;
+
+		wsc_attr_builder_put_u8(builder,
+					WSC_WFA_EXTENSION_AUTHORIZED_MACS);
+		wsc_attr_builder_put_u8(builder, count * 6);
+		wsc_attr_builder_put_bytes(builder, beacon->authorized_macs,
+						count * 6);
+	}
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

--===============0055349497365562647==--

