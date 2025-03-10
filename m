Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FEE1E25F9
	for <iwd@lists.linux.dev>; Mon, 10 Mar 2025 21:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741642880; cv=none; b=f/NiJvJetaBDKGpYi+qtgRiMW1ep5bYIGS4oAodrJWLV9Uai5Hh7DWCVKjE1Msy2cbQYo7eTmpPL0L+dLEJwxoZPgzeLVfJ8un3hP769Ozi5WXFTyiefoM4G8iA6tHOrzzL2PGFS4LizMfpx3QCCFhdko9s3WEhoMFUWJh5K/Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741642880; c=relaxed/simple;
	bh=6Fp8R4Qw0nOtNEgD63cJHCtZcpKImAfVM8JPMBCUgTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NkkKgFDIoC6kfOPIOGllmZgVtUlQMmyCFDW0gOasoTv1tcigqdxbZZsB+2qYfRTpCbUiDtglKNGd2QSkvAVqEOX+etcPQkoQnZfWFf10gRwUnQtL32xWLk/WFjOzvca4JG/ryi4GgkxrOGbuLXZU5ZAAcB+O/ux/t5TapLzHsV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UI0UJXR1; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UI0UJXR1"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46c8474d8f6so38241011cf.3
        for <iwd@lists.linux.dev>; Mon, 10 Mar 2025 14:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741642877; x=1742247677; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2A1lLqRFKn/6XH8pCFXenZs6pITaQh0n3lF9tO6nvOU=;
        b=UI0UJXR1y/B84fflf693PcFr3QFucxDfFRC4g30pJPxD0awDt3HtJSNaIk9IbHJ4S8
         KSxGXbxVzF1BHZ4dG2x6X66BMkDpbEzsdUdzwkNfV0cCzttQ3cE5TrNuCjp+4U9k7emb
         iMTaH8PuZRD9W39uhkWlfocir6/adWyOR6sk+s/aojh5Sw83b9/GVhhhJIAX1vI4H+8y
         2pARp5DEZNk6PzN+brpRpghOnvyaWh2Syqey/F0SPLX08IpUFmMGF1z/DEc/AiAqyHNs
         pc9ce1dYmMQ+6m6JF9tkeUXoZWqAoM7KWXipp7foJl1Di5GQHyoSUKyWv9TBwCsgqd3p
         MSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741642877; x=1742247677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2A1lLqRFKn/6XH8pCFXenZs6pITaQh0n3lF9tO6nvOU=;
        b=psad4F26uwrtCzStAEfxe2pQtfErOyPqk+IugyYl4Bg0x+FaoKEdnBRazaF2HRgpSH
         vzVYE+Py4yreIGEbtXLjKNTKJKbxs32vdZNwmYL5NRmbHhuQNRYG29jhwutxX3nfWr8o
         HVTfHt/jjBW+ffTabWcM1S2Bt58R8nWTwV2kTQBPMHS01GYQu2Fw9kN0x8d5cVuZYPLg
         P878/uKFC0CJfJQM9tJSUSIsUt6bgpkjkHkp/RfPiTQTjdtUmbkyP16Ca7s6uEeFmwFs
         23/YiuGVfDKhw15O6tkmA756Pkt2m7KQUw10t2GRIOkZIogpSNJ/L0hfIgaymBAEo9JY
         E/9Q==
X-Gm-Message-State: AOJu0Ywn7UfsfGc5VnqYPVI8tZ8viP+dYQRwt47w0oHNeDv512E/hg5U
	z5w3VPXrl5RPtzLbx083z/uzOWpAtqscB76wQr54eu5zKKXx3/zIuRTfXw==
X-Gm-Gg: ASbGnctTu4KSUFTgkkkkhR3mBmae4P+tvyqnfdiWFtQLELR+ZhNgyUua5lO38uPCyJI
	NwdKqxBSyJC7yjyPAmNav1qVSkJMq6QVFuub/7JEfova8z7XyPuhLiwZpZfKDSYxd3qMLl59lVd
	6zINR5N+YSwTyPF4BVOpzQf9dnZVphIi2c81Kl9nDOgmW9dWVZcchcwdnCp2MZ8w/1bEqMBFGei
	wCOZR5GUX+fdkbq3kASFzAnWa/Ki2WBMuCbrmjUWD2BviqrEucvwagAgQWX0CXvyNfgBt7Nd0KZ
	kUMxoVhkynqwYNgsTCV7S3RAvvtieSHHldwCjJEMdQJWEPQrL1AlqLHTwf1QE7uLHikIz/7ox+n
	5C1k=
X-Google-Smtp-Source: AGHT+IFT/14+yvSwIjXHlEvFDsXexacsboGf7oIx6LPzvhqJ5wsHmOKWsjK5L9Kgv49OSM2G/PgJAQ==
X-Received: by 2002:ac8:7d16:0:b0:476:671e:deb6 with SMTP id d75a77b69052e-476994c5f5fmr15957041cf.12.1741642876770;
        Mon, 10 Mar 2025 14:41:16 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476772de5absm30487841cf.66.2025.03.10.14.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 14:41:16 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/8] network: update to use blacklist's new temporary type
Date: Mon, 10 Mar 2025 14:40:55 -0700
Message-Id: <20250310214059.20809-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310214059.20809-1-prestwoj@gmail.com>
References: <20250310214059.20809-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the temporary blacklist from network.c and use the new
BLACKLIST_REASON_TEMPORARY type.
---
 src/network.c | 34 +++++++++++++++++-----------------
 src/network.h |  2 --
 src/station.c |  8 ++++----
 3 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/src/network.c b/src/network.c
index 92b44ed3..b48eaa51 100644
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
+	blacklist_remove_bss(bss->addr, BLACKLIST_REASON_TEMPORARY);
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
+						BLACKLIST_REASON_TEMPORARY))
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
index fab37478..d16e82af 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3462,8 +3462,8 @@ static bool station_retry_with_status(struct station *station,
 	 *       obtain that IE, but this should be done in the future.
 	 */
 	if (IS_TEMPORARY_STATUS(status_code))
-		network_blacklist_add(station->connected_network,
-						station->connected_bss);
+		blacklist_add_bss(station->connected_bss->addr,
+					BLACKLIST_REASON_TEMPORARY);
 	else if (!station_pmksa_fallback(station, status_code))
 		blacklist_add_bss(station->connected_bss->addr,
 					BLACKLIST_REASON_PERMANENT);
@@ -3562,8 +3562,8 @@ static void station_connect_cb(struct netdev *netdev, enum netdev_result result,
 		iwd_notice(IWD_NOTICE_DISCONNECT_INFO, "reason: %u", reason);
 
 		/* Disconnected while connecting */
-		network_blacklist_add(station->connected_network,
-						station->connected_bss);
+		blacklist_add_bss(station->connected_bss->addr,
+					BLACKLIST_REASON_TEMPORARY);
 		if (station_try_next_bss(station))
 			return;
 
-- 
2.34.1

