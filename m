Content-Type: multipart/mixed; boundary="===============7160076399170981655=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 09/11] ie: add IE_AKM_HAS_FT
Date: Wed, 12 May 2021 14:46:08 -0700
Message-ID: <20210512214610.361080-9-prestwoj@gmail.com>
In-Reply-To: <20210512214610.361080-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7160076399170981655==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is similar to IE_AKM_IS_FT but checks a bitmask of AKM
suites for any FT AKMs.
---
 src/ie.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/src/ie.h b/src/ie.h
index 600cf297..9d32c7b7 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -289,12 +289,13 @@ enum ie_rsn_akm_suite {
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
+
 =

 #define IE_AKM_IS_FILS(akm) \
 	((akm =3D=3D IE_RSN_AKM_SUITE_FILS_SHA256) || \
-- =

2.31.1

--===============7160076399170981655==--

