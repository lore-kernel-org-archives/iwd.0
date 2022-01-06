Content-Type: multipart/mixed; boundary="===============5676849479649267213=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 5/5] unit: add checks for improper use of json_iter_parse/next
Date: Thu, 06 Jan 2022 14:42:16 -0800
Message-ID: <20220106224216.569171-5-prestwoj@gmail.com>
In-Reply-To: 20220106224216.569171-1-prestwoj@gmail.com

--===============5676849479649267213==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds checks to make sure these API's don't operate on
objects/primitives they aren't supposed to.
---
 unit/test-json.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/unit/test-json.c b/unit/test-json.c
index fb87987d..0d48b3d1 100644
--- a/unit/test-json.c
+++ b/unit/test-json.c
@@ -225,12 +225,14 @@ static void check_primitives(struct json_iter *i, str=
uct json_iter *ui,
 	assert(!json_iter_get_uint(i, NULL));
 	assert(!json_iter_get_boolean(i, NULL));
 	assert(!json_iter_get_null(i));
+	assert(!json_iter_next(i));
 	assert(json_iter_get_int(i, &i_val));
 	assert(i_val =3D=3D -10);
 =

 	assert(json_iter_is_valid(ui));
 	assert(!json_iter_get_boolean(ui, NULL));
 	assert(!json_iter_get_null(ui));
+	assert(!json_iter_next(ui));
 	assert(json_iter_get_int(ui, &i_val));
 	assert(json_iter_get_uint(ui, &ui_val));
 	assert(i_val =3D=3D 10 && ui_val =3D=3D 10);
@@ -239,6 +241,7 @@ static void check_primitives(struct json_iter *i, struc=
t json_iter *ui,
 	assert(!json_iter_get_null(t));
 	assert(!json_iter_get_int(t, NULL));
 	assert(!json_iter_get_uint(t, NULL));
+	assert(!json_iter_next(t));
 	assert(json_iter_get_boolean(t, &b_val));
 	assert(b_val =3D=3D true);
 =

@@ -246,6 +249,7 @@ static void check_primitives(struct json_iter *i, struc=
t json_iter *ui,
 	assert(!json_iter_get_null(f));
 	assert(!json_iter_get_int(f, NULL));
 	assert(!json_iter_get_uint(f, NULL));
+	assert(!json_iter_next(f));
 	assert(json_iter_get_boolean(f, &b_val));
 	assert(b_val =3D=3D false);
 =

@@ -253,10 +257,12 @@ static void check_primitives(struct json_iter *i, str=
uct json_iter *ui,
 	assert(!json_iter_get_int(null, NULL));
 	assert(!json_iter_get_uint(null, NULL));
 	assert(!json_iter_get_boolean(null, NULL));
+	assert(!json_iter_next(null));
 	assert(json_iter_get_null(null));
 =

 	if (obj) {
 		assert(json_iter_is_valid(obj));
+		assert(!json_iter_next(obj));
 		assert(json_iter_parse(obj,
 			JSON_MANDATORY("null_val", JSON_PRIMITIVE, null),
 			JSON_MANDATORY("false_val", JSON_PRIMITIVE, f),
@@ -336,6 +342,7 @@ static void test_json_arrays(const void *data)
 =

 	while (json_iter_next(&ui_array)) {
 		assert(json_iter_get_type(&ui_array) =3D=3D JSON_PRIMITIVE);
+		assert(!json_iter_parse(&ui_array, JSON_UNDEFINED));
 		assert(json_iter_get_uint(&ui_array, &ui));
 		assert(ui =3D=3D (unsigned int) count);
 		count++;
@@ -345,6 +352,7 @@ static void test_json_arrays(const void *data)
 =

 	while (json_iter_next(&i_array)) {
 		assert(json_iter_get_type(&i_array) =3D=3D JSON_PRIMITIVE);
+		assert(!json_iter_parse(&i_array, JSON_UNDEFINED));
 		assert(json_iter_get_int(&i_array, &i));
 		assert(i =3D=3D count);
 		count--;
@@ -354,6 +362,7 @@ static void test_json_arrays(const void *data)
 =

 	while (json_iter_next(&b_array)) {
 		assert(json_iter_get_type(&b_array) =3D=3D JSON_PRIMITIVE);
+		assert(!json_iter_parse(&b_array, JSON_UNDEFINED));
 		assert(json_iter_get_boolean(&b_array, &b));
 		assert(b =3D=3D count % 2 ? false : true);
 		count++;
@@ -363,6 +372,7 @@ static void test_json_arrays(const void *data)
 =

 	while (json_iter_next(&n_array)) {
 		assert(json_iter_get_type(&n_array) =3D=3D JSON_PRIMITIVE);
+		assert(!json_iter_parse(&n_array, JSON_UNDEFINED));
 		assert(json_iter_get_null(&n_array));
 		count++;
 	}
@@ -407,6 +417,8 @@ static void test_json_arrays(const void *data)
 =

 	count =3D 0;
 =

+	assert(!json_iter_parse(&obj_array, JSON_UNDEFINED));
+
 	while (json_iter_next(&obj_array)) {
 		struct json_iter object;
 =

@@ -475,17 +487,19 @@ static void test_json_nested_arrays(const void *data)
 			count2++;
 		}
 =

-		/*
-		 * TODO: add checks for object iteration. Currently these will
-		 * just count all tokens in the object.
-		 */
 		switch (count) {
 		case 0:
 			assert(count2 =3D=3D 0);
 			break;
+		case 1:
+			assert(count2 =3D=3D 0);
+			break;
 		case 2:
 			assert(count2 =3D=3D 2);
 			break;
+		case 3:
+			assert(count2 =3D=3D 0);
+			break;
 		case 4:
 			assert(count2 =3D=3D 2);
 			break;
-- =

2.31.1

--===============5676849479649267213==--

