Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6511E7E59A
	for <iwd@lists.linux.dev>; Thu, 29 Aug 2024 11:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724930885; cv=none; b=JaeHUGeXmNLAEpxUscK15/gdHpvxIEwn2GQZHfJkZJ+V/J+wLTGLTSI6OwzKtL73VtYVWX3Gn6ti0cuYdWAE38wM62zb8bZBqEub93YHpnROtf7UeNWrpKUAOWG/26GZ+GS76PflqzcSjyHL5Mm94bFwJKgFRpt0UB6AfTs2FSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724930885; c=relaxed/simple;
	bh=CaMnbYHqPe0UhihgJb68NMPPywkeY+CBdG5HPRAKqNU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ocwtBIuG1uBfdrrPOIZlF3SEtxEIKETWK1UTb2ehkj3hFil5FDL0fX6iOdFrWeCoYag82YlqRrnpOeisDAuGJnwwaND1r/iQ4YArZVz0F5FMnX4ENHOKJub8vIxkl6RYCJQoudAXjGPz9om4lYARP9VmfVqGxQ5kVa65n6jBhBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFtbEQq9; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFtbEQq9"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-70941cb73e9so195411a34.2
        for <iwd@lists.linux.dev>; Thu, 29 Aug 2024 04:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724930883; x=1725535683; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=alAFmbzkweJeLTE78UJpF/pO8lMIMRzBzWjW5Mqi+dk=;
        b=JFtbEQq94xe7lCBRA5oiyp7pA4ohSIcdPTTM9HiTd1MuyyGxARY6mekdpagjwzf1AS
         X4WRKyoPKzDZurRzpkYKBTQjha6x+uupW86lHQIGnKeLHFzZ1S7BkBxHg6NC7cVwhcS4
         P/bUHomeghcqfFS/BTE3W51w+YngiSEk0dgSHKjeYejqld0KamvPaHO4h23m9qwjSdWi
         /5nWvLnQ56GAyBLTfxYtymS3k9E9AT5CT44PFM9b8sDDqu0dycZja5b1HaJz1UNC/NQ8
         AwznDPMKwwIM6Qw47mlaIrOmdlPlN873zq/upHchmAyOaFpHlcTeN4Jyw1Jvy42RhKwq
         mpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724930883; x=1725535683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=alAFmbzkweJeLTE78UJpF/pO8lMIMRzBzWjW5Mqi+dk=;
        b=EY6qRVdHftBwYTFF5900P5zT0rmG7z6sKMn+ThIBRucsC8ryPivqipifvDhNTzoby9
         hNOSdxVxOnBUxGoezWJgTw+64p9ZobJqDQeXp8B4Bf+OJDjgBz5/4q47bjEpChHhEiLR
         xTHWULRk3tjTZxNbXE43KBSNFePhJKTOjjM72J2xf20XYMorbOE+VqloZmBIddExgWta
         8n11JiOgqZtLjxCun6sX4+biAKpdJP8Hb5QF5F4r1DjoMaQwQbaf5MeYGivAhXHrqRs7
         mq/HED1c1/qthBKQ8lhVU+sT/VFnM39l96ZmtfQiGrmtOIL23HSgy8iKY1OiWwGlV2UK
         SClw==
X-Gm-Message-State: AOJu0Yx/IJCIZ/dLBQR099ZE3/Crdetb1I5EDVcU1BqaUOqNfKVEq2sr
	DElsG6xpM4ccaIsBfVeoi+kjNziSEzWhM3akogiIuSZn9qfM7IHz7rHgjA==
X-Google-Smtp-Source: AGHT+IEvjUp3/NjyVl65ZTZlw4B2XQOJJYw1L7Z2mHMuTmOrqWS2rUCvUyW1a2Ew3q8zHdomL/9asg==
X-Received: by 2002:a05:6830:641c:b0:709:4b8d:af4 with SMTP id 46e09a7af769-70f5c3447b4mr2857082a34.5.1724930883144;
        Thu, 29 Aug 2024 04:28:03 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682d66e30sm4021471cf.61.2024.08.29.04.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 04:28:02 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] station: check for roam timeout before rearming
Date: Thu, 29 Aug 2024 04:27:58 -0700
Message-Id: <20240829112758.35494-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A user reported a crash which was due to the roam trigger timeout
being overwritten, followed by a disconnect. Post-disconnect the
timer would fire and result in a crash. Its not clear exactly where
the overwrite was happening but upon code inspection it could
happen in the following scenario:

1. Beacon loss event, start roam timeout
2. Signal low event, no check if timeout is running and the timeout
   gets overwritten.

