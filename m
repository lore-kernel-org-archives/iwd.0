Content-Type: multipart/mixed; boundary="===============5484389195524458671=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 03/11] band: add BAND_FREQ_6_GHZ
Date: Fri, 25 Feb 2022 09:58:02 -0800
Message-ID: <20220225175810.2914413-3-prestwoj@gmail.com>
In-Reply-To: 20220225175810.2914413-1-prestwoj@gmail.com

--===============5484389195524458671==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a new band defined in the WiFi 6E (ax) amendment. A completely
new value is needed due to channel reuse between 2.4/5 and 6GHz.

util.c needed minimal updating to prevent compile errors which will
be fixed later to actually handle this band. WSC also needed a case
added for 6GHz but the spec does not outline any RF Band value for
6GHz so the 5GHz value will be returned in this case.
---
 src/band.c | 3 ++-
 src/band.h | 1 +
 src/util.c | 4 ++++
 src/wsc.c  | 1 +
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/band.c b/src/band.c
index 053f85d6..1eb94586 100644
--- a/src/band.c
+++ b/src/band.c
@@ -1092,10 +1092,11 @@ static const uint8_t oper_class_jp_to_global[] =3D {
 	/* 128 - 130 is a 1 to 1 mapping */
 };
 =

-/* Annex E, table E-4 (only 2.4GHz and 4.9 / 5GHz bands) */
+/* Annex E, table E-4 (only 2.4GHz, 4.9 / 5GHz, and 6GHz bands) */
 static const enum band_freq oper_class_to_band_global[] =3D {
 	[81 ... 84]   =3D BAND_FREQ_2_4_GHZ,
 	[104 ... 130] =3D BAND_FREQ_5_GHZ,
+	[131 ... 136] =3D BAND_FREQ_6_GHZ,
 };
 =

 /* Annex E, table E-5 */
diff --git a/src/band.h b/src/band.h
index 2320bbcf..7b9e901f 100644
--- a/src/band.h
+++ b/src/band.h
@@ -39,6 +39,7 @@ enum band_chandef_width {
 enum band_freq {
 	BAND_FREQ_2_4_GHZ =3D 0x1,
 	BAND_FREQ_5_GHZ =3D 0x2,
+	BAND_FREQ_6_GHZ =3D 0x4,
 };
 =

 struct band_chandef {
diff --git a/src/util.c b/src/util.c
index 20e179a6..16df59ac 100644
--- a/src/util.c
+++ b/src/util.c
@@ -347,6 +347,8 @@ bool scan_freq_set_add(struct scan_freq_set *freqs, uin=
t32_t freq)
 		return true;
 	case BAND_FREQ_5_GHZ:
 		return l_uintset_put(freqs->channels_5ghz, channel);
+	case BAND_FREQ_6_GHZ:
+		return false;
 	}
 =

 	return false;
@@ -366,6 +368,8 @@ bool scan_freq_set_contains(const struct scan_freq_set =
*freqs, uint32_t freq)
 		return freqs->channels_2ghz & (1 << (channel - 1));
 	case BAND_FREQ_5_GHZ:
 		return l_uintset_contains(freqs->channels_5ghz, channel);
+	case BAND_FREQ_6_GHZ:
+		return false;
 	}
 =

 	return false;
diff --git a/src/wsc.c b/src/wsc.c
index 0457ebf7..bb9f663b 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -308,6 +308,7 @@ static inline enum wsc_rf_band freq_to_rf_band(uint32_t=
 freq)
 	case BAND_FREQ_2_4_GHZ:
 		return WSC_RF_BAND_2_4_GHZ;
 	case BAND_FREQ_5_GHZ:
+	case BAND_FREQ_6_GHZ:
 		return WSC_RF_BAND_5_0_GHZ;
 	}
 =

-- =

2.34.1

--===============5484389195524458671==--

