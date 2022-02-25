Content-Type: multipart/mixed; boundary="===============6894851324600956675=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 01/11] band: add operating clases for 802.11ax
Date: Fri, 25 Feb 2022 09:58:00 -0800
Message-ID: <20220225175810.2914413-1-prestwoj@gmail.com>

--===============6894851324600956675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Obtained from the IEEE 802.11ax amendment, Table E-4
---
 src/band.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 55 insertions(+), 8 deletions(-)

diff --git a/src/band.c b/src/band.c
index 9024d186..28ba6a62 100644
--- a/src/band.c
+++ b/src/band.c
@@ -489,8 +489,8 @@ static int band_channel_info_get_bandwidth(const struct=
 band_chandef *info)
 struct operating_class_info {
 	uint32_t starting_frequency;
 	uint32_t flags;
-	uint8_t channel_set[20];
-	uint8_t center_frequencies[8];
+	uint8_t channel_set[60];
+	uint8_t center_frequencies[30];
 	uint16_t channel_spacing;
 	uint8_t operating_class;
 };
@@ -598,20 +598,20 @@ static const struct operating_class_info e4_operating=
_classes[] =3D {
 	{
 		.operating_class =3D 125,
 		.starting_frequency =3D 5000,
-		.channel_set =3D { 149, 153, 157, 161, 165, 169, 173},
+		.channel_set =3D { 149, 153, 157, 161, 165, 169, 173, 177 },
 		.channel_spacing =3D 20,
 	},
 	{
 		.operating_class =3D 126,
 		.starting_frequency =3D 5000,
-		.channel_set =3D { 149, 157, 165},
+		.channel_set =3D { 149, 157, 165, 173 },
 		.channel_spacing =3D 40,
 		.flags =3D PRIMARY_CHANNEL_LOWER,
 	},
 	{
 		.operating_class =3D 127,
 		.starting_frequency =3D 5000,
-		.channel_set =3D { 153, 161, 169 },
+		.channel_set =3D { 153, 161, 169, 177 },
 		.channel_spacing =3D 40,
 		.flags =3D PRIMARY_CHANNEL_UPPER,
 	},
@@ -619,21 +619,68 @@ static const struct operating_class_info e4_operating=
_classes[] =3D {
 		.operating_class =3D 128,
 		.starting_frequency =3D 5000,
 		.channel_spacing =3D 80,
-		.center_frequencies =3D { 42, 58, 106, 122, 138, 155 },
+		.center_frequencies =3D { 42, 58, 106, 122, 138, 155, 171 },
 	},
 	{
 		.operating_class =3D 129,
 		.starting_frequency =3D 5000,
 		.channel_spacing =3D 160,
-		.center_frequencies =3D { 50, 114 },
+		.center_frequencies =3D { 50, 114, 163 },
 	},
 	{
 		.operating_class =3D 130,
 		.starting_frequency =3D 5000,
 		.channel_spacing =3D 80,
-		.center_frequencies =3D { 42, 58, 106, 122, 138, 155 },
+		.center_frequencies =3D { 42, 58, 106, 122, 138, 155, 171 },
 		.flags =3D PLUS80,
 	},
+	{
+		.operating_class =3D 131,
+		.starting_frequency =3D 5950,
+		.channel_spacing =3D 20,
+		.channel_set =3D { 1, 5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45,
+				49, 53, 57, 61, 65, 69, 73, 77, 81, 85, 89, 93,
+				97, 101, 105, 109, 113, 117, 121, 125, 129, 133,
+				137, 141, 145, 149, 153, 157, 161, 165, 169,
+				173, 177, 181, 185, 189, 193, 197, 201, 205,
+				209, 213, 217, 221, 225, 229, 233 },
+	},
+	{
+		.operating_class =3D 132,
+		.starting_frequency =3D 5950,
+		.channel_spacing =3D 40,
+		.center_frequencies =3D { 3, 11, 19, 27, 35, 43, 51, 59, 67, 75,
+					83, 91, 99, 107, 115, 123, 131, 139,
+					147, 155, 163, 171, 179, 187, 195, 203,
+					211, 219, 227 },
+	},
+	{
+		.operating_class =3D 133,
+		.starting_frequency =3D 5950,
+		.channel_spacing =3D 80,
+		.center_frequencies =3D { 7, 23, 39, 55, 71, 87, 103, 119, 135,
+					151, 167, 183, 199, 215 },
+	},
+	{
+		.operating_class =3D 134,
+		.starting_frequency =3D 5950,
+		.channel_spacing =3D 160,
+		.center_frequencies =3D { 15, 47, 79, 111, 143, 175, 207 },
+	},
+	{
+		.operating_class =3D 135,
+		.starting_frequency =3D 5950,
+		.channel_spacing =3D 80,
+		.center_frequencies =3D { 7, 23, 39, 55, 71, 87, 102, 119, 135,
+					151, 167, 183, 199, 215 },
+		.flags =3D PLUS80,
+	},
+	{
+		.operating_class =3D 136,
+		.starting_frequency =3D 5950,
+		.channel_spacing =3D 20,
+		.center_frequencies =3D { 2 },
+	}
 };
 =

 static const struct operating_class_info *e4_find_opclass(uint32_t opclass)
-- =

2.34.1

--===============6894851324600956675==--

