Content-Type: multipart/mixed; boundary="===============2940986614575493958=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 09/11] ie: use bitwise compare for IE_AKM_IS_FT
Date: Wed, 12 May 2021 16:01:46 -0700
Message-ID: <20210512230148.370858-9-prestwoj@gmail.com>
In-Reply-To: <20210512230148.370858-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2940986614575493958==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This has the same effect when passing a single AKM value, but also
handles AKM bit fields (e.g. ie_rsn_info->akm_suites)
---
 src/ie.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

v3:
 * removed extra newline

diff --git a/src/ie.h b/src/ie.h
index 600cf297..538ca9a8 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -289,12 +289,12 @@ enum ie_rsn_akm_suite {
 	(akm =3D=3D IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256))
 =

 #define IE_AKM_IS_FT(akm) \
-	((akm =3D=3D IE_RSN_AKM_SUITE_FT_OVER_8021X) || \
-	 (akm =3D=3D IE_RSN_AKM_SUITE_FT_USING_PSK) || \
-	 (akm =3D=3D IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256) || \
-	 (akm =3D=3D IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384) || \
-	 (akm =3D=3D IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256) || \
-	 (akm =3D=3D IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384))
+	(akm & (IE_RSN_AKM_SUITE_FT_OVER_8021X | \
+		IE_RSN_AKM_SUITE_FT_USING_PSK | \
+		IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256 | \
+		IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384 | \
+		IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256 | \
+		IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384))
 =

 #define IE_AKM_IS_FILS(akm) \
 	((akm =3D=3D IE_RSN_AKM_SUITE_FILS_SHA256) || \
-- =

2.31.1

--===============2940986614575493958==--

