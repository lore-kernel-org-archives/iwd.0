Content-Type: multipart/mixed; boundary="===============6998661873293621992=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/7] Fixes: 6e8b7652788ac (add check for CMD_AUTH/CMD_ASSOC
 support)
Date: Tue, 30 Mar 2021 14:09:15 -0700
Message-ID: <20210330210921.750967-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6998661873293621992==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Commit 6e8b76527 added a switch statement for AKM suites which
was not correct as this is a bitmask and may contain multiple
values. Intead we can rely on wiphy_select_akm which is a more
robust check anyways.
---
 src/wiphy.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

v3:
 * Return the result of wiphy_select_akm
 * Pass false for fils_hint parameter

diff --git a/src/wiphy.c b/src/wiphy.c
index 676f236c..ab57a2d2 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -407,24 +407,7 @@ bool wiphy_can_connect(struct wiphy *wiphy, struct sca=
n_bss *bss)
 					rsn_info.group_management_cipher))
 			return false;
 =

-
-		switch (rsn_info.akm_suites) {
-		case IE_RSN_AKM_SUITE_SAE_SHA256:
-		case IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256:
-			if (!wiphy_can_connect_sae(wiphy))
-				return false;
-
-			break;
-		case IE_RSN_AKM_SUITE_OWE:
-		case IE_RSN_AKM_SUITE_FILS_SHA256:
-		case IE_RSN_AKM_SUITE_FILS_SHA384:
-		case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256:
-		case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384:
-			if (!wiphy->support_cmds_auth_assoc)
-				return false;
-
-			break;
-		}
+		return wiphy_select_akm(wiphy, bss, false);
 	} else if (r !=3D -ENOENT)
 		return false;
 =

-- =

2.26.2

--===============6998661873293621992==--

