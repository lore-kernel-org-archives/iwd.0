Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8A52E3F2
	for <iwd@lists.linux.dev>; Fri,  5 Jan 2024 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gc4SwiZC"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-67fa018c116so7925776d6.3
        for <iwd@lists.linux.dev>; Fri, 05 Jan 2024 06:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704466076; x=1705070876; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qr8IxkfTm+OARkC8wd1qTikgUjVh3/KeOFW/Qt1SPuM=;
        b=gc4SwiZCGj99QrIhScoPJaF2lc0TjcghcQ4MDFoh7cHS8Zd3azyJ4P/C4cNpkQGbhh
         aU+cGiFs+xFB9gg7rQ0x4YxWDp71mlonkRKPY6A+iDdILb/SW7ohRb/Okc6N+BWueNzD
         QqjrWnpVQ0Gy3zkfYxrQZrjbwgEHzWtJrxqIlNQaqo768X21WaNaXXTjjzi4r3Eei+e0
         u7rG/X/k3ErWuGPLOrFlpww6EHPQGgOKQ7cR+7goCe2M2Ot8YnNueaNa/nV/cUK7KyY8
         eP045S91rwbzFRYaQyGxjxzd3uUe6KzkwrMeGnRM4d+6rOpUK8rDndIfxqF65kXcazfi
         548Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704466076; x=1705070876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qr8IxkfTm+OARkC8wd1qTikgUjVh3/KeOFW/Qt1SPuM=;
        b=AVosAwDK0q65yC7Eq1z5MErMCxV7FQx05tl0zLq8f7ppvu5TznD/zHMeOgGMisWShM
         Q2OQ9j1QT0/h/fzl0GTlPV989ksgqWE2ZKrNYTWDNFM2841KMfdL5uFhTBAkdTpIYZqu
         549vnwHf7/W9DuhceygkR0MbJ3L2q7JVqiaJZM5ptpNHjkNB48Pd3hVyMDYQ5iYA5Lxw
         AYiyVCWI4/a2qf71it8j934AMYsioL0Vd14u5couu6dvMNJ1vtYfdZf8NTGKfrF80/jo
         jicynSvV8xiIy6TaHjo7Y3okv3BQ4cOjMLhm062xs8/MxIPB7QYsWGo0zh8Yh9ijdiBY
         QiIQ==
X-Gm-Message-State: AOJu0YznB2kQRVxC2Tr2hXupnOIsTaAFPAiDQlSRe5F/WGylQurb/5Bo
	jljnR+h327YTQDc1vCNTcBmGUjEQcic=
X-Google-Smtp-Source: AGHT+IEVlzYPHHRslEQuKiSn3yYJ5TeDwif5CmwHE/V7+vo9PrFev6xk+RBXeTP1DC8ABwuTYeeCnA==
X-Received: by 2002:a05:6214:2303:b0:67a:c570:1528 with SMTP id gc3-20020a056214230300b0067ac5701528mr2353061qvb.20.1704466075859;
        Fri, 05 Jan 2024 06:47:55 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id pz30-20020ad4551e000000b0067f8f04a2fcsm656843qvb.57.2024.01.05.06.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 06:47:55 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/3] station: add handling for new NETCONFIG state
Date: Fri,  5 Jan 2024 06:47:49 -0800
Message-Id: <20240105144750.839705-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105144750.839705-1-prestwoj@gmail.com>
References: <20240105144750.839705-1-prestwoj@gmail.com>
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

In addition the general state logic is wrong here. If IWD roams
prior to netconfig it should stay in a connecting state (from the
perspective of DBus).

To fix this a new internal station state was added (no changes to
the DBus API) to distinguish between a purely WiFi connecting state
(STATION_STATE_CONNECTING/AUTO) and netconfig
(STATION_STATE_NETCONFIG). This allows IWD roam as needed if
netconfig is still running. Also, some special handling was added so
the station state property remains in a "connected" state until
netconfig actually completes, regardless of roams.

For some background this scenario happens if the DHCP server goes
down for an extended period, e.g. if its being upgraded/serviced.
---
 src/station.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

