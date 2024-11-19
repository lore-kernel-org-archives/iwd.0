Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5F81CEACF
	for <iwd@lists.linux.dev>; Tue, 19 Nov 2024 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732026287; cv=none; b=PCmGjCd8aI4ORqt0AxTMTSpJAxiPZnbV466XDPflKcoUZFuZsZAehdbkefjKi52RM1AO8kaWN3/Atod5v6MsMplA4usX+2KxV26IYSFR9XsY6Luw92EDofz0zZs1VuKF+tQwxhKNuN+9hZrR1iQ6/8pn3g+ljUPUDq5G56YpEV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732026287; c=relaxed/simple;
	bh=s5P9THym1xrPKeUoiPfpKUV/fT6odiPKVLjmoxx5iPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TIx3ryQ6J8xjYAG+Ma0PzvSYoFpeC/raAq+17XgtAe9nA5gjwc80R3wY3/kSgOOcHVhxJPTyYweJXSxuO8J+/UsBYdfvK2Ig7q61hxpfV+wG9WwJ2FQaLGwxy3p303IRKc+RrscweOxW0GPRXUR6ckSvMTyvdZGenG/zHQSN7YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlaFCqgV; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlaFCqgV"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21210fe8775so17846235ad.1
        for <iwd@lists.linux.dev>; Tue, 19 Nov 2024 06:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732026285; x=1732631085; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAmOltD/CiKXU3qRu9vi+6hwzYl2onLaVBZnDAEwbh8=;
        b=TlaFCqgVLASioxiK6VAzcB/R3J7MIo0SNBJEkFt2e8rIcqh9JcPkiIZNBUVWvpuzmz
         nMafCD0PAyqxUbmmirp96QgyOAvM3RLQ9Nr01Qclk6gGEAqvw5MIVDwufHRXyI2XPjQq
         g0uP4uIT1ZQb64K6/mM9HF7v1NZbvdF2FlgRoh5CUAD6lw8CkpY1DOfmrZP22gW3kODO
         buaRMBgYL2vL9pRgo7kZdS9QqXBGYep1Uy+BtPkfafpMuqWJWe95r1/kMnZLe44yWWSu
         i23vR0ThsUrOG9muPhBS3BLgz+40SYqt8oODi2rfC8e/aGi7xABpABAL0r6NsUMtLgph
         Uf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732026285; x=1732631085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kAmOltD/CiKXU3qRu9vi+6hwzYl2onLaVBZnDAEwbh8=;
        b=MrDel2NP54U5hJHFRjAFExQ/zVr97sG4JSCF3uF33P2NzRbFUoMSHpZ+Vpb8g6zeHD
         TxYUm3yNmXrOEka85olkWsv6Jl/TiUKaqOQPsv1kssoaot3byQA8AA3Z9Mbq1iEZalEC
         ijqFWlwzOjFoCME1a/5Nbd/YjUwxuAG2AL3jfOaTthVRXwOMpGavueoWzlK/nWY3nr3i
         rxq1+Iw7+UbDS3rVWMPslIj13LuW17IRyL6RVK975NLAKT7zh81Bc8gByQg/9S7O75/J
         9/kCl136zn9e8kv4C7DsTkhXolx27bpJ2Es7mLagPKTddun5j3p0jL5Q83cB52uCIZk4
         LkoQ==
X-Gm-Message-State: AOJu0YygVaqV2bHvLeNVizQu4rpfPJW1sIfwwYHH/S1VJ066TB4RkHe9
	gNJ3q67LTWRGo3FCEemZYJcTbc2qQ6SpB+V/jSlZMve1eUOElI8shT4rUg==
X-Google-Smtp-Source: AGHT+IHn6cL3B7sFqHRlLuyFAJ/0f1rlMafkfTqByDZqcsWv6/tswWQpuEuvUcVrIK5C/J9SrcgP0g==
X-Received: by 2002:a17:902:f792:b0:20c:b6cf:f465 with SMTP id d9443c01a7336-2124cf595c2mr50110225ad.6.1732026285301;
        Tue, 19 Nov 2024 06:24:45 -0800 (PST)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212389529b6sm29219115ad.236.2024.11.19.06.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 06:24:45 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/8] scan: add ranking modifiers for utilization/station count
Date: Tue, 19 Nov 2024 06:24:28 -0800
Message-Id: <20241119142430.323074-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119142430.323074-1-prestwoj@gmail.com>
References: <20241119142430.323074-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The utilization rank factor already existed but was very rigid
and only checked a few values. This adds the (optional) ability
to start applying an exponentially decaying factor to both
utilization and station count after some threshold is reached.

This area needs to be re-worked in order to support very highly
loaded networks. If a network either doesn't support client
balancing or does it poorly its left up to the clients to choose
the best BSS possible given all the information available. In
these cases connecting to a highly loaded BSS may fail, or result
in a disconnect soon after connecting. In these cases its likely
better for IWD to choose a slightly lower RSSI/datarate BSS over
the conventionally 'best' BSS in order to aid in distributing
the network load.

The thresholds are currently optional and not enabled by default
but if set they behave as follows:

If the value is above the threshold it is mapped to an integer
between 0 and 30. (using a starting range of <value> - 255).
This integer is then used to index in the exponential decay table
to get a factor between 1 and 0. This factor is then applied to
the rank.

Note that as the value increases above the threshold the rank
will be increasingly effected, as is expected for an exponential
function. These option should be used with care as it may have
unintended consequences, especially with very high load networks.
i.e. you may see IWD roaming to BSS's with much lower signal if
there are high load BSS's nearby.

