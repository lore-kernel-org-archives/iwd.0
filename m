Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D62874E25
	for <iwd@lists.linux.dev>; Wed, 15 May 2024 12:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715775753; cv=none; b=bqbKsNy0Eh9AvOtrNlqqdpR9ti9GPeTcFul793m6sTMC5ZyLZD/OHVdTuaUglnDtXFQE4EEMRo2e0FBEKLPiH0quy5VY45ft73stcXTOGoqOWeeIQ2Ntrn4uYOleMd2TOZUcVAc9PRDvf8jCidBw/qw2r8jXkjgcrQ07AQZU0l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715775753; c=relaxed/simple;
	bh=uoLh7ZThrih6ndfpJ1BfPHhyxIzr+KFOvg3V89yDoAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=idsA5Bz1arNnTnRidl20VHon9KBQh1mG0P1TZABSFMobQw7SE56iEv++M9hjITU41j0Z748+LzDqhkzGes9oeDzH7JaNuC+RhOGlbM6VjzcTxI+MDsOyYtdyTPdiprSsel/Rsob7ULPokgYL1a7JlqV0uPC6nmn9LhbSVuBTbRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fw5BadAF; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fw5BadAF"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-792b8d30075so468434185a.1
        for <iwd@lists.linux.dev>; Wed, 15 May 2024 05:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715775749; x=1716380549; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfKh5Zksqm4ttq/9eaP7c7Ayyv0YPlHKaWrWdMb3sGc=;
        b=fw5BadAFoc0+QyOQdjDBRSc0SYjGE32f8j7Md8tP8+EmF7JtxwTb2Ywyfgxy1tztHV
         bwpTMp4UDfLTb3y77dep4hnVxiACHi7DiL30ceqlxGLK+u0oFQ5y/Qt0f8GQ1PR6n4Q9
         ffrqn42oiT9gkfOIdQtN9Eo43lnkkg2s8rvqo0s6NXtzh55ii/FgnzsmIYYV4rFmLFl7
         Ce5BM7tSEvtgtLE4PZv6SWSIllepvDxDIV2PKBnlpHR0WWfqX7Lb161Gjn8a5LS3X6dG
         xYPFAlTWo0pyJ08ZW7Axw8+QbNWskOqGiXR+jUgQEb/ewWE15oHvdc8DLiQaFvPiSKcO
         zFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715775749; x=1716380549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfKh5Zksqm4ttq/9eaP7c7Ayyv0YPlHKaWrWdMb3sGc=;
        b=ptS1I2Z9CWKtb5+3kHqSRlR3kJIkweY/BQe7xlfiMIU+JYylQ7RP4tKCR2XQFIlgS5
         DQH3sPNw5FJlqCIsszqaS8VBJvVxobBClH8oAbE6lRkFE5RKjIXmHYpB6UI8OIFNTGql
         TETtPZbbj8bHbvIfP8vU6CN317buvpqK9jZ+259PmdnwRsdfW1OE0cYIojP5vYPT6kfI
         9UueH2p3kzFU9nBVLw9fOaSTyUvArWg7GlvFE31Zq4EUqfblky8no8t9nouQk2JR5w8W
         1Ey2PEohad0tLO9pMtyMWNil2cnFqOWDLn8uxtG+/26Qurt6lOclrXRkHE8Lw7dUWgWH
         9JGw==
X-Gm-Message-State: AOJu0YxhDfDdfEDTU19x2XF5GwXsbffsrHR64W8xEC0c1f6zIf3zpAbC
	Pu6rLW53Tmd7cR5Npmp2ttY1lEAY71KTycqyGwnQGWlW4Q+/PlyIsgQsogXb
X-Google-Smtp-Source: AGHT+IEL9Fwk7YyIO2cdSEGiHvAdxz60s/Vd3+PCUHYPZ1KMQWx1uMFeqLcf9nKqvVC0Apz7EBsLFQ==
X-Received: by 2002:a05:620a:390d:b0:78d:6b42:6c17 with SMTP id af79cd13be357-792c7600fbfmr1969064585a.76.1715775749215;
        Wed, 15 May 2024 05:22:29 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2a11e8sm669380085a.58.2024.05.15.05.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 05:22:28 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] station: refactor the printing of scan results, print SNR/load
Date: Wed, 15 May 2024 05:22:21 -0700
Message-Id: <20240515122221.333230-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515122221.333230-1-prestwoj@gmail.com>
References: <20240515122221.333230-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a few values which are nice to see in debug logs. Namely
the BSS load and SNR. Both of these values may not be available
either due to the AP or local hardware limiations. Rather than print
dummy values for these refactor the print so append the values only
if they are set in the scan result.
---
 src/station.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/src/station.c b/src/station.c
index 641068cc..2e5febee 100644
--- a/src/station.c
+++ b/src/station.c
@@ -402,6 +402,27 @@ static int bss_signal_strength_compare(const void *a, const void *b, void *user)
 	return (bss->signal_strength > new_bss->signal_strength) ? 1 : -1;
 }
 
+static void station_print_scan_bss(const struct scan_bss *bss)
+{
+	uint32_t kbps100 = DIV_ROUND_CLOSEST(bss->data_rate, 100000);
+	char optional[64] = {0};
+	char *ptr = optional;
+
+	if (bss->have_snr)
+		ptr += sprintf(ptr, ", snr: %d", bss->snr);
+
+	if (bss->have_utilization)
+		ptr += sprintf(ptr, ", load: %u/255", bss->utilization);
+
+	l_debug("Processing BSS '%s' with SSID: %s, freq: %u, rank: %u, "
+			"strength: %i, data_rate: %u.%u%s",
+			util_address_to_string(bss->addr),
+			util_ssid_to_utf8(bss->ssid_len, bss->ssid),
+			bss->frequency, bss->rank, bss->signal_strength,
+			kbps100 / 10, kbps100 % 10,
+			optional);
+}
+
 /*
  * Returns the network object the BSS was added to or NULL if ignored.
  */
@@ -412,14 +433,8 @@ static struct network *station_add_seen_bss(struct station *station,
 	enum security security;
 	const char *path;
 	char ssid[33];
-	uint32_t kbps100 = DIV_ROUND_CLOSEST(bss->data_rate, 100000);
 
-	l_debug("Processing BSS '%s' with SSID: %s, freq: %u, rank: %u, "
-			"strength: %i, data_rate: %u.%u",
-			util_address_to_string(bss->addr),
-			util_ssid_to_utf8(bss->ssid_len, bss->ssid),
-			bss->frequency, bss->rank, bss->signal_strength,
-			kbps100 / 10, kbps100 % 10);
+	station_print_scan_bss(bss);
 
 	if (util_ssid_is_hidden(bss->ssid_len, bss->ssid)) {
 		l_debug("BSS has hidden SSID");
@@ -2655,15 +2670,9 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 
 	while ((bss = l_queue_pop_head(bss_list))) {
 		double rank;
-		uint32_t kbps100 = DIV_ROUND_CLOSEST(bss->data_rate, 100000);
 		struct roam_bss *rbss;
 
-		l_debug("Processing BSS '%s' with SSID: %s, freq: %u, rank: %u,"
-				" strength: %i, data_rate: %u.%u",
-				util_address_to_string(bss->addr),
-				util_ssid_to_utf8(bss->ssid_len, bss->ssid),
-				bss->frequency, bss->rank, bss->signal_strength,
-				kbps100 / 10, kbps100 % 10);
+		station_print_scan_bss(bss);
 
 		/* Skip the BSS we are connected to */
 		if (!memcmp(bss->addr, station->connected_bss->addr, 6))
-- 
2.34.1

