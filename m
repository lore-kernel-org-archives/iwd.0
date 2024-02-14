Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ECD138488
	for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 19:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707939537; cv=none; b=HTRPdlX1ca5s43KYL2ui5W0Im1m8RSxskchnca3AOv/RtRufpNcvDaTCU9BFs21rLHJiQQ5DsDeubLM4uLKk+jEyrI7kpoSt9TGgArqDbZatJn7uTqkI/ubi/4IHzMGBnFiDJq3py+7ytKce13TJIfHQzTSSWh9DuzPSrpaPEws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707939537; c=relaxed/simple;
	bh=MjPjBS7yuQ3yAyfpRxhmwICpWOeBZ9kHqLFk26SkV1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W4t5iXn20Mjrk139cJQVBdK7vpawgW5LSJRenm50KS0zUhzOW2bGNfeth6m2D0jBYDZ2bk5l4WekSppqubDGemUPQRoNpgbkdR6YU0EHEI52BZehYlpmJP7XXXHSHP4V9F/5S1PntwvF7AiS/jAFaRgVitpLy5tzUgHg2xwrlZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8q4nFFB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8q4nFFB"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d91397bd22so776495ad.0
        for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 11:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707939535; x=1708544335; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEO1rfbP4xIiW9H4MjMKHumuk4OaCq9eBSHXt9UovzA=;
        b=R8q4nFFB5QAzo1pJweqTP2t4bfUK3jI/FVrz+vJ7QIDhwEdehjxNWJbomGUmAKQq7j
         zBbbqbRQovmkNMJdUBmruR8VWvil7tkADRqQ1yLLrBY6rGUpSGG6gl3CQkU6S5Tk9Pd2
         JS5OrQ4NlEZnC3P/Yprn2qYGeqHaRtkF3ZGKdLTWokO1VyEpd9vqa8h2A1Lp7Me8N8Me
         CG3bbaM3CKfbIE6ueecDY2VbiwDOuF2t0SNq0rRtTdg/3gdCoO+z/u63BztZF/DovCJF
         bHZ6JV8l/M9qPFl/vqC7Jg1lNHN0zeBuhnCGdcErh8LuCBSuV0Glr9O4JPYPaAn78VQD
         1aMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707939535; x=1708544335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEO1rfbP4xIiW9H4MjMKHumuk4OaCq9eBSHXt9UovzA=;
        b=eLC2rgiazCo7MX1gHOO/hM6tyLS3Ydc3yxpsUGQ7cE282GrW2RqWkdkrlwPqGfIjVi
         thTEVtrFAE0iAzdRzUYeCzFooSnz852hzEvMZ3H0bmyRCZ+vn3r1u37quGbwC3DnfdB+
         FZ7TotKIORRZewFEBqQVC1S5bjtebYL3wSxPbvswbxt8r8DV1y+/rMxDADZJRcj89BNX
         JEV6nxuLQ9fw1DQsShRhyInCrx++NtGaQ/BMMWo6ylRp05TzokbgmXCLNVuCfrlh522V
         ePhdQms5bvToaXgcupbP7qlFeriImXLwExnTcQgczC7ArDA7xKDjoqnMHbGryRh4s5FF
         Xp+w==
X-Gm-Message-State: AOJu0YwzwKEwIuqm55uuNAOKpIXj2x+ybB8egOsozsbK3vZIxtyxFuKL
	lr8T6YAHvhi5ylK/2M7awc8Kwd1RvnFDPd5Y/ec32PVPfvDadN4S/bQEPjWqwos=
X-Google-Smtp-Source: AGHT+IG9Y3/2kAZ9ZVBoTiLSHTK7ukwBaOcigwjYpxkwbg49kobRG5jPUABx8jJOP7hF6Hv2VN8Tzg==
X-Received: by 2002:a17:902:bd0a:b0:1db:5319:4d86 with SMTP id p10-20020a170902bd0a00b001db53194d86mr3788159pls.52.1707939534620;
        Wed, 14 Feb 2024 11:38:54 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id v2-20020a170902d08200b001db53ccb856sm1761606plv.108.2024.02.14.11.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 11:38:54 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 2/5] station: use l_notice for station_debug_event, allow arguments
