Content-Type: multipart/mixed; boundary="===============6973670718564074971=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/6] station: don't set ERP cache to handshake
Date: Tue, 03 Aug 2021 10:27:55 -0700
Message-ID: <20210803172759.123297-2-prestwoj@gmail.com>
In-Reply-To: <20210803172759.123297-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6973670718564074971==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is now done internally by fils.
---
 src/station.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/src/station.c b/src/station.c
index e914abb3..b793c8e5 100644
--- a/src/station.c
+++ b/src/station.c
@@ -889,17 +889,6 @@ static struct handshake_state *station_handshake_setup=
(struct station *station,
 	if (network_handshake_setup(network, hs) < 0)
 		goto not_supported;
 =

-	/*
-	 * If FILS was chosen, the ERP cache has been verified to exist. We
-	 * wait to get it until here because@this point so there are no
-	 * failure paths before fils_sm_new
-	 */
-	if (hs->akm_suite & (IE_RSN_AKM_SUITE_FILS_SHA256 |
-				IE_RSN_AKM_SUITE_FILS_SHA384 |
-				IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256 |
-				IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384))
-		hs->erp_cache =3D erp_cache_get(network_get_ssid(network));
-
 	return hs;
 =

 not_supported:
-- =

2.31.1

--===============6973670718564074971==--

