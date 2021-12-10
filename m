Content-Type: multipart/mixed; boundary="===============6098112354969505743=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v4 3/3] unit: add JSON unit test
Date: Fri, 10 Dec 2021 14:33:27 -0800
Message-ID: <20211210223327.2060720-3-prestwoj@gmail.com>
In-Reply-To: 20211210223327.2060720-1-prestwoj@gmail.com

--===============6098112354969505743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am      |   5 +-
 unit/test-json.c | 234 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 238 insertions(+), 1 deletion(-)
 create mode 100644 unit/test-json.c

diff --git a/Makefile.am b/Makefile.am
index fef2c2c4..312081a0 100644
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
index 00000000..4c43a8cd
--- /dev/null
+++ b/unit/test-json.c
@@ -0,0 +1,234 @@
+/*
+ *
+ *  Wireless daemon for Linux
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
+struct json_contents;
+
+
+/*
+ * Object:
+ * { "test": "<smile emoji>" }
+ */
+static void test_json_unicode(const void *data)
+{
+	struct json_iter iter;
+	_auto_(l_free)char *v;
+	uint8_t expected[] =3D { 0xF0, 0x9F, 0x98, 0x80, 0 };
+
+	uint8_t s[] =3D { '{', '"', 't', 'e', 's', 't', '"', ':',
+				'"', 0xf0, 0x9f, 0x98, 0x80, '"', '}', 0 };
+	struct json_contents *c =3D json_contents_new((const char *)s, sizeof(s));
+
+	json_iter_init(&iter, c);
+	assert(json_iter_parse(&iter, JSON_MANDATORY("test", JSON_STRING, &v),
+				JSON_UNDEFINED));
+
+	assert(!strcmp(v, (char *)expected));
+
+	json_contents_free(c);
+}
+
+static void test_json_escaped_unicode(const void *data)
+{
+	struct json_iter iter;
+	_auto_(l_free)char *v;
+	char *s =3D "{\"test\":\"\\uD8F0\"}";
+	char expected[] =3D "\\uD8F0";
+	struct json_contents *c =3D json_contents_new(s, strlen(s));
+
+	json_iter_init(&iter, c);
+	assert(json_iter_parse(&iter, JSON_MANDATORY("test", JSON_STRING, &v),
+				JSON_UNDEFINED));
+
+	assert(!strcmp(v, expected));
+
+	json_contents_free(c);
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
+	char integers[] =3D "{\"test\": 10 }";
+	char bools[] =3D "{\"test\": true}";
+
+	struct json_iter iter;
+	struct json_contents *c =3D json_contents_new(arrays, strlen(arrays));
+
+	json_iter_init(&iter, c);
+	assert(!json_iter_parse(&iter,
+				JSON_MANDATORY("test", JSON_ARRAY, NULL),
+				JSON_UNDEFINED));
+	json_contents_free(c);
+
+	c =3D json_contents_new(integers, strlen(integers));
+	json_iter_init(&iter, c);
+	assert(!json_iter_parse(&iter,
+				JSON_MANDATORY("test", JSON_PRIMITIVE, NULL),
+				JSON_UNDEFINED));
+	json_contents_free(c);
+
+	c =3D json_contents_new(bools, strlen(bools));
+	json_iter_init(&iter, c);
+	assert(!json_iter_parse(&iter,
+				JSON_MANDATORY("test", JSON_PRIMITIVE, NULL),
+				JSON_UNDEFINED));
+	json_contents_free(c);
+}
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
+	_auto_(l_free)char *tech;
+	_auto_(l_free)char *ssid;
+	_auto_(l_free)char *akm;
+	_auto_(l_free)char *pass;
+	_auto_(l_free)char *opt_not_found;
+	struct json_iter objnotfound;
+	struct json_iter discovery;
+	struct json_iter cred;
+	struct json_iter iter;
+	struct json_contents *c =3D json_contents_new(json, strlen(json));
+
+	json_iter_init(&iter, c);
+	assert(json_iter_parse(&iter,
+			JSON_MANDATORY("wi-fi_tech", JSON_STRING, &tech),
+			JSON_MANDATORY("discovery", JSON_OBJECT, &discovery),
+			JSON_MANDATORY("cred", JSON_OBJECT, &cred),
+			JSON_OPTIONAL("notfound", JSON_STRING, &opt_not_found),
+			JSON_OPTIONAL("objnotfound", JSON_OBJECT, &objnotfound),
+			JSON_UNDEFINED));
+
+	assert(opt_not_found =3D=3D NULL);
+	assert(!json_iter_is_valid(&objnotfound));
+
+	assert(!strcmp(tech, "infra"));
+
+	assert(json_iter_parse(&discovery,
+			JSON_MANDATORY("ssid", JSON_STRING, &ssid),
+			JSON_UNDEFINED));
+
+	assert(!strcmp(ssid, "somessid"));
+
+	assert(json_iter_parse(&cred,
+			JSON_MANDATORY("akm", JSON_STRING, &akm),
+			JSON_MANDATORY("pass", JSON_STRING, &pass),
+			JSON_UNDEFINED));
+	assert(!strcmp(akm, "psk"));
+	assert(!strcmp(pass, "somepassphrase"));
+
+	json_contents_free(c);
+}
+
+/*
+ * Tests empty objects parse successfully
+ */
+static void test_json_empty_objects(const void *data)
+{
+	char empty[] =3D "{}";
+	char nested_empty[] =3D "{\"empty\":{}}";
+	struct json_iter nested_iter;
+	struct json_iter iter;
+	struct json_contents *c =3D json_contents_new(empty, strlen(empty));
+
+	json_iter_init(&iter, c);
+	assert(json_iter_parse(&iter, JSON_UNDEFINED));
+
+	assert(json_iter_parse(&iter,
+				JSON_OPTIONAL("optional", JSON_OBJECT, NULL),
+				JSON_UNDEFINED));
+
+	assert(!json_iter_parse(&iter,
+				JSON_MANDATORY("optional", JSON_OBJECT, NULL),
+				JSON_UNDEFINED));
+	json_contents_free(c);
+
+	c =3D json_contents_new(nested_empty, strlen(nested_empty));
+	json_iter_init(&iter, c);
+	assert(json_iter_parse(&iter,
+			JSON_MANDATORY("empty", JSON_OBJECT, &nested_iter),
+			JSON_UNDEFINED));
+	assert(json_iter_parse(&nested_iter, JSON_UNDEFINED));
+	assert(!json_iter_parse(&nested_iter,
+				JSON_MANDATORY("mandatory", JSON_OBJECT, NULL),
+				JSON_UNDEFINED));
+	json_contents_free(c);
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
+	struct json_iter iter;
+	struct json_contents *c =3D json_contents_new(object, strlen(object));
+
+	json_iter_init(&iter, c);
+	assert(json_iter_parse(&iter,
+				JSON_OPTIONAL("nonexist1", JSON_STRING, NULL),
+				JSON_MANDATORY("key3", JSON_STRING, NULL),
+				JSON_MANDATORY("key2", JSON_STRING, NULL),
+				JSON_OPTIONAL("nonexist2", JSON_OBJECT, NULL),
+				JSON_MANDATORY("key1", JSON_OBJECT, NULL),
+				JSON_UNDEFINED));
+	json_contents_free(c);
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

--===============6098112354969505743==--

