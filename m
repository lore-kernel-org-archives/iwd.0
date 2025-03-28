Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D561C5F29
	for <iwd@lists.linux.dev>; Fri, 28 Mar 2025 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743172994; cv=none; b=C+sh6r69hw1qI4w62kJoqDfTB1sFluDFGxmBZ9FTb+Odh1x429t4AJg9ZHdWx3CgS6SbW7uF7L+U0VrfQ5RbeCcr7GMC/m54LHVuw+Nx2BROgEwFIgGpBcoKyTt2BEKb84kEAKJZX2YnwCGDu/igjpqZnR1G90yjloxQhveJETI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743172994; c=relaxed/simple;
	bh=EwPdsSLrXzCyw+8nRrhClCjtUfVMb9FjzyIKxtjNK2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kiqu0b7JlIEPWRZqTI0wqVARfk9xgsRiJaV0V4zucBIytgbO/Cx3gR8MBOnP7vHLkBNoVpuu78E0KPtrDQvyoR4y0KvGGcWWoHQPg5xeym7QM76xiAXQyAP1PzR9+VPHZKw2ENLWU4wl3OuPUnUfxwAV4LPt2PrYysOczNG+6Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mo2Mmyvg; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mo2Mmyvg"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-224341bbc1dso44840315ad.3
        for <iwd@lists.linux.dev>; Fri, 28 Mar 2025 07:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743172992; x=1743777792; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlMOAxothzpmJqi0/HRD7fb36L9A970wXkr8VYYxoiY=;
        b=Mo2MmyvguyZFobaF4Npbys8OpB4PklubVl1VrHZQEr9fcugkGGTNORAv+zayL76ST9
         hb3DhnTa1lGl96aupO5JBhuJClEW6MT8qHEJ7bhVjepUJoDlix6IcwUgfG0e/OIMPlQe
         dqkkfhlc2r3F7tzLc8YgDemSyz83eWQxPgVU3T8yy704MHQv3tp9tZCLn8t+KYTEN4M/
         mQkAmW9v/FILFP++6Gx1iScmUz5qqzacrkWsJGMeSHZzx4yq0LUGen+ROyvvqPHCQh/L
         MQHOeCwY9DgaQ0mZxu5zoOjM7ATyVVENXIS9Go30sCpV2iQVWg90UFbFT5gYprKHVTi6
         PSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743172992; x=1743777792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UlMOAxothzpmJqi0/HRD7fb36L9A970wXkr8VYYxoiY=;
        b=maoXDDpWxqzvGTIHkXpSpX242Xmve1bBUy/+wwm9Xq4Qwj3gqXfdIOQ/dhUAXh8Juc
         sC4sO8kTJQcgYGzgNdl+/4r8y0++FTHF7U1MPJ0Mc0vXW1dDRi1aBbCpbK5t69tvIYYu
         RZL6xw0VYtURuR5djD1rs0b0ws63VM5m09sLcbvFoNPUn77BMlS5OS/YCMAc8EFX6pUG
         ovhec8KNedOrBgEbppSmGpqqVNwD/C9m/JkSOYZwHfixN5jLwEpiI8kVni32mMdNFIi9
         0YOWW9Jwl91Ki9SQDXz2EKaMm+xKMWtiSdSipQKURo7shEX70yBPp/p8kjVUGL60oRUM
         UrPQ==
X-Gm-Message-State: AOJu0YxKTrXVw6rGLZmT8tRiL+R0W0ZPQ515mRrEGYz0h7nfOG7DItT6
	+FqaIhpH14Nil9rszFtNcxW8jSk7KUS2TJvAoEOHSqLF003e36WcC/VDiA==
