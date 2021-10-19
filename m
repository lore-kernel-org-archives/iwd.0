Content-Type: multipart/mixed; boundary="===============3083266176697786590=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 1/2] wiphy: add wiphy_can_offload
Date: Tue, 19 Oct 2021 14:52:46 -0700
Message-ID: <20211019215247.574475-1-prestwoj@gmail.com>

--===============3083266176697786590==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a convenience method for detecting any supported offload
extended features (4way/1x/SAE).
---
 src/wiphy.c | 11 +++++++++++
 src/wiphy.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index 1a333aad..4d740ba3 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -459,6 +459,17 @@ bool wiphy_can_transition_disable(struct wiphy *wiphy)
 	return true;
 }
 =

+/* Catch all for the offload features */
+bool wiphy_can_offload(struct wiphy *wiphy)
+{
+	return wiphy_has_ext_feature(wiphy,
+				NL80211_EXT_FEATURE_4WAY_HANDSHAKE_STA_PSK) ||
+				wiphy_has_ext_feature(wiphy,
+				NL80211_EXT_FEATURE_4WAY_HANDSHAKE_STA_1X) ||
+				wiphy_has_ext_feature(wiphy,
+				NL80211_EXT_FEATURE_SAE_OFFLOAD);
+}
+
 bool wiphy_supports_ext_key_id(struct wiphy *wiphy)
 {
 	return wiphy_has_ext_feature(wiphy, NL80211_EXT_FEATURE_EXT_KEY_ID);
diff --git a/src/wiphy.h b/src/wiphy.h
index f7b6e1c4..9f0d6d07 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -83,6 +83,7 @@ uint32_t wiphy_get_supported_bands(struct wiphy *wiphy);
 const struct scan_freq_set *wiphy_get_supported_freqs(
 						const struct wiphy *wiphy);
 bool wiphy_can_transition_disable(struct wiphy *wiphy);
+bool wiphy_can_offload(struct wiphy *wiphy);
 bool wiphy_supports_cmds_auth_assoc(struct wiphy *wiphy);
 bool wiphy_can_randomize_mac_addr(struct wiphy *wiphy);
 bool wiphy_rrm_capable(struct wiphy *wiphy);
-- =

2.31.1

--===============3083266176697786590==--

