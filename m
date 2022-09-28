Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB082595
	for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 18:33:53 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id l9-20020a17090a4d4900b00205e295400eso2419453pjh.4
        for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 11:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=PCY053LlNrPnNh9X0hFtmNBDK3frWHdygcrk/bI2d80=;
        b=AueqeNRLOU04nGDheijVQRWWRkUNzgWABvSYSWXFQ9xT2DeEqLT3994lq0i8qRLut+
         EJO8PAIqBPEUqkh7/uClVe5xL0RlR17+LUiUCzVQU0ip1eizh0bYW7XW65cFjeoRJmvD
         fnyW4Gf2RVx4IQuhcU4CBmxd1QRXnBLzu2YhoRAqWeaZfugt7YRF/IIuTQRDebqMGUJU
         a1KUgCF0WGrUa9UjWxHd+HRDIHlC7tc91YJTHnNhzI3LCOJgp72F6qunM+W4XBfEJRqE
         wN41is/G4mkLA6qXZdFef6t01tmhNbWu622AxsdZuGsCiV0uvYVTzbL/Rqtoh+LqqNJ/
         oHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=PCY053LlNrPnNh9X0hFtmNBDK3frWHdygcrk/bI2d80=;
        b=eFPTHfDBDv/VjTjM1LTR/Ajwz/EODiR7S+5mVbCO9vGigpiQ5o6OQ0vvw7IvdRc7FL
         vEDKP+JCRP7HAbKzhFwaQCmbFr06Z3PrFxzNRiAH5CHmR/Qy/4y5HQ4n6BI04CShHqJZ
         DqD1cq7C/Pk7EbDDhDAwF8geTGlnQxA4M89Unuj/vAXy1i/+n+ppBRn/V6YYwLiZxYuL
         0JZlCij+fthVgXxCGQQbqmv+P5caXyOncRZqFJsY22T2JvuafA251BuiQ3gHOnUiiufs
         ln00CqoFz8XTV5V0HKpainZUb7FZr35a+806mhK6rk2w24ONEdOhMksQIOr5E7l6kqS2
         CbuQ==
X-Gm-Message-State: ACrzQf1P+6tmiYhkIapUbka9u8Zom39PkAOichIiBesf2SnY4ySFEX3u
	uHhblh+ZGPBiZD3RANnrRwKqDGjLaOY=
X-Google-Smtp-Source: AMsMyM4ZzNBLUJ4Lj/eHLYgBHp1YYB4sMm5wVppX7DNuUskXgEES6aY6jFCc/aJLcz6iZFs0KFEzcg==
X-Received: by 2002:a17:90b:3ec2:b0:202:b123:29cc with SMTP id rm2-20020a17090b3ec200b00202b12329ccmr12139291pjb.167.1664390032985;
        Wed, 28 Sep 2022 11:33:52 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902db0900b0016d6c939332sm4148704plx.279.2022.09.28.11.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 11:33:52 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] station: add two new roaming states (FT/FW)
Date: Wed, 28 Sep 2022 11:33:50 -0700
Message-Id: <20220928183351.363600-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds two new station states to differentiate between
reassociation (ROAMING), Fast transition (FT_ROAMING) or a firmare
based roam (FW_ROAMING).
---
 src/station.c | 33 +++++++++++++++++++++++++--------
 src/station.h |  4 +++-
 src/wsc.c     |  2 ++
 3 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/src/station.c b/src/station.c
index 372e23c1..6bd66ffc 100644
--- a/src/station.c
+++ b/src/station.c
@@ -197,6 +197,13 @@ static bool station_is_autoconnecting(struct station *station)
 			station->state == STATION_STATE_AUTOCONNECT_QUICK;
 }
 
+static bool station_is_roaming(struct station *station)
+{
+	return station->state == STATION_STATE_ROAMING ||
+			station->state == STATION_STATE_FT_ROAMING ||
+			station->state == STATION_STATE_FW_ROAMING;
+}
+
 static bool station_debug_event(struct station *station, const char *name)
 {
 	struct l_dbus_message *signal;
@@ -1461,6 +1468,10 @@ static const char *station_state_to_string(enum station_state state)
 		return "disconnecting";
 	case STATION_STATE_ROAMING:
 		return "roaming";
+	case STATION_STATE_FT_ROAMING:
+		return "ft-roaming";
+	case STATION_STATE_FW_ROAMING:
+		return "fw-roaming";
 	}
 
 	return "invalid";
@@ -1599,6 +1610,8 @@ static void station_enter_state(struct station *station,
 	case STATION_STATE_DISCONNECTING:
 		break;
 	case STATION_STATE_ROAMING:
+	case STATION_STATE_FT_ROAMING:
+	case STATION_STATE_FW_ROAMING:
 		station_set_evict_nocarrier(station, false);
 		break;
 	}
