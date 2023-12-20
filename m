Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D363825560
	for <iwd@lists.linux.dev>; Wed, 20 Dec 2023 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMEuJujf"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3b9f111c114so3820025b6e.1
        for <iwd@lists.linux.dev>; Wed, 20 Dec 2023 05:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703077930; x=1703682730; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0r8COS43hybrdlcLSa48QXn75TJOVSuKgZDRTr3WWM=;
        b=hMEuJujfKcavHFpq/mW3ZItl/vdeDkmtpV1Utd2TWUrSVBs/rrCwz2OiG+az/s8yHY
         bIzpKm2JXAkzfHXEvGJ0VG8lpj4LY/KLty0l5urHBca5THEK7D2+bFsWOpva5tz+/voK
         KZ2YfIMyCP9G8gYkmwVrXibVW4L++sQi7/08nQa6vqBMeq5LWTOA/Ra7F36RXSUrFLE6
         9J1AIBePrhwB/xNinHP6miyMgSmMqwZkDiCbHykfDF4PCTwegwppH2xEGxAr/82tDLRK
         FHmPeV2qC5/fVtqbJ1JqIWAdBJiS1SKMqpHcwFegti5is8LlhElrkMxcSQ6NCN7aCSaV
         Mt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703077930; x=1703682730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0r8COS43hybrdlcLSa48QXn75TJOVSuKgZDRTr3WWM=;
        b=qGYotZujzRYUIL06vCnp+JFmAgrw26YoRsXa+RZDo1WHeMnriYPYG5ZV0PW2iYk5O2
         +nW7bkghQRJAVigQt4tNRTLsL5//vPTEt+aFkQCfUgIygZE2moycnaTwb0mYy8mzq3sp
         WeUzo7awwJ1OeVFXTX6au8/Tb0QVPVWDyDvpkI8fPNpwkkuBlzTJdNyt0jxcswCTNA1Y
         jvA+NiIxwz1GRrl0j/1tRILIIQhKHBTD/8E3/KkJ99WfTrsqO8U2jZuMwIqChzrCemWb
         O//COtw9xdXcyLGiKg9VtZsfrqAd4md2Y/SjtyuErjufeHUvtinOMVjGZ5a9w1KBZw4W
         Gukw==
X-Gm-Message-State: AOJu0Yy4TB6WKBFNQ3AB0y8vJEKn+VX0CpIM+yBUgMEAPeYmnCflm07i
	940ycL7tCYMrUW8pnNEqC4dd10qRjZ0=
X-Google-Smtp-Source: AGHT+IEnHsXZlP7tGbC6JgqRQZWYzDpmcqwafcU1dTdJ+GutUYauSFatgqAtwtsVJ2FXt3qSIenuSg==
X-Received: by 2002:a05:6808:3cf:b0:3b8:b063:5d8e with SMTP id o15-20020a05680803cf00b003b8b0635d8emr19467748oie.117.1703077930517;
        Wed, 20 Dec 2023 05:12:10 -0800 (PST)
Received: from LOCLAP699.barrett-olive-branch.locus ([50.222.209.222])
        by smtp.gmail.com with ESMTPSA id j15-20020aca170f000000b003ba3a9c553esm2109591oii.30.2023.12.20.05.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 05:12:09 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/7] known_network: rename known_network_add_frequency
Date: Wed, 20 Dec 2023 05:11:54 -0800
Message-Id: <20231220131200.267489-2-prestwoj@gmail.com>
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

Rename to known_network_add_seen_frequency. This prepares to
differentiate between tracking frequencies based on a BSS being
seen versus being connected to. When a BSS has been connected to
that frequency should be preferred when roaming/quick scanning.
---
 src/knownnetworks.c | 3 ++-
 src/knownnetworks.h | 3 ++-
 src/network.c       | 6 +++---
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/src/knownnetworks.c b/src/knownnetworks.c
index 04ce74ec..eac6c66b 100644
--- a/src/knownnetworks.c
+++ b/src/knownnetworks.c
@@ -566,7 +566,8 @@ static bool known_frequency_match(const void *a, const void *b)
  * Adds a frequency to the 'known' set of frequencies that this network
  * operates on.  The list is sorted according to most-recently seen
  */
-int known_network_add_frequency(struct network_info *info, uint32_t frequency)
+int known_network_add_seen_frequency(struct network_info *info,
+					uint32_t frequency)
 {
 	struct known_frequency *known_freq;
 
diff --git a/src/knownnetworks.h b/src/knownnetworks.h
index e8ffac0b..d404b161 100644
--- a/src/knownnetworks.h
+++ b/src/knownnetworks.h
@@ -114,7 +114,8 @@ struct network_info *known_networks_find(const char *ssid,
 
 struct scan_freq_set *known_networks_get_recent_frequencies(
 						uint8_t num_networks_tosearch);
-int known_network_add_frequency(struct network_info *info, uint32_t frequency);
+int known_network_add_seen_frequency(struct network_info *info,
+					uint32_t frequency);
 void known_network_frequency_sync(struct network_info *info);
 
 uint32_t known_networks_watch_add(known_networks_watch_func_t func,
diff --git a/src/network.c b/src/network.c
index 4723334e..3e8770bc 100644
--- a/src/network.c
+++ b/src/network.c
@@ -807,7 +807,7 @@ static void add_known_frequency(void *data, void *user_data)
 	struct scan_bss *bss = data;
 	struct network_info *info = user_data;
 
-	known_network_add_frequency(info, bss->frequency);
+	known_network_add_seen_frequency(info, bss->frequency);
 }
 
 void network_set_info(struct network *network, struct network_info *info)
@@ -1094,7 +1094,7 @@ bool network_bss_add(struct network *network, struct scan_bss *bss)
 		return false;
 
 	if (network->info)
-		known_network_add_frequency(network->info, bss->frequency);
+		known_network_add_seen_frequency(network->info, bss->frequency);
 
 	/* Done if BSS is not HS20 or we already have network_info set */
 	if (!bss->hs20_capable)
@@ -1131,7 +1131,7 @@ bool network_bss_update(struct network *network, struct scan_bss *bss)
 
 	/* Sync frequency for already known networks */
 	if (network->info) {
-		known_network_add_frequency(network->info, bss->frequency);
+		known_network_add_seen_frequency(network->info, bss->frequency);
 		known_network_frequency_sync(network->info);
 	}
 
-- 
2.34.1

