Content-Type: multipart/mixed; boundary="===============8570349983575471125=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/2] unit: update test-ie with supported rates
Date: Fri, 14 May 2021 12:22:53 -0700
Message-ID: <20210514192253.454140-2-prestwoj@gmail.com>
In-Reply-To: <20210514192253.454140-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8570349983575471125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For now this just tests supported rates with a zero length
IE.
---
 unit/test-ie.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/unit/test-ie.c b/unit/test-ie.c
index 6dd074b5..93a4f9ca 100644
--- a/unit/test-ie.c
+++ b/unit/test-ie.c
@@ -692,6 +692,22 @@ static void ie_test_encapsulate_wsc(const void *data)
 	l_free(packed);
 }
 =

+static void ie_test_supported_rates(const void *data)
+{
+	const uint8_t zero_len_supp[] =3D { IE_TYPE_SUPPORTED_RATES, 0 };
+	const uint8_t zero_len_ext_supp[] =3D { IE_TYPE_EXTENDED_SUPPORTED_RATES,
+						0 };
+	int ret;
+
+	ret =3D ie_parse_data_rates(zero_len_supp, NULL, NULL, NULL,
+					-70, NULL);
+	assert(ret =3D=3D -EINVAL);
+
+	ret =3D ie_parse_data_rates(NULL, zero_len_ext_supp, NULL, NULL,
+					-70, NULL);
+	assert(ret =3D=3D -EINVAL);
+}
+
 int main(int argc, char *argv[])
 {
 	l_test_init(&argc, &argv);
@@ -752,6 +768,8 @@ int main(int argc, char *argv[])
 	l_test_add("/ie/Encapsulation/WSC/Test Case 1",
 				ie_test_encapsulate_wsc,
 				&ie_tlv_concat_test_data_1);
+	l_test_add("/ie/Supported rates/Test Case 1", ie_test_supported_rates,
+				NULL);
 =

 	return l_test_run();
 }
-- =

2.31.1

--===============8570349983575471125==--

