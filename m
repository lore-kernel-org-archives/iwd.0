Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E3C82C60
	for <iwd@lists.linux.dev>; Wed, 28 May 2025 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748442477; cv=none; b=LEBvHfXYjZUsKiHqaLJyEKybd2W5qRw3FiwRtcO81jJ7gQohBHcgoCwe/A+9NchwwzXo6HRqGP8MwBiKubDl0TbW5L2Y21HpDQxNRAFQfglJNNptpHRzcWNVcDE4SyjTWekYGrMlSgCgflYLO5FMadHUQ/vX0ZsOcftCBt+kpZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748442477; c=relaxed/simple;
	bh=GGyy2oP4zs32+m4+mBDoAx284jyEMXAz2V4A4Vf0PII=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ExTGEIQwpAUSj0FyRUcUWi8QyFzcSUfRV4XBDnPz1ykGi5I34a3YOfeoZ6kPEXTO9thx6T7hC59VEk3/iw1cJc+GZ2LS/uTk3hCoA4ceyUT65z05HDnGO6wpP8W+Cb7YqyVzuC8woXGWLZnOysJLrtHY4MgGd01ZLStngOD8yCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+QFxO1o; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+QFxO1o"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6faa9e72827so46640226d6.2
        for <iwd@lists.linux.dev>; Wed, 28 May 2025 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748442474; x=1749047274; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dC65H4hhYOrJU+ANzDkHdfgzMtnNFVMdxF3B03m+ZGk=;
        b=M+QFxO1o+IApn5wjnlHELcBQIMctaEoHHgjZMvpWrHgTtRodbVKtbv+LqVruHf3PDs
         hiEdEQ9U7A8rJyEAzbCajZ8P4pLaBdAFVmoqtmU86pb693d0J0MTu6B6yygRz79IgIjc
         MYOQcFOhBAq3fi2Vpk5LjQ26OBthOQAC6vGuwZszw4TVmrvHiEDw4DuR+PK0gZ+/NsiI
         pVB4cEh4F8QC1mmINJ9udlAV378OABSFZzH5T/ffEHuzLQf3vckoc0ZBtG3UaOThHFEH
         ROOJmbpGIBQZzZkffNOk0nr8dBvqORdRKrNw0SU27gP9415VYXQC85qKX/K2p9oJs05c
         mZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748442474; x=1749047274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dC65H4hhYOrJU+ANzDkHdfgzMtnNFVMdxF3B03m+ZGk=;
        b=TFD19WoH0V8zvUJoYy0dtZ4txP29rXlVnsAq//j1MLIse2qf2MXAGIOepnA7yySClx
         8LlJhO2H4/FDSfG+IgqHMkuYyt4KGqRhemSpYZ7pUwDxe8mxGCeyePSI/6sHieCOUqOi
         +FNfDtjqDtANGgrHD1zGkhVO4yRhstEjTDV7c7dDYDbZmXu6AXb5VdjVkdIswEdMle77
         ccs+Ibfb4rqLzHxUgBq0PQmqQ/lMzTLh1YmxoPlCWxvIctGogHAcO4mfZicyFZka5SxJ
         Q8+v1Mtyohza1+R5fhe4L6npWyySCA9BCjpqpyfboTqPLCIM9bCGqEq82xxyLFyf/TIJ
         11/Q==
X-Gm-Message-State: AOJu0YyIW9tQm9er9YtJduJFyH7JxXiGA+i8VRHwDSOiH45UriNmb0tJ
	+VJ2AUTausFTsupo7trIRMpuarSJLeqN0xpBrRhFLT/ZkDbtvKC0XmQE7K26cw==
X-Gm-Gg: ASbGncuumdDpJ78fukJ9eIkjYDTomSn9rk57erfzC3/bLum0mEGbyAcuYh2zVfco1Mz
	EtIUfESWx+MeHsOeFk5EUZ+1INFOYQc5BMzadPazyZCH652MYhzjJZuKsmWZWTB4X+WmOivVrmB
	AZZZBSgybbAiRQ3vcduxkF98vMjod6eiCccsDsMuEdo3ttL+l6kDk5OyU7vhepF89YFqvhE3fvl
	t1CP1/hwDxVX9la3qWUoDWwa3dh1lSloLAJnHdlnk0MRFP7Lu7DYBN1DqZY5kKjFMzNxOm1h4qQ
	WZxgxcG4YUa1tF9JFTWwSwa+litgEmBoTLK8BWJFCNuwdqLzSried2k8R+HwZQ==
