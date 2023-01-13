Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172EEBA3A
	for <iwd@lists.linux.dev>; Fri, 13 Jan 2023 21:24:38 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id w2so1710629pfc.11
        for <iwd@lists.linux.dev>; Fri, 13 Jan 2023 13:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uWQv33hbaKl/A8qcfAKgvqAmB04dSNDVt6b1AvZcGb4=;
        b=EI+RwKPBRHk7k3qMrqKf5jxaehi/Frh6ARM3S7EN9C4L+R8goX6VpQ+ZEYlPYdsFs2
         acFw57d3KJLCe+jc7hVV/lg2efaeaP9/kUgf4kTRxsVXnNtM6fd7sarACEdeAft2Q6gc
         M6bv7L3j8XJTtyZlJ/N8qqXHy054hkwoewW7J9QBcw1kfGQGJ3sdhA+uNtm3vL3fN9M7
         yGh09bjiJKu4Dl89gPTsDRfctkqCnfXcaMHugwJIIzslsHcybNpSeVr3DW24YplzW7wO
         wp7ybmJh2e8vbyv75ui+Gmx36w8C1IsD/AKpKtqKMwjDKh8dLJRqSApsg88nDuv74mw+
         mCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uWQv33hbaKl/A8qcfAKgvqAmB04dSNDVt6b1AvZcGb4=;
        b=imucesUy233Hd2qEgiBH/tIkzJroTqJtmEeRdtrtTdXQPddafhmfz0gBIAjtmjgg1S
         9kSF/xEYa8m9Zlossu6syWSxSn7Kr5W7iBiaoMPutFOWaCCVcO4OXkPIicnq+NeFFQ29
         KROetRqXRkaKzT5Kv11AL4RSWc6DrxtWXTNGzCRalppEUK0tgqh+SiB9YhuGaaOS1xDy
         nr5uQP36JGo120dZBWS1gmCVVpSwL6e2OqV2oCMPUBjEyp4rHv2/mJxFKRZ33seHn3GO
         e8J4OpmAL8bFvDHwY1IeaVE8LvmZ5+R0DvZSKnoUkeOjYX2LGL6Mv2lY5uqbJiR9svZh
         s7+A==
X-Gm-Message-State: AFqh2koHbzgZx6Uw2Y0ix3JfDTM8HzoO11cd1sKq75sdUT6ZkJnVgyKJ
	QxD6NlDwjQAGr4XlkPlq3fmxXll0TiY=
X-Google-Smtp-Source: AMrXdXuPTJOOVLOGeGOS2ur94/LCIWRZnnvnwv8NFJqIbJPf3q2ReeoTPCYD90IKTJ61kY0KN6LASQ==
X-Received: by 2002:aa7:93de:0:b0:587:25ea:4fcb with SMTP id y30-20020aa793de000000b0058725ea4fcbmr11863596pff.19.1673645078262;
        Fri, 13 Jan 2023 13:24:38 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id 66-20020a620645000000b0056d98e31439sm14562829pfg.140.2023.01.13.13.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 13:24:37 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/3] station: add checks to prevent multiple roam scans
Date: Fri, 13 Jan 2023 13:24:34 -0800
Message-Id: <20230113212436.794519-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Under the following conditions IWD can accidentally trigger a second
roam scan while one is already in progress:

 - A low RSSI condition is met. This starts the roam rearm timer.
 - A packet loss condition is met, which triggers a roam scan.
 - The roam rearm timer fires and starts another roam scan while
   also overwriting the first roam scan ID.
 - Then, if IWD gets disconnected the overwritten roam scan gets
   canceled, and the roam state is cleared which NULL's
   station->connected_network.
 - The initial roam scan results then come in with the assumption
   that IWD is still connected which results in a crash trying to
   reference station->connected_network.

This can be fixed by adding a station_cannot_roam check in the rearm
timer. If IWD is already doing a roam scan station->preparing_roam
should be set which will cause it to return true and stop any further
action.

