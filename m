Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8F22230C
	for <iwd@lists.linux.dev>; Fri, 26 Jan 2024 20:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706300570; cv=none; b=V8T4NqNRJLKkN9J5fmyiYsJ6f1b/X8LKk9OdwKbDwJHTtOEuMOGXOtqICj9c+2HJ1YDtwkFIjA65NJDTD0Ciyam3lhD1NecSQS8vhfyX8RdhJjbxiSUvgYKecU14yP4CwJmWKvKEf70Bz2HHe4IVDn6RyBC9QzD/7VLDYU3q0Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706300570; c=relaxed/simple;
	bh=AD1z9g6vaGTmslQEoP3TO6zF+quFZu1Lrkz2VMibbGE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mGCdUkM/Et0ju8x1lnfVLEvPtC2m1gOXLmrfjpc5IQu9zygF3ViOv8jWDOISf0ShwDmrGrHPlWJDr/rfxLMYXQY9WXPyIwRyn+UXln4PQKVfuIc33O5lJ3BNNANvH5HBjGrrEuIPwKmZPnEM8mT7bULssQfUrvcK7eCoRPKHNxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krAdW7X9; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krAdW7X9"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42a75ec56dcso7789051cf.0
        for <iwd@lists.linux.dev>; Fri, 26 Jan 2024 12:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706300567; x=1706905367; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YPBb4mCw/R1ghl4eJw9QnLwDTvV7rYUlLLOC/s2r03U=;
        b=krAdW7X9mrhGijJYXk4xRW3RiMWNXpr//RcLo4VTjzoNvu/viezZe6I2NxWYj7mNpb
         PkSPGvIM6sqhhdS1K+YEc36lnMOn2ujaf/FJAWrmPhrXKjAQwveApcUMcR0hYPpnbZDf
         cFZK2PZE+BoAlXlU4IbBC/s/mbqG3mwa/owtgu0Z0WnF1v7pRfZ4wdP7UEvsXug4R45k
         WUmoPBflX8HJq9a2RzewsNnNnOnHqO9QkUyzTTYQQonq8Xi/5T6Y709SqRYTQca03yPw
         L1ZgzPkSLPyHurgx3rd7+ywevMmEyy0OKhI6rQNSygV01Nkvk+xCWvkf/o19cTmKfW2h
         4iWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706300567; x=1706905367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YPBb4mCw/R1ghl4eJw9QnLwDTvV7rYUlLLOC/s2r03U=;
        b=lhvGxrlehEnte8EVwovL+7BDhy8h6/98fYGrHO91WSd5t3Cboj0EAmCvkTk/yi4LA4
         zDGzuslvcjVQU0mKhCIMnTKLnUqXSRQiOe8mKwK+hUGmwHwDrSMci54UDukjPnixxOOD
         wfmNUiu6GiwNl0k12lKirZW1ZTXeq+jdQgs7g+pfoO9EHFGZU58CgMdyiKwF5U10Jzq7
         +275xpnue2p3CzY63aByWyP3lJouVhltsnTaGXIzuEhYfmb7f38Z/MVFzA/Z1ks4K7+r
         Pu3UKRLa0+sfDX5LFCJeXw/7XDkQhrdf9Bb+HkOuNPe6yA47yVIsnbVB/73iSHlNygBy
         qFUw==
X-Gm-Message-State: AOJu0YxK0HuKkcOQ36RlZKk32OnJ3qa0fElfYMTuHveFt0mciDaJk6B7
	ghj5lfWAsjpw0z8Ee0U/bNvxNbXjRWEOTjNxDghTr6YP9N48qdRjjpU8YIxcsRo=
X-Google-Smtp-Source: AGHT+IFFOekxIQo5NLmKjcp6Qfd6UJ1cj0hkSu5Oi0GY555t6McTKV3GGs5vDgO5Juj+si8z0ZxPLQ==
X-Received: by 2002:a05:622a:196:b0:42a:39ac:84e2 with SMTP id s22-20020a05622a019600b0042a39ac84e2mr454738qtw.10.1706300567611;
        Fri, 26 Jan 2024 12:22:47 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id fe3-20020a05622a4d4300b0042a25f3950esm826463qtb.75.2024.01.26.12.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 12:22:47 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/4] network: add network_update_known_frequencies
