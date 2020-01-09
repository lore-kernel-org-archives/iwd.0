Content-Type: multipart/mixed; boundary="===============8170599779562360397=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/3] wscutil: Add wsc_build_m8_encrypted_settings
Date: Thu, 09 Jan 2020 20:40:18 +0100
Message-ID: <20200109194019.8228-2-andrew.zaborowski@intel.com>
In-Reply-To: <20200109194019.8228-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8170599779562360397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Note it internally calls wsc_build_credential instead of the user
having to do this.  I can convert wsc_parse_m8_encrypted_settings to do
the same thing.
---
 src/wscutil.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 src/wscutil.h |  4 ++++
 2 files changed, 46 insertions(+)

diff --git a/src/wscutil.c b/src/wscutil.c
index d63e3bc7..99a74d1e 100644
--- a/src/wscutil.c
+++ b/src/wscutil.c
@@ -1928,6 +1928,13 @@ static void build_network_key(struct wsc_attr_builde=
r *builder,
 	wsc_attr_builder_put_bytes(builder, key, key_len);
 }
 =

+static void build_new_password(struct wsc_attr_builder *builder,
+				const uint8_t *password, size_t password_len)
+{
+	wsc_attr_builder_start_attr(builder, WSC_ATTR_NEW_PASSWORD);
+	wsc_attr_builder_put_bytes(builder, password, password_len);
+}
+
 static void build_os_version(struct wsc_attr_builder *builder,
 							uint32_t os_version)
 {
@@ -2072,6 +2079,17 @@ uint8_t *wsc_build_credential(const struct wsc_crede=
ntial *in, size_t *out_len)
 	return ret;
 }
 =

+static void build_credential(struct wsc_attr_builder *builder,
+					const struct wsc_credential *cred)
+{
+	size_t data_len;
+	uint8_t *data =3D wsc_build_credential(cred, &data_len);
+
+	wsc_attr_builder_start_attr(builder, WSC_ATTR_CREDENTIAL);
+	wsc_attr_builder_put_bytes(builder, data, data_len);
+	l_free(data);
+}
+
 uint8_t *wsc_build_probe_request(const struct wsc_probe_request *probe_req=
uest,
 							size_t *out_len)
 {
@@ -2447,6 +2465,30 @@ done:
 	return ret;
 }
 =

+uint8_t *wsc_build_m8_encrypted_settings(
+				const struct wsc_m8_encrypted_settings *in,
+				const struct wsc_credential *creds,
+				unsigned int creds_cnt, size_t *out_len)
+{
+	struct wsc_attr_builder *builder;
+	unsigned int i;
+
+	builder =3D wsc_attr_builder_new(256);
+
+	for (i =3D 0; i < creds_cnt; i++)
+		build_credential(builder, &creds[i]);
+
+	if (in->new_password_len) {
+		build_new_password(builder, in->new_password,
+					in->new_password_len);
+		build_device_password_id(builder, in->device_password_id);
+	}
+
+	build_key_wrap_authenticator(builder, in->authenticator);
+
+	return wsc_attr_builder_free(builder, false, out_len);
+}
+
 uint8_t *wsc_build_wsc_ack(const struct wsc_ack *ack, size_t *out_len)
 {
 	struct wsc_attr_builder *builder;
diff --git a/src/wscutil.h b/src/wscutil.h
index 424725d1..0d06a60f 100644
--- a/src/wscutil.h
+++ b/src/wscutil.h
@@ -638,6 +638,10 @@ uint8_t *wsc_build_m7_encrypted_settings(
 				size_t *out_len);
 uint8_t *wsc_build_m8(const struct wsc_m8 *m8, const uint8_t *encrypted,
 			size_t encrypted_len, size_t *out_len);
+uint8_t *wsc_build_m8_encrypted_settings(
+				const struct wsc_m8_encrypted_settings *in,
+				const struct wsc_credential *creds,
+				unsigned int creds_cnt, size_t *out_len);
 =

 uint8_t *wsc_build_wsc_ack(const struct wsc_ack *ack, size_t *out_len);
 uint8_t *wsc_build_wsc_nack(const struct wsc_nack *nack, size_t *out_len);
-- =

2.20.1

--===============8170599779562360397==--