X-Google-Smtp-Source: AGHT+IHEQOLfWuMTzbQu69hkxHgDrcdbj6zhaLs9kUMuPJNgvmGTKM48hiXBkkEsQaU8Fjx5U81UTA==
X-Received: by 2002:a05:6214:224a:b0:6fa:bb44:fde5 with SMTP id 6a1803df08f44-6fabb4512fcmr66424596d6.17.1748442473767;
        Wed, 28 May 2025 07:27:53 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac0b2244fsm6960526d6.17.2025.05.28.07.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 07:27:53 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] station: treat netconfig failures as connection failures
Date: Wed, 28 May 2025 07:27:47 -0700
Message-Id: <20250528142750.498252-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the netconfig functionality is somewhat separated from
IWD's "connection" process. Regardless if netconfig is enabled
the method return from Connect() will happen after IWD has completed
the 4-way handshake. If netconfig fails its shows externally as an
IWD state change rather than part of the method return from
Connect(). Overall this doesn't pose a significant problem since a
netconfig failure essentially appears as if IWD became disconnected
but more critical is that IWD will not iteratively try more BSS's if
netconfig fails.

For example a BSS may be misconfigured, or not able to communicate to
the DHCP server. IWD could connect to it, and fail netconfig thereby
restarting the autoconnect logic. IWD will then choose the "best" BSS
which may be the one it just failed on. This would then repeat
indefinitely or until a better BSS comes around which could be never.

To improve this netconfig has been adopted into the IWD's BSS retry
logic. If netconfig fails this will not result in IWD transitioning
to a disconnected state, and instead the BSS will be network
blacklisted and the next will be tried. Only once all BSS's have been
tried will IWD go into a disconnected state and start autoconnect
over.
---
 src/station.c | 104 +++++++++++++++++++++++++-------------------------
 1 file changed, 51 insertions(+), 53 deletions(-)

