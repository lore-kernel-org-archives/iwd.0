Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C724A2C
	for <iwd@lists.linux.dev>; Fri, 22 Jul 2022 16:37:16 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id p6-20020a17090a680600b001f2267a1c84so6949037pjj.5
        for <iwd@lists.linux.dev>; Fri, 22 Jul 2022 09:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=svzd3PF6k8MkSduQuJ28bOzWlvPKhFyicr0L1IYzjLI=;
        b=VIgHy8cfNpHo+Bl4jQITwQUVmEfaEXkFjvuF7olyLO27ykNvigIOPZzV3okjHOlMna
         lbLs37kTGbIOiT2NVylDPUc9ABuTIUpaWWB+y1JKeXr7Zu/734H98Au4mcGgEvSL3/Hb
         D9PY7qhsV6E7mkcu0ZCDJmtJXjvMQ+hpH0WeIBbdRogB3uV5O2wqp5+nKGNM4BGVo2W+
         UgEVQhj9MA5ZviMKxu0JkaMtfuPpftcswdv7MV4scZ9F3NQbesDsaav6MgU8Bwi1R+7b
         sMPs62ppgi5k7ClJw3Gzw5DNsbjcwZA2wUokpd+Q3ebO+Tl8vI+mvNtYgOlY80FFc0Yj
         bEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=svzd3PF6k8MkSduQuJ28bOzWlvPKhFyicr0L1IYzjLI=;
        b=S5xBHXg86pZ5078qf7yCoK+sQ19Cx2WoiCP4b5kFNOVHVHz54w/4nENVwE0q55l6tM
         eaH42DfvzbY4hCVLg0Nuq48lcuoskYJfzckcwPFWiame96SUcZj8c49q72W61LulM81t
         OhZmiajGVXGqerIctpxjJL1mX9qWkJxS4v/R2KaqX6WWpZzZCog5HYkLIQ1ZjRErpOqH
         e+v7l3iJJPVK5iX7kyqdkJdh3Oafz+mKJqmYt/4Ht5KM3zR4c5OxXwyy0bzjAi0dGZGK
         dO8mU3L4Ow9wQFKuoZigqsyzmTjPVqJlwXMNwfuQdQHiZnFv2ytExt5Sblh5h3/JKRBx
         V5pw==
X-Gm-Message-State: AJIora/zfXdXRf4AZFM4B1HtsPZg1GVP+AU0sJHNG39VSJlT0hOkO+5h
	c6pCa/ljqZDsR+KG18zSFqQacImA9T8=
X-Google-Smtp-Source: AGRyM1tKmURBlaeTYmKRaF1dzXGAiRGYXas9kDbr+nyOPmoIqpY0kPlj/gzCHMqySEoo9J+fQMQmBQ==
X-Received: by 2002:a17:90b:4b4d:b0:1ef:a2c2:6bcc with SMTP id mi13-20020a17090b4b4d00b001efa2c26bccmr507358pjb.186.1658507835325;
        Fri, 22 Jul 2022 09:37:15 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902e75200b0016a109c7606sm4013887plf.259.2022.07.22.09.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 09:37:15 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 7/7] station: do full passive scan if 6GHz is supported but disabled.
Date: Fri, 22 Jul 2022 09:34:17 -0700
Message-Id: <20220722163417.1119334-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220722163417.1119334-1-prestwoj@gmail.com>
References: <20220722163417.1119334-1-prestwoj@gmail.com>
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
 src/station.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/src/station.c b/src/station.c
index 02f21c76..373bd1c3 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1352,12 +1352,35 @@ static void station_quick_scan_destroy(void *userdata)
 
 static int station_quick_scan_trigger(struct station *station)
 {
+	uint32_t max_freq;
 	struct scan_freq_set *known_freq_set;
+	const struct scan_freq_set *supported = wiphy_get_supported_freqs(
+								station->wiphy);
+	const struct scan_freq_set *disabled = wiphy_get_disabled_freqs(
+								station->wiphy);
 
 	known_freq_set = known_networks_get_recent_frequencies(5);
 	if (!known_freq_set)
 		return -ENODATA;
 
+	/*
+	 * This means IWD has previously connected to a 6GHz AP before, but now
+	 * the regulatory domain disallows 6GHz likely caused by a reboot or
+	 * the firmware going down. The only way to re-enable 6GHz is to get
+	 * enough beacons via scanning for the firmware to set the regulatory
+	 * domain and open up the frequencies.
+	 */
+	max_freq = scan_freq_set_max(known_freq_set);
+	if (max_freq > 6000 && scan_freq_set_contains(disabled, max_freq)) {
+		l_debug("6GHz may be available, doing full passive scan");
+		station->quick_scan_id = scan_passive(
+					netdev_get_wdev_id(station->netdev),
+					supported, station_quick_scan_triggered,
+					station_quick_scan_results, station,
+					station_quick_scan_destroy);
+		goto done;
+	}
+
 	if (!wiphy_constrain_freq_set(station->wiphy, known_freq_set)) {
 		scan_freq_set_free(known_freq_set);
 		return -ENOTSUP;
@@ -1368,6 +1391,7 @@ static int station_quick_scan_trigger(struct station *station)
 						station_quick_scan_triggered,
 						station_quick_scan_results,
 						station_quick_scan_destroy);
+done:
 	scan_freq_set_free(known_freq_set);
 
 	if (!station->quick_scan_id)
-- 
2.34.1

