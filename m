Content-Type: multipart/mixed; boundary="===============1050543116906595993=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] wiphy: restrict FT AKMs when not supported
Date: Mon, 04 May 2020 08:24:20 -0700
Message-ID: <20200504152420.27210-4-prestwoj@gmail.com>
In-Reply-To: <20200504152420.27210-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1050543116906595993==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some full mac cards don't like being given a FT AKM when connecting.
From an API perspective this should be supported, but in practice
these cards behave differently and some do no accept FT AKMs. Until
this becomes more stable any cards not supporting Auth/Assoc commands
(full mac) will not connect using FT AKMs.
---
 src/wiphy.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 9821da0e..aef39549 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -157,7 +157,8 @@ enum ie_rsn_akm_suite wiphy_select_akm(struct wiphy *wi=
phy,
 		}
 =

 		if ((info.akm_suites & IE_RSN_AKM_SUITE_FT_OVER_8021X) &&
-				bss->rsne && bss->mde_present)
+				bss->rsne && bss->mde_present &&
+				wiphy->support_cmds_auth_assoc)
 			return IE_RSN_AKM_SUITE_FT_OVER_8021X;
 =

 		if (info.akm_suites & IE_RSN_AKM_SUITE_8021X_SHA256)
@@ -175,8 +176,9 @@ enum ie_rsn_akm_suite wiphy_select_akm(struct wiphy *wi=
phy,
 		if (wiphy->supported_ciphers & IE_RSN_CIPHER_SUITE_BIP &&
 				wiphy_has_feature(wiphy, NL80211_FEATURE_SAE) &&
 				info.mfpr) {
-			if (info.akm_suites &
-					IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256)
+			if ((info.akm_suites &
+					IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256) &&
+					wiphy->support_cmds_auth_assoc)
 				return IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256;
 =

 			if (info.akm_suites & IE_RSN_AKM_SUITE_SAE_SHA256)
@@ -184,7 +186,8 @@ enum ie_rsn_akm_suite wiphy_select_akm(struct wiphy *wi=
phy,
 		}
 =

 		if ((info.akm_suites & IE_RSN_AKM_SUITE_FT_USING_PSK) &&
-				bss->rsne && bss->mde_present)
+				bss->rsne && bss->mde_present &&
+				wiphy->support_cmds_auth_assoc)
 			return IE_RSN_AKM_SUITE_FT_USING_PSK;
 =

 		if (info.akm_suites & IE_RSN_AKM_SUITE_PSK_SHA256)
-- =

2.21.1

--===============1050543116906595993==--

