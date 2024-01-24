Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D459E199BA
	for <iwd@lists.linux.dev>; Wed, 24 Jan 2024 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706103612; cv=none; b=VLsLeQrWuyB9mRU5IBEoLb71oaibD7s4IiKml52FHmEhDJcvxkRXKzXVJxMhzNa/06FSDju1XpkUKRSzvAQHve5sUlfXkzIK/wojdrjjbEpA2f6ue+lPmPafjuTCYfOAeh5rrgfrYwmBN7wPmFhHOck3iRdB/La3R9pU6CjrQJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706103612; c=relaxed/simple;
	bh=b2hyvLV4lCyvBDqXs8ONm+gukrkbS04d+igpwc055/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JFoRwnSu+ZGzUJt8w1cQalEBCo0pbOOTJcKl+wQe9XgwHit4wOijBtoWDn8ArGs7TjSsHiil3gbauxgezxAdZIdpYJIabsf9CqPl2fCxia8/1f8tYdn0zF8e91cySeKlbMroN7Nem0i9vO9vEG9Y6x9muPixUIQhAdDznn8X850=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEYHpccO; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEYHpccO"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6853f6ff6e1so27587566d6.2
        for <iwd@lists.linux.dev>; Wed, 24 Jan 2024 05:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706103609; x=1706708409; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lepWR7JYPDHeydw5l0Odqk7+dLy/r9WpLDTU/O1ZBcU=;
        b=VEYHpccOmrvdDDw5eohMcCl5UUS7vzcalq3/aCJU8D/fU0FA6dL1yUxq19PwclEwCR
         DJ48rG6mtrDbEuD5qA3krtKrEFw4aCMHIF0jrbD0FL+Y8S0/8LQcInn3isCa2W1Qsz2V
         l6DzPZO0ModNNyFsPtP9/GbW8PMSM1bAjV7gx6qCAMRNz/owQtzUiJZAAOdLr+U2v8fh
         3QsNXpJYwZEjboh7NWQm3Q4SZnudEmY+cm0gaQF4KdPfm754mIrpfLyzqiO8xwYPMI0x
         bx7avlmWrq4iHF47aSyGBvBOarzHhAP0X2kAk3v2RsP6zaCXj/JZyE+rKhnTnAy6KklK
         +Q1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706103609; x=1706708409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lepWR7JYPDHeydw5l0Odqk7+dLy/r9WpLDTU/O1ZBcU=;
        b=c9HeyBlQZjaHQF108cSCvszytsRlM97y/qEBzaZSr7DfKNvT9Fr1d14FkLIzl/yjPv
         OW3dxhYcA/KlcNcfgonuxXyTe0634zd6zkRd4LuYdYQdfxdsu+BJnxMYoATZgAbq2UwV
         y0CwDidvC11jeORLpHEGCF3xlQ15he9XLWvM3nIuwDsyPkq93zsNA8aTuh3lh2+g6bsJ
         MpnubxHN/rK8XaESC8gB679qhpj+S8Y9Bk6BxJbGaqtiPIqCCaeCqJHeLZ20aFhcbNp/
         y3cNxoDBo9A7hxWD9lbNVOb9RV9L+QE5T6tZ29xTWZ619EMhkdRci4UYULt+4qTCx0ay
         u7Rw==
X-Gm-Message-State: AOJu0YxwpuoyCqw4KiHBPbGX9nr7NuQL9diJZk7iiCfm/9jGgaZqVift
	RI78bSoN53kdn7O9S5K7NYIP007QgvGA50Hv5du4kF59efIUVjV4KItNPuHcj2E=
X-Google-Smtp-Source: AGHT+IEFld+sAzpu+5Qxle5lq2+D/AzjToek6V3w2nLHhlYjlg7FNFnlcKUhyq4a5xDCWIwjr+GFlw==
X-Received: by 2002:ad4:5b85:0:b0:686:abae:eb69 with SMTP id 5-20020ad45b85000000b00686abaeeb69mr1736924qvp.130.1706103609269;
        Wed, 24 Jan 2024 05:40:09 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id ly4-20020a0562145c0400b0068688a2964asm3470456qvb.113.2024.01.24.05.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 05:40:08 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/4] station: knownnetworks: limit quick scans to 5 freqs per network
Date: Wed, 24 Jan 2024 05:40:00 -0800
Message-Id: <20240124134001.20453-3-prestwoj@gmail.com>
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

