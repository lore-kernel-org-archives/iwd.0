Content-Type: multipart/mixed; boundary="===============1717675741887918469=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] station: limit extended key IDs to CCMP ciphers
Date: Tue, 12 Oct 2021 08:34:17 -0700
Message-ID: <20211012153417.3781942-1-prestwoj@gmail.com>

--===============1717675741887918469==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/station.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index bfd69777..c73db634 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1087,8 +1087,13 @@ build_ie:
 =

 	info.ocvc =3D !disable_ocv && bss_info.ocvc;
 =

-	/* Extended Key IDs can only be used if supported by both AP and STA */
-	if (wiphy_supports_ext_key_id(wiphy) && bss_info.extended_key_id)
+	/*
+	 * IEEE 802.11-2020 9.4.2.24.4 states extended key IDs can only be used
+	 * with CCMP/GCMP cipher suites. We also only enable support if the AP
+	 * also indicates support.
+	 */
+	if (wiphy_supports_ext_key_id(wiphy) && bss_info.extended_key_id &&
+			info.pairwise_ciphers =3D=3D IE_RSN_CIPHER_SUITE_CCMP)
 		info.extended_key_id =3D true;
 =

 	/* RSN takes priority */
-- =

2.31.1

--===============1717675741887918469==--

