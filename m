Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEEB190072
	for <iwd@lists.linux.dev>; Thu,  8 Aug 2024 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723138962; cv=none; b=CPWjZSjEkhqwKTnIrn1Ni96zISPNDFntLffdDgQ8+WVWWfuBVhNa5Zr03yQLd3i9iwbE/fjaLRRaml61O2LzTisqOUEwQicJLT5zcLwIeRVUJhSe/0x/BVXCtii031ujupSaHlVHZr0aGOxMnwY1VVAZPBXF2o8CTR3vYdmDCiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723138962; c=relaxed/simple;
	bh=py7vwZab5zeIRybpiYD2KXK0nrES6lgvE7s3LcLAJxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mjx9qp0WTRzv0mWEXVMvZQZLPRyPk3TyixojDo0bvbNNVN94jkNnIp2tCWsle4d/x476JG5L/axGXAEAfZoNOdBUYQ96d4JsqGldgCRN5JfoxYp28WYZUKK548jEZ8macJOH7SA8S8gVuGdF7RCDQIhcaLo934Pmj+ogeoUUmwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AELiI9sW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AELiI9sW"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fd9e70b592so10727535ad.3
        for <iwd@lists.linux.dev>; Thu, 08 Aug 2024 10:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723138960; x=1723743760; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZPCgnGXF4BrQ9vo5hXu2653vC5Ulqpydb1rMi3BJUo=;
        b=AELiI9sW20mUX8arRAa/Ue2MlNENLTsVyuG3/uxbk0CMUC6jvSIBsjTV8GVagwoR5m
         RNeZV29c+HI8eEL0IgB6tGPGuMHDxtn/6VhmAyOFhY5owefgFenIkR6BJKENIbdaREkZ
         qCc1E27OTipzAs+5pIwLu1xHsGRFUnKFPNZqGcORhjiDKinEufk3h9gYlYAw1CI4w+Ed
         upVTflamegVrNzP72t+dDLD4ywa6PyQMG1QZpWQfjQx3vd+SSTjuEtohJ99211+3KcVK
         aHtAYYkGrSk637FyRF9Yq4ZR7pVbwNP7rp3J2rRIbVlQVOimIiDNFfil5FgHa7KO/1fq
         w4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723138960; x=1723743760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZPCgnGXF4BrQ9vo5hXu2653vC5Ulqpydb1rMi3BJUo=;
        b=Ex663u/qu5KJS4UiWtZ3dqH57V8ura7eZMQ8AgBZFlRe5pCRSC8RGrkFpqLms9TBc5
         TkkJAX5Tch9ZtKYDWBUUQOJjmbhGeQ/3884bkySFtZhIe8BVGV5851I1pUwYLS3cH78b
         fV3ooWfXDo18dbgQTfZM2768KDswbc8YB0V0S5eDZqUFIsWUqmz/ju7nOZz2kKpclVS6
         MRSnJtJBUN8UzlRRY3LlBKYe6N2BpzQc7fiCefYu0nrgcM2hRGRp4WXdZNJdi6zwLuJl
         Qwr7PBkB3K6hnHOfNm1de/1rwZAnJk/XVCsw46ilpzTVj3yjaH29IdGlb3Zdb8+AtmeX
         B5dg==
X-Gm-Message-State: AOJu0YxZf9O59uoMqewGovpgKAcXJC2Wr6p6kZdwfIcpGnRN8maubrHI
	g0Xu1tLDKUlXV2RbaoktQQbgrZu6IsNC+NaOZhW+VtugIyuQdDxPVWt09A==
X-Google-Smtp-Source: AGHT+IHjUhUxRk4zLzwTIyJve9RC+YflhmQSehdgx/kXX6bHMyoutoIjAFCuEFQCa0aQ1u/PDSNcag==
X-Received: by 2002:a17:903:41d2:b0:1fd:63d7:5d21 with SMTP id d9443c01a7336-20095395179mr29108455ad.47.1723138960469;
        Thu, 08 Aug 2024 10:42:40 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f53435sm127478355ad.64.2024.08.08.10.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 10:42:40 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 03/13] station: use network_bss_{start,stop}_update