X-Gm-Gg: ASbGncvofe86LlM9/JOeRfMk823Zr3+uaCZC1J0JlCKxOOiitSf9GG0D9t//Ogltq3u
	LrwjLo8fnj95fSj3RsupUoa1Fw5mCFe0KPh44ShTD/kypZrMVagAOZ9QvvJEN9WAW52KRDDGipz
	LWtisEZAS2GtA3EiiZpvxlRqzua4s5/Jah8IQiIeiDrS47w1QqJjF0dsNi8ltVkDBGNpOXBWu7f
	3nre2O3+jPO16NSe/TujgIg9wEBko+jv5M1JVM/dYbwPOvi7DOTB8jAtJ6rj1RYJN0LSSaH/9Ji
	rAYceeCrTzOFdCZO6fuY9zy3AkCTTnT9sUB4EKXZUhlwZZjhWd+EtifBDx3jUKvYySXJRA+H2c8
	=
X-Google-Smtp-Source: AGHT+IHbexa6TatbBDVz+Hu/NhkbhrnSzsGvAKeP2uQR3S2CfC4urbNfLmhbqZcsKgE/iaFomuH55g==
X-Received: by 2002:a17:902:f688:b0:223:47d9:1964 with SMTP id d9443c01a7336-22804946d87mr132435085ad.34.1743172991618;
        Fri, 28 Mar 2025 07:43:11 -0700 (PDT)
Received: from LOCLAP699.locus-demo-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eee2288sm18885515ad.87.2025.03.28.07.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 07:43:11 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 07/11] station: roam blacklist BSS's, and consider when roaming
Date: Fri, 28 Mar 2025 07:42:49 -0700
Message-Id: <20250328144253.421425-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250328144253.421425-1-prestwoj@gmail.com>
References: <20250328144253.421425-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the BSS is requesting IWD roam elsewhere add this BSS to the
blacklist using BLACKLIST_REASON_ROAM_REQUESTED. This will lower
the chances of IWD roaming/connecting back to this BSS in the
future.

This then allows IWD to consider this blacklist state when picking
a roam candidate. Its undesireable to fully ban a roam blacklisted
BSS, so some additional sorting logic has been added. Prior to
comparing based on rank, BSS's will be sorted into two higher level
groups:

Above Threshold - BSS is above the CriticalRoamThreshold
Below Threshold - BSS is below the CriticalRoamThreshold

Within each of these groups the BSS may be roam blacklisted which
will position it at the bottom of the list within its respecitve
group.
---
 src/station.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 69 insertions(+), 6 deletions(-)

diff --git a/src/station.c b/src/station.c
index e2ed78f3..623cfdca 100644
--- a/src/station.c
+++ b/src/station.c
@@ -155,6 +155,55 @@ struct anqp_entry {
 	uint32_t pending;
 };
 
