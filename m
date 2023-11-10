Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4BE1B28E
	for <iwd@lists.linux.dev>; Fri, 10 Nov 2023 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X75zt5+u"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ce2de8da87so1164548a34.1
        for <iwd@lists.linux.dev>; Fri, 10 Nov 2023 06:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699625786; x=1700230586; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekbDauHIj4jrXFThCUA2Z01UjDfb9nb9MmkrcEPbhJ4=;
        b=X75zt5+uUdMYI23d6xohA15/fKUdyf7BUXGGo+hbQ9/slTUzgr1WamlujMnF3BVcUN
         UB0g7FOsp6AievB0e2RB2n2brY3ZdQWxrbKkW8IYDz0/C4MYzz5tHEnlk5RUwLAF9HTQ
         aLzMlGoAtLGB2TcmJ6cNDL7irIofwasqMWOC6l7cjzaLanEuFztl5An2EIJTndMvC9Sn
         pR4etS46JjduMFEA8kvY7+ytQlskMMfX9orqSPZEyIudg3j+RZbtUOKqJefasulvKh+a
         nmSI4HlqPymfWvaEKKMe0OojTQ1O5U8FMbx7Mjh7JMtTzUreoTYloB6D930golAgJdMQ
         Bm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699625786; x=1700230586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ekbDauHIj4jrXFThCUA2Z01UjDfb9nb9MmkrcEPbhJ4=;
        b=QTcJ0fp3rJPPc3Oqot/HhjUdkoceoa5OrK2gJklBc0IU5y83OxpFNdmxZBGBVzTzYN
         HOp6UVb/AXRE3TdnF3S4m6KrSvwjH4EJ9uqtuC8rEXb2Q+9zSbkfOcJIjp5k3ISj3WUn
         iIAHt4xDTa90K9w4qP22v6X+9m/QZ4iWbwAn0UnIMdDcTmOtId3JR4obgDq110aJMzqv
         RlKAbhHx0+4aJeWWgxMKa4NrLbapsPMd9Bdis6rHJIfJH16+BaGwgcjq/EUR/kr0z9w5
         7S7mNMnXAVz6uqEKA1+P0RdZOUGyUG4SeLikoiQUGM6UDGgxh3kBy0d4n5aNafAa5dXW
         HHEg==
X-Gm-Message-State: AOJu0YxYIqA7wEHtL3v2zie0nubcMNs7vVp74Cx5jZWsUzyGyalRaWp+
	b/0esaAJ0OAwkLY4/5HcQOJWg0L6bZQ=
X-Google-Smtp-Source: AGHT+IFS/L5faz3uCI9xKyIG1NYL6HcX5C8OC1AjoHlW4Z6UGQStZUWEZ8kGP4lAF2WDHUeRs7B9CQ==
X-Received: by 2002:a9d:6d08:0:b0:6d6:471e:1eda with SMTP id o8-20020a9d6d08000000b006d6471e1edamr1759672otp.4.1699625786519;
        Fri, 10 Nov 2023 06:16:26 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id c10-20020a05621401ea00b0065b11053445sm2958163qvu.54.2023.11.10.06.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 06:16:26 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/3] dpp: add station watch to DPP
Date: Fri, 10 Nov 2023 06:16:20 -0800
Message-Id: <20231110141620.80195-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231110141620.80195-1-prestwoj@gmail.com>
References: <20231110141620.80195-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DPP (both DPP and PKEX) run the risk of odd behavior if station
decides to change state. DPP is completely unaware of this and
best case would just result in a protocol failure, worst case
duplicate calls to __station_connect_network.

Add a station watch and stop DPP if station changes state during
the protocol.
---
 src/dpp.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/src/dpp.c b/src/dpp.c
