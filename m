Content-Type: multipart/mixed; boundary="===============4556804487733691893=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/8] unit: add primitive json test
Date: Wed, 05 Jan 2022 10:46:21 -0800
Message-ID: <20220105184627.329505-2-prestwoj@gmail.com>
In-Reply-To: 20220105184627.329505-1-prestwoj@gmail.com

--===============4556804487733691893==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-json.c | 111 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 95 insertions(+), 16 deletions(-)

diff --git a/unit/test-json.c b/unit/test-json.c
index 854b92dd..fe8f756f 100644
--- a/unit/test-json.c
+++ b/unit/test-json.c
@@ -84,8 +84,6 @@ static void test_json_unsupported_types(const void *data)
 	 * Valid JSON objects but currently unsupported types
 	 */
 	char arrays[] =3D "{\"test\":[1, 2, 3, 4]}";
-	char integers[] =3D "{\"test\": 10 }";
-	char bools[] =3D "{\"test\": true}";
 =

 	struct json_iter iter;
 	struct json_contents *c =3D json_contents_new(arrays, strlen(arrays));
@@ -95,20 +93,6 @@ static void test_json_unsupported_types(const void *data)
 				JSON_MANDATORY("test", JSON_ARRAY, NULL),
 				JSON_UNDEFINED));
 	json_contents_free(c);
-
-	c =3D json_contents_new(integers, strlen(integers));
-	json_iter_init(&iter, c);
-	assert(!json_iter_parse(&iter,
-				JSON_MANDATORY("test", JSON_PRIMITIVE, NULL),
-				JSON_UNDEFINED));
-	json_contents_free(c);
-
-	c =3D json_contents_new(bools, strlen(bools));
-	json_iter_init(&iter, c);
-	assert(!json_iter_parse(&iter,
-				JSON_MANDATORY("test", JSON_PRIMITIVE, NULL),
-				JSON_UNDEFINED));
-	json_contents_free(c);
 }
 =

 /*
@@ -248,6 +232,100 @@ static void test_json_larger_object(const void *data)
 	json_contents_free(c);
 }
 =

+static void check_primitives(struct json_iter *i, struct json_iter *ui,
+				struct json_iter *t, struct json_iter *f,
+				struct json_iter *null, struct json_iter *obj)
+{
+
+	int i_val;
+	unsigned int ui_val;
+	bool b_val;
+
+	assert(json_iter_is_valid(i));
+	assert(!json_iter_get_uint(i, NULL));
+	assert(!json_iter_get_boolean(i, NULL));
+	assert(!json_iter_get_null(i));
+	assert(json_iter_get_int(i, &i_val));
+	assert(i_val =3D=3D -10);
+
+	assert(json_iter_is_valid(ui));
+	assert(!json_iter_get_boolean(ui, NULL));
+	assert(!json_iter_get_null(ui));
+	assert(json_iter_get_int(ui, &i_val));
+	assert(json_iter_get_uint(ui, &ui_val));
+	assert(i_val =3D=3D 10 && ui_val =3D=3D 10);
+
+
+	assert(json_iter_is_valid(t));
+	assert(!json_iter_get_null(t));
+	assert(!json_iter_get_int(t, NULL));
+	assert(!json_iter_get_uint(t, NULL));
+	assert(json_iter_get_boolean(t, &b_val));
+	assert(b_val =3D=3D true);
+
+	assert(json_iter_is_valid(f));
+	assert(!json_iter_get_null(f));
+	assert(!json_iter_get_int(f, NULL));
+	assert(!json_iter_get_uint(f, NULL));
+	assert(json_iter_get_boolean(f, &b_val));
+	assert(b_val =3D=3D false);
+
+	assert(json_iter_is_valid(null));
+	assert(!json_iter_get_int(null, NULL));
+	assert(!json_iter_get_uint(null, NULL));
+	assert(!json_iter_get_boolean(null, NULL));
+	assert(json_iter_get_null(null));
+
+	if (obj) {
+		assert(json_iter_is_valid(obj));
+		assert(json_iter_parse(obj,
+			JSON_MANDATORY("null_val", JSON_PRIMITIVE, null),
+			JSON_MANDATORY("false_val", JSON_PRIMITIVE, f),
+			JSON_MANDATORY("true_val", JSON_PRIMITIVE, t),
+			JSON_MANDATORY("int_val", JSON_PRIMITIVE, i),
+			JSON_MANDATORY("uint_val", JSON_PRIMITIVE, ui),
+			JSON_UNDEFINED));
+
+		check_primitives(i, ui, t, f, null, NULL);
+	}
+}
+
+static void test_json_primitives(const void *data)
+{
+	char json[] =3D "{\"int_val\": -10,"
+			"\"uint_val\": 10,"
+			"\"true_val\": true,"
+			"\"false_val\": false,"
+			"\"null_val\": null,"
+			"\"obj_val\":{"
+				"\"int_val\": -10,"
+				"\"uint_val\": 10,"
+				"\"true_val\": true,"
+				"\"false_val\": false,"
+				"\"null_val\": null}}";
+	struct json_contents *c =3D json_contents_new(json, strlen(json));
+	struct json_iter outer, inner, null, f, t, i, ui;
+	struct json_iter not_found;
+
+	json_iter_init(&outer, c);
+	assert(json_iter_parse(&outer,
+			JSON_MANDATORY("obj_val", JSON_OBJECT, &inner),
+			JSON_MANDATORY("null_val", JSON_PRIMITIVE, &null),
+			JSON_MANDATORY("false_val", JSON_PRIMITIVE, &f),
+			JSON_MANDATORY("true_val", JSON_PRIMITIVE, &t),
+			JSON_MANDATORY("int_val", JSON_PRIMITIVE, &i),
+			JSON_MANDATORY("uint_val", JSON_PRIMITIVE, &ui),
+			JSON_OPTIONAL("not_found", JSON_PRIMITIVE, &not_found),
+			JSON_UNDEFINED));
+
+	assert(!json_iter_is_valid(&not_found));
+
+	check_primitives(&i, &ui, &t, &f, &null, &inner);
+
+	json_contents_free(c);
+}
+
+
 int main(int argc, char *argv[])
 {
 	l_test_init(&argc, &argv);
@@ -259,6 +337,7 @@ int main(int argc, char *argv[])
 	l_test_add("json empty objects", test_json_empty_objects, NULL);
 	l_test_add("json parse out of order", test_json_out_of_order, NULL);
 	l_test_add("json larger object", test_json_larger_object, NULL);
+	l_test_add("json test primitives", test_json_primitives, NULL);
 =

 	return l_test_run();
 }
-- =

2.31.1

--===============4556804487733691893==--

