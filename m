Content-Type: multipart/mixed; boundary="===============3643821729590524416=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 5/8] unit: add test for json arrays
Date: Wed, 05 Jan 2022 10:46:24 -0800
Message-ID: <20220105184627.329505-5-prestwoj@gmail.com>
In-Reply-To: 20220105184627.329505-1-prestwoj@gmail.com

--===============3643821729590524416==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-json.c | 113 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 92 insertions(+), 21 deletions(-)

diff --git a/unit/test-json.c b/unit/test-json.c
index fe8f756f..1a7daaff 100644
--- a/unit/test-json.c
+++ b/unit/test-json.c
@@ -75,26 +75,6 @@ static void test_json_escaped_unicode(const void *data)
 	json_contents_free(c);
 }
 =

-/*
- * Tests that unsupported types will not parse
- */
-static void test_json_unsupported_types(const void *data)
-{
-	/*
-	 * Valid JSON objects but currently unsupported types
-	 */
-	char arrays[] =3D "{\"test\":[1, 2, 3, 4]}";
-
-	struct json_iter iter;
-	struct json_contents *c =3D json_contents_new(arrays, strlen(arrays));
-
-	json_iter_init(&iter, c);
-	assert(!json_iter_parse(&iter,
-				JSON_MANDATORY("test", JSON_ARRAY, NULL),
-				JSON_UNDEFINED));
-	json_contents_free(c);
-}
-
 /*
  * Basic test string values and nested objects
  */
@@ -325,6 +305,97 @@ static void test_json_primitives(const void *data)
 	json_contents_free(c);
 }
 =

+static void test_json_arrays(const void *data)
+{
+	unsigned int ui;
+	int i;
+	bool b;
+	int count;
+	char json[] =3D "{\"uint_array\":[1, 2, 3, 4, 5, 6],"
+			"\"int_array\":[-1, -2, -3, -4, -5, -6],"
+			"\"bool_array\":[true, false, true, false],"
+			"\"null_array\":[null, null, null, null],"
+			"\"mixed_array\":[1, -1, true, false, null]}";
+
+	struct json_iter iter;
+	struct json_iter i_array, ui_array, b_array, n_array, m_array;
+	struct json_contents *c =3D json_contents_new(json, strlen(json));
+
+	json_iter_init(&iter, c);
+	assert(json_iter_parse(&iter,
+			JSON_MANDATORY("mixed_array", JSON_ARRAY, &m_array),
+			JSON_MANDATORY("null_array", JSON_ARRAY, &n_array),
+			JSON_MANDATORY("bool_array", JSON_ARRAY, &b_array),
+			JSON_MANDATORY("int_array", JSON_ARRAY, &i_array),
+			JSON_MANDATORY("uint_array", JSON_ARRAY, &ui_array),
+			JSON_UNDEFINED));
+
+	count =3D 1;
+
+	while (json_iter_next(&ui_array)) {
+		assert(json_iter_get_type(&ui_array) =3D=3D JSON_PRIMITIVE);
+		assert(json_iter_get_uint(&ui_array, &ui));
+		assert(ui =3D=3D (unsigned int) count);
+		count++;
+	}
+
+	count =3D -1;
+
+	while (json_iter_next(&i_array)) {
+		assert(json_iter_get_type(&i_array) =3D=3D JSON_PRIMITIVE);
+		assert(json_iter_get_int(&i_array, &i));
+		assert(i =3D=3D count);
+		count--;
+	}
+
+	count =3D 0;
+
+	while (json_iter_next(&b_array)) {
+		assert(json_iter_get_type(&b_array) =3D=3D JSON_PRIMITIVE);
+		assert(json_iter_get_boolean(&b_array, &b));
+		assert(b =3D=3D count % 2 ? false : true);
+		count++;
+	}
+
+	count =3D 0;
+
+	while (json_iter_next(&n_array)) {
+		assert(json_iter_get_type(&n_array) =3D=3D JSON_PRIMITIVE);
+		assert(json_iter_get_null(&n_array));
+		count++;
+	}
+
+	assert(count =3D=3D 4);
+
+	count =3D 0;
+
+	while (json_iter_next(&m_array)) {
+		assert(json_iter_get_type(&m_array) =3D=3D JSON_PRIMITIVE);
+
+		switch (count) {
+		case 0:
+			assert(json_iter_get_uint(&m_array, &ui));
+			assert(ui =3D=3D 1);
+			break;
+		case 1:
+			assert(json_iter_get_int(&m_array, &i));
+			assert(i =3D=3D -1);
+			break;
+		case 2:
+		case 3:
+			assert(json_iter_get_boolean(&m_array, &b));
+			assert(b =3D=3D count % 2 ? false : true);
+			break;
+		case 4:
+			assert(json_iter_get_null(&m_array));
+			break;
+		}
+
+		count++;
+	}
+
+	json_contents_free(c);
+}
 =

 int main(int argc, char *argv[])
 {
@@ -333,11 +404,11 @@ int main(int argc, char *argv[])
 	l_test_add("json unicode", test_json_unicode, NULL);
 	l_test_add("json escaped unicode", test_json_escaped_unicode, NULL);
 	l_test_add("json nested objects", test_json, NULL);
-	l_test_add("json unsupported types", test_json_unsupported_types, NULL);
 	l_test_add("json empty objects", test_json_empty_objects, NULL);
 	l_test_add("json parse out of order", test_json_out_of_order, NULL);
 	l_test_add("json larger object", test_json_larger_object, NULL);
 	l_test_add("json test primitives", test_json_primitives, NULL);
+	l_test_add("json test arrays", test_json_arrays, NULL);
 =

 	return l_test_run();
 }
-- =

2.31.1

--===============3643821729590524416==--

