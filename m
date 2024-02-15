Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7FB131744
	for <iwd@lists.linux.dev>; Thu, 15 Feb 2024 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005212; cv=none; b=HgvZKVFxWw4oElsluByX34Sk8r5ieJvyv/OvJ+n2xFDkNGnuiWNVBF8xdkcvWNbfyQh3WJ7WoEEW0jy9qI+1rT3yKHUVlUe9SjOycYpHA7KHKd1Ghl6CeLgMvIRmbQDfkYXx71qKa/9SKyS4ArN9T9nQeIJ3ZyCmNRxTKvhxF9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005212; c=relaxed/simple;
	bh=b9WrHQA+55sfpX5UTQUFQsRER7opRtgrtGrAVRimhao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DObdGYkrHwyAkeX1yooeqpWbt8cDSLBNRQDeZi3Gp0GPPcH59MFAuykj9mrG4tDnGHEPxq5mC8DNEQ0I7EP0zuLOfwNUoCKABOXt2ea2ibNp8tiX3FImcF0TSyVD0jh81+rfyKohNWq/q62JA3fY2UvRZ/Q+LXEe4V6mZpWda5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jb+zvX4L; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jb+zvX4L"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d8da50bffaso4602525ad.2
        for <iwd@lists.linux.dev>; Thu, 15 Feb 2024 05:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708005209; x=1708610009; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwB3hGZIe2RWXidkTeHREeCnsLJG0qjdm4/W+cSwMjI=;
        b=Jb+zvX4L7p+OrtKijlztD9djfuFK3BVndP0ctsB26uAqJ8nP/0Qgea0fXyvmr9HEvI
         nDG88DhK+xNVHLFEBdS8xl5j5qw+fO5u4BB/kxfabghW5eQ2BYlecSNmIRQNlw1qPP7t
         F/Jvm+A6itNUZ9xGukX9LNOk8UxEjVyEULH2JNraZRZdlJ9KeqogdOCCTBHqdSA9DG31
         4xAPYv/ph8Vb6zB9mZn4rEbF2Ix3hpRwbqpy1+MEEhuC696s7HA7nn6E1Kv+h/WvxunN
         71XUMN29tDKmm0wj/5ZYfhN/DyOVDIvR1hqAHKY/U4H4rvH2DCsSCO0oai1HCLM0WPGD
         fYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708005209; x=1708610009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwB3hGZIe2RWXidkTeHREeCnsLJG0qjdm4/W+cSwMjI=;
        b=Aj3OAl2nYBxKzdvDacd48Nw9eIu/89M08XebqNjRwJwiRGbyFon5PudXX8uyT1hqTQ
         lHwLnDt3Xm+LUChmC9bHCMJOZJxBFyIo99dkOEeDq5MSN1zX9g8byJQARVqd1O01YrEL
         Pfn8ZVKzAfg72/0gFyMvsrmyWxiHpGcPDW2tngTUDTJadgF7iOPsLRYdBYWx/YAvlali
         REFLHLqKVzrKTvsAQvH4qgPXlQF3cT+pc2rvEVrLt4g4ktLHTi3k5dzptDZNn88orTPR
         XFE8McUWUGjFgTg5pOwF3ALdvT7T9VqVF7f2wbc9n8SYgDmvK2Op0MhScnd1c3tcZs0M
         +8uw==
X-Gm-Message-State: AOJu0YyJaVtB6pT4DNP6NR8ce8GD0bMBsa2oyOyU1lFrN7po6BPUm8fb
	Fma59/esEsz2sdG5CNQ6NCOcdUyaSG2gUPwm1z/NaBQsgA/EOc7h0/v3pEgoH28=
X-Google-Smtp-Source: AGHT+IEUDkBHtMfo0HwHsiezi70KfXPIHW/RMcN+ih6OeUO0f4bVHTKva7DAhPJVMQg8BUnY/OSBYw==
X-Received: by 2002:a17:902:dac4:b0:1db:9f89:ea56 with SMTP id q4-20020a170902dac400b001db9f89ea56mr62044plx.63.1708005209540;
        Thu, 15 Feb 2024 05:53:29 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709029f8e00b001db55d2e1e1sm1284787plq.63.2024.02.15.05.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 05:53:29 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFCv2 4/5] station: use iwd_notice for state/event information