v2:
 * Stay in a "connecting" state if roaming before netconfig from
   a DBus property perspective.
 * Minor changes using L_IN_SET

There are still improvements needed in this area, but this at
least fixes the major issues related to the state change and allowing
multiple roams. Still TODO:

 * Add a netconfig timeout (in ELL)
 * Put netconfig behind a wiphy work item. This requires some thought
   since we'd still need to allow roam scans, but just not any other
   scans/offchannel.

diff --git a/src/station.c b/src/station.c
index 68cac945..a6442d3e 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1770,6 +1770,7 @@ static void station_reset_connection_state(struct station *station)
 	if (station->state == STATION_STATE_CONNECTED ||
 			station->state == STATION_STATE_CONNECTING ||
 			station->state == STATION_STATE_CONNECTING_AUTO ||
+			station->state == STATION_STATE_NETCONFIG ||
 			station_is_roaming(station))
 		network_disconnected(network);
 }
@@ -2045,8 +2046,7 @@ static void station_netconfig_event_handler(enum netconfig_event event,
 			dbus_pending_reply(&station->connect_pending, reply);
 		}
 
-		if (L_IN_SET(station->state, STATION_STATE_CONNECTING,
-				STATION_STATE_CONNECTING_AUTO))
+		if (station->state == STATION_STATE_NETCONFIG)
 			network_connect_failed(station->connected_network,
 						false);
 
@@ -2072,9 +2072,14 @@ static bool netconfig_after_roam(struct station *station)
 					network_get_settings(network)))
 		return false;
 
-	return netconfig_configure(station->netconfig,
+	if (!netconfig_configure(station->netconfig,
 					station_netconfig_event_handler,
-					station);
+					station))
+		return false;
+
+	station_enter_state(station, STATION_STATE_NETCONFIG);
+
+	return true;
 }
 
 static void station_roamed(struct station *station)
@@ -3253,6 +3258,8 @@ static void station_connect_ok(struct station *station)
 						station_netconfig_event_handler,
 						station)))
 			return;
+
+		station_enter_state(station, STATION_STATE_NETCONFIG);
 	} else
 		station_enter_state(station, STATION_STATE_CONNECTED);
 }
@@ -4064,8 +4071,10 @@ static struct l_dbus_message *station_dbus_scan(struct l_dbus *dbus,
 	if (station->dbus_scan_id)
 		return dbus_error_busy(message);
 
-	if (station->state == STATION_STATE_CONNECTING ||
-			station->state == STATION_STATE_CONNECTING_AUTO)
+	if (L_IN_SET(station->state, STATION_STATE_CONNECTING,
+				STATION_STATE_CONNECTING_AUTO,
+				STATION_STATE_NETCONFIG) ||
+				station_is_roaming(station))
 		return dbus_error_busy(message);
 
 	station->dbus_scan_subset_idx = 0;
@@ -4288,7 +4297,14 @@ static bool station_property_get_state(struct l_dbus *dbus,
 	case STATION_STATE_ROAMING:
 	case STATION_STATE_FT_ROAMING:
 	case STATION_STATE_FW_ROAMING:
-		statestr = "roaming";
+		/*
+		 * Stay in a connecting state if roaming before netconfig
+		 * has finished
+		 */
+		if (station->netconfig_after_roam)
+			statestr = "connecting";
+		else
+			statestr = "roaming";
 		break;
 	}
 
@@ -5022,8 +5038,10 @@ static struct l_dbus_message *station_debug_scan(struct l_dbus *dbus,
 	if (station->dbus_scan_id)
 		return dbus_error_busy(message);
 
-	if (station->state == STATION_STATE_CONNECTING ||
-			station->state == STATION_STATE_CONNECTING_AUTO)
+	if (L_IN_SET(station->state, STATION_STATE_CONNECTING,
+				STATION_STATE_CONNECTING_AUTO,
+				STATION_STATE_NETCONFIG) ||
+				station_is_roaming(station))
 		return dbus_error_busy(message);
 
 	if (!l_dbus_message_get_arguments(message, "aq", &iter))
-- 
2.34.1