index f1ea01ff..46330c08 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -100,6 +100,7 @@ struct dpp_sm {
 	char *uri;
 	uint8_t role;
 	int refcount;
+	uint32_t station_watch;
 
 	uint64_t wdev_id;
 
@@ -542,6 +543,8 @@ static void dpp_reset(struct dpp_sm *dpp)
 
 static void dpp_free(struct dpp_sm *dpp)
 {
+	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
+
 	dpp_reset(dpp);
 
 	if (dpp->own_asn1) {
@@ -559,6 +562,13 @@ static void dpp_free(struct dpp_sm *dpp)
 		dpp->boot_private = NULL;
 	}
 
+	/*
+	 * Since this is called when the netdev goes down, station may already
+	 * be gone in which case the state watch will automatically go away.
+	 */
+	if (station)
+		station_remove_state_watch(station, dpp->station_watch);
+
 	l_free(dpp);
 }
 
@@ -3614,6 +3624,55 @@ static void dpp_frame_watch(struct dpp_sm *dpp, uint16_t frame_type,
 					L_UINT_TO_PTR(frame_type), NULL);
 }
 
+/*
+ * Station is unaware of DPP's state so we need to handle a few cases here so
+ * weird stuff doesn't happen:
+ *
+ *   - While configuring we should stay connected, a disconnection/roam should
+ *     stop DPP since it would fail regardless due to the hardware going idle
+ *     or changing channels since configurators assume all comms will be
+ *     on-channel.
+ *   - While enrolling we should stay disconnected. If station connects during
+ *     enrolling it would cause 2x calls to __station_connect_network after
+ *     DPP finishes.
+ *
+ * Other conditions shouldn't ever happen i.e. configuring and going into a
+ * connecting state or enrolling and going to a disconnected/roaming state.
+ */
+static void dpp_station_state_watch(enum station_state state, void *user_data)
+{
+	struct dpp_sm *dpp = user_data;
+
+	switch (state) {
+	case STATION_STATE_DISCONNECTED:
+	case STATION_STATE_DISCONNECTING:
+	case STATION_STATE_ROAMING:
+	case STATION_STATE_FT_ROAMING:
+	case STATION_STATE_FW_ROAMING:
+		L_WARN_ON(dpp->role == DPP_CAPABILITY_ENROLLEE);
+
+		if (dpp->role == DPP_CAPABILITY_CONFIGURATOR) {
+			l_debug("Disconnected while configuring, stopping DPP");
+			dpp_reset(dpp);
+		}
+
+		break;
+	case STATION_STATE_CONNECTING:
+	case STATION_STATE_CONNECTED:
+	case STATION_STATE_CONNECTING_AUTO:
+	case STATION_STATE_AUTOCONNECT_FULL:
+	case STATION_STATE_AUTOCONNECT_QUICK:
+		L_WARN_ON(dpp->role == DPP_CAPABILITY_CONFIGURATOR);
+
+		if (dpp->role == DPP_CAPABILITY_ENROLLEE) {
+			l_debug("Connecting while enrolling, stopping DPP");
+			dpp_reset(dpp);
+		}
+
+		break;
+	}
+}
+
 static void dpp_create(struct netdev *netdev)
 {
 	struct l_dbus *dbus = dbus_get_bus();
@@ -3621,6 +3680,7 @@ static void dpp_create(struct netdev *netdev)
 	uint8_t dpp_conf_response_prefix[] = { 0x04, 0x0b };
 	uint8_t dpp_conf_request_prefix[] = { 0x04, 0x0a };
 	uint64_t wdev_id = netdev_get_wdev_id(netdev);
+	struct station *station = station_find(netdev_get_ifindex(netdev));
 
 	dpp->netdev = netdev;
 	dpp->state = DPP_STATE_NOTHING;
@@ -3666,6 +3726,9 @@ static void dpp_create(struct netdev *netdev)
 				sizeof(dpp_conf_request_prefix),
 				dpp_handle_config_request_frame, dpp, NULL);
 
+	dpp->station_watch = station_add_state_watch(station,
+					dpp_station_state_watch, dpp, NULL);
+
 	l_queue_push_tail(dpp_list, dpp);
 }
 
-- 
2.25.1

