Content-Type: multipart/mixed; boundary="===============1121110300565296598=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 9/9] unit: add test for nested arrays
Date: Thu, 06 Jan 2022 11:50:07 -0800
Message-ID: <20220106195007.528618-9-prestwoj@gmail.com>
In-Reply-To: 20220106195007.528618-1-prestwoj@gmail.com

--===============1121110300565296598==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-json.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/unit/test-json.c b/unit/test-json.c
index 52e3f675..3d7e690b 100644
--- a/unit/test-json.c
+++ b/unit/test-json.c
@@ -424,6 +424,51 @@ static void test_json_arrays(const void *data)
 	json_contents_free(c);
 }
 =

+static void test_json_nested_arrays(const void *data)
+{
+	char json[] =3D "{\"array\":[[], {}, [1, 2], {\"key\":\"value\"}]}";
+	int count =3D 0;
+	struct json_iter iter;
+	struct json_iter array;
+	struct json_iter inner;
+	struct json_contents *c =3D json_contents_new(json, strlen(json));
+
+	json_iter_init(&iter, c);
+	assert(json_iter_parse(&iter,
+			JSON_MANDATORY("array", JSON_ARRAY, &array),
+			JSON_UNDEFINED));
+
+	while (json_iter_next(&array)) {
+		int count2 =3D 0;
+
+		assert(json_iter_get_container(&array, &inner));
+
+		while (json_iter_next(&inner))
+			count2++;
+
+		/*
+		 * TODO: add checks for object iteration. Currently these will
+		 * just count all tokens in the object.
+		 */
+		switch (count) {
+		case 0:
+			assert(count2 =3D=3D 0);
+			break;
+		case 2:
+			assert(count2 =3D=3D 2);
+			break;
+		default:
+			break;
+		}
+
+		count++;
+	}
+
+	assert(count =3D=3D 4);
+
+	json_contents_free(c);
+}
+
 int main(int argc, char *argv[])
 {
 	l_test_init(&argc, &argv);
@@ -436,6 +481,7 @@ int main(int argc, char *argv[])
 	l_test_add("json larger object", test_json_larger_object, NULL);
 	l_test_add("json test primitives", test_json_primitives, NULL);
 	l_test_add("json test arrays", test_json_arrays, NULL);
+	l_test_add("json test nested arrays", test_json_nested_arrays, NULL);
 =

 	return l_test_run();
 }
-- =

2.31.1

--===============1121110300565296598==--