@@ -1722,7 +1735,7 @@ static void station_reset_connection_state(struct station *station)
 	if (station->state == STATION_STATE_CONNECTED ||
 			station->state == STATION_STATE_CONNECTING ||
 			station->state == STATION_STATE_CONNECTING_AUTO ||
-			station->state == STATION_STATE_ROAMING)
+			station_is_roaming(station))
 		network_disconnected(network);
 }
 
@@ -2055,7 +2068,7 @@ static void station_roam_failed(struct station *station)
 	 * If we attempted a reassociation or a fast transition, and ended up
 	 * here then we are now disconnected.
 	 */
-	if (station->state == STATION_STATE_ROAMING) {
+	if (station_is_roaming(station)) {
 		station_disassociated(station);
 		return;
 	}
@@ -2245,7 +2258,7 @@ try_next:
 
 	station->connected_bss = bss;
 	station->preparing_roam = false;
-	station_enter_state(station, STATION_STATE_ROAMING);
+	station_enter_state(station, STATION_STATE_FT_ROAMING);
 
 	return true;
 
@@ -2288,7 +2301,7 @@ static bool station_fast_transition(struct station *station,
 
 		station->connected_bss = bss;
 		station->preparing_roam = false;
-		station_enter_state(station, STATION_STATE_ROAMING);
+		station_enter_state(station, STATION_STATE_FT_ROAMING);
 
 		return true;
 	} else {
@@ -2742,7 +2755,8 @@ static bool station_cannot_roam(struct station *station)
 		disabled = false;
 
 	return disabled || station->preparing_roam ||
-					station->state == STATION_STATE_ROAMING;
+				station->state == STATION_STATE_ROAMING ||
+				station->state == STATION_STATE_FT_ROAMING;
 }
 
 #define WNM_REQUEST_MODE_PREFERRED_CANDIDATE_LIST	(1 << 0)
@@ -3180,7 +3194,8 @@ static void station_disconnect_event(struct station *station, void *event_data)
 					event_data, station);
 		return;
 	case STATION_STATE_CONNECTED:
-	case STATION_STATE_ROAMING:
+	case STATION_STATE_FT_ROAMING:
+	case STATION_STATE_FW_ROAMING:
 		station_disassociated(station);
 		return;
 	default:
@@ -3234,7 +3249,7 @@ static void station_netdev_event(struct netdev *netdev, enum netdev_event event,
 			station_signal_agent_notify(station);
 		break;
 	case NETDEV_EVENT_ROAMING:
-		station_enter_state(station, STATION_STATE_ROAMING);
+		station_enter_state(station, STATION_STATE_FW_ROAMING);
 		break;
 	case NETDEV_EVENT_ROAMED:
 		station_event_roamed(station, (struct scan_bss *) event_data);
@@ -3246,7 +3261,7 @@ static void station_netdev_event(struct netdev *netdev, enum netdev_event event,
 		station_packets_lost(station, l_get_u32(event_data));
 		break;
 	case NETDEV_EVENT_FT_ROAMED:
-		if (station->state != STATION_STATE_ROAMING)
+		if (L_WARN_ON(station->state != STATION_STATE_FT_ROAMING))
 			return;
 
 		station_roamed(station);
@@ -4069,6 +4084,8 @@ static bool station_property_get_state(struct l_dbus *dbus,
 		statestr = "disconnecting";
 		break;
 	case STATION_STATE_ROAMING:
+	case STATION_STATE_FT_ROAMING:
+	case STATION_STATE_FW_ROAMING:
 		statestr = "roaming";
 		break;
 	}
diff --git a/src/station.h b/src/station.h
index 67d22f03..24fab321 100644
--- a/src/station.h
+++ b/src/station.h
@@ -42,7 +42,9 @@ enum station_state {
 	STATION_STATE_CONNECTING_AUTO,
 	STATION_STATE_CONNECTED,
 	STATION_STATE_DISCONNECTING,
-	STATION_STATE_ROAMING
+	STATION_STATE_ROAMING,		/* Reassociation */
+	STATION_STATE_FT_ROAMING,	/* Fast transition */
+	STATION_STATE_FW_ROAMING,	/* Firmware roamed by itself */
 };
 
 enum station_event {
diff --git a/src/wsc.c b/src/wsc.c
index bb9f663b..cb2e2c3e 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -665,6 +665,8 @@ static void wsc_check_can_connect(struct wsc_station_dbus *wsc,
 	case STATION_STATE_AUTOCONNECT_QUICK:
 	case STATION_STATE_AUTOCONNECT_FULL:
 	case STATION_STATE_ROAMING:
+	case STATION_STATE_FT_ROAMING:
+	case STATION_STATE_FW_ROAMING:
 		l_warn("%s: invalid station state", __func__);
 		break;
 	}
-- 
2.34.3

