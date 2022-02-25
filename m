Content-Type: multipart/mixed; boundary="===============4896603383194475946=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 09/11] unit: add band tests for 6GHz
Date: Fri, 25 Feb 2022 09:58:08 -0800
Message-ID: <20220225175810.2914413-9-prestwoj@gmail.com>
In-Reply-To: 20220225175810.2914413-1-prestwoj@gmail.com

--===============4896603383194475946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Tests that all valid channels/frequencies can be computed as well
as oci_verify maps each new operating class to the correct chandef.
---
 unit/test-band.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/unit/test-band.c b/unit/test-band.c
index 0de1fdee..757db377 100644
--- a/unit/test-band.c
+++ b/unit/test-band.c
@@ -331,6 +331,33 @@ static const struct band_chandef cd_4 =3D {
 	.center1_frequency =3D 2427,
 };
 =

+static const struct band_chandef cd_5 =3D {
+	.frequency =3D 6235,
+	.channel_width =3D BAND_CHANDEF_WIDTH_20,
+};
+
+static const struct band_chandef cd_6 =3D {
+	.frequency =3D 6235,
+	.channel_width =3D  BAND_CHANDEF_WIDTH_40,
+};
+
+static const struct band_chandef cd_7 =3D {
+	.frequency =3D 6235,
+	.channel_width =3D  BAND_CHANDEF_WIDTH_80,
+};
+
+static const struct band_chandef cd_8 =3D {
+	.frequency =3D 6235,
+	.channel_width =3D  BAND_CHANDEF_WIDTH_160,
+};
+
+static const struct band_chandef cd_9 =3D {
+	.frequency =3D 6235,
+	.channel_width =3D  BAND_CHANDEF_WIDTH_80P80,
+	.center1_frequency =3D 6145,
+	.center2_frequency =3D 6225,
+};
+
 struct oci_data {
 	const struct band_chandef *cd;
 	uint8_t oci[3];
@@ -341,6 +368,11 @@ static const struct oci_data oci_data_1 =3D { &cd_1, {=
 129, 108, 0 } };
 static const struct oci_data oci_data_2 =3D { &cd_2, { 130, 36, 155 } };
 static const struct oci_data oci_data_3 =3D { &cd_3, { 81, 6, 0 } };
 static const struct oci_data oci_data_4 =3D { &cd_4, { 84, 6, 0 } };
+static const struct oci_data oci_data_5 =3D { &cd_5, { 131, 57, 0 } };
+static const struct oci_data oci_data_6 =3D { &cd_6, { 132, 57, 0 } };
+static const struct oci_data oci_data_7 =3D { &cd_7, { 133, 57, 0 } };
+static const struct oci_data oci_data_8 =3D { &cd_8, { 134, 57, 0 } };
+static const struct oci_data oci_data_9 =3D { &cd_9, { 135, 57, 55 } };
 =

 static const struct oci_data oci_err_1 =3D { &cd_1, { 129, 36, 0 }, -EPERM=
 };
 static const struct oci_data oci_err_2 =3D { &cd_1, { 121, 108, 0 }, -EPER=
M };
@@ -372,6 +404,26 @@ static void test_oci_from_chandef(const void *data)
 	assert(!memcmp(oci, test->oci, sizeof(oci)));
 }
 =

+static void test_6ghz_channels(const void *data)
+{
+	unsigned int i;
+
+	/* Test all channels for 6GHz */
+	for (i =3D 1; i <=3D 233; i +=3D 4)
+		assert(band_channel_to_freq(i, BAND_FREQ_6_GHZ) !=3D 0);
+}
+
+static void test_6ghz_freqs(const void *data)
+{
+	uint32_t i;
+	enum band_freq band;
+
+	for (i =3D 5955; i < 7115; i +=3D 5) {
+		assert(band_freq_to_channel(i, &band) !=3D 0);
+		assert(band =3D=3D BAND_FREQ_6_GHZ);
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	l_test_init(&argc, &argv);
@@ -395,6 +447,11 @@ int main(int argc, char *argv[])
 	l_test_add("/band/oci/verify 2", test_oci_verify, &oci_data_2);
 	l_test_add("/band/oci/verify 3", test_oci_verify, &oci_data_3);
 	l_test_add("/band/oci/verify 4", test_oci_verify, &oci_data_4);
+	l_test_add("/band/oci/verify 5", test_oci_verify, &oci_data_5);
+	l_test_add("/band/oci/verify 6", test_oci_verify, &oci_data_6);
+	l_test_add("/band/oci/verify 7", test_oci_verify, &oci_data_7);
+	l_test_add("/band/oci/verify 8", test_oci_verify, &oci_data_8);
+	l_test_add("/band/oci/verify 9", test_oci_verify, &oci_data_9);
 =

 	l_test_add("/band/oci/noverify 1", test_oci_verify, &oci_err_1);
 	l_test_add("/band/oci/noverify 2", test_oci_verify, &oci_err_2);
@@ -410,5 +467,8 @@ int main(int argc, char *argv[])
 	l_test_add("/band/oci/chandef 3", test_oci_from_chandef, &oci_data_3);
 	l_test_add("/band/oci/chandef 4", test_oci_from_chandef, &oci_data_4);
 =

+	l_test_add("/band/6ghz/channels", test_6ghz_channels, NULL);
+	l_test_add("/band/6ghz/freq", test_6ghz_freqs, NULL);
+
 	return l_test_run();
 }
-- =

2.34.1

--===============4896603383194475946==--