Aborting (signal 11) [/usr/libexec/iwd]
iwd[426]: ++++++++ backtrace ++++++++
iwd[426]: #0  0x7f858d7b2090 in /lib/x86_64-linux-gnu/libc.so.6
iwd[426]: #1  0x443df7 in network_get_security() at ome/locus/workspace/iwd/src/network.c:287
iwd[426]: #2  0x421fbb in station_roam_scan_notify() at ome/locus/workspace/iwd/src/station.c:2516
iwd[426]: #3  0x43ebc1 in scan_finished() at ome/locus/workspace/iwd/src/scan.c:1861
iwd[426]: #4  0x43ecf2 in get_scan_done() at ome/locus/workspace/iwd/src/scan.c:1891
iwd[426]: #5  0x4cbfe9 in destroy_request() at ome/locus/workspace/iwd/ell/genl.c:676
iwd[426]: #6  0x4cc98b in process_unicast() at ome/locus/workspace/iwd/ell/genl.c:954
iwd[426]: #7  0x4ccd28 in received_data() at ome/locus/workspace/iwd/ell/genl.c:1052
iwd[426]: #8  0x4c79c9 in io_callback() at ome/locus/workspace/iwd/ell/io.c:120
iwd[426]: #9  0x4c62e3 in l_main_iterate() at ome/locus/workspace/iwd/ell/main.c:476
iwd[426]: #10 0x4c6426 in l_main_run() at ome/locus/workspace/iwd/ell/main.c:519
iwd[426]: #11 0x4c6752 in l_main_run_with_signal() at ome/locus/workspace/iwd/ell/main.c:645
iwd[426]: #12 0x405987 in main() at ome/locus/workspace/iwd/src/main.c:600
iwd[426]: #13 0x7f858d793083 in /lib/x86_64-linux-gnu/libc.so.6
iwd[426]: +++++++++++++++++++++++++++
---
 src/station.c | 47 +++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/src/station.c b/src/station.c
index 4452e83e..1a69b98a 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2701,6 +2701,28 @@ static void station_start_roam(struct station *station)
 		station_roam_failed(station);
 }
 
+static bool station_cannot_roam(struct station *station)
+{
+	const struct l_settings *config = iwd_get_config();
+	bool disabled;
+
+	/*
+	 * Disable roaming with hardware that can roam automatically. Note this
+	 * is now required for recent kernels which have CQM event support on
+	 * this type of hardware (e.g. brcmfmac).
+	 */
+	if (wiphy_supports_firmware_roam(station->wiphy))
+		return true;
+
+	if (!l_settings_get_bool(config, "Scan", "DisableRoamingScan",
+								&disabled))
+		disabled = false;
+
+	return disabled || station->preparing_roam ||
+				station->state == STATION_STATE_ROAMING ||
+				station->state == STATION_STATE_FT_ROAMING;
+}
+
 static void station_roam_trigger_cb(struct l_timeout *timeout, void *user_data)
 {
 	struct station *station = user_data;
@@ -2710,6 +2732,9 @@ static void station_roam_trigger_cb(struct l_timeout *timeout, void *user_data)
 	l_timeout_remove(station->roam_trigger_timeout);
 	station->roam_trigger_timeout = NULL;
 
+	if (station_cannot_roam(station))
+		return;
+
 	station_start_roam(station);
 }
 
@@ -2735,28 +2760,6 @@ static void station_roam_timeout_rearm(struct station *station, int seconds)
 								station, NULL);
 }
 
-static bool station_cannot_roam(struct station *station)
-{
-	const struct l_settings *config = iwd_get_config();
-	bool disabled;
-
-	/*
-	 * Disable roaming with hardware that can roam automatically. Note this
-	 * is now required for recent kernels which have CQM event support on
-	 * this type of hardware (e.g. brcmfmac).
-	 */
-	if (wiphy_supports_firmware_roam(station->wiphy))
-		return true;
-
-	if (!l_settings_get_bool(config, "Scan", "DisableRoamingScan",
-								&disabled))
-		disabled = false;
-
-	return disabled || station->preparing_roam ||
-				station->state == STATION_STATE_ROAMING ||
-				station->state == STATION_STATE_FT_ROAMING;
-}
-
 #define WNM_REQUEST_MODE_PREFERRED_CANDIDATE_LIST	(1 << 0)
 #define WNM_REQUEST_MODE_DISASSOCIATION_IMMINENT	(1 << 2)
 #define WNM_REQUEST_MODE_TERMINATION_IMMINENT		(1 << 3)
-- 
2.34.3

