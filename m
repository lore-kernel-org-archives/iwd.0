Content-Type: multipart/mixed; boundary="===============2670560161716842034=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] wiphy: add wiphy_can_offload API
Date: Wed, 03 Mar 2021 09:47:27 -0800
Message-ID: <20210303174730.6738-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2670560161716842034==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This checks if offload is an available extended feature and
compatible with the desired BSS. It is also conditional on
the [General].PreferOffload setting which, for now, is being
added as a 'hidden' developer feature (not documented).
---
 src/wiphy.c | 33 +++++++++++++++++++++++++++++++++
 src/wiphy.h |  1 +
 2 files changed, 34 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index 3adc5669..2493e8eb 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -412,6 +412,39 @@ bool wiphy_can_randomize_mac_addr(struct wiphy *wiphy)
 	return wiphy_has_feature(wiphy, NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR);
 }
 =

+bool wiphy_can_offload(struct wiphy *wiphy, struct scan_bss *bss)
+{
+	struct ie_rsn_info rsn_info;
+	int r;
+	bool prefer_offload =3D false;
+
+	if (!wiphy_has_ext_feature(wiphy,
+				NL80211_EXT_FEATURE_4WAY_HANDSHAKE_STA_PSK))
+		return false;
+
+	if (!l_settings_get_bool(iwd_get_config(), "General", "PreferOffload",
+				&prefer_offload) || !prefer_offload)
+		return false;
+
+	memset(&rsn_info, 0, sizeof(rsn_info));
+	r =3D scan_bss_get_rsn_info(bss, &rsn_info);
+
+	if (r < 0)
+		return false;
+
+	/*
+	 * For now offload is only allowed on PSK networks.
+	 */
+	switch (rsn_info.akm_suites) {
+	case IE_RSN_AKM_SUITE_PSK:
+	case IE_RSN_AKM_SUITE_PSK_SHA256:
+		return true;
+	default:
+		return false;
+	}
+}
+
+
 bool wiphy_rrm_capable(struct wiphy *wiphy)
 {
 	if (wiphy_has_feature(wiphy,
diff --git a/src/wiphy.h b/src/wiphy.h
index 50c8c936..016e5879 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -80,6 +80,7 @@ const struct scan_freq_set *wiphy_get_supported_freqs(
 						const struct wiphy *wiphy);
 bool wiphy_can_connect(struct wiphy *wiphy, struct scan_bss *bss);
 bool wiphy_can_randomize_mac_addr(struct wiphy *wiphy);
+bool wiphy_can_offload(struct wiphy *wiphy, struct scan_bss *bss);
 bool wiphy_rrm_capable(struct wiphy *wiphy);
 bool wiphy_has_feature(struct wiphy *wiphy, uint32_t feature);
 bool wiphy_has_ext_feature(struct wiphy *wiphy, uint32_t feature);
-- =

2.26.2

--===============2670560161716842034==--

