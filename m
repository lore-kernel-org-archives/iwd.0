Content-Type: multipart/mixed; boundary="===============4839410083237045891=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 02/12] wiphy: add wiphy_supports_ext_key_id
Date: Mon, 04 Oct 2021 09:48:52 -0700
Message-ID: <20211004164902.2274318-2-prestwoj@gmail.com>
In-Reply-To: 20211004164902.2274318-1-prestwoj@gmail.com

--===============4839410083237045891==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/wiphy.c | 5 +++++
 src/wiphy.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index e2222887..0ff10d46 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -433,6 +433,11 @@ bool wiphy_can_transition_disable(struct wiphy *wiphy)
 	return true;
 }
 =

+bool wiphy_supports_ext_key_id(struct wiphy *wiphy)
+{
+	return wiphy_has_ext_feature(wiphy, NL80211_EXT_FEATURE_EXT_KEY_ID);
+}
+
 bool wiphy_supports_cmds_auth_assoc(struct wiphy *wiphy)
 {
 	return wiphy->support_cmds_auth_assoc;
diff --git a/src/wiphy.h b/src/wiphy.h
index c32fd21e..d3bf16b8 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -86,6 +86,7 @@ bool wiphy_can_transition_disable(struct wiphy *wiphy);
 bool wiphy_supports_cmds_auth_assoc(struct wiphy *wiphy);
 bool wiphy_can_randomize_mac_addr(struct wiphy *wiphy);
 bool wiphy_rrm_capable(struct wiphy *wiphy);
+bool wiphy_supports_ext_key_id(struct wiphy *wiphy);
 bool wiphy_has_feature(struct wiphy *wiphy, uint32_t feature);
 bool wiphy_has_ext_feature(struct wiphy *wiphy, uint32_t feature);
 uint8_t wiphy_get_max_num_ssids_per_scan(struct wiphy *wiphy);
-- =

2.31.1

--===============4839410083237045891==--

