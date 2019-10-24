Content-Type: multipart/mixed; boundary="===============1302963367137898061=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/8] scan: Hide CCK rates if no_cck_rates set
Date: Thu, 24 Oct 2019 06:29:54 +0200
Message-ID: <20191024043000.13687-2-andrew.zaborowski@intel.com>
In-Reply-To: <20191024043000.13687-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1302963367137898061==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

no_cck_rates is set in the scan parameters generally to make sure
that the Probe Request frames are not sent at any of the 802.11b
rates during active scans.  With this patch we also omit those rates
from the Supported Rates IEs, which is required by the p2p spec and
also matches our flag's name.
---
 src/scan.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/src/scan.c b/src/scan.c
index a63c462a..2d54af12 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -347,10 +347,43 @@ static struct l_genl_msg *scan_build_cmd(struct scan_=
context *sc,
 	if (flags)
 		l_genl_msg_append_attr(msg, NL80211_ATTR_SCAN_FLAGS, 4, &flags);
 =

-	if (params->no_cck_rates)
+	if (params->no_cck_rates) {
+		static const uint8_t b_rates[] =3D { 2, 4, 11, 22 };
+		uint8_t *scan_rates;
+		const uint8_t *supported;
+		int i;
+		int count;
+
 		l_genl_msg_append_attr(msg, NL80211_ATTR_TX_NO_CCK_RATE, 0,
 					NULL);
 =

+		/*
+		 * Assume if we're sending the probe requests at OFDM bit
+		 * rates we don't want to advertise support for 802.11b rates.
+		 */
+		supported =3D wiphy_get_supported_rates(sc->wiphy,
+							NL80211_BAND_2GHZ);
+		if (!supported) {
+			L_WARN_ON(true);
+			return msg;
+		}
+
+		scan_rates =3D l_malloc(strlen((const char *) supported));
+
+		for (i =3D 0, count =3D 0; supported[i]; i++)
+			if (!memchr(b_rates, supported[i],
+					L_ARRAY_SIZE(b_rates)))
+				scan_rates[count++] =3D supported[i];
+
+		L_WARN_ON(!count);
+
+		l_genl_msg_enter_nested(msg, NL80211_ATTR_SCAN_SUPP_RATES);
+		l_genl_msg_append_attr(msg, NL80211_BAND_2GHZ, count,
+					scan_rates);
+		l_genl_msg_leave_nested(msg);
+		l_free(scan_rates);
+	}
+
 	return msg;
 }
 =

-- =

2.20.1

--===============1302963367137898061==--

