Content-Type: multipart/mixed; boundary="===============8912382218640785399=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 3/7] scan: check flush feature before using flag
Date: Thu, 24 Feb 2022 09:04:56 -0800
Message-ID: <20220224170500.2779425-3-prestwoj@gmail.com>
In-Reply-To: 20220224170500.2779425-1-prestwoj@gmail.com

--===============8912382218640785399==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/scan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/scan.c b/src/scan.c
index 7c510df8..12b7a3fd 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -362,7 +362,8 @@ static struct l_genl_msg *scan_build_cmd(struct scan_co=
ntext *sc,
 	if (params->freqs)
 		scan_build_attr_scan_frequencies(msg, params->freqs);
 =

-	if (params->flush && !ignore_flush_flag)
+	if (params->flush && !ignore_flush_flag && wiphy_has_feature(sc->wiphy,
+						NL80211_FEATURE_SCAN_FLUSH))
 		flags |=3D NL80211_SCAN_FLAG_FLUSH;
 =

 	if (!is_passive && params->randomize_mac_addr_hint &&
-- =

2.34.1

--===============8912382218640785399==--

