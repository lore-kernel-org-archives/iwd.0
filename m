Content-Type: multipart/mixed; boundary="===============2264536950363129504=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v4 3/5] station: set extended key capability
Date: Fri, 08 Oct 2021 11:07:24 -0700
Message-ID: <20211008180726.2599788-3-prestwoj@gmail.com>
In-Reply-To: 20211008180726.2599788-1-prestwoj@gmail.com

--===============2264536950363129504==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If wiphy and the AP suppor it, set the Extended Key ID capability
bit in the RSN info.
---
 src/station.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/station.c b/src/station.c
index f12cdde5..30335170 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1087,6 +1087,10 @@ build_ie:
 =

 	info.ocvc =3D !disable_ocv;
 =

+	/* Extended Key IDs can only be used if supported by both AP and STA */
+	if (wiphy_supports_ext_key_id(wiphy) && bss_info.extended_key_id)
+		info.extended_key_id =3D true;
+
 	/* RSN takes priority */
 	if (bss->rsne) {
 		ap_ie =3D bss->rsne;
-- =

2.31.1

--===============2264536950363129504==--

