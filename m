Content-Type: multipart/mixed; boundary="===============0755145397268752072=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/6] wiphy: check SAE offload in wiphy_select_akm
Date: Thu, 18 Mar 2021 10:20:35 -0700
Message-ID: <20210318172039.278896-2-prestwoj@gmail.com>
In-Reply-To: <20210318172039.278896-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0755145397268752072==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows an SAE AKM to be selected if the hardware does not
support SAE in userspace, but does support SAE offload.
---
 src/wiphy.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index e230b273..9aac830f 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -189,17 +189,15 @@ enum ie_rsn_akm_suite wiphy_select_akm(struct wiphy *=
wiphy,
 			}
 =

 			/*
-			 * TODO: Only SoftMAC (mac80211) drivers are currently
-			 * capable of SAE since it requires ability to send
-			 * Authenticate and Associate frames (which is given by
-			 * support_cmds_auth_assoc).  FullMAC drivers require
-			 * SAE offload which we do not support nor supported
-			 * in any upstream driver as of this time.
+			 * If the hardware does not support SAE in userspace
+			 * (NL80211_FEATURE_SAE), has no Auth/Assoc support,
+			 * nor has SAE offload support downgrade to WPA2.
 			 */
-			if (!wiphy_has_feature(wiphy, NL80211_FEATURE_SAE) ||
-					!wiphy->support_cmds_auth_assoc) {
-				l_debug("No HW WPA3 support, trying WPA2");
-				goto wpa2_personal;
+			if (!wiphy_has_feature(wiphy, NL80211_FEATURE_SAE)) {
+				if (!wiphy_has_ext_feature(wiphy,
+					NL80211_EXT_FEATURE_SAE_OFFLOAD) &&
+						!wiphy->support_cmds_auth_assoc)
+					goto wpa2_personal;
 			}
 =

 			if (info.akm_suites &
-- =

2.26.2

--===============0755145397268752072==--

