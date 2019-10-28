Content-Type: multipart/mixed; boundary="===============8194850621707707767=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 02/16] scan: Hide CCK rates if no_cck_rates set
Date: Mon, 28 Oct 2019 15:04:54 +0100
Message-ID: <20191028140508.13518-2-andrew.zaborowski@intel.com>
In-Reply-To: <20191028140508.13518-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8194850621707707767==
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
index c0c3177e..0ec7831c 100644
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
+		unsigned int num_supported;
+		unsigned int count;
+
 		l_genl_msg_append_attr(msg, NL80211_ATTR_TX_NO_CCK_RATE, 0,
 					NULL);
 =

+		/*
+		 * Assume if we're sending the probe requests at OFDM bit
+		 * rates we don't want to advertise support for 802.11b rates.
+		 */
+		supported =3D wiphy_get_supported_rates(sc->wiphy,
+							NL80211_BAND_2GHZ,
+							&num_supported);
+		if (!supported) {
+			L_WARN_ON(true);
+			return msg;
+		}
+
+		scan_rates =3D l_malloc(num_supported);
+
+		for (count =3D 0; *supported; supported++)
+			if (!memchr(b_rates, *supported, L_ARRAY_SIZE(b_rates)))
+				scan_rates[count++] =3D *supported;
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

--===============8194850621707707767==--

