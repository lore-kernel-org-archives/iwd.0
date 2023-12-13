Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256B554FAE
	for <iwd@lists.linux.dev>; Wed, 13 Dec 2023 17:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWjNK0hT"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3ba2e4ff6e1so56894b6e.3
        for <iwd@lists.linux.dev>; Wed, 13 Dec 2023 09:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702488364; x=1703093164; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEPdNfRnU1tcY+wCOLFMTwot+Xe9HH010Ltb3HBhZD0=;
        b=bWjNK0hTdPOn/E0Q/y/O1cTAMhrMYMSegXxTCEhisffBgERCeB+K7AHWSC8Z5HMGse
         zJai8mX2tvAChWzCMFc+Kr/mWUVTxBoY/qBwSODddZeZyZC0Efbto0QNnvbz87aZQ94i
         2j6BSa/OmnBaPHXV99vLp3VcTQqlTdWVY8aohGqoGHQ6TnMLhawOg79SyqGqsuQUlcAc
         ZE7soQFtWB1s19OqWbRNdEF6w5eaYYD1Potk5Xq4vDL7pB9+7q4dpVUnGOVePps6T490
         ISv8yobU/4EArUA41NpMQSvKv00pJ4kKwvmFjm1xG5Eq+NJf+Q9pVphGD6mnA28+8e3I
         L2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702488364; x=1703093164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cEPdNfRnU1tcY+wCOLFMTwot+Xe9HH010Ltb3HBhZD0=;
        b=CU0SWjsL1swEYhHPVg5urcUa+7ULCA2gMbxTXc+pkIiGzMWasKmqzJfQM0n+yRe+M9
         DwhxAaPAzO936yGeYJ7rQ50CWi2GczpwWcSJrjkY5p82bIZvzepsiLuZiqjONutdxxR4
         4VBOOY9s1ZzOrCeeT5GzZjZ/xJ1JGqYuVkKCoXqyAPJ0ZDdtSFIZFDtuYLLDBBLMiYdk
         S09ZS5YmQlWW9jhBsrvQdZ9HLcefyhg20cbJ53EytSj60+9z3Nx8BRViHh0BuIcfGZgd
         UjQ6uA8Js/cJAky3MAJVtY5YmIWwL8nIMEnEzOnkwTZ1q8hPYWO1PNQvnwO6kw/koQcp
         AlZg==
X-Gm-Message-State: AOJu0YwVjx7QGfhu642ug57pCbczWT3hNegJ+oe6+LDGiexrFcpj8kIq
	iFBwswrNwtb6vhLR3EWwHKIi66iJUOk=
X-Google-Smtp-Source: AGHT+IGBYs33TWO1rkpgrBZDw2IjQ950DmIhmyVFfa/qc+0QUxG5Yih1sEzaSqRAH9k2hmBVz0jvOg==
X-Received: by 2002:a05:6808:1290:b0:3b8:9b7f:40e8 with SMTP id a16-20020a056808129000b003b89b7f40e8mr11148565oiw.17.1702488363851;
        Wed, 13 Dec 2023 09:26:03 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id hh12-20020a05622a618c00b00425f0ab0393sm556914qtb.17.2023.12.13.09.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 09:26:03 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 2/4] station: unify scan cancelation
Date: Wed, 13 Dec 2023 09:25:44 -0800
Message-Id: <20231213172546.145998-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213172546.145998-1-prestwoj@gmail.com>
References: <20231213172546.145998-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The scan cancelation was all being done manually so group all the
automatic-type scans into a single cancel function. This includes
hidden, quick, owe, and periodic scans.

This is being done in order to avoid scan failures after DPP
initiates a connection. This is ultimately done through
__station_connect_network which has no cancelation logic. This
patch will move the scan cancelation into station_enter_state
when the state changes to CONNECTING. All the mentioned scans will
be canceled at that point.

DBus scans were left out intentionally as they are an explicit
type of scan rather than one that IWD starts on its own.
---
 src/station.c | 96 +++++++++++++++++++++++----------------------------
 1 file changed, 43 insertions(+), 53 deletions(-)

diff --git a/src/station.c b/src/station.c
index 10860808..95ffee05 100644
--- a/src/station.c
+++ b/src/station.c
@@ -279,16 +279,8 @@ static int station_autoconnect_next(struct station *station)
 			bss->signal_strength);
 
 		r = network_autoconnect(network, bss);
-		if (!r) {
-			if (station->quick_scan_id) {
-				scan_cancel(netdev_get_wdev_id(station->netdev),
-						station->quick_scan_id);
-				station->quick_scan_id = 0;
-				station_property_set_scanning(station, false);
-			}
-
+		if (!r)
 			return 0;
-		}
 
 		l_debug("autoconnect: network_autoconnect: %s (%d)",
 							strerror(-r), r);
