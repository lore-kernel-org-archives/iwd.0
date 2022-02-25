Content-Type: multipart/mixed; boundary="===============4746091775474393333=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 1/7] ie: update IE_AKM_IS_SAE to bitwise comparison
Date: Fri, 25 Feb 2022 15:32:45 -0800
Message-ID: <20220225233251.2958102-1-prestwoj@gmail.com>

--===============4746091775474393333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

All uses of this macro will work with a bitwise comparison which is
needed for 6GHz checks and somewhat more flexible since it can be
used to compare RSN info, not only single AKM values.
---
 src/ie.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/ie.h b/src/ie.h
index 302cda70..9b57cf66 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -337,8 +337,8 @@ enum ie_rsn_akm_suite {
 };
 =

 #define IE_AKM_IS_SAE(akm) \
-	((akm =3D=3D IE_RSN_AKM_SUITE_SAE_SHA256) || \
-	(akm =3D=3D IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256))
+	(akm & (IE_RSN_AKM_SUITE_SAE_SHA256 | \
+		IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256))
 =

 #define IE_AKM_IS_FT(akm) \
 	(akm & (IE_RSN_AKM_SUITE_FT_OVER_8021X | \
-- =

2.34.1

--===============4746091775474393333==--

