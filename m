Content-Type: multipart/mixed; boundary="===============6318739896710544198=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 1/2] wiphy: Add parser and getter for max ie len attr
Date: Wed, 06 Nov 2019 17:16:23 -0500
Message-ID: <20191106221624.12072-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6318739896710544198==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/wiphy.c | 12 ++++++++++++
 src/wiphy.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index ef22c0d3..4446abba 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -67,6 +67,7 @@ struct wiphy {
 	uint8_t ext_features[(NUM_NL80211_EXT_FEATURES + 7) / 8];
 	uint8_t max_num_ssids_per_scan;
 	uint32_t max_roc_duration;
+	uint16_t max_scan_ie_len;
 	uint16_t supported_iftypes;
 	uint16_t supported_ciphers;
 	struct scan_freq_set *supported_freqs;
@@ -363,6 +364,11 @@ uint8_t wiphy_get_max_num_ssids_per_scan(struct wiphy =
*wiphy)
 	return wiphy->max_num_ssids_per_scan;
 }
 =

+uint16_t wiphy_get_max_scan_ie_len(struct wiphy *wiphy)
+{
+	return wiphy->max_scan_ie_len;
+}
+
 uint32_t wiphy_get_max_roc_duration(struct wiphy *wiphy)
 {
 	return wiphy->max_roc_duration;
@@ -834,6 +840,12 @@ static void wiphy_parse_attributes(struct wiphy *wiphy,
 				wiphy->max_num_ssids_per_scan =3D
 							*((uint8_t *) data);
 			break;
+		case NL80211_ATTR_MAX_SCAN_IE_LEN:
+			if (len !=3D sizeof(uint16_t))
+				l_warn("Invalid MAX_SCAN_IE_LEN attribute");
+			else
+				wiphy->max_scan_ie_len =3D *((uint16_t *) data);
+			break;
 		case NL80211_ATTR_SUPPORT_IBSS_RSN:
 			wiphy->support_adhoc_rsn =3D true;
 			break;
diff --git a/src/wiphy.h b/src/wiphy.h
index 85fa3f56..67eafe3c 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -64,6 +64,7 @@ bool wiphy_rrm_capable(struct wiphy *wiphy);
 bool wiphy_has_feature(struct wiphy *wiphy, uint32_t feature);
 bool wiphy_has_ext_feature(struct wiphy *wiphy, uint32_t feature);
 uint8_t wiphy_get_max_num_ssids_per_scan(struct wiphy *wiphy);
+uint16_t wiphy_get_max_scan_ie_len(struct wiphy *wiphy);
 uint32_t wiphy_get_max_roc_duration(struct wiphy *wiphy);
 bool wiphy_supports_iftype(struct wiphy *wiphy, uint32_t iftype);
 const uint8_t *wiphy_get_supported_rates(struct wiphy *wiphy, unsigned int=
 band,
-- =

2.21.0

--===============6318739896710544198==--