@@ -1542,6 +1534,36 @@ static void station_set_drop_unicast_l2_multicast(struct station *station,
 
 static void station_signal_agent_notify(struct station *station);
 
+static void station_cancel_scans(struct station *station)
+{
+	if (station->hidden_network_scan_id) {
+		scan_cancel(netdev_get_wdev_id(station->netdev),
+				station->hidden_network_scan_id);
+
+		dbus_pending_reply(&station->hidden_pending,
+				dbus_error_failed(station->hidden_pending));
+	}
+
+	if (station->quick_scan_id) {
+		scan_cancel(netdev_get_wdev_id(station->netdev),
+				station->quick_scan_id);
+		station->quick_scan_id = 0;
+		station_property_set_scanning(station, false);
+	}
+
+	if (station->owe_hidden_scan_ids) {
+		void *ptr;
+
+		while ((ptr = l_queue_pop_head(station->owe_hidden_scan_ids)))
+			scan_cancel(netdev_get_wdev_id(station->netdev),
+					L_PTR_TO_UINT(ptr));
+
+		l_queue_destroy(station->owe_hidden_scan_ids, NULL);
+	}
+
+	periodic_scan_stop(station);
+}
+
 static void station_enter_state(struct station *station,
 						enum station_state state)
 {
@@ -1594,7 +1616,9 @@ static void station_enter_state(struct station *station,
 		if (station->signal_agent)
 			station_signal_agent_notify(station);
 
-		periodic_scan_stop(station);
+		/* Scans issued during a connection will fail */
+		station_cancel_scans(station);
+
 		break;
 	case STATION_STATE_CONNECTED:
 		l_dbus_object_add_interface(dbus,
@@ -3539,27 +3563,15 @@ void station_connect_network(struct station *station, struct network *network,
 	struct l_dbus *dbus = dbus_get_bus();
 	int err;
 
-	/*
-	 * If a hidden scan is not completed, station_is_busy would not
-	 * indicate anything is going on so we need to cancel the scan and
-	 * fail the connection now.
-	 */
-	if (station->hidden_network_scan_id) {
-		scan_cancel(netdev_get_wdev_id(station->netdev),
-				station->hidden_network_scan_id);
-
-		dbus_pending_reply(&station->hidden_pending,
-				dbus_error_failed(station->hidden_pending));
-	}
-
-	if (station->quick_scan_id) {
-		scan_cancel(netdev_get_wdev_id(station->netdev),
-				station->quick_scan_id);
-		station->quick_scan_id = 0;
-		station_property_set_scanning(station, false);
-	}
-
 	if (station_is_busy(station)) {
+		/*
+		 * All scans will be canceled when entering into a connecting
+		 * state but since we have an async disconnect callback cancel
+		 * them early so we don't potentially trigger a scan in the
+		 * middle of connecting. This also takes care of failing any
+		 * hidden network connection
+		 */
+		station_cancel_scans(station);
 		station_disconnect_onconnect(station, network, bss, message);
 
 		return;
@@ -4539,8 +4551,6 @@ static void station_free(struct station *station)
 		station->netconfig = NULL;
 	}
 
-	periodic_scan_stop(station);
-
 	if (station->signal_agent) {
 		station_signal_agent_release(station->signal_agent,
 					netdev_get_path(station->netdev));
@@ -4551,10 +4561,6 @@ static void station_free(struct station *station)
 		dbus_pending_reply(&station->connect_pending,
 				dbus_error_aborted(station->connect_pending));
 
-	if (station->hidden_pending)
-		dbus_pending_reply(&station->hidden_pending,
-				dbus_error_aborted(station->hidden_pending));
-
 	if (station->disconnect_pending)
 		dbus_pending_reply(&station->disconnect_pending,
 			dbus_error_aborted(station->disconnect_pending));
@@ -4567,23 +4573,7 @@ static void station_free(struct station *station)
 		scan_cancel(netdev_get_wdev_id(station->netdev),
 				station->dbus_scan_id);
 
-	if (station->quick_scan_id)
-		scan_cancel(netdev_get_wdev_id(station->netdev),
-				station->quick_scan_id);
-
-	if (station->hidden_network_scan_id)
-		scan_cancel(netdev_get_wdev_id(station->netdev),
-				station->hidden_network_scan_id);
-
-	if (station->owe_hidden_scan_ids) {
-		void *ptr;
-
-		while ((ptr = l_queue_pop_head(station->owe_hidden_scan_ids)))
-			scan_cancel(netdev_get_wdev_id(station->netdev),
-					L_PTR_TO_UINT(ptr));
-
-		l_queue_destroy(station->owe_hidden_scan_ids, NULL);
-	}
+	station_cancel_scans(station);
 
 	station_roam_state_clear(station);
 
-- 
2.34.1

