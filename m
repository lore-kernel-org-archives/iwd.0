Content-Type: multipart/mixed; boundary="===============6347030158135093333=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 1/4] scan: add support for scanning on AP interface type
Date: Mon, 28 Feb 2022 10:49:36 -0800
Message-ID: <20220228184939.3150560-1-prestwoj@gmail.com>

--===============6347030158135093333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds a new flag, force_ap to the scan parameters. When enabled
this will set NL80211_SCAN_FLAG_AP.
---
 src/scan.c | 3 +++
 src/scan.h | 1 +
 2 files changed, 4 insertions(+)

v3:
 * Removed the feature check.

diff --git a/src/scan.c b/src/scan.c
index 12b7a3fd..b0824e72 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -391,6 +391,9 @@ static struct l_genl_msg *scan_build_cmd(struct scan_co=
ntext *sc,
 					NL80211_EXT_FEATURE_SCAN_RANDOM_SN))
 		flags |=3D NL80211_SCAN_FLAG_RANDOM_SN;
 =

+	if (params->ap_scan)
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

--===============6347030158135093333==--

