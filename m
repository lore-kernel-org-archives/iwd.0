Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9A225F7A1
	for <iwd@lists.linux.dev>; Mon, 24 Mar 2025 14:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825759; cv=none; b=adT/PWzy+5DkqTmzPinmZLAU/t8pQUugGtwdfi+6O/opY7ime+vCKg6dKgtdVdpGXbGy4cONFidfTnjrCyEIpUtguS8ZbOpeFTDZ2T4F4oxOp5alI32lp3n1sUE/zae5u0/27f35dk/b9f+Bxh56uGcvWHiDOghZckEsofZZIWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825759; c=relaxed/simple;
	bh=kDbBHa7dv/2J/wsyl5QeuwjBGgEup1aWI8pNSyvLLP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dd7Cpr+C/2CyifO1oIxPCZutpzAER9hxMUvlUsosARaX7rWmOotnIomkLL3zI4RVTtX8P0B1MTWDvsLutanO8h/zKfaEBudR4V+C6YmdBteY5qJOqVrF0ihWgDKJtWuFVJI+/vwAnD6gESr6hCdk9A5Y4eTFd/HejnIhh7C/JJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8/Toqtx; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8/Toqtx"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-227c7e57da2so15104915ad.0
        for <iwd@lists.linux.dev>; Mon, 24 Mar 2025 07:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742825756; x=1743430556; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wlR5HXvNId2KnttetbOYOmB/J+YldI9plWWPNRcDxI=;
        b=b8/ToqtxWKFVdqoynoQTHqZeTmqTPP3xFz5gzgkvvB8scTvLXAXNVJ9pFCLURjJEIC
         HlvfjtvTGCiiFH3WkvTFM5oie0+wv74xkfJ49RYDbTSaIBATaBGYGGh0+X/P/XL6MQuB
         4eKkMLlP7WtmfDTDB2PrbJpDwQsLp1p99fMZPS2Mfvf/sQcrEAt1g5fi4pj+Zej4XyVD
         XlDjfqbaT+exrDqqKyWZNx9/Tk9V6gBdieMQDz89Jb/m9IfxBhGyVXa88vuAqjuwoJzl
         pKI64Trls+PhuDY3UT86F1CJS8H5t/ZPSKifyKdGO1EWZHABrbTs3O888EbgYzqtCMMC
         M7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742825756; x=1743430556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wlR5HXvNId2KnttetbOYOmB/J+YldI9plWWPNRcDxI=;
        b=KQi56Ivd15xSFZbWHGkCquwhEdtJg1FwRDD4uStpl2Xm8BD8lWs7zU/2lZYwyZXAwH
         akti1jXf+uYhfLO09gH2gcoOAuNK9CNODLEysrDs6/SNrkAma4nXt/+bkmJxeRoCTiOX
         pbmPzKsxTmdu6jtphrbSvp92N5R7nB66T7bLPQpbOIKfuc6RyICjbbvtVQZTrjfmaOrc
         MVPAYDAGar7wjRCDrY/HNkpxzOjGQdxtrJE9PvUiMzPsMhZpUIyePHe0B924EOu5jLbL
         xzBzQwgo73wzJLha0G7eHUaova9DM5vCQ4wVYfrK1HMCWu6e6OETiBFnEhf01xMSqIBs
         rm6w==
X-Gm-Message-State: AOJu0Yx6flcgxSuArAjJSOrr8YaIxfRQR1ya3CW9pUaJ1vXUnILgm8a5
	HM4brwPJF2lrfczAZK9LbpxxqbBeC/4Cp+QDzNFkMM6w7+U2Q+T0EVWJFA==
X-Gm-Gg: ASbGncuxRFwhAgCG5aLmKh1neKa20qgR2HIaRhmkBwAya4Mo5nSjnyAzDZUAfYXBfBu
	KFX7lTXdbucleCfo2NxjV50UN0tUoZW1J8pBrWSJBpcyqwpDDGKHgq7Xgz3tJ3qX3RRl4fxX9xl
	9HUkMoMWniz7Y2+CeLDg/ASC4tky0r769NPJVhelhlRCgyqj3wgmahWbTO2QBFn//3Lta45Tal8
	DcdI3DMhFsOwJ7U7W4iMWqYDvTdfO/Hp650GbpChxMbFqSd8AoM42JC3BobzAVVmjYAEvyzLcl1
	Atg/xBlwYxMvk1apwCfJnCWW7nWEvdc8U5ARlyr0porLOJzpIIdO3OU=
X-Google-Smtp-Source: AGHT+IElN6Tv8FnTom/G0kL4ciWkVlJiPwFgHNkIhVv38wCknlw17lRDBiklfupxBHIGiWSD2CnHYA==
X-Received: by 2002:a05:6a00:218b:b0:736:7a00:e522 with SMTP id d2e1a72fcca58-7390593b7f2mr19654657b3a.2.1742825756107;
        Mon, 24 Mar 2025 07:15:56 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd54efsm8007868b3a.37.2025.03.24.07.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 07:15:55 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 03/13] blacklist: include a blacklist reason when adding/finding
Date: Mon, 24 Mar 2025 07:15:28 -0700
Message-Id: <20250324141538.144578-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324141538.144578-1-prestwoj@gmail.com>
References: <20250324141538.144578-1-prestwoj@gmail.com>
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
index 21f85a75..eb722de5 100644
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
+	case BLACKLIST_REASON_CONNECT_FAILED:
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