Date: Thu, 15 Feb 2024 05:53:13 -0800
Message-Id: <20240215135314.1017081-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215135314.1017081-1-prestwoj@gmail.com>
References: <20240215135314.1017081-1-prestwoj@gmail.com>
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

This is being done, starting with station, by using iwd_notice
which internally uses l_notice. The use of the notice log level
(5) in IWD will be strictly for the type of messages described
above.
---
 src/station.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/src/station.c b/src/station.c
index ea505ca2..51eee56e 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1561,9 +1561,9 @@ static void station_enter_state(struct station *station,
 	bool disconnected;
 	int ret;
 
-	l_debug("Old State: %s, new state: %s",
-			station_state_to_string(station->state),
-			station_state_to_string(state));
+	iwd_notice(IWD_NOTICE_STATE, "old: %s, new: %s",
+					station_state_to_string(station->state),
+					station_state_to_string(state));
 
 	station_debug_event(station, station_state_to_string(state));
 
@@ -2358,6 +2358,8 @@ static bool station_ft_work_ready(struct wiphy_radio_work_item *item)
 		break;
 	case -ENOENT:
 		station_debug_event(station, "ft-roam-failed");
+		iwd_notice(IWD_NOTICE_FT_ROAM_FAILED,
+				"status: authentication timeout");
 try_next:
 		station_transition_start(station);
 		break;
@@ -2384,8 +2386,10 @@ disassociate:
 		station_disassociated(station);
 		break;
 	default:
-		if (ret > 0)
+		if (ret > 0) {
+			iwd_notice(IWD_NOTICE_FT_ROAM_FAILED, "status: %d", ret);
 			goto try_next;
+		}
 
 		station_roam_failed(station);
 		break;
@@ -2457,8 +2461,10 @@ static bool station_try_next_transition(struct station *station,
 	struct handshake_state *new_hs;
 	struct ie_rsn_info cur_rsne, target_rsne;
 
-	l_debug("%u, target %s", netdev_get_ifindex(station->netdev),
-			util_address_to_string(bss->addr));
+	iwd_notice(IWD_NOTICE_ROAM_INFO, "bss: "MAC", signal: %d, load: %d/255",
+					MAC_STR(bss->addr),
+					bss->signal_strength / 100,
+					bss->utilization);
 
 	/* Reset AP roam flag, at this point the roaming behaves the same */
 	station->ap_directed_roaming = false;
@@ -2561,6 +2567,7 @@ static void station_roam_scan_triggered(int err, void *user_data)
 	}
 
 	station_debug_event(station, "roam-scan-triggered");
+	iwd_notice("roam-scan-triggered");
 
 	/*
 	 * Do not update the Scanning property as we won't be updating the
@@ -3159,6 +3166,8 @@ static bool station_retry_owe_default_group(struct station *station)
 static bool station_retry_with_reason(struct station *station,
 					uint16_t reason_code)
 {
+	iwd_notice(IWD_NOTICE_CONNECT_FAILED, "reason: %u", reason_code);
+
 	/*
 	 * We don't want to cause a retry and blacklist if the password was
 	 * incorrect. Otherwise we would just continue to fail.
@@ -3209,6 +3218,8 @@ static bool station_retry_with_status(struct station *station,
 	else
 		blacklist_add_bss(station->connected_bss->addr);
 
+	iwd_notice(IWD_NOTICE_CONNECT_FAILED, "status: %u", status_code);
+
 	return station_try_next_bss(station);
 }
 
@@ -3369,6 +3380,8 @@ static void station_disconnect_event(struct station *station, void *event_data)
 	case STATION_STATE_FT_ROAMING:
 	case STATION_STATE_FW_ROAMING:
 	case STATION_STATE_NETCONFIG:
+		iwd_notice(IWD_NOTICE_DISCONNECT_INFO, "reason: %u",
+					l_get_u16(event_data));
 		station_disassociated(station);
 		return;
 	default:
@@ -3508,7 +3521,12 @@ int __station_connect_network(struct station *station, struct network *network,
 		return r;
 	}
 
-	l_debug("connecting to BSS "MAC, MAC_STR(bss->addr));
+	iwd_notice(IWD_NOTICE_CONNECT_INFO, "ssid: %s, bss: "MAC", "
+					"signal: %d, load: %d/255",
+					network_get_ssid(network),
+					MAC_STR(bss->addr),
+					bss->signal_strength / 100,
+					bss->utilization);
 
 	station->connected_bss = bss;
 	station->connected_network = network;
-- 
2.34.1

