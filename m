Content-Type: multipart/mixed; boundary="===============1959896235584730583=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 3/3] station: enforce MFPR=1 for 6GHz frequencies
Date: Fri, 25 Feb 2022 14:03:38 -0800
Message-ID: <20220225220338.2942516-3-prestwoj@gmail.com>
In-Reply-To: 20220225220338.2942516-1-prestwoj@gmail.com

--===============1959896235584730583==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds checks if MFP is set to 0 or 1:

0 - Always fail if the frequency is 6GHz
1 - Fail if MFPC=3D0 and the frequency is 6GHz.
    If HW is capable set MFPR=3D1 for 6GHz
---
 src/station.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index dd924c00..a0e95cb7 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1012,9 +1012,13 @@ static int station_build_handshake_rsn(struct handsh=
ake_state *hs,
 	struct ie_rsn_info info;
 	uint8_t *ap_ie;
 	bool disable_ocv;
+	enum band_freq band;
 =

 	memset(&info, 0, sizeof(info));
 =

+	if (!band_freq_to_channel(bss->frequency, &band))
+		goto not_supported;
+
 	memset(&bss_info, 0, sizeof(bss_info));
 	scan_bss_get_rsn_info(bss, &bss_info);
 =

@@ -1061,12 +1065,31 @@ static int station_build_handshake_rsn(struct hands=
hake_state *hs,
 =

 	switch (mfp_setting) {
 	case 0:
-		break;
+		if (band !=3D BAND_FREQ_6_GHZ)
+			break;
+
+		l_error("MFP turned off by [General].ManagementFrameProtection,"
+				" 6GHz frequencies are disabled");
+		goto not_supported;
 	case 1:
 		info.group_management_cipher =3D
 			wiphy_select_cipher(wiphy,
 				bss_info.group_management_cipher);
 		info.mfpc =3D info.group_management_cipher !=3D 0;
+
+		if (band !=3D BAND_FREQ_6_GHZ)
+			break;
+
+		if (!info.mfpc)
+			goto not_supported;
+
+		/*
+		 * 802.11ax Section 12.12.2
+		 * The STA shall use management frame protection
+		 * (MFPR=3D1) when using RSN.
+		 */
+		info.mfpr =3D true;
+
 		break;
 	case 2:
 		info.group_management_cipher =3D
-- =

2.34.1

--===============1959896235584730583==--

