Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF4725F96A
	for <iwd@lists.linux.dev>; Mon, 24 Mar 2025 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825764; cv=none; b=UfcRFctWaSOLeF2+3BHTB2LFn7k9kXzp3pjpOYyqf+tkp5vJT3vwv3e4keiPxmjmwz83sqXUVOSozqsx3eZ58cFFTfOuQPOOsJFhneUFEIaNPQVDJLXz72EV9nBS+9XTdesDeOfshaAIPjvYYkWLNlOXXN9vurHUN/YJY7QynCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825764; c=relaxed/simple;
	bh=51wEAWT7aJyNu2blmtP+1KXhrrIfssK7tES3rt9eyDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PVNII9gfcSN7LRTWAAYhkeQyR1GHbY5dSvDBQV3yMht1xNDbU7F4kny4hbiFxYayNTBLcWo3sB2c/Ob127EJtYGl3Pe+BXlN5v/H+JQ+vPrtnYxBu/sw/cVXXJy+B6AvGs+dDZTLvQr99TZVlZrz4RhgszzunZwqAhSjPoNlFbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAAVEjMv; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAAVEjMv"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2243803b776so7187255ad.0
        for <iwd@lists.linux.dev>; Mon, 24 Mar 2025 07:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742825761; x=1743430561; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l32T96Ov8t1M/e/ghgbw20eFnDZCLgN8TyPJ9gdzECY=;
        b=TAAVEjMvde6i61moD3WGNWG2AxE8chfKAsO18JZ8FeXuuMFFa/mvek8VrQm576sg07
         dHaRNRn8EAk1A6drBhK5eebkF82O/ivMGFeMm1uzhEzQhke2C9OmeJtJKq6llchQOVxZ
         sysU7jqouTOVVb/PuF4cj7ExHngHVSn80baUpyf9iqICD9ad355GqLvFDHxEpHr32lO7
         fIHNXIPUPE9wYnzo7NjsMpivMbYP6i+4z2rSMNu1KlHiIUCcwzDMUK5J+W3jwv7Inh1c
         RBJ78hGynILKylwHITRUijehju69dfZt+X+uwreDpwhlWqXQbrDdpMprvb602gegqSjV
         TXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742825761; x=1743430561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l32T96Ov8t1M/e/ghgbw20eFnDZCLgN8TyPJ9gdzECY=;
        b=dEeXyolP2SuU3ozSja2s6OB2Q1h8bUr3nHeYIqmQI7CM0IUI14AVfm6Qv/DzS/H9Km
         NIOcpjc/v96J9LUCDJOigY49Mwx9xgpELldUyVVBaZZdXHNDVqOKHgK7S9XhbDcXyloY
         7DVuFjSEthTmr+A7Xn5B8HYSu+yOTrxMRA+vSchDXjcCp+F6ESL+MQyi3owxxLd1mIFX
         vd1XsM2K1QQSSoP75lSBIJPto2tdo8npp7mZn41aEO57PI/Knu8AEVCZ6u4P4MyOLYNI
         dmv5syofMt+yTd/dzhPK2FAtwTF1mZpdGG/RsJUGNFp2pC+YIeg1YBau0TILAF6gnK/b
         s99w==
X-Gm-Message-State: AOJu0YyAPru3dvcTs+BWn1PW4PGb9Gic4BiswsOgUXrYzxVZb8dCbZkp
	EOdhjhJTEfyaeYdDpK60koGLHhA0uAFGkoISxCBwMCkd1J5Tbp0H08wzhA==
X-Gm-Gg: ASbGnct1oOQMEqfVX0N5hOfBJFb0PnKFEK4idehtG0HAWu5jZ+aP+Dxec9+oqxqDr+q
	3/P6LNXNqMYLFK1fwGo1tLHBs5os/MVkaUaRbfwI2nLhpx4y14Om+h9sE1y4ReHxXs7vk9W1hqU
	HXPogR/PrKBjduqls73vbv0Unxh8Vnc544ybtRZTeK3PodFinjOV944hU1riXfrOsmmmH6iULBc
	ZsBqRK7h0vYasdrDaaFsxWccep0SwgEoKzSgo5gK8NNJOyPjAtzwubQT/bvl/piFc7Eq0f0glKB
	fIqzL1ZTz0oWL9Z4q7ZnzLEETy/mnxk3xp0Dz3ZKzNGUGvV2gEsJ1Lg=
X-Google-Smtp-Source: AGHT+IECli5ZVyuXJceAwpAKw2SzOLKdb49pa0PyHrzD/Fhc/43n8c6K/kJ+G1SI+l9kVUlWi+crqA==
X-Received: by 2002:a05:6a00:4603:b0:736:bfc4:ef2c with SMTP id d2e1a72fcca58-739056530f5mr16584009b3a.0.1742825761107;
        Mon, 24 Mar 2025 07:16:01 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd54efsm8007868b3a.37.2025.03.24.07.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 07:16:00 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 06/13] network: update to use blacklist's new temporary type
Date: Mon, 24 Mar 2025 07:15:31 -0700
Message-Id: <20250324141538.144578-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324141538.144578-1-prestwoj@gmail.com>
References: <20250324141538.144578-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the temporary blacklist from network.c and use the new
BLACKLIST_REASON_TRANSIENT_ERROR reason.
---
 src/network.c | 34 +++++++++++++++++-----------------
 src/network.h |  2 --
 src/station.c | 12 ++++++------
 3 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/src/network.c b/src/network.c
