Content-Type: multipart/mixed; boundary="===============3165716975328667295=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/8] wscutil: Use a utility for building authorized_macs
Date: Fri, 28 Aug 2020 14:46:42 +0200
Message-ID: <20200828124649.78677-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3165716975328667295==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add the wfa_build_authorized_macs function (wfa_ prefix following the
wfa_extract_ naming) and use it in wsc_build_probe_response.  The logic
is changed slightly to treat the first 6-zeros address in the array as
the end of the array.
---
 src/wscutil.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/src/wscutil.c b/src/wscutil.c
index d78a0354..f15cd215 100644
--- a/src/wscutil.c
+++ b/src/wscutil.c
@@ -2094,6 +2094,20 @@ static void build_wsc_state(struct wsc_attr_builder =
*builder,
 	wsc_attr_builder_put_u8(builder, 1);				\
 	wsc_attr_builder_put_u8(builder, 0x20)
 =

+static void wfa_build_authorized_macs(struct wsc_attr_builder *builder,
+				const uint8_t authorized_macs[static 30])
+{
+	int count;
+
+	for (count =3D 1; count < 5; count++)
+		if (util_mem_is_zero(authorized_macs + count * 6, 6))
+			break;
+
+	wsc_attr_builder_put_u8(builder, WSC_WFA_EXTENSION_AUTHORIZED_MACS);
+	wsc_attr_builder_put_u8(builder, count * 6);
+	wsc_attr_builder_put_bytes(builder, authorized_macs, count * 6);
+}
+
 uint8_t *wsc_build_credential(const struct wsc_credential *in, size_t *out=
_len)
 {
 	struct wsc_attr_builder *builder;
@@ -2204,21 +2218,9 @@ uint8_t *wsc_build_probe_response(
 =

 	START_WFA_VENDOR_EXTENSION();
 =

-	if (!util_mem_is_zero(probe_response->authorized_macs, 30)) {
-		int count;
-
-		for (count =3D 1; count < 5; count++)
-			if (util_mem_is_zero(probe_response->authorized_macs +
-						count * 6, 30 - count * 6))
-				break;
-
-		wsc_attr_builder_put_u8(builder,
-					WSC_WFA_EXTENSION_AUTHORIZED_MACS);
-		wsc_attr_builder_put_u8(builder, count * 6);
-		wsc_attr_builder_put_bytes(builder,
-					probe_response->authorized_macs,
-					count * 6);
-	}
+	if (!util_mem_is_zero(probe_response->authorized_macs, 6))
+		wfa_build_authorized_macs(builder,
+					probe_response->authorized_macs);
 =

 	if (probe_response->reg_config_methods) {
 		wsc_attr_builder_put_u8(builder,
-- =

2.25.1

--===============3165716975328667295==--

