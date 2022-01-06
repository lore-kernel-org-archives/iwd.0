Content-Type: multipart/mixed; boundary="===============1844511620220925107=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 2/5] unit: add strings to several json iteration tests
Date: Thu, 06 Jan 2022 14:52:55 -0800
Message-ID: <20220106225258.570850-2-prestwoj@gmail.com>
In-Reply-To: 20220106225258.570850-1-prestwoj@gmail.com

--===============1844511620220925107==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-json.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/unit/test-json.c b/unit/test-json.c
index d160f6b7..fb87987d 100644
--- a/unit/test-json.c
+++ b/unit/test-json.c
@@ -315,7 +315,7 @@ static void test_json_arrays(const void *data)
 			"\"bool_array\":[true, false, true, false],"
 			"\"null_array\":[null, null, null, null],"
 			"\"obj_array\":[{}, {\"key\":\"value\", \"key2\":\"value2\"}],"
-			"\"mixed_array\":[1, -1, true, false, null]}";
+			"\"mixed_array\":[1, -1, true, false, null, \"string\"]}";
 =

 	struct json_iter iter;
 	struct json_iter i_array, ui_array, b_array, n_array,
@@ -372,25 +372,34 @@ static void test_json_arrays(const void *data)
 	count =3D 0;
 =

 	while (json_iter_next(&m_array)) {
-		assert(json_iter_get_type(&m_array) =3D=3D JSON_PRIMITIVE);
+		_auto_(l_free) char *str =3D NULL;
 =

 		switch (count) {
 		case 0:
+			assert(json_iter_get_type(&m_array) =3D=3D JSON_PRIMITIVE);
 			assert(json_iter_get_uint(&m_array, &ui));
 			assert(ui =3D=3D 1);
 			break;
 		case 1:
+			assert(json_iter_get_type(&m_array) =3D=3D JSON_PRIMITIVE);
 			assert(json_iter_get_int(&m_array, &i));
 			assert(i =3D=3D -1);
 			break;
 		case 2:
 		case 3:
+			assert(json_iter_get_type(&m_array) =3D=3D JSON_PRIMITIVE);
 			assert(json_iter_get_boolean(&m_array, &b));
 			assert(b =3D=3D count % 2 ? false : true);
 			break;
 		case 4:
+			assert(json_iter_get_type(&m_array) =3D=3D JSON_PRIMITIVE);
 			assert(json_iter_get_null(&m_array));
 			break;
+		case 5:
+			assert(json_iter_get_type(&m_array) =3D=3D JSON_STRING);
+			assert(json_iter_get_string(&m_array, &str));
+			assert(!strcmp(str, "string"));
+			break;
 		}
 =

 		count++;
@@ -425,7 +434,7 @@ static void test_json_arrays(const void *data)
 =

 static void test_json_nested_arrays(const void *data)
 {
-	char json[] =3D "{\"array\":[[], {}, [1, 2], {\"key\":\"value\"}]}";
+	char json[] =3D "{\"array\":[[], {}, [1, 2], {\"key\":\"value\"}, [\"one\=
",\"two\"]]}";
 	int count =3D 0;
 	struct json_iter iter;
 	struct json_iter array;
@@ -442,8 +451,29 @@ static void test_json_nested_arrays(const void *data)
 =

 		assert(json_iter_get_container(&array, &inner));
 =

-		while (json_iter_next(&inner))
+		while (json_iter_next(&inner)) {
+			_auto_(l_free) char *str =3D NULL;
+
+			switch (count) {
+			case 0:
+			case 1:
+				assert(false);
+				break;
+			case 4:
+				assert(json_iter_get_type(&inner) =3D=3D
+							JSON_STRING);
+				assert(json_iter_get_string(&inner, &str));
+
+				if (count2 =3D=3D 0)
+					assert(!strcmp("one", str));
+				else
+					assert(!strcmp("two", str));
+
+				break;
+			}
+
 			count2++;
+		}
 =

 		/*
 		 * TODO: add checks for object iteration. Currently these will
@@ -456,6 +486,9 @@ static void test_json_nested_arrays(const void *data)
 		case 2:
 			assert(count2 =3D=3D 2);
 			break;
+		case 4:
+			assert(count2 =3D=3D 2);
+			break;
 		default:
 			break;
 		}
@@ -463,7 +496,7 @@ static void test_json_nested_arrays(const void *data)
 		count++;
 	}
 =

-	assert(count =3D=3D 4);
+	assert(count =3D=3D 5);
 =

 	json_contents_free(c);
 }
-- =

2.31.1

--===============1844511620220925107==--

