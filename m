Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DC86EB53
	for <iwd@lists.linux.dev>; Wed, 15 May 2024 12:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715775751; cv=none; b=ezO2Mt2AFS1W26WvBVUNq8pDvME4PBZGJzBCTlGMl8ejHPfHOw2z4YBGrJJS5xasqNphGoe5SML4dnh16Ndpg88z4J2lyJZnFB56h9MjmVHdBZNcv0L3K/TdHm4r4GIRYLjxdWmOAHVgVR6veJyF8NiZR62qHr8DxdvDEY+8Mtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715775751; c=relaxed/simple;
	bh=ieXM6WVuAM5MH0/2baL+qD1UGTOSGRtxt4PJw+3zQBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=odU46GPENg3/lELfq32lgWfGR5doX7pa3a4wB3cNplB6tk3LTqTdS8H0Mwhy41h8pGHEy04w/16t2c7Y2DjksG4Mywm4y3d9usaTy8e/UBN6uwwbv2Tj07BXMPcVfMABchPQOK7cv+VPFr7I8hYmeGlIr1EvIb+nGax7lLyeMOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2grODuy; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2grODuy"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-792b8d31702so427201485a.3
        for <iwd@lists.linux.dev>; Wed, 15 May 2024 05:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715775748; x=1716380548; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k79exwgCqVUrVnBuHOQy2LIeRnXzcjCZK4+8ra/2Vj0=;
        b=c2grODuydAR6gXVmEwUL/vu+Ia9coE05XZ1X2bFker3v5ik7f/qTU5YzPKWBQNQiw0
         8Cf8E4BDS1yoIxZCClhqeMy0aB/LogJ+QJA5cpgsqxeca+WznoNUwpW548w1Culachy7
         wZg5fkzfhBxTaRMo1aGbSxuFELjFrG8xpxNxIU1aTluvaMVfc81emqncVnbJTnSV/X8e
         WrULMfZLhKHyyEfDT8fqaYwyA7T6jm+Z1xNSwFzP5eU7O9a1uBz1pfm8HIQfKSBe66lM
         b6l9nUM+WCxTlPRE6Mjfh4e68LUS9syps+x+2aU5XYEJlOaUlfvPBxKRZWvkJLEWu6R5
         ffyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715775748; x=1716380548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k79exwgCqVUrVnBuHOQy2LIeRnXzcjCZK4+8ra/2Vj0=;
        b=BfI4m+2knBwR5UFJST5xCjk+NNPi4CmButZAoF6E6DsBrPFlq53s53x244QGlTrRiT
         4ykWm3L1wY5vCa3Z7zo3xZs4BKiH2cNmPQsPzH89rkUPIhlr+ytEL8rdMuns4cCxk5HC
         7JxAkM4teTBBsXw90Ih4J0KuXNPbjg6/gyJBAPsFIl1mZf8QbXX1j0jMT0yzoX8nrCFw
         KsdbQYJbGSwOcoIcKk4IDzbfQDaKIH/YWVH9wPZNmfjGZn9uSSpIaBIXhFuY/mmwQwGZ
         p/zLRhsdXXG8akt2HuxBI25lGvM3Gi26KfmHAVFWWeyCZ1/0uEQ3M1mWdNcA3Mp2jQe3
         dKpw==
X-Gm-Message-State: AOJu0YyktOT6BOGdeZhCiXwkcZ1Y8jrcumv08fujldHZTETTvxgzR9Kh
	15VsDspNKWKh/gSlGVuuiNm2OLjpgfn5ERZ8b4LpSxbMu+u5ipAc1fgE2hFp
X-Google-Smtp-Source: AGHT+IGNAJ1JFcdWHpCW1Pc31A1CiRm9WIm5M7fcPd4WwVXUeyMw0iiLrfj2/OAWAU1SHd8/oF3Jew==
X-Received: by 2002:a05:620a:f05:b0:793:29:7fe5 with SMTP id af79cd13be357-793002980a9mr23747885a.10.1715775748189;
        Wed, 15 May 2024 05:22:28 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2a11e8sm669380085a.58.2024.05.15.05.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 05:22:27 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] scan: add flag if BSS load was advertised
Date: Wed, 15 May 2024 05:22:20 -0700
Message-Id: <20240515122221.333230-3-prestwoj@gmail.com>
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

For ranking purposes the utilization was defaulted to a valid (127)
which would not change the rank if that IE was not found in the
scan results. Historically this was printed (debug) as part of the
scan results but that was removed as it was somewhat confusing. i.e.
did the AP _really_ have a utilization of 127? or was the IE not
found?

Since it is useful to see the BSS load if that is advertised add a
flag to the scan_bss struct to indicate if the IE was present which
can be checked.
---
 src/scan.c | 14 ++++++++------
 src/scan.h |  1 +
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index 8699fe3e..555ab88e 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -1344,6 +1344,8 @@ static bool scan_parse_bss_information_elements(struct scan_bss *bss,
 						NULL) < 0)
 				l_warn("Unable to parse BSS Load IE for "
 					MAC, MAC_STR(bss->addr));
+			else
+				bss->have_utilization = true;
 
 			break;
 		case IE_TYPE_VENDOR_SPECIFIC:
@@ -1533,7 +1535,6 @@ static struct scan_bss *scan_parse_attr_bss(struct l_genl_attr *attr,
 	size_t beacon_ies_len;
 
 	bss = l_new(struct scan_bss, 1);
-	bss->utilization = 127;
 	bss->source_frame = SCAN_BSS_BEACON;
 
 	while (l_genl_attr_next(attr, &type, &len, &data)) {
@@ -1704,10 +1705,12 @@ static void scan_bss_compute_rank(struct scan_bss *bss)
 		rank *= RANK_6G_FACTOR;
 
 	/* Rank loaded APs lower and lightly loaded APs higher */
-	if (bss->utilization >= 192)
-		rank *= RANK_HIGH_UTILIZATION_FACTOR;
-	else if (bss->utilization <= 63)
-		rank *= RANK_LOW_UTILIZATION_FACTOR;
+	if (bss->have_utilization) {
+		if (bss->utilization >= 192)
+			rank *= RANK_HIGH_UTILIZATION_FACTOR;
+		else if (bss->utilization <= 63)
+			rank *= RANK_LOW_UTILIZATION_FACTOR;
+	}
 
 	if (bss->have_snr) {
 		if (bss->snr <= 15)
@@ -1734,7 +1737,6 @@ struct scan_bss *scan_bss_new_from_probe_req(const struct mmpdu_header *mpdu,
 
 	bss = l_new(struct scan_bss, 1);
 	memcpy(bss->addr, mpdu->address_2, 6);
-	bss->utilization = 127;
 	bss->source_frame = SCAN_BSS_PROBE_REQ;
 	bss->frequency = frequency;
 	bss->signal_strength = rssi;
diff --git a/src/scan.h b/src/scan.h
index 0bfc9e47..06753b82 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -91,6 +91,7 @@ struct scan_bss {
 	bool sae_pw_id_used : 1;
 	bool sae_pw_id_exclusive : 1;
 	bool have_snr : 1;
+	bool have_utilization : 1;
 };
 
 struct scan_parameters {
-- 
2.34.1

