Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962C9199BA
	for <iwd@lists.linux.dev>; Wed, 24 Jan 2024 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706103610; cv=none; b=tOLTyVpkRofAuBa4MR24f+c1kA7IxmXi8jFZhRiNRj5gPTQnCYwbYuGRA2CsnkRJRVMDit2/qIa68EEhyVxPShT+81kcZ6f91VI3x7MKhUEbR+COg/jUK0jVC5d1uqddutH+71k/9bNg7wugmP4/+aJf4RiWO2EHxyn0uifzkiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706103610; c=relaxed/simple;
	bh=24D0PZsLFp59/l8YDmrcqW7GUUDopAe9DjMqaRG7X2s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MKFgZX4WDS8Y8baWNlCLJBRqNRBZYgDnqtXA2LYeSdw0dvqHIsd0G/EBaL8nyzyyZ2DjoRNz3DkPE7VY/QEO15WBlUnFukm9COOOUAaTGNnpE1u5BF5G8azDlCG4FA879RW067iRA+NDAPOcEp/ENdcO+SUOifqZrOdW2de6bTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glyMnatJ; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glyMnatJ"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6029e069e08so6184237b3.0
        for <iwd@lists.linux.dev>; Wed, 24 Jan 2024 05:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706103607; x=1706708407; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=95FKrAx90CxilkJ/M6gv4d89ixqRa0ufMbtb7PAA2WI=;
        b=glyMnatJjNnKr0yoY+V//S5tVIRNQlLro/wd6crK4x9GHDC/Q3/OrfXjvF7eHmDwX0
         hgFMuCQgsc+915aFO1XlezlL4Yopy8v5zq8GsCyaeNOBFzgYX32vQNB0LDloAHK8vtr2
         V0bvPG1EBoX+fshU+QPNjyt9MK5EsIpKi8bKRS0FiB0u5M1Bkm9vnfWoo7Hziezm9Idy
         fCA2Cz3d7LSoKO+CLzXTHGDUte56NvsgEce7jGo2/d7+JnNgwduwonxFs036ijY6bNnp
         l4zO3FO+/KysQDT4ILZAuYPb0fZkczsL7bZGeBNN+NubyS3fyJvqabkXKb39chqVx0lk
         pgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706103607; x=1706708407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=95FKrAx90CxilkJ/M6gv4d89ixqRa0ufMbtb7PAA2WI=;
        b=iXQZhfy6v69xkNPMarKjhffzNARQ/LlGgnbVS7flQSoJ0k5R7JZK+vPLPTcIFBSHuv
         VvtuglJIGrwBg7Mqo3WRcn/7rib3GZuRtFbSxTjDveSjjbyCTmWUOp7tPzYGsaybLYmK
         pm/Gt+MexwtM+v+evpKbTkWRuQ9+IQoTI+Cbjc3A2mEdbGADOl1ydjM8Wvq2rdCI2NwU
         jbVzTggjo+0Rf+8orP3bJnZevt7fxgJlBNN0ZUFn8xK6KP5MFaa+cLYBpSTqCXFEDbku
         ABOEgQ5KL43OHhKCjVlb/+iJYWJAOWCRnyoC/j+iQcscpMIjz9o7HVyZLY87aArZXcvQ
         f52w==
X-Gm-Message-State: AOJu0YyfoKZ9tUUhutRZ9ighssE3k30pcKXLBXOOgUsiswvKeXPwDlqp
	gcM2M3MBTokyWvXp17waHUMq1vN0DSBEe9ZlHrROqP7+0XriwAqHK/ppqLXldyg=
X-Google-Smtp-Source: AGHT+IFFtOGbwocTyk+5xqrQbT1OzfVpB26cpCurlKVptA9IzLzbkEfsh5irosgxHwyJ205vJLnSdA==
X-Received: by 2002:a05:6902:514:b0:dc2:2fa0:aad8 with SMTP id x20-20020a056902051400b00dc22fa0aad8mr604856ybs.106.1706103607256;
        Wed, 24 Jan 2024 05:40:07 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id ly4-20020a0562145c0400b0068688a2964asm3470456qvb.113.2024.01.24.05.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 05:40:06 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/4] knownnetworks: pass scan_bss to known_network_add_frequency
Date: Wed, 24 Jan 2024 05:39:58 -0800
Message-Id: <20240124134001.20453-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This prepares to store known frequencies sorted by BSS rank.
---
 src/knownnetworks.c | 6 +++---
 src/knownnetworks.h | 3 ++-
 src/network.c       | 6 +++---
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/src/knownnetworks.c b/src/knownnetworks.c
index 04ce74ec..f6284fdc 100644
--- a/src/knownnetworks.c
+++ b/src/knownnetworks.c
@@ -566,7 +566,7 @@ static bool known_frequency_match(const void *a, const void *b)
  * Adds a frequency to the 'known' set of frequencies that this network
  * operates on.  The list is sorted according to most-recently seen
  */
-int known_network_add_frequency(struct network_info *info, uint32_t frequency)
+int known_network_add_frequency(struct network_info *info, struct scan_bss *bss)
 {
 	struct known_frequency *known_freq;
 
@@ -574,10 +574,10 @@ int known_network_add_frequency(struct network_info *info, uint32_t frequency)
 		info->known_frequencies = l_queue_new();
 
 	known_freq = l_queue_remove_if(info->known_frequencies,
-					known_frequency_match, &frequency);
+					known_frequency_match, &bss->frequency);
 	if (!known_freq) {
 		known_freq = l_new(struct known_frequency, 1);
-		known_freq->frequency = frequency;
+		known_freq->frequency = bss->frequency;
 	}
 
 	l_queue_push_head(info->known_frequencies, known_freq);
diff --git a/src/knownnetworks.h b/src/knownnetworks.h
index e8ffac0b..9f81e308 100644
--- a/src/knownnetworks.h
+++ b/src/knownnetworks.h
@@ -114,7 +114,8 @@ struct network_info *known_networks_find(const char *ssid,
 
 struct scan_freq_set *known_networks_get_recent_frequencies(
 						uint8_t num_networks_tosearch);
-int known_network_add_frequency(struct network_info *info, uint32_t frequency);
+int known_network_add_frequency(struct network_info *info,
+				struct scan_bss *bss);
 void known_network_frequency_sync(struct network_info *info);
 
 uint32_t known_networks_watch_add(known_networks_watch_func_t func,
diff --git a/src/network.c b/src/network.c
index 4723334e..81315746 100644
--- a/src/network.c
+++ b/src/network.c
@@ -807,7 +807,7 @@ static void add_known_frequency(void *data, void *user_data)
 	struct scan_bss *bss = data;
 	struct network_info *info = user_data;
 
-	known_network_add_frequency(info, bss->frequency);
+	known_network_add_frequency(info, bss);
 }
 
 void network_set_info(struct network *network, struct network_info *info)
@@ -1094,7 +1094,7 @@ bool network_bss_add(struct network *network, struct scan_bss *bss)
 		return false;
 
 	if (network->info)
-		known_network_add_frequency(network->info, bss->frequency);
+		known_network_add_frequency(network->info, bss);
 
 	/* Done if BSS is not HS20 or we already have network_info set */
 	if (!bss->hs20_capable)
@@ -1131,7 +1131,7 @@ bool network_bss_update(struct network *network, struct scan_bss *bss)
 
 	/* Sync frequency for already known networks */
 	if (network->info) {
-		known_network_add_frequency(network->info, bss->frequency);
+		known_network_add_frequency(network->info, bss);
 		known_network_frequency_sync(network->info);
 	}
 
-- 
2.34.1

