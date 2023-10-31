Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9341E530
	for <iwd@lists.linux.dev>; Tue, 31 Oct 2023 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVM7mbt1"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-67131800219so21769746d6.3
        for <iwd@lists.linux.dev>; Tue, 31 Oct 2023 11:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698778084; x=1699382884; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUCpVo4hvLbvW9owbr/nYYc5HPo8z6nB2C41Jvf3Dnw=;
        b=ZVM7mbt12dXHj3sQaZRBHrFMcZ54tP6Gc8f1h8B+BXbswt6MwV+1MXM2tGWYf+gJSU
         uy9tDdfU5RuGH54ypbHNhy6CoHQPAubVYVwjXvXVMCsZbGnR0XZKdT+TPXTG0MOYuibX
         MhZnlXTlWqRdo5Gpz8WfNjYvWFNPup6J5G3ASGdczVqemOJyEYKP3I1boiWlow/c4wiy
         DyHLKUe3wB5ecdxxM90x3sZn1UisNHc8lI//K1CD98wtpc1kAs1YXsRfi+MOEpfUQssx
         wlTvi7AFEkuofYJGPl+S4WQztvBmCcorwiP/LlkbfBcqEerfBJDVw3XLuT4X50ep/OeP
         ccYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698778084; x=1699382884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUCpVo4hvLbvW9owbr/nYYc5HPo8z6nB2C41Jvf3Dnw=;
        b=CsxzrVgQeUfqqRLP6LIQ+hIyyj3QOX61FgGrVnKte19Rwod5ECBbPAg2OGYxcGnLSz
         05o52d43MbngGaR1h0ns7JhBpRE0KiA90E/uI86TvBTeFV0IMnl3rhKq29BNtb3NBSGi
         oGaTCFAdQZ9DRjhFKddJPjFgF0eirDIDHbD+GhMJCMMcS2T2oCEXFZbAcZkpq7P7oHOq
         EGxJUCd7r3yKXDIsnyRY3Q5T+ovr28wq3Umghhk+CsjiO/s0Ja2xsviUz73MQmx1ehBm
         PNS8iPhJdLFTG7Y4if1MjQ+FVwxD1eREFln3a+y0zhPNtO+cqZsYgr901ALMXqDkjOBs
         V82g==
X-Gm-Message-State: AOJu0YyipntOZ3wWyLcBpRUSEYkYL5ElVsW1EGVNoO4zgXuK7R4H1jTd
	VW1FefRKAKC5S+tjLL9Gh+85xpRgXKc=
X-Google-Smtp-Source: AGHT+IG6PrhCj/ZqB7sCspJ+mbWm8PO4E3k7ZKYeo2i8d2zMe92KyV4nfhvAVwnzKgTjRuE0ma3GkQ==
X-Received: by 2002:a05:6214:2506:b0:658:26d7:72e0 with SMTP id gf6-20020a056214250600b0065826d772e0mr250064qvb.4.1698778084142;
        Tue, 31 Oct 2023 11:48:04 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id bj30-20020a05620a191e00b00774292e636dsm736351qkb.63.2023.10.31.11.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 11:48:03 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 5/9] station: provide new state in __station_connect_network
Date: Tue, 31 Oct 2023 11:47:46 -0700
Message-Id: <20231031184750.722404-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231031184750.722404-1-prestwoj@gmail.com>
References: <20231031184750.722404-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is being done to allow the DPP module to work correctl. DPP
currently uses __station_connect_network incorrectly since it
does not (and cannot) change the state after calling. The only
way to connect with a state change is via station_connect_network
which requires a DBus method that triggered the connection; DPP
does not have this due to its potentially long run time.

To support DPP there are a few options:
 1. Pass a state into __station_connect_network (this patch)
 2. Support a NULL DBus message in station_connect_network. This
    would require several NULL checks and adding all that to only
    support DPP just didn't feel right.
 3. A 3rd connect API in station which wraps
    __station_connect_network and changes the state. And again, an
    entirely new API for only DPP felt wrong (I guess we did this
    for network_autoconnect though...)

Its about 50/50 between call sites that changed state after calling
and those that do not. Changing the state inside
__station_connect_network felt useful enough to cover the cases that
could benefit and the remaining cases could handle it easily enough:
 - network_autoconnect(), and the state is changed by station after
   calling so it more or less follows the same pattern just routes
   through network. This will now pass the CONNECTING_AUTO state
   from within network vs station.
 - The disconnect/reconnect path. Here the state is changed to
   ROAMING prior in order to avoid multiple state changes. Knowing
   this the same ROAMING state can be passed which won't trigger a
   state change.
 - Retrying after a failed BSS. The state changes on the first call
   then remains the same for each connection attempt. To support this
   the current station->state is passed to avoid a state change.
