Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA4E21A453
	for <iwd@lists.linux.dev>; Wed, 28 May 2025 20:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748463036; cv=none; b=A3RPN60xutbomO0fe7M7gq2nhuK3dnItDUsm4yAprlOiCwhNI8q0DY1p5a5wS3sHtZAXfwOauQvbOfl7bfcRQP5Vnf1/IogCHk0WVa5XckkPTpS0vEeUwiqu8M8KUSkOrDx/ha70YnR22WOHlvbp03CnGHQw1D606OPlm61t0dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748463036; c=relaxed/simple;
	bh=WJAp0+PUNBX+thmgATikYnSGlJvtzgaVVulj+zVdZc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I6I21cwwb0arc0n6CJxfyKTFpNC9n9OObihcJLqX8Q1oQRRtBKzYKUdBcQjffk8JWC5hb1tdez0hKYXNeqmXRW8CQq5dMTb2qhOYE7pwPffG7jy1JmHKDLmigq16m0GrE2Rgey7uwKMctE2tUEbvD4qV8D0AgguIVRmKhhkHYRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1Gsrf0A; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1Gsrf0A"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6f0c30a1cf8so3302926d6.2
        for <iwd@lists.linux.dev>; Wed, 28 May 2025 13:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748463033; x=1749067833; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zhd0+P2SR7KyI72yh8RZnA914oLlNoRlmm1n0Kzg04w=;
        b=h1Gsrf0AXmHj/dRrw8pa/5BGTg2DXlzOKoJuKXXAyybTCE+yHUmg4RukmwkaI4n1N3
         vRK4f7YTnMN3PWq8Ql2L/XS2nQR+R51fVBJvaPid1VFIhGI8eKjXSCRUD8XTCUPy+gCA
         5snxDwG6gkNUMjb8aGZKaylsqhkewVp/NLPRxXvSYJFGe/olsEngjzjKByC+yFeawYge
         qKlEQLBUdQwEiXghtmYI1YbPx9+2u1aREys7LPi45GQ/BZgw5gy6v5HSO5UTf3mRVCcn
         /z1QTsSvYqEFkXeNNoPQcoO1MKC0M5KWQld1aDychv5/lMK918ZbC33hKckYGVcD99dn
         DEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748463033; x=1749067833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zhd0+P2SR7KyI72yh8RZnA914oLlNoRlmm1n0Kzg04w=;
        b=RgWLF0PcF5YCXu0sXyLl/o1kdFODfCwqBZw9scnjOZ9EpmL3pb+K5qhTKiaPxQrNtp
         tzhX8EzRs/PNlsLstoVv3rOBvhL7VGgurDTEhwNdtpmFT9MVOqxiDjuDaHelarXLM/Mo
         aGl8vNXw8Q8T43mIv15qRU4FlBacpvCPMQVX2tiR5ChXT2Yps4ORTa9+5Vcb0F9yx8VE
         b22LPLV4PdMUJ7UtvWttOrwyEUJXDJELpi7b9YY2WoQitJEAANZcGzVohjcMGMMTnyTa
         dfBvXyikQ4Fo87wmkVd8QI99XE1n16QQgi/IkaDLpH8Q2Ra1/P88LYdSTiWHY25ampJw
         kaIA==
X-Gm-Message-State: AOJu0YzgoH5ZrDP/HK+UoFKwFU6ywfGTV58Kb/xTf01+hs6o5nDyGh8j
	0QgJ3kh51r07PGOR4Rl4fGdYDtkXnme2C3uPpccflp8F8ZrdUib7lLMgFbkBHg==
X-Gm-Gg: ASbGnctOv8vEXqh7IIRTMdv2VQUB4QBXn3AcYff3OGqWKpEdpUJVWoZQGQj6U9Jq7x/
	A6HfvJrtvIoEbBKD4AErbY7AmpV6dqNsKZNGg+4stJG3KXjTRkZvW4TYALAKXSL0PG+nPz8fHj9
	qH53Ehw9cVeb6rAwRNXPaBzbZut7mw3IVArE28/tRTcOdHvkTchPwP7SJ1/FzNTYDP9rKs4Gza3
	yOfFlWxXbCpM667lcGDm1FyxUjMqgHCXtOQqLRALsvgNX1QrSOCr1PtDNM+08oE46UgO9qAJUbK
	n/yBUSHuGg1uPhBZs7JbpHjnoKKSA1z3LhqrwT9QfAMFPI3+dHuiWnR+RWIqRF5VXFSXbdw5
X-Google-Smtp-Source: AGHT+IGYrNNvuGmQ6HgOxUC0k99D7HZdyVImhOzd46lMkyd7//b08RkglfZ7cEgKMmsQGExD9WVkpw==
X-Received: by 2002:ad4:5ec9:0:b0:6f5:4dfa:693c with SMTP id 6a1803df08f44-6fa9d134838mr285825446d6.14.1748463032697;
        Wed, 28 May 2025 13:10:32 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac0b2888asm10408126d6.45.2025.05.28.13.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 13:10:32 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/6] station: include netconfig as part of the BSS retry logic
Date: Wed, 28 May 2025 13:10:23 -0700
Message-Id: <20250528201026.598221-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250528201026.598221-1-prestwoj@gmail.com>
References: <20250528201026.598221-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A netconfig failure results in a failed connection which restarts
autoconnect and prevents IWD from retrying the connection on any
other BSS's within the network as a whole. When autoconnect restarts
IWD will scan and choose the "best" BSS which is likely the same as
the prior attempt. If that BSS is somehow misconfigured as far as
DHCP goes, it will likely fail indefinitely and in turn cause IWD to
retry indefinitely.

To improve this netconfig has been adopted into the IWD's BSS retry
logic. If netconfig fails this will not result in IWD transitioning
to a disconnected state, and instead the BSS will be network
blacklisted and the next will be tried. Only once all BSS's have been
tried will IWD go into a disconnected state and start autoconnect
over.
---
 src/station.c | 85 +++++++++++++++++++++++++--------------------------
 1 file changed, 41 insertions(+), 44 deletions(-)

v2:
 * Removed network_disconnected() call on failure
 * Utilize network_clear_blacklist() and retain the existing call site
   for network_connected()

diff --git a/src/station.c b/src/station.c
index 4180b7a4..a4c3e7d1 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1795,6 +1795,8 @@ static void station_enter_state(struct station *station,
 		periodic_scan_stop(station);
 		break;
 	case STATION_STATE_CONNECTED:
+		network_clear_blacklist(station->connected_network);
+
 		if (station->connect_pending) {
 			struct l_dbus_message *reply =
 				l_dbus_message_new_method_return(
@@ -2221,6 +2223,26 @@ static void station_early_neighbor_report_cb(struct netdev *netdev, int err,
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
@@ -2263,28 +2285,26 @@ static bool station_can_fast_transition(struct station *station,
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
-
-	continue_autoconnect = station->state == STATION_STATE_CONNECTING_AUTO;
+	if (station_try_next_bss(station))
+		return;
 
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
@@ -2297,23 +2317,20 @@ static void station_netconfig_event_handler(enum netconfig_event event,
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
@@ -3416,26 +3433,6 @@ static void station_event_channel_switched(struct station *station,
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
-- 
2.34.1

