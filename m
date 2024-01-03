Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5448B1C6BC
	for <iwd@lists.linux.dev>; Wed,  3 Jan 2024 18:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTi91vuk"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7810c332a2cso934353485a.1
        for <iwd@lists.linux.dev>; Wed, 03 Jan 2024 10:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704307619; x=1704912419; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUfQaeQFiY/hrzbSzl8jYqU9JdCp/0PNe7cSdz9EVOU=;
        b=VTi91vukLHF5eTUAXLD9UjU3f8ra4QgY4dbvJJAFOSm/myyAvFr/ZIX757bhvjVvGe
         wHb3WDxqWbJnCufJt5k+KceRf/8FP3bakEixg/raf9T/XWFC5dqDIIL0+Y+eupkRjWwE
         MIGQinCHzF/ntgsz4oPpvP0uHUVk9c8d+h+gYjI9RbEPLVPMcpxh8uYLTGWVHE/ND3AW
         4DqNeMNHhqwIxYkLu+N3ki6SYa3jLMRYoU5wQWzby5sLy89skwxmJTQTCy6hDGJ1zUt7
         Y4bVYHiI6tQyzsjb9XNtOv573bsm3LkNpTvNUNeYIMocRf9qV9lcbJI/cf/XvqzLngMN
         szQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704307619; x=1704912419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUfQaeQFiY/hrzbSzl8jYqU9JdCp/0PNe7cSdz9EVOU=;
        b=w9ljByQeH9v5SIXjKm1cMPgx/WKsvp0DU8/DCGLrBU1OjWZYRk5a3YR+tx0yfZJ2Me
         9Hfczzn9pbVtOeL8ZhOysxj3jDBb4xGR63Ybe2awoTe89CIRB3ah4rr5zDEGWfKn0O6f
         DCMDC8kDSyEQdUwzy5Z0YWle+JE8N2uEdDIbNnLAXfiY+Ts9fo/u+VKm6I5lFqsmSMje
         eTJMbVNsW9KZRKC3i20DyUMgrKH9LypWoxbdesElKr580fQ66pzOevMCYHVQoHsLTX/s
         CEMF3iAGmcHpD0WR6aI840UI8Wodrpv6RUcrxRksi2pwIJTeEALGl/wHeHw4DBhPZHPa
         vpCQ==
X-Gm-Message-State: AOJu0Ywbsm/hIA+DdpxfetQ0Uf0WVkpIce5y0U+FnpV+tWivE7HM/Sdc
	qggIe0lPC46vCaDIgXKOJ2eVfuOFx8eC2g==
X-Google-Smtp-Source: AGHT+IFUbas4qpjOMMj7rpX0F9957YmCIMFXotaP83TJ3/jV0Y/NiTwxkCDox0OLGbGzHgD8dZ2/FQ==
X-Received: by 2002:a05:620a:11a7:b0:781:2560:3ceb with SMTP id c7-20020a05620a11a700b0078125603cebmr23391065qkk.89.1704307618826;
        Wed, 03 Jan 2024 10:46:58 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id o21-20020a05620a22d500b00781a147e444sm3693370qki.92.2024.01.03.10.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 10:46:58 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/8] station: add handling for new NETCONFIG state
Date: Wed,  3 Jan 2024 10:46:33 -0800
Message-Id: <20240103184638.533221-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103184638.533221-1-prestwoj@gmail.com>
References: <20240103184638.533221-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was an unhandled corner case if netconfig was running and
multiple roam conditions happened in sequence, all before netconfig
had completed. A single roam before netconfig was already handled
(23f0f5717c) but this did not take into account any additional roam
conditions.

If IWD is in this state, having started netconfig, then roamed, and
again restarted netconfig it is still in a roaming state which will
prevent any further roams. IWD will remain "stuck" on the current
BSS until netconfig completes or gets disconnected.

To fix this a new internal station state was added (no changes to
the DBus API) to distinguish between a purely WiFi connecting state
(STATION_STATE_CONNECTING/AUTO) and netconfig
(STATION_STATE_NETCONFIG). This allows IWD roam as needed if
netconfig is still running.

The change is mainly just adding STATION_STATE_NETCONFIG anywhere
that STATION_STATE_CONNECTING is to maintain the same behavior,
except within the netconfig event handler. In this case we should
never get here without being in either a NETCONFIG or ROAMING
state.

For some background this scenario happens if the DHCP server goes
down for an extended period, e.g. if its being upgraded/serviced.
---
 src/station.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/src/station.c b/src/station.c
index 57d22e91..8f310ec8 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1768,6 +1768,7 @@ static void station_reset_connection_state(struct station *station)
 	if (station->state == STATION_STATE_CONNECTED ||
 			station->state == STATION_STATE_CONNECTING ||
 			station->state == STATION_STATE_CONNECTING_AUTO ||
+			station->state == STATION_STATE_NETCONFIG ||
 			station_is_roaming(station))
 		network_disconnected(network);
 }
@@ -2043,8 +2044,9 @@ static void station_netconfig_event_handler(enum netconfig_event event,
 			dbus_pending_reply(&station->connect_pending, reply);
 		}
 
-		if (L_IN_SET(station->state, STATION_STATE_CONNECTING,
-				STATION_STATE_CONNECTING_AUTO))
+		if (L_IN_SET(station->state, STATION_STATE_NETCONFIG,
+				STATION_STATE_ROAMING, STATION_STATE_FT_ROAMING,
+				STATION_STATE_FW_ROAMING))
 			network_connect_failed(station->connected_network,
 						false);
 
@@ -2070,9 +2072,14 @@ static bool netconfig_after_roam(struct station *station)
 					network_get_settings(network)))
 		return false;
 
-	return netconfig_configure(station->netconfig,
+	if (L_WARN_ON(!netconfig_configure(station->netconfig,
 					station_netconfig_event_handler,
-					station);
+					station)))
+		return false;
+
+	station_enter_state(station, STATION_STATE_NETCONFIG);
+
+	return true;
 }
 
 static void station_roamed(struct station *station)
@@ -3255,6 +3262,8 @@ static void station_connect_ok(struct station *station)
 						station_netconfig_event_handler,
 						station)))
 			return;
+
+		station_enter_state(station, STATION_STATE_NETCONFIG);
 	} else
 		station_enter_state(station, STATION_STATE_CONNECTED);
 }
@@ -4067,7 +4076,8 @@ static struct l_dbus_message *station_dbus_scan(struct l_dbus *dbus,
 		return dbus_error_busy(message);
 
 	if (station->state == STATION_STATE_CONNECTING ||
-			station->state == STATION_STATE_CONNECTING_AUTO)
+			station->state == STATION_STATE_CONNECTING_AUTO ||
+			station->state == STATION_STATE_NETCONFIG)
 		return dbus_error_busy(message);
 
 	station->dbus_scan_subset_idx = 0;
@@ -5025,7 +5035,8 @@ static struct l_dbus_message *station_debug_scan(struct l_dbus *dbus,
 		return dbus_error_busy(message);
 
 	if (station->state == STATION_STATE_CONNECTING ||
-			station->state == STATION_STATE_CONNECTING_AUTO)
+			station->state == STATION_STATE_CONNECTING_AUTO ||
+			station->state == STATION_STATE_NETCONFIG)
 		return dbus_error_busy(message);
 
 	if (!l_dbus_message_get_arguments(message, "aq", &iter))
-- 
2.34.1

