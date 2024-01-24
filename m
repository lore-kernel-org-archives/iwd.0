Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5282177F14
	for <iwd@lists.linux.dev>; Wed, 24 Jan 2024 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706103615; cv=none; b=puORob+/vXwGtaj026l75QlfDBGEKxOdDkuxeZfnh0sfQ6sBvoQKRAJE4cDC0/yfkCdbnZAoANZB5guoNtrER3iwUCM08+zY78F6ZeUUrBW1/GGgTvXj/Gh8IkSk7GkTLlacYNvwi1YNjR4mIDTMtbXdWdRbti8/No2YwdJzdo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706103615; c=relaxed/simple;
	bh=IOpScdZjK56QxyeEq6eoyt2MdkTVz7Uyww9zTxu21fY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cc+Wg+8XZ8M+q1nSal0fSwhb/cbfMoGDtPExyDaMLKRcgwFvSajGxaMfqBTDCS2z78kIBoiuxw/lx4zxBBiH+WyjM4/vddqrQwzCE7lMBs2XZ6a3tMxpUgmjqGk2D9q8dqxOl2wm1+89TDmpuWGj35anuqYe6K4wmqlURWfJyjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9Ex0mOZ; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9Ex0mOZ"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-db3a09e96daso4694467276.3
        for <iwd@lists.linux.dev>; Wed, 24 Jan 2024 05:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706103613; x=1706708413; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mICSpAbWMPURceODAsw5vEUXmuHptWdKhLHvVRLjtlE=;
        b=L9Ex0mOZCaS4cmeyebfIRA1rshYvI00/jROVYqgLduGyIHKIOGSTvyU9yAp5c8oYou
         sjBgfY0+nhAEGD5fdSAW+LRyuhEVR4RpKiRvqVOdx+H/kt2VDDJrLz1tbJ3pFyBbE+Su
         6WlbFGtY2lMCOshf9Akn3lKKYxPrmD8wBdRL4lhCaGh+ftSSK30rr7t+xckUyprERPLX
         IG7UW8pPMvKE9s+xKr7RBvr+/nMA6eQtkolo+3bhJJalRkhYYCFyuI707gqLQebk0ACr
         CmZ9iZ3mOtl8e/kPQnV8JpuKFSoCCbP3KlWCGUZ3ICn+re0967BF5rD896agC9LemEfc
         hCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706103613; x=1706708413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mICSpAbWMPURceODAsw5vEUXmuHptWdKhLHvVRLjtlE=;
        b=nNgpHSFFhoco4KqB+y9VgK29qNsxh58ttTbUCH5LSLltaI+KSDUorviGwvij64nizm
         I9U1Hg+5sBvFYf4pl0foScVLOT+3a12wJPgmjVVuwZDYUvbm2VmvOMOc2TECjKZIjJTC
         FgE4urHPYd0iQsjtFFieMV1fHKZCZ0pqROW8pY9D9ODyNdk0meiUhj71whYAHbToc9Rz
         F2vyjin1W/WxZYo9dbEA2g27ziX6cn9W7mNtCxwL1FShXgJBt/v5lGmA3Aso78/tHA4j
         OVp5jc5y3cDwWdxIIitZ/4KR54l3Qlwkb0XQbm6TSAcYTql/bbCpfltKdCU4crX5+XY0
         0Krw==
X-Gm-Message-State: AOJu0Yw6+I0UUagFQ0aiEBQfyCQExKEoB5LfA+v8w5sGLzqZbBMFana/
	gPKaibZLAc5BMGX7PitENgaQd+zJp3xznV6gZ0GVRYuhFuaSksokQEkIdZjfssQ=
X-Google-Smtp-Source: AGHT+IGxytBYUThZWmZYeJXSoSBlFmBCjyDzki+XWCXT2zs2Am0xUGJ07ftzWKfQ6R8RrzHHToUgCQ==
X-Received: by 2002:a25:448a:0:b0:dc3:5468:b385 with SMTP id r132-20020a25448a000000b00dc35468b385mr488573yba.95.1706103608262;
        Wed, 24 Jan 2024 05:40:08 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id ly4-20020a0562145c0400b0068688a2964asm3470456qvb.113.2024.01.24.05.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 05:40:07 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/4] knownnetworks: sort known frequencies by BSS rank
Date: Wed, 24 Jan 2024 05:39:59 -0800
Message-Id: <20240124134001.20453-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124134001.20453-1-prestwoj@gmail.com>
References: <20240124134001.20453-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently a quick scan uses the entire known frequency list so
ordering really doesn't matter but improvements will be made here
to make quick scans "quicker" for large network deployments (with
many known frequencies).

To prepare for this the known frequency list has been changed to
be sorted by BSS rank rather than most recently seen. This makes
a lot more sense because IWD should prefer to scan frequencies
that had higher ranked BSS's, not just frequencies that were scanned
last on the most recent scan.

As far as the disk sync goes the ranking is not included, but
ordering is. This really isn't a limitation because when IWD starts
up there isn't any guarantee its in the same physical location so
old scan ranks are likely not valid anymore. The first set of scans
will begin replacing the frequencies loaded from disk.
---
 src/knownnetworks.c | 16 ++++++++++++++--
 src/knownnetworks.h |  1 +
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/src/knownnetworks.c b/src/knownnetworks.c
index f6284fdc..6e549e02 100644
--- a/src/knownnetworks.c
+++ b/src/knownnetworks.c
@@ -562,9 +562,19 @@ static bool known_frequency_match(const void *a, const void *b)
 	return known_freq->frequency == *frequency;
 }
 
+static int known_frequency_compare(const void *a, const void *b,
+					void *user_data)
+{
+	const struct known_frequency *kf_a = a;
+	const struct known_frequency *kf_b = b;
+
+	return (kf_b->rank > kf_a->rank) ? 1 : -1;
+}
+
 /*
  * Adds a frequency to the 'known' set of frequencies that this network
- * operates on.  The list is sorted according to most-recently seen
+ * operates on.  The list is sorted according to the rank of the BSS on that
+ * frequency.
  */
 int known_network_add_frequency(struct network_info *info, struct scan_bss *bss)
 {
@@ -578,9 +588,11 @@ int known_network_add_frequency(struct network_info *info, struct scan_bss *bss)
 	if (!known_freq) {
 		known_freq = l_new(struct known_frequency, 1);
 		known_freq->frequency = bss->frequency;
+		known_freq->rank = bss->rank;
 	}
 
-	l_queue_push_head(info->known_frequencies, known_freq);
+	l_queue_insert(info->known_frequencies, known_freq,
+			known_frequency_compare, NULL);
 
 	return 0;
 }
diff --git a/src/knownnetworks.h b/src/knownnetworks.h
index 9f81e308..36106501 100644
--- a/src/knownnetworks.h
+++ b/src/knownnetworks.h
@@ -96,6 +96,7 @@ typedef void (*known_networks_destroy_func_t)(void *user_data);
 
 struct known_frequency {
 	uint32_t frequency;
+	uint16_t rank;
 };
 
 void __network_config_parse(const struct l_settings *settings,
-- 
2.34.1

