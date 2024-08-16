Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7C2156F34
	for <iwd@lists.linux.dev>; Fri, 16 Aug 2024 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723812743; cv=none; b=DwecPlaETdITh3I4K1zaFHivzaDVGcn5fe/j+wg/bPCIzBzAfkjB7bXCZxwnAZA4dFSK6SR8fqNHIVOK0i81V+4zFHiJUdbnVGwbgZUCt1IMbmIKT5MwdRIjKPsBtXdhk1UA2mcY62i/0UFOesOzS7DnAcAdrSt6hsdD+IPQLDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723812743; c=relaxed/simple;
	bh=2HqIBExNRmwUHO+XHHwxK4p1f6S0ypn3Q0S/iPGc28k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VbjXyCyJCALdPr+lsBDznUxA4gocau2S/ms8r9n2lDRixu5dxngn7gpCfrOT/Lxt0xiREOj5qigVtixgUvCBMtMOwiHmOWfQ8JAtpvkrUS08/eho8lSkwtRX/mTXgirKavolZwUXARcxQJ70sk98bMJ9vp+x1uWDfquU0w6hK/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGzT9vQw; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGzT9vQw"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-45006bcb482so10418031cf.3
        for <iwd@lists.linux.dev>; Fri, 16 Aug 2024 05:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723812740; x=1724417540; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkdPtJF6Yfs9+V2+uZ5QEN9qO8E9CKv0LgQx8qXBJyU=;
        b=OGzT9vQwWvgv8OySPUPc+FWT3vgwPX7FdDEQAQxMfJZt0Resc5H0DebkGM+pu92v0T
         kfJKzc6NluVNeL4EBSik1ECAkvENXYSQsRUKYmROOU0tn8g3Mqel7lPO/qlWnY/XJ5uC
         uhc86uovyKEnlIzh1hTBXBsgGR1fkxg/DUxkbWaW6XfhwXZfkNlQILVZG7xvaZTe0VlC
         D6K84dVDMi1JdV0ZjrVIKIDzstZlMck3EV0KST91qjr2WDxpWnm9U246im6I051wUXqZ
         zS/5vaa8qRV0fAjSFcZXcOT31n5VdQJKyUUEFQvg+yJX/eqTGStlkjB8yI8BVgX8T2bR
         KgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723812740; x=1724417540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkdPtJF6Yfs9+V2+uZ5QEN9qO8E9CKv0LgQx8qXBJyU=;
        b=WtrRPL8kFi2V45qsUWX7dzDVqrfGpAiyGCVmZhb/QX6psktj0jOrz2ntV+siv+qTyJ
         Ky9lSaVC3Z6MaY40bjSyOOBxD6+T9x3ulGvwGrs8KhR5WNa8FPdCjdOjPGTnC07MAf+5
         af/2wuqc3WwMk+qrm8fquiDtKxEJEN/zj+VSd/kajHOelS4PzcXf1oiyPKLGAMmbscjg
         xU+JXvvqaR9h46xEKQe1JrxXd2toHwrweQMCrDpTZE0voM3eVfVsucXGXa3HLh1Ni5/i
         hHB/Py0POPC5xeeqGRmn69T+smGLDcfrpwX06nvp4dY/dcUoJOYV8bcz78ZkzBBQFmWm
         GcAg==
X-Gm-Message-State: AOJu0YzoRslYnZG6Rw2YCeoDwdW6JjGd1uhGUXYnsg4nTGKdO2sMDFhP
	a3S5B+Gg3oUTssAWeued+ogzNdxKBSHXqdm6tx0TAejj6ANd2MHMDvCAMw==
X-Google-Smtp-Source: AGHT+IG6np22Dn4nCUK7UFqZ27vMsGYh3PefeKezo2LTrgu0/EMIkgpMigt2+sb8ZQ+3odEZ6f4/pA==
X-Received: by 2002:a05:622a:5e83:b0:451:d557:22ed with SMTP id d75a77b69052e-453741bf460mr24814531cf.11.1723812740227;
        Fri, 16 Aug 2024 05:52:20 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369ff54ffsm15921931cf.36.2024.08.16.05.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 05:52:19 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/6] network: remove BasicServiceSet DBus registration code
Date: Fri, 16 Aug 2024 05:52:11 -0700
Message-Id: <20240816125214.1162415-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816125214.1162415-1-prestwoj@gmail.com>
References: <20240816125214.1162415-1-prestwoj@gmail.com>
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

