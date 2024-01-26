Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DD02230C
	for <iwd@lists.linux.dev>; Fri, 26 Jan 2024 20:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706300572; cv=none; b=M4xMK9kYr7ud5opC/vuuY8JWgNR+9wmw3Cx+WzwvouA9ieoYWhaSCjJ1GmXPx5f84jGQKcUK1dmKXMvbZKp46fRMLfuyCjeUQ0DF1zMP5Z98KrKdyL3LMtL55F8nnBXcaJWozbL85jXwsOjj5EEPaASxkL5yhaOZ6J42QQ7OjYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706300572; c=relaxed/simple;
	bh=p/qBiaP2+r7lYpiw3QH9+MkPCM1LfllQwTKB4AKRoMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fTWWcYgbHxYJ3n+3zT2M2FZU5jDF165pHCKf/UE/rDQUjIARG8c0BXQV39U5DCO5BGRJPErct4LjuN4wXTow/M1kS3iF7/6w5oITI+NbFJsSF27hfKtwUZu5VWWZEQky5CWS0x2Xd7IZE4WBm+RdUEkL2lwMzCHLh5kWhqCH2kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qd5941J6; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qd5941J6"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4298e866cd6so4887191cf.0
        for <iwd@lists.linux.dev>; Fri, 26 Jan 2024 12:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706300570; x=1706905370; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFC3wtQTOlWSOFKpdLhiIlAPgdq6Lb2+B3xA3bc0LG8=;
        b=Qd5941J60qrHXveGpBdbbf+p40DMw5Y1E4T7fAbi2WKZeGFhyHO8ib67+9SmA+8M3A
         jLWk8giwLdmj3fQieTKKq50y+D3ZD5STn2KErtZ6u+T+E6qKs/G1f3NqUGvHVyG7+z9j
         5M1ad6HV2RjGvRmswraZYRqcHywD2QaaINIxQrdSa76SW8lzhqKBjpgXYjzB4clowG6g
         Is6RRGptbauweFa8dESy2mSQYUbYycdtZQC/eYx56idaqCMQb5waZ21PwCRGAsszwdfc
         8jPyBccSwXfcdPpV3VpqV4AmmYPuf9ziO2PbQNNBkJoaXy0vNi3po6SVvN0Xe7Se5dnk
         y0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706300570; x=1706905370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFC3wtQTOlWSOFKpdLhiIlAPgdq6Lb2+B3xA3bc0LG8=;
        b=MygCIR6oI4wWLBM2cfzaQrlUatV1LEAN459e0vJy3KR5fw3TCEGe8FKOC8pNQ11C6J
         s/3MeHKNLavA6WtXRe4TrL9f5+3gnMsQgR25Lk7y2RSxV13WIBsRitxHHl8cFQZDdzgc
         sdcnqtdTRoyWHwoKQUL14c8MQxa1LFYjZa02+Q2hTekHD6IdrjKeZCFdWsurytL6Lokh
         Uy5C7vXMgD/7fBIa5KR7O/hFSzFuTpgds3lrTzaiqTH56qCeQ28OmzzYgEDCpC1nbdpX
         POYoksaZqMFsnxaxJzjfzu7pizq+YqZlEPOx5LU6Ggq4SZ8sMR2yFeyx5s7Fixyr3mdK
         ATqA==
X-Gm-Message-State: AOJu0Yxx/1qV4EKL7eYDcQao8HOKH6o61UreiOflUJBl4kz3icjLUowY
	JuI5N0m3DyIRXpwrR4GE6TWxhWusGfUPC+bpNZ5oVTgd0oqMoeo9/MvR4+oJOCc=
X-Google-Smtp-Source: AGHT+IGoKK3K5mKJV9+sLIZNZRwgqmNHvwwb1UPLvO2s8nOECa01Vh+ZEEMYn2yAPmcYBC+oGSKLxg==
X-Received: by 2002:a05:622a:648:b0:42a:5a41:abd2 with SMTP id a8-20020a05622a064800b0042a5a41abd2mr626486qtb.55.1706300569708;
        Fri, 26 Jan 2024 12:22:49 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id fe3-20020a05622a4d4300b0042a25f3950esm826463qtb.75.2024.01.26.12.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 12:22:49 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 3/4] station: knownnetworks: limit quick scans to 5 freqs per network
