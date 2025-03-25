Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA4C1F3D3E
	for <iwd@lists.linux.dev>; Tue, 25 Mar 2025 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925660; cv=none; b=vCJu9M5qPRKWaT1OAcB66zihZA5bXGz8kW7GTyYiZ0CqoP65ED/o5/J2GwnxOgE45Y7y72osYBZx8uSKggtWR6SbQ2ZnXkPHkyRk/uLjIOii15tId/0sVRkFR/UhObu8kcg9yEzH/MvOU7fF9Fhe87q03kTU1p/T1J2R5gBr23U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925660; c=relaxed/simple;
	bh=fVTWIZPaaHu947Xhsj0ojlm+/XG9rhpAQqYDHWn6L/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nki35eZAZR0udrcCxUcV2lhsmFPAzoItG4zRllBEZYOAldrJGRBGlDTS7TbIg6RWkDdyqk8OC9GLG7tEqD7jU3vPnsS6lx3qYFgXXu7mV7LPaxH4YQ7sp3YSEIRVf0SeMDw2fz7+zMGIS0gCihTa+EicguH1Zp2Bd0RMSQROZDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMmz3sVg; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMmz3sVg"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-223f4c06e9fso1780535ad.1
        for <iwd@lists.linux.dev>; Tue, 25 Mar 2025 11:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742925657; x=1743530457; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLmAOMujx9S2nEt/UoUO/0Kjcqf7j3KvU1htbAmnPr8=;
        b=GMmz3sVgq1PZF2cpNkigMCVxk9bch6PdqtK3eXLpUSla7T4VNF+QhcYFY5olnRx8wF
         SZDAkyL8QQ8nNb/L/7CdAAmfQwIBJgLJHTpFDCOEQQHH8wH7aBIxbUBbcM/3Mr5zY4GV
         fw9TIwTnywN0tiSy+IYly4xrEVjEtyP5+IwRVu+7uO8XqyXm0ZbPxNQRwHBotSdYvmC2
         6o6WTh5mUFH2zVTqvXKlbWCRAGDJ7aOimIAH4GXtkljB0ft6GzY1EYpsw0Z2D+w8Y6DX
         tefwIundfMBjv1XgAfysKCDAerZjSTXKv/xaSc9dLejuoXA0VerdQ9lemFSDN+N0NkJR
         FFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742925657; x=1743530457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jLmAOMujx9S2nEt/UoUO/0Kjcqf7j3KvU1htbAmnPr8=;
        b=OP9bkrTmK9hXbibT6HVDa/0C/9hnRCHPV+/z3kfgRRqPSEIpg8fpP/fCpxhSlvsPXG
         8PVwmwVvLYJMNbu5WwiZK6ft9NiKf6IW5qTx0i5Dk0hLSvZ7D+8hAFCWnWVHHmr2VoyN
         5nniH8UzNEkDwM/7Ck/lGWqk1bojJfczIkxNvCIbr+Dgv6i4IOfkUIzJRHDDGTcHDI+k
         x0DqSUww1pIt0oRxpxiK4QHMzWyfKNZw5/cDX/isxSWVMtBdlMUCb3RFbbwgT3GX1oPM
         luhHOBPDZ8IgsgrSKXn3QqIw+qw6mKpDDvkpy4fYV/4cIjnaQcgGR1ULrEzNSaKCf49u
         PNyw==
X-Gm-Message-State: AOJu0Yyxfizht68/IlCi+kV3kQhlBzDEDDafYVq0bHsDn/Ujl3EIVf6v
	iuDQjtFooQsvWk+5vP1NJdZOg8iDn5QVAmOh0D3vtkgJwWbGj5asQUM5/w==
X-Gm-Gg: ASbGncuXCbppNhm9tw3IUm4XiIj5yjWh+74WTRd1GRhMwHrlM+DpiTnuCZ0tkn4i43R
	s5LtPnjkVUmnkjmeLjtNUxaRNTEpfJjM2DwQbkcC26rm/pv9OiaFPXt3NP3bpjwLjMLC3i9eBbI
	naXdDz9vc8IOVl//yfIGtYlAlvGrc+z9O414A7ZkahvJ60praWW41gQ293PSYVIXJlxjRSRmSsf
	jwyTduofMk2NQdXkqqKeaOO8argQbkws09X1j+V1X9UrGruIAir0y6Nt6mu/2FVUbDVAt4n47mw
	gKpWDFdjH6FvlxXNEnjaoJInfTBwrD4sNKsbpt0UkDrdQ+Kl7eVMQYMVcJbdqZv24XpzRkjZ+AM
	tong=
X-Google-Smtp-Source: AGHT+IFdJBQ4KdGnRu42Zuc3r923c/ifkFIk7PlCeuhutCRlu9HRw9ALfr5zN/xxoiIjBTXHe/edFQ==
X-Received: by 2002:a17:902:9683:b0:224:7a4:b31 with SMTP id d9443c01a7336-227efafc884mr8557765ad.6.1742925657170;
        Tue, 25 Mar 2025 11:00:57 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811bae9asm93770515ad.138.2025.03.25.11.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 11:00:56 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 03/10] blacklist: include a blacklist reason when adding/finding
Date: Tue, 25 Mar 2025 11:00:34 -0700
Message-Id: <20250325180041.238676-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250325180041.238676-1-prestwoj@gmail.com>
References: <20250325180041.238676-1-prestwoj@gmail.com>
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
 src/blacklist.c | 61 +++++++++++++++++++++++++++++++++++++++++--------
 src/blacklist.h | 14 +++++++++---
 src/network.c   |  3 ++-
 src/station.c   | 12 ++++++----
 4 files changed, 72 insertions(+), 18 deletions(-)

