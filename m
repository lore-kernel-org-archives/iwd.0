Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23529A4F
	for <iwd@lists.linux.dev>; Wed,  8 Nov 2023 01:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjp.ie
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b="pjJVOo1J"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
	t=1699407294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rRPeS5jmj3/ANWQiKBtwTRSORPlucFS8dF5cXetTaTI=;
	b=pjJVOo1JPyx62g5NCk+U2zeeEPUzQOBKn6+p7Zuq32ZQSj9VLx2zBEF56A6ZiGRlbhN5dC
	v7JgUcQbT/hUpFCSxM/KmyL689V/Xm2ENjIPMmm9FFPNLc46HXtJekXHMietOGLckhyBZi
	+UtkmLdt5gxh+OIaFUW/G03FPlThm14=
From: Ronan Pigott <ronan@rjp.ie>
To: iwd@lists.linux.dev
Cc: Ronan Pigott <ronan@rjp.ie>
Subject: [PATCH] tree-wide: correct the spelling Ghz -> GHz
Date: Tue,  7 Nov 2023 18:33:54 -0700
Message-ID: <20231108013445.59080-1-ronan@rjp.ie>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This mispelling was present in the configuration, so I retained parsing
of the legacy BandModifier*Ghz options for compatibility. Without this
change anyone spelling GHz correctly in their configs would be very
confused.

---
 TODO               |  2 +-
 monitor/nlmon.c    |  2 +-
 src/ap.c           |  4 ++--
 src/iwd.config.rst | 10 +++++-----
 src/scan.c         | 14 +++++++++-----
 src/station.c      |  2 +-
 src/wiphy.c        |  4 ++--
 unit/test-band.c   |  4 ++--
 8 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/TODO b/TODO
index ac1cb683716f..b3a03bd6232d 100644
--- a/TODO
+++ b/TODO
@@ -286,7 +286,7 @@ Wireless daemon
 - Support OCE mutually non-overlapping channels optimization.
 
   OCE Section 3.10 mandates that the STA should scan channels 1, 6 and 11 in
-  the 2.4Ghz band first, unless it expects to find an AP on a different
+  the 2.4GHz band first, unless it expects to find an AP on a different
   channel.
 
   Priority: Low
diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index a4115a5b15f3..ed40264bacd6 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -2761,7 +2761,7 @@ static void print_wsc_configuration_error(unsigned int level, const char *label,
 		"Message timeout",
 		"Registration session timeout",
 		"Device Password Auth Failure",
-		"60 Ghz channel not supported",
+		"60 GHz channel not supported",
 		"Public Key Hash Mismatch",
 	};
 
