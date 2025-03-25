Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E46263F4E
	for <iwd@lists.linux.dev>; Tue, 25 Mar 2025 18:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925666; cv=none; b=K6Ft4UYh6DN0IB5i77z/J66iWxzj8fgQP8KOECi0lNFOwVsFPM3lwnba2XOtMc98r7ufO0LC967F2xqtV1o8UU7McBTkKl2DBaeL9yGbj75JPpjpdxxIF/hXwJLS3WraWpcUaPG4+UV3OflTmx/iFQq7FWvKHurSfC85IrC2280=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925666; c=relaxed/simple;
	bh=9GdPPeyK/2h26/o+1gsaDBW3+lf82h40D8GWVHdUOQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uiIAm9F6YmOq0m7gskl3LusqLvSkc/4tv2SgqzJSh1ErQh1cIAAFzNw/1Rr+iq1f7niLzNT3it/bwgAh4XhAyRvQm8Tjb3MSRsMA+sevtUIcB8I1t+t5OCLNg6JAobIHiO2evUnS2bnTZVG6jdnLBhGwpnPZqouXD8dcF2yBi3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHhVM2TU; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHhVM2TU"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2255003f4c6so116114905ad.0
        for <iwd@lists.linux.dev>; Tue, 25 Mar 2025 11:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742925664; x=1743530464; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5geqpT6JYJy07SCLDyr6LqDtVr7GPALCmJXy/zzVbI=;
        b=KHhVM2TU0GHgjBmMlOyFDrw6FU6CxDtsVCWKQMN0mAE7+6QK0i+yzjPnj2ZIttqXNy
         5MFn0C3GYlaw1jyigzDA7YCeES1pXno3gBdj+Llm82WO/OtrxmBhDdqgcAcRDZAz3Xkj
         a3pJRVTVfSCDkpPCifG0JtSbgkTifaIIiIt025VK+KdmMuwUzKjblzQx+Z5i2vDEw5Yy
         kUcikAmgj2UYLuoH/yCOC4I2Q+dgmLSkbJymCnGlZSVp1iMstqUVf3NX95858hTG2NWv
         8RYuRYDxOMVetPFnREVFQrzUqAbXzSepXcsmazVUSaeGdzAyG3TADO+xWDnNLPtb2CF2
         t9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742925664; x=1743530464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5geqpT6JYJy07SCLDyr6LqDtVr7GPALCmJXy/zzVbI=;
        b=WWNXGWTmyaQtxAzsQO+PLq9cG1FPIYAyP5RKGbfqeSIXWaaUWsQ7kfD2Z3EoTLlkS3
         swjFgJoG9c3yh2OOGDo482U8vavcXhoUMA8K5e/RHahwlTs4xuGxRNDeDHgYbpml3mOb
         qe67rlvn4sJYSbTKji1/ihChQi4nI5+ajNE35r/GfXvbYaKTaNCZuDMXRN/Ma0WNHBIf
         TpN+IYzvykXv+ndJ1HHhU+gjTqTkEGxuRh38NFR+fEwcC+4OMs7VeNUVS2eThPpXg4il
         rY4mlR9zFsMLfbT50csoOP8dcGWPqhsnL9VtFlZf1+mVDFUrEu4ODhhG6QPN1RBf1Vwr
         vlUg==
X-Gm-Message-State: AOJu0YyVdEJ8AKyl65EJa5zWmPd2rVbkXY/C4MLlI9LCnAwfajVw9LAj
	QIMGGpb8AE+l08JffId+Ys+henhSVloTmvXIJL+rD8UHXkKIaThafreHBA==
X-Gm-Gg: ASbGncud76EyrkOQASEFkWusVogibzdIfF3MnwpkuBVDrzU1KdOS+txi+hpV6RQGfaB
	7GHXczat8VSyQxhBPp+3yfeAHRJ+hQ55hebx+FF21a3tZnyFRw1k8D5c8aIAuADff3sctFrx3Ym
	uWbKaQH7p6TcF6KHLXLME9YXdnp+/ARghIrKDfwEjyxkqEY5Tef/hx7kP+oxzw8YA+77iMmUn6t
	gM26YRQZFUKSUv6T0dTNEAJSZ0Pa0AdFvs4giq8Hgnqps2t1EZaZjnUqP64aw5akTxAZWqEGwOT
	5wU7W8HkSrehHF4W3iNkHserJg8dy6Z27/2ZP4dJMk0KHdtDCjpAwGR12RGnMNDxgYQWoi0tk8I
	kUzI=