index 4602a110..be6641c0 100644
--- a/src/network.c
+++ b/src/network.c
@@ -78,7 +78,6 @@ struct network {
 	struct l_queue *bss_list;
 	struct l_settings *settings;
 	struct l_queue *secrets;
-	struct l_queue *blacklist; /* temporary blacklist for BSS's */
 	uint8_t hessid[6];
 	char **nai_realms;
 	uint8_t *rc_ie;
@@ -168,6 +167,18 @@ static bool network_secret_check_cacheable(void *data, void *user_data)
 	return false;
 }
 
+static void remove_temporary_blacklist(void *user_data)
+{
+	struct scan_bss *bss = user_data;
+
+	blacklist_remove_bss(bss->addr, BLACKLIST_REASON_TRANSIENT_ERROR);
+}
+
+static void remove_blacklist_foreach(void *data, void *user_data)
+{
+	remove_temporary_blacklist(data);
+}
+
 void network_connected(struct network *network)
 {
 	enum security security = network_get_security(network);
@@ -198,7 +209,7 @@ void network_connected(struct network *network)
 	l_queue_foreach_remove(network->secrets,
 				network_secret_check_cacheable, network);
 
-	l_queue_clear(network->blacklist, NULL);
+	l_queue_foreach(network->bss_list, remove_blacklist_foreach, NULL);
 
 	network->provisioning_hidden = false;
 }
@@ -207,7 +218,7 @@ void network_disconnected(struct network *network)
 {
 	network_settings_close(network);
 
-	l_queue_clear(network->blacklist, NULL);
+	l_queue_foreach(network->bss_list, remove_blacklist_foreach, NULL);
 
 	if (network->provisioning_hidden)
 		station_hide_network(network->station, network);
@@ -254,7 +265,6 @@ struct network *network_create(struct station *station, const char *ssid,
 	}
 
 	network->bss_list = l_queue_new();
-	network->blacklist = l_queue_new();
 
 	return network;
 }
@@ -1197,11 +1207,6 @@ struct scan_bss *network_bss_find_by_addr(struct network *network,
 	return l_queue_find(network->bss_list, match_addr, addr);
 }
 
-static bool match_bss(const void *a, const void *b)
-{
-	return a == b;
-}
-
 struct erp_cache_entry *network_get_erp_cache(struct network *network)
 {
 	struct erp_cache_entry *cache;
@@ -1277,7 +1282,8 @@ struct scan_bss *network_bss_select(struct network *network,
 			candidate = bss;
 
 		/* check if temporarily blacklisted */
-		if (l_queue_find(network->blacklist, match_bss, bss))
+		if (blacklist_contains_bss(bss->addr,
+					BLACKLIST_REASON_TRANSIENT_ERROR))
 			continue;
 
 		if (blacklist_contains_bss(bss->addr,
@@ -1784,11 +1790,6 @@ struct l_dbus_message *network_connect_new_hidden_network(
 	return dbus_error_not_supported(message);
 }
 
-void network_blacklist_add(struct network *network, struct scan_bss *bss)
-{
-	l_queue_push_head(network->blacklist, bss);
-}
-
 static bool network_property_get_name(struct l_dbus *dbus,
 					struct l_dbus_message *message,
 					struct l_dbus_message_builder *builder,
@@ -1934,8 +1935,7 @@ void network_remove(struct network *network, int reason)
 	if (network->info)
 		network->info->seen_count -= 1;
 
-	l_queue_destroy(network->bss_list, NULL);
-	l_queue_destroy(network->blacklist, NULL);
+	l_queue_destroy(network->bss_list, remove_temporary_blacklist);
 
 	if (network->nai_realms)
 		l_strv_free(network->nai_realms);
diff --git a/src/network.h b/src/network.h
index 849051dd..1e01de88 100644
--- a/src/network.h
+++ b/src/network.h
@@ -95,8 +95,6 @@ struct l_dbus_message *network_connect_new_hidden_network(
 						struct network *network,
 						struct l_dbus_message *message);
 
-void network_blacklist_add(struct network *network, struct scan_bss *bss);
-
 struct erp_cache_entry *network_get_erp_cache(struct network *network);
 
 const struct l_queue_entry *network_bss_list_get_entries(
diff --git a/src/station.c b/src/station.c
index e2ed78f3..c4ba9413 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3408,8 +3408,8 @@ static bool station_retry_with_reason(struct station *station,
 	 * Network blacklist the BSS as well, since the timeout blacklist could
 	 * be disabled
 	 */
-	network_blacklist_add(station->connected_network,
-				station->connected_bss);
+	blacklist_add_bss(station->connected_bss->addr,
+				BLACKLIST_REASON_TRANSIENT_ERROR);
 
 try_next:
 	return station_try_next_bss(station);
@@ -3481,8 +3481,8 @@ static bool station_retry_with_status(struct station *station,
 	 * will allow network_bss_select to traverse the BSS list and ignore
 	 * BSS's which have previously failed
 	 */
-	network_blacklist_add(station->connected_network,
-				station->connected_bss);
+	blacklist_add_bss(station->connected_bss->addr,
+				BLACKLIST_REASON_TRANSIENT_ERROR);
 
 try_next:
 	iwd_notice(IWD_NOTICE_CONNECT_FAILED, "status: %u", status_code);
@@ -3579,8 +3579,8 @@ static void station_connect_cb(struct netdev *netdev, enum netdev_result result,
 		iwd_notice(IWD_NOTICE_DISCONNECT_INFO, "reason: %u", reason);
 
 		/* Disconnected while connecting */
-		network_blacklist_add(station->connected_network,
-						station->connected_bss);
+		blacklist_add_bss(station->connected_bss->addr,
+					BLACKLIST_REASON_TRANSIENT_ERROR);
 		if (station_try_next_bss(station))
 			return;
 
-- 
2.34.1

