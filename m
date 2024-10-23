Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63C51ADFE8
	for <iwd@lists.linux.dev>; Wed, 23 Oct 2024 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729689680; cv=none; b=Y5xQN7dIWKIsKil/Mk2Lfm3fr2uH6VDtk1amRYnY9oCjWMWYHpstonKzHArYeODyb68c+5Uw9qAobExSDN5pCnZW/j4fTeV2AMQc14ZE6v3+jMUDaYAF3sKjCYM6LXGcbRQH6G8MgNiMaPpIMXsFCo3egG5HqGQaa/SoGFVE7As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729689680; c=relaxed/simple;
	bh=djLyw7aYUk+qkqAn0atiZBaXa2GRGxYfWD4ZFmvmdsY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JLtkTNyCPlOmOLs4eCYsC2cKOER+TFwGhjNL0pp3vqhVn3pjLOrRO14U3gSPvPPIzirIVseYtcrDnw18UfVkqGHCXJsFFpL3v2OJ0gaPC030dYBv12VJBN7wZ7K0nvMTqofTQIBxf7gFx/Ys11VQT3Ce8Uge01QjT9y5Wsuw+3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcgEyH0S; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcgEyH0S"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a4d3b7077cso5014225ab.1
        for <iwd@lists.linux.dev>; Wed, 23 Oct 2024 06:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729689678; x=1730294478; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hIn+TlYTrJoVD1XDoEmtFlHWtnNeiCHFqm3HATKm+qM=;
        b=lcgEyH0S78QXHerDfhe0blr7OwMFXnEVIPnTYg4vz9dEvAZJDEt8biLzTiG/56C9Wf
         MtE5pr23ZZvdXN9ttSBBS1/S5UeB2Ni9x9j+QZ6oVsVhr7MEjyegtf2LWGAiSVprFVAD
         v8cLwzGPnxPAPvKVjgb+TZpmHGa4/R1pF7r4xNeJaMbQIS50o6aeUCBjAOLOKAd8t/Q8
         iTdPySF/WVRUA9IK/ZnvR73TDVac44cqABJGkRz5P4lEMQS+DNypmBA4UypCTQvuymom
         kf6pKReECOcSDZOJQfgXVDqz/1OIXJERyeuCWqevHXfte2GcvKnFWvUXb188HZp9CPq6
         PLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729689678; x=1730294478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hIn+TlYTrJoVD1XDoEmtFlHWtnNeiCHFqm3HATKm+qM=;
        b=d0Lg6wvpGbf1hY8Kq2R97S0sWXWYQqoZkqAUizaLQoj6ghthX6yX5R5jd5uItmplYo
         VhmCpH9AasNwgcKcmV8wY30DE9n4EhbhFQDXsieIUdR/wHwqs5X1jVNNAeYCHWVuWJH+
         ySDGyvg3/KXJ0awMHR3uI4HL+6xvhpC7qTkG2eI65WA+qrkmem+eh5YMbV9pTGBPsiM6
         RJ9twz4IcAPiNj8jS0f6bZflUe+L5kHLnp3Si+YGWgqEKsrFfHNd/uCtQEbufQ9qnK/Y
         MaqpmTjAo9coyS0/RbLNvqbDgJRaQGlEXiR9xpFQBUVcqfaGcj2cDgucpoP7uWFOjCnc
         y6qA==
X-Gm-Message-State: AOJu0Yxy2Ebek2bq3c3oeOyZTgRGe6IaBh5tXB9561OOgbJfin0np5IE
	jmMjauUfqBjhDDNq90y8BPAu7DLOkEgcgQc5MdCeWB8JYnWZ0/QZ8ie5qAli
X-Google-Smtp-Source: AGHT+IHv/qvqNxdxXjxcR1Haek4eie2wKkZAJaN4QCfWIRuGfdLfGLn71GBa3TWx8qHekXq42inaCw==
X-Received: by 2002:a05:6e02:1488:b0:3a0:52f9:9170 with SMTP id e9e14a558f8ab-3a4d5934a2bmr29368325ab.1.1729689677631;
        Wed, 23 Oct 2024 06:21:17 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeaafb1e0sm6830735a12.3.2024.10.23.06.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 06:21:17 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFC] network: fix OWE transition BSS selection
Date: Wed, 23 Oct 2024 06:21:11 -0700
Message-Id: <20241023132111.80231-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The selection loop was choosing an initial candidate purely for
use of the "fallback_to_blacklist" flag. But we have a similar
case with OWE transitional networks where we avoid the legacy
open network in preference for OWE:

/* Don't want to connect to the Open BSS if possible */
if (!bss->rsne)
	continue;

If no OWE network gets selected we may iterate all BSS's and end
the loop, which then returns NULL.

To fix this move the blacklist check earlier and still ignore any
BSS's in the blacklist. Also add a new flag in the selection loop
indicating an open network was skipped. If we then exhaust all
other BSS's we can return this candidate.
---
 src/network.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/src/network.c b/src/network.c
index 5a856fb4..dd09a98d 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1281,6 +1281,7 @@ struct scan_bss *network_bss_select(struct network *network,
 	struct l_queue *bss_list = network->bss_list;
 	const struct l_queue_entry *bss_entry;
 	struct scan_bss *candidate = NULL;
+	bool skipped_open = false;
 
 	for (bss_entry = l_queue_get_entries(bss_list); bss_entry;
 			bss_entry = bss_entry->next) {
@@ -1300,30 +1301,34 @@ struct scan_bss *network_bss_select(struct network *network,
 		if (!candidate)
 			candidate = bss;
 
+		/* check if temporarily blacklisted */
+		if (l_queue_find(network->blacklist, match_bss, bss))
+			continue;
+
+		if (blacklist_contains_bss(bss->addr))
+			continue;
+
 		/* OWE Transition BSS */
 		if (bss->owe_trans) {
 			/* Don't want to connect to the Open BSS if possible */
-			if (!bss->rsne)
+			if (!bss->rsne) {
+				skipped_open = true;
 				continue;
+			}
 
 			/* Candidate is not OWE, set this as new candidate */
 			if (!(candidate->owe_trans && candidate->rsne))
 				candidate = bss;
 		}
 
-		/* check if temporarily blacklisted */
-		if (l_queue_find(network->blacklist, match_bss, bss))
-			continue;
-
-		if (!blacklist_contains_bss(bss->addr))
-			return bss;
+		return candidate;
 	}
 
 	/*
 	 * No BSS was found, but if we are falling back to blacklisted BSS's we
 	 * can just use the first connectable candidate found above.
 	 */
-	if (fallback_to_blacklist)
+	if (fallback_to_blacklist || skipped_open)
 		return candidate;
 
 	return NULL;
-- 
2.34.1

