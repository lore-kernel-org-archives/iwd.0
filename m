Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681D225541
	for <iwd@lists.linux.dev>; Wed, 20 Dec 2023 13:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1IAxffI"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3ba1be5ad0aso3828330b6e.0
        for <iwd@lists.linux.dev>; Wed, 20 Dec 2023 05:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703077931; x=1703682731; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okalQclEjrZbYfXcH/b2xNsErvaxrMNmJdqBPJuStic=;
        b=Y1IAxffIS0w/a2eNTmXXQSzHFtvvPMngOe/w7tW5fFFK6M9SdaRf/sO0SjUyieWIfq
         fYoZfMMzFd31ZzfK7tGyopeUZ0ffl5ozVdbrt7wt2WSQ8MKyvZR1Jnf8eJO0yhHBf5fW
         sIRAqmZihPBJFTCtR0TVidVDLAFNVj4SjUCL2t6qHB6m50KPfMhkTGV9oIZvH8LVbWVG
         VlpJ82RfwqXqkpAg4ze9hUdOhOLLgNI5QDhStziXhv8Pm512WQBwyoZYl88FfCrYuhRV
         ITv8Ax6YMsdLkJxgZBSt9oqI0J5YW0XVChywfkEL4Sq4ck539HfrdP86TTl1sY61+Rjo
         WLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703077931; x=1703682731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okalQclEjrZbYfXcH/b2xNsErvaxrMNmJdqBPJuStic=;
        b=h6i75RWwqHaL7BZhwXMaMUK8ENN9E3mmtYKMqiUK4+8txr3x+HSeqpKpPnnU6uc35d
         asoqyd/nkI9fusVlo274/lR9I4OiOF0A4u4V5aGP1zr+oTJYcn1l1m4y2ijikI1ECvwA
         Uf2xmcXHA6Dw989w7QI3B3Ir5QtQ8HjoHX+n3ZCAWZzhaYFjFsCAk1lIreHdnv2bfS5/
         38XVW42JJyGWxDNdESDh3kFejxHHZomaxSchWOSmsbFF1XT9XxOpSQJ94EW8R6V2WpAq
         DgS8QzoCTa7h7KTvVSZMeRqjRq2SEPQpV8iwPNJ4Sboe1+buamWUOlT1eEaqJH+5xzH8
         GexA==
X-Gm-Message-State: AOJu0YwJcNZ96yfqLIYXo4M6Ydd2uw2iFCDTCMc3r00Ty69tx+6k+jXw
	o6qJT6RMZQaA08Kod+h6F67NAOGGSYM=
X-Google-Smtp-Source: AGHT+IH8JeXjWy5INETsynjepva6lo7F5L1O1viJ+53vMs+VrwULjJsLXNRW9vyUkmCWaCjzwIMEVg==
X-Received: by 2002:a05:6808:2227:b0:3bb:6a4d:deaf with SMTP id bd39-20020a056808222700b003bb6a4ddeafmr2105445oib.83.1703077931344;
        Wed, 20 Dec 2023 05:12:11 -0800 (PST)
Received: from LOCLAP699.barrett-olive-branch.locus ([50.222.209.222])
        by smtp.gmail.com with ESMTPSA id j15-20020aca170f000000b003ba3a9c553esm2109591oii.30.2023.12.20.05.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 05:12:11 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/7] knownnetworks: add known_network_add_connected_frequency
Date: Wed, 20 Dec 2023 05:11:55 -0800
Message-Id: <20231220131200.267489-3-prestwoj@gmail.com>
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

This should be called when BSS is connected/roamed to which will
insert the frequency ahead of entries which were only seen in scan
results.

Providing this and the 'seen' variant sets up the frequency list
into two adjacent sections:
  [Most recently used]...[Most recently seen]

Doing this will allow scanning to be more optimized and limit the
number of frequencies while prefering BSS's that have been connected
to prior.

