Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A72C28F9
	for <iwd@lists.linux.dev>; Thu,  4 Aug 2022 18:51:18 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id d7so630366pgc.13
        for <iwd@lists.linux.dev>; Thu, 04 Aug 2022 11:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=VUGZsRjXnvMMiol65M/eC5toD4JAQnOrf4VlNwDGoWM=;
        b=Wc71uQs/PS1NcQtl2vKQv7cWA1mTHmf37enmyfjh08D6mdL6yHUrwSafKFQfrR+Auj
         5fTNl1GPxoPF0uyk0AcQ4/VBebHCw8gulYCNZqxTKciBFTLwOOIA9KBGVrOdEPSU26DC
         C0YlR5cQT/d0QXhNZKEoZXO6VqgldPEhpitKZzwe8HKoLi9HTqF2WLXthdVBgfli5MXx
         DWJfv5eUWj7uERqRcF2ezHmNC7/gFQ3/IgIHAloHabV3cWu2b3lZAEHjtafrNkQIPySY
         WfsPakNztcA7OGcrLSgl6ZxSbUsrZB+w4iXZVDdOqRW5amzBf/M2Jn89z9sKirJnRHgp
         KZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=VUGZsRjXnvMMiol65M/eC5toD4JAQnOrf4VlNwDGoWM=;
        b=zqWNPvrOordQxhpZLnj2SV+V65uyTni5lrVAame8jmHQqGqZZMOpkZtW9J+QoeDae7
         FDW5Obrwevnup07lHkpZ2mY8wT1GBgbTdc+O5hbr4YQaaMq2MwfgKDLc6+aar8uid7Jj
         uFpR8lYIZUzyfUhYk84KAPw66t3NNCF7ONGqYYsiTHQZFnbcJMtOq1HsiVG24UdnZYB6
         KrEWDzbhz7bFkp1L3yIBluyUp40vVezm9CnP3ZAWufGNdEIzn5AVyzcIYggiIHloqajC
         85eZUchFUWqfthoYfxqBuGB/JPrVXf0Nh0HZU/MeXQC1gmmxmcaPAHtThFvzJGeMY5EW
         I+Sw==
X-Gm-Message-State: ACgBeo1Uuvk9nrOalSOZPpkutAGe2N1XtdYWLc/eMSCbQ6mjPnH2QDC+
	0ESVaV3xWoIc+oGl5lSoeZb76bKLmC8=
X-Google-Smtp-Source: AA6agR7MHtSHNMr/EEdDaPLgQsKnAzykpBBMCPfSl9XEP1oc0TLHJ2vRPKl1eElDlSB1k3Xm3VPlPw==
X-Received: by 2002:a05:6a00:b55:b0:52a:db7b:2880 with SMTP id p21-20020a056a000b5500b0052adb7b2880mr3020087pfo.22.1659639077566;
        Thu, 04 Aug 2022 11:51:17 -0700 (PDT)
Received: from jprestwo-xps.none ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id c7-20020a634e07000000b0041b3c112b1esm219954pgb.29.2022.08.04.11.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 11:51:17 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 4/7] station: do full passive scan if 6GHz is supported but disabled.
Date: Thu,  4 Aug 2022 11:51:09 -0700
Message-Id: <20220804185112.457670-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220804185112.457670-1-prestwoj@gmail.com>
References: <20220804185112.457670-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel handles setting the regulatory domain by receiving beacons which
set the country IE. Presumably since most regulatory domains disallow 6GHz
the default (world) domain also disables it. This means until the country
is set, 6GHz is disabled.

This poses a problem for IWD's quick scanning since it only scans a few
frequencies and this likely isn't enough beacons for the firmware to update
the country, leaving 6Ghz inaccessable to the user without manual intervention
(e.g. iw scan passive, or periodic scans by IWD).

To try and work around this limitation the quick scan logic has been updated
to check if a 6GHz AP has been connected to before and if that frequency is
disabled (but supported). If this is the case IWD will opt for a full passive
scan rather than scanning a limited set of frequencies.
---
 src/station.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

v3:
 * Return -EAGAIN in the case of a regdom update rather than 0. Check this
   along with 0 in both calls.
 * Re-worked the wiphy state event to focus only on the DONE event, and set
   regdom_updated based on wiphy_regdom_is_updating. This avoids a switch
   statement when its mainly the DONE event we care about.
 * Check quick_scan_id if regdom update so we aren't accidentally re-triggering
   a quick scan.