diff --git a/src/ap.c b/src/ap.c
index 398e469a1c43..577f25a71def 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -1202,7 +1202,7 @@ static size_t ap_build_country_ie(struct ap_state *ap, uint8_t *out_buf,
 	 * and use the same TX power. Any deviation from this results in a new
 	 * channel group.
 	 *
-	 * TODO: 6Ghz requires operating triplets, not subband triplets.
+	 * TODO: 6GHz requires operating triplets, not subband triplets.
 	 */
 	for (i = 0; i < len; i++) {
 		const struct band_freq_attrs *attr = &list[i];
@@ -3564,7 +3564,7 @@ static bool ap_validate_band_channel(struct ap_state *ap)
 	freq = band_channel_to_freq(ap->channel, ap->band);
 	if (!freq) {
 		l_error("AP invalid band (%s) and channel (%u) combination",
-			(ap->band & BAND_FREQ_5_GHZ) ? "5Ghz" : "2.4GHz",
+			(ap->band & BAND_FREQ_5_GHZ) ? "5GHz" : "2.4GHz",
 			ap->channel);
 		return false;
 	}
diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index be2fd18c48e9..d9c94e01c297 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -122,7 +122,7 @@ The group ``[General]`` contains general settings.
      - Value: rssi dBm value, from -100 to 1, default: **-70**
 
        This value can be used to control how aggressively **iwd** roams when
-       connected to a 2.4Ghz access point.
+       connected to a 2.4GHz access point.
 
    * - RoamThreshold5G
      - Value: rssi dBm value, from -100 to 1, default: **-76**
@@ -291,7 +291,7 @@ autoconnect purposes.
    :widths: 20 80
    :align: left
 
-   * - BandModifier2_4Ghz
+   * - BandModifier2_4GHz
      - Values: floating point value (default: **1.0**)
 
        Increase or decrease the preference for 2.4GHz access points by
@@ -300,19 +300,19 @@ autoconnect purposes.
        A value of 0.0 will disable the 2.4GHz band and prevent scanning or
        connecting on those frequencies.
 
-   * - BandModifier5Ghz
+   * - BandModifier5GHz
      - Values: floating point value (default: **1.0**)
 
        Increase or decrease the preference for 5GHz access points by increasing
        or decreasing the value of this modifier.  5GHz networks are already
        preferred due to their increase throughput / data rate.  However, 5GHz
        networks are highly RSSI sensitive, so it is still possible for IWD to
-       prefer 2.4Ghz APs in certain circumstances.
+       prefer 2.4GHz APs in certain circumstances.
 
        A value of 0.0 will disable the 5GHz band and prevent scanning or
        connecting on those frequencies.
 
-   * - BandModifier6Ghz
+   * - BandModifier6GHz
      - Values: floating point value (default: **1.0**)
 
        Increase or decrease the preference for 6GHz access points by increasing
diff --git a/src/scan.c b/src/scan.c
index 8cb39d7a1edb..5aa92a90661c 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -2333,24 +2333,28 @@ double scan_get_band_rank_modifier(enum band_freq band)
 {
 	const struct l_settings *config = iwd_get_config();
 	double modifier;
-	char *str;
+	char *str, *str_legacy;
 
 	switch (band) {
 	case BAND_FREQ_2_4_GHZ:
-		str = "BandModifier2_4Ghz";
+		str = "BandModifier2_4GHz";
+		str_legacy = "BandModifier2_4Ghz";
 		break;
 	case BAND_FREQ_5_GHZ:
-		str = "BandModifier5Ghz";
+		str = "BandModifier5GHz";
+		str_legacy = "BandModifier5Ghz";
 		break;
 	case BAND_FREQ_6_GHZ:
-		str = "BandModifier6Ghz";
+		str = "BandModifier6GHz";
+		str_legacy = "BandModifier6Ghz";
 		break;
 	default:
 		l_warn("Unhandled band %u", band);
 		return 0.0;
 	}
 
-	if (!l_settings_get_double(config, "Rank", str, &modifier))
+	if (!l_settings_get_double(config, "Rank", str, &modifier) &&
+		!l_settings_get_double(config, "Rank", str_legacy, &modifier))
 		modifier = 1.0;
 
 	return modifier;
diff --git a/src/station.c b/src/station.c
index ee229fc27d79..ff8a74661578 100644
--- a/src/station.c
+++ b/src/station.c
@@ -4435,7 +4435,7 @@ static void station_wiphy_watch(struct wiphy *wiphy,
 	/*
 	 * The only state that requires special handling is for
 	 * quick scans since the previous quick scan was delayed until
-	 * the regulatory domain updated. Try again in case 6Ghz is now
+	 * the regulatory domain updated. Try again in case 6GHz is now
 	 * unlocked (unlikely), or advance to full autoconnect. Just in
 	 * case this update came during a quick scan, ignore it.
 	 */
diff --git a/src/wiphy.c b/src/wiphy.c
index 776a10ee8b0b..570f54155717 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -1262,10 +1262,10 @@ static void wiphy_print_basic_info(struct wiphy *wiphy)
 	l_info("\tPermanent Address: "MAC, MAC_STR(wiphy->permanent_addr));
 
 	if (wiphy->band_2g)
-		wiphy_print_band_info(wiphy->band_2g, "2.4Ghz Band");
+		wiphy_print_band_info(wiphy->band_2g, "2.4GHz Band");
 
 	if (wiphy->band_5g)
-		wiphy_print_band_info(wiphy->band_5g, "5Ghz Band");
+		wiphy_print_band_info(wiphy->band_5g, "5GHz Band");
 
 	if (wiphy->band_6g)
 		wiphy_print_band_info(wiphy->band_6g, "6GHz Band");
diff --git a/unit/test-band.c b/unit/test-band.c
index e27531f79613..8140b2725efc 100644
--- a/unit/test-band.c
+++ b/unit/test-band.c
@@ -654,8 +654,8 @@ static void test_conversions(const void *data)
 {
 	/*
 	 * Test a few invalid channels/frequencies that appear valid but are
-	 * not in the E-4 table. The checks in band.c seem to cover 2.4Ghz and
-	 * 6Ghz very well since there are no gaps, but the 5GHz band has some
+	 * not in the E-4 table. The checks in band.c seem to cover 2.4GHz and
+	 * 6GHz very well since there are no gaps, but the 5GHz band has some
 	 * segmentation.
 	 */
 
-- 
2.42.1

