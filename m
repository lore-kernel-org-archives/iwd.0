Content-Type: multipart/mixed; boundary="===============3746017126577468336=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 4/6] band: move several scan utilities into band
Date: Mon, 29 Nov 2021 15:12:58 -0800
Message-ID: <20211129231300.108873-4-prestwoj@gmail.com>
In-Reply-To: 20211129231300.108873-1-prestwoj@gmail.com

--===============3746017126577468336==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will allow unit testing modules which depend on these
APIs:

scan_channel_to_freq
scan_freq_to_channel
scan_oper_class_to_band
---
 src/band.c | 193 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/band.h |  10 +++
 2 files changed, 203 insertions(+)

diff --git a/src/band.c b/src/band.c
index b1932f0b..4d9624f1 100644
--- a/src/band.c
+++ b/src/band.c
@@ -923,3 +923,196 @@ int oci_from_chandef(const struct band_chandef *own, =
uint8_t oci[static 3])
 =

 	return -ENOENT;
 }
+
+uint8_t band_freq_to_channel(uint32_t freq, enum band_freq *out_band)
+{
+	uint32_t channel =3D 0;
+
+	if (freq >=3D 2412 && freq <=3D 2484) {
+		if (freq =3D=3D 2484)
+			channel =3D 14;
+		else {
+			channel =3D freq - 2407;
+
+			if (channel % 5)
+				return 0;
+
+			channel /=3D 5;
+		}
+
+		if (out_band)
+			*out_band =3D BAND_FREQ_2_4_GHZ;
+
+		return channel;
+	}
+
+	if (freq >=3D 5005 && freq < 5900) {
+		if (freq % 5)
+			return 0;
+
+		channel =3D (freq - 5000) / 5;
+
+		if (out_band)
+			*out_band =3D BAND_FREQ_5_GHZ;
+
+		return channel;
+	}
+
+	if (freq >=3D 4905 && freq < 5000) {
+		if (freq % 5)
+			return 0;
+
+		channel =3D (freq - 4000) / 5;
+
+		if (out_band)
+			*out_band =3D BAND_FREQ_5_GHZ;
+
+		return channel;
+	}
+
+	return 0;
+}
+
+uint32_t band_channel_to_freq(uint8_t channel, enum band_freq band)
+{
+	if (band =3D=3D BAND_FREQ_2_4_GHZ) {
+		if (channel >=3D 1 && channel <=3D 13)
+			return 2407 + 5 * channel;
+
+		if (channel =3D=3D 14)
+			return 2484;
+	}
+
+	if (band =3D=3D BAND_FREQ_5_GHZ) {
+		if (channel >=3D 1 && channel <=3D 179)
+			return 5000 + 5 * channel;
+
+		if (channel >=3D 181 && channel <=3D 199)
+			return 4000 + 5 * channel;
+	}
+
+	return 0;
+}
+
+static const char *const oper_class_us_codes[] =3D {
+	"US", "CA"
+};
+
+static const char *const oper_class_eu_codes[] =3D {
+	"AL", "AM", "AT", "AZ", "BA", "BE", "BG", "BY", "CH", "CY", "CZ", "DE",
+	"DK", "EE", "EL", "ES", "FI", "FR", "GE", "HR", "HU", "IE", "IS", "IT",
+	"LI", "LT", "LU", "LV", "MD", "ME", "MK", "MT", "NL", "NO", "PL", "PT",
+	"RO", "RS", "RU", "SE", "SI", "SK", "TR", "UA", "UK"
+};
+
+/* Annex E, table E-1 */
+static const uint8_t oper_class_us_to_global[] =3D {
+	[1]  =3D 115, [2]  =3D 118, [3]  =3D 124, [4]  =3D 121,
+	[5]  =3D 125, [6]  =3D 103, [7]  =3D 103, [8]  =3D 102,
+	[9]  =3D 102, [10] =3D 101, [11] =3D 101, [12] =3D 81,
+	[13] =3D 94,  [14] =3D 95,  [15] =3D 96,  [22] =3D 116,
+	[23] =3D 119, [24] =3D 122, [25] =3D 126, [26] =3D 126,
+	[27] =3D 117, [28] =3D 120, [29] =3D 123, [30] =3D 127,
+	[31] =3D 127, [32] =3D 83,  [33] =3D 84,  [34] =3D 180,
+	/* 128 - 130 is a 1 to 1 mapping */
+};
+
+/* Annex E, table E-2 */
+static const uint8_t oper_class_eu_to_global[] =3D {
+	[1]  =3D 115, [2]  =3D 118, [3]  =3D 121, [4]  =3D 81,
+	[5]  =3D 116, [6]  =3D 119, [7]  =3D 122, [8]  =3D 117,
+	[9]  =3D 120, [10] =3D 123, [11] =3D 83,  [12] =3D 84,
+	[17] =3D 125, [18] =3D 130,
+	/* 128 - 130 is a 1 to 1 mapping */
+};
+
+/* Annex E, table E-3 */
+static const uint8_t oper_class_jp_to_global[] =3D {
+	[1]  =3D 115, [2]  =3D 112, [3]  =3D 112, [4]  =3D 112,
+	[5]  =3D 112, [6]  =3D 112, [7]  =3D 109, [8]  =3D 109,
+	[9]  =3D 109, [10] =3D 109, [11] =3D 109, [12] =3D 113,
+	[13] =3D 113, [14] =3D 113, [15] =3D 113, [16] =3D 110,
+	[17] =3D 110, [18] =3D 110, [19] =3D 110, [20] =3D 110,
+	[21] =3D 114, [22] =3D 114, [23] =3D 114, [24] =3D 114,
+	[25] =3D 111, [26] =3D 111, [27] =3D 111, [28] =3D 111,
+	[29] =3D 111, [30] =3D 81,  [31] =3D 82,  [32] =3D 118,
+	[33] =3D 118, [34] =3D 121, [35] =3D 121, [36] =3D 116,
+	[37] =3D 119, [38] =3D 119, [39] =3D 122, [40] =3D 122,
+	[41] =3D 117, [42] =3D 120, [43] =3D 120, [44] =3D 123,
+	[45] =3D 123, [46] =3D 104, [47] =3D 104, [48] =3D 104,
+	[49] =3D 104, [50] =3D 104, [51] =3D 105, [52] =3D 105,
+	[53] =3D 105, [54] =3D 105, [55] =3D 105, [56] =3D 83,
+	[57] =3D 84,  [58] =3D 121, [59] =3D 180,
+	/* 128 - 130 is a 1 to 1 mapping */
+};
+
+/* Annex E, table E-4 (only 2.4GHz and 4.9 / 5GHz bands) */
+static const enum band_freq oper_class_to_band_global[] =3D {
+	[81 ... 84]   =3D BAND_FREQ_2_4_GHZ,
+	[104 ... 130] =3D BAND_FREQ_5_GHZ,
+};
+
+/* Annex E, table E-5 */
+static const uint8_t oper_class_cn_to_global[] =3D {
+	[1]  =3D 115, [2]  =3D 118, [3]  =3D 125, [4]  =3D 116,
+	[5]  =3D 119, [6]  =3D 126, [7]  =3D 81,  [8]  =3D 83,
+	[9]  =3D 84,
+	/* 128 - 130 is a 1 to 1 mapping */
+};
+
+enum band_freq band_oper_class_to_band(const uint8_t *country,
+					uint8_t oper_class)
+{
+	unsigned int i;
+	int table =3D 0;
+
+	if (country && country[2] >=3D 1 && country[2] <=3D 5)
+		table =3D country[2];
+	else if (country) {
+		for (i =3D 0; i < L_ARRAY_SIZE(oper_class_us_codes); i++)
+			if (!memcmp(oper_class_us_codes[i], country, 2)) {
+				/* Use table E-1 */
+				table =3D 1;
+				break;
+			}
+
+		for (i =3D 0; i < L_ARRAY_SIZE(oper_class_eu_codes); i++)
+			if (!memcmp(oper_class_eu_codes[i], country, 2)) {
+				/* Use table E-2 */
+				table =3D 2;
+				break;
+			}
+
+		if (!memcmp("JP", country, 2))
+			/* Use table E-3 */
+			table =3D 3;
+
+		if (!memcmp("CN", country, 2))
+			/* Use table E-5 */
+			table =3D 5;
+	}
+
+	switch (table) {
+	case 1:
+		if (oper_class < L_ARRAY_SIZE(oper_class_us_to_global))
+			oper_class =3D oper_class_us_to_global[oper_class];
+		break;
+	case 2:
+		if (oper_class < L_ARRAY_SIZE(oper_class_eu_to_global))
+			oper_class =3D oper_class_eu_to_global[oper_class];
+		break;
+	case 3:
+		if (oper_class < L_ARRAY_SIZE(oper_class_jp_to_global))
+			oper_class =3D oper_class_jp_to_global[oper_class];
+		break;
+	case 5:
+		if (oper_class < L_ARRAY_SIZE(oper_class_cn_to_global))
+			oper_class =3D oper_class_cn_to_global[oper_class];
+		break;
+	}
+
+	if (oper_class < L_ARRAY_SIZE(oper_class_to_band_global))
+		return oper_class_to_band_global[oper_class];
+	else
+		return 0;
+}
diff --git a/src/band.h b/src/band.h
index 1bb5af8e..2320bbcf 100644
--- a/src/band.h
+++ b/src/band.h
@@ -36,6 +36,11 @@ enum band_chandef_width {
 	BAND_CHANDEF_WIDTH_160,
 };
 =

+enum band_freq {
+	BAND_FREQ_2_4_GHZ =3D 0x1,
+	BAND_FREQ_5_GHZ =3D 0x2,
+};
+
 struct band_chandef {
 	uint32_t frequency;
 	uint32_t channel_width;
@@ -76,3 +81,8 @@ int oci_to_frequency(uint32_t operating_class, uint32_t c=
hannel);
 =

 int oci_verify(const uint8_t oci[static 3], const struct band_chandef *own=
);
 int oci_from_chandef(const struct band_chandef *own, uint8_t oci[static 3]=
);
+
+uint8_t band_freq_to_channel(uint32_t freq, enum band_freq *out_band);
+uint32_t band_channel_to_freq(uint8_t channel, enum band_freq band);
+enum band_freq band_oper_class_to_band(const uint8_t *country,
+					uint8_t oper_class);
-- =

2.31.1

--===============3746017126577468336==--

