Content-Type: multipart/mixed; boundary="===============7124374782375953744=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 03/10] unit: add DPP unit tests for URI parsing
Date: Mon, 14 Feb 2022 13:48:02 -0800
Message-ID: <20220214214809.1017870-3-prestwoj@gmail.com>
In-Reply-To: 20220214214809.1017870-1-prestwoj@gmail.com

--===============7124374782375953744==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-dpp.c | 142 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/unit/test-dpp.c b/unit/test-dpp.c
index bfe6f747..1803e688 100644
--- a/unit/test-dpp.c
+++ b/unit/test-dpp.c
@@ -33,6 +33,134 @@
 #include "src/util.h"
 #include "ell/useful.h"
 =

+struct dpp_test_info {
+	const char *uri;
+	bool expect_fail;
+	uint32_t expected_freqs[10];
+	struct dpp_uri_info result;
+};
+
+struct dpp_test_info all_values =3D {
+	.uri =3D "DPP:C:81/1,115/36;I:SN=3D4774LH2b4044;M:5254005828e5;V:2;K:MDkw=
EwYHKoZIzj0CAQYIKoZIzj0DAQcDIgADURzxmttZoIRIPWGoQMV00XHWCAQIhXruVWOz0NjlkIA=
=3D;;",
+	.result =3D {
+		.mac =3D { 0x52, 0x54, 0x00, 0x58, 0x28, 0xe5 },
+		.version =3D 2,
+	},
+	.expected_freqs =3D { 2412, 5180, 0 }
+};
+
+struct dpp_test_info no_type =3D {
+	.uri =3D "C:81/1;K:shouldnotmatter;;",
+	.expect_fail =3D true
+};
+
+struct dpp_test_info empty =3D {
+	.uri =3D "DPP:",
+	.expect_fail =3D true
+};
+
+struct dpp_test_info no_key =3D {
+	.uri =3D "DPP:C:81/1,115/36;I:SN=3D4774LH2b4044;M:5254005828e5;V:2;;",
+	.expect_fail =3D true
+};
+
+struct dpp_test_info data_after_terminator =3D {
+	.uri =3D "DPP:K:MDkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDIgADURzxmttZoIRIPWGoQMV00=
XHWCAQIhXruVWOz0NjlkIA=3D;;C:81/1;;",
+	.expect_fail =3D true
+};
+
+struct dpp_test_info single_terminator =3D {
+	.uri =3D "DPP:K:MDkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDIgADURzxmttZoIRIPWGoQMV00=
XHWCAQIhXruVWOz0NjlkIA=3D;",
+	.expect_fail =3D true
+};
+
+struct dpp_test_info no_terminator =3D {
+	.uri =3D "DPP:K:MDkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDIgADURzxmttZoIRIPWGoQMV00=
XHWCAQIhXruVWOz0NjlkIA=3D",
+	.expect_fail =3D true
+};
+
+struct dpp_test_info bad_key =3D {
+	.uri =3D "DPP:K:MDkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDIgADURzxmttZoIRIPWGoQMV00=
XHWCAQIhXruVWOz0;;",
+	.expect_fail =3D true
+};
+
+struct dpp_test_info unexpected_id =3D {
+	.uri =3D "DPP:Z:somedata;K:MDkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDIgADURzxmttZoI=
RIPWGoQMV00XHWCAQIhXruVWOz0NjlkIA=3D;;",
+	.expect_fail =3D true
+};
+
+struct dpp_test_info bad_channels[] =3D {
+	{
+		.uri =3D "DPP:C:;K:MDkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDIgADURzxmttZoIRIPWGoQ=
MV00XHWCAQIhXruVWOz0NjlkIA=3D;;",
+		.expect_fail =3D true
+	},
+	{
+		.uri =3D "DPP:C:81;K:MDkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDIgADURzxmttZoIRIPWG=
oQMV00XHWCAQIhXruVWOz0NjlkIA=3D;;",
+		.expect_fail =3D true
+	},
+	{
+		.uri =3D "DPP:C:81/;K:MDkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDIgADURzxmttZoIRIPW=
GoQMV00XHWCAQIhXruVWOz0NjlkIA=3D;;",
+		.expect_fail =3D true
+	},
+	{
+		.uri =3D "DPP:C:81/1,;K:MDkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDIgADURzxmttZoIRI=
PWGoQMV00XHWCAQIhXruVWOz0NjlkIA=3D;;",
+		.expect_fail =3D true
+	},
+	{
+		.uri =3D "DPP:C:81/1,81/;K:MDkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDIgADURzxmttZo=
IRIPWGoQMV00XHWCAQIhXruVWOz0NjlkIA=3D;;",
+		.expect_fail =3D true
+	},
+	{
+		.uri =3D "DPP:C:81/1,/;K:MDkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDIgADURzxmttZoIR=
IPWGoQMV00XHWCAQIhXruVWOz0NjlkIA=3D;;",
+		.expect_fail =3D true
+	},
+};
+
+static bool verify_info(const struct dpp_uri_info *parsed,
+			const struct dpp_test_info *result)
+{
+	const struct dpp_uri_info *expected =3D &result->result;
+	uint32_t i;
+
+	assert(!memcmp(parsed->mac, expected->mac, 6));
+	assert(parsed->version =3D=3D expected->version);
+	assert(parsed->boot_public !=3D NULL);
+
+	for (i =3D 0; result->expected_freqs[i]; i++)
+		assert(scan_freq_set_contains(parsed->freqs,
+						result->expected_freqs[i]));
+
+	return true;
+}
+
+static void test_uri_parse(const void *data)
+{
+	const struct dpp_test_info *test_info =3D data;
+	struct dpp_uri_info *info;
+	int ret;
+
+	info =3D dpp_parse_uri(test_info->uri);
+	if (test_info->expect_fail) {
+		assert(info =3D=3D NULL);
+		return;
+	}
+
+	assert(ret =3D=3D 0);
+
+	assert(verify_info(info, test_info));
+
+	dpp_free_uri_info(info);
+}
+
+
+static void test_bad_channels(const void *data)
+{
+	unsigned int i;
+
+	for (i =3D 0; i < L_ARRAY_SIZE(bad_channels); i++)
+		test_uri_parse(&bad_channels[i]);
+}
+
 /*
  * B.2 Test Vectors for DPP Authentication Using P-256 for
  * Responder-only Authentication
@@ -148,5 +276,19 @@ int main(int argc, char *argv[])
 		l_test_add("DPP test key derivation",
 						test_key_derivation, NULL);
 =

+	l_test_add("DPP URI parse", test_uri_parse, &all_values);
+	l_test_add("DPP URI no type", test_uri_parse, &no_type);
+	l_test_add("DPP URI empty", test_uri_parse, &empty);
+	l_test_add("DPP URI no key", test_uri_parse, &no_key);
+	l_test_add("DPP URI data after terminator", test_uri_parse,
+				&data_after_terminator);
+	l_test_add("DPP URI single terminator", test_uri_parse,
+				&single_terminator);
+	l_test_add("DPP URI no terminator", test_uri_parse,
+				&no_terminator);
+	l_test_add("DPP URI bad key", test_uri_parse, &bad_key);
+	l_test_add("DPP URI bad channels", test_bad_channels, &bad_channels);
+	l_test_add("DPP URI unexpected ID", test_uri_parse, &unexpected_id);
+
 	return l_test_run();
 }
-- =

2.34.1

--===============7124374782375953744==--