diff --git a/src/station.c b/src/station.c
index e39e9d4b..e3a36f46 100644
--- a/src/station.c
+++ b/src/station.c
@@ -112,6 +112,8 @@ struct station {
 	struct scan_freq_set *scan_freqs_order[3];
 	unsigned int dbus_scan_subset_idx;
 
+	uint32_t wiphy_watch;
+
 	bool preparing_roam : 1;
 	bool roam_scan_full : 1;
 	bool signal_low : 1;
@@ -119,6 +121,7 @@ struct station {
 	bool scanning : 1;
 	bool autoconnect : 1;
 	bool autoconnect_can_start : 1;
+	bool regdom_updating : 1;
 };
 
 struct anqp_entry {
@@ -1353,11 +1356,36 @@ static void station_quick_scan_destroy(void *userdata)
 static int station_quick_scan_trigger(struct station *station)
 {
 	struct scan_freq_set *known_freq_set;
+	bool known_6ghz;
+	const struct scan_freq_set *disabled = wiphy_get_disabled_freqs(
+								station->wiphy);
+
+	if (station->regdom_updating) {
+		l_debug("regdom is updating, delaying quick scan");
+
+		return -EAGAIN;
+	}
 
 	known_freq_set = known_networks_get_recent_frequencies(5);
 	if (!known_freq_set)
 		return -ENODATA;
 
+	known_6ghz = scan_freq_set_get_bands(known_freq_set) & BAND_FREQ_6_GHZ;
+
+	/*
+	 * This means IWD has previously connected to a 6GHz AP before, but now
+	 * the regulatory domain disallows 6GHz likely caused by a reboot, the
+	 * firmware going down, or a regulatory update. The only way to
+	 * re-enable 6GHz is to get enough beacons via scanning for the firmware
+	 * to set the regulatory domain. A quick scan is very unlikely to do
+	 * this since its so limited, so return an error which will fall back to
+	 * full autoconnect.
+	 */
+	if ((scan_freq_set_get_bands(disabled) & BAND_FREQ_6_GHZ) &&
+				wiphy_country_is_unknown(station->wiphy) &&
+				known_6ghz)
+		return -ENOTSUP;
+
 	if (!wiphy_constrain_freq_set(station->wiphy, known_freq_set)) {
 		scan_freq_set_free(known_freq_set);
 		return -ENOTSUP;
@@ -1446,6 +1474,7 @@ static void station_enter_state(struct station *station,
 	uint64_t id = netdev_get_wdev_id(station->netdev);
 	struct l_dbus *dbus = dbus_get_bus();
 	bool disconnected;
+	int ret;
 
 	l_debug("Old State: %s, new state: %s",
 			station_state_to_string(station->state),
@@ -1462,7 +1491,8 @@ static void station_enter_state(struct station *station,
 
 	switch (state) {
 	case STATION_STATE_AUTOCONNECT_QUICK:
-		if (!station_quick_scan_trigger(station))
+		ret = station_quick_scan_trigger(station);
+		if (ret == 0 || ret == -EAGAIN)
 			break;
 
 		station->state = STATION_STATE_AUTOCONNECT_FULL;
@@ -3988,6 +4018,36 @@ static void station_fill_scan_freq_subsets(struct station *station)
 	}
 }
 
+static void station_wiphy_watch(struct wiphy *wiphy,
+				enum wiphy_state_watch_event event,
+				void *user_data)
+{
+	struct station *station = user_data;
+	int ret;
+
+	station->regdom_updating = wiphy_regdom_is_updating(wiphy);
+
+	if (event != WIPHY_STATE_WATCH_EVENT_REGDOM_DONE)
+		return;
+
+	/*
+	 * The only state that requires special handling is for
+	 * quick scans since the previous quick scan was delayed until
+	 * the regulatory domain updated. Try again in case 6Ghz is now
+	 * unlocked (unlikely), or advance to full autoconnect. Just in
+	 * case this update came during a quick scan, ignore it.
+	 */
+	if (station->state != STATION_STATE_AUTOCONNECT_QUICK ||
+			station->quick_scan_id)
+		return;
+
+	ret = station_quick_scan_trigger(station);
+	if (ret == 0 || ret == -EAGAIN)
+		return;
+
+	station_enter_state(station, STATION_STATE_AUTOCONNECT_FULL);
+}
+
 static struct station *station_create(struct netdev *netdev)
 {
 	struct station *station;
@@ -4008,6 +4068,11 @@ static struct station *station_create(struct netdev *netdev)
 	station->wiphy = netdev_get_wiphy(netdev);
 	station->netdev = netdev;
 
+	station->wiphy_watch = wiphy_state_watch_add(station->wiphy,
+							station_wiphy_watch,
+							station, NULL);
+	station->regdom_updating = wiphy_regdom_is_updating(station->wiphy);
+
 	l_queue_push_head(station_list, station);
 
 	l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
@@ -4117,6 +4182,8 @@ static void station_free(struct station *station)
 	if (station->scan_freqs_order[2])
 		scan_freq_set_free(station->scan_freqs_order[2]);
 
+	wiphy_state_watch_remove(station->wiphy, station->wiphy_watch);
+
 	l_free(station);
 }
 
-- 
2.34.3