Date: Fri, 26 Jan 2024 12:22:40 -0800
Message-Id: <20240126202243.91947-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to support an ordered list of known frequencies the list
should be in order of last seen BSS frequencies with the highest
ranked ones first. To accomplish this without adding a lot of
complexity the frequencies can be pushed into the list as long as
they are pushed in reverse rank order (lowest rank first, highest
last). This ensures that very high ranked BSS's will always get
superseded by subsequent scans if not seen.

This adds a new network API to update the known frequency list
based on the current newtork->bss_list. This assumes that station
always wipes the BSS list on scans and populates with only fresh
BSS entries. After the scan this API can be called and it will
reverse the list, then add each frequency.
---
 src/network.c | 40 ++++++++++++++++++++++++++++------------
 src/network.h |  2 ++
 2 files changed, 30 insertions(+), 12 deletions(-)

v4:
 * Added an API to do the insertion once all the BSS's have been added
   to the network object.
 * I'm also ok adding something to ELL like:
   l_queue_new_reverse(list);

   The current reverse is in-place, so I cant really use it unless I
   wanted to reverse twice to get it back to decending order.

diff --git a/src/network.c b/src/network.c
index 4723334e..287e2be0 100644
--- a/src/network.c
+++ b/src/network.c
@@ -802,21 +802,13 @@ const struct network_info *network_get_info(const struct network *network)
 	return network->info;
 }
 
-static void add_known_frequency(void *data, void *user_data)
-{
-	struct scan_bss *bss = data;
-	struct network_info *info = user_data;
-
-	known_network_add_frequency(info, bss->frequency);
-}
-
 void network_set_info(struct network *network, struct network_info *info)
 {
 	if (info) {
 		network->info = info;
 		network->info->seen_count++;
 
-		l_queue_foreach(network->bss_list, add_known_frequency, info);
+		network_update_known_frequencies(network);
 	} else {
 		network->info->seen_count--;
 		network->info = NULL;
@@ -1087,15 +1079,39 @@ static bool match_hotspot_network(const struct network_info *info,
 	return true;
 }
 
+bool network_update_known_frequencies(struct network *network)
+{
+	const struct l_queue_entry *e;
+	struct l_queue *reversed;
+
+	if (!network->info)
+		return false;
+
+	reversed = l_queue_new();
+
+	for (e = l_queue_get_entries(network->bss_list); e; e = e->next) {
+		struct scan_bss *bss = e->data;
+
+		l_queue_push_head(reversed, bss);
+	}
+
+	for (e = l_queue_get_entries(reversed); e; e = e->next) {
+		struct scan_bss *bss = e->data;
+
+		known_network_add_frequency(network->info, bss->frequency);
+	}
+
+	l_queue_destroy(reversed, NULL);
+
+	return true;
+}
+
 bool network_bss_add(struct network *network, struct scan_bss *bss)
 {
 	if (!l_queue_insert(network->bss_list, bss, scan_bss_rank_compare,
 									NULL))
 		return false;
 
-	if (network->info)
-		known_network_add_frequency(network->info, bss->frequency);
-
 	/* Done if BSS is not HS20 or we already have network_info set */
 	if (!bss->hs20_capable)
 		return true;
diff --git a/src/network.h b/src/network.h
index f29649f7..ea619f3f 100644
--- a/src/network.h
+++ b/src/network.h
@@ -61,6 +61,8 @@ void network_set_info(struct network *network, struct network_info *info);
 void network_set_force_default_owe_group(struct network *network);
 bool network_get_force_default_owe_group(struct network *network);
 
+bool network_update_known_frequencies(struct network *network);
+
 int network_can_connect_bss(struct network *network,
 						const struct scan_bss *bss);
 int network_autoconnect(struct network *network, struct scan_bss *bss);
-- 
2.34.1

