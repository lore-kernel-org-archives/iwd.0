Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A4B13A3F4
	for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083066; cv=none; b=KKBzHUsyUWjxup65zYNnL+XME5RZSrTuEd3rDXATlmyBX4Dspe30Haq8Cgh41na2hX6uqXog8WnI0ckHNxLIAVFs6LtE5iNULtIeFODChtRop+0yNhi1xugLUiT6f/9e2QjFaTiQhSlS00Gcri109dWF23B9pKtjt386XpEtZIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083066; c=relaxed/simple;
	bh=2HqIBExNRmwUHO+XHHwxK4p1f6S0ypn3Q0S/iPGc28k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r76HAfAS5XwoeCKjQXuFOV0BG782+dYeYyoSrH9DoGODLEvgRmHhjvRkmThAvGFoHQYEyAXfCQE/mRb5Y+O3Rk2f53CWQ1KajIk3giFyZM8IL2grttF90IcSZmwExRJo9ID8ZXQRwTp5rPqkdzHUvDXSVBZa+MacV5KanvZkArA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M82SMlzQ; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M82SMlzQ"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso3337680a12.2
        for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 08:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724083064; x=1724687864; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkdPtJF6Yfs9+V2+uZ5QEN9qO8E9CKv0LgQx8qXBJyU=;
        b=M82SMlzQ0/H2TbJtUJeVlrZW8z5/HcpzishEX+mrAQVt+ny53j1kYekADw7pZht7lQ
         u0cI8AzCxr8v668c4yR9/U5hmuYo5a5lmWLel8JvDYgUODOLEU14owyuj/kJrHF/7tKk
         jRMk2oyMtMv/gGLtsr2mPDydrRT9XFc6KFSzTQ/mwCVyWsqFS/WJnEXHJeWbbkawgoXd
         EdNKZvbGjwwN5WFD5Yi4oWVWfWvIvUCxPZbYBVE3X402LpSIVt4KQEn68Y9Zg8KiResW
         DEcxgiqG2vcp6GUbUBLucbXPCr5LckfoJ/k8XglVRfNbv3I10kn5eCDRc6/d6nDkNFsv
         t+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724083064; x=1724687864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkdPtJF6Yfs9+V2+uZ5QEN9qO8E9CKv0LgQx8qXBJyU=;
        b=fY5Ai8aKcYpWzpkicJ/cNPgXa2N7Z18s0U+58Qr0du/WVkw6RgPtYr+bhpFXPqADZn
         qBDgomAKBHr6SKZ0Y2NWNZ/nIvEp2ow7y3fo+Q+0SxtfaMms3T83cyio0/Yn4h3Ku34v
         Lh2/wexAYGlcbuyuU1pHgPq9p/SCpM7Z0HPO0Snxy3xhg3/4w4GoUfGLox98aoVfsxGf
         QJCOhjROzuibcHg8kLfQKg6SaQFbyahcp+jW0J9EoxmIvSLuiQw/zJBfnjzcp/XJbst2
         /qbGbuSQmL/O9xn3J3YxB48+0va/XtRabG0KPZaUcnudNYXZh6fV57MluilEMG/f8rUF
         JFbQ==
X-Gm-Message-State: AOJu0YzFrCI0xV11kgG7RTnCCUZTWe8DORFCfN407BmDHz15axLrx1vz
	NPshbBqSrwQfW6zrXBrd2r5zd+tGQ9Ppbu8yO0OMfsUHgkgaVzYFSMs0cQ==
X-Google-Smtp-Source: AGHT+IFkVeS9t71cA08lZ8xMg/m9pRP9Lp5Gdjb393i5rUmWXbTOrgzOaVZfNDRCf7BYYioFgoG4gA==
X-Received: by 2002:a05:6a20:6f05:b0:1c4:ba7c:741c with SMTP id adf61e73a8af0-1c904f91357mr14768318637.21.1724083064243;
        Mon, 19 Aug 2024 08:57:44 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae0cb5asm6752277b3a.69.2024.08.19.08.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 08:57:43 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/6] network: remove BasicServiceSet DBus registration code
Date: Mon, 19 Aug 2024 08:57:31 -0700
Message-Id: <20240819155734.1276476-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819155734.1276476-1-prestwoj@gmail.com>
References: <20240819155734.1276476-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was moved into station.
---
 src/network.c | 100 ++------------------------------------------------
 src/network.h |   2 -
 2 files changed, 4 insertions(+), 98 deletions(-)

