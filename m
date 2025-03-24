Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1F925F96E
	for <iwd@lists.linux.dev>; Mon, 24 Mar 2025 14:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825760; cv=none; b=u/eBAU+u1Wr8sirqKeN6J7sYiZX7ymAMCGX59POj+ltThkC/UK7C4I14F+ghE6yJumZ4Jhti30RXwLMRxnJxJi9+JvBdLlnX3u8FSypR0BjlQ56csmc4EnSaulKZC0rVo1uE2EtEQaUfRFyi60XSVAQUllc6YliJ5zo4mw8LpO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825760; c=relaxed/simple;
	bh=a7WJCvx551iMFNF5234uURKm8WKdUHevFwd2TVGdWkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JXDJvKnbzML849C4wZ3VE4xxDpofcIR3+XSgvjSkkgodz0ysgjJdxJwgGbhCmXS0HZvqSEQ/qOADjDT4IR/EFnycsPbw+REhvzjO/AGGbdSme+Cwk1iJEZ5uXwAlHYuUPyV15o0OwBKwfwKjOrDNffsoxGikZtqaQ6dmB6ovb1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXZzdKdC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXZzdKdC"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223fd89d036so83501085ad.1
        for <iwd@lists.linux.dev>; Mon, 24 Mar 2025 07:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742825758; x=1743430558; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kOwG/yngvmK1gcwehtoklydLh11RsZs9cJUvwASH98=;
        b=UXZzdKdCmo7bP/4sFNvLz0HBmJMK1+8jsnG7qJWCNhf00LzG7eUubzmiJQXjuAmxjS
         Qzjz+EODWM1rhUPyn31ZWiyTzs9RGaciMQRnwr1I4eAakfJbhw8IsrVhj5jkX/NKyx9K
         W6s9tNPnyvEM3t1iYMi7T/U0jLLDPUvtwBPyn8SmhK8NdLs6u6S51y8UBnArQnn03n/K
         YhPbbmQBk6oQ6UNB9C9UdeDDna6qVxplDCYSWP4TLA/wkxxILu2rUOfr68ygMYNh3VVE
         nGnXVhVRNXdKCuyXHHNpOzbmozVUBioIEw6zffXSoN3YQyP+0nbHHbfC5M0J8vr6B6u2
         ifEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742825758; x=1743430558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kOwG/yngvmK1gcwehtoklydLh11RsZs9cJUvwASH98=;
        b=ZORW8X8gsx8OecL+aSKr2rvEz42V9ArzXOnY3xHLbTDwYNrhOxWVApKMQnZSQYD/qF
         Ifn5wX5yKPsCJqKdWAUxYE5Qiv2zz3g50dZ0j6STuXHhZwJ+9oORu89aQfY4zWOWhQgy
         bAaQvU/qh4TlOACZ55xeeOeTufLSGw+yt9p+wamu6EYejOl7a90fLqPEEmnUNDSltoGa
         7l8Rnsrtm5BSFBVrumYN5mpRHW1gvlyTGA0W/f5lmY0yVyqNSri1HWlB0Xr//+JdA8fs
         HtNJhAYvXPtYu5SJgwlrAN+TX6TsulIISpO9+pScz9wzP4Trt5exGM2ySQMBwMD0ouke
         +6kw==
X-Gm-Message-State: AOJu0YxFUXTeTZHktAm3vX2NpNPZ5bbq2AdEGJb+je4ZGJ7RL/ZUJ0Lb
	uEI/o+c+WsG2qgiy0lp7PkYSk6XL9qjQKx7AsQPo4nays4UcWY8fR1ok4Q==
X-Gm-Gg: ASbGncvHaYM7g1sFwDqZFdiwEi2lzxIi//Mqlj85yE8DJsLnXQdXfNXdbGWZMB/gcRk
	dGH6YIRahf3S3KJS39HVEWSSuEmtBs+d9l+U0iFvIO6pWaI6MFhEAxfSd/SaizceDJlRa4S2D2X
	gTgu3ZMBLuEFEsFh84wJTgCF6vYsg9irXxTVph/Dhx3bFFIcrHFkuEtbnWyCfhyzHXNCv/DVqkP
	n1BftlFliIumEse1Jtl7pRn2eBqJC2WwG67uCv1BN8JwQnoBBpb4JSyp7OinqH0IAzxH1P9iqkd
	ZfS1re4g3v9h8IDItt1pqrqn0xlZ1S2BHMg0n2ZrQrYPS/RM6tj6rww4Er3dp6WvZw==
X-Google-Smtp-Source: AGHT+IFNyovuy+jMVrBXwDmzSt7kqJU3Ong0IZePlWrv5Ok3R6p575ar1jcMdW6xS5tnThA73Uwarw==
X-Received: by 2002:a05:6a00:1146:b0:730:9946:5973 with SMTP id d2e1a72fcca58-7390593b830mr18635972b3a.5.1742825757666;
        Mon, 24 Mar 2025 07:15:57 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd54efsm8007868b3a.37.2025.03.24.07.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 07:15:57 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 04/13] blacklist: fix pruning to remove the entry if its expired
Date: Mon, 24 Mar 2025 07:15:29 -0700
Message-Id: <20250324141538.144578-5-prestwoj@gmail.com>
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
index eb722de5..ca699767 100644
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

