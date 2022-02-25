Content-Type: multipart/mixed; boundary="===============7213917303260180131=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 04/11] band: add 6GHz support to {channel, freq}_to_{freq,
 channel}
Date: Fri, 25 Feb 2022 09:58:03 -0800
Message-ID: <20220225175810.2914413-4-prestwoj@gmail.com>
In-Reply-To: 20220225175810.2914413-1-prestwoj@gmail.com

--===============7213917303260180131==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adds support for the channels and frequencies defined in the
802.11ax spec.
---
 src/band.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/src/band.c b/src/band.c
index 1eb94586..87b70d42 100644
--- a/src/band.c
+++ b/src/band.c
@@ -1016,6 +1016,25 @@ uint8_t band_freq_to_channel(uint32_t freq, enum ban=
d_freq *out_band)
 		return channel;
 	}
 =

+	if (freq > 5950 && freq <=3D 7115) {
+		if (freq % 5)
+			return 0;
+
+		channel =3D (freq - 5950) / 5;
+
+		if (out_band)
+			*out_band =3D BAND_FREQ_6_GHZ;
+
+		return channel;
+	}
+
+	if (freq =3D=3D 5935) {
+		if (out_band)
+			*out_band =3D BAND_FREQ_6_GHZ;
+
+		return 2;
+	}
+
 	return 0;
 }
 =

@@ -1037,6 +1056,22 @@ uint32_t band_channel_to_freq(uint8_t channel, enum =
band_freq band)
 			return 4000 + 5 * channel;
 	}
 =

+	if (band =3D=3D BAND_FREQ_6_GHZ) {
+		/* operating class 136 */
+		if (channel =3D=3D 2)
+			return 5935;
+
+		/* Channels increment by 4, starting with 1 */
+		if (channel % 4 !=3D 1)
+			return 0;
+
+		if (channel < 1 || channel > 233)
+			return 0;
+
+		/* operating classes 131, 132, 133, 134, 135 */
+		return 5950 + 5 * channel;
+	}
+
 	return 0;
 }
 =

-- =

2.34.1

--===============7213917303260180131==--

