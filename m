Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933F41E0DFE
	for <iwd@lists.linux.dev>; Mon, 10 Mar 2025 21:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741642877; cv=none; b=rC5mlmt4fYcRVsXzb7W0tZHss7a0hxr8wXbMeNz38ASdel19cPFYYQ9jXFTiAXH/9OQ/r63kTEJo2lIcW5fMNApeXpsaT8ltzma4rTHFsZm148ZXKyi+Aut6M8wVbWT+t0ON4i9Qo8TssBCHGGyQBD5NRUYSyHG0bfuyS+f8PYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741642877; c=relaxed/simple;
	bh=lggmDBdi7Qo4rHQUc5Vt3rVXhSZLhE0e1B4BuRcazaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o7Z4cjvAr4tarw5LJsYgXjQllK3Y1GG7NvGAg/82XGg/XTV8gJmJpM3oBYdOuiOkbzxMIwEorZkN4KCtK7F8XftBWSq8hpqSL9jSfF69d1WiPPEePAibqPOf1BUPH/ApwlMawTe/14tQ9U/s8OQBz6Rc6Vfu2RzszwBWBwHblgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSibmADQ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSibmADQ"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-475a77bbd8cso46042511cf.3
        for <iwd@lists.linux.dev>; Mon, 10 Mar 2025 14:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741642874; x=1742247674; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3B+uJuu6c4TBgixutemxV73ZyO1KyZzSW4bjfnd4OZI=;
        b=kSibmADQv+n6vH/PikigK8Yt/5iEcRGKp1nBikRXb6GNpIkMZfytZCzLSP7Ln6RME0
         xha8x5kqBcQo275ArXgOZwiqfEl9uzJl+MXb6qveLyE6/GQeewVS9AwgHSGJvdArKqrl
         Sj8s8jCQKkazCI1g52at4yih/X4fE0tpZ0TNyCzCWa3Q7vkXZGLZrDHIRkQTdRO8Uc2l
         /KVURg4QXWppIwnwM05WMteRaRH4xiGywFOXEBphfJA5qHBuFpWu2fVb22Fnv02FCD6j
         C/9ef9ye6kpmcWj58PYyiKrdmKNSj5d0UfIlGNWtlzK86udHlD4kfUB2V4DeHCCT81iR
         g5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741642874; x=1742247674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3B+uJuu6c4TBgixutemxV73ZyO1KyZzSW4bjfnd4OZI=;
        b=IDvKSpaI4AFDoijZgiGKfu74CNfp8IijOa0NgO331cFmEftcihHNK+uFKQ2Bfg3e76
         Y4o+dzWR7M8wMcSWRRFm5Wjyt+zj0B7TA6ziZ3wbylnrhbl3cx/B9ZiYeKJkn+5SfaLr
         Ixrxy23J2k0Nj+R/8Cqlm19qEGD3We2wjFFfO2jEPoRN5wfyab7ldbPxrguFQVwoQMp8
         E3RRuDTyrECO8z5KvACsnyYdxab7WfEYZQtNkPDUR0EhC+IlJYjFEX/uzBapRJ42i0hd
         RuNuTdRawaBPq96IxVIZXlxUIYsATvTGwqSBEdUm74JGlnMnqmEaAzTtx95CFMrK5QYJ
         YAYQ==
X-Gm-Message-State: AOJu0YwE1S+umlJ6KVarPF2lDtM+mgR5Um48P9NaUzDhGxFgUZYIh9+z
	8vCljWOoFKk3dx4I/DHr6rwV1kHeAwFUlO63aCw2D7pl2lmm7IdGkNlIaw==
X-Gm-Gg: ASbGncvV4V85eS+4qWsblSS3e03nfR/z3C61MZobhrMV98rY/DhqD7YFlacpRXtbynz
	M8m7ybOJy/0EXt8RJNa7PzI2BD1KAf0TESXWq9EQFeW/XrxccYjzYrP8PcUsOY5u0xFFuFNmYiQ
	Gv8DWaywumH5BMpJjYY9VdvPx77U09t5MODMHKCHmQY6oZAI1nW4g3byN6m5Uc79VK+oWehmOg/
	/WxQH9PJIHoeC3sBQvF5MgAvrITqwzuW0J+iXb2LObVdRGqbxrvJ4JDRt0WuCbPHak18V8SXrSS
	x2u8TEk3K3gIAmhU+AOVbZi5loWB5aOeo/bZ4zVQNCx9t5dB4zihyTi+6CzdyRZ+op+jFvnHGQV
	AWa4=
X-Google-Smtp-Source: AGHT+IHVt8mT/KP70GolfsL5bLRdAOS+ruf7sXf9Btli1RGSBuTzMWcjH9DYxOkXsydv4Oa+pUNmyA==
X-Received: by 2002:ac8:7d4a:0:b0:476:8f9e:44af with SMTP id d75a77b69052e-4768f9e4583mr52366461cf.29.1741642874195;
        Mon, 10 Mar 2025 14:41:14 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476772de5absm30487841cf.66.2025.03.10.14.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 14:41:13 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/8] blacklist: fix pruning to remove the entry if its expired
Date: Mon, 10 Mar 2025 14:40:53 -0700
Message-Id: <20250310214059.20809-2-prestwoj@gmail.com>
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

When pruning the list check_if_expired was comparing to the maximum
amount of time a BSS can be blacklisted, not if the current time had
exceeded the expirationt time. This results in blacklist entries
hanging around longer than they should, which would result in them
poentially being blacklisted even longer if there was another reason
to blacklist in the future.

Instead on prune check the actual expiration and remove the entry if
its expired. Doing this removes the need to check any of the times
in blacklist_contains_bss since prune will remove any expired entries
correctly.
---
 src/blacklist.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/src/blacklist.c b/src/blacklist.c
index b6583fdf..12100a07 100644
--- a/src/blacklist.c
+++ b/src/blacklist.c
@@ -96,7 +96,7 @@ static bool check_if_expired(void *data, void *user_data)
 	struct blacklist_entry *entry = data;
 	uint64_t now = l_get_u64(user_data);
 
-	if (l_time_diff(now, entry->added_time) > blacklist_max_timeout) {
+	if (l_time_after(now, entry->expire_time)) {
 		l_debug("Removing entry "MAC" on prune", MAC_STR(entry->addr));
 		l_free(entry);
 		return true;
@@ -159,9 +159,6 @@ void blacklist_add_bss(const uint8_t *addr, enum blacklist_reason reason)
 
 bool blacklist_contains_bss(const uint8_t *addr, enum blacklist_reason reason)
 {
-	bool ret;
-	uint64_t time_now;
-	struct blacklist_entry *entry;
 	struct blacklist_search search = {
 		.addr = addr,
 		.reason = reason
@@ -169,16 +166,7 @@ bool blacklist_contains_bss(const uint8_t *addr, enum blacklist_reason reason)
 
 	blacklist_prune();
 
-	entry = l_queue_find(blacklist, match_addr, &search);
-
-	if (!entry)
-		return false;
-
-	time_now = l_time_now();
-
-	ret = l_time_after(time_now, entry->expire_time) ? false : true;
-
-	return ret;
+	return l_queue_find(blacklist, match_addr, &search) != NULL;
 }
 
 void blacklist_remove_bss(const uint8_t *addr, enum blacklist_reason reason)
-- 
2.34.1

