Content-Type: multipart/mixed; boundary="===============8218667366496884250=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/3] unit: add JSON unit test
Date: Tue, 07 Dec 2021 12:55:47 -0800
Message-ID: <20211207205547.1520508-3-prestwoj@gmail.com>
In-Reply-To: 20211207205547.1520508-1-prestwoj@gmail.com

--===============8218667366496884250==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am      |   5 +-
 unit/test-json.c | 243 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 247 insertions(+), 1 deletion(-)
 create mode 100644 unit/test-json.c

diff --git a/Makefile.am b/Makefile.am
index 1ae7e3c0..871499a3 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -396,7 +396,7 @@ unit_tests =3D unit/test-cmac-aes \
 		unit/test-ie unit/test-util unit/test-ssid-security \
 		unit/test-arc4 unit/test-wsc unit/test-eap-mschapv2 \
 		unit/test-eap-sim unit/test-sae unit/test-p2p unit/test-band \
-		unit/test-dpp
+		unit/test-dpp unit/test-json
 =

 if CLIENT
 unit_tests +=3D unit/test-client
@@ -556,6 +556,9 @@ unit_test_dpp_SOURCES =3D unit/test-dpp.c src/dpp-util.=
h src/dpp-util.c \
 =

 unit_test_dpp_LDADD =3D $(ell_ldadd)
 =

+unit_test_json_SOURCES =3D unit/test-json.c src/json.h src/json.c shared/j=
smn.h
+unit_test_json_LDADD =3D $(ell_ldadd)
+
 TESTS =3D $(unit_tests)
 =

 EXTRA_DIST =3D src/genbuiltin src/iwd.service.in src/net.connman.iwd.servi=
