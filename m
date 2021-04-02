Content-Type: multipart/mixed; boundary="===============4783357346792866351=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v6 3/4] wiphy: allow FT AKM to be used if Auth/Assoc is not
 supported
Date: Fri, 02 Apr 2021 15:06:16 -0700
Message-ID: <20210402220617.937790-3-prestwoj@gmail.com>
In-Reply-To: <20210402220617.937790-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4783357346792866351==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Until now FT was only supported via Auth/Assoc commands which barred
any fullmac cards from using FT AKMs. With PSK offload support these
cards can do FT but only when offloading is used.
---
 src/wiphy.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

v6:
 * Check both PSK offload and fw roam support before choosing FT

diff --git a/src/wiphy.c b/src/wiphy.c
index ab57a2d2..9cf0e07c 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -178,6 +178,8 @@ enum ie_rsn_akm_suite wiphy_select_akm(struct wiphy *wi=
phy,
 {
 	struct ie_rsn_info info;
 	enum security security;
+	bool psk_offload =3D wiphy_has_ext_feature(wiphy,
+				NL80211_EXT_FEATURE_4WAY_HANDSHAKE_STA_PSK);
 =

 	memset(&info, 0, sizeof(info));
 	scan_bss_get_rsn_info(bss, &info);
@@ -246,10 +248,17 @@ enum ie_rsn_akm_suite wiphy_select_akm(struct wiphy *=
wiphy,
 		}
 =

 wpa2_personal:
+		/*
+		 * Allow FT if either Auth/Assoc is supported OR if the card
+		 * supports PSK offload. Without Auth/Assoc, PSK offload is the
+		 * only mechanism to allow FT on these cards.
+		 */
 		if ((info.akm_suites & IE_RSN_AKM_SUITE_FT_USING_PSK) &&
-				bss->rsne && bss->mde_present &&
-				wiphy->support_cmds_auth_assoc)
-			return IE_RSN_AKM_SUITE_FT_USING_PSK;
+					bss->rsne && bss->mde_present) {
+			if (wiphy->support_cmds_auth_assoc ||
+					(psk_offload && wiphy->support_fw_roam))
+				return IE_RSN_AKM_SUITE_FT_USING_PSK;
+		}
 =

 		if (info.akm_suites & IE_RSN_AKM_SUITE_PSK_SHA256)
 			return IE_RSN_AKM_SUITE_PSK_SHA256;
-- =

2.26.2

--===============4783357346792866351==--

