Content-Type: multipart/mixed; boundary="===============1365307153398056887=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 8/8] unit: add test for nested arrays
Date: Wed, 05 Jan 2022 10:46:27 -0800
Message-ID: <20220105184627.329505-8-prestwoj@gmail.com>
In-Reply-To: 20220105184627.329505-1-prestwoj@gmail.com

--===============1365307153398056887==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These are not yet supported, but test anyway to ensure iteration
does not work and doesn't result in any unexpected behavior.
---
 unit/test-json.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/unit/test-json.c b/unit/test-json.c
index 52e3f675..5ffd36ec 100644
--- a/unit/test-json.c
+++ b/unit/test-json.c
@@ -424,6 +424,27 @@ static void test_json_arrays(const void *data)
 	json_contents_free(c);
 }
 =

+static void test_json_nested_arrays(const void *data)
+{
+	char json[] =3D "{\"array\":[[1, 2], [3, 4]]}";
+	int count =3D 0;
+	struct json_iter iter;
+	struct json_iter array;
+	struct json_contents *c =3D json_contents_new(json, strlen(json));
+
+	json_iter_init(&iter, c);
+	assert(json_iter_parse(&iter,
+			JSON_MANDATORY("array", JSON_ARRAY, &array),
+			JSON_UNDEFINED));
+
+	while (json_iter_next(&array))
+		count++;
+
+	assert(count =3D=3D 0);
+
+	json_contents_free(c);
+}
+
 int main(int argc, char *argv[])
 {
 	l_test_init(&argc, &argv);
@@ -436,6 +457,7 @@ int main(int argc, char *argv[])
 	l_test_add("json larger object", test_json_larger_object, NULL);
 	l_test_add("json test primitives", test_json_primitives, NULL);
 	l_test_add("json test arrays", test_json_arrays, NULL);
+	l_test_add("json test nested arrays", test_json_nested_arrays, NULL);
 =

 	return l_test_run();
 }
-- =

2.31.1

--===============1365307153398056887==--

