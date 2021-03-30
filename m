Content-Type: multipart/mixed; boundary="===============8825643882100457456=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] wiphy: fix wiphy_can_connect AKM checks
Date: Tue, 30 Mar 2021 10:31:13 -0700
Message-ID: <20210330173113.737510-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8825643882100457456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This was changed in commit 6e8b7652 to remove the IE_AKM_IS_SAE
and instead use a switch statement. This is was incorrect since
the akm_suites is actually a bitmask which could contain multiple
AKM suites (hence the plural name). Instead a few macros were
added which check the bitmask rather than the entire value.
---
 src/wiphy.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 676f236c..57c97367 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -388,6 +388,21 @@ const struct scan_freq_set *wiphy_get_supported_freqs(
 	return wiphy->supported_freqs;
 }
 =

+#define AKM_IS_AUTH_ASSOC(akm)				\
+(							\
+	akm & (IE_RSN_AKM_SUITE_OWE |			\
+		IE_RSN_AKM_SUITE_FILS_SHA256 |		\
+		IE_RSN_AKM_SUITE_FILS_SHA384 |		\
+		IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256 |	\
+		IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384)	\
+)
+
+#define AKM_IS_SAE(akm)					\
+(							\
+	akm & (IE_RSN_AKM_SUITE_SAE_SHA256 |		\
+		IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256)	\
+)
+
 bool wiphy_can_connect(struct wiphy *wiphy, struct scan_bss *bss)
 {
 	struct ie_rsn_info rsn_info;
@@ -407,23 +422,12 @@ bool wiphy_can_connect(struct wiphy *wiphy, struct sc=
an_bss *bss)
 					rsn_info.group_management_cipher))
 			return false;
 =

-
-		switch (rsn_info.akm_suites) {
-		case IE_RSN_AKM_SUITE_SAE_SHA256:
-		case IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256:
+		if (AKM_IS_SAE(rsn_info.akm_suites)) {
 			if (!wiphy_can_connect_sae(wiphy))
 				return false;
-
-			break;
-		case IE_RSN_AKM_SUITE_OWE:
-		case IE_RSN_AKM_SUITE_FILS_SHA256:
-		case IE_RSN_AKM_SUITE_FILS_SHA384:
-		case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256:
-		case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384:
+		} else if (AKM_IS_AUTH_ASSOC(rsn_info.akm_suites)) {
 			if (!wiphy->support_cmds_auth_assoc)
 				return false;
-
-			break;
 		}
 	} else if (r !=3D -ENOENT)
 		return false;
-- =

2.26.2

--===============8825643882100457456==--

