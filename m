Content-Type: multipart/mixed; boundary="===============6930037222882960447=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] station: get neighbor report after roaming
Date: Mon, 29 Mar 2021 12:07:42 -0700
Message-ID: <20210329190742.713249-3-prestwoj@gmail.com>
In-Reply-To: <20210329190742.713249-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6930037222882960447==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In the same vein as requesting a neighbor report after
connecting for the first time, it should also be done
after a roam to obtain the latest neighbor information.
---
 src/station.c | 354 +++++++++++++++++++++++++-------------------------
 1 file changed, 180 insertions(+), 174 deletions(-)

diff --git a/src/station.c b/src/station.c
index acf77ec8..cf4dd2e7 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1428,6 +1428,180 @@ static void station_roam_timeout_rearm(struct stati=
on *station, int seconds);
 static int station_roam_scan(struct station *station,
 				struct scan_freq_set *freq_set);
 =

+static uint32_t station_freq_from_neighbor_report(const uint8_t *country,
+		struct ie_neighbor_report_info *info, enum scan_band *out_band)
+{
+	enum scan_band band;
+	uint32_t freq;
+
+	if (info->oper_class =3D=3D 0) {
+		/*
+		 * Some Cisco APs report all operating class values as 0
+		 * in the Neighbor Report Responses.  Work around this by
+		 * using the most likely operating class for the channel
+		 * number as the 2.4GHz and 5GHz bands happen to mostly
+		 * use channels in two disjoint ranges.
+		 */
+		if (info->channel_num >=3D 1 && info->channel_num <=3D 14)
+			band =3D SCAN_BAND_2_4_GHZ;
+		else if (info->channel_num >=3D 36 && info->channel_num <=3D 169)
+			band =3D SCAN_BAND_5_GHZ;
+		else {
+			l_debug("Ignored: 0 oper class with an unusual "
+				"channel number");
+
+			return 0;
+		}
+	} else {
+		band =3D scan_oper_class_to_band(country, info->oper_class);
+		if (!band) {
+			l_debug("Ignored: unsupported oper class");
+
+			return 0;
+		}
+	}
+
+	freq =3D scan_channel_to_freq(info->channel_num, band);
+	if (!freq) {
+		l_debug("Ignored: unsupported channel");
+
+		return 0;
+	}
+
+	if (out_band)
+		*out_band =3D band;
+
+	return freq;
+}
+
+static void parse_neighbor_report(struct station *station,
+					const uint8_t *reports,
+					size_t reports_len,
+					struct scan_freq_set **set)
+{
+	struct ie_tlv_iter iter;
+	int count_md =3D 0, count_no_md =3D 0;
+	struct scan_freq_set *freq_set_md, *freq_set_no_md;
+	uint32_t current_freq =3D 0;
+	struct handshake_state *hs =3D netdev_get_handshake(station->netdev);
+
+	freq_set_md =3D scan_freq_set_new();
+	freq_set_no_md =3D scan_freq_set_new();
+
+	ie_tlv_iter_init(&iter, reports, reports_len);
+
+	/* First see if any of the reports contain the MD bit set */
+	while (ie_tlv_iter_next(&iter)) {
+		struct ie_neighbor_report_info info;
+		uint32_t freq;
+		enum scan_band band;
+		const uint8_t *cc =3D NULL;
+
+		if (ie_tlv_iter_get_tag(&iter) !=3D IE_TYPE_NEIGHBOR_REPORT)
+			continue;
+
+		if (ie_parse_neighbor_report(&iter, &info) < 0)
+			continue;
+
+		l_debug("Neighbor report received for %s: ch %i "
+				"(oper class %i), %s",
+				util_address_to_string(info.addr),
+				(int) info.channel_num, (int) info.oper_class,
+				info.md ? "MD set" : "MD not set");
+
+		if (station->connected_bss->cc_present)
+			cc =3D station->connected_bss->cc;
+
+		freq =3D station_freq_from_neighbor_report(cc, &info, &band);
+		if (!freq)
+			continue;
+
+		/* Skip if the band is not supported */
+		if (!(band & wiphy_get_supported_bands(station->wiphy)))
+			continue;
+
+		if (!memcmp(info.addr,
+				station->connected_bss->addr, ETH_ALEN)) {
+			/*
+			 * If this report is for the current AP, don't add
+			 * it to any of the lists yet.  We will need to scan
+			 * its channel because it may still be the best ranked
+			 * or the only visible AP.
+			 */
+			current_freq =3D freq;
+
+			continue;
+		}
+
+		/* Add the frequency to one of the lists */
+		if (info.md && hs->mde) {
+			scan_freq_set_add(freq_set_md, freq);
+
+			count_md +=3D 1;
+		} else {
+			scan_freq_set_add(freq_set_no_md, freq);
+
+			count_no_md +=3D 1;
+		}
+	}
+
+	if (!current_freq)
+		current_freq =3D station->connected_bss->frequency;
+
+	/*
+	 * If there are neighbor reports with the MD bit set then the bit
+	 * is probably valid so scan only the frequencies of the neighbors
+	 * with that bit set, which will allow us to use Fast Transition.
+	 * Some APs, such as those based on hostapd do not set the MD bit
+	 * even if the neighbor is within the MD.
+	 *
+	 * In any case we only select the frequencies here and will check
+	 * the IEs in the scan results as the authoritative information
+	 * on whether we can use Fast Transition, and rank BSSes based on
+	 * that.
+	 *
+	 * TODO: possibly save the neighbors from outside the MD and if
+	 * none of the ones in the MD end up working, try a non-FT
+	 * transition to those neighbors.  We should be using a
+	 * blacklisting mechanism (for both initial connection and
+	 * transitions) so that cound_md would not count the
+	 * BSSes already used and when it goes down to 0 we'd
+	 * automatically fall back to the non-FT candidates and then to
+	 * full scan.
+	 */
+	if (count_md) {
+		scan_freq_set_add(freq_set_md, current_freq);
+		*set =3D freq_set_md;
+		scan_freq_set_free(freq_set_no_md);
+	} else if (count_no_md) {
+		scan_freq_set_add(freq_set_no_md, current_freq);
+		*set =3D freq_set_no_md;
+		scan_freq_set_free(freq_set_md);
+	} else {
+		scan_freq_set_free(freq_set_no_md);
+		scan_freq_set_free(freq_set_md);
+		*set =3D NULL;
+	}
+}
+
+static void station_early_neighbor_report_cb(struct netdev *netdev, int er=
r,
+						const uint8_t *reports,
+						size_t reports_len,
+						void *user_data)
+{
+	struct station *station =3D user_data;
+
+	l_debug("ifindex: %u, error: %d(%s)",
+			netdev_get_ifindex(station->netdev),
+			err, err < 0 ? strerror(-err) : "");
+
+	if (!reports || err)
+		return;
+
+	parse_neighbor_report(station, reports, reports_len,
+				&station->roam_freqs);
+}
+
 static void station_roamed(struct station *station)
 {
 	station->roam_scan_full =3D false;
@@ -1447,6 +1621,12 @@ static void station_roamed(struct station *station)
 		station->roam_freqs =3D NULL;
 	}
 =