Date: Fri, 26 Jan 2024 12:22:42 -0800
Message-Id: <20240126202243.91947-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126202243.91947-1-prestwoj@gmail.com>
References: <20240126202243.91947-1-prestwoj@gmail.com>
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
 src/knownnetworks.c | 30 +++++++++++++++++++-----------
 src/knownnetworks.h |  6 ++++--
 src/station.c       | 10 ++++++++--
 3 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/src/knownnetworks.c b/src/knownnetworks.c
index 04ce74ec..fc810057 100644
--- a/src/knownnetworks.c
+++ b/src/knownnetworks.c
@@ -517,8 +517,23 @@ struct network_info *known_networks_find(const char *ssid,
 	return l_queue_find(known_networks, network_info_match, &query);
 }
 
+static void known_network_append_frequencies(const struct network_info *info,
+						struct scan_freq_set *set,
+						uint8_t max)
+{
+	const struct l_queue_entry *entry;
+
+	for (entry = l_queue_get_entries(info->known_frequencies); entry && max;
+					entry = entry->next, max--) {
+		const struct known_frequency *known_freq = entry->data;
+
+		scan_freq_set_add(set, known_freq->frequency);
+	}
+}
+
 struct scan_freq_set *known_networks_get_recent_frequencies(
-						uint8_t num_networks_tosearch)
+						uint8_t num_networks_tosearch,
+						uint8_t freqs_per_network)
 {
 	/*
 	 * This search function assumes that the known networks are always
@@ -527,10 +542,9 @@ struct scan_freq_set *known_networks_get_recent_frequencies(
 	 * list.
 	 */
 	const struct l_queue_entry *network_entry;
-	const struct l_queue_entry *freq_entry;
 	struct scan_freq_set *set;
 
-	if (!num_networks_tosearch)
+	if (!num_networks_tosearch || !freqs_per_network)
 		return NULL;
 
 	set = scan_freq_set_new();
@@ -541,14 +555,8 @@ struct scan_freq_set *known_networks_get_recent_frequencies(
 						num_networks_tosearch--) {
 		const struct network_info *network = network_entry->data;
 
-		for (freq_entry = l_queue_get_entries(
-						network->known_frequencies);
-				freq_entry; freq_entry = freq_entry->next) {
-			const struct known_frequency *known_freq =
-							freq_entry->data;
-
-			scan_freq_set_add(set, known_freq->frequency);
-		}
+		known_network_append_frequencies(network, set,
+							freqs_per_network);
 	}
 
 	return set;
diff --git a/src/knownnetworks.h b/src/knownnetworks.h
index e8ffac0b..741d42ed 100644
--- a/src/knownnetworks.h
+++ b/src/knownnetworks.h
@@ -113,8 +113,10 @@ struct network_info *known_networks_find(const char *ssid,
 						enum security security);
 
 struct scan_freq_set *known_networks_get_recent_frequencies(
-						uint8_t num_networks_tosearch);
-int known_network_add_frequency(struct network_info *info, uint32_t frequency);
+						uint8_t num_networks_tosearch,
+						uint8_t freqs_per_network);
+int known_network_add_frequency(struct network_info *info,
+				uint32_t frequency);
 void known_network_frequency_sync(struct network_info *info);
 
 uint32_t known_networks_watch_add(known_networks_watch_func_t func,
diff --git a/src/station.c b/src/station.c
index b186c505..8a5f4e18 100644
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
@@ -1438,7 +1441,9 @@ static int station_quick_scan_trigger(struct station *station)
 		return -EAGAIN;
 	}
 
-	known_freq_set = known_networks_get_recent_frequencies(5);
+	known_freq_set = known_networks_get_recent_frequencies(
+						STATION_RECENT_NETWORK_LIMIT,
+						STATION_RECENT_FREQS_LIMIT);
 	if (!known_freq_set)
 		return -ENODATA;
 
@@ -2761,7 +2766,8 @@ static int station_roam_scan_known_freqs(struct station *station)
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

