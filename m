Content-Type: multipart/mixed; boundary="===============0760322882189282307=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 3/3] unit: add JSON unit test
Date: Wed, 08 Dec 2021 13:36:36 -0800
Message-ID: <20211208213636.1697316-3-prestwoj@gmail.com>
In-Reply-To: 20211208213636.1697316-1-prestwoj@gmail.com

--===============0760322882189282307==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am      |   5 +-
 unit/test-json.c | 238 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 242 insertions(+), 1 deletion(-)
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
index 00000000..ddc820d5
--- /dev/null
+++ b/unit/test-json.c
@@ -0,0 +1,238 @@
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
+/*
+ * Object:
+ * { "test": "<smile emoji>" }
+ */
+static void test_json_unicode(const void *data)
+{
+	struct json_iter *iter;
+	struct iovec v;
+	uint8_t expected[] =3D { 0xF0, 0x9F, 0x98, 0x80 };
+
+	uint8_t s[] =3D { '{', '"', 't', 'e', 's', 't', '"', ':',
+				'"', 0xf0, 0x9f, 0x98, 0x80, '"', '}', 0 };
+
+	iter =3D json_iter_new((const char *)s, sizeof(s));
+	assert(json_iter_parse(iter, JSON_MANDATORY("test", JSON_STRING, &v),
+				JSON_FLAG_INVALID));
+
+	assert(v.iov_len =3D=3D sizeof(expected));
+	assert(!memcmp(v.iov_base, expected, sizeof(expected)));
+
+	json_iter_free(iter);
+}
+
+static void test_json_escaped_unicode(const void *data)
+{
+	struct json_iter *iter;
+	struct iovec v;
+	char *s =3D "{\"test\":\"\\uD8F0\"}";
+	char expected[] =3D "\\uD8F0";
+
+	iter =3D json_iter_new(s, strlen(s));
+	assert(json_iter_parse(iter, JSON_MANDATORY("test", JSON_STRING, &v),
+				JSON_FLAG_INVALID));
+
+	assert(v.iov_len =3D=3D strlen(expected));
+	assert(!memcmp(v.iov_base, expected, strlen(expected)));
+
+	json_iter_free(iter);
+}
+
+/*
+ * Tests that unsupported types will not parse
+ */
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
+	assert(!json_iter_parse(iter,
+				JSON_MANDATORY("test", JSON_ARRAY, NULL),
+				JSON_FLAG_INVALID));
+
+	iter =3D json_iter_new(undefs, strlen(undefs));
+	assert(iter);
+	assert(!json_iter_parse(iter,
+				JSON_MANDATORY("test", JSON_UNDEFINED, NULL),
+				JSON_FLAG_INVALID));
+
+	iter =3D json_iter_new(integers, strlen(integers));
+	assert(iter);
+	assert(!json_iter_parse(iter,
+				JSON_MANDATORY("test", JSON_PRIMITIVE, NULL),
+				JSON_FLAG_INVALID));
+
+	iter =3D json_iter_new(bools, strlen(bools));
+	assert(iter);
+	assert(!json_iter_parse(iter,
+				JSON_MANDATORY("test", JSON_PRIMITIVE, NULL),
+				JSON_FLAG_INVALID));
+}
+
+#define CHECK_STRING(iov, exp) \
+({ \
+	assert((iov)->iov_len =3D=3D strlen((exp))); \
+	assert(!memcmp((iov)->iov_base, exp, (iov)->iov_len)); \
+})
+
+/*
+ * Basic test string values and nested objects
+ */
+static void test_json(const void *data)
+{
+	char json[] =3D "{\"wi-fi_tech\":\"infra\","
+			"\"discovery\":"
+				"{\"ssid\":\"somessid\"},"
+			"\"cred\":"
+				"{\"akm\":\"psk\","
+				"\"pass\":\"somepassphrase\"}}";
+	struct iovec tech;
+	struct iovec ssid;
+	struct iovec akm;
+	struct iovec pass;
+	struct iovec opt_not_found;
+	struct json_iter *discovery, *cred;
+
+	struct json_iter *iter =3D json_iter_new(json, strlen(json));
+
+	assert(json_iter_parse(iter,
+			JSON_MANDATORY("wi-fi_tech", JSON_STRING, &tech),
+			JSON_MANDATORY("discovery", JSON_OBJECT, &discovery),
+			JSON_MANDATORY("cred", JSON_OBJECT, &cred),
+			JSON_OPTIONAL("notfound", JSON_STRING, &opt_not_found),
+			JSON_FLAG_INVALID));
+
+	assert(opt_not_found.iov_base =3D=3D 0);
+
+	CHECK_STRING(&tech, "infra");
+
+	assert(json_iter_parse(discovery,
+			JSON_MANDATORY("ssid", JSON_STRING, &ssid),
+			JSON_FLAG_INVALID));
+
+	CHECK_STRING(&ssid, "somessid");
+
+	assert(json_iter_parse(cred,
+			JSON_MANDATORY("akm", JSON_STRING, &akm),
+			JSON_MANDATORY("pass", JSON_STRING, &pass),
+			JSON_FLAG_INVALID));
+
+	CHECK_STRING(&akm, "psk");
+	CHECK_STRING(&pass, "somepassphrase");
+
+	json_iter_free(iter);
+}
+
+/*
+ * Tests empty objects parse successfully
+ */
+static void test_json_empty_objects(const void *data)
+{
+	char empty[] =3D "{}";
+	char nested_empty[] =3D "{\"empty\":{}}";
+	struct json_iter *nested_iter;
+	struct json_iter *iter;
+
+	iter =3D json_iter_new(empty, strlen(empty));
+	assert(json_iter_parse(iter, JSON_FLAG_INVALID));
+	json_iter_free(iter);
+
+	iter =3D json_iter_new(empty, strlen(empty));
+	assert(json_iter_parse(iter,
+				JSON_OPTIONAL("optional", JSON_OBJECT, NULL),
+				JSON_FLAG_INVALID));
+	json_iter_free(iter);
+
+
+	iter =3D json_iter_new(empty, strlen(empty));
+	assert(!json_iter_parse(iter,
+				JSON_MANDATORY("optional", JSON_OBJECT, NULL),
+				JSON_FLAG_INVALID));
+	json_iter_free(iter);
+
+
+	iter =3D json_iter_new(nested_empty, strlen(nested_empty));
+	assert(json_iter_parse(iter,
+			JSON_MANDATORY("empty", JSON_OBJECT, &nested_iter),
+			JSON_FLAG_INVALID));
+	assert(nested_iter);
+	assert(json_iter_parse(nested_iter, JSON_FLAG_INVALID));
+	json_iter_free(iter);
+}
+
+/*
+ * Tests that expected key/values can be provided in an order different th=
an
+ * they appear in the JSON string.
+ */
+static void test_json_out_of_order(const void *data)
+{
+	char object[] =3D "{\"key1\":{},\"key2\":\"val2\",\"key3\":\"val3\"}";
+	struct json_iter *iter;
+
+	iter =3D json_iter_new(object, strlen(object));
+	assert(iter);
+	assert(json_iter_parse(iter,
+				JSON_OPTIONAL("nonexist1", JSON_STRING, NULL),
+				JSON_MANDATORY("key3", JSON_STRING, NULL),
+				JSON_MANDATORY("key2", JSON_STRING, NULL),
+				JSON_OPTIONAL("nonexist2", JSON_OBJECT, NULL),
+				JSON_MANDATORY("key1", JSON_OBJECT, NULL),
+				JSON_FLAG_INVALID));
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
+	l_test_add("json empty objects", test_json_empty_objects, NULL);
+	l_test_add("json parse out of order", test_json_out_of_order, NULL);
+
+	return l_test_run();
+}
-- =

2.31.1

--===============0760322882189282307==--

