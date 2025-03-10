Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2851DFFD
	for <iwd@lists.linux.dev>; Mon, 10 Mar 2025 21:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741642876; cv=none; b=SAeKH8wSqzpBsrTtoKdFG3rHMV6bUCo7pByP9HLJcAnL60eWegauiGFwN2EHXa0oHmLULkcrnMz3KF2a6UYy+Duu1pqf5zCCEmQJlLY3m0/BP8a6erjPKfb+wQxPhYzn4t0bouJE+nA2EnIv5HuP2AQ3xAxz0f74My0LuOMgPhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741642876; c=relaxed/simple;
	bh=oXxroYoZTSblSWJSbtqjTRVXqV50TGF+rEHQGvWwN4M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GZuT8dxZeRw0Hu4JLR+9Z3p86g5WFqc3BcDV42bKJ821kMVMHXXNKmmlyg96clmQdfzLmkDpRFjPkm8prdfeMnF26/mcMZW+TkVWiDyLRPEiHRX11OQwIJIGedGz8HafR0n+83VCVverLZTdEDCX51HTN3f2KSdNIrKZInpoaBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eL6vX3re; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eL6vX3re"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4750c3b0097so41513941cf.0
        for <iwd@lists.linux.dev>; Mon, 10 Mar 2025 14:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741642873; x=1742247673; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0mFpTsqLKYS9MlkJ8LTsWza+e49TdZbiyZl2/VHb7rk=;
        b=eL6vX3rePDbw7Sx9BgOqVf/I/8nx+YSxCA24JjItbZSVF2yL738C5yI5VZLcGeHOVX
         zulFGeVWbe41TyucUfaut80LRz/ZIM1EEjGR3A4jps8pF0S5SNdfjagT/mpFU4p1+oeY
         stx/RKLzYYW4SvoLsPjk2oZrMx9PgRFPos5G0W4KlChHSYXBrtNX3WDRjFBpTpNCQSRP
         Sq/tfmNjO0XgBlGZgifMhcquGHVl/c+7shZX4sqgtz2XHJJ5skXd5/0n54vb1AT4LP3A
         H1Y8MVUZum2giAugJKwnFz71ok12IE/w1u9M8Sm+rCMNOvy0Jyg8nFZalWpv5iGLztaO
         zgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741642873; x=1742247673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0mFpTsqLKYS9MlkJ8LTsWza+e49TdZbiyZl2/VHb7rk=;
        b=gq6Xi++YUbSWhaYoBgv6A8rztbzxhBkekUumfjtKA2F78vBbYG0+q7PYPm8LyOc9+F
         CsiwwIneYa00gyjTnGvqcaEz40W4NNI4dyUnfdxVM3uKlZs9iGC7RvRVup5cGWv4vGya
         m3kcZrDAlEAiRXhlLp2oEdtaolX29uOuXPBrQqsCBgmGENtGEhMc02ouuQcDngbkiS/N
         VlpjFM2jDuCrl/r3lDAbos61fU+qpO11+P11riM6WGUiirwhD61Mj1Dvem3PZ4JEmOsz
         x0jfaXt+YmyagL4ZdKKul4zMlTxKTxPfksLl2QwlaSspjfFCo+dApJKkBn4WCuqz+tT7
         Jr0w==
X-Gm-Message-State: AOJu0YwyM4gakWl6lqpMKkrtnOl2i5VON2xLvJ6jjTmp8F2PZMKsxXwi
	v2ICiu9oeNriBj+CY5P5GW4pqWZWLnAibtpqSO/O1ZE9E3Cxitk1KzWaFQ==
X-Gm-Gg: ASbGncuvapDwGbnB9FqElezsZjXPE2VVuzWxqV2zsgMKjreKq0XQf9iX0I8iyzd64Fp
	FCE+QdzNZjj3BOw2fwk1ZJeombxfjkol/58BQlXZD0P0w1c5aVMZ6MQYxOx9vAptL8AauxMpZ8Q
	8glm1ZHi46lta5cH01hL3LqkLRSBrBV7PEyDywMFELlgNQbd2tvVXPIzopy6dYle8Ixv5p0I6bq
	nImh5OWzo73zoky/igq6X/LQePsDkrD0J7EPoOgvpGlMSw0PV8GXjAp0B55NCyd+EVBqE/jOYIT
	8Z4Vz4E1ZemoKaVagoyY3WNmyQ75PVn4fqhbj3a5QdzTAxKKbc6/NyLLqJSPZ20JyTd78r5NGGs
	XNy/lRZvRLNZi3w==