diff --git a/src/network.c b/src/network.c
index a8e61d48..b9194b3c 100644
--- a/src/network.c
+++ b/src/network.c
@@ -75,7 +75,6 @@ struct network {
 	struct l_ecc_point *sae_pt_20; /* SAE PT for Group 20 */
 	unsigned int agent_request;
 	struct l_queue *bss_list;
-	struct l_queue *old_bss_list;
 	struct l_settings *settings;
 	struct l_queue *secrets;
 	struct l_queue *blacklist; /* temporary blacklist for BSS's */
@@ -1147,101 +1146,20 @@ const char *network_bss_get_path(const struct network *network,
 	return __network_path_append_bss(network->object_path, bss);
 }
 
-static bool network_unregister_bss(void *a, void *user_data)
-{
-	struct scan_bss *bss = a;
-	struct network *network = user_data;
-
-	l_dbus_unregister_object(dbus_get_bus(),
-					network_bss_get_path(network, bss));
-
-	l_dbus_property_changed(dbus_get_bus(), network->object_path,
-				IWD_NETWORK_INTERFACE, "ExtendedServiceSet");
-
-	return true;
-}
-
-static bool network_register_bss(struct network *network, struct scan_bss *bss)
-{
-	const char *path = network_bss_get_path(network, bss);
-	struct scan_bss *old;
-
-	/*
-	 * If we find this path in the object tree update the data to the new
-	 * scan_bss pointer, as this one will be freed soon.
-	 */
-	old = l_dbus_object_get_data(dbus_get_bus(), path, IWD_BSS_INTERFACE);
-	if (old)
-		return l_dbus_object_set_data(dbus_get_bus(), path,
-						IWD_BSS_INTERFACE, bss);
-
-	if (!l_dbus_object_add_interface(dbus_get_bus(), path,
-						IWD_BSS_INTERFACE, bss))
-		return false;
-
-	if (!l_dbus_object_add_interface(dbus_get_bus(), path,
-					L_DBUS_INTERFACE_PROPERTIES, bss))
-		return false;
-
-	l_dbus_property_changed(dbus_get_bus(), network->object_path,
-				IWD_NETWORK_INTERFACE, "ExtendedServiceSet");
-
-	return true;
-}
-
 void network_bss_start_update(struct network *network)
 {
-	network->old_bss_list = network->bss_list;
+	l_queue_destroy(network->bss_list, NULL);
 	network->bss_list = l_queue_new();
 }
 
-void network_bss_stop_update(struct network *network,
-				const struct scan_freq_set *limit_freqs)
-{
-	const struct l_queue_entry *e;
-
-	/*
-	 * Update has finished, clean up any BSS's from the old list that have
-	 * been registered on DBus.
-	 */
-	for (e = l_queue_get_entries(network->old_bss_list); e; e = e->next) {
-		const struct scan_bss *old = e->data;
-		const struct scan_bss *bss;
-		const char *path = network_bss_get_path(network, old);
-
-		bss = l_dbus_object_get_data(dbus_get_bus(), path,
-						IWD_BSS_INTERFACE);
-
-		/*
-		 * Don't remove BSS's who's frequencies were not in the set.
-		 * This happens due to scan subsets (i.e. from station) so some
-		 * BSS's won't be seen since the frequency is not being scanned.
-		 * These BSS's will get cleared out eventually if they have
-		 * actually disappeared.
-		 */
-		if (!scan_freq_set_contains(limit_freqs, bss->frequency))
-			continue;
-
-		/*
-		 * The lookup matched the user data of an old BSS. This should
-		 * be unregistered from DBus
-		 */
-		if (bss && bss == old)
-			l_dbus_object_remove_interface(dbus_get_bus(), path,
-							IWD_BSS_INTERFACE);
-	}
-
-	l_queue_destroy(network->old_bss_list, NULL);
-	network->old_bss_list = NULL;
-}
-
 bool network_bss_add(struct network *network, struct scan_bss *bss)
 {
 	if (!l_queue_insert(network->bss_list, bss, scan_bss_rank_compare,
 									NULL))
 		return false;
 
-	network_register_bss(network, bss);
+	l_dbus_property_changed(dbus_get_bus(), network->object_path,
+				IWD_NETWORK_INTERFACE, "ExtendedServiceSet");
 
 	/* Done if BSS is not HS20 or we already have network_info set */
 	if (!bss->hs20_capable)
@@ -1276,8 +1194,6 @@ bool network_bss_update(struct network *network, struct scan_bss *bss)
 
 	l_queue_insert(network->bss_list, bss, scan_bss_rank_compare, NULL);
 
-	network_register_bss(network, bss);
-
 	/* Sync frequency for already known networks */
 	if (network->info) {
 		known_network_add_frequency(network->info, bss->frequency);
@@ -1294,12 +1210,7 @@ bool network_bss_list_isempty(struct network *network)
 
 struct scan_bss *network_bss_list_pop(struct network *network)
 {
-	struct scan_bss *bss = l_queue_pop_head(network->bss_list);
-
-	if (bss)
-		network_unregister_bss(bss, network);
-
-	return bss;
+	return l_queue_pop_head(network->bss_list);
 }
 
 struct scan_bss *network_bss_find_by_addr(struct network *network,
@@ -2030,9 +1941,6 @@ static void network_unregister(struct network *network, int reason)
 
 void network_remove(struct network *network, int reason)
 {
-	l_queue_foreach_remove(network->bss_list,
-				network_unregister_bss, network);
-
 	if (network->object_path)
 		network_unregister(network, reason);
 
diff --git a/src/network.h b/src/network.h
index c9f73200..73d2ddb0 100644
--- a/src/network.h
+++ b/src/network.h
@@ -69,8 +69,6 @@ int network_can_connect_bss(struct network *network,
 int network_autoconnect(struct network *network, struct scan_bss *bss);
 void network_connect_failed(struct network *network, bool in_handshake);
 void network_bss_start_update(struct network *network);
-void network_bss_stop_update(struct network *network,
-				const struct scan_freq_set *freqs);
 bool network_bss_add(struct network *network, struct scan_bss *bss);
 bool network_bss_update(struct network *network, struct scan_bss *bss);
 const char *network_bss_get_path(const struct network *network,
-- 
2.34.1

