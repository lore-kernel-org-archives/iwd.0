Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D0F4C62
	for <iwd@lists.linux.dev>; Wed,  3 Aug 2022 21:36:53 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso3308539pjq.4
        for <iwd@lists.linux.dev>; Wed, 03 Aug 2022 14:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=L4pdzujL1aNI3rt051RJK6ip7MPDb225gUo5VMRYIQo=;
        b=PtV6l3ja+oHnqQaMkc1Nasn2h2g2e4gFO3TpDAjPwOCId1HoLX5NCY9PI4U5/C7Tj6
         MDaKxPfDakhqlszo/Z/LMGGVX56cK/jgujbFhAKs1GAPgIwxQG5m7UAIo5V7VtDeenM4
         kADTZOBn8NLKER/DFVZWk1lePnCQDOeJ5AHAOo8/7ywFBigqqnQpA1jxRPgT20/uiGdH
         +iTW/6Msm/8lc/q7dVKKsyFyf7Wbexkwdv4Xza7agdxmhk+gIdIsIHGfAZp+MXS5s9x5
         mRKfw+cYDSQsm4T6knlnI3p6Ku8mxQIK2KLoLfk1nrrO2kJNp+7MOsG596FxU587O9qs
         nGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=L4pdzujL1aNI3rt051RJK6ip7MPDb225gUo5VMRYIQo=;
        b=fvg3oxTciNS2dypRwbusPZ2U+DWeHuA/268CVqkFd1oG1GKweYR0aciSpHD4TE7uew
         FVexTzwrWORDYRx+wF015l9qeNhyamda+G5XolUzQaFQICUVT205O0NLx8b9qgjjE3Rm
         oUrtmYRx4uF9oG3/wLBnNs6TnpIakNqQp9Huz+sRbh/XSaITs702EQt656LLxEd4yvr+
         jRrE5zi98OcIjsp/fS08MlKfdDcf6bkUTL7UNjR35m76yMFOhDDntZl3+wsCbiinGESv
         kcbmYN56siMKV3BJACfpuJVV9bkKHGM0Oo9WT86NLgx+CKF7Emw1gMSi6eC37RGpLrVe
         erFw==
X-Gm-Message-State: ACgBeo3l9EFPE6SZjs39NQat3Lf9bWfPHwf1OAKxgf0IWZ5tZtCxQhFn
	qGysoukHadEFdQvGtClxz8R8cMjxnxo=
X-Google-Smtp-Source: AA6agR7d7z+NHxIL0lrMIYgOtWA+ghhFg6n/qaVLvVZoNEUFl/Ckvlq19qVdt2VvsYT4UW5F2j/deg==
X-Received: by 2002:a17:902:eb8a:b0:16d:c75a:c40b with SMTP id q10-20020a170902eb8a00b0016dc75ac40bmr28692754plg.102.1659562612664;
        Wed, 03 Aug 2022 14:36:52 -0700 (PDT)
Received: from jprestwo-xps.none ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id b13-20020a65578d000000b00419fc2c27d8sm11527066pgr.43.2022.08.03.14.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 14:36:52 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 10/13] station: do full passive scan if 6GHz is supported but disabled.
Date: Wed,  3 Aug 2022 14:36:41 -0700
Message-Id: <20220803213644.277534-10-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220803213644.277534-1-prestwoj@gmail.com>
References: <20220803213644.277534-1-prestwoj@gmail.com>
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
 src/station.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/src/station.c b/src/station.c
index 02f21c76..f002d7ef 100644
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
@@ -1353,11 +1356,37 @@ static void station_quick_scan_destroy(void *userdata)
 static int station_quick_scan_trigger(struct station *station)
 {
 	struct scan_freq_set *known_freq_set;
+	bool known_6ghz;
+	const struct scan_freq_set *disabled = wiphy_get_disabled_freqs(
+								station->wiphy);
 
 	known_freq_set = known_networks_get_recent_frequencies(5);
 	if (!known_freq_set)
 		return -ENODATA;
 
+	if (station->regdom_updating) {
+		l_debug("regdom is updating, delaying quick scan");
+
+		scan_freq_set_free(known_freq_set);
+		return 0;
+	}
+
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
+		return -EAGAIN;
+
 	if (!wiphy_constrain_freq_set(station->wiphy, known_freq_set)) {
 		scan_freq_set_free(known_freq_set);
 		return -ENOTSUP;
@@ -3977,6 +4006,37 @@ static void station_fill_scan_freq_subsets(struct station *station)
 	}
 }
 
+static void station_wiphy_watch(struct wiphy *wiphy,
+				enum wiphy_state_watch_event event,
+				void *user_data)
+{
+	struct station *station = user_data;
+
+	switch (event) {
+	case WIPHY_STATE_WATCH_EVENT_REGDOM_STARTED:
+		station->regdom_updating = true;
+		return;
+	case WIPHY_STATE_WATCH_EVENT_REGDOM_DONE:
+		station->regdom_updating = false;
+
+		/*
+		 * The only state that requires special handling is for
+		 * quick scans since the previous quick scan was delayed until
+		 * the regulatory domain updated. Try again in case 6Ghz is now
+		 * unlocked (unlikely), or advance to full autoconnect.
+		 */
+		if (station->state != STATION_STATE_AUTOCONNECT_QUICK)
+			return;
+
+		if (!station_quick_scan_trigger(station))
+			return;
+
+		station_enter_state(station, STATION_STATE_AUTOCONNECT_FULL);
+	default:
+		return;
+	}
+}
+
 static struct station *station_create(struct netdev *netdev)
 {
 	struct station *station;
@@ -3997,6 +4057,11 @@ static struct station *station_create(struct netdev *netdev)
 	station->wiphy = netdev_get_wiphy(netdev);
 	station->netdev = netdev;
 
+	station->wiphy_watch = wiphy_state_watch_add(station->wiphy,
+							station_wiphy_watch,
+							station, NULL);
+	station->regdom_updating = wiphy_regdom_is_updating(station->wiphy);
+
 	l_queue_push_head(station_list, station);
 
 	l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
@@ -4106,6 +4171,8 @@ static void station_free(struct station *station)
 	if (station->scan_freqs_order[2])
 		scan_freq_set_free(station->scan_freqs_order[2]);
 
+	wiphy_state_watch_remove(station->wiphy, station->wiphy_watch);
+
 	l_free(station);
 }
 
-- 
2.34.3

