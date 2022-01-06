Content-Type: multipart/mixed; boundary="===============7235454096353079405=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 8/9] unit: add arrays of objects test
Date: Thu, 06 Jan 2022 11:50:06 -0800
Message-ID: <20220106195007.528618-8-prestwoj@gmail.com>
In-Reply-To: 20220106195007.528618-1-prestwoj@gmail.com

--===============7235454096353079405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-json.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/unit/test-json.c b/unit/test-json.c
index 1a7daaff..52e3f675 100644
--- a/unit/test-json.c
+++ b/unit/test-json.c
@@ -315,10 +315,12 @@ static void test_json_arrays(const void *data)
 			"\"int_array\":[-1, -2, -3, -4, -5, -6],"
 			"\"bool_array\":[true, false, true, false],"
 			"\"null_array\":[null, null, null, null],"
+			"\"obj_array\":[{}, {\"key\":\"value\", \"key2\":\"value2\"}],"
 			"\"mixed_array\":[1, -1, true, false, null]}";
 =

 	struct json_iter iter;
-	struct json_iter i_array, ui_array, b_array, n_array, m_array;
+	struct json_iter i_array, ui_array, b_array, n_array,
+				m_array, obj_array;
 	struct json_contents *c =3D json_contents_new(json, strlen(json));
 =

 	json_iter_init(&iter, c);
@@ -328,6 +330,7 @@ static void test_json_arrays(const void *data)
 			JSON_MANDATORY("bool_array", JSON_ARRAY, &b_array),
 			JSON_MANDATORY("int_array", JSON_ARRAY, &i_array),
 			JSON_MANDATORY("uint_array", JSON_ARRAY, &ui_array),
+			JSON_MANDATORY("obj_array", JSON_ARRAY, &obj_array),
 			JSON_UNDEFINED));
 =

 	count =3D 1;
@@ -394,6 +397,30 @@ static void test_json_arrays(const void *data)
 		count++;
 	}
 =

+	count =3D 0;
+
+	while (json_iter_next(&obj_array)) {
+		struct json_iter object;
+
+		assert(json_iter_get_type(&obj_array) =3D=3D JSON_OBJECT);
+		assert(json_iter_get_container(&obj_array, &object));
+
+		switch (count) {
+		case 0:
+			assert(json_iter_parse(&object, JSON_UNDEFINED));
+			break;
+		case 1:
+			assert(json_iter_parse(&object,
+				JSON_MANDATORY("key", JSON_STRING, NULL),
+				JSON_UNDEFINED));
+			break;
+		}
+
+		count++;
+	}
+
+	assert(count =3D=3D 2);
+
 	json_contents_free(c);
 }
 =

-- =

2.31.1

--===============7235454096353079405==--

