Content-Type: multipart/mixed; boundary="===============9197977061016264188=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/6] wiphy: check SAE offload in wiphy_can_connect
Date: Thu, 18 Mar 2021 10:20:36 -0700
Message-ID: <20210318172039.278896-3-prestwoj@gmail.com>
In-Reply-To: <20210318172039.278896-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9197977061016264188==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows this wiphy_can_connect to pass for an SAE BSS
if the hardware does not support user space SAE, but does
support SAE offload.
---
 src/wiphy.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 9aac830f..6533cc7e 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -376,15 +376,18 @@ bool wiphy_can_connect(struct wiphy *wiphy, struct sc=
an_bss *bss)
 		case IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256:
 			/*
 			 * if the AP ONLY supports SAE/WPA3, then we can only
-			 * connect if the wiphy feature is supported. Otherwise
-			 * the AP may list SAE as one of the AKM's but also
-			 * support PSK (hybrid). In this case we still want to
-			 * allow a connection even if SAE is not supported.
+			 * connect if the wiphy either supports userspace SAE or
+			 * SAE offload. Otherwise the AP may list SAE as one of
+			 * the AKM's but also support PSK (hybrid). In this case
+			 * we still want to allow a connection even if SAE is
+			 * not supported.
 			 */
-			if (!wiphy_has_feature(wiphy, NL80211_FEATURE_SAE) ||
+			if (!wiphy_has_feature(wiphy, NL80211_FEATURE_SAE)) {
+				if (!wiphy_has_ext_feature(wiphy,
+					NL80211_EXT_FEATURE_SAE_OFFLOAD) &&
 						!wiphy->support_cmds_auth_assoc)
-				return false;
-
+					return false;
+			}
 			break;
 		case IE_RSN_AKM_SUITE_OWE:
 		case IE_RSN_AKM_SUITE_FILS_SHA256:
-- =

2.26.2

--===============9197977061016264188==--