Date: Wed, 14 Feb 2024 11:37:40 -0800
Message-Id: <20240214193743.963349-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214193743.963349-1-prestwoj@gmail.com>
References: <20240214193743.963349-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For anyone debugging or trying to identify network infrastructure
problems the IWD DBus API isn't all that useful and ultimately
requires going through debug logs to figure out exactly what
happened. Having a concise set of debug logs containing only
relavent information would be very useful. In addition, having
some kind of syntax for these logs to be parsed by tooling could
automate these tasks.

This is being done, starting with station, by using l_notice. The
use of l_notice in IWD will be strictly for the type of messages
described above. Modules using l_notice should follow the same
log format so tooling can parse the messages generically. The
format should be zero or more comma-separated key value pairs,
starting with "event: <event name>".

station_debug_event is being modified to use l_notice as most of
the events are useful for debugging. This was modified slightly
to allow arguments to be passed in order to provide extra
information if available.
---
 src/station.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/src/station.c b/src/station.c
index ea505ca2..a097174e 100644
--- a/src/station.c
+++ b/src/station.c
@@ -215,15 +215,13 @@ static bool station_is_roaming(struct station *station)
 			station->state == STATION_STATE_FW_ROAMING;
 }
 
-static bool station_debug_event(struct station *station, const char *name)
+static bool station_emit_event(struct station *station, const char *name)
 {
 	struct l_dbus_message *signal;
 
 	if (!iwd_is_developer_mode())
 		return true;
 
-	l_debug("StationDebug.Event(%s)", name);
-
 	signal = l_dbus_message_new_signal(dbus_get_bus(),
 					netdev_get_path(station->netdev),
 					IWD_STATION_DEBUG_INTERFACE, "Event");
@@ -233,6 +231,12 @@ static bool station_debug_event(struct station *station, const char *name)
 	return l_dbus_send(dbus_get_bus(), signal) != 0;
 }
 
+#define station_debug_event(station, name, fmt, ...)			\
+({									\
+	l_notice("event: %s, " fmt, name, ##__VA_ARGS__);		\
+	station_emit_event(station, name);				\
+})
+
 static void station_property_set_scanning(struct station *station,
 								bool scanning)
 {
@@ -1565,7 +1569,7 @@ static void station_enter_state(struct station *station,
 			station_state_to_string(station->state),
 			station_state_to_string(state));
 
-	station_debug_event(station, station_state_to_string(state));
+	station_debug_event(station, station_state_to_string(state), "");
 
 	disconnected = !station_is_busy(station);
 
@@ -2351,13 +2355,14 @@ static bool station_ft_work_ready(struct wiphy_radio_work_item *item)
 		l_queue_insert(station->roam_bss_list, rbss,
 				roam_bss_rank_compare, NULL);
 
-		station_debug_event(station, "ft-fallback-to-reassoc");
+		station_debug_event(station, "ft-fallback-to-reassoc", "");
 
 		station_transition_start(station);
 		l_steal_ptr(rbss);
 		break;
 	case -ENOENT:
-		station_debug_event(station, "ft-roam-failed");
+		station_debug_event(station, "ft-roam-failed",
+					"reason: authentication timeout");
 try_next:
 		station_transition_start(station);
 		break;
@@ -2560,7 +2565,7 @@ static void station_roam_scan_triggered(int err, void *user_data)
 		return;
 	}
 
-	station_debug_event(station, "roam-scan-triggered");
+	station_debug_event(station, "roam-scan-triggered", "");
 
 	/*
 	 * Do not update the Scanning property as we won't be updating the
@@ -2704,7 +2709,7 @@ next:
 
 	/* See if we have anywhere to roam to */
 	if (l_queue_isempty(station->roam_bss_list)) {
-		station_debug_event(station, "no-roam-candidates");
+		station_debug_event(station, "no-roam-candidates", "");
 		goto fail;
 	}
 
@@ -3393,7 +3398,7 @@ static void station_packets_lost(struct station *station, uint32_t num_pkts)
 	if (station_cannot_roam(station))
 		return;
 
-	station_debug_event(station, "packet-loss-roam");
+	station_debug_event(station, "packet-loss-roam", "count: %u", num_pkts);
 
 	elapsed = l_time_diff(station->last_roam_scan, l_time_now());
 
@@ -3423,7 +3428,7 @@ static void station_beacon_lost(struct station *station)
 	if (station_cannot_roam(station))
 		return;
 
-	station_debug_event(station, "beacon-loss-roam");
+	station_debug_event(station, "beacon-loss-roam", "");
 
 	if (station->roam_trigger_timeout)
 		return;
-- 
2.34.1