+	if (station->connected_bss->cap_rm_neighbor_report) {
+		if (netdev_neighbor_report_req(station->netdev,
+					station_early_neighbor_report_cb) < 0)
+			l_warn("Could not request neighbor report");
+	}
+
 	station_enter_state(station, STATION_STATE_CONNECTED);
 }
 =

@@ -1920,162 +2100,6 @@ static int station_roam_scan_known_freqs(struct sta=
tion *station)
 	return r;
 }
 =

-static uint32_t station_freq_from_neighbor_report(const uint8_t *country,
-		struct ie_neighbor_report_info *info, enum scan_band *out_band)
-{
-	enum scan_band band;
-	uint32_t freq;
-
-	if (info->oper_class =3D=3D 0) {
-		/*
-		 * Some Cisco APs report all operating class values as 0
-		 * in the Neighbor Report Responses.  Work around this by
-		 * using the most likely operating class for the channel
-		 * number as the 2.4GHz and 5GHz bands happen to mostly
-		 * use channels in two disjoint ranges.
-		 */
-		if (info->channel_num >=3D 1 && info->channel_num <=3D 14)
-			band =3D SCAN_BAND_2_4_GHZ;
-		else if (info->channel_num >=3D 36 && info->channel_num <=3D 169)
-			band =3D SCAN_BAND_5_GHZ;
-		else {
-			l_debug("Ignored: 0 oper class with an unusual "
-				"channel number");
-
-			return 0;
-		}
-	} else {
-		band =3D scan_oper_class_to_band(country, info->oper_class);
-		if (!band) {
-			l_debug("Ignored: unsupported oper class");
-
-			return 0;
-		}
-	}
-
-	freq =3D scan_channel_to_freq(info->channel_num, band);
-	if (!freq) {
-		l_debug("Ignored: unsupported channel");
-
-		return 0;
-	}
-
-	if (out_band)
-		*out_band =3D band;
-
-	return freq;
-}
-
-static void parse_neighbor_report(struct station *station,
-					const uint8_t *reports,
-					size_t reports_len,
-					struct scan_freq_set **set)
-{
-	struct ie_tlv_iter iter;
-	int count_md =3D 0, count_no_md =3D 0;
-	struct scan_freq_set *freq_set_md, *freq_set_no_md;
-	uint32_t current_freq =3D 0;
-	struct handshake_state *hs =3D netdev_get_handshake(station->netdev);
-
-	freq_set_md =3D scan_freq_set_new();
-	freq_set_no_md =3D scan_freq_set_new();
-
-	ie_tlv_iter_init(&iter, reports, reports_len);
-
-	/* First see if any of the reports contain the MD bit set */
-	while (ie_tlv_iter_next(&iter)) {
-		struct ie_neighbor_report_info info;
-		uint32_t freq;
-		enum scan_band band;
-		const uint8_t *cc =3D NULL;
-
-		if (ie_tlv_iter_get_tag(&iter) !=3D IE_TYPE_NEIGHBOR_REPORT)
-			continue;
-
-		if (ie_parse_neighbor_report(&iter, &info) < 0)
-			continue;
-
-		l_debug("Neighbor report received for %s: ch %i "
-				"(oper class %i), %s",
-				util_address_to_string(info.addr),
-				(int) info.channel_num, (int) info.oper_class,
-				info.md ? "MD set" : "MD not set");
-
-		if (station->connected_bss->cc_present)
-			cc =3D station->connected_bss->cc;
-
-		freq =3D station_freq_from_neighbor_report(cc, &info, &band);
-		if (!freq)
-			continue;
-
-		/* Skip if the band is not supported */
-		if (!(band & wiphy_get_supported_bands(station->wiphy)))
-			continue;
-
-		if (!memcmp(info.addr,
-				station->connected_bss->addr, ETH_ALEN)) {
-			/*
-			 * If this report is for the current AP, don't add
-			 * it to any of the lists yet.  We will need to scan
-			 * its channel because it may still be the best ranked
-			 * or the only visible AP.
-			 */
-			current_freq =3D freq;
-
-			continue;
-		}
-
-		/* Add the frequency to one of the lists */
-		if (info.md && hs->mde) {
-			scan_freq_set_add(freq_set_md, freq);
-
-			count_md +=3D 1;
-		} else {
-			scan_freq_set_add(freq_set_no_md, freq);
-
-			count_no_md +=3D 1;
-		}
-	}
-
-	if (!current_freq)
-		current_freq =3D station->connected_bss->frequency;
-
-	/*
-	 * If there are neighbor reports with the MD bit set then the bit
-	 * is probably valid so scan only the frequencies of the neighbors
-	 * with that bit set, which will allow us to use Fast Transition.
-	 * Some APs, such as those based on hostapd do not set the MD bit
-	 * even if the neighbor is within the MD.
-	 *
-	 * In any case we only select the frequencies here and will check
-	 * the IEs in the scan results as the authoritative information
-	 * on whether we can use Fast Transition, and rank BSSes based on
-	 * that.
-	 *
-	 * TODO: possibly save the neighbors from outside the MD and if
-	 * none of the ones in the MD end up working, try a non-FT
-	 * transition to those neighbors.  We should be using a
-	 * blacklisting mechanism (for both initial connection and
-	 * transitions) so that cound_md would not count the
-	 * BSSes already used and when it goes down to 0 we'd
-	 * automatically fall back to the non-FT candidates and then to
-	 * full scan.
-	 */
-	if (count_md) {
-		scan_freq_set_add(freq_set_md, current_freq);
-		*set =3D freq_set_md;
-		scan_freq_set_free(freq_set_no_md);
-	} else if (count_no_md) {
-		scan_freq_set_add(freq_set_no_md, current_freq);
-		*set =3D freq_set_no_md;
-		scan_freq_set_free(freq_set_md);
-	} else {
-		scan_freq_set_free(freq_set_no_md);
-		scan_freq_set_free(freq_set_md);
-		*set =3D NULL;
-	}
-}
-
 static void station_neighbor_report_cb(struct netdev *netdev, int err,
 					const uint8_t *reports,
 					size_t reports_len, void *user_data)
@@ -2461,24 +2485,6 @@ static void station_connect_dbus_reply(struct statio=
n *station,
 	dbus_pending_reply(&station->connect_pending, reply);
 }
 =

-static void station_early_neighbor_report_cb(struct netdev *netdev, int er=
r,
-						const uint8_t *reports,
-						size_t reports_len,
-						void *user_data)
-{
-	struct station *station =3D user_data;
-
-	l_debug("ifindex: %u, error: %d(%s)",
-			netdev_get_ifindex(station->netdev),
-			err, err < 0 ? strerror(-err) : "");
-
-	if (!reports || err)
-		return;
-
-	parse_neighbor_report(station, reports, reports_len,
-				&station->roam_freqs);
-}
-
 static void station_connect_cb(struct netdev *netdev, enum netdev_result r=
esult,
 					void *event_data, void *user_data)
 {
-- =

2.26.2

--===============6930037222882960447==--

