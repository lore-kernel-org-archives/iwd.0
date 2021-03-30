Content-Type: multipart/mixed; boundary="===============1945305558865626397=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/7] wiphy: add offload out parameter to wiphy_can_connect_sae
Date: Tue, 30 Mar 2021 09:13:01 -0700
Message-ID: <20210330161307.732965-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1945305558865626397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will be set if the SAE connection requires offloading to
work.
---
 src/wiphy.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 676f236c..35872577 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -126,7 +126,7 @@ enum ie_rsn_cipher_suite wiphy_select_cipher(struct wip=
hy *wiphy, uint16_t mask)
 	return 0;
 }
 =

-static bool wiphy_can_connect_sae(struct wiphy *wiphy)
+static bool wiphy_can_connect_sae(struct wiphy *wiphy, bool *offload)
 {
 	/*
 	 * SAE support in the kernel is a complete mess in that there are 3
@@ -153,8 +153,11 @@ static bool wiphy_can_connect_sae(struct wiphy *wiphy)
 =

 	if (wiphy_has_feature(wiphy, NL80211_FEATURE_SAE)) {
 		/* Case (1) */
-		if (wiphy->support_cmds_auth_assoc)
+		if (wiphy->support_cmds_auth_assoc) {
+			if (offload)
+				*offload =3D false;
 			return true;
+		}
 =

 		/*
 		 * Case (3)
@@ -165,8 +168,12 @@ static bool wiphy_can_connect_sae(struct wiphy *wiphy)
 	} else {
 		/* Case (2) */
 		if (wiphy_has_ext_feature(wiphy,
-					NL80211_EXT_FEATURE_SAE_OFFLOAD))
+					NL80211_EXT_FEATURE_SAE_OFFLOAD)) {
+			if (offload)
+				*offload =3D true;
+
 			return true;
+		}
 =

 		return false;
 	}
@@ -234,7 +241,7 @@ enum ie_rsn_akm_suite wiphy_select_akm(struct wiphy *wi=
phy,
 				goto wpa2_personal;
 			}
 =

-			if (!wiphy_can_connect_sae(wiphy))
+			if (!wiphy_can_connect_sae(wiphy, NULL))
 				goto wpa2_personal;
 =

 			if (info.akm_suites &
@@ -411,7 +418,7 @@ bool wiphy_can_connect(struct wiphy *wiphy, struct scan=
_bss *bss)
 		switch (rsn_info.akm_suites) {
 		case IE_RSN_AKM_SUITE_SAE_SHA256:
 		case IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256:
-			if (!wiphy_can_connect_sae(wiphy))
+			if (!wiphy_can_connect_sae(wiphy, NULL))
 				return false;
 =

 			break;
-- =

2.26.2

--===============1945305558865626397==--

