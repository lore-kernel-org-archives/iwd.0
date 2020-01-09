Content-Type: multipart/mixed; boundary="===============7056606432016975024=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/3] wscutil: Add wsc_build_credential
Date: Thu, 09 Jan 2020 20:40:17 +0100
Message-ID: <20200109194019.8228-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7056606432016975024==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/wscutil.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/wscutil.h |  2 ++
 2 files changed, 56 insertions(+)

diff --git a/src/wscutil.c b/src/wscutil.c
index 7f0f6c77..d63e3bc7 100644
--- a/src/wscutil.c
+++ b/src/wscutil.c
@@ -1766,6 +1766,13 @@ static void build_association_state(struct wsc_attr_=
builder *builder,
 	wsc_attr_builder_put_u16(builder, state);
 }
 =

+static void build_authentication_type(struct wsc_attr_builder *builder,
+							uint16_t auth_type)
+{
+	wsc_attr_builder_start_attr(builder, WSC_ATTR_AUTHENTICATION_TYPE);
+	wsc_attr_builder_put_u16(builder, auth_type);
+}
+
 static void build_authentication_type_flags(struct wsc_attr_builder *build=
er,
 					uint16_t auth_type_flags)
 {
@@ -1816,6 +1823,13 @@ static void build_device_password_id(struct wsc_attr=
_builder *builder,
 	wsc_attr_builder_put_u16(builder, id);
 }
 =

+static void build_encryption_type(struct wsc_attr_builder *builder,
+						uint16_t encryption_type)
+{
+	wsc_attr_builder_start_attr(builder, WSC_ATTR_ENCRYPTION_TYPE);
+	wsc_attr_builder_put_u16(builder, encryption_type);
+}
+
 static void build_encryption_type_flags(struct wsc_attr_builder *builder,
 						uint16_t encryption_type_flags)
 {
@@ -1900,6 +1914,20 @@ static void build_model_number(struct wsc_attr_build=
er *builder,
 	wsc_attr_builder_put_string(builder, model_number);
 }
 =

+static void build_network_index(struct wsc_attr_builder *builder,
+							uint8_t network_index)
+{
+	wsc_attr_builder_start_attr(builder, WSC_ATTR_NETWORK_INDEX);
+	wsc_attr_builder_put_u8(builder, network_index);
+}
+
+static void build_network_key(struct wsc_attr_builder *builder,
+					const uint8_t *key, size_t key_len)
+{
+	wsc_attr_builder_start_attr(builder, WSC_ATTR_NETWORK_KEY);
+	wsc_attr_builder_put_bytes(builder, key, key_len);
+}
+
 static void build_os_version(struct wsc_attr_builder *builder,
 							uint32_t os_version)
 {
@@ -1979,6 +2007,13 @@ static void build_r_snonce2(struct wsc_attr_builder =
*builder,
 	wsc_attr_builder_put_bytes(builder, nonce, 16);
 }
 =

+static void build_ssid(struct wsc_attr_builder *builder, const uint8_t *ss=
id,
+							size_t ssid_len)
+{
+	wsc_attr_builder_start_attr(builder, WSC_ATTR_SSID);
+	wsc_attr_builder_put_bytes(builder, ssid, ssid_len);
+}
+
 static void build_serial_number(struct wsc_attr_builder *builder,
 						const char *serial_number)
 {
@@ -2018,6 +2053,25 @@ static void build_wsc_state(struct wsc_attr_builder =
*builder,
 	wsc_attr_builder_put_u8(builder, 1);				\
 	wsc_attr_builder_put_u8(builder, 0x20)
 =

+uint8_t *wsc_build_credential(const struct wsc_credential *in, size_t *out=
_len)
+{
+	struct wsc_attr_builder *builder;
+	uint8_t *ret;
+
+	builder =3D wsc_attr_builder_new(128);
+	build_network_index(builder, 1);
+	build_ssid(builder, in->ssid, in->ssid_len);
+	build_authentication_type(builder, in->auth_type);
+	build_encryption_type(builder, in->encryption_type);
+	build_network_key(builder, in->network_key, in->network_key_len);
+	build_mac_address(builder, in->addr);
+
+	/* TODO: Append EAP attrs & Network Key Shareable inside WFA EXT */
+
+	ret =3D wsc_attr_builder_free(builder, false, out_len);
+	return ret;
+}
+
 uint8_t *wsc_build_probe_request(const struct wsc_probe_request *probe_req=
uest,
 							size_t *out_len)
 {
diff --git a/src/wscutil.h b/src/wscutil.h
index 1a133f33..424725d1 100644
--- a/src/wscutil.h
+++ b/src/wscutil.h
@@ -602,6 +602,8 @@ int wsc_parse_wsc_nack(const uint8_t *pdu, uint32_t len=
, struct wsc_nack *out);
 =

 int wsc_parse_wsc_done(const uint8_t *pdu, uint32_t len, struct wsc_done *=
out);
 =

+uint8_t *wsc_build_credential(const struct wsc_credential *in, size_t *out=
_len);
+
 uint8_t *wsc_build_probe_request(const struct wsc_probe_request *probe_req=
uest,
 				size_t *out_len);
 uint8_t *wsc_build_association_request(
-- =

2.20.1

--===============7056606432016975024==--

