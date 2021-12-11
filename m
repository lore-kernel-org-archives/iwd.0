Content-Type: multipart/mixed; boundary="===============6144705476797070180=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] unit: add larger object test
Date: Fri, 10 Dec 2021 16:21:37 -0800
Message-ID: <20211211002137.2104598-1-prestwoj@gmail.com>

--===============6144705476797070180==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This tests the previous JSON bug fix removing % sizeof(jsmntok_t)
Objects with more than 10 (sizeof(jsmntok_t)) would not parse
correctly.
---
 unit/test-json.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/unit/test-json.c b/unit/test-json.c
index 4c43a8cd..854b92dd 100644
--- a/unit/test-json.c
+++ b/unit/test-json.c
@@ -219,6 +219,35 @@ static void test_json_out_of_order(const void *data)
 	json_contents_free(c);
 }
 =

+/*
+ * Tests that the token bounds checking works.
+ */
+static void test_json_larger_object(const void *data)
+{
+	char json[] =3D "{\"test1\":\"tester1\","
+			"\"test2\":\"tester2\","
+			"\"test3\":\"tester3\","
+			"\"test4\":\"tester4\","
+			"\"test5\":\"tester5\","
+			"\"test6\":\"tester6\","
+			"\"test7\":\"tester7\","
+			"\"test8\":\"tester8\","
+			"\"test9\":\"tester9\","
+			"\"test10\":\"tester10\","
+			"\"test11\":\"tester11\","
+			"\"test12\":\"tester12\","
+			"\"test13\":\"tester13\"}";
+
+	struct json_iter iter;
+	struct json_contents *c =3D json_contents_new(json, strlen(json));
+
+	json_iter_init(&iter, c);
+	assert(json_iter_parse(&iter,
+				JSON_MANDATORY("test13", JSON_STRING, NULL),
+				JSON_UNDEFINED));
+	json_contents_free(c);
+}
+
 int main(int argc, char *argv[])
 {
 	l_test_init(&argc, &argv);
@@ -229,6 +258,7 @@ int main(int argc, char *argv[])
 	l_test_add("json unsupported types", test_json_unsupported_types, NULL);
 	l_test_add("json empty objects", test_json_empty_objects, NULL);
 	l_test_add("json parse out of order", test_json_out_of_order, NULL);
+	l_test_add("json larger object", test_json_larger_object, NULL);
 =

 	return l_test_run();
 }
-- =

2.31.1

--===============6144705476797070180==--

