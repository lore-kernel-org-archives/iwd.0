Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9B4185E7B
	for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477587; cv=none; b=jLxxgzyyx7bVYEiAhhNkTbOLt7moQ6bZ1MDB4R18fvlZ4cbG1ku/cqok+M7LabLEy2deLIfO4FtQyUE+tGrkfHhH80SsoG3TEkpFbTM8pTwomg2z2yuDMTnODYQx7GYCXQy8CsOL+SY+pLOae0ihx5vUVAMah4CkN4aFW7pzvOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477587; c=relaxed/simple;
	bh=cO5JG5viEy5MUT80LQPDQWDW4F9qGzjr0mOtoK2xVSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J31ALs5maBG3nN8zeyVmDnFgYOP9mm89IbsYt1y2lV2kQdY5+J/hS9XTM06bVT3UL4YH5XL6U3EUNGgzqBAOsXh1qzfdf8iHB/NQ5ynHhJo3CL4VHIGFjvFzRqsiYfYKGcoTke64qfwjhw/rTKAkp9cs5evJY2za0cjTs9v1xpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZphFak+h; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZphFak+h"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a1337cfbb5so5957104a12.3
        for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 08:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723477583; x=1724082383; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsgIYGinwHsZb7T3gEAavUfV/ewZDhdP5OQnNEu3J9g=;
        b=ZphFak+h3vfbtLlpklpowiq1RIkJZ+8epPjGu+9Mz3G93qWnPwKvu8jlybTW+lkctJ
         9+nncesc4CKDz6S+2P7pXqNSkWwtMbzv7f9IB7Dbi/9Ty4wRpcmmxwL+bueUF6/Y8hl4
         NhJ1xs5Pz6DUsfXohwhDJMWwawOsDimmP2LS5YNjQT0pmypp1rNkCx2tGatrHF3MoVSK
         YiTkjiIhF6yKEQ8EhiMSriYIQYtiRxXihdjSN0SFFBcz1p5WdYq70ImX7xm60memnz22
         lb6dcLlL8G7lpEg9cxjVJXTN38cQP1KKZA2l3W93E5pU8LnTumBf6Lyy9L6+ILOwGYQp
         8YTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723477583; x=1724082383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GsgIYGinwHsZb7T3gEAavUfV/ewZDhdP5OQnNEu3J9g=;
        b=TXdGCHaTMkpIG+EDATznv0ODPMXpSDyoBE6M7lBm6pk6PyBeOz2rVwMjwgC0oBOoHV
         3D19nFldHIyrqQXQ+VApUc1EPgkAiwzkrmpXICJnu+x4RoggWaNbaGOIw3jJMya6O8H1
         vQfxr2cy3x0t2tx99V9r0TjPmhRoaLePhaYZu/zYMZORXKFRNT85A6Io6IZH3xsP/58G
         YA8UkKp0u2kY15XQh5ioKfSmY9k3R1NkFiPZrhlOKyyXLy2+x43SlmaoO4I3hL1hf26p
         728mdXFW4E9rcir7+74aLswB8LMlyVtbupLt8u3JqYic+WWJmCVrAmjhzDwka030Hy1u
         BV2g==
X-Gm-Message-State: AOJu0YxPxEe+lncTzoI0zTcX+m4oSTg6FOWPVNPaO9FnNW1EkRSZWKFF
	TdA01OmEAQuMbIuXQVW3rOqr3CES8q5X0frEX42BXPFSpDe+4RhTdrN3Cg==
X-Google-Smtp-Source: AGHT+IFtjzcxZCUnuBUi04eG2E9oA1PuU9zdIuJ3i8aRimx4Ymdyw0dR1ZwUcHxj6nv0Pz+l99SqyA==
X-Received: by 2002:a05:6402:2109:b0:5a7:d986:6e4 with SMTP id 4fb4d7f45d1cf-5bd44c6d7efmr532022a12.28.1723477583009;
        Mon, 12 Aug 2024 08:46:23 -0700 (PDT)
Received: from LOCLAP699.vf-sint-niklaas.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd190adb45sm2224931a12.32.2024.08.12.08.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:46:22 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 03/13] station: use network_bss_{start,stop}_update
Date: Mon, 12 Aug 2024 08:46:03 -0700
Message-Id: <20240812154613.126522-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812154613.126522-1-prestwoj@gmail.com>
References: <20240812154613.126522-1-prestwoj@gmail.com>
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
 src/station.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

v3:
 * Update use of stop_update() to provide the scan_freq_set. This
   also required using a new struct to pass to process_network()

diff --git a/src/station.c b/src/station.c
index e373b03b..c45b849b 100644
--- a/src/station.c
+++ b/src/station.c
@@ -339,10 +339,18 @@ static void network_free(void *data)
 	network_remove(network, -ESHUTDOWN);
 }
 
+struct process_network_data {
+	struct station *station;
+	const struct scan_freq_set *freqs;
+};
+
 static bool process_network(const void *key, void *data, void *user_data)
 {
 	struct network *network = data;
-	struct station *station = user_data;
+	struct process_network_data *process_data = user_data;
+	struct station *station = process_data->station;
+
+	network_bss_stop_update(network, process_data->freqs);
 
 	if (!network_bss_list_isempty(network)) {
 		bool connected = network == station->connected_network;
@@ -532,6 +540,7 @@ struct bss_expiration_data {
 	struct scan_bss *connected_bss;
 	uint64_t now;
 	const struct scan_freq_set *freqs;
+	struct l_queue *free_list;
 };
 
 #define SCAN_RESULT_BSS_RETENTION_TIME (30 * 1000000)
@@ -553,18 +562,20 @@ static bool bss_free_if_expired(void *data, void *user_data)
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
@@ -939,18 +950,20 @@ void station_set_scan_results(struct station *station,
 {
 	const struct l_queue_entry *bss_entry;
 	struct network *network;
+	struct process_network_data data;
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
@@ -962,7 +975,12 @@ void station_set_scan_results(struct station *station,
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
@@ -994,7 +1012,12 @@ void station_set_scan_results(struct station *station,
 
 	station->bss_list = new_bss_list;
 
-	l_hashmap_foreach_remove(station->networks, process_network, station);
+	data.station = station;
+	data.freqs = freqs;
+
+	l_hashmap_foreach_remove(station->networks, process_network, &data);
+
+	l_queue_destroy(free_list, bss_free);
 
 	station->autoconnect_can_start = trigger_autoconnect;
 	station_autoconnect_start(station);
-- 
2.34.1

