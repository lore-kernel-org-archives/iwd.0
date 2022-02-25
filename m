Content-Type: multipart/mixed; boundary="===============0865929199098825826=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 2/7] ie: update IE_AKM_IS_FILS to be bitwise
Date: Fri, 25 Feb 2022 15:32:46 -0800
Message-ID: <20220225233251.2958102-2-prestwoj@gmail.com>
In-Reply-To: 20220225233251.2958102-1-prestwoj@gmail.com

--===============0865929199098825826==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently nothing actually uses this macro, but switching it to a bitwise
comparison makes it more useful and consistent with the others.
---
 src/ie.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/ie.h b/src/ie.h
index 9b57cf66..fac766d5 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -349,10 +349,10 @@ enum ie_rsn_akm_suite {
 		IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384))
 =

 #define IE_AKM_IS_FILS(akm) \
-	((akm =3D=3D IE_RSN_AKM_SUITE_FILS_SHA256) || \
-	 (akm =3D=3D IE_RSN_AKM_SUITE_FILS_SHA384) || \
-	 (akm =3D=3D IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256) || \
-	 (akm =3D=3D IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384))
+	(akm & (IE_RSN_AKM_SUITE_FILS_SHA256 | \
+		IE_RSN_AKM_SUITE_FILS_SHA384 | \
+		IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256 | \
+		IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384))
 =

 #define IE_LEN(ie) \
 	((ie) ? (ie)[1] + 2 : 0)
-- =

2.34.1

--===============0865929199098825826==--

