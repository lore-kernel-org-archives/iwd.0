Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3FD1C549E
	for <iwd@lists.linux.dev>; Fri, 28 Mar 2025 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743172989; cv=none; b=FqeWKH9Ga3dsnDjWNnApfRoWCQTaF0Co0j/hyw6TBYIa01HJ4xiwshgnhXFNUNCj5QdY+L0SNXlJl09zwT+J0QHFvc5M0Y+Amu8ng8NiWPhYhug33kfacJxJH3ZAUdk92mAiSU0AuoVLGxd9ppCKYIYDvZevjVpqJCyPjfSBNAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743172989; c=relaxed/simple;
	bh=BrH42WKhmJVPhC61fzD+MeGaw6W5h1QEuAcVG1DiBfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j0UfOZdnYGOPkyLCQdgQ1dCp+Y6c0rVF3babdeNhzT7h2VRg+UHUVivbkM3EQrg4OdB53q+bKZ7WkwQBfdkDN6I3e4rQ6ai9DKsQ3iKnceMMh1Xq0yWF1oqZytsfikKpwy04ufCW/DqJZdIJOuu9qOCEUAsPAgimR7pQMqv3ZYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEOhuLJb; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEOhuLJb"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22409077c06so68827565ad.1
        for <iwd@lists.linux.dev>; Fri, 28 Mar 2025 07:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743172987; x=1743777787; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Rhzxq5SVNXIf8bmVNjN9u9uNej23p4Q0pgvf0hbCvY=;
        b=iEOhuLJbk/6EH4uoW+/nU+BBJCmMi8Wqua4igkKkKRJn1UF0xGLwUgGWiveA8Ou2pn
         dY+C+WZBi/31D4bwNGKeVJaSLC84Ibta13tvZE4En19xWvsHWJCeTDpny58vf4F2P+Ml
         qPvFnAjvyi6+kq3LafEn6+nZZmTJahnK9dbh9Wnzv5asHtx++IUV7P4HMXfZFkd7+2w8
         E7p2ksVpdA7jIibAPWFGUnZi8iWeIk2pOskN40ntaY8tEK+aFpyzhqOpbnxW5GCBpVe2
         n6BJMFT6veY/DRztrsvLLd5xhWQRqnGtG2jTjiW5UvSZ+RdJJbPK7uKL48l+wv+oiedO
         wJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743172987; x=1743777787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Rhzxq5SVNXIf8bmVNjN9u9uNej23p4Q0pgvf0hbCvY=;
        b=RKk4x0DVWrlNEW2QqK7ZeRizQdoqNv7o8ANBXuc48mUy8VKagHFXf7l/MC6wEHKZ/S
         tc221E4Ttnro2YwPkGC8J8p5bWbdN5C86m63+cosRY5Bi/zv55vBG4fB1Rwv3nySvN05
         skIYl/wnXLI04NetoRKszyDxL+mtNfFIef+PhRZObdQ3M7FqcJsR+PHIYyppodUhOmdE
         xy+AVAFWqnvsEkxLl4g5/zYGTXBXq1vLs3V4fhEvzRMVYr1zIwFwLnLeHsG3wPieDYGe
         SlTpcHp7en3wDc/xL7F4OlN9tVFJ+3CChwRbTbgCh7zveskAeGacV44SS08BRw/Wkfo/
         EHmw==
X-Gm-Message-State: AOJu0YxhWDHIXyABSBl2zemNJ3tb5kmQOX4DAjmBKBOoCH0uWdnhEiit
	A3R2A010/y5iIfreedg8zYREH+MxMplmirs6Qh1+DeL2Gm/lp95cMdObow==
X-Gm-Gg: ASbGncuZo/u/kOq0bpsOKF+FE7GDTAulrxipQGEqaYp7FIM4nHbwUwaq0mcYpJ+3Bj9
	KbrNmkG+xCfKFHLiiOU7r/VmRcSN0CNqKfc2jN3PfX7NPWe3NMR30wupNgEelAXOXrV52rf0Ltm
	0y9FgxfFCez6rd9SFrybZrsGw0Kw7/8hhFdUazAoXTxBgXWSzI+Y9ly03fqa2qcotkMn367m9hJ
	XlDsieU/WWwbPOZ247qVgSbv8qUCQmfYwZjP0ywgU/iW/80NnQJXydPY/HYXygLnuDlMbhIi8Im
	Q9wubjn5b0431kMpq+25vkYFWw1BVzE0+jiwtqP7/DN77CkIPOT+rVdla1F/iC1ZWrYGQGfIkAs
	=
X-Google-Smtp-Source: AGHT+IHIOMvutevediRcT5hoB8o/R5VDo1GcMp+1k0UFgY/ZCxtWFx7R4I4ba7pI32cHbTdl7iL83A==
X-Received: by 2002:a17:903:2312:b0:224:1074:63a2 with SMTP id d9443c01a7336-228048e8453mr114897645ad.43.1743172986733;
        Fri, 28 Mar 2025 07:43:06 -0700 (PDT)
Received: from LOCLAP699.locus-demo-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eee2288sm18885515ad.87.2025.03.28.07.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 07:43:06 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 04/11] blacklist: fix pruning to remove the entry if its expired
Date: Fri, 28 Mar 2025 07:42:46 -0700
Message-Id: <20250328144253.421425-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250328144253.421425-1-prestwoj@gmail.com>
References: <20250328144253.421425-1-prestwoj@gmail.com>
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
index 8ae474b3..2539c5e0 100644
--- a/src/blacklist.c
+++ b/src/blacklist.c
@@ -77,7 +77,7 @@ static bool check_if_expired(void *data, void *user_data)
 	struct blacklist_entry *entry = data;
 	uint64_t now = l_get_u64(user_data);
 
-	if (l_time_diff(now, entry->added_time) > blacklist_max_timeout) {
+	if (l_time_after(now, entry->expire_time)) {
 		l_debug("Removing entry "MAC" on prune", MAC_STR(entry->addr));
 		l_free(entry);
 		return true;
@@ -157,9 +157,6 @@ void blacklist_add_bss(const uint8_t *addr, enum blacklist_reason reason)
 
 bool blacklist_contains_bss(const uint8_t *addr, enum blacklist_reason reason)
 {
-	bool ret;
-	uint64_t time_now;
-	struct blacklist_entry *entry;
 	struct blacklist_search search = {
 		.addr = addr,
 		.reason = reason
@@ -167,16 +164,7 @@ bool blacklist_contains_bss(const uint8_t *addr, enum blacklist_reason reason)
 
 	blacklist_prune();
 
-	entry = l_queue_find(blacklist, match_addr_and_reason, &search);
-
-	if (!entry)
-		return false;
-
-	time_now = l_time_now();
-
-	ret = l_time_after(time_now, entry->expire_time) ? false : true;
-
-	return ret;
+	return l_queue_find(blacklist, match_addr_and_reason, &search) != NULL;
 }
 
 void blacklist_remove_bss(const uint8_t *addr, enum blacklist_reason reason)
-- 
2.34.1

