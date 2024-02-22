Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD26148FE6
	for <iwd@lists.linux.dev>; Thu, 22 Feb 2024 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615510; cv=none; b=pcIe1Y8KixEv7dZ0fk6ieXDATX962cvWYXSzTeZTbFVIRafRahKoWoyJom3pNMZYapmOO56JBZD2iynuVSc8S2RfKbDJ3HER3ULwlkQ+Hx74YYKHUDq1wNqo/fsBjzuVS1ZmGFMDyK1W2nnGi7j+FFlM9+BQlNfh1ds63rz8pwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615510; c=relaxed/simple;
	bh=W0bZObP3tVFXeX9n82rV3ag9yqIcamebywg3CMtpTQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tSwTHHNGkrOE3Cq3UF1SwOuEvijABhG9pYjOGir+R0m+cZZadeYNyKk0USL2rwb0syr54wQflL58pv2seHV591DZEh6h4sY1jTi/g2xucRQJlt5+E8k/ujB+Wo4YDO43Xdkopk23gCQ5CXiE5Ew9XQKn5NoAqqcrZiRvqUEyR4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzHDvnv1; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzHDvnv1"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d731314e67so58362745ad.1
        for <iwd@lists.linux.dev>; Thu, 22 Feb 2024 07:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708615507; x=1709220307; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4nImlvJnivfs9V0+/iuGxuAV9smyFbHtiNjuzhjiog=;
        b=GzHDvnv1D2ouL+6vzOd5I8nUUVWQag4rbqPUzeZXZpsHhn06ntHvaYE77S/+YlCBES
         8Y3OM/Q4KrIyYjL7P+F3KJFj+ewgzQNM4l4gNxConpdHj9Fz1RFPlbA2KaBa44dLWuMa
         5bp3FtzJ7crjzavyJ/jcgWm6zt0FVW5IjYgn2naqAe/JvE9AL7mpp5YiuSQj4AQ9h/So
         XqNmtLV75DoVYA9uD+K72T/mJbApBxTLwyrzzqxTlG3wJx49Mc40p+/wFEVDHoCT57/U
         gclLZ495oISJ3KdCzcHJgAPujMC6Lc1GxsSOjNmVbVzLSq3rAlYU3eiU+cFKQKouacn/
         bzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708615507; x=1709220307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4nImlvJnivfs9V0+/iuGxuAV9smyFbHtiNjuzhjiog=;
        b=iG6cEAwjh3//fgpu3y2/yC0ZvUzryJRVDNAOc22Gpv0l5KmQvpBmh17IlAzUq5lseR
         TgLiZwRZjlfTAg/ewm+2YcagXfXLwfQmfyKfVmvzfpgiijhujyaGJAk6Tgw/v/XSEBQz
         wKDyEZsQj3hr9zVC+fmbXO0q90Z38MTqMah3CPFKlxY6t+/wLIfj3rA1XtQhfqz35qRn
         Pc6S4y89ASqpmXGWVcf5MXJEzQG6lOqpcwkfbR9foZqoGQqM/sr5Uu4VTB3cmy2970cX
         LExcaLRWjqogm1tLU7U7sECZ0U/YA1J1m1EYCqHMKrO3zNBx7QsaQ6zbQ5AhO+G5r0aI
         Kb9g==
X-Gm-Message-State: AOJu0Yy6IakHuO4U43my2PIdgk15QKDDyFVmF027QCYfG46L6viGwBFo
	f4ory12JJL6K3UNIvMzrVFWc53oYC82V1clhVK3kg6EhBjl0bozSPFhTUF6k
X-Google-Smtp-Source: AGHT+IFbm9FTsr2sL0MH543nYtSsBwodqT5WtQglAgtHdjDqaKeKLsmXBvPrK47IN7X04Ryi3yYI5A==
X-Received: by 2002:a17:903:24c:b0:1db:63aa:6d33 with SMTP id j12-20020a170903024c00b001db63aa6d33mr23526546plh.4.1708615507561;
        Thu, 22 Feb 2024 07:25:07 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id jd20-20020a170903261400b001d94a3f3987sm10044873plb.184.2024.02.22.07.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 07:25:07 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/7] station: use iwd_notice for state/event information
Date: Thu, 22 Feb 2024 07:24:50 -0800
Message-Id: <20240222152451.1541682-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222152451.1541682-1-prestwoj@gmail.com>
References: <20240222152451.1541682-1-prestwoj@gmail.com>
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
 src/station.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/src/station.c b/src/station.c
index ea505ca2..8817637b 100644
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
 
@@ -2352,12 +2352,16 @@ static bool station_ft_work_ready(struct wiphy_radio_work_item *item)
 				roam_bss_rank_compare, NULL);
 
 		station_debug_event(station, "ft-fallback-to-reassoc");
+		iwd_notice(IWD_NOTICE_FT_ROAM_FAILED, "status: %d",
+					MMPDU_STATUS_CODE_INVALID_PMKID);
 
 		station_transition_start(station);
 		l_steal_ptr(rbss);
 		break;
 	case -ENOENT:
 		station_debug_event(station, "ft-roam-failed");
+		iwd_notice(IWD_NOTICE_FT_ROAM_FAILED,
+				"status: authentication timeout");
 try_next:
 		station_transition_start(station);
 		break;
@@ -2384,8 +2388,10 @@ disassociate:
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
@@ -2457,8 +2463,10 @@ static bool station_try_next_transition(struct station *station,
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
@@ -2561,6 +2569,7 @@ static void station_roam_scan_triggered(int err, void *user_data)
 	}
 
 	station_debug_event(station, "roam-scan-triggered");
+	iwd_notice(IWD_NOTICE_ROAM_SCAN);
 
 	/*
 	 * Do not update the Scanning property as we won't be updating the
@@ -3159,6 +3168,8 @@ static bool station_retry_owe_default_group(struct station *station)
 static bool station_retry_with_reason(struct station *station,
 					uint16_t reason_code)
 {
+	iwd_notice(IWD_NOTICE_CONNECT_FAILED, "reason: %u", reason_code);
+
 	/*
 	 * We don't want to cause a retry and blacklist if the password was
 	 * incorrect. Otherwise we would just continue to fail.
@@ -3209,6 +3220,8 @@ static bool station_retry_with_status(struct station *station,
 	else
 		blacklist_add_bss(station->connected_bss->addr);
 
+	iwd_notice(IWD_NOTICE_CONNECT_FAILED, "status: %u", status_code);
+
 	return station_try_next_bss(station);
 }
 
@@ -3369,6 +3382,8 @@ static void station_disconnect_event(struct station *station, void *event_data)
 	case STATION_STATE_FT_ROAMING:
 	case STATION_STATE_FW_ROAMING:
 	case STATION_STATE_NETCONFIG:
+		iwd_notice(IWD_NOTICE_DISCONNECT_INFO, "reason: %u",
+					l_get_u16(event_data));
 		station_disassociated(station);
 		return;
 	default:
@@ -3508,7 +3523,12 @@ int __station_connect_network(struct station *station, struct network *network,
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