ce \
diff --git a/unit/test-json.c b/unit/test-json.c
new file mode 100644
index 00000000..2b5552fd
--- /dev/null
+++ b/unit/test-json.c
@@ -0,0 +1,243 @@
+/*
+ *
+ *  Embedded Linux library
+ *
+ *  Copyright (C) 2021  Intel Corporation. All rights reserved.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <assert.h>
+
+#include <ell/ell.h>
+
+#include "src/json.h"
+#include "ell/useful.h"
+
+static bool foreach_unicode_test(struct json_iter *iter,
+				const uint8_t *key, size_t key_len,
+				enum json_type type, const void *value,
+				size_t value_len, void *user_data)
+{
+	uint8_t expected[] =3D { 0xF0, 0x9F, 0x98, 0x80 };
+
+	assert(type =3D=3D JSON_STRING);
+	assert(key_len =3D=3D 4);
+	assert(!memcmp(key, "test", 4));
+	assert(value_len =3D=3D 4);
+	assert(!memcmp(value, expected, 4));
+
+	return true;
+}
+
+/*
+ * Object:
+ * { "test": "<smile emoji>" }
+ */
+static void test_json_unicode(const void *data)
+{
+	struct json_iter *iter;
+
+	uint8_t s[] =3D { '{', '"', 't', 'e', 's', 't', '"', ':',
+				'"', 0xf0, 0x9f, 0x98, 0x80, '"', '}', 0 };
+
+	iter =3D json_iter_new((const char *)s, sizeof(s));
+
+	assert(json_iter_foreach(iter, foreach_unicode_test, NULL));
+
+	json_iter_free(iter);
+}
+
+static bool foreach_escaped_unicode_test(struct json_iter *iter,
+				const uint8_t *key, size_t key_len,
+				enum json_type type, const void *value,
+				size_t value_len, void *user_data)
+{
+	char expected[] =3D "\\uD8F0";
+
+	assert(type =3D=3D JSON_STRING);
+	assert(key_len =3D=3D 4);
+	assert(!memcmp(key, "test", 4));
+	assert(value_len =3D=3D strlen(expected));
+	assert(!memcmp(value, expected, strlen(expected)));
+
+	return true;
+}
+
+static void test_json_escaped_unicode(const void *data)
+{
+	struct json_iter *iter;
+	char *s =3D "{\"test\":\"\\uD8F0\"}";
+
+	iter =3D json_iter_new(s, strlen(s));
+
+	assert(json_iter_foreach(iter, foreach_escaped_unicode_test, NULL));
+
+	json_iter_free(iter);
+}
+
+#define CHECK_STR(data, data_len, exp) \
+({ \
+	assert((data_len) =3D=3D strlen((exp))); \
+	assert(!memcmp(data, exp, data_len)); \
+})
+
+static bool foreach_discovery(struct json_iter *iter,
+				const uint8_t *key, size_t key_len,
+				enum json_type type, const void *value,
+				size_t value_len, void *user_data)
+{
+	uint8_t *count =3D user_data;
+
+	switch (*count) {
+	case 0:
+		assert(type =3D=3D JSON_STRING);
+		CHECK_STR(key, key_len, "ssid");
+		CHECK_STR(value, value_len, "somessid");
+		break;
+	default:
+		assert(false);
+	}
+
+	return true;
+}
+
+static bool foreach_cred(struct json_iter *iter,
+				const uint8_t *key, size_t key_len,
+				enum json_type type, const void *value,
+				size_t value_len, void *user_data)
+{
+	uint8_t *count =3D user_data;
+
+	switch (*count) {
+	case 0:
+		assert(type =3D=3D JSON_STRING);
+		CHECK_STR(key, key_len, "akm");
+		CHECK_STR(value, value_len, "psk");
+		break;
+	case 1:
+		assert(type =3D=3D JSON_STRING);
+		CHECK_STR(key, key_len, "pass");
+		CHECK_STR(value, value_len, "somepassphrase");
+		break;
+	default:
+		assert(false);
+	}
+
+	l_put_u8(*count + 1, count);
+
+	return true;
+}
+
+static bool json_foreach(struct json_iter *iter,
+				const uint8_t *key, size_t key_len,
+				enum json_type type, const void *value,
+				size_t value_len, void *user_data)
+{
+	uint8_t *count =3D user_data;
+	uint8_t count2 =3D 0;
+
+	switch (*count) {
+	case 0:
+		assert(type =3D=3D JSON_STRING);
+		CHECK_STR(key, key_len, "wi-fi_tech");
+		CHECK_STR(value, value_len, "infra");
+		break;
+	case 1:
+		assert(type =3D=3D JSON_OBJECT);
+		CHECK_STR(key, key_len, "discovery");
+		assert(json_iter_foreach((struct json_iter *)value,
+					foreach_discovery, &count2));
+
+		break;
+	case 2:
+		assert(type =3D=3D JSON_OBJECT);
+		CHECK_STR(key, key_len, "cred");
+		assert(json_iter_foreach((struct json_iter *)value,
+					foreach_cred, &count2));
+		break;
+	default:
+		assert(false);
+	}
+
+	l_put_u8(*count + 1, count);
+
+	return true;
+}
+
+static void test_json(const void *data)
+{
+	char json[] =3D "{\"wi-fi_tech\":\"infra\","
+			"\"discovery\":"
+				"{\"ssid\":\"somessid\"},"
+			"\"cred\":"
+				"{\"akm\":\"psk\","
+				"\"pass\":\"somepassphrase\"}}";
+	uint8_t count =3D 0;
+
+	struct json_iter *iter =3D json_iter_new(json, strlen(json));
+
+	assert(json_iter_foreach(iter, json_foreach, &count));
+
+	json_iter_free(iter);
+}
+
+static void test_json_unsupported_types(const void *data)
+{
+	/*
+	 * Valid JSON objects but currently unsupported types
+	 */
+	char arrays[] =3D "{\"test\":[1, 2, 3, 4]}";
+	char undefs[] =3D "{\"test\": undefined}";
+	char integers[] =3D "{\"test\": 10 }";
+	char bools[] =3D "{\"test\": true}";
+
+	struct json_iter *iter;
+
+	iter =3D json_iter_new(arrays, strlen(arrays));
+	assert(iter);
+	assert(!json_iter_foreach(iter, NULL, NULL));
+
+	iter =3D json_iter_new(undefs, strlen(undefs));
+	assert(iter);
+	assert(!json_iter_foreach(iter, NULL, NULL));
+
+	iter =3D json_iter_new(integers, strlen(integers));
+	assert(iter);
+	assert(!json_iter_foreach(iter, NULL, NULL));
+
+	iter =3D json_iter_new(bools, strlen(bools));
+	assert(iter);
+	assert(!json_iter_foreach(iter, NULL, NULL));
+}
+
+int main(int argc, char *argv[])
+{
+	l_test_init(&argc, &argv);
+
+	l_test_add("json unicode", test_json_unicode, NULL);
+	l_test_add("json escaped unicode", test_json_escaped_unicode, NULL);
+	l_test_add("json nested objects", test_json, NULL);
+	l_test_add("json unsupported types", test_json_unsupported_types, NULL);
+
+
+	return l_test_run();
+}
-- =

2.31.1

--===============8218667366496884250==--

