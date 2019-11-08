Content-Type: multipart/mixed; boundary="===============4260471948896544953=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 4/4] scan: Separate cck rates attr creation into logical block
Date: Fri, 08 Nov 2019 17:04:02 -0500
Message-ID: <20191108220402.10282-4-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191108220402.10282-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4260471948896544953==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/scan.c | 82 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 42 insertions(+), 40 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index a3d6e5d8..f99ad1e7 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -308,6 +308,45 @@ static void scan_build_attr_ie(struct l_genl_msg *msg,
 	l_genl_msg_append_attrv(msg, NL80211_ATTR_IE, iov, iov_elems);
 }
 =

+static void scan_build_attr_tx_no_cck_rates(struct l_genl_msg *msg,
+							struct scan_context *sc)
+{
+	static const uint8_t b_rates[] =3D { 2, 4, 11, 22 };
+	uint8_t *scan_rates;
+	const uint8_t *supported;
+	unsigned int num_supported;
+	unsigned int count;
+	unsigned int i;
+
+	l_genl_msg_append_attr(msg, NL80211_ATTR_TX_NO_CCK_RATE, 0, NULL);
+
+	/*
+	 * Assume if we're sending the probe requests at OFDM bit
+	 * rates we don't want to advertise support for 802.11b rates.
+	 */
+	if (L_WARN_ON(!(supported =3D wiphy_get_supported_rates(sc->wiphy,
+							NL80211_BAND_2GHZ,
+							&num_supported))))
+		return;
+
+	scan_rates =3D l_malloc(num_supported);
+
+	for (count =3D 0, i =3D 0; i < num_supported; i++)
+		if (!memchr(b_rates, supported[i], L_ARRAY_SIZE(b_rates)))
+			scan_rates[count++] =3D supported[i];
+
+	if (L_WARN_ON(!count)) {
+		l_free(scan_rates);
+		return;
+	}
+
+	l_genl_msg_enter_nested(msg, NL80211_ATTR_SCAN_SUPP_RATES);
+	l_genl_msg_append_attr(msg, NL80211_BAND_2GHZ, count, scan_rates);
+	l_genl_msg_leave_nested(msg);
+
+	l_free(scan_rates);
+}
+
 static bool scan_mac_address_randomization_is_disabled(void)
 {
 	const struct l_settings *config =3D iwd_get_config();
@@ -338,6 +377,9 @@ static struct l_genl_msg *scan_build_cmd(struct scan_co=
ntext *sc,
 	if (params->freqs)
 		scan_build_attr_scan_frequencies(msg, params->freqs);
 =

+	if (params->no_cck_rates)
+		scan_build_attr_tx_no_cck_rates(msg, sc);
+
 	if (params->flush && !ignore_flush_flag)
 		flags |=3D NL80211_SCAN_FLAG_FLUSH;
 =

@@ -357,46 +399,6 @@ static struct l_genl_msg *scan_build_cmd(struct scan_c=
ontext *sc,
 	if (flags)
 		l_genl_msg_append_attr(msg, NL80211_ATTR_SCAN_FLAGS, 4, &flags);
 =

-	if (params->no_cck_rates) {
-		static const uint8_t b_rates[] =3D { 2, 4, 11, 22 };
-		uint8_t *scan_rates;
-		const uint8_t *supported;
-		unsigned int num_supported;
-		unsigned int count;
-		unsigned int i;
-
-		l_genl_msg_append_attr(msg, NL80211_ATTR_TX_NO_CCK_RATE, 0,
-					NULL);
-
-		/*
-		 * Assume if we're sending the probe requests at OFDM bit
-		 * rates we don't want to advertise support for 802.11b rates.
-		 */
-		if (L_WARN_ON(!(supported =3D wiphy_get_supported_rates(sc->wiphy,
-							NL80211_BAND_2GHZ,
-							&num_supported))))
-			goto done;
-
-		scan_rates =3D l_malloc(num_supported);
-
-		for (count =3D 0, i =3D 0; i < num_supported; i++)
-			if (!memchr(b_rates, supported[i],
-						L_ARRAY_SIZE(b_rates)))
-				scan_rates[count++] =3D supported[i];
-
-		if (L_WARN_ON(!count)) {
-			l_free(scan_rates);
-			goto done;
-		}
-
-		l_genl_msg_enter_nested(msg, NL80211_ATTR_SCAN_SUPP_RATES);
-		l_genl_msg_append_attr(msg, NL80211_BAND_2GHZ,
-							count, scan_rates);
-		l_genl_msg_leave_nested(msg);
-		l_free(scan_rates);
-	}
-
-done:
 	return msg;
 }
 =

-- =

2.21.0

--===============4260471948896544953==--

