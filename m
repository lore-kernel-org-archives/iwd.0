Content-Type: multipart/mixed; boundary="===============6165822910503597700=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 7/7] wiphy: remove wiphy_supports_cmds_auth_assoc
Date: Tue, 30 Mar 2021 14:09:21 -0700
Message-ID: <20210330210921.750967-7-prestwoj@gmail.com>
In-Reply-To: <20210330210921.750967-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6165822910503597700==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is no longer needed.
---
 src/wiphy.c | 5 -----
 src/wiphy.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index b6b82933..a72773f7 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -455,11 +455,6 @@ bool wiphy_can_connect(struct wiphy *wiphy, struct sca=
n_bss *bss)
 	return true;
 }
 =

-bool wiphy_supports_cmds_auth_assoc(struct wiphy *wiphy)
-{
-	return wiphy->support_cmds_auth_assoc;
-}
-
 bool wiphy_has_feature(struct wiphy *wiphy, uint32_t feature)
 {
 	return wiphy->feature_flags & feature;
diff --git a/src/wiphy.h b/src/wiphy.h
index 7ac1df95..c83cd15a 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -80,7 +80,6 @@ uint32_t wiphy_get_supported_bands(struct wiphy *wiphy);
 const struct scan_freq_set *wiphy_get_supported_freqs(
 						const struct wiphy *wiphy);
 bool wiphy_can_connect(struct wiphy *wiphy, struct scan_bss *bss);
-bool wiphy_supports_cmds_auth_assoc(struct wiphy *wiphy);
 bool wiphy_can_randomize_mac_addr(struct wiphy *wiphy);
 bool wiphy_rrm_capable(struct wiphy *wiphy);
 bool wiphy_has_feature(struct wiphy *wiphy, uint32_t feature);
-- =

2.26.2

--===============6165822910503597700==--