X-Google-Smtp-Source: AGHT+IFP9l4hkFQ+rPok5Rd39KBmlyQDfXPwiZEGQYKId9LDbwDNU5B88lET7ssQ38rXNtxvDGDlEg==
X-Received: by 2002:a17:902:db0a:b0:224:de2:7fd0 with SMTP id d9443c01a7336-22780da5a37mr275623235ad.25.1742925663413;
        Tue, 25 Mar 2025 11:01:03 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811bae9asm93770515ad.138.2025.03.25.11.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 11:01:03 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 07/10] station: roam blacklist BSS's, and consider when roaming
Date: Tue, 25 Mar 2025 11:00:38 -0700
Message-Id: <20250325180041.238676-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250325180041.238676-1-prestwoj@gmail.com>
References: <20250325180041.238676-1-prestwoj@gmail.com>
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
comparing based on rank, BSS's will be sorted into 3 groups:

Optimal - Not roam blacklisted, and above the roaming threshold
Above Threshold - May be blacklisted, and above the roaming threshold
Below Threshold - BSS is below the roaming threshold
---
 src/station.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 84 insertions(+), 4 deletions(-)

diff --git a/src/station.c b/src/station.c
index e2ed78f3..e3c7c189 100644
--- a/src/station.c
+++ b/src/station.c
@@ -155,6 +155,57 @@ struct anqp_entry {
 	uint32_t pending;
 };
 
+/*
+ * Rather than sorting BSS's purely based on ranking a higher level grouping
+ * is used. The purpose of this higher order grouping is the consider the BSS's
+ * roam blacklist status. The roam blacklist is a "soft" blacklist in that we
+ * still should connect to these BSS's if they are the only "good" option.
+ * The question here is: what makes a BSS "good" vs "bad".
+ *
+ * For an initial (probably nieve) approach here we can use the RoamThreshod[5G]
+ * and sort BSS's into "above" or "below" this threshold. Within each of these
+ * groups a BSS may be blacklisted, meaning it should get sorted lower on the
+ * list compared to others within the same group.
+ *
+ * Since we have several call sites needing to check/compare these groupings
+ * a bitmask can be used to describe the grouping:
+ *
+ * Each group will have 2 bits. The lower order bit signifies the BSS is in the
+ * group, but also blacklisted. The higher order bit signifies the BSS is in
+ * the group, but not blacklisted. The bitmask between two BSS's can then be
+ * compared directly similar to rank.
+ */
+
+#define UNDER_THRESHOLD_BIT 1
+#define ABOVE_THRESHOLD_BIT 3
+
+static uint32_t evaluate_bss_group(const uint8_t *addr, uint32_t freq,
+					int16_t signal_strength)
+{
+	int threshold;
+	int signal = signal_strength / 100;
+	bool roam_blacklist;
+	uint32_t mask = 0;
+
+	if (blacklist_contains_bss(addr, BLACKLIST_REASON_CONNECT_FAILED))
+		return mask;
+
+	roam_blacklist = blacklist_contains_bss(addr,
+					BLACKLIST_REASON_ROAM_REQUESTED);
+
+	if (freq > 4000)
+		netdev_get_low_signal_thresholds(NULL, &threshold);
+	else
+		netdev_get_low_signal_thresholds(&threshold, NULL);
+
+	if (signal >= threshold)
+		set_bit(&mask, ABOVE_THRESHOLD_BIT - roam_blacklist);
+	else
+		set_bit(&mask, UNDER_THRESHOLD_BIT - roam_blacklist);
+
+	return mask;
+}
+
 /*
  * Used as entries for the roam list since holding scan_bss pointers directly
  * from station->bss_list is not 100% safe due to the possibility of the
@@ -164,11 +215,13 @@ struct roam_bss {
 	uint8_t addr[6];
 	uint16_t rank;
 	int32_t signal_strength;
+	uint32_t group;
 	bool ft_failed: 1;
 };
 
 static struct roam_bss *roam_bss_from_scan_bss(const struct scan_bss *bss,
-						uint16_t rank)
+						uint16_t rank,
+						uint32_t group)
 {
 	struct roam_bss *rbss = l_new(struct roam_bss, 1);
 
@@ -176,6 +229,7 @@ static struct roam_bss *roam_bss_from_scan_bss(const struct scan_bss *bss,
 	rbss->rank = rank;
 	rbss->signal_strength = bss->signal_strength;
 	rbss->ft_failed = false;
+	rbss->group = group;
 
 	return rbss;
 }
@@ -184,6 +238,12 @@ static int roam_bss_rank_compare(const void *a, const void *b, void *user_data)
 {
 	const struct roam_bss *new_bss = a, *bss = b;
 
+	if (bss->group > new_bss->group)
+		return 1;
+	else if (bss->group < new_bss->group)
+		return -1;
+
+	/* BSS's both have the same group, sort by rank */
 	if (bss->rank == new_bss->rank)
 		return (bss->signal_strength >
 					new_bss->signal_strength) ? 1 : -1;
