Content-Type: multipart/mixed; boundary="===============3249744569861057445=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 1/2] wiphy: allow FT AKM to be used if Auth/Assoc is not
 supported
Date: Fri, 02 Apr 2021 13:42:26 -0700
Message-ID: <20210402204227.931444-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3249744569861057445==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Until now FT was only supported via Auth/Assoc commands which barred
any fullmac cards from using FT AKMs. With PSK offload support these
cards can do FT but only when offloading is used.
---
 src/wiphy.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

v5 (forgot to tag v4 on previous set):
 * Offloading is assumed if the driver supports it

diff --git a/src/wiphy.c b/src/wiphy.c
index ab57a2d2..d5f6f876 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -246,10 +246,18 @@ enum ie_rsn_akm_suite wiphy_select_akm(struct wiphy *=
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
+				wiphy_has_ext_feature(wiphy,
+				NL80211_EXT_FEATURE_4WAY_HANDSHAKE_STA_PSK))
+				return IE_RSN_AKM_SUITE_FT_USING_PSK;
+		}
 =

 		if (info.akm_suites & IE_RSN_AKM_SUITE_PSK_SHA256)
 			return IE_RSN_AKM_SUITE_PSK_SHA256;
-- =

2.26.2

--===============3249744569861057445==--