+/*
+ * Rather than sorting BSS's purely based on ranking a higher level grouping
+ * is used. The purpose of this higher order grouping is the consider the BSS's
+ * roam blacklist status. The roam blacklist is a "soft" blacklist in that we
+ * still should connect to these BSS's if they are the only "good" option.
+ * The question here is: what makes a BSS "good" vs "bad".
+ *
+ * For an initial (probably naive) approach here we can use the
+ * CriticalSignalThreshod[5G] which indicates the signal level that would not
+ * be of an acceptable connection quality. BSS can then be sorted either
+ * above or below this threshold. Within each of these groups a BSS may be
+ * blacklisted, meaning it should get sorted lower on the list compared to
+ * others within the same group.
+ *
+ * This sorting is achieved by extending rank to a uint32_t where the first 16
+ * bits are the standard rank calculated by scan.c. Above that bits can be
+ * reserved for this higher level grouping:
+ *
+ * Bit 16 indicates the BSS is not blacklisted
+ * Bit 17 indicates the BSS is above the critical signal threshold
+ */
+
+#define ABOVE_THRESHOLD_BIT 17
+#define NOT_BLACKLISTED_BIT 16
+
+static uint32_t evaluate_bss_group_rank(const uint8_t *addr, uint32_t freq,
+					int16_t signal_strength, uint16_t rank)
+{
+	int signal = signal_strength / 100;
+	bool roam_blacklist;
+	bool good_signal;
+	uint32_t rank_out = (uint32_t) rank;
+
+	if (blacklist_contains_bss(addr, BLACKLIST_REASON_CONNECT_FAILED))
+		return 0;
+
+	roam_blacklist = blacklist_contains_bss(addr,
+					BLACKLIST_REASON_ROAM_REQUESTED);
+	good_signal = signal >= netdev_get_low_signal_threshold(freq);
+
+	if (good_signal)
+		set_bit(&rank_out, ABOVE_THRESHOLD_BIT);
+
+	if (!roam_blacklist)
+		set_bit(&rank_out, NOT_BLACKLISTED_BIT);
+
+	return rank_out;
+}
+
 /*
  * Used as entries for the roam list since holding scan_bss pointers directly
  * from station->bss_list is not 100% safe due to the possibility of the
@@ -162,13 +211,13 @@ struct anqp_entry {
  */
 struct roam_bss {
 	uint8_t addr[6];
-	uint16_t rank;
+	uint32_t rank;
 	int32_t signal_strength;
 	bool ft_failed: 1;
 };
 
 static struct roam_bss *roam_bss_from_scan_bss(const struct scan_bss *bss,
-						uint16_t rank)
+						uint32_t rank)
 {
 	struct roam_bss *rbss = l_new(struct roam_bss, 1);
 
@@ -2805,7 +2854,7 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 	struct handshake_state *hs = netdev_get_handshake(station->netdev);
 	struct scan_bss *current_bss = station->connected_bss;
 	struct scan_bss *bss;
-	double cur_bss_rank = 0.0;
+	uint32_t cur_bss_group_rank = 0;
 	static const double RANK_FT_FACTOR = 1.3;
 	uint16_t mdid;
 	enum security orig_security, security;
@@ -2834,10 +2883,15 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 	 */
 	bss = l_queue_find(bss_list, bss_match_bssid, current_bss->addr);
 	if (bss && !station->ap_directed_roaming) {
-		cur_bss_rank = bss->rank;
+		double cur_bss_rank = bss->rank;
 
 		if (hs->mde && bss->mde_present && l_get_le16(bss->mde) == mdid)
 			cur_bss_rank *= RANK_FT_FACTOR;
+
+		cur_bss_group_rank = evaluate_bss_group_rank(bss->addr,
+						bss->frequency,
+						bss->signal_strength,
+						(uint16_t) cur_bss_rank);
 	}
 
 	/*
@@ -2859,6 +2913,7 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 	while ((bss = l_queue_pop_head(bss_list))) {
 		double rank;
 		struct roam_bss *rbss;
+		uint32_t group_rank;
 
 		station_print_scan_bss(bss);
 
@@ -2889,7 +2944,11 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 		if (hs->mde && bss->mde_present && l_get_le16(bss->mde) == mdid)
 			rank *= RANK_FT_FACTOR;
 
-		if (rank <= cur_bss_rank)
+		group_rank = evaluate_bss_group_rank(bss->addr, bss->frequency,
+						bss->signal_strength,
+						(uint16_t) rank);
+
+		if (group_rank <= cur_bss_group_rank)
 			goto next;
 
 		/*
@@ -2898,7 +2957,7 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 		 */
 		station_update_roam_bss(station, bss);
 
-		rbss = roam_bss_from_scan_bss(bss, rank);
+		rbss = roam_bss_from_scan_bss(bss, group_rank);
 
 		l_queue_insert(station->roam_bss_list, rbss,
 				roam_bss_rank_compare, NULL);
@@ -3268,6 +3327,10 @@ static void station_ap_directed_roam(struct station *station,
 	l_timeout_remove(station->roam_trigger_timeout);
 	station->roam_trigger_timeout = NULL;
 
+	blacklist_add_bss(station->connected_bss->addr,
+				BLACKLIST_REASON_ROAM_REQUESTED);
+	station_debug_event(station, "ap-roam-blacklist-added");
+
 	if (req_mode & WNM_REQUEST_MODE_PREFERRED_CANDIDATE_LIST) {
 		l_debug("roam: AP sent a preferred candidate list");
 		station_neighbor_report_cb(station->netdev, 0, body + pos,
-- 
2.34.1