To maintain the existing behavior if there is no utilization
factor set in main.conf the legacy thresholds/factors will be
used.
---
 src/scan.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 86 insertions(+), 7 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index 64de57d2..aeab6516 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -56,6 +56,8 @@
 static double RANK_2G_FACTOR;
 static double RANK_5G_FACTOR;
 static double RANK_6G_FACTOR;
+static uint32_t RANK_HIGH_UTILIZATION;
+static uint32_t RANK_HIGH_STATION_COUNT;
 static uint32_t SCAN_MAX_INTERVAL;
 static uint32_t SCAN_INIT_INTERVAL;
 
@@ -1681,10 +1683,77 @@ static struct scan_bss *scan_parse_result(struct l_genl_msg *msg,
 	return bss;
 }
 
-static void scan_bss_compute_rank(struct scan_bss *bss)
+static double scan_legacy_utilization_factor(uint8_t utilization)
 {
 	static const double RANK_HIGH_UTILIZATION_FACTOR = 0.8;
 	static const double RANK_LOW_UTILIZATION_FACTOR = 1.2;
+
+	if (utilization >= 192)
+		return RANK_HIGH_UTILIZATION_FACTOR;
+	else if (utilization <= 63)
+		return RANK_LOW_UTILIZATION_FACTOR;
+
+	return 1.0;
+}
+
+static double scan_get_load_factors(uint8_t utilization, uint16_t sta_count)
+{
+	double n;
+	double factor = 1.0;
+	/*
+	 * The exponential decay table has 64 entries (0 <= n <= 63) which range
+	 * from 1.0 to 0.28. For the utilization and station count factors we
+	 * likely don't want to adjust the rank so drastically (potentially a
+	 * 78% reduction in the worse case) so cap the index at 30 which equates
+	 * to ~64% at the worst case.
+	 */
+	static const uint8_t LOAD_DECAY_OFFSET = 30;
+
+	if (!RANK_HIGH_UTILIZATION) {
+		/*
+		 * To maintain existing behavior, if the utilization factor is
+		 * unset (default) fall back to the static thresholds and
+		 * factor weights.
+		 */
+		factor = scan_legacy_utilization_factor(utilization);
+		goto sta_count;
+	} else if (utilization < RANK_HIGH_UTILIZATION)
+		goto sta_count;
+
+	/* Map the utilization threshold -> 255 to rankmod_table indexes */
+	if (L_WARN_ON(!util_linear_map(utilization, RANK_HIGH_UTILIZATION,
+					255, 0, LOAD_DECAY_OFFSET, &n)))
+		goto sta_count;
+
+	factor = util_exponential_decay(n);
+
+sta_count:
+	if (!RANK_HIGH_STATION_COUNT || sta_count < RANK_HIGH_STATION_COUNT)
+		return factor;
+
+	/*
+	 * The station count is a uint16 so in theory it could be excessively
+	 * large. In practice APs generally can't handle anywhere near this so
+	 * put a cap at 255. If at some time in the future APs begin to handle
+	 * this level of capacity we could increase this.
+	 *
+	 * TODO: A warning is used here to make this visible. If we see cases
+	 * where this is happening we may need to give this another look.
+	 */
+	if (L_WARN_ON(sta_count > 255))
+		sta_count = 255;
+
+	if (L_WARN_ON(!util_linear_map(sta_count, RANK_HIGH_STATION_COUNT,
+					255, 0, LOAD_DECAY_OFFSET, &n)))
+		return factor;
+
+	factor *= util_exponential_decay(n);
+
+	return factor;
+}
+
+static void scan_bss_compute_rank(struct scan_bss *bss)
+{
 	static const double RANK_HIGH_SNR_FACTOR = 1.2;
 	static const double RANK_LOW_SNR_FACTOR = 0.8;
 	double rank;
@@ -1708,12 +1777,8 @@ static void scan_bss_compute_rank(struct scan_bss *bss)
 		rank *= RANK_6G_FACTOR;
 
 	/* Rank loaded APs lower and lightly loaded APs higher */
-	if (bss->have_utilization) {
-		if (bss->utilization >= 192)
-			rank *= RANK_HIGH_UTILIZATION_FACTOR;
-		else if (bss->utilization <= 63)
-			rank *= RANK_LOW_UTILIZATION_FACTOR;
-	}
+	if (bss->have_utilization)
+		rank *= scan_get_load_factors(bss->utilization, bss->sta_count);
 
 	if (bss->have_snr) {
 		if (bss->snr <= 15)
@@ -2599,6 +2664,20 @@ static int scan_init(void)
 	if (SCAN_MAX_INTERVAL > UINT16_MAX)
 		SCAN_MAX_INTERVAL = UINT16_MAX;
 
+	if (!l_settings_get_uint(config, "Rank", "HighUtilizationThreshold",
+					&RANK_HIGH_UTILIZATION))
+		RANK_HIGH_UTILIZATION = 0;
+
+	if (L_WARN_ON(RANK_HIGH_UTILIZATION > 255))
+		RANK_HIGH_UTILIZATION = 255;
+
+	if (!l_settings_get_uint(config, "Rank", "HighStationCountThreshold",
+					&RANK_HIGH_STATION_COUNT))
+		RANK_HIGH_STATION_COUNT = 0;
+
+	if (L_WARN_ON(RANK_HIGH_STATION_COUNT > 255))
+		RANK_HIGH_STATION_COUNT = 255;
+
 	return 0;
 }
 
-- 
2.34.1

