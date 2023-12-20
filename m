Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812092554B
	for <iwd@lists.linux.dev>; Wed, 20 Dec 2023 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAzf1LSc"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3ba46a19689so4576167b6e.3
        for <iwd@lists.linux.dev>; Wed, 20 Dec 2023 05:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703077935; x=1703682735; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXM9fDGsJhcvLM2r6QHQn6cB2B8VNSaSk3keVtia3zo=;
        b=hAzf1LScxUDuzvv401xdD5u2ekxHIMGhMDg+cSJHUq1HbCgR76ZzfqCPFvG858oJc2
         oN6sPMwjpa5EW9gtsHv4E/tY8uSZpc2R842sLJ7P4uk2/HKxsTzN6N+eSPk6oK81rw/q
         EHhOmu3AyjcZxkXTe3Xxxu4cqIsWWRRhUCOQ6PL5pcUgp0eVSSckEVyt0lEiPmv+W52z
         muozqKcqpN8xXlM/Jou7+DSmJyhifnaAtjC1ydPFS81ytjdxj8JaEHwKSdxnJwwjV7qL
         VPJNk4SqOj73wf5QiIIRHfD6n2oYDZqaR3Dl3u523xN3XfnnpVSoKcKZUvey9kCt21cI
         Km/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703077935; x=1703682735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXM9fDGsJhcvLM2r6QHQn6cB2B8VNSaSk3keVtia3zo=;
        b=D3rZRUORKwxo7qwZfq6rpi5YIltlCH96bC4IFisUXf9RjDiWDELqGU1eUToTgxWUe6
         quRJ8TCgnnZUVi7GYabpiRstgohUhU2erID6svq0IepxQf5nRf8YewtQsYY9j+VMu7F/
         uGJrRVWvUhpYSEAVVJGbVPESZZggPxSaCBvsQprF5s5a2OFnNlJEUma/13I8QHyy7xuO
         b5C8wMC7atOQjgNUzFDt5JJEHGM//avtmn05OCJ7LCkM24nbqNwrYSwKjoabyY6OzCF7
         Td6Tj2EZOFqigZ3Yaw7AlYUvG5T3hzCzfM1ympt7FrI6Jqaoh1LBSU9sGtUdwO6dzE62
         vZ1Q==
X-Gm-Message-State: AOJu0YwPxoQHoQZoGXR9otQdZcNoiHy/2iUmtIYVIV/k9ivxfYYogLAr
	tfbPeXoccJ0bprhy4Cq0w7D1tx/yrVk=
X-Google-Smtp-Source: AGHT+IFFmeBbA9zk+tGcOX0KHvjnZvmCHb73NLfdWNY4X/NZU7nBvRjB8WMOByruKUtirGqD583U1g==
X-Received: by 2002:a05:6808:22a4:b0:3b8:44e3:dfda with SMTP id bo36-20020a05680822a400b003b844e3dfdamr23558857oib.3.1703077935464;
        Wed, 20 Dec 2023 05:12:15 -0800 (PST)
Received: from LOCLAP699.barrett-olive-branch.locus ([50.222.209.222])
        by smtp.gmail.com with ESMTPSA id j15-20020aca170f000000b003ba3a9c553esm2109591oii.30.2023.12.20.05.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 05:12:15 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 7/7] knownnetworks: limit 5 recent frequencies per network
Date: Wed, 20 Dec 2023 05:12:00 -0800
Message-Id: <20231220131200.267489-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220131200.267489-1-prestwoj@gmail.com>
References: <20231220131200.267489-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since this is meant to be used for quick/roam scans we should be
putting a cap on the frequencies scanned. For large networks with
many BSS's this could end up scanning quite a few frequencies which
isn't very 'quick' as it should be.

Since the known frequency list is now sorted in most recently used
order we can grab the first 5 frequencies per network and be
somewhat confident that this will result in a BSS to connect to.
---
 src/knownnetworks.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/knownnetworks.c b/src/knownnetworks.c
index e44109fd..ecdd79a1 100644
--- a/src/knownnetworks.c
+++ b/src/knownnetworks.c
@@ -540,10 +540,12 @@ struct scan_freq_set *known_networks_get_recent_frequencies(
 				network_entry = network_entry->next,
 						num_networks_tosearch--) {
 		const struct network_info *network = network_entry->data;
+		uint8_t num_freqs = 5;
 
 		for (freq_entry = l_queue_get_entries(
 						network->known_frequencies);
-				freq_entry; freq_entry = freq_entry->next) {
+				freq_entry && num_freqs;
+				freq_entry = freq_entry->next, num_freqs--) {
 			const struct known_frequency *known_freq =
 							freq_entry->data;
 
-- 
2.34.1

