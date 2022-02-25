Content-Type: multipart/mixed; boundary="===============5518441980491345350=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 3/7] station: use IE_AKM_IS_FILS
Date: Fri, 25 Feb 2022 15:32:47 -0800
Message-ID: <20220225233251.2958102-3-prestwoj@gmail.com>
In-Reply-To: 20220225233251.2958102-1-prestwoj@gmail.com

--===============5518441980491345350==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use this macro instead of manually checking
---
 src/station.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/src/station.c b/src/station.c
index cd119ff1..637d03d1 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1144,10 +1144,7 @@ build_ie:
 	 * a reference now so it remains valid (in case of expiration) until
 	 * FILS starts.
 	 */
-	if (hs->akm_suite & (IE_RSN_AKM_SUITE_FILS_SHA256 |
-				IE_RSN_AKM_SUITE_FILS_SHA384 |
-				IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256 |
-				IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384))
+	if (IE_AKM_IS_FILS(hs->akm_suite))
 		hs->erp_cache =3D erp_cache;
 	else if (erp_cache)
 		erp_cache_put(erp_cache);
-- =

2.34.1

--===============5518441980491345350==--

