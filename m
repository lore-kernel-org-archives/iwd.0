Content-Type: multipart/mixed; boundary="===============6792075669416263377=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 02/11] band: remove unneeded line break
Date: Fri, 25 Feb 2022 09:58:01 -0800
Message-ID: <20220225175810.2914413-2-prestwoj@gmail.com>
In-Reply-To: 20220225175810.2914413-1-prestwoj@gmail.com

--===============6792075669416263377==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This fits within 80 characters
---
 src/band.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/band.c b/src/band.c
index 28ba6a62..053f85d6 100644
--- a/src/band.c
+++ b/src/band.c
@@ -325,8 +325,7 @@ static bool find_best_mcs_vht(uint8_t max_index, enum o=
fdm_channel_width width,
 	 */
 =

 	for (i =3D max_index; i >=3D 0; i--)
-		if (band_ofdm_rate(i, width, rssi,
-						nss, sgi, out_data_rate))
+		if (band_ofdm_rate(i, width, rssi, nss, sgi, out_data_rate))
 			return true;
 =

 	return false;
-- =

2.34.1

--===============6792075669416263377==--