Date: Thu,  8 Aug 2024 10:42:26 -0700
Message-Id: <20240808174236.218750-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808174236.218750-1-prestwoj@gmail.com>
References: <20240808174236.218750-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will tell network the BSS list is being updated and it can
act accordingly as far as the BSS DBus registrations/unregistration.

In addition any scan_bss object needing to be freed has to wait
until after network_bss_stop_update() because network has to be able
to iterate its old list and unregister any BSS's that were not seen
in the scan results. This is done by pushing each BSS needing to be
freed into a queue, then destroying them after the BSS's are all
added.
---
 src/station.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

v2:
 * Updated to use network_bss_{start,stop} update
 * Added the free list to fix invalid reads due to freeing the
   scan_bss early

diff --git a/src/station.c b/src/station.c
index e373b03b..8a76339c 100644
--- a/src/station.c
+++ b/src/station.c
@@ -344,6 +344,8 @@ static bool process_network(const void *key, void *data, void *user_data)
 	struct network *network = data;
 	struct station *station = user_data;
 
+	network_bss_stop_update(network);
+
 	if (!network_bss_list_isempty(network)) {
 		bool connected = network == station->connected_network;
 
@@ -532,6 +534,7 @@ struct bss_expiration_data {
 	struct scan_bss *connected_bss;
 	uint64_t now;
 	const struct scan_freq_set *freqs;
+	struct l_queue *free_list;
 };
 
 #define SCAN_RESULT_BSS_RETENTION_TIME (30 * 1000000)
@@ -553,18 +556,20 @@ static bool bss_free_if_expired(void *data, void *user_data)
 			bss->time_stamp + SCAN_RESULT_BSS_RETENTION_TIME))
 		return false;
 
-	bss_free(bss);
+	l_queue_push_head(expiration_data->free_list, bss);
 
 	return true;
 }
 
 static void station_bss_list_remove_expired_bsses(struct station *station,
-					const struct scan_freq_set *freqs)
+					const struct scan_freq_set *freqs,
+					struct l_queue *free_list)
 {
 	struct bss_expiration_data data = {
 		.now = l_time_now(),
 		.connected_bss = station->connected_bss,
 		.freqs = freqs,
+		.free_list = free_list,
 	};
 
 	l_queue_foreach_remove(station->bss_list, bss_free_if_expired, &data);
@@ -939,18 +944,19 @@ void station_set_scan_results(struct station *station,
 {
 	const struct l_queue_entry *bss_entry;
 	struct network *network;
+	struct l_queue *free_list = l_queue_new();
 
 	l_queue_foreach_remove(new_bss_list, bss_free_if_ssid_not_utf8, NULL);
 
 	while ((network = l_queue_pop_head(station->networks_sorted)))
-		network_bss_list_clear(network);
+		network_bss_start_update(network);
 
 	l_queue_clear(station->hidden_bss_list_sorted, NULL);
 
 	l_queue_destroy(station->autoconnect_list, NULL);
 	station->autoconnect_list = NULL;
 
-	station_bss_list_remove_expired_bsses(station, freqs);
+	station_bss_list_remove_expired_bsses(station, freqs, free_list);
 
 	for (bss_entry = l_queue_get_entries(station->bss_list); bss_entry;
 						bss_entry = bss_entry->next) {
@@ -962,7 +968,12 @@ void station_set_scan_results(struct station *station,
 			if (old_bss == station->connected_bss)
 				station->connected_bss = new_bss;
 
-			bss_free(old_bss);
+			/*
+			 * The network object is still holding a reference to
+			 * the BSS. Until we tell network to replace the BSS
+			 * with a new object, don't free it.
+			 */
+			l_queue_push_head(free_list, old_bss);
 
 			continue;
 		}
@@ -996,6 +1007,8 @@ void station_set_scan_results(struct station *station,
 
 	l_hashmap_foreach_remove(station->networks, process_network, station);
 
+	l_queue_destroy(free_list, bss_free);
+
 	station->autoconnect_can_start = trigger_autoconnect;
 	station_autoconnect_start(station);
 }
-- 
2.34.1