---
 src/dpp.c     |  3 ++-
 src/network.c |  3 ++-
 src/station.c | 23 +++++++++++------------
 src/station.h |  2 +-
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index e5e1b3fa..b0a79361 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -833,7 +833,8 @@ static void dpp_handle_config_response_frame(const struct mmpdu_header *frame,
 	offchannel_cancel(dpp->wdev_id, dpp->offchannel_id);
 
 	if (network && bss)
-		__station_connect_network(station, network, bss);
+		__station_connect_network(station, network, bss,
+						STATION_STATE_CONNECTING);
 	else if (station) {
 		dpp->connect_scan_id = scan_active(dpp->wdev_id, NULL, 0,
 						dpp_scan_triggered,
diff --git a/src/network.c b/src/network.c
index 3099d102..f203834c 100644
--- a/src/network.c
+++ b/src/network.c
@@ -991,7 +991,8 @@ int network_autoconnect(struct network *network, struct scan_bss *bss)
 		return -ENOTSUP;
 	}
 
-	return __station_connect_network(station, network, bss);
+	return __station_connect_network(station, network, bss,
+						STATION_STATE_CONNECTING_AUTO);
 
 close_settings:
 	network_settings_close(network);
diff --git a/src/station.c b/src/station.c
index d4eb0cd8..3da02b06 100644
--- a/src/station.c
+++ b/src/station.c
@@ -280,9 +280,6 @@ static int station_autoconnect_next(struct station *station)
 
 		r = network_autoconnect(network, bss);
 		if (!r) {
-			station_enter_state(station,
-						STATION_STATE_CONNECTING_AUTO);
-
 			if (station->quick_scan_id) {
 				scan_cancel(netdev_get_wdev_id(station->netdev),
 						station->quick_scan_id);
@@ -3084,7 +3081,7 @@ static bool station_try_next_bss(struct station *station)
 		return false;
 
 	ret = __station_connect_network(station, station->connected_network,
-						next);
+						next, station->state);
 	if (ret < 0)
 		return false;
 
@@ -3421,7 +3418,7 @@ static void station_netdev_event(struct netdev *netdev, enum netdev_event event,
 }
 
 int __station_connect_network(struct station *station, struct network *network,
-				struct scan_bss *bss)
+				struct scan_bss *bss, enum station_state state)
 {
 	struct handshake_state *hs;
 	int r;
@@ -3448,6 +3445,9 @@ int __station_connect_network(struct station *station, struct network *network,
 	station->connected_bss = bss;
 	station->connected_network = network;
 
+	if (station->state != state)
+		station_enter_state(station, state);
+
 	return 0;
 }
 
@@ -3461,7 +3461,8 @@ static void station_disconnect_onconnect_cb(struct netdev *netdev, bool success,
 
 	err = __station_connect_network(station,
 					station->connect_pending_network,
-					station->connect_pending_bss);
+					station->connect_pending_bss,
+					STATION_STATE_CONNECTING);
 
 	station->connect_pending_network = NULL;
 	station->connect_pending_bss = NULL;
@@ -3472,8 +3473,6 @@ static void station_disconnect_onconnect_cb(struct netdev *netdev, bool success,
 						station->connect_pending));
 		return;
 	}
-
-	station_enter_state(station, STATION_STATE_CONNECTING);
 }
 
 static void station_disconnect_onconnect(struct station *station,
@@ -3531,12 +3530,11 @@ void station_connect_network(struct station *station, struct network *network,
 		return;
 	}
 
-	err = __station_connect_network(station, network, bss);
+	err = __station_connect_network(station, network, bss,
+					STATION_STATE_CONNECTING);
 	if (err < 0)
 		goto error;
 
-	station_enter_state(station, STATION_STATE_CONNECTING);
-
 	station->connect_pending = l_dbus_message_ref(message);
 
 	station_set_autoconnect(station, true);
@@ -3746,7 +3744,8 @@ static void station_disconnect_reconnect_cb(struct netdev *netdev, bool success,
 	struct station *station = user_data;
 
 	if (__station_connect_network(station, station->connected_network,
-					station->connected_bss) < 0)
+					station->connected_bss,
+					STATION_STATE_ROAMING) < 0)
 		station_disassociated(station);
 }
 
diff --git a/src/station.h b/src/station.h
index 24fab321..0d502a08 100644
--- a/src/station.h
+++ b/src/station.h
@@ -89,7 +89,7 @@ void station_remove_event_watch(uint32_t id);
 bool station_set_autoconnect(struct station *station, bool autoconnect);
 
 int __station_connect_network(struct station *station, struct network *network,
-				struct scan_bss *bss);
+				struct scan_bss *bss, enum station_state state);
 void station_connect_network(struct station *station, struct network *network,
 				struct scan_bss *bss,
 				struct l_dbus_message *message);
-- 
2.25.1

