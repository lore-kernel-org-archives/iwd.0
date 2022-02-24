Content-Type: multipart/mixed; boundary="===============1568240231759930785=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 4/7] scan: add support for scanning on AP interface type
Date: Thu, 24 Feb 2022 09:04:57 -0800
Message-ID: <20220224170500.2779425-4-prestwoj@gmail.com>
In-Reply-To: 20220224170500.2779425-1-prestwoj@gmail.com

--===============1568240231759930785==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds a new flag, force_ap to the scan parameters. When enabled
this will set NL80211_SCAN_FLAG_AP.
---
 src/scan.c | 4 ++++
 src/scan.h | 1 +
 2 files changed, 5 insertions(+)

v2:
 * Renamed flag to 'ap_scan'

diff --git a/src/scan.c b/src/scan.c
index 12b7a3fd..2345ca50 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -391,6 +391,10 @@ static struct l_genl_msg *scan_build_cmd(struct scan_c=
ontext *sc,
 					NL80211_EXT_FEATURE_SCAN_RANDOM_SN))
 		flags |=3D NL80211_SCAN_FLAG_RANDOM_SN;
 =

+	if (params->ap_scan && wiphy_has_feature(sc->wiphy,
+						NL80211_FEATURE_AP_SCAN))
+		flags |=3D NL80211_SCAN_FLAG_AP;
+
 	if (flags)
 		l_genl_msg_append_attr(msg, NL80211_ATTR_SCAN_FLAGS, 4, &flags);
 =

diff --git a/src/scan.h b/src/scan.h
index 2c401df6..ba11a508 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -98,6 +98,7 @@ struct scan_parameters {
 	bool randomize_mac_addr_hint : 1;
 	bool no_cck_rates : 1;
 	bool duration_mandatory : 1;
+	bool ap_scan : 1;
 	const uint8_t *ssid;	/* Used for direct probe request */
 	size_t ssid_len;
 	const uint8_t *source_mac;
-- =

2.34.1

--===============1568240231759930785==--