diff --git a/src/blacklist.c b/src/blacklist.c
index 21f85a75..8ae474b3 100644
--- a/src/blacklist.c
+++ b/src/blacklist.c
@@ -51,10 +51,27 @@ struct blacklist_entry {
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
 
+static uint64_t get_reason_timeout(enum blacklist_reason reason)
+{
+	switch (reason) {
+	case BLACKLIST_REASON_CONNECT_FAILED:
+		return blacklist_initial_timeout;
+	default:
+		l_warn("Unhandled blacklist reason: %u", reason);
+		return 0;
+	}
+}
+
 static bool check_if_expired(void *data, void *user_data)
 {
 	struct blacklist_entry *entry = data;
@@ -87,15 +104,31 @@ static bool match_addr(const void *a, const void *b)
 	return false;
 }
 
-void blacklist_add_bss(const uint8_t *addr)
+static bool match_addr_and_reason(const void *a, const void *b)
 {
-	struct blacklist_entry *entry;
+	const struct blacklist_entry *entry = a;
+	const struct blacklist_search *search = b;
 
-	if (!blacklist_initial_timeout)
-		return;
+	if (entry->reason != search->reason)
+		return false;
+
+	if (!memcmp(entry->addr, search->addr, 6))
+		return true;
+
+	return false;
+}
+
+void blacklist_add_bss(const uint8_t *addr, enum blacklist_reason reason)
+{
+	struct blacklist_entry *entry;
+	uint64_t timeout;
 
 	blacklist_prune();
 
+	timeout = get_reason_timeout(reason);
+	if (!timeout)
+		return;
+
 	entry = l_queue_find(blacklist, match_addr, addr);
 
 	if (entry) {
@@ -115,22 +148,26 @@ void blacklist_add_bss(const uint8_t *addr)
 	entry = l_new(struct blacklist_entry, 1);
 
 	entry->added_time = l_time_now();
-	entry->expire_time = l_time_offset(entry->added_time,
-						blacklist_initial_timeout);
+	entry->expire_time = l_time_offset(entry->added_time, timeout);
+	entry->reason = reason;
 	memcpy(entry->addr, addr, 6);
 
 	l_queue_push_tail(blacklist, entry);
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
+	entry = l_queue_find(blacklist, match_addr_and_reason, &search);
 
 	if (!entry)
 		return false;
@@ -142,13 +179,17 @@ bool blacklist_contains_bss(const uint8_t *addr)
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
+	entry = l_queue_remove_if(blacklist, match_addr_and_reason, &search);
 
 	if (!entry)
 		return;
diff --git a/src/blacklist.h b/src/blacklist.h
index 56260e20..a87e5eca 100644
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
+	BLACKLIST_REASON_CONNECT_FAILED,
+};
+
+void blacklist_add_bss(const uint8_t *addr, enum blacklist_reason reason);
+bool blacklist_contains_bss(const uint8_t *addr, enum blacklist_reason reason);
+void blacklist_remove_bss(const uint8_t *addr, enum blacklist_reason reason);
diff --git a/src/network.c b/src/network.c
index 0a40a6c5..4602a110 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1280,7 +1280,8 @@ struct scan_bss *network_bss_select(struct network *network,
 		if (l_queue_find(network->blacklist, match_bss, bss))
 			continue;
 
-		if (blacklist_contains_bss(bss->addr))
+		if (blacklist_contains_bss(bss->addr,
+					BLACKLIST_REASON_CONNECT_FAILED))
 			continue;
 
 		/* OWE Transition BSS */
diff --git a/src/station.c b/src/station.c
index 0b20e785..e2ed78f3 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2880,7 +2880,8 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 		if (network_can_connect_bss(network, bss) < 0)
 			goto next;
 
-		if (blacklist_contains_bss(bss->addr))
+		if (blacklist_contains_bss(bss->addr,
+					BLACKLIST_REASON_CONNECT_FAILED))
 			goto next;
 
 		rank = bss->rank;
@@ -3400,7 +3401,8 @@ static bool station_retry_with_reason(struct station *station,
 		break;
 	}
 
-	blacklist_add_bss(station->connected_bss->addr);
+	blacklist_add_bss(station->connected_bss->addr,
+				BLACKLIST_REASON_CONNECT_FAILED);
 
 	/*
 	 * Network blacklist the BSS as well, since the timeout blacklist could
@@ -3471,7 +3473,8 @@ static bool station_retry_with_status(struct station *station,
 	 *       obtain that IE, but this should be done in the future.
 	 */
 	if (!IS_TEMPORARY_STATUS(status_code))
-		blacklist_add_bss(station->connected_bss->addr);
+		blacklist_add_bss(station->connected_bss->addr,
+					BLACKLIST_REASON_CONNECT_FAILED);
 
 	/*
 	 * Unconditionally network blacklist the BSS if we are retrying. This
@@ -3566,7 +3569,8 @@ static void station_connect_cb(struct netdev *netdev, enum netdev_result result,
 
 	switch (result) {
 	case NETDEV_RESULT_OK:
-		blacklist_remove_bss(station->connected_bss->addr);
+		blacklist_remove_bss(station->connected_bss->addr,
+					BLACKLIST_REASON_CONNECT_FAILED);
 		station_connect_ok(station);
 		return;
 	case NETDEV_RESULT_DISCONNECTED:
-- 
2.34.1