Note that this list format is not synced to the file system.
Frequencies will be synced in the order of this list but not
containing the 'connected' bit. When IWD restarts this information
will be lost, but the list is still sorted on disk in a better state
than it was prior.
---
 src/knownnetworks.c | 59 ++++++++++++++++++++++++++++++++++++++++++++-
 src/knownnetworks.h |  3 +++
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/src/knownnetworks.c b/src/knownnetworks.c
index eac6c66b..e44109fd 100644
--- a/src/knownnetworks.c
+++ b/src/knownnetworks.c
@@ -562,15 +562,70 @@ static bool known_frequency_match(const void *a, const void *b)
 	return known_freq->frequency == *frequency;
 }
 
+static int known_frequency_compare(const void *a, const void *b,
+					void *user_data)
+{
+	const struct known_frequency *ka = a;
+
+	/*
+	 * Only meant to be used to insert 'seen' frequencies. Any existing
+	 * entry that has 'connected' set should preceed an entry that was
+	 * only seen.
+	 */
+	if (ka->connected)
+		return -1;
+
+	/*
+	 * Otherwise, insert immediately after the last 'connected' entry,
+	 * i.e. the most recently seen
+	 */
+	return 1;
+}
+
 /*
  * Adds a frequency to the 'known' set of frequencies that this network
- * operates on.  The list is sorted according to most-recently seen
+ * operates on. Frequencies added here will follow frequencies which have been
+ * connected to and inserted according to most-recently seen
  */
 int known_network_add_seen_frequency(struct network_info *info,
 					uint32_t frequency)
 {
 	struct known_frequency *known_freq;
 
+	if (!info->known_frequencies)
+		info->known_frequencies = l_queue_new();
+
+	known_freq = l_queue_find(info->known_frequencies,
+					known_frequency_match, &frequency);
+	/*
+	 * If no match, create a new one.
+	 * If connected to frequency before leave that entry in place
+	 */
+	if (!known_freq) {
+		known_freq = l_new(struct known_frequency, 1);
+		known_freq->frequency = frequency;
+	} else if (known_freq->connected)
+		return 0;
+
+	l_queue_remove(info->known_frequencies, known_freq);
+
+	/* insert the entry immediately after the last 'connected' entry */
+	l_queue_insert(info->known_frequencies, known_freq,
+			known_frequency_compare, NULL);
+
+	return 0;
+}
+
+/*
+ * Adds a frequency to the known set of frequencies that this network operates
+ * on. Frequencies added here are assumed to be most recently used and inserted
+ * at the head of the queue.
+ */
+int known_network_add_connected_frequency(struct network_info *info,
+						uint32_t frequency)
+{
+	struct known_frequency *known_freq;
+
 	if (!info->known_frequencies)
 		info->known_frequencies = l_queue_new();
 
@@ -581,6 +636,8 @@ int known_network_add_seen_frequency(struct network_info *info,
 		known_freq->frequency = frequency;
 	}
 
+	known_freq->connected = true;
+
 	l_queue_push_head(info->known_frequencies, known_freq);
 
 	return 0;
diff --git a/src/knownnetworks.h b/src/knownnetworks.h
index d404b161..644e713f 100644
--- a/src/knownnetworks.h
+++ b/src/knownnetworks.h
@@ -96,6 +96,7 @@ typedef void (*known_networks_destroy_func_t)(void *user_data);
 
 struct known_frequency {
 	uint32_t frequency;
+	bool connected : 1;
 };
 
 void __network_config_parse(const struct l_settings *settings,
@@ -116,6 +117,8 @@ struct scan_freq_set *known_networks_get_recent_frequencies(
 						uint8_t num_networks_tosearch);
 int known_network_add_seen_frequency(struct network_info *info,
 					uint32_t frequency);
+int known_network_add_connected_frequency(struct network_info *info,
+					uint32_t frequency);
 void known_network_frequency_sync(struct network_info *info);
 
 uint32_t known_networks_watch_add(known_networks_watch_func_t func,
-- 
2.34.1