The reported crash actually didn't appear to be from the above
scenario but something else, so this logic is being hardened and
improved

Now if a roam timeout already exists and trying to be rearmed IWD
will check the time remaining on the current timer and either keep
the active timer or reschedule it to the lesser of the two values
(current or new rearm time). This will avoid cases such as a long
roam timer being active (e.g. 60 seconds) followed by a beacon or
packet loss event which should trigger a more agressive roam
schedule.
---
 src/station.c | 48 +++++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/src/station.c b/src/station.c
index 30a1232a..8b29df77 100644
--- a/src/station.c
+++ b/src/station.c
@@ -102,7 +102,6 @@ struct station {
 	struct l_queue *owe_hidden_scan_ids;
 
 	/* Roaming related members */
-	struct timespec roam_min_time;
 	struct l_timeout *roam_trigger_timeout;
 	uint32_t roam_scan_id;
 	uint8_t preauth_bssid[6];
@@ -1820,7 +1819,6 @@ static void station_roam_state_clear(struct station *station)
 	station->preparing_roam = false;
 	station->roam_scan_full = false;
 	station->signal_low = false;
-	station->roam_min_time.tv_sec = 0;
 	station->netconfig_after_roam = false;
 	station->last_roam_scan = 0;
 
@@ -3041,20 +3039,33 @@ static void station_roam_trigger_cb(struct l_timeout *timeout, void *user_data)
 
 static void station_roam_timeout_rearm(struct station *station, int seconds)
 {
-	struct timespec now, min_timeout;
+	uint64_t remaining;
 
-	clock_gettime(CLOCK_MONOTONIC, &now);
+	if (!station->roam_trigger_timeout)
+		goto new_timeout;
 
-	min_timeout = now;
-	min_timeout.tv_sec += seconds;
+	/* If we cant get the remaining time just create a new timer */
+	if (L_WARN_ON(!l_timeout_remaining(station->roam_trigger_timeout,
+						&remaining))) {
+		l_timeout_remove(station->roam_trigger_timeout);
+		goto new_timeout;
+	}
+
+	/* Our current timeout is less than the rearm, keep current */
+	if (l_time_before(remaining, seconds * L_USEC_PER_SEC)) {
+		l_debug("Keeping current roam timeout of %lu seconds",
+				l_time_to_secs(remaining));
+		return;
+	}
+
+	l_debug("Rescheduling roam timeout from %lu to %u seconds",
+			l_time_to_secs(remaining), seconds);
+	l_timeout_modify(station->roam_trigger_timeout, seconds);
 
-	if (station->roam_min_time.tv_sec < min_timeout.tv_sec ||
-			(station->roam_min_time.tv_sec == min_timeout.tv_sec &&
-			 station->roam_min_time.tv_nsec < min_timeout.tv_nsec))
-		station->roam_min_time = min_timeout;
+	return;
 
-	seconds = station->roam_min_time.tv_sec - now.tv_sec +
-		(station->roam_min_time.tv_nsec > now.tv_nsec ? 1 : 0);
+new_timeout:
+	l_debug("Arming new roam timer for %u seconds", seconds);
 
 	station->roam_trigger_timeout =
 		l_timeout_create(seconds, station_roam_trigger_cb,
@@ -3212,7 +3223,6 @@ static void station_ok_rssi(struct station *station)
 	station->roam_trigger_timeout = NULL;
 
 	station->signal_low = false;
-	station->roam_min_time.tv_sec = 0;
 }
 
 static void station_event_roamed(struct station *station, struct scan_bss *new)
@@ -3558,14 +3568,17 @@ static void station_packets_lost(struct station *station, uint32_t num_pkts)
 		l_debug("Too many roam attempts in %u second timeframe, "
 			"delaying roam", LOSS_ROAM_RATE_LIMIT);
 
-		if (station->roam_trigger_timeout)
-			return;
-
 		station_roam_timeout_rearm(station, LOSS_ROAM_RATE_LIMIT);
 
 		return;
 	}
 
+	if (station->roam_trigger_timeout) {
+		l_debug("canceling roam timer to roam immediately");
+		l_timeout_remove(station->roam_trigger_timeout);
+		station->roam_trigger_timeout = NULL;
+	}
+
 	station_start_roam(station);
 }
 
@@ -3578,9 +3591,6 @@ static void station_beacon_lost(struct station *station)
 
 	station_debug_event(station, "beacon-loss-roam");
 
-	if (station->roam_trigger_timeout)
-		return;
-
 	station_roam_timeout_rearm(station, LOSS_ROAM_RATE_LIMIT);
 }
 
-- 
2.34.1