@@ -2805,6 +2865,7 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 	struct handshake_state *hs = netdev_get_handshake(station->netdev);
 	struct scan_bss *current_bss = station->connected_bss;
 	struct scan_bss *bss;
+	uint32_t cur_bss_group = 0;
 	double cur_bss_rank = 0.0;
 	static const double RANK_FT_FACTOR = 1.3;
 	uint16_t mdid;
@@ -2835,6 +2896,9 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 	bss = l_queue_find(bss_list, bss_match_bssid, current_bss->addr);
 	if (bss && !station->ap_directed_roaming) {
 		cur_bss_rank = bss->rank;
+		cur_bss_group = evaluate_bss_group(current_bss->addr,
+						current_bss->frequency,
+						current_bss->signal_strength);
 
 		if (hs->mde && bss->mde_present && l_get_le16(bss->mde) == mdid)
 			cur_bss_rank *= RANK_FT_FACTOR;
@@ -2859,6 +2923,9 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 	while ((bss = l_queue_pop_head(bss_list))) {
 		double rank;
 		struct roam_bss *rbss;
+		uint32_t group = evaluate_bss_group(bss->addr,
+							bss->frequency,
+							bss->signal_strength);
 
 		station_print_scan_bss(bss);
 
@@ -2889,7 +2956,15 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 		if (hs->mde && bss->mde_present && l_get_le16(bss->mde) == mdid)
 			rank *= RANK_FT_FACTOR;
 
-		if (rank <= cur_bss_rank)
+		/*
+		 * First check the group:
+		 *   - If worse, disregard BSS candidate
+		 *   - If better, keep BSS candidate
+		 *   - If equal, compare based on rank
+		 */
+		if (group < cur_bss_group)
+			goto next;
+		else if (group == cur_bss_group && rank <= cur_bss_rank)
 			goto next;
 
 		/*
@@ -2898,7 +2973,7 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 		 */
 		station_update_roam_bss(station, bss);
 
-		rbss = roam_bss_from_scan_bss(bss, rank);
+		rbss = roam_bss_from_scan_bss(bss, rank, group);
 
 		l_queue_insert(station->roam_bss_list, rbss,
 				roam_bss_rank_compare, NULL);
@@ -3268,6 +3343,10 @@ static void station_ap_directed_roam(struct station *station,
 	l_timeout_remove(station->roam_trigger_timeout);
 	station->roam_trigger_timeout = NULL;
 
+	blacklist_add_bss(station->connected_bss->addr,
+				BLACKLIST_REASON_ROAM_REQUESTED);
+	station_debug_event(station, "ap-roam-blacklist-added");
+
 	if (req_mode & WNM_REQUEST_MODE_PREFERRED_CANDIDATE_LIST) {
 		l_debug("roam: AP sent a preferred candidate list");
 		station_neighbor_report_cb(station->netdev, 0, body + pos,
@@ -5344,7 +5423,8 @@ static bool station_force_roam_scan_notify(int err, struct l_queue *bss_list,
 	/* The various roam routines expect this to be set from scanning */
 	station->preparing_roam = true;
 	l_queue_push_tail(station->roam_bss_list,
-				roam_bss_from_scan_bss(target, target->rank));
+				roam_bss_from_scan_bss(target, target->rank,
+				0xffff));
 
 	station_update_roam_bss(station, target);
 
-- 
2.34.1