X-Google-Smtp-Source: AGHT+IESQx6ek1dfAq9/pbjypcFSBJ8ryc4i1hKnrKC8Grgntp9HURBoN89ygSdn8mqcAgKITMUTjQ==
X-Received: by 2002:a05:622a:164c:b0:476:9296:80c1 with SMTP id d75a77b69052e-4769950dc42mr25163451cf.31.1741642873019;
        Mon, 10 Mar 2025 14:41:13 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476772de5absm30487841cf.66.2025.03.10.14.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 14:41:12 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/8] blacklist: include a blacklist reason when adding/finding
Date: Mon, 10 Mar 2025 14:40:52 -0700
Message-Id: <20250310214059.20809-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To both prepare for some new blacklisting behavior and allow for
easier consolidation of the network-specific blacklist include a
reason enum for each entry. This allows IWD to differentiate
between multiple blacklist types. For now only the existing
"permanent" type is being added which prevents connections to that
BSS via autoconnect until it expires.

By including a type into each entry we now have additional search
criteria and can have multiple entires of the same BSS with
different reasons. This was done versus a bitmask because each
blacklist reason may have a different expiration time. We want to
maintain individual expirations to have the best "memory" of past
events rather than overwriting them.

Future patches will lump in the temporary network blacklist as well
as a new roaming blacklist type.
---
 src/blacklist.c | 81 +++++++++++++++++++++++++++++++++++++------------
 src/blacklist.h | 14 +++++++--
 src/network.c   |  3 +-
 src/station.c   | 12 +++++---
 4 files changed, 83 insertions(+), 27 deletions(-)

diff --git a/src/blacklist.c b/src/blacklist.c
index 21f85a75..b6583fdf 100644
--- a/src/blacklist.c
+++ b/src/blacklist.c
@@ -51,10 +51,46 @@ struct blacklist_entry {
 	uint8_t addr[6];
 	uint64_t added_time;
 	uint64_t expire_time;
+	enum blacklist_reason reason;
+};
+
+struct blacklist_search {
+	const uint8_t *addr;
+	enum blacklist_reason reason;
 };
 
 static struct l_queue *blacklist;
 
