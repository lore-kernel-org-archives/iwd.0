Content-Type: multipart/mixed; boundary="===============8153564796894966540=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/9] station: start FT-over-DS actions after roaming
Date: Tue, 28 Sep 2021 14:27:37 -0700
Message-ID: <20210928212744.717276-2-prestwoj@gmail.com>
In-Reply-To: 20210928212744.717276-1-prestwoj@gmail.com

--===============8153564796894966540==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Once roamed IWD never sent out any FT Request frames. This prevented
FT-over-DS from being used after an initial roam.
---
 src/station.c | 149 +++++++++++++++++++++++++-------------------------
 1 file changed, 74 insertions(+), 75 deletions(-)

diff --git a/src/station.c b/src/station.c
index 2e7fd0f9..f12cdde5 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1729,6 +1729,77 @@ static void station_early_neighbor_report_cb(struct =
netdev *netdev, int err,
 				&station->roam_freqs);
 }
 =

+static bool station_can_fast_transition(struct handshake_state *hs,
+					struct scan_bss *bss)
+{
+	uint16_t mdid;
+
+	if (!hs->mde)
+		return false;
+
+	if (ie_parse_mobility_domain_from_data(hs->mde, hs->mde[1] + 2,
+						&mdid, NULL, NULL) < 0)
+		return false;
+
+	if (!(bss->mde_present && l_get_le16(bss->mde) =3D=3D mdid))
+		return false;
+
+	if (hs->supplicant_ie !=3D NULL) {
+		struct ie_rsn_info rsn_info;
+
+		if (!IE_AKM_IS_FT(hs->akm_suite))
+			return false;
+
+		if (scan_bss_get_rsn_info(bss, &rsn_info) < 0)
+			return false;
+
+		if (!IE_AKM_IS_FT(rsn_info.akm_suites))
+			return false;
+	}
+
+	return true;
+}
+
+static void station_ft_ds_action_start(struct station *station)
+{
+	struct handshake_state *hs =3D netdev_get_handshake(station->netdev);
+	uint16_t mdid;
+	const struct l_queue_entry *entry;
+	struct scan_bss *bss;
+	struct ie_rsn_info rsn_info;
+
+	if (!station_can_fast_transition(hs, station->connected_bss) ||
+						!(hs->mde[4] & 1))
+		return;
+
+	if (ie_parse_mobility_domain_from_data(hs->mde, hs->mde[1] + 2,
+						&mdid, NULL, NULL) < 0)
+		return;
+
+	for (entry =3D network_bss_list_get_entries(station->connected_network);
+						entry; entry =3D entry->next) {
+		bss =3D entry->data;
+
+		if (bss =3D=3D station->connected_bss)
+			continue;
+
+		if (mdid !=3D l_get_le16(bss->mde))
+			continue;
+
+		if (scan_bss_get_rsn_info(bss, &rsn_info) < 0)
+			continue;
+
+		if (!IE_AKM_IS_FT(rsn_info.akm_suites))
+			continue;
+
+		/*
+		* Fire and forget. Netdev will maintain a cache of responses and
+		* when the time comes these can be referenced for a roam
+		*/
+		netdev_fast_transition_over_ds_action(station->netdev, bss);
+	}
+}
+
 static void station_roamed(struct station *station)
 {
 	station->roam_scan_full =3D false;
@@ -1754,6 +1825,8 @@ static void station_roamed(struct station *station)
 			l_warn("Could not request neighbor report");
 	}
 =

+	station_ft_ds_action_start(station);
+
 	station_enter_state(station, STATION_STATE_CONNECTED);
 }
 =

@@ -1957,37 +2030,6 @@ static void station_preauthenticate_cb(struct netdev=
 *netdev,
 	station_transition_reassociate(station, bss, new_hs);
 }
 =

-static bool station_can_fast_transition(struct handshake_state *hs,
-					struct scan_bss *bss)
-{
-	uint16_t mdid;
-
-	if (!hs->mde)
-		return false;
-
-	if (ie_parse_mobility_domain_from_data(hs->mde, hs->mde[1] + 2,
-						&mdid, NULL, NULL) < 0)
-		return false;
-
-	if (!(bss->mde_present && l_get_le16(bss->mde) =3D=3D mdid))
-		return false;
-
-	if (hs->supplicant_ie !=3D NULL) {
-		struct ie_rsn_info rsn_info;
-
-		if (!IE_AKM_IS_FT(hs->akm_suite))
-			return false;
-
-		if (scan_bss_get_rsn_info(bss, &rsn_info) < 0)
-			return false;
-
-		if (!IE_AKM_IS_FT(rsn_info.akm_suites))
-			return false;
-	}
-
-	return true;
-}
-
 static void station_transition_start(struct station *station,
 							struct scan_bss *bss)
 {
@@ -2624,36 +2666,6 @@ static bool station_retry_with_status(struct station=
 *station,
 	return station_try_next_bss(station);
 }
 =

-static void station_ft_ds_action_start(struct station *station, uint16_t m=
did)
-{
-	const struct l_queue_entry *entry;
-	struct scan_bss *bss;
-	struct ie_rsn_info rsn_info;
-
-	for (entry =3D network_bss_list_get_entries(station->connected_network);
-						entry; entry =3D entry->next) {
-		bss =3D entry->data;
-
-		if (bss =3D=3D station->connected_bss)
-			continue;
-
-		if (mdid !=3D l_get_le16(bss->mde))
-			continue;
-
-		if (scan_bss_get_rsn_info(bss, &rsn_info) < 0)
-			continue;
-
-		if (!IE_AKM_IS_FT(rsn_info.akm_suites))
-			continue;
-
-		/*
-		* Fire and forget. Netdev will maintain a cache of responses and
-		* when the time comes these can be referenced for a roam
-		*/
-		netdev_fast_transition_over_ds_action(station->netdev, bss);
-	}
-}
-
 static void station_connect_ok(struct station *station)
 {
 	struct handshake_state *hs =3D netdev_get_handshake(station->netdev);
@@ -2677,20 +2689,7 @@ static void station_connect_ok(struct station *stati=
on)
 			l_warn("Could not request neighbor report");
 	}
 =

-	/*
-	 * If this network supports FT-over-DS send initial action frames now
-	 * to prepare for future roams.
-	 */
-	if (station_can_fast_transition(hs, station->connected_bss) &&
-						(hs->mde[4] & 1)) {
-		uint16_t mdid;
-
-		if (ie_parse_mobility_domain_from_data(hs->mde, hs->mde[1] + 2,
-						&mdid, NULL, NULL) < 0)
-			return;
-
-		station_ft_ds_action_start(station, mdid);
-	}
+	station_ft_ds_action_start(station);
 =

 	network_connected(station->connected_network);
 =

-- =

2.31.1

--===============8153564796894966540==--

