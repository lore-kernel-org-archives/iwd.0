Content-Type: multipart/mixed; boundary="===============0727041172129059562=="
MIME-Version: 1.0
From: Andrew Zaborowski <balrogg@gmail.com>
Subject: [PATCH 10/11] wiphy: Add wiphy_get_max_roc_duration
Date: Mon, 21 Oct 2019 15:55:09 +0200
Message-ID: <20191021135510.12657-10-balrogg@gmail.com>
In-Reply-To: <20191021135510.12657-1-balrogg@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0727041172129059562==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Andrew Zaborowski <andrew.zaborowski@intel.com>

Add a function to retrieve the maximum Remain On Channel listen duration
supported by the wiphy's driver.
---
 src/wiphy.c | 12 ++++++++++++
 src/wiphy.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index 169631af..9cb9ae66 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -66,6 +66,7 @@ struct wiphy {
 	uint32_t feature_flags;
 	uint8_t ext_features[(NUM_NL80211_EXT_FEATURES + 7) / 8];
 	uint8_t max_num_ssids_per_scan;
+	uint32_t max_roc_duration;
 	uint16_t supported_iftypes;
 	uint16_t supported_ciphers;
 	struct scan_freq_set *supported_freqs;
@@ -355,6 +356,11 @@ uint8_t wiphy_get_max_num_ssids_per_scan(struct wiphy =
*wiphy)
 	return wiphy->max_num_ssids_per_scan;
 }
 =

+uint32_t wiphy_get_max_roc_duration(struct wiphy *wiphy)
+{
+	return wiphy->max_roc_duration;
+}
+
 bool wiphy_supports_adhoc_rsn(struct wiphy *wiphy)
 {
 	return wiphy->support_adhoc_rsn;
@@ -769,6 +775,12 @@ static void wiphy_parse_attributes(struct wiphy *wiphy,
 =

 			parse_iftype_extended_capabilities(wiphy, &nested);
 			break;
+		case NL80211_ATTR_MAX_REMAIN_ON_CHANNEL_DURATION:
+			if (len !=3D 4)
+				l_warn("Invalid MAX_ROC_DURATION attribute");
+			else
+				wiphy->max_roc_duration =3D *((uint32_t *) data);
+			break;
 		}
 	}
 }
diff --git a/src/wiphy.h b/src/wiphy.h
index 61e1caf8..c109f0a8 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -64,6 +64,7 @@ bool wiphy_rrm_capable(struct wiphy *wiphy);
 bool wiphy_has_feature(struct wiphy *wiphy, uint32_t feature);
 bool wiphy_has_ext_feature(struct wiphy *wiphy, uint32_t feature);
 uint8_t wiphy_get_max_num_ssids_per_scan(struct wiphy *wiphy);
+uint32_t wiphy_get_max_roc_duration(struct wiphy *wiphy);
 bool wiphy_supports_iftype(struct wiphy *wiphy, uint32_t iftype);
 bool wiphy_supports_adhoc_rsn(struct wiphy *wiphy);
 bool wiphy_can_offchannel_tx(struct wiphy *wiphy);
-- =

2.20.1

--===============0727041172129059562==--