In very large network deployments there could be a vast amount of APs
which could create a large known frequency list after some time once
all the APs are seen in scan results. This then increases the quick
scan time significantly, in the very worst case (but unlikely) just
as long as a full scan.

To help with this support in knownnetworks was added to limit the
number of frequencies per network. Station will now only get 5
recent frequencies per network making the maximum frequencies 25
in the worst case (~2.5s scan).

The magic values are now defines, and the recent roam frequencies
was also changed to use this define as well.
---
 src/knownnetworks.c |  9 ++++++---
 src/knownnetworks.h |  3 ++-
 src/station.c       | 10 ++++++++--
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/src/knownnetworks.c b/src/knownnetworks.c
index 6e549e02..fe0fce09 100644
--- a/src/knownnetworks.c
+++ b/src/knownnetworks.c
@@ -518,7 +518,8 @@ struct network_info *known_networks_find(const char *ssid,
 }
 
 struct scan_freq_set *known_networks_get_recent_frequencies(
-						uint8_t num_networks_tosearch)
+						uint8_t num_networks_tosearch,
+						uint8_t freqs_per_network)
 {
 	/*
 	 * This search function assumes that the known networks are always
@@ -530,7 +531,7 @@ struct scan_freq_set *known_networks_get_recent_frequencies(
 	const struct l_queue_entry *freq_entry;
 	struct scan_freq_set *set;
 
-	if (!num_networks_tosearch)
+	if (!num_networks_tosearch || !freqs_per_network)
 		return NULL;
 
 	set = scan_freq_set_new();
@@ -540,10 +541,12 @@ struct scan_freq_set *known_networks_get_recent_frequencies(
 				network_entry = network_entry->next,
 						num_networks_tosearch--) {
 		const struct network_info *network = network_entry->data;
+		uint8_t freqs_found = 0;
 
 		for (freq_entry = l_queue_get_entries(
 						network->known_frequencies);
-				freq_entry; freq_entry = freq_entry->next) {
+				freq_entry && freqs_found < freqs_per_network;
+				freq_entry = freq_entry->next, freqs_found++) {
 			const struct known_frequency *known_freq =
 							freq_entry->data;
 
diff --git a/src/knownnetworks.h b/src/knownnetworks.h
index 36106501..108f334e 100644
--- a/src/knownnetworks.h
+++ b/src/knownnetworks.h
@@ -114,7 +114,8 @@ struct network_info *known_networks_find(const char *ssid,
 						enum security security);
 
 struct scan_freq_set *known_networks_get_recent_frequencies(
-						uint8_t num_networks_tosearch);
+						uint8_t num_networks_tosearch,
+						uint8_t freqs_per_network);
 int known_network_add_frequency(struct network_info *info,
 				struct scan_bss *bss);
 void known_network_frequency_sync(struct network_info *info);
diff --git a/src/station.c b/src/station.c
index a6442d3e..1b34b956 100644
--- a/src/station.c
+++ b/src/station.c
@@ -64,6 +64,9 @@
 #include "src/eap-tls-common.h"
 #include "src/storage.h"
 
+#define STATION_RECENT_NETWORK_LIMIT	5
+#define STATION_RECENT_FREQS_LIMIT	5
+
 static struct l_queue *station_list;
 static uint32_t netdev_watch;
 static uint32_t mfp_setting;
@@ -1434,7 +1437,9 @@ static int station_quick_scan_trigger(struct station *station)
 		return -EAGAIN;
 	}
 
-	known_freq_set = known_networks_get_recent_frequencies(5);
+	known_freq_set = known_networks_get_recent_frequencies(
+						STATION_RECENT_NETWORK_LIMIT,
+						STATION_RECENT_FREQS_LIMIT);
 	if (!known_freq_set)
 		return -ENODATA;
 
@@ -2757,7 +2762,8 @@ static int station_roam_scan_known_freqs(struct station *station)
 	const struct network_info *info = network_get_info(
 						station->connected_network);
 	struct scan_freq_set *freqs = network_info_get_roam_frequencies(info,
-					station->connected_bss->frequency, 5);
+					station->connected_bss->frequency,
+					STATION_RECENT_FREQS_LIMIT);
 	int r = -ENODATA;
 
 	if (!freqs)
-- 
2.34.1

