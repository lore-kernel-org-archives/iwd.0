Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C94B33E8
	for <iwd@lists.linux.dev>; Tue,  2 May 2023 18:59:49 +0000 (UTC)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7516ac80c6cso219994085a.1
        for <iwd@lists.linux.dev>; Tue, 02 May 2023 11:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683053988; x=1685645988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=94Rkh8z+gaDZSXDDqm2hMR0+yiZZKMR3XOOw2wEMzGA=;
        b=Exa6KtMRzgRBAq9HNORhf8S2EhkxSe7QZpjYqMG+jXkZKezOGxkBTnUCiogWrnQwbh
         N1wLX+A/Dmvj1X4MntgDHFWMuhjDeODn1O9M3YYxvbj8i126h5eN/a0W1Duibw4HRTeO
         6SfYdfL5C0e7mfgm4ueGdai0XfF2UgOVx95xDo9DY79atLM4dtr6RPmzm4vEQwwbeIY/
         tx3S8+zFVwZSQ5pSqcxgd59mtAqnjB2jCjNHYBsEN3B2B88HHZoq0aBDMXFbozauCDA0
         nS/B2VgGTwA4wyx4WmUbmxJAxB74DrhilHGNQigvb/zPAZFVJ8MohqzJw2tdAbdL2SpI
         0D0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683053988; x=1685645988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94Rkh8z+gaDZSXDDqm2hMR0+yiZZKMR3XOOw2wEMzGA=;
        b=GzJse6tzBPDqMZbFx7G/9Zh4jQHNNDeE+RkPOE2zRfrPkYl17YiH1UlJD7m7ttiAaH
         T8tCNpTCsonZMfK+D9QMgZHdnwt0ldoDWN4pcpMCJx9as1i+yR5xPCh8UyQ12QNNlzvD
         f2JxRC/R3PI6+osuMY4dLvJgbyT6EmQL5+ABauwgaI6mP+g/GeUD6EPI503qKLrFgECd
         5VKBxqW2JeEhpZHG+hSgbXfNHQRcycAsEiiQJkLu85MUTF+mv0XeWGlwn28EO9IOdl6g
         uxO2mVBB8Vg1KQlcbvzW+TQDosKqNdtA/EU0InJVeygMfOe9oMFEZTuZClLA7IXjODek
         8Qgg==
X-Gm-Message-State: AC+VfDxJn3NhPwcNBuDqYmVMuwXNjp25bH4Mc1CZj4GD6PyT1ZCe0KQF
	vsKj9k8mtPANaLmk4AhrTHw5ZltGD6M=
X-Google-Smtp-Source: ACHHUZ4DF1ymxACr4lMO2ybG31MhuCB/dWzZBnRIrPqwe8Pqm2SZpow9sQICIwpbEb32v0lxSl6QUw==
X-Received: by 2002:ad4:5de7:0:b0:5ef:d5b0:c327 with SMTP id jn7-20020ad45de7000000b005efd5b0c327mr4486411qvb.11.1683053987999;
        Tue, 02 May 2023 11:59:47 -0700 (PDT)
Received: from LOCLAP699.cardinalhealth-columbus.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id t18-20020a0cea32000000b0061b71220644sm174872qvp.19.2023.05.02.11.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 11:59:47 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2] station: allow roaming before netconfig finishes
Date: Tue,  2 May 2023 11:59:41 -0700
Message-Id: <20230502185941.436015-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If IWD connects under bad RF conditions and netconfig takes
a while to complete (e.g. slow DHCP), the roam timeout
could fire before DHCP is done. Then, after the roam,
IWD would transition automatically to connected before
DHCP was finished. In theory DHCP could still complete after
this point but any process depending on IWD's connected
state would be uninformed and assume IP networking is up.

Fix this by stopping netconfig prior to a roam if IWD is not
in a connected state. Then, once the roam either failed or
succeeded, start netconfig again.
---
 src/station.c | 151 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 90 insertions(+), 61 deletions(-)

v2:
 * Reworked to allow the roam to finish then start netconfig.
   Now netconfig will be reset and resumed after the roam.