diff --git a/src/station.c b/src/station.c
index 2b6a18f8..81c1e595 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1795,6 +1795,13 @@ static void station_enter_state(struct station *station,
 		periodic_scan_stop(station);
 		break;
 	case STATION_STATE_CONNECTED:
+		if (station->connect_pending) {
+			struct l_dbus_message *reply =
+				l_dbus_message_new_method_return(
+						station->connect_pending);
+			dbus_pending_reply(&station->connect_pending, reply);
+		}
+
 		l_dbus_object_add_interface(dbus,
 					netdev_get_path(station->netdev),
 					IWD_STATION_DIAGNOSTIC_INTERFACE,
@@ -2214,6 +2221,26 @@ static void station_early_neighbor_report_cb(struct netdev *netdev, int err,
 				&station->roam_freqs);
 }
 
+static bool station_try_next_bss(struct station *station)
+{
+	struct scan_bss *next;
+	int ret;
+
+	next = network_bss_select(station->connected_network, false);
+
+	if (!next)
+		return false;
+
+	ret = __station_connect_network(station, station->connected_network,
+						next, station->state);
+	if (ret < 0)
+		return false;
+
+	l_debug("Attempting to connect to next BSS "MAC, MAC_STR(next->addr));
+
+	return true;
+}
+
 static bool station_can_fast_transition(struct station *station,
 					struct handshake_state *hs,
 					struct scan_bss *bss)
@@ -2256,28 +2283,28 @@ static bool station_can_fast_transition(struct station *station,
 	return true;
 }
 
-static void station_disconnect_on_error_cb(struct netdev *netdev, bool success,
-					void *user_data)
+static void station_disconnect_on_netconfig_failed(struct netdev *netdev,
+							bool success,
+							void *user_data)
 {
 	struct station *station = user_data;
-	bool continue_autoconnect;
 
-	station_enter_state(station, STATION_STATE_DISCONNECTED);
+	if (station_try_next_bss(station))
+		return;
 
-	continue_autoconnect = station->state == STATION_STATE_CONNECTING_AUTO;
+	network_disconnected(station->connected_network);
 
-	if (continue_autoconnect) {
-		if (station_autoconnect_next(station) < 0) {
-			l_debug("Nothing left on autoconnect list");
-			station_enter_state(station,
-					STATION_STATE_AUTOCONNECT_FULL);
-		}
+	if (station->connect_pending) {
+		struct l_dbus_message *reply = dbus_error_failed(
+						station->connect_pending);
 
-		return;
+		dbus_pending_reply(&station->connect_pending, reply);
 	}
 
-	if (station->autoconnect)
-		station_enter_state(station, STATION_STATE_AUTOCONNECT_QUICK);
+	station_reset_connection_state(station);
+
+	station_enter_state(station, STATION_STATE_DISCONNECTED);
+	station_enter_state(station, STATION_STATE_AUTOCONNECT_FULL);
 }
 
 static void station_netconfig_event_handler(enum netconfig_event event,
@@ -2287,26 +2314,24 @@ static void station_netconfig_event_handler(enum netconfig_event event,
 
 	switch (event) {
 	case NETCONFIG_EVENT_CONNECTED:
+		network_connected(station->connected_network);
 		station_enter_state(station, STATION_STATE_CONNECTED);
 		break;
 	case NETCONFIG_EVENT_FAILED:
-		if (station->connect_pending) {
-			struct l_dbus_message *reply = dbus_error_failed(
-						station->connect_pending);
+		station_debug_event(station, "netconfig-failed");
 
-			dbus_pending_reply(&station->connect_pending, reply);
-		}
+		netconfig_reset(station->netconfig);
 
 		if (station->state == STATION_STATE_NETCONFIG)
 			network_connect_failed(station->connected_network,
 						false);
 
+		network_blacklist_add(station->connected_network,
+						station->connected_bss);
+
 		netdev_disconnect(station->netdev,
-					station_disconnect_on_error_cb,
+					station_disconnect_on_netconfig_failed,
 					station);
-		station_reset_connection_state(station);
-
-		station_enter_state(station, STATION_STATE_DISCONNECTING);
 		break;
 	default:
 		l_error("station: Unsupported netconfig event: %d.", event);
@@ -3409,26 +3434,6 @@ static void station_event_channel_switched(struct station *station,
 	network_bss_update(network, station->connected_bss);
 }
 
-static bool station_try_next_bss(struct station *station)
-{
-	struct scan_bss *next;
-	int ret;
-
-	next = network_bss_select(station->connected_network, false);
-
-	if (!next)
-		return false;
-
-	ret = __station_connect_network(station, station->connected_network,
-						next, station->state);
-	if (ret < 0)
-		return false;
-
-	l_debug("Attempting to connect to next BSS "MAC, MAC_STR(next->addr));
-
-	return true;
-}
-
 static bool station_retry_owe_default_group(struct station *station)
 {
 	/*
@@ -3581,13 +3586,6 @@ static void station_connect_ok(struct station *station)
 
 	l_debug("");
 
-	if (station->connect_pending) {
-		struct l_dbus_message *reply =
-			l_dbus_message_new_method_return(
-						station->connect_pending);
-		dbus_pending_reply(&station->connect_pending, reply);
-	}
-
 	/*
 	 * Get a neighbor report now so future roams can avoid waiting for
 	 * a report at that time
@@ -3598,8 +3596,6 @@ static void station_connect_ok(struct station *station)
 			l_warn("Could not request neighbor report");
 	}
 
-	network_connected(station->connected_network);
-
 	if (station->netconfig) {
 		if (hs->fils_ip_req_ie && hs->fils_ip_resp_ie) {
 			struct ie_fils_ip_addr_response_info info;
@@ -3639,8 +3635,10 @@ static void station_connect_ok(struct station *station)
 			return;
 
 		station_enter_state(station, STATION_STATE_NETCONFIG);
-	} else
+	} else {
+		network_connected(station->connected_network);
 		station_enter_state(station, STATION_STATE_CONNECTED);
+	}
 }
 
 static void station_connect_cb(struct netdev *netdev, enum netdev_result result,
-- 
2.34.1

