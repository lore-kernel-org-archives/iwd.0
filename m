Content-Type: multipart/mixed; boundary="===============1726740597770168025=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] unit: add test for util_is_field_bit_set
Date: Thu, 07 Nov 2019 10:19:09 -0800
Message-ID: <20191107181909.29773-2-prestwoj@gmail.com>
In-Reply-To: <20191107181909.29773-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1726740597770168025==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-util.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/unit/test-util.c b/unit/test-util.c
index f091f2c2..f0cc0956 100644
--- a/unit/test-util.c
+++ b/unit/test-util.c
@@ -115,6 +115,29 @@ static void get_username_test(const void *data)
 	assert(strcmp(test, "username") =3D=3D 0);
 }
 =

+static void test_is_bit_field_set(const void *data)
+{
+	uint8_t field[8] =3D { 0 };
+
+	field[4] =3D (1 << 7) | (1 << 3);
+	field[0] =3D (1 << 0);
+	field[7] =3D (1 << 7);
+
+	/* test first and last bit */
+	assert(util_is_field_bit_set(field, 0));
+	assert(util_is_field_bit_set(field, 63));
+
+	/* 4th byte 7th bit =3D 39th bit */
+	assert(!util_is_field_bit_set(field, 38));
+	assert(util_is_field_bit_set(field, 39));
+	assert(!util_is_field_bit_set(field, 40));
+
+	/* 4th byte 3rd bit =3D 35th bit */
+	assert(!util_is_field_bit_set(field, 34));
+	assert(util_is_field_bit_set(field, 35));
+	assert(!util_is_field_bit_set(field, 46));
+}
+
 int main(int argc, char *argv[])
 {
 	l_test_init(&argc, &argv);
@@ -122,6 +145,7 @@ int main(int argc, char *argv[])
 	l_test_add("/util/ssid_to_utf8/", ssid_to_utf8, ssid_samples);
 	l_test_add("/util/get_domain/", get_domain_test, NULL);
 	l_test_add("/util/get_username/", get_username_test, NULL);
+	l_test_add("/util/is_field_bit_set/", test_is_bit_field_set, NULL);
 =

 	return l_test_run();
 }
-- =

2.17.1

--===============1726740597770168025==--

