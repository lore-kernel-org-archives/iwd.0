Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72183EAF9
	for <iwd@lists.linux.dev>; Fri, 28 Mar 2025 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743172988; cv=none; b=g/E75ZNLg02K43NfZjLpDgaXuJXpSo77Hhz4nBnWQY81riu9mXOJW2riPjdodiwyOQizFh33MdYRrrzrPSAleY5RTVOoSo6NLw1Gk8g67HOq7OmjdLi3IAh9NxQ7s47aYk6E1JLdy8LAKutNn26XUlXaRksvjv4R836KrlwSNsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743172988; c=relaxed/simple;
	bh=fVTWIZPaaHu947Xhsj0ojlm+/XG9rhpAQqYDHWn6L/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ax9g6iRi+CimkOYTwrKYHVlC9jZj81oW1zNFKGurPuihsgVC+EFd37wvWB7Mh6dpT4ynnTG64gmnDMpfbWyCyk8wCqf3tZM0ZZve95xVzU5dWgwY/pQFnB+ztsEtdNNben194W/VrDAoZucjIZpqNqMVBboYr//0AOgklhxED3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=notiujTf; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="notiujTf"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2255003f4c6so44710085ad.0
        for <iwd@lists.linux.dev>; Fri, 28 Mar 2025 07:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743172985; x=1743777785; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLmAOMujx9S2nEt/UoUO/0Kjcqf7j3KvU1htbAmnPr8=;
        b=notiujTfNISMlyhqi0QEslW+yYSEUbm8iG3jRLmWEwGAq0UEU+A0w9VeAeWm4hsFvU
         Ddgljhyq4Ku6cHSMxvDc2oAZxkJAGMlZwsoNYyGgeGASiw0LIhrbYUsQIUePimkwNgAm
         Qybr30dt0C85bsFljFNsVuFz8TxZtNr+cKRUN3JAmIhXqTqLQ1tqBtponYFk69PwkM3c
         QiCFx05FohiG9R/7+N9shRF0ZlBA1wG7UD1BoUobqLd2VEry8GqXs5c1vUKnZ74vJUDt
         MEr7Cup4qO2Q2k9vtfrkg6VHowFmCzzES6t5FYowt12aaGFlO0hLsGp86cI/cFu0HbFj
         wx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743172985; x=1743777785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jLmAOMujx9S2nEt/UoUO/0Kjcqf7j3KvU1htbAmnPr8=;
        b=vOytFQ1voishDaZUlAbt5ERTbQzXOt7QVQTYEGamsPqLfAZWFaVGBsQsX0XbY0NNTw
         /YhiWTukB05H+GMoX1JHCCryDjZ/3BZOtbVaunTwbkQdzmx6lpUY1b1TaZ8Ftkp79QF1
         LKvSEhsc96Zm1KW0YIC2K2nrZZ9yFdseiFa3rN0/z1EQ/i7+e36DYV6u9z87gNvTXsWn
         MUn5h0Qz/fad9z7suuoUbgcZnzTM6MjBBIrje09dOTwD2LlUAp8cafLHBBoCH8DVKi74
         4xdkTCaI/KKy91KyMXuJfbkg2igSBdmDM9q/inG8kPHLD0GJSV7VJ3qrX/agGnpOXNEh
         kUrg==
X-Gm-Message-State: AOJu0Yw79H+0eDzo4G/uPwOXKla5vzRIhmTT9ijI0vCVZxNrHKHfLRsI
	/mspoIr8bp222PMTcfNigNvqhnbZdaB5QbtJDYzkFDv5DP0xp+KPfYPPBQ==
X-Gm-Gg: ASbGncuBxTQEaepP53L2pLQbysmHh8h+nCNrQ56F+e/KGzgFb+9x8LhjxCp5gFAff39
	rJq85NbkhEHLwll4Di+gK6PEb/p98kpKSzs3Y2F39M1PtKu/R56kqkIchxsjv3uUwQP+CofQuZC
	iwLiZADyS1iptVlgX5rX2AtHHExdVlV/vg8s7XLo/+NoEULuBOnjhxfI0bIkK0Ud6l+DK3QnMss
	CMvSBjirIDYGHyasBHR/gKXmwf95bPMO0HofW9GV7pZd13uviQiu2cG4OQJdzfLbIDU7TVeM0gp
	25fcjaOJKoLjaGs9ba8kYpTtnUFwnYHDLIZCaFR5B6qNLuXJ25GplUE3jSuWTt7oHd0oCKQDV80
	=
X-Google-Smtp-Source: AGHT+IFeIBoqR0MWn6GLbZJgAreFg6ki85wKV+I/pZyoG1HValGvX0A4EdWMjj0W2Gb/q7vq0VEO4Q==
X-Received: by 2002:a17:902:fc4f:b0:216:410d:4c53 with SMTP id d9443c01a7336-2280491aa7dmr127005725ad.41.1743172985174;
        Fri, 28 Mar 2025 07:43:05 -0700 (PDT)
Received: from LOCLAP699.locus-demo-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eee2288sm18885515ad.87.2025.03.28.07.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 07:43:04 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 03/11] blacklist: include a blacklist reason when adding/finding
Date: Fri, 28 Mar 2025 07:42:45 -0700
Message-Id: <20250328144253.421425-3-prestwoj@gmail.com>
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