diff --git a/src/station.c b/src/station.c
index d5650a29..be571083 100644
--- a/src/station.c
+++ b/src/station.c
@@ -129,6 +129,7 @@ struct station {
 	bool scanning : 1;
 	bool autoconnect : 1;
 	bool autoconnect_can_start : 1;
+	bool netconfig_after_roam : 1;
 };
 
 struct anqp_entry {
@@ -1683,6 +1684,7 @@ static void station_roam_state_clear(struct station *station)
 	station->roam_scan_full = false;
 	station->signal_low = false;
 	station->roam_min_time.tv_sec = 0;
+	station->netconfig_after_roam = false;
 
 	if (station->roam_scan_id)
 		scan_cancel(netdev_get_wdev_id(station->netdev),
@@ -1971,6 +1973,65 @@ static bool station_can_fast_transition(struct handshake_state *hs,
 	return true;
 }
 
+static void station_disconnect_on_error_cb(struct netdev *netdev, bool success,
+					void *user_data)
+{
+	struct station *station = user_data;
+	bool continue_autoconnect;
+
+	station_enter_state(station, STATION_STATE_DISCONNECTED);
+
+	continue_autoconnect = station->state == STATION_STATE_CONNECTING_AUTO;
+
+	if (continue_autoconnect) {
+		if (station_autoconnect_next(station) < 0) {
+			l_debug("Nothing left on autoconnect list");
+			station_enter_state(station,
+					STATION_STATE_AUTOCONNECT_FULL);
+		}
+
+		return;
+	}
+
+	if (station->autoconnect)
+		station_enter_state(station, STATION_STATE_AUTOCONNECT_QUICK);
+}
+
+static void station_netconfig_event_handler(enum netconfig_event event,
+							void *user_data)
+{
+	struct station *station = user_data;
+
+	switch (event) {
+	case NETCONFIG_EVENT_CONNECTED:
+		station_enter_state(station, STATION_STATE_CONNECTED);
+		break;
+	case NETCONFIG_EVENT_FAILED:
+		if (station->connect_pending) {
+			struct l_dbus_message *reply = dbus_error_failed(
+						station->connect_pending);
+
+			dbus_pending_reply(&station->connect_pending, reply);
+		}
+
+		if (L_IN_SET(station->state, STATION_STATE_CONNECTING,
+				STATION_STATE_CONNECTING_AUTO))
+			network_connect_failed(station->connected_network,
+						false);
+
+		netdev_disconnect(station->netdev,
+					station_disconnect_on_error_cb,
+					station);
+		station_reset_connection_state(station);
+
+		station_enter_state(station, STATION_STATE_DISCONNECTING);
+		break;
+	default:
+		l_error("station: Unsupported netconfig event: %d.", event);
+		break;
+	}
+}
+
 static void station_roamed(struct station *station)
 {
 	station->roam_scan_full = false;
@@ -1999,7 +2060,14 @@ static void station_roamed(struct station *station)
 
 	l_queue_clear(station->roam_bss_list, l_free);
 
-	station_enter_state(station, STATION_STATE_CONNECTED);
+	/* Re-enable netconfig if it never finished on the last BSS */
+	if (station->netconfig_after_roam) {
+		station->netconfig_after_roam = false;
+		L_WARN_ON(!netconfig_configure(station->netconfig,
+						station_netconfig_event_handler,
+						station));
+	} else
+		station_enter_state(station, STATION_STATE_CONNECTED);
 }
 
 static void station_roam_retry(struct station *station)
@@ -2032,6 +2100,14 @@ static void station_roam_failed(struct station *station)
 		return;
 	}
 
+	/* Re-enable netconfig if needed, even on a failed roam */
+	if (station->netconfig_after_roam) {
+		station->netconfig_after_roam = false;
+		L_WARN_ON(!netconfig_configure(station->netconfig,
+						station_netconfig_event_handler,
+						station));
+	}
+
 	/*
 	 * We were told by the AP to roam, but failed.  Try ourselves or
 	 * wait for the AP to tell us to roam again
@@ -2060,65 +2136,6 @@ delayed_retry:
 	station_roam_retry(station);
 }
 
-static void station_disconnect_on_error_cb(struct netdev *netdev, bool success,
-					void *user_data)
-{
-	struct station *station = user_data;
-	bool continue_autoconnect;
-
-	station_enter_state(station, STATION_STATE_DISCONNECTED);
-
-	continue_autoconnect = station->state == STATION_STATE_CONNECTING_AUTO;
-
-	if (continue_autoconnect) {
-		if (station_autoconnect_next(station) < 0) {
-			l_debug("Nothing left on autoconnect list");
-			station_enter_state(station,
-					STATION_STATE_AUTOCONNECT_FULL);
-		}
-
-		return;
-	}
-
-	if (station->autoconnect)
-		station_enter_state(station, STATION_STATE_AUTOCONNECT_QUICK);
-}
-
-static void station_netconfig_event_handler(enum netconfig_event event,
-							void *user_data)
-{
-	struct station *station = user_data;
-
-	switch (event) {
-	case NETCONFIG_EVENT_CONNECTED:
-		station_enter_state(station, STATION_STATE_CONNECTED);
-		break;
-	case NETCONFIG_EVENT_FAILED:
-		if (station->connect_pending) {
-			struct l_dbus_message *reply = dbus_error_failed(
-						station->connect_pending);
-
-			dbus_pending_reply(&station->connect_pending, reply);
-		}
-
-		if (L_IN_SET(station->state, STATION_STATE_CONNECTING,
-				STATION_STATE_CONNECTING_AUTO))
-			network_connect_failed(station->connected_network,
-						false);
-
-		netdev_disconnect(station->netdev,
-					station_disconnect_on_error_cb,
-					station);
-		station_reset_connection_state(station);
-
-		station_enter_state(station, STATION_STATE_DISCONNECTING);
-		break;
-	default:
-		l_error("station: Unsupported netconfig event: %d.", event);
-		break;
-	}
-}
-
 static void station_reassociate_cb(struct netdev *netdev,
 					enum netdev_result result,
 					void *event_data,
@@ -2404,8 +2421,20 @@ static void station_transition_start(struct station *station)
 		l_free(rbss);
 	}
 
-	if (!roaming)
+	if (!roaming) {
 		station_roam_failed(station);
+		return;
+	}
+
+	/*
+	 * Netconfig could potentially be running and not completed yet. We
+	 * still should roam in this case but need to restart netconfig once the
+	 * roam is finished.
+	 */
+	if (station->netconfig && station->state != STATION_STATE_CONNECTED) {
+		netconfig_reset(station->netconfig);
+		station->netconfig_after_roam = true;
+	}
 }
 
 static void station_roam_scan_triggered(int err, void *user_data)
-- 
2.25.1

