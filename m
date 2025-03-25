Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F198C2641F3
	for <iwd@lists.linux.dev>; Tue, 25 Mar 2025 18:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925661; cv=none; b=HWkAm4YzBYJr9KIOZFfSmVG7510r9lwHI6SiyCy/5eVgaJflM+JsGG9OXA/zOHjpRkmyVCkR9cQUJ2QEmD1Ids7bnfDeRP+ilhOx2V7yIv2RwxoWNyldLHU1U5TEPIKBt6X7IAhjQn4ftFdEeAFa/raPK+DrwlBM5Jb7gZJDboc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925661; c=relaxed/simple;
	bh=BrH42WKhmJVPhC61fzD+MeGaw6W5h1QEuAcVG1DiBfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W9SW/DQHfzNygy8suMBSZXgOlyAer+8EpgoMHFMhiAdHTCXVVz6e5MuYRcWu39g1trkmKMjWwKgUDejLPIljO2dEvBQ2Du9tNHqr0ZVL8xh48RUVgy6hwlQXGA8OS84xhRus3zkblcgw6IPG8uKopGz2aqLge5skohPbYCIC4ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Us8yTHnX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Us8yTHnX"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2255003f4c6so116114065ad.0
        for <iwd@lists.linux.dev>; Tue, 25 Mar 2025 11:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742925659; x=1743530459; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Rhzxq5SVNXIf8bmVNjN9u9uNej23p4Q0pgvf0hbCvY=;
        b=Us8yTHnXUjFtN3v8I/rSoKn0/NDubG6TIEbETLpEh4o/H43A1kjoDOw6cag/Cy/Qx5
         XW0HZHItEoTRmEbIYakbPNHhjyTGu0PwWmzVNc3noVmRI5R0P2WY5wNVD+vJqWl/uT9m
         w0BdrzoRuhbzTYdeyo18wC9lzoKovO/Uc/KsHqrzp+Yu3v0h9XCUj73a3BuIrm6EC6HT
         vjf4GxkhhA5t7Oa8pEPhHovL7XWgPuNp2D4soMbKNY91sUZJ/m5zkCvFl1jTm3bz3B7g
         +/TKiPUKUELnkB//qA3k8ZKoQWW0hVfC4qoUgDklgo1CJxYD2/kxVwRtrKZk13/lNaIn
         839g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742925659; x=1743530459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Rhzxq5SVNXIf8bmVNjN9u9uNej23p4Q0pgvf0hbCvY=;
        b=FwgquUeHO76qUGwx19wZAUOwpAo+1i9nR/lNiDahR+vue6nn5zpgwUII2TEHzQUVvq
         z30Ext2/NQCQWXVzo9CJgoOUCoyDEGKx8HzI2Cov9vFAq7vJxl+iAC0tU7r5IuTWws3J
         yVPTl9HTjcmzpOEB86wySMcbQ96TzH0Xl3KAxM4U/7dK/njb0mGuUvGgczMKRdYb+4aV
         AxJ5LtF402DOMeFBJ3RQH8h71INiARjGiLE8F6+WCWM4X/o2EZybKGO6XF1Vdk0K3qXE
         pKKdDgpcoSaDn7MmfFd38rK6wbNx1F6ywNuL09j5HJRpowg3OtOgvN5Of7DcpAh2rK+3
         Z3UQ==
X-Gm-Message-State: AOJu0YyY6ToCerhzOObUo6TIkMIJ6SNZadMKrkEUCOeurVVNtX/m1SmG
	Zr+ELRoLWVKmNH6uXzTiL0Cse8oxi5v4qrWE8Uztmyw1rSui87y891XLBg==
X-Gm-Gg: ASbGncvQ88u2swLwdKwyWD9qL9spyvC1CJc65sHbCKsgPWfwCMopD6SAOzmLQkgN/rf
	P7PBViaiTxC1Y88AnqxwGiqaJ3E8ZnepVD9hyADSdE7G4TBG2RiZvapbjxe3MX5Fwju1nll/vTr
	r8YN6xP24qK8QewSh4bLV/nrBQfXj2EKFR0A4G5lla6eaaDAwvPxuXeEjm4jUa9ebMVtVHNtlzJ
	YIkAs4p03jeS+JJOgLgYn/tIWWp/h6NjGQqXsgdBzLrMP4H5zs0P6+hQ71/KHczgW0vHd2j/m5w
	TOEr7eo4MEVXcbdsQCP6vwE8B8tx3qm1bP2Qj8zDqPGZlcQIFvr7wMT88cvp7vvHXUlGhRhHdTH
	0Hy7oj7n3BrO0bA==
X-Google-Smtp-Source: AGHT+IFzKIt9T2aFq5Xa3Bj6J/yL327uRfCl/FyK95yaooJXgy9SlRqzFahZBAmCwfGolZaDTv1tFQ==
X-Received: by 2002:a17:902:f64e:b0:224:1c41:a4c0 with SMTP id d9443c01a7336-22780c50cecmr294774025ad.9.1742925658732;
        Tue, 25 Mar 2025 11:00:58 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811bae9asm93770515ad.138.2025.03.25.11.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 11:00:58 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 04/10] blacklist: fix pruning to remove the entry if its expired
Date: Tue, 25 Mar 2025 11:00:35 -0700
Message-Id: <20250325180041.238676-4-prestwoj@gmail.com>
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

