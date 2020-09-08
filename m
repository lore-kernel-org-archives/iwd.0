Content-Type: multipart/mixed; boundary="===============6855250547688364796=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 02/17] scan: Add optional source_mac scan parameter
Date: Wed, 09 Sep 2020 01:49:18 +0200
Message-ID: <20200908234933.301439-2-andrew.zaborowski@intel.com>
In-Reply-To: <20200908234933.301439-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6855250547688364796==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is similar to randomize_mac_addr_hint but it sets a specific source
MAC address for our probe frames.
---
 src/scan.c | 12 ++++++++++++
 src/scan.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/src/scan.c b/src/scan.c
index 889ff3a8..b4135d7c 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -361,6 +361,18 @@ static struct l_genl_msg *scan_build_cmd(struct scan_c=
ontext *sc,
 		 */
 		flags |=3D NL80211_SCAN_FLAG_RANDOM_ADDR;
 =

+	if (!is_passive && params->source_mac &&
+			wiphy_can_randomize_mac_addr(sc->wiphy)) {
+		static const uint8_t mask[6] =3D	/* No random bits */
+			{ 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
+
+		flags |=3D NL80211_SCAN_FLAG_RANDOM_ADDR;
+		l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, 6,
+					params->source_mac);
+		l_genl_msg_append_attr(msg, NL80211_ATTR_MAC_MASK, 6,
+					mask);
+	}
+
 	if (!is_passive && wiphy_has_ext_feature(sc->wiphy,
 					NL80211_EXT_FEATURE_SCAN_RANDOM_SN))
 		flags |=3D NL80211_SCAN_FLAG_RANDOM_SN;
diff --git a/src/scan.h b/src/scan.h
index 61d7550f..82b03e87 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -104,6 +104,7 @@ struct scan_parameters {
 	bool no_cck_rates : 1;
 	bool duration_mandatory : 1;
 	const char *ssid;	/* Used for direct probe request */
+	const uint8_t *source_mac;
 };
 =

 static inline int scan_bss_addr_cmp(const struct scan_bss *a1,
-- =

2.25.1

--===============6855250547688364796==--