+static struct blacklist_entry *blacklist_entry_new(const uint8_t *addr,
+						enum blacklist_reason reason)
+{
+	struct blacklist_entry *entry;
+	uint64_t added;
+	uint64_t expires;
+
+	switch (reason) {
+	case BLACKLIST_REASON_PERMANENT:
+		if (!blacklist_initial_timeout)
+			return NULL;
+
+		added = l_time_now();
+		expires = l_time_offset(added, blacklist_initial_timeout);
+		break;
+	default:
+		l_warn("Unhandled blacklist reason: %u", reason);
+		return NULL;
+	}
+
+	entry = l_new(struct blacklist_entry, 1);
+
+	entry->added_time = added;
+	entry->expire_time = expires;
+	entry->reason = reason;
+	memcpy(entry->addr, addr, 6);
+
+	return entry;
+}
+
 static bool check_if_expired(void *data, void *user_data)
 {
 	struct blacklist_entry *entry = data;
@@ -79,24 +115,28 @@ static void blacklist_prune(void)
 static bool match_addr(const void *a, const void *b)
 {
 	const struct blacklist_entry *entry = a;
-	const uint8_t *addr = b;
+	const struct blacklist_search *search = b;
+
+	if (entry->reason != search->reason)
+		return false;
 
-	if (!memcmp(entry->addr, addr, 6))
+	if (!memcmp(entry->addr, search->addr, 6))
 		return true;
 
 	return false;
 }
 
-void blacklist_add_bss(const uint8_t *addr)
+void blacklist_add_bss(const uint8_t *addr, enum blacklist_reason reason)
 {
 	struct blacklist_entry *entry;
-
-	if (!blacklist_initial_timeout)
-		return;
+	struct blacklist_search search = {
+		.addr = addr,
+		.reason = reason
+	};
 
 	blacklist_prune();
 
-	entry = l_queue_find(blacklist, match_addr, addr);
+	entry = l_queue_find(blacklist, match_addr, &search);
 
 	if (entry) {
 		uint64_t offset = l_time_diff(entry->added_time,
@@ -112,25 +152,24 @@ void blacklist_add_bss(const uint8_t *addr)
 		return;
 	}
 
-	entry = l_new(struct blacklist_entry, 1);
-
-	entry->added_time = l_time_now();
-	entry->expire_time = l_time_offset(entry->added_time,
-						blacklist_initial_timeout);
-	memcpy(entry->addr, addr, 6);
-
-	l_queue_push_tail(blacklist, entry);
+	entry = blacklist_entry_new(addr, reason);
+	if (entry)
+		l_queue_push_tail(blacklist, entry);
 }
 
-bool blacklist_contains_bss(const uint8_t *addr)
+bool blacklist_contains_bss(const uint8_t *addr, enum blacklist_reason reason)
 {
 	bool ret;
 	uint64_t time_now;
 	struct blacklist_entry *entry;
+	struct blacklist_search search = {
+		.addr = addr,
+		.reason = reason
+	};
 
 	blacklist_prune();
 
-	entry = l_queue_find(blacklist, match_addr, addr);
+	entry = l_queue_find(blacklist, match_addr, &search);
 
 	if (!entry)
 		return false;
@@ -142,13 +181,17 @@ bool blacklist_contains_bss(const uint8_t *addr)
 	return ret;
 }
 
-void blacklist_remove_bss(const uint8_t *addr)
+void blacklist_remove_bss(const uint8_t *addr, enum blacklist_reason reason)
 {
 	struct blacklist_entry *entry;
+	struct blacklist_search search = {
+		.addr = addr,
+		.reason = reason
+	};
 
 	blacklist_prune();
 
-	entry = l_queue_remove_if(blacklist, match_addr, addr);
+	entry = l_queue_remove_if(blacklist, match_addr, &search);
 
 	if (!entry)
 		return;
diff --git a/src/blacklist.h b/src/blacklist.h
index 56260e20..d4da4478 100644
--- a/src/blacklist.h
+++ b/src/blacklist.h
@@ -20,6 +20,14 @@
  *
  */
 
-void blacklist_add_bss(const uint8_t *addr);
-bool blacklist_contains_bss(const uint8_t *addr);
-void blacklist_remove_bss(const uint8_t *addr);
+enum blacklist_reason {
+	/*
+	 * When a BSS is blacklisted using this reason IWD will refuse to
+	 * connect to it via autoconnect
+	 */
+	BLACKLIST_REASON_PERMANENT,
+};
+
+void blacklist_add_bss(const uint8_t *addr, enum blacklist_reason reason);
+bool blacklist_contains_bss(const uint8_t *addr, enum blacklist_reason reason);
+void blacklist_remove_bss(const uint8_t *addr, enum blacklist_reason reason);
diff --git a/src/network.c b/src/network.c
index 0a40a6c5..92b44ed3 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1280,7 +1280,8 @@ struct scan_bss *network_bss_select(struct network *network,
 		if (l_queue_find(network->blacklist, match_bss, bss))
 			continue;
 
-		if (blacklist_contains_bss(bss->addr))
+		if (blacklist_contains_bss(bss->addr,
+						BLACKLIST_REASON_PERMANENT))
 			continue;
 
 		/* OWE Transition BSS */
diff --git a/src/station.c b/src/station.c
index 5403c332..fab37478 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2880,7 +2880,8 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 		if (network_can_connect_bss(network, bss) < 0)
 			goto next;
 
-		if (blacklist_contains_bss(bss->addr))
+		if (blacklist_contains_bss(bss->addr,
+						BLACKLIST_REASON_PERMANENT))
 			goto next;
 
 		rank = bss->rank;
@@ -3400,7 +3401,8 @@ static bool station_retry_with_reason(struct station *station,
 		break;
 	}
 
-	blacklist_add_bss(station->connected_bss->addr);
+	blacklist_add_bss(station->connected_bss->addr,
+				BLACKLIST_REASON_PERMANENT);
 
 try_next:
 	return station_try_next_bss(station);
@@ -3463,7 +3465,8 @@ static bool station_retry_with_status(struct station *station,
 		network_blacklist_add(station->connected_network,
 						station->connected_bss);
 	else if (!station_pmksa_fallback(station, status_code))
-		blacklist_add_bss(station->connected_bss->addr);
+		blacklist_add_bss(station->connected_bss->addr,
+					BLACKLIST_REASON_PERMANENT);
 
 	iwd_notice(IWD_NOTICE_CONNECT_FAILED, "status: %u", status_code);
 
@@ -3549,7 +3552,8 @@ static void station_connect_cb(struct netdev *netdev, enum netdev_result result,
 
 	switch (result) {
 	case NETDEV_RESULT_OK:
-		blacklist_remove_bss(station->connected_bss->addr);
+		blacklist_remove_bss(station->connected_bss->addr,
+					BLACKLIST_REASON_PERMANENT);
 		station_connect_ok(station);
 		return;
 	case NETDEV_RESULT_DISCONNECTED:
-- 
2.34.1

