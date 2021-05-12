Content-Type: multipart/mixed; boundary="===============4204269007481358347=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 11/11] station: use IE_AKM_IS_FT when possible
Date: Wed, 12 May 2021 16:01:48 -0700
Message-ID: <20210512230148.370858-11-prestwoj@gmail.com>
In-Reply-To: <20210512230148.370858-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4204269007481358347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Update a check to use IE_AKM_IS_FT as the condition is identical
to the macro.
---
 src/station.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/src/station.c b/src/station.c
index 325121f1..f64ba675 100644
--- a/src/station.c
+++ b/src/station.c
@@ -865,11 +865,7 @@ build_ie:
 	if (!handshake_state_set_supplicant_ie(hs, rsne_buf))
 		goto not_supported;
 =

-	if (info.akm_suites & (IE_RSN_AKM_SUITE_FT_OVER_8021X |
-				IE_RSN_AKM_SUITE_FT_USING_PSK |
-				IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256 |
-				IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256 |
-				IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384))
+	if (IE_AKM_IS_FT(info.akm_suites))
 		add_mde =3D true;
 =

 open_network:
-- =

2.31.1

--===============4204269007481358347==--

